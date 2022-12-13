/**
 * 表单Item
 */
seajs.use(['lui/jquery', 'lui/dialog','lang!third-mall'], function($, dialog,lang) {
	window.buildNode = function(data){
		var node = $('<div/>').attr("class","cm-items");
		node.attr("data-formid",data.fdId);
		var innerNode = $('<div/>').attr("class", "cm-items-inner");
		node.append(innerNode);
		var version = window.parent.version;
		var context = window.parent.document;
		var createUrl = $("[name='add_url']",context).val();
		var url = "";
		//内容
		var $item = $("<div class='item-box'>").appendTo(innerNode);
		var auth = window.parent.isAuth;
		if (data.fdId != "more") {
			if (data.pic != "") {
				$item.append('<img src="' + data.pic + '"></img>');
			} else {
				$item.append('<span class="icon-pic"></span>');
			}
			var $content = $('<div class="content">');
			$item.append($content);
			var html = [];
			html.push("<p class='cm-form-box-item-desc'>" + data.fdName + "</p>");
			html.push("<div class='cm-form-box-item-title'>");
			// html.push("<p>" + (data.fdPrice == "0" ? lang["thirdMall.free"] : ("¥" + data.fdPrice)) + "</p>");
			html.push("<div class='cm-form-box-item-data'>");
			html.push("<div class='cm-form-box-item-read'><i class='icon-view'></i><span>" + data.fdReadCount + "</span></div>")
			html.push("<div class='cm-form-box-item-download'><i class='icon-download'></i><span>" + data.fdDownloadCount + "</span></div>");
			html.push("</div>");
			html.push("</div>");
			
		    $content.append(html.join(""));
	        
			//遮罩
			var $itemMask = $('<div class="item-mask">');
			innerNode.append($itemMask);
			var $maskContent = $('<div class="mask-content"></div>');
			$itemMask.append($maskContent);
			var $preview = $("<a href='javascript:void(0);'>" + lang["thirdMall.preview"] + "</a>");
			var $use = $("<a href='javascript:void(0);'>" + lang["thirdMall.use"] + "</a>");
			$maskContent.append($preview);
			$maskContent.append($use);
			//预览
			$preview.on('click',function(){
				if (data.pic != "") {
					var previewUrl = "/third/mall/template/thirdMallTemplate_preview.jsp";
					var pcPreviewUrl = data.pic;
					var mobilePreviewUrl = data.mobilePic;
					var _createUrl = Com_Parameter.ContextPath + createUrl + "&sourceFrom=Reuse&sourceKey=Reuse&type=2&fdThirdTemplateId=" + data.fdId;
					
				} else {
					var previewUrl = "/third/mall/template/thirdMallTemplate_preview.jsp";
					var pcPreviewUrl = "../resource/images/pic_1@2x.png";
					var mobilePreviewUrl = pcPreviewUrl;
					var _createUrl = Com_Parameter.ContextPath + createUrl + "&sourceFrom=Reuse&sourceKey=Reuse&type=2&fdThirdTemplateId=" + data.fdId;
				}
				var _dial = dialog.iframe(previewUrl,"",function(value) {
					}, {
					"width" : 920,
					"height" : 680,
					 params : {
						 "pcPreviewUrl" : pcPreviewUrl,
						 "mobilePreviewUrl" : mobilePreviewUrl,
						 "createUrl" : _createUrl,
						 "auth" : auth,
						 "parentDialog" : window.parent.$dialog
					 }
				});
				
			});
			$use.on('click',function(){
				if (auth == "true") {
					//新建模板
					url = Com_Parameter.ContextPath + createUrl + "&sourceFrom=Reuse&sourceKey=Reuse&type=2&fdThirdTemplateId=" + data.fdId;
					if(Com_Parameter.dingXForm === "true") {
						//因为钉钉审批高级版后台页面最外层是moduleindex，与\sys\profile\index.jsp不同，frameWin[funcName]能找到对应方法，会导致新建模板页面在viewFrame中打开
						Com_OpenWindow(url, "_blank");
					} else {
						Com_OpenWindow(url);
					}
					window.parent.$dialog.hide();
				} else {
					seajs.use(['lui/dialog'],function(dialog){
						dialog.alert(lang["thirdMall.noAuth"]);
					});
				}
			});
		} else {
			var moreHtml = [];
			moreHtml.push("<div class='more'><span>" + lang["thirdMall.templateMore"] + "</span><span class='icon-more'></span></div>");
			$item.append(moreHtml.join(""));
			node.on('click',function(){
				if (auth == "true") {
					//跳转到云商城页面
					var $navList = LUI("navList").element;
					var thirdMallCreateParam = "&sourceFrom=Reuse&sourceKey=Reuse&type=2";
					var industryId = $navList.find("li.nav_main_selected").attr("data-industryid");
					createUrl = data.absPath + createUrl;
					url = data.url + "&industryId=" + industryId + "&sysVerId=" + version + "&createUrl=" + encodeURIComponent(createUrl + thirdMallCreateParam);
					if(Com_Parameter.dingXForm === "true") {
						//因为钉钉审批高级版后台页面最外层是moduleindex，与\sys\profile\index.jsp不同，frameWin[funcName]能找到对应方法，会导致新建模板页面在viewFrame中打开
						Com_OpenWindow(url, "_blank");
					} else {
						Com_OpenWindow(url);
					}
					window.parent.$dialog.hide();
				} else {
					seajs.use(['lui/dialog'],function(dialog){
						dialog.alert(lang["thirdMall.noAuth"]);
					});
				}
			});
		}
		return node;
	};
	var element = render.parent.element;
	$(element).html("");
	var formInfos = data;
	if(formInfos == null || formInfos.length == 0){
		done();
		noRecode($(element));
	}else{
		var ul = $(element);
		for(var i = 0; i < formInfos.length; i++){
			var formObj = formInfos[i];
			var node = buildNode(formObj);
			node.appendTo(ul);
		}
	}
});

function hide() {
	var context = window.top.document;
	seajs.use(['lui/jquery'],function($){
		$("[data-lui-mark='dialog.nav.close']",context).trigger("click");
	});
}



function  noRecode(context) {
	seajs.use(['lui/util/env','theme!listview'],function(env,listview){
		var	__url = '/resource/jsp/listview_norecord.jsp?_='+new Date().getTime();
		$.ajax({
					url : env.fn.formatUrl(__url),
					dataType : 'text',
					success : function(data, textStatus) {
									context.html(data);
							  }
		});
	})
};