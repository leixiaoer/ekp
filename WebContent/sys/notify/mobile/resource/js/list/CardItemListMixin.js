define([
    "dojo/_base/declare",
    'dojo/_base/lang',
    'dojo/topic',
    'dojox/mobile/viewRegistry',
	"mui/list/_TemplateItemListMixin",
	"sys/notify/mobile/resource/js/list/CardItemMixin"
	], function(declare, lang, topic, viewRegistry, _TemplateItemListMixin, CardItemMixin) {
	
	return declare("sys.notify.list.CardItemListMixin", [_TemplateItemListMixin], {
		itemTemplateString : null,
		itemRenderer: CardItemMixin,
		startup : function(){
			this.inherited(arguments);
			// 监听window对象的 pageshow 事件（为了浏览器回退的时候能够强制刷新页面）
			this.connect(window,'pageshow','_pageshow');
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