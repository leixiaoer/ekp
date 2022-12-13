define(["dojo/_base/declare","dojo/query","dojo/topic","mui/form/Textarea",
        "../common/BaseResponse","../common/RadioResponseMixin","../common/SelectReasonResponseMixin","../common/OtherOptionResponseMixin",
        "dojo/dom-construct","dojo/dom-style","mui/i18n/i18n!km-pindagate:mobile"],
		function(declare,query,topic,Textarea,BaseResponse,RadioResponseMixin,SelectReasonResponseMixin,OtherOptionResponseMixin,domConstruct,domStyle,msg){
	
	
	return declare("km.pindagate.singleselect.SingleselectResponse",[BaseResponse,RadioResponseMixin,SelectReasonResponseMixin,OtherOptionResponseMixin],{
		
		
		renderTitle:function(){
			this.inherited(arguments);
				domConstruct.create('span',{className:'pi_txtStrong',innerHTML:'(' + msg['mobile.kmPindagateMain.multimatrix.tip'].replace('%number%',1) +')'},this.subjectNode);
		},
		renderBody:function(){
			var renderNode=this.context.renderNode,
				name='option'+this.index,
				_items=this.formatData(this.questionDef.items),
				optionsContainer=domConstruct.create('div',{},renderNode);//options domNode
			
			
			//call from SelectResponseMixin
			var radioGroup = this.renderRadioGroup({
				name : name,
				value : this.draftValue,
				items : _items, 
				srcNodeRef : optionsContainer,
				showStatus:this.showStatus
			});
			
			// 处理其他选项
			if(this.questionDef.autoAddOther){
				var otherOptionText = this.otherOptionText = domConstruct.create('div',{},renderNode);
				var otherOptionName = "fdItems["+ this.index +"].fdOther";
				var t=new Textarea({
					id:'id_' + otherOptionName,//防止冲突
					name:  otherOptionName,
					value : this.draftOther,
					showStatus:this.showStatus,
					placeholder : this.questionDef.otherText,
					className:'newMui muiFormEleWrap muiFormGroup muiFormStatusEdit muiOtherOption',
					opt:false
				},this.otherOptionText);
				t.startup();
				topic.subscribe('/mui/form/valueChanged',function(widget,args){
					if(widget == radioGroup){
						if(args.value == 'other'){
							domStyle.set(otherOptionText,'display','block');
						}else{
							domStyle.set(otherOptionText,'display','none');
						}
					}
				});
				
				var self = this;
				this.connect(t.textareaNode,'input',function(){
					if(!t.textareaNode.__lastScrollHeight ||
							t.textareaNode.__lastScrollHeight != t.textareaNode.scrollHeight){
						self.context.renderNode.style.height = self.context.renderNode.offsetHeight - t.textareaNode.__lastScrollHeight + t.textareaNode.scrollHeight + 'px';
						if (/Android/gi.test(navigator.userAgent)) {
							topic.publish('km/pindagate/slideTo',{
								y : 0 - ( self.context.renderNode.offsetHeight - self.context.domNode.offsetHeight)
							});
						}
						t.textareaNode.__lastScrollHeight = t.textareaNode.scrollHeight;
					}
				});
				this.connect(t.textareaNode,'focus',function(){
					var _height = self.context.renderNode.offsetHeight;
					_height = _height + 2 * self.context.domNode.offsetHeight / 3;
					self.context.renderNode.style.height = _height+ 'px';
					if (/Android/gi.test(navigator.userAgent)) {
						setTimeout(function(){
							topic.publish('km/pindagate/slideTo',{
								y : 0 - ( _height - self.context.domNode.offsetHeight)
							});
						},1000);
					}
				});
				this.connect(t.textareaNode,'blur',function(){
					self.context.renderNode.style.height = 'auto';
				});
				
			}
			
			//call from SelectReasonResponseMixin
			name='fdItems['+this.index+'].fdSelectReason';
			this.renderSelectReason({
				name : name,
				value : this.draftSelectReason,
				srcNodeRef : renderNode
			});
			
		}
		
	
	});
	
});