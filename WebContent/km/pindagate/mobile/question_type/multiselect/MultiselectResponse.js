define(["dojo/_base/declare","dojo/topic","mui/form/Textarea",
        "../common/BaseResponse","../common/CheckBoxResponseMixin","../common/OtherOptionResponseMixin","../common/SelectReasonResponseMixin",
        "dojo/dom-construct","dojo/dom-style","mui/i18n/i18n!km-pindagate:mobile","dojo/dom"],
		function(declare,topic,Textarea,BaseResponse,CheckBoxResponseMixin,OtherOptionResponseMixin,SelectReasonResponseMixin,domConstruct,domStyle,msg,dom){
	
	return declare("km.pindagate.multiselect.MultiselectResponse",[BaseResponse,CheckBoxResponseMixin,OtherOptionResponseMixin,SelectReasonResponseMixin],{
		
		
		minSelectNumber:null,
		
		maxSelectNumber:null,
		
		initProperties:function(){
			this.inherited(arguments);
			if(this.questionDef.minSelectNumber){
				this.minSelectNumber=this.questionDef.minSelectNumber;
			}
			if(this.questionDef.maxSelectNumber){
				this.maxSelectNumber=this.questionDef.maxSelectNumber;
			}
		},
		
		renderTitle:function(){
			this.inherited(arguments);
			if(this.minSelectNumber&&this.maxSelectNumber){
				domConstruct.create('span',{className:'pi_txtStrong',innerHTML:'(' + msg['mobile.kmPindagateMain.atLeast'].replace('%number%',this.minSelectNumber) +", "+ msg['mobile.kmPindagateMain.atMost'].replace('%number%',this.maxSelectNumber)  + ')'},this.subjectNode);
			}
		},
		
		//
		renderBody:function(){
			var renderNode=this.context.renderNode,
				name='option'+this.index,
				_items=this.formatData(this.questionDef.items),
				optionsContainer=domConstruct.create('div',{},renderNode);//options domNode
			
			//call from CheckBoxResponseMixin
			var checkboxGroup = this.renderCheckBoxGroup({
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
					if(widget == checkboxGroup){
						if(widget.value && widget.value.indexOf('other') > -1){
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
			
		},
		
		validate:function(value){
			var self = this;
			var navVal=dom.byId("navSgin").value;
			navIndex=this.index;
			value = value || this.value;
			this.inherited(arguments);
			if(this.validateResult.canSave==true){
				for(var key in value){
					var _count=0;
					if(value[key]){
						_count=value[key].split(';').length;
					}
				}
				//最少选择几个
				if(this.minSelectNumber && this.minSelectNumber > _count ){
					this.validateResult.canSave=false;
					this.validateResult.message=  msg['mobile.kmPindagateMain.atLeast.tip'].replace('%serial%',this.serialNum).replace('%number%',this.minSelectNumber);
				}
				//最多选择几个
				if(this.maxSelectNumber && this.maxSelectNumber < _count ){
					this.validateResult.canSave=false;
					this.validateResult.message= msg['mobile.kmPindagateMain.atMost.tip'].replace('%serial%',this.serialNum).replace('%number%',this.maxSelectNumber);
				}
			}
			if (navVal) {
				navVal=JSON.parse(navVal);
				if (navVal.indexOf(navIndex+1)>-1) {
					this.validateResult.canSave=true;
					this.validateResult.message='';
				}
			}
			//题目关联
			topic.publish('km/pindagate/relation',self,{
				name:'option'+this.index,
				value:value,
				type:"multiSelect"
			});
		}
		
	});
	
});