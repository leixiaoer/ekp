define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/carmng/mobile/js/selectdialog/DialogItemMixin"
	], function(declare, _TemplateItemMixin, DialogItemMixin) {
	
	return declare("mui.selectdialog.DialogItemListMixin", [_TemplateItemMixin], {

		itemRenderer : DialogItemMixin
		
	});
});