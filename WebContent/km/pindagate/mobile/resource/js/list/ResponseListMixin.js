define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/pindagate/mobile/resource/js/list/item/ResponseListItemMixin",
	"km/pindagate/mobile/resource/js/nowDate",
	'dojox/mobile/viewRegistry'
	], function(declare, _TemplateItemListMixin, ResponseListItemMixin, nowDate, viewRegistry) {
	
	return declare("km.pindagate.list.ResponseListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: ResponseListItemMixin,
		nowDate : null, // 服务器当前时间
		
		startup : function(){
			this.inherited(arguments);
			// 监听window对象的 pageshow 事件（为了浏览器回退的时候能够强制刷新页面）
			this.connect(window,'pageshow','_pageshow');
		},
		
		onComplete : function(items) {
			// 获取服务器当前时间
			this.nowDate = nowDate.getDate();
			this.inherited(arguments);
		},

		_createItemProperties : function(){
			var props = this.inherited(arguments);
			props['nowDate'] = this.nowDate || new Date();
			return props;
		},
		
		_pageshow : function(evt){
			/* 注：经验证，只有第一次浏览器回退的时候persisted才会为true，所以必须使用页面刷新的方式来显示新的列表数据以及角标
			 * 不可以手动去发事件去更新列表和角标，因为只有强制刷新整个页面后，才会使得每次浏览器回退时persisted都为true
			*/ 
			if(evt.persisted){	
				var viewObj = viewRegistry.getEnclosingView(this.domNode);
				if(viewObj && viewObj.isVisible()){
					window.location.reload();
				}
			}
		}
		
	});
});