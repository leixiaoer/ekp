define([
    "dojo/_base/declare",
    "dojo/topic",
	"mui/list/JsonStoreList",
	'dojo/dom-style',
	"dojox/mobile/viewRegistry"
	], function(declare,topic, JsonStoreList,domStyle,viewRegistry) {
	
	return declare("km.supervise.list.SuperviseInstructionJsonStoreList", [JsonStoreList], {
		
		hasLoad:false,
		
		onComplete:function(){
			this.inherited(arguments);
			var parentView=viewRegistry.getEnclosingView(this.domNode);
			//手动控制push的显示与隐藏，防止其他view页面也出现push提示信息
			topic.publish('/mui/list/pushDomHide',parentView);
		},
		
		//重写下拉刷新事件
		handleOnPush: function(widget, handle) {
			var parentView=viewRegistry.getEnclosingView(this.domNode);
			if(parentView.isVisible() && !this._loadOver){
				topic.publish('/mui/list/pushDomShow',parentView);
				this.loadMore(handle);
			}
			if (handle)
				handle.done(this);
		},
		
		startup:function(){
			this.inherited(arguments);
			this.subscribe('/mui/navitem/_selected','__load');
		},
		
		__load:function(obj){
			var parentView=viewRegistry.getEnclosingView(this.domNode),
				id = obj.moveTo || obj.id;
			if(parentView && parentView.id == id && !this.hasLoad){
				if(this.lazy){
					this.doLoad();
				}
				if(this.tempItem){
					var parentWidget = this.getParent();
					var	h = parentWidget.domNode.offsetHeight;
					domStyle.set(this.tempItem.domNode,{
						'height' : h + 'px',
						'line-height' : h + 'px'
					});
				}
				this.hasLoad = true;
			}
		}
		
		
	});
});