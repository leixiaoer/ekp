define(function(require, exports, module) {

	var env = require('lui/util/env');

	function goToView(categoryId, moduleUrl, type, toggleView, timetype, showIntro) {

		var fdUrl = "";

		if (!moduleUrl) {
			return fdUrl;
		}

		fdUrl = moduleUrl;

		if (toggleView) {
			fdUrl = Com_SetUrlParameter(fdUrl, 'toggleView', toggleView);
		}
		
		if(categoryId && categoryId.indexOf(";") > -1) {
			categoryId = ""
		}

		// 是否展示推荐
		if ("true" == showIntro) {
			fdUrl = fdUrl + "#showIntro=true&orderby=docIntrCount&ordertype=down";

			if (categoryId) {
				fdUrl = fdUrl + "&docCategory=" + categoryId;
			}
		}

		if ("docIsIntroduced" == type) { 
			fdUrl = fdUrl + "#docIsIntroduced=1";

			if (categoryId) {
				fdUrl = fdUrl + "&docCategory=" + categoryId;
			}
		} else {
			if ("docReadCount" == type || "fdTotalCount" == type) {
				fdUrl = Com_SetUrlParameter(fdUrl, 'orderBy', "fdTotalCount");
			}

			if (categoryId) {
				fdUrl = fdUrl + "#docCategory=" + categoryId;
			}
 
		}
		if("docIsIndexTop"==type){
			fdUrl = fdUrl + "#j_path=%2Fall&docIsIndexTop=1";
		}

		// 发布时间筛选
		console.log("timetype=>",timetype)
		if (timetype && timetype != "no") {
			fdUrl = buildCriQueryParameter(fdUrl, 'docPublishTime', getStartTime(timetype))
			fdUrl = buildCriQueryParameter(fdUrl, 'docPublishTime', getEndTime(timetype))
		}

		// 门户部件的更多只展示发布状态文档
		fdUrl = buildCriQueryParameter(fdUrl, "docStatus", "30");

		console.log("fdUrl=>", fdUrl)

		window.open(Com_Parameter.ContextPath + fdUrl, '_blank');
	}

	/**
	 * 统一的构造跳转参数的方法
	 *
	 * tangyw
	 * 2021-11-30
	 *
	 * @param fdUrl
	 * @param pkey
	 * @param pvalue
	 */
	function buildCriQueryParameter(fdUrl, pkey, pvalue) {
		if (fdUrl.indexOf("cri.q") > -1) {
			fdUrl = fdUrl + "%3B" + pkey + "%3A" + pvalue;
		} else {
			if (fdUrl.indexOf("#") > -1) {
				fdUrl = fdUrl + "&";
			} else {
				fdUrl = fdUrl + "#";
			}
			fdUrl = fdUrl + "cri.q=" + pkey + "%3A" + pvalue;
		}
		return fdUrl;
	}

	function getStartTime(type) {
		if(type=="month"){
			return getDate("day", -30);
		}else if(type=="season"){
			return getDate("day", -90);
		}else if(type=="halfYear"){
			return getDate("day", -180);
		}else if(type=="year"){
			return getDate("day", -365);
		}else if(type=="twoYear"){
			return getDate("day", -365*2);
		}

		return "";
	}

	function getEndTime(type) {
		return getDate();
	}

	function getDate(type,number) {
		if(!type){
			type = null;
		}
		if(!number){
			number=0;
		}
		var nowdate = new Date();
		switch (type) {
			case "day":   //取number天前、后的时间
				nowdate.setTime(nowdate.getTime() + (24 * 3600 * 1000) * number);
				var y = nowdate.getFullYear();
				var m = nowdate.getMonth() + 1;
				var d = nowdate.getDate();
				var retrundate = y + '-' + m + '-' + d;
				break;
			case "week":  //取number周前、后的时间
				var weekdate = new Date(nowdate + (7 * 24 * 3600 * 1000) * number);
				var y = weekdate.getFullYear();
				var m = weekdate.getMonth() + 1;
				var d = weekdate.getDate();
				var retrundate = y + '-' + m + '-' + d;
				break;
			case "month":  //取number月前、后的时间
				nowdate.setMonth(nowdate.getMonth() + number);
				var y = nowdate.getFullYear();
				var m = nowdate.getMonth() + 1;
				var d = nowdate.getDate();
				var retrundate = y + '-' + m + '-' + d;
				break;
			case "year":  //取number年前、后的时间
				nowdate.setFullYear(nowdate.getFullYear() + number);
				var y = nowdate.getFullYear();
				var m = nowdate.getMonth() + 1;
				var d = nowdate.getDate();
				var retrundate = y + '-' + m + '-' + d;
				break;
			default:     //取当前时间
				var y = nowdate.getFullYear();
				var m = nowdate.getMonth() + 1;
				var d = nowdate.getDate();
				var retrundate = y + '-' + m + '-' + d;
		}
		return retrundate;
	}


	exports.goToView = goToView;
});