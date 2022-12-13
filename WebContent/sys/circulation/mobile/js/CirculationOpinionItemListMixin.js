define(	["dojo/_base/declare",
		"mui/list/_TemplateItemListMixin",
		dojoConfig.baseUrl+ "sys/circulation/mobile/js/CirculationOpinionItemMixin.js"],
						
		function(declare, _TemplateItemListMixin, CirculationOpinionItemMixin) {

			return declare("sys.circulation.CirculationOpinionItemListMixin",
				[_TemplateItemListMixin], {

					itemRenderer : CirculationOpinionItemMixin
				});
		});