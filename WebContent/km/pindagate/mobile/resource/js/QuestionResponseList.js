define(["dojo/_base/declare","dijit/_WidgetBase","dijit/_Container","./CardPageMixin","./QuestionResponseCacheMixin","mui/dialog/BarTip","dojo/dom-style","dojo/dom"],
		function(declare,WidgetBase,Container,CardPageMixin,QuestionResponseCacheMixin,BarTip,domStyle,dom){
	
	return declare("km.pindagate.QuestionResponseList",[WidgetBase,Container,CardPageMixin,QuestionResponseCacheMixin],{
		
		tips:[],
		
		buildRendering:function(){
			this.inherited(arguments);
			this.subscribe('/km/pindagate/afterWidgetValidate','handleWidgetValidate');
		},
		
		handleWidgetValidate:function(widget){
			var index=widget.serialNum - 1;
			this.validate(index);
		},
		
		validateAll:function(){
			this.destoryTips();//先销毁全部Tip
			var result = this._validateAll();
			if(!result.status){
				var _tip=BarTip.tip({
					text:result.message
				});
				this.defer(function(){
					if(_tip)
						_tip.hide();
				},3000);
				this.tips.push(_tip);
			}
			return result.status;
		},
		
		_validateAll : function(){
			var children=this.__children,
				result={
					status : true,
					message : ''
				};
			var navVal=dom.byId("navSgin").value;
			if (navVal) {
				navVal=JSON.parse(navVal);
			}
			
			navIndex=this.index;
			
			//for(var i=children.length-1; i>=0 ; i--){
				for(var i=0; i<=children.length-1 ; i++){
				var _widget=children[i].widget;
				if(_widget && _widget.validate){//TODO 判断_widget是否为BaseResponse
					_widget.validate();
					if(_widget.validateResult.canSave==false){
						result.status=false;
						result.message = _widget.validateResult.message
						return result;
					}
				}
			}
			return result;
		},
		
		validate:function(index){
			var children=this.__children,
				_widget=children[index].widget,
				result=true;
			this.destoryTips();//先销毁全部Tip
			if(_widget && _widget.validate){//TODO 判断_widget是否为BaseResponse
				_widget.validate();
				if(_widget.validateResult.canSave==false){
					var _tip=BarTip.tip({
						text:_widget.validateResult.message
					});
					this.defer(function(){
						if(_tip)
							_tip.hide();
					},3000);
					this.tips.push(_tip);
					result=false;
				}
			}
			return result;
		},
	
		destoryTips:function(){
			for(var i=0;i<this.tips.length;i++){
				this.tips[i].destroy();
			}
			this.tips=[];
		}
		
	});
});