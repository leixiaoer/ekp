define(	["dojo/_base/declare", "dojo/dom-construct", "dojo/dom-class",
				"dojo/dom-style", "dojo/dom-attr", "dojox/mobile/_ItemBase",
				"dojox/mobile/iconUtils", "mui/util", 
				"dojo/string","mui/i18n/i18n!km-asset"],
		function(declare, domConstruct, domClass, domStyle, domAttr, ItemBase,
				iconUtils, util, string,msg) {
	
			var item = declare("km.asset.item.AssetTaskItemMixin", [ItemBase], {

						tag : "div",
						
						label : "",
						
						fdId : "",
						
						buildRendering : function() {
							this._templated = !!this.templateString;
							if (!this._templated) {
								this.domNode = this.containerNode = this.srcNodeRef
										|| domConstruct.create(this.tag);
								this.contentNode = domConstruct.create(
										'div', {
											className: "taskRadioLabelItem"
										}, this.domNode);
							}
							this.inherited(arguments);
							if (!this._templated)
								this.buildInternalRender();
						},

						buildInternalRender : function() {
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
								id : this.fdId,
								innerHTML : this.label,
								onclick : 'choseTask(this)'
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
