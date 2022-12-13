define(['dojo/_base/declare',
		'dojo/_base/lang',
		'dojo/dom-construct'], 
	function(declare, lang, domConstruct) {
	return declare("km.vote.maxhub.KmVoteNoDataMixin", null, {
		
		buildNoDataItem : function(widget){
			if(this.noDataNode){
				domConstruct.destroy(this.noDataNode);
				this.noDataNode = null;
			}
			if(widget.totalSize==0){
				var containerNode = widget.domNode,
					noDataNode =  domConstruct.create('div',{className : 'mhVoteNoData'},containerNode),
					noDataItem = domConstruct.create('div',{className : 'mhVoteNoDataItem'},noDataNode);
				//图标
				domConstruct.create('div',{className : 'mhui-message-icon mhui-icon-signin'},noDataItem);
				
				var textNode = domConstruct.create('div',{className : 'mhVoteNoDataTextContainer'},noDataItem);
				//提示语
				domConstruct.create('span',{className : 'mhVoteNoDataText',innerHTML : '会议未发起投票'},textNode);
				//刷新
				var refreshNode = domConstruct.create('span',{className : 'mhVoteRefreshContainer'},textNode);
				domConstruct.create('span',{className : 'mhVoteRefresh', innerHTML : '刷新'},refreshNode);
				domConstruct.create('span',{className : 'mui mui-reflash'},refreshNode);
				this.connect(refreshNode,'click',lang.hitch(this,function(){
					this.reload();
				}));
				this.noDataNode = noDataNode;
			}
		}
		
	});
});