//新建分类选择框，给门户或二级页面调用
define(function(require, exports, module) {
	var dialog = require('lui/dialog');
	//参数为默认选中的分类
	function addDoc(categoryId) {
		dialog.categoryForNewFile(
				'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
				'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&i.docTemplate=!{id}',false,null,null,categoryId);
	}
	exports.addDoc = addDoc;
});