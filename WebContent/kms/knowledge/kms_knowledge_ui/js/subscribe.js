define(function(require, exports, module) {

	var topic = require('lui/topic');
	var spaConst = require('lui/spa/const');

	topic.subscribe(spaConst.SPA_CHANGE_VALUES, function(e) {
		//后台设置页面不隐藏右侧iframe
		if(e.value && e.value['j_path'] == '/management'){
			return;
		}
		LUI.pageHide('_rIframe');
	});

	// 监听新建更新等成功后刷新
	topic.subscribe('successReloadPage', function() {

		topic.publish('list.refresh');
	});

})