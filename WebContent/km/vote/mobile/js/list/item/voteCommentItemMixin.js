
define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"mui/i18n/i18n!km-vote"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, voteMsg) {
	var item = declare("km.vote.list.item.voteCommentItemMixin", [ItemBase], {
		tag:"li",
		baseClass:"muiCardItem muiListItem",
		buildRendering:function(){
			
			this.domNode = domConstruct.create('li', {className : ''}, this.containerNode);
			this.inherited(arguments);
			this.buildInternalRender();
		
		},
		buildInternalRender : function() {

			var box = domConstruct.create("div",{className:"comment-item-box"},this.domNode);
			var top = domConstruct.create("div",{className:"comment-item-top"},box);
			var topImg = domConstruct.create('img',{src:location.origin + dojoConfig.baseUrl+this.creatorIcon.slice(1)},top)
			var regex = /<a.*?>(.*?)<\/a>/ig;
			var fdName ='';
			if( this['docCreator.fdName']){
				var result = regex.exec(this['docCreator.fdName'])
				fdName = result[1];

			}
			var topName = domConstruct.create('span',{innerHTML:fdName},top)
			var info = domConstruct.create("div",{className:'comment-item-info'},this.domNode);
			var infoTime = domConstruct.create("div",{className:'comment-item-info-time',innerHTML:this.docCreateTime},info)
			var contentStr = util.formatText(this.docContent)
			var content = domConstruct.create("div",{className:'comment-item-doc',innerHTML:contentStr},this.domNode)
		
		},
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		}
	});
	return item;
});