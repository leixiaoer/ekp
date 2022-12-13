define(	["dojo/_base/declare", "dojo/dom-construct", "dojo/dom-class",
				"dojo/dom-style", "dojo/dom-attr", "dojox/mobile/_ItemBase",
				"dojox/mobile/iconUtils", "mui/util", 
				"dojo/string","mui/i18n/i18n!km-asset"],
		function(declare, domConstruct, domClass, domStyle, domAttr, ItemBase,
				iconUtils, util, string,msg) {
	
			var item = declare("km.asset.item.AssetCardLifeItemMixin", [ItemBase], {

						tag : "div",
						
						buildRendering : function() {
							this._templated = !!this.templateString;
							if (!this._templated) {
								this.domNode = this.containerNode = this.srcNodeRef
										|| domConstruct.create(this.tag);
								this.contentNode = domConstruct.create(
										'div', {
											className: "cardLifeLabelItem"
										}, this.domNode);
							}
							this.inherited(arguments);
							if (!this._templated)
								this.buildInternalRender();
						},

						buildInternalRender : function() {
							var node1 = domConstruct.create("div" ,{
								className: "cardLifeLabelItemDot mui mui-dot",
								innerHTML : ""
							}, this.contentNode);
							var node2 = domConstruct.create("div" ,{
								className: "cardLifeLabelItemTitle",
								innerHTML : this.fdOperType
							}, this.contentNode);
							var node3 = domConstruct.create("div" ,{
								className: "cardLifeNodeItem",
								innerHTML : ""
							}, this.contentNode);
							var node4 = domConstruct.create("div" ,{
								className: "cardLifeNodeItemContainer",
								innerHTML : ""
							}, node3);
							var node5 = domConstruct.create("div" ,{
								className: "cardLifeNodeInfo",
								innerHTML : '<img class="cardLifeNodeImage" src="'+this.fdApplyPersonImg+'" alt=""><h4>'+this.fdApplyPersonName+'</h4><p class="cardLifeNodeDate mui mui-time"><span>'+this.date+'</span></p>'
							}, node4);
							var url = util.formatUrl("/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=view4Base&fdId="+this.fdApplyModelid+"&fdSubclassModelname="+this.fdApplyModelname);
							var node6 = domConstruct.create("div" ,{
								className: "cardLifeNodeContent",
								innerHTML : '<p class="cardLifeNode">'+this.fdOperContent+'</p><p class="cardLifeRelationName"><em>'+msg["mui.kmAssetCardLife.fdApplyModelid"]+'：</em><a href="'+url+'">'+this.fdApplyModelNo+'</a></p>'
							}, node4);
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
