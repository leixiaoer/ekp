<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
request.setAttribute("sys.ui.theme", "default");
%>
<template:include ref="default.simple">
	<template:replace name="title">选择portlet</template:replace>
	<template:replace name="body">
	<script>
		seajs.use(['theme!form']);
		</script>
	<script>
		function selectPortletTheme(rid,rname){
			var data = {
					"ref":rid,
					"name":rname
			};
			window.$dialog.hide(data);
		}
		function searchEnter(event){
			event = event || window.event;
			if (event.keyCode == 13){
				dosearch();
			}
		}
		function dosearch(){
			var keywords = document.getElementsByName("keywords")[0].value;
			//去除首尾空格
			keywords = keywords.replace(/(^\s*)|(\s*$)/g,"");
			keywords = encodeURI(keywords); //中文两次转码
			var url = "/sys/portal/sys_portal_portlet/sysPortalPortlet.do?method=selectTheme&keywords=" + keywords;
			var source = LUI('themeList').source;
			source.url = url;
			source.get();
		}
	</script>
	<div class="input_search" style="margin: 10px 0 0 17px;">
	 	<input type="text" name="keywords" size="20" onkeydown="searchEnter();" />
	   	<input type="button" class="btnopt" value="<bean:message key="button.search"/>" onclick="dosearch();">
	</div>
	<table class="tb_normal" style="margin:10px auto;width:95%;height:460px;">
		<tr>
			<td valign="top">
				<list:listview id="themeList">
					<ui:source type="AjaxJson">
						{"url":"/sys/portal/sys_portal_portlet/sysPortalPortlet.do?method=selectTheme"}
					</ui:source>
					<list:colTable sort="false" onRowClick="selectPortletTheme('!{fdId}','!{fdName}')">
						<list:col-serial></list:col-serial>
						<list:col-auto props="fdName"></list:col-auto>
						<list:col-html title="${ lfn:message('sys-portal:sys.portal.thumbnail') }">
							{$
								<img width="250" src="${ LUI_ContextPath }{%row['fdThumb']%}" />
							$}
						</list:col-html>
						<list:col-html title="">
							{$
								<a class='com_btn_link' href="javascript:void(0)" onclick="selectPortletTheme('{%row['fdId']%}','{%row['fdName']%}')">${ lfn:message('sys-portal:desgin.msg.select') }</a>
							$}
						</list:col-html>
					</list:colTable>
				</list:listview>
			</td>
		</tr>
	</table>
	</template:replace>
</template:include>