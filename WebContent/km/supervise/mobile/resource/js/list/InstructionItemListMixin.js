define([
    "dojo/_base/declare",
	"mui/list/_TemplateItemListMixin",
	"km/supervise/mobile/resource/js/list/item/InstructionItemMixin"
	], function(declare, _TemplateItemListMixin, InstructionItemMixin) {
	
	return declare("km.supervise.list.InstructionItemListMixin", [_TemplateItemListMixin], {
		
		itemTemplateString : null,
		
		itemRenderer: InstructionItemMixin
	});
});