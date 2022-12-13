define(['dojo/_base/declare',
		'mui/list/_TemplateItemListMixin',
		'./KmVoteResultItemMixin'], 
		function(declare, TemplateItemListMixin, KmVoteResultItemMixin){
	
	return declare('km.vote.maxhub.KmVoteResultItemListMixin', [TemplateItemListMixin],{
		
		itemRenderer : KmVoteResultItemMixin
		
	});
});