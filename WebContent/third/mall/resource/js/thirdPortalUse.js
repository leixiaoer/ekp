/**
 * 使用模板
 */
define(function(require, exports, module) {

	var $ = require("lui/jquery");
	var dialog = require('lui/dialog');
	var lang = require('lang!third-mall');
	
	// 关闭页面
	closeDialog = function(closeWin) {
		if(window.parent && window.parent.$dialog) {
			window.parent.$dialog.hide();
		}
		if(closeWin) {
			setTimeout(function() {Com_CloseWindow();}, 1500);
		}
	}
	
	// 登录模板
	useLoginTpl = function(data, callback) {
		if(!data.templateIsExists && data.successMessage) {
			// 成功
			dialog.success(lang["thirdMall.portal.success"]);
			if(callback) {
				callback(true);
			}
			closeDialog(true);
		} else {
			// 失败
			if(data.isCriterionTemplate) {
				dialog.failure(lang["thirdMall.portal.login.failure"]);
				if(callback) {
					callback(false);
				}
				closeDialog();
			} else {
				// 自定义包有重复，是否替换
				dialog.confirm(lang["thirdMall.portal.confirm"], function(value) {
					if(value) {
						// 继续更新
						$.ajax({
							url: Com_Parameter.ContextPath + "sys/profile/sys_login_template/sysLoginTemplate.do?method=replaceTemplate",
							data: {"templateId": data.templateId,"folderName": data.folderName,"isDefault": data.isDefault},
							type: "POST",
							dataType: 'json',
							success: function (res) {
								if(res == '1') {
									dialog.success(lang["thirdMall.opt.success"]);
									closeDialog(true);
								} else {
									dialog.failure(lang["thirdMall.opt.failure"]);
									closeDialog();
								}
								if(callback) {
									callback(true);
								}
							}
						});
					} else {
						if(callback) {
							callback(false);
						}
						closeDialog();
					}
				});
			}
		}
	}
	
	// 使用主题
	useThemeTpl = function(data, callback) {
		if(!data.themeIsExists && data.successMessage) {
			// 成功
			dialog.success(lang["thirdMall.theme.success"]);
			if(callback) {
				callback(true);
			}
			closeDialog(true);
		} else {
			// 自定义包有重复，是否替换
			dialog.confirm(lang["thirdMall.theme.confirm"], function(value) {
				if(value) {
					// 继续更新
					$.ajax({
						url: Com_Parameter.ContextPath + "sys/ui/sys_ui_extend/sysUiExtend.do?method=replaceExtend",
						data: {"extendId": data.extendId,"folderName": data.folderName},
						type: "POST",
						dataType: 'json',
						success: function (res) {
							if(res == '1') {
								dialog.success(lang["thirdMall.opt.success"]);
								closeDialog(true);
							} else {
								dialog.failure(lang["thirdMall.opt.failure"]);
								closeDialog();
							}
							if(callback) {
								callback(true);
							}
						}
					});
				} else {
					if(callback) {
						callback(false);
					}
					closeDialog();
				}
			});
		}
	}
	
	exports.useTpl = function(fdId, type, callback) {
		if(fdId && type) {
			$.ajax({
				url: Com_Parameter.ContextPath + "third/mall/thirdMallPortal.do?&method=downloadTmpl&fdId=" + fdId + "&type=" + type,
				type: "POST",
				dataType: 'json',
				success: function (data) {
					if(type == 'login') {
						// 使用登录页
						useLoginTpl(data, callback);
					} else if(type == 'theme') {
						// 使用主题包
						useThemeTpl(data, callback);
					}
				}
			});
		} else {
			dialog.failure("未知的操作！");
		}
	}

})