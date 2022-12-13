define(	["dojo/_base/declare", "dojo/dom-construct", "dojo/dom-class",
				"dojo/dom-style", "dojo/dom-attr", "dojox/mobile/_ItemBase",
				"dojox/mobile/iconUtils", "mui/util", 
				"mui/list/item/_ListLinkItemMixin",
				"dojo/string","mui/i18n/i18n!km-asset:mui.kmAsset.mobile.card.code"],
		function(declare, domConstruct, domClass, domStyle, domAttr, ItemBase,
				iconUtils, util, _ListLinkItemMixin, string, msg) {
			var item = declare("km.asset.item.AssetCardItemMixin", [ItemBase,_ListLinkItemMixin], {

						tag : "li",
						
						baseClass: "muiAssetCardItem",
						
						buildRendering : function() {
							this._templated = !!this.templateString;
							if (!this._templated) {
								this.domNode = this.containerNode = this.srcNodeRef || domConstruct.create(this.tag);
							}
							this.inherited(arguments);
							if (!this._templated)
								this.buildInternalRender();
						},

						buildInternalRender : function() {

							// 资产图片
							var iconUrl = this.fdImageUrl ? util.formatUrl(util.decodeHTML(this.fdImageUrl)) : util.formatUrl("/km/asset/mobile/js/list/item/defaulthead.png");
							var iconNode = domConstruct.create("div" ,{
								className: "muiAssetCardItemIcon",
								style:{'background-image' : 'url(' + iconUrl + ')'}
							}, this.domNode);
							
							
							// 基本信息容器DOM (资产名称、资产状态、资产价格、资产编码)
							var infoNode = domConstruct.create("div" ,{className: "muiAssetCardItemInfo"}, this.domNode);
							
							// 资产名称
							if (this.fdName) {
								var titleNode = domConstruct.create('div', {className : 'muiAssetCardItemTitle', innerHTML: this.fdName}, infoNode);
							}
							
							// 资产状态
							if(this.fdAssetStatus){
								var statusNode = domConstruct.create('div', {className : 'muiAssetCardItemStatus', innerHTML: this.fdAssetStatus}, infoNode);
							}
							
							
							// 基本信息底部容器DOM (资产价格、资产编码)
							var infoFooterNode = domConstruct.create("div" ,{className: "muiAssetCardItemInfoFooter"}, infoNode);
							
							// 资产价格
							var priceNode = domConstruct.create("div" ,{className: "muiAssetCardItemPrice"}, infoFooterNode);
							var priceHtml = "";
							if(this.fdFirstValue){
								priceHtml+="<span class='priceFirstUnit'>"+this.fdFirstUnit+"</span><span class='priceFirstValue'>"+this.fdFirstValue+"</span>"
								if(this.fdMeasure){
									priceHtml+="<span class='priceMeasure'>/"+this.fdMeasure+"</span>";
								}
							}
							priceNode.innerHTML = priceHtml;
							
							// 资产编码
							var codeNode = domConstruct.create("div" ,{className: "muiAssetCardItemCode"}, infoFooterNode);
							if(this.fdCode){
								codeNode.innerHTML = "<span class='assetCodeTitle'>"+msg['mui.kmAsset.mobile.card.code']+":</span><span class='assetCode'>"+this.fdCode+"</span>";
							}
							
							
							if(this.fdRefUrl) {
								this.href = this.fdRefUrl;
							}
							
							if(this.href){
								this.makeLinkNode(this.domNode);
							}
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
