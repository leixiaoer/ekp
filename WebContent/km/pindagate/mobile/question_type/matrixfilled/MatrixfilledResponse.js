define(["dojo/_base/declare","../common/BaseResponse","../common/InputResponseMixin","../common/SelectReasonResponseMixin","dojo/dom-construct","mui/i18n/i18n!km-pindagate:mobile", "dojo/query","dojo/on","dojo/topic"],
		function(declare,BaseResponse,InputResponseMixin,SelectReasonResponseMixin,domConstruct,msg,query,on,topic){
	
	
	return declare("km.pindagate.matrixfilled.MatrixfilledResponse",[BaseResponse,InputResponseMixin,SelectReasonResponseMixin],{
		
		renderTitle:function(){
			this.inherited(arguments);
				//domConstruct.create('span',{className:'pi_txtStrong',innerHTML:'(' + msg['mobile.kmPindagateMain.multimatrix.tip'].replace('%number%',1) +')'},this.subjectNode);
		},
		//
		renderBody:function(){
			var self=this;
			var renderNode=this.context.renderNode,
				optionsContainer=domConstruct.create('div',{className : 'pindagate_matrix_list'},renderNode);//options domNode
			var seriaNumber=this.serialNum-1;
			var method_GET=query('[name="method_GET"]').val();
			_items=this.formatData(this.questionDef.items);
		
			var ulContainer=domConstruct.create('ul',{},optionsContainer);
			for (var i = 0; i < this.questionDef.items.length; i++) {
				var nameNumber = "option"+seriaNumber+"_"+i;
				var _item=this.questionDef.items[i];
				var liContainer=domConstruct.create('li',{},ulContainer);
				var labelContainer=domConstruct.create('label',{},liContainer);
				domConstruct.create('span',{innerHTML:_item[0]},labelContainer);
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
					var keyName="";
					var countIndex = 0;
					var _split = "&___";
					for(var itemskey in self.questionDef.items){
						var option =self.questionDef.items[itemskey];
						var value = $('input[name="option'+self.index+"_"+itemskey+'"]').val();
						var key = 'option'+self.index+"_"+itemskey+'';
						if(countIndex > 0){
							answerVal+=_split
							answerTxt+=_split
							keyName+=";"
						}
						answerVal+=key+":"+value;
						answerTxt += key+":"+value;
						keyName=keyName+key;
						countIndex++;	
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
			this.initInputVal();
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
		},
		//初始化输入框的值
		initInputVal:function(){
			var self = this;
			var answerVal = "";
			var answerTxt = "";
			var keyName="";
			var countIndex = 0;
			for(var itemskey in self.questionDef.items){
				var option =self.questionDef.items[itemskey];
				var value = $('input[name="option'+self.index+"_"+itemskey+'"]').val();
				var key = 'option'+self.index+"_"+itemskey+'';
				if(countIndex > 0){
					answerVal += ";";
					answerTxt += ";";
					keyName += ";";
				}
				answerVal+=key+":"+value;
				answerTxt += key+":"+value;
				keyName=keyName+key;
				countIndex ++;
			}
			query("input[name='fdItems["+self.index+"].fdAnswer']").val(answerVal);
			query("input[name='fdItems["+self.index+"].fdAnswerTxt']").val(answerTxt);
			var nameItems='fdItems['+self.index+'].fdAnswer';
			self.initMatrix(answerVal);
			self.initForm(keyName);
		}
		
	});
	
});