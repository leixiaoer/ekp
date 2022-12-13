define(["dojo/_base/declare","../common/BaseResponse","../common/RadioResponseMixin","../common/MatrixResponseMixin","../common/SelectReasonResponseMixin","dojo/dom-construct","mui/i18n/i18n!km-pindagate:mobile"],
		function(declare,BaseResponse,RadioResponseMixin,MatrixResponseMixin,SelectReasonResponseMixin,domConstruct,msg){
	
	
	return declare("km.pindagate.singleselect.SinglematrixResponse",[BaseResponse,RadioResponseMixin,MatrixResponseMixin,SelectReasonResponseMixin],{
		
		renderTitle:function(){
			this.inherited(arguments);
				domConstruct.create('span',{className:'pi_txtStrong',innerHTML:'(' + msg['mobile.kmPindagateMain.multimatrix.tip'].replace('%number%',1) +')'},this.subjectNode);
		},
		//
		renderBody:function(){
			var renderNode=this.context.renderNode,
				optionsContainer=domConstruct.create('div',{},renderNode);//options domNode
			
			
			for(var i = 0;i<this.questionDef.items.length;i++){
				var name='option'+this.index+'_'+i,
					_item=this.questionDef.items[i];
					_options=this.formatData(this.questionDef.options,i);
				domConstruct.create('div',{className:'muiSubSubject',innerHTML:_item[0] },optionsContainer);
				if(_item[1])
					var _imgs =  _item[1].split(";");
								if (_imgs) {
									for (var j = 0; j < _imgs.length; j++) {
										domConstruct.create('img', {
											className : 'muiPindagateImg',
											src : _imgs[j]
										}, optionsContainer);
									}
								}
				var radioGroupContainer=domConstruct.create('div',{},optionsContainer);
				//call from SelectResponseMixin
				this.renderRadioGroup({
					name : name,
					value : this.draftValue,
					items : _options, 
					srcNodeRef : radioGroupContainer,
					showStatus:this.showStatus
				});
				//call from MatrixResponseMixin
				this.initMatrix(name);
			}
			
			//call from SelectReasonResponseMixin
			name='fdItems['+this.index+'].fdSelectReason';
			this.renderSelectReason({
				name : name,
				value : this.draftSelectReason,
				srcNodeRef : renderNode
			});
			
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