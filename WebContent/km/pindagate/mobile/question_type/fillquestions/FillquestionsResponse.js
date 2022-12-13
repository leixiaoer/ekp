define(["dojo/_base/declare","../common/BaseResponse","mui/form/Textarea","dojo/dom-style","dojo/dom-construct","dojo/topic","dojo/query","../common/method","dojo/on","dojo/dom-construct","dojo/_base/lang","dojo/parser"],
		function(declare,BaseResponse,Textarea,domStyle,domConstruct,topic,query,method,on,domCtr,lang,parser){
	return declare("km.pindagate.fillquestions.FillquestionsResponse",[BaseResponse,method],{
		
		renderBody:function(){
			var renderNode=this.context.renderNode,
				name='fdItems['+this.index+'].fdAnswer',
				textareaContainer=domConstruct.create('div',{},renderNode),//textarea domNode
				fillquestionNode=domConstruct.create('div',{className:'pindagate_matrix_list'},renderNode),//textarea domNode
				self=this;
			var fdAnswerTxtValue = query('[name="fdItems['+this.index+'].fdAnswerTxt"]').val();
			
			var method_GET=query('[name="method_GET"]').val();
			self=this;
			//1：整数、2：小数、3：日期、4：手机、5：邮箱、6：省市区、7：身份证号、8：汉字、9：英文
			if (this.questionDef.questionsSel=="1"||this.questionDef.questionsSel=="2") {
				var strVal='';
				//defVal integerDef
				if (this.questionDef.defVal==true) {
					strVal=this.questionDef.integerDef;
					self.addAnswer(strVal);
				}
				integerDef=domConstruct.create('input',{id:"integerDef"+this.index,value:strVal},fillquestionNode);
				on(integerDef,"input",function(data){
					key="#integerDef"+self.index;
					self.saveAnswer(key);
					intVal=query("#integerDef"+self.index).val();
					query("input[name='fdItems["+self.index+"].fdAnswer']").val(intVal);
					query("input[name='fdItems["+self.index+"].fdAnswerTxt']").val(intVal);
					self.value=intVal;
				});
				
			}else if(this.questionDef.questionsSel=="3"){
				var str='',
					editVal='';
				if (method_GET=="edit") {
					editVal=query("input[name='fdItems["+this.index+"].fdAnswer']").val();
				}
				
				if (this.questionDef.dataSel=="1") {//日期
					str='<div data-dojo-type="mui/form/DateTime" data-dojo-mixins="mui/datetime/_DateMixin" data-dojo-props="valueField:\'dateTime'+this.index+'\',showStatus:\'edit\',subject:\'日期\',onValueChange:\'\',value:\''+editVal+'\'"></div>';
					parser.parse(domConstruct.create('div',{ innerHTML:str },fillquestionNode));
				}
				if (this.questionDef.dataSel=="2") {//时间
					str='<div data-dojo-type="mui/form/DateTime" data-dojo-mixins="mui/datetime/_TimeMixin" data-dojo-props="valueField:\'dateTime'+this.index+'\',showStatus:\'edit\',subject:\'时间\',onValueChange:\'\',value:\''+editVal+'\'"></div>';
					parser.parse(domConstruct.create('div',{ innerHTML:str },fillquestionNode));
				}
				if (this.questionDef.dataSel=="3") {//日期时间
					str='<div data-dojo-type="mui/form/DateTime" data-dojo-mixins="mui/datetime/_DateTimeMixin" data-dojo-props="valueField:\'dateTime'+this.index+'\',showStatus:\'edit\',subject:\'日期时间\',onValueChange:\'\',value:\''+editVal+'\'"></div>';
					parser.parse(domConstruct.create('div',{ innerHTML:str },fillquestionNode));
				}
			}else if(this.questionDef.questionsSel=="4"){
				iphoenVal=domConstruct.create('input',{id:"iphoen"+this.index},fillquestionNode);
				on(iphoenVal,"input",function(data){
					key="#iphoen"+self.index;
					self.saveAnswer(key);
				});
			}else if(this.questionDef.questionsSel=="5"){
				emailVal=domConstruct.create('input',{id:"email"+this.index},fillquestionNode);
				on(emailVal,"input",function(data){
					var key="#email"+self.index;
					self.saveAnswer(key);
				});
			}else if(this.questionDef.questionsSel=="6"){
				var cityDefVal='',
					cityShow='',
				proVal;
				if (this.questionDef.cityVal==true) {
					cityTxtShow=this.questionDef.provTxt;
					cityShow=this.questionDef.prov;
					cityDefVal='<option value="'+cityShow+'">'+cityTxtShow+'</option>';
				}
				if (cityDefVal) {
					proVal=domConstruct.create('select',{id:"prov"+this.index,name:this.index,innerHTML:cityDefVal,className:'fillquestion_city_width'},fillquestionNode);
				}else{
					proVal=domConstruct.create('select',{id:"prov"+this.index,name:this.index,innerHTML:"<option value='-1'>=请选择省份=</option>"},fillquestionNode);
				}
				
				var cityValEnt=domConstruct.create('select',{id:"city"+this.index,name:this.index,innerHTML:"<option value='-1'>=请选择城市=</option>",className:'fillquestion_city_width'},fillquestionNode),
				countryVal=domConstruct.create('select',{id:"country"+this.index,name:this.index,innerHTML:"<option value='-1'>=请选择县区=</option>",className:'fillquestion_city_width'},fillquestionNode);
				on(proVal,"input",function(data){
					self.showCity(proVal,data.target.name);
				});
				on(cityValEnt,"input",function(data){
					self.showCountry(cityValEnt,data.target.name);
				});
				on(countryVal,"input",function(data){
					var anserTxt='',
					anser='';
					var prov=query("#prov"+self.index);
					var city=query("#city"+self.index);
					var country=query("#country"+self.index);
					anserTxt=anserTxt+window.provice[prov.val()].name+";";
					anserTxt=anserTxt+window.provice[prov.val()]["city"][city.val()].name+";";
					anserTxt=anserTxt+window.provice[prov.val()]["city"][city.val()].districtAndCounty[country.val()];
					//number
					anser=anser+prov.val()+";";
					anser=anser+city.val()+";";
					anser=anser+country.val();
					if (country.val()=="-1") {
						anser="";
					}
					if(anser == null || anser == ""){
						query("input[name='fdItems["+self.index+"].fdAnswer']").val("");
						query("input[name='fdItems["+self.index+"].fdAnswerTxt']").val("");
					}else{
						query("input[name='fdItems["+self.index+"].fdAnswer']").val(anser);
						query("input[name='fdItems["+self.index+"].fdAnswerTxt']").val(anserTxt);
					}
				 });
				
				if (this.questionDef.cityVal==true) {
					self.showAddress(this.questionDef.prov,this.questionDef.city,self.index);
					query("#prov"+self.index).val(this.questionDef.prov);
					query("#city"+self.index).val(this.questionDef.city);
					query("#country"+self.index).val(this.questionDef.country);
					
					cityVal=this.questionDef.prov+";"+this.questionDef.city+";"+this.questionDef.country;
					cityTxtVal=this.questionDef.provTxt+";"+this.questionDef.cityTxt+";"+this.questionDef.countryTxt;
					query("input[name='fdItems["+self.index+"].fdAnswer']").val(cityVal);
					query("input[name='fdItems["+self.index+"].fdAnswerTxt']").val(cityTxtVal);	
					cityDefVal=this.questionDef.provTxt;
				}
				self.showProv(this.index,cityShow);
			}else if(this.questionDef.questionsSel=="7"){
				idVal=domConstruct.create('input',{id:"id"+this.index},fillquestionNode);
				on(idVal,"input",function(data){
					key="#id"+self.index;
					self.saveAnswer(key);
				});
			}else if(this.questionDef.questionsSel=="8"){
				var strVal='';
				if (this.questionDef.strDefVal==true) {
					strVal=this.questionDef.strValDef;
					self.addAnswer(strVal);
				}
				chinesWordVal=domConstruct.create('input',{id:"chinesWord"+this.index,value:strVal},fillquestionNode);
				on(chinesWordVal,"input",function(data){
					key="#chinesWord"+self.index;
					self.saveAnswer(key);
				});
			}else if(this.questionDef.questionsSel=="9"){
				var strVal='';
				if (this.questionDef.strDefVal==true) {
					strVal=this.questionDef.strValDef;
					self.addAnswer(strVal);
				}
				englishVal=domConstruct.create('input',{id:"english"+this.index,value:strVal},fillquestionNode);
				on(englishVal,"input",function(data){
					key="#english"+self.index;
					self.saveAnswer(key);
				});
			}else{
				defVal=domConstruct.create('input',{id:"def"+this.index},fillquestionNode);
				on(defVal,"input",function(data){
					key="#def"+self.index;
					self.saveAnswer(key);
				});
			}
			
			if (method_GET=="edit") {
				queryVal=query("input[name='fdItems["+this.index+"].fdAnswer']").val();
				if (this.questionDef.questionsSel=="1"||this.questionDef.questionsSel=="2") {
					query("#integerDef"+this.index).val(queryVal);
				}else if(this.questionDef.questionsSel=="3"){
					var method_GET=query('[name="method_GET"]').val();
					divMsg=$(this.valueDom).find(".muiSelInput")[0];
					//PC移动端日期时间类型控件转换，后期同步控件处理在修改此处 showTitle parentNode
					/*if (this.questionDef.dataSel=="3") {
						queryVal=queryVal.replace('T',' ');
					}*/
					if (queryVal) {
						queryVals=query("input[name='dateTime"+this.index+"']")[0];
						if (divMsg) {
							divMsg.innerText=anVal;
							queryClass=queryVals.parentNode;
							domClass.add(queryClass,"showTitle");
						}
					}
				}else if(this.questionDef.questionsSel=="4"){
					query("#iphoen"+this.index).val(queryVal);
				}else if(this.questionDef.questionsSel=="5"){
					query("#email"+this.index).val(queryVal);
				}else if(this.questionDef.questionsSel=="6"){
					if (queryVal) {
						queryVals=queryVal.split(";");
						self.showAddress(queryVals[0],queryVals[1],this.index);
						query("#prov"+this.index).val(queryVals[0]);
						query("#city"+this.index).val(queryVals[1]);
						query("#country"+this.index).val(queryVals[2]);
						query("input[name='fdItems["+this.index+"].fdAnswer']").val(queryVal);
					}
					
				}else if(this.questionDef.questionsSel=="7"){
					query("#id"+this.index).val(queryVal);
				}else if(this.questionDef.questionsSel=="8"){
					query("#chinesWord"+this.index).val(queryVal);
				}else if(this.questionDef.questionsSel=="9"){
					query("#english"+this.index).val(queryVal);
				}else{
					query("#def"+this.index).val(queryVal);
				}
				
			}
			
			var t=new Textarea({
				
			});
			t.startup();
			this.valueDom =renderNode;
			var self = this;
			
			this.connect(t.textareaNode,'input',function(){
				self.context.renderNode.style.height = 'auto';
				var value = t.get("value");
				query("input[name='fdItems["+this.index+"].fdAnswer']").val(value);
				topic.publish('/km/pindagate/valueChanged',self,{
					name:name,
					value:value,
					text:value
				});
			});
			
			topic.subscribe('/mui/textarea/onInput',function(widget,value){
			});
			
			if(fdAnswerTxtValue){
				topic.publish('/km/pindagate/valueChanged',self,{
					name:name,
					value:fdAnswerTxtValue,
					text:fdAnswerTxtValue
				});
			}
		},
		
		saveAnswer:function(key){
			anser=query(key).val();
			query("input[name='fdItems["+this.index+"].fdAnswer']").val(anser);
			query("input[name='fdItems["+this.index+"].fdAnswerTxt']").val(anser);
		},
		addAnswer:function(answerVal){
			query("input[name='fdItems["+this.index+"].fdAnswer']").val(answerVal);
			query("input[name='fdItems["+this.index+"].fdAnswerTxt']").val(answerVal);
		},
		
	});
	
	
});