define(["dojo/_base/declare","../common/BaseResponse","mui/form/Textarea","dojo/dom-style","dojo/dom-construct","dojo/topic","dojo/query"],
		function(declare,BaseResponse,Textarea,domStyle,domConstruct,topic,query){
	
	return declare("km.pindagate.essayquestion.EssayquestionResponse",[BaseResponse],{
		
		startup : function(){
			this.inherited(arguments);
			this.subscribe('km/pindagate/touchEnd','resize');
		},
		
		//值域初始化
		/*initValueFeild:function(){
			this.valueTxtDom=domConstruct.create('input',{type:'hidden',name:'fdItems['+this.index+'].fdAnswerTxt'},this.context.renderNode);
		},*/
		
		
		//
		renderBody:function(){
			var renderNode=this.context.renderNode,
				name='fdItems['+this.index+'].fdAnswer',
				textareaContainer=domConstruct.create('div',{},renderNode),//textarea domNode
				self=this;
			var fdAnswerTxtValue = query('[name="fdItems['+this.index+'].fdAnswerTxt"]').val();
			var t=new Textarea({
				id:'id_'+name,//防止冲突
				name:name,
				value : fdAnswerTxtValue,
				showStatus:this.showStatus,
				className:'newMui muiFormEleWrap muiFormGroup muiFormStatusEdit border',
				opt:false
			},textareaContainer);
			t.startup();
			this.valueDom = t.textareaNode;
			
			var self = this;
			
			/*this.connect(t.textareaNode,'input',function(){
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
			});*/
			this.connect(t.textareaNode,'input',function(){
				setTimeout(function(){
					domStyle.set(self.context.renderNode,'paddingBottom','300px');
				}, 100 );
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
		
		resize : function() {
		/*	var scrollHeight = this.valueDom.scrollHeight;
			if (scrollHeight <= 0)
				return;
			domStyle.set(this.valueDom, {
				height : scrollHeight + 'px'
			});*/
		}
	});
	
});