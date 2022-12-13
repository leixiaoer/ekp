//新建分类选择框，给门户或二级页面调用
define(function(require, exports, module) {
	var dialog = require('lui/dialog');
	//参数为默认选中的分类
	function addDoc(categoryId) {
		dialog.simpleCategoryForNewFile(
				'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
				'/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=add&fdTemplateId=!{id}',false,null,null,categoryId);
	}
	exports.addDoc = addDoc;
});