define(['dojo/_base/declare',
		'dojox/mobile/_ItemBase',
		'dojo/dom-construct',
		'mui/util',
		'mui/i18n/i18n!km-vote'], 
		function(declare, ItemBase, domConstruct, util, Msg){
	
	return declare('km.vote.maxhub.KmVoteResultItemMixin', [ItemBase],{
		
		buildRendering:function(){
			this.domNode = domConstruct.create('li', {className : 'mhVoteResultItem'}, this.containerNode);
			//附件图片
			if(this.fdAtt){
				domConstruct.create('img',{className : 'mhVoteResultAtt',src : util.formatUrl(this.fdAtt)},this.domNode);
			}
			//投票项
			domConstruct.create('span',{className : 'mhVoteResultTitle', innerHTML: this.fdName },this.domNode);
			//投票统计数
			domConstruct.create('span',{className : 'mhVoteResultNum', innerHTML: this.fdVoteItemNum + '票' },this.domNode);
			this.inherited(arguments);
		},
		
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		}
		
	});
});