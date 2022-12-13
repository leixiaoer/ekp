define(	["dojo/_base/declare", "dojo/dom-construct", "dojo/dom-class",
				"dojo/dom-style", "dojo/dom-attr", "dojox/mobile/_ItemBase",
				"dojox/mobile/iconUtils", "mui/util", 
				"dojo/string"],
		function(declare, domConstruct, domClass, domStyle, domAttr, ItemBase,
				iconUtils, util, string) {
			var item = declare("km.asset.item.AssetCardPersonnelItemMixin", [ItemBase,], {

						tag : "li",
						
						fdName : '',
						
						fdParent : '',
						
						icon : '',
						
						
						
						buildRendering : function() {
							this._templated = !!this.templateString;
							if (!this._templated) {
								this.domNode = this.containerNode = this.srcNodeRef|| domConstruct.create(this.tag);
							}
							this.inherited(arguments);
							if (!this._templated)
								this.buildInternalRender();
						},

						buildInternalRender : function() {
							
							var infoNode = domConstruct.create("div" ,{
								className: "muiCateInfoItem"
							}, this.domNode);
							
							var containerNode = domConstruct.create("div" ,{
								className: "muiCateContainer"
							}, infoNode);
							var iconNode = domConstruct.create("div" ,{
								className: "muiCateIcon mui_zone_cate_icon",
								innerHTML : '<span style="background:url(' + this.icon + ') center center / cover no-repeat; display: inline-block;"></span>'
							}, containerNode);
							
							var CateInfoNode = domConstruct.create("div" ,{
								className: "muiCateInfo",
								innerHTML : '<div class="muiCateName mui_zone_cate_person_name">'+this.fdName+'</div><div class="muiCateName mui_zone_cate_post"><span class="mui mui-post"> </span>'+this.fdParent+'</div></div>'
							}, containerNode);
							
						},

						startup : function() {
							if (this._started) {
								return;
							}
							this.inherited(arguments);
						},

						_setLabelAttr : function(text) {
							if (text)
								this._set("label", text);
						}
					});
			return item;
		});
