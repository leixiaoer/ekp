define(["dojo/_base/declare","../common/BaseResponse","../common/InputResponseMixin","../common/SelectReasonResponseMixin","dojo/dom-construct","mui/i18n/i18n!km-pindagate:mobile","dojo/topic", "dojo/query","dojo/on"],
		function(declare,BaseResponse,InputResponseMixin,SelectReasonResponseMixin,domConstruct,msg,topic,query,on){
	
	
	return declare("km.pindagate.formfilled.FormfilledResponse",[BaseResponse,InputResponseMixin,SelectReasonResponseMixin],{
		
		renderTitle:function(){
			this.inherited(arguments);
				//domConstruct.create('span',{className:'pi_txtStrong',innerHTML:'(' + msg['mobile.kmPindagateMain.multimatrix.tip'].replace('%number%',1) +')'},this.subjectNode);
		},
		//
		renderBody:function(){
			var self=this;
			var renderNode=this.context.renderNode,
				optionsContainer=domConstruct.create('div',{className : 'pindagate_table_fill_list'},renderNode);//options domNode
			var seriaNumber=self.index;
			var method_GET=query('[name="method_GET"]').val();
			for(var i = 0;i<this.questionDef.items.length;i++){
				var name='option'+this.index+'_'+i,
					_item=this.questionDef.items[i];
					_options=this.formatData(this.questionDef.options,i);
					dlContainer=domConstruct.create('dl',{},optionsContainer);
					domConstruct.create('dt',{innerHTML:_item[0] },dlContainer);
				if(_item[1])
					var _imgs =  _item[1].split(";");
								if (_imgs) {
									for (var j = 0; j < _imgs.length; j++) {
										domConstruct.create('img', {className : 'muiPindagateImg',src : _imgs[j]}, optionsContainer);
									}
								}
				var radioGroupContainer=domConstruct.create('div',{},optionsContainer);
				
				for(var q = 0;q<this.questionDef.options.length;q++){
					var colOptions = this.questionDef.options[q];
					ddContainer=domConstruct.create('dd',{},dlContainer);
					labelContainer=domConstruct.create('label',{},ddContainer);
					domConstruct.create('span',{innerHTML:colOptions[0] },labelContainer);
					var nameNumber = "forms"+seriaNumber+"_"+i+"_"+q;
					var nameValue="";
					if (method_GET=='edit') {
						var _split = "&___";
						var answers;
						if(this.draftValue.indexOf(_split)>-1){
							answers = this.draftValue.split(_split);
						}else{
							answers = this.draftValue.split(";");
						}
						for (var w = 0; w < answers.length; w++) {
							var answerSplit = answers[w];
							var answerKey = answerSplit.split(":");
							if (answerKey[0]==nameNumber) {
								nameValue=answerKey[1];
							}
						}
					}
					var inputValue=domConstruct.create('input',{name:nameNumber,type:"text",value:nameValue},labelContainer);
					on(inputValue,"input",function(data){
						var answerVal = "";
						var answerTxt = "";
						var optionsIndex;
						var keyName="";
						var _split = "&___";
						for(var itemskey in self.questionDef.items){
							var option = self.questionDef.items[itemskey];
							for(var optionskey in self.questionDef.options){
								var value = $('input[name="forms'+seriaNumber+"_"+itemskey+"_"+optionskey+'"]').val();
								var key = 'forms'+seriaNumber+"_"+itemskey+"_"+optionskey+'';
								
								if (value&&key) {
									answerVal+=key+":"+value+_split;
									answerTxt += key+":"+value+_split;
								}
								
								keyName=keyName+key+";";
								
							}
						}
						query("input[name='fdItems["+self.index+"].fdAnswer']").val(answerVal);
						query("input[name='fdItems["+self.index+"].fdAnswerTxt']").val(answerTxt);
						var nameItems='fdItems['+self.index+'].fdAnswer';
						self.initMatrix(answerVal);
						self.initForm(keyName);
						topic.publish('/km/pindagate/valueChanged',self,{
							name:nameItems,
							value:answerTxt,
							text:answerTxt
						});
					})
				}
			}
		},
		
		//格式化选项数据
		formatData:function(datas,i){
			var result=[];
			for(var index=0;index<datas.length;index++){
				var data = datas[index],
					tmp={};
				tmp.value=i+'_'+index;
				tmp.text=data[0];
				tmp.img=data[1];
				result.push(tmp);
			}
			return result;
		}
		
	});
	
});