define(["dojo/_base/declare","mui/form/Textarea","dojo/dom-construct","dojo/topic"],
		function(declare,Textarea,domConstruct,topic){
	
	return declare("km.pindagate.common.SelectReasonResponseMixin",null,{
		
		selectReasonText:null,
		
		initProperties:function(){
			this.inherited(arguments);
			if(this.questionDef.autoAddSelectReason){
				this.autoAddSelectReason = this.questionDef.autoAddSelectReason;
			}
			if(this.questionDef.selectReasonText){
				this.selectReasonText=this.questionDef.selectReasonText;
			}
		},
		
		renderSelectReason:function(options){
			var name = options.name,
				value = options.value,
				srcNodeRef = options.srcNodeRef;
			if(this.autoAddSelectReason && this.selectReasonText){
				domConstruct.create('div',{innerHTML:this.selectReasonText+':',className:'muiFieldText'},srcNodeRef);
				var txtNoderef=domConstruct.create('div',{className:''},srcNodeRef);
				var t=new Textarea({
					id:'id_'+name,//防止冲突
					name:name,
					value : value,
					showStatus:this.showStatus,
					className:'newMui muiFormEleWrap muiFormGroup muiFormStatusEdit',
					opt:false
				},txtNoderef);
				t.startup();
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
		}
	});
	
});