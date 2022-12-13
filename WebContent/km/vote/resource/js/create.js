//新建分类选择框，给门户或二级页面调用
define(function(require, exports, module) {
	var dialog = require('lui/dialog');
	//参数为默认选中的分类
	function addDoc(categoryId) {
		//debugger;
		dialog.simpleCategoryForNewFile(
				'com.landray.kmss.km.vote.model.KmVoteCategory',
				 '/km/vote/km_vote_main/kmVoteMain.do?method=add&fdCategoryId=!{id}',false,null,null,categoryId);
	}
	exports.addDoc = addDoc;
});