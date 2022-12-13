define(["dojo/_base/declare", "mui/tabbar/TabBarButton", "dojo/dom-class", "dijit/registry","mui/util",
        "dojo/topic", "mui/form/_FormBase", "dojo/dom"], function(
       	declare, TabBarButton, domClass, registry,util, topic, FormBase, dom) {

		return declare("sys.task.CreateBarButton", [TabBarButton], {
				
			onClick : function() {
				//修复iPhoneX点击穿透问题
				if(!this._CLICK_FLAG) {
					return;
				}
				
				//让当前聚焦的dom失焦(单行失焦后才会重设value)，防止校验时获取的value不准确
				var activeElement = document.activeElement;
				if(activeElement && activeElement.blur){
					activeElement.blur();
				}
				var args = arguments;
				this.defer(function(){
					if (this.href) {
						window.parent.location.href = util.formatUrl(this.href);
					}
					this.inherited(args);
				},350);
				if(this.href)
					return false;
			}

		});
});