define(['dojo/_base/declare',
		'dojox/mobile/_ItemBase',
		'dojo/dom-construct',
		'mui/list/item/_ListLinkItemMixin',
		'./KmVoteViewMixin',
		'mui/i18n/i18n!km-vote'], 
		function(declare, ItemBase, domConstruct, _ListLinkItemMixin, KmVoteViewMixin, Msg){
	
	return declare('km.vote.maxhub.KmVoteItemMixin', [ItemBase, _ListLinkItemMixin, KmVoteViewMixin],{
		
		buildRendering:function(){
			this.domNode = domConstruct.create('li', {className : 'mhVoteItem'}, this.containerNode);
			var wrapperNode = this.wrapperNode = domConstruct.create('div', {className : 'mhVoteItemWrapper'}, this.domNode);
			//显示状态
			if(this.expireTime != Msg['mui.kmVoteMain.unlimited']){
				var expireDate = new Date(this.expireTime.replace(/-/g, "/"));
				if(expireDate < new Date()){
					this._buildStatusNode();
				}
			}
			//标题
			domConstruct.create('h4',{ className : 'mhVoteItemTitle', innerHTML : this.docSubject },wrapperNode);
			var bottomArea = domConstruct.create('div',{ className : 'mhVoteItemBottom' },wrapperNode);
			//发起人
			domConstruct.create('span',{className : 'mhVoteItemCreator',innerHTML : Msg['mui.kmVoteMain.docCreator'] + ':' + this.creator },bottomArea);
			//截止日期
			domConstruct.create('span',{className : 'mhVoteItemExpireTime',innerHTML : Msg['mui.kmVoteMain.fdExpireTime'] + ':' + this.expireTime },bottomArea);
			this.inherited(arguments);
		},
		
		_buildStatusNode : function(){
			var statusNode = domConstruct.create('div',{ className : 'mhVoteItemStatus' },this.wrapperNode, 'first');
			domConstruct.create('i',{ className : 'mui mui-stamp' },statusNode);
			domConstruct.create('span',{ className : 'mhVoteItemStatusTxt' ,innerHTML : '已结束' },statusNode);
		},
		
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		}
		
	});
});