define(['dojo/_base/declare',
		'mui/list/_TemplateItemListMixin',
		'./KmVoteItemMixin',
		'./KmVoteNoDataMixin'], 
		function(declare, TemplateItemListMixin, KmVoteItemMixin,KmVoteNoDataMixin){
	
	return declare('km.vote.maxhub.KmVoteItemListMixin', [TemplateItemListMixin,KmVoteNoDataMixin],{
		
		itemRenderer : KmVoteItemMixin
		
	});
});