<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.framework.plugin.core.config.IExtension"%>
<%@page import="com.landray.kmss.sys.task.util.SysTaskAnalyzeExecutorPlugin"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%
	String fdType=(String)request.getParameter("type");
	IExtension ext=SysTaskAnalyzeExecutorPlugin.getExtensionForStat(fdType);
	if(ext!=null){
		if(StringUtil.isNotNull(SysTaskAnalyzeExecutorPlugin.getConditionJsp(ext))){
			request.setAttribute("conditionUrl", SysTaskAnalyzeExecutorPlugin.getConditionJsp(ext));
		}
		if(StringUtil.isNotNull(SysTaskAnalyzeExecutorPlugin.getExtJs(ext))){
			request.setAttribute("extJs", SysTaskAnalyzeExecutorPlugin.getExtJs(ext));
		}
	}
%>
<template:include ref="default.view" showQrcode="false" sidebar="no">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:out value="${lfn:message('sys-task:table.sysTaskAnalyze')} - ${ lfn:message('sys-task:module.sys.task') }"></c:out>	
	</template:replace>
	<template:replace name="head">
		<c:if test="${not empty extJs }">
			<script language="JavaScript" src="${LUI_ContextPath}${extJs}"></script>
		</c:if>
		<script language="JavaScript">
			Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|xform.js|jquery.js|dialog.js|calendar.js", null, "js");
			seajs.use("${LUI_ContextPath}/sys/task/sys_task_analyze/resource/css/stat.css");
			seajs.use(["${LUI_ContextPath}/sys/task/sys_task_analyze/resource/js/stat.js"],function(stat){
				window.stat = stat;
			});
			LUI.ready(function(){
				$("#div_condtionSection").attr("isShow","1");
				window.stat.expandDiv($("#div_condtionArea .div_titleArea"),'div_condtionSection');
				//禁用
				var queryAreaEles = $("#div_condtionSection *");
				queryAreaEles.prop("disabled",true);
				queryAreaEles.removeAttr("onclick");
				
				window.stat.statExecutor();
				
			});
			function exportExcel(){
				window.stat.exportExcel();
			}
			
			/* 设置iframe自适应高度 */
			domain.register('pageResize', function(){
				var iframeDom = document.getElementById('iframe_Detail');
				var listviewHeight = ($(iframeDom.contentWindow.document.body).find('#listview').height());
				$(iframeDom).height(listviewHeight + 200);
			});
		</script>
	</template:replace>
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<%--提交--%>
			<kmss:auth requestURL="/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.edit')}" 
					onclick="Com_OpenWindow('sysTaskAnalyze.do?method=edit&fdId=${JsParam.fdId}&type=${sysTaskAnalyzeForm.fdAnalyzeType}','_self');">
				</ui:button>
			</kmss:auth>
			<%--删除--%>
			<kmss:auth requestURL="/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" 
					onclick="del('sysTaskAnalyze.do?method=delete&fdId=${JsParam.fdId}');">
				</ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/sys/task/sys_task_analyze/sysTaskAnalyze.do?method=exportExcel&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('sys-task:button.exportExcel')}" 
					onclick="exportExcel();">
				</ui:button>
			</kmss:auth>
			<%--关闭--%> 
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	<%--导航路径--%>
	<template:replace name="path">
		<% String _type = request.getParameter("type");
			String _path = "load";
			if("1".equals(_type)) {
				_path = "load";
			}else if("2".equals(_type)) {
				_path = "degree";
			}else if("4".equals(_type)) {
				_path = "type";
			}else if("5".equals(_type)) {
				_path = "trend";
			}
			pageContext.setAttribute("_path", _path);
		%>
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('sys-task:module.sys.task') }" href="/sys/task/" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('sys-task:table.sysTaskAnalyze') }" href="/sys/task/#j_path=/${_path }" target="_self">
			</ui:menu-item>
		</ui:menu>
	</template:replace>	
	
	<%--主内容--%>
	<template:replace name="content">
		<script type="text/javascript">
			seajs.use(['lui/jquery','lui/dialog'], function($, dialog) {
				//删除确认框
				window.del=function(url){
					dialog.confirm("${lfn:message('page.comfirmDelete')}",function(isOk){
						if(isOk==true){
							Com_OpenWindow(url,'_self');
						}
					});
				};
			});
		</script>
		<html:form action="/sys/task/sys_task_analyze/sysTaskAnalyze.do">
			<p class="lui_form_subject">
				<bean:message key="sys-task:sysTaskAnalyze.type.${JsParam.type}"/>
			</p>
			<div class="lui_form_content_frame" style="padding-top:20px">
				<%--条件筛选--%>	
				<div id="div_condtionArea">
					<div class="div_section">
						<div class="div_line"></div>
						<div class="div_titleArea"  onclick="window.stat.expandDiv(this,'div_condtionSection');">
							${lfn:message('sys-task:sysTaskAnalyze.title.condition') }
							<span class="div_icon_coll"></span>
						</div>
					</div>	
					<c:import url="${conditionUrl}" charEncoding="UTF-8">
						<c:param name="formName" value="sysTaskAnalyzeForm"/>
						<c:param name="mode" value="view"></c:param>
					</c:import>
				</div>
				<div id="div_chartArea">
					<div class="div_section">
						<div class="div_line"></div>
						<div class="div_titleArea" onclick="window.stat.expandDiv(this,'div_reportSection');">
							${lfn:message('sys-task:sysTaskAnalyze.stat.section.result')}
							<span class="div_icon_exp"></span>
						</div>
					</div>
					<div id="div_reportSection">
						<div id="div_chartSection">
							<%--echart图表--%>
							<ui:chart height="500px" width="1100px" id="sysTaskStatChart">
			  					<ui:source type="AjaxJson">
									{"url":""}
			  					</ui:source>
							</ui:chart>
						</div>
						<div id="div_listSection">
							<div id="div_list" class="div_list"></div>
						</div>
						<div id="otherInfo">
							<div id="div_interesting"
								style="padding: 6px 0px 20px 60px; display: none;"></div>
							<div id="div_detail" style="padding-top: 16px; display: none;">
								<div align="center" id="detailSubject" class="lui_form_subject"></div>
								<iframe name="chartDetailListFrame" id="iframe_Detail" frameborder="0" style="width: 100%;height:1000px" scrolling="no"></iframe>
							</div>
						</div>
					</div>
				</div>
			</div>
		</html:form>
	</template:replace>
</template:include>