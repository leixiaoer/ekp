<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${kmPindagateMainForm.docSubject} - ${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	<%--路径导航--%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-pindagate:module.km.pindagate') }" href="/km/pindagate/" target="_self">
			</ui:menu-item>
			 <%-- 问卷设置 --%>
			<ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.set') }" href="/km/pindagate/index.jsp?key=set#j_path=%2FmydocMine&mydoc=mine" target="_self">
			  	<%-- 参与调查 --%>
			   <ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.participate') }" href="/km/pindagate/index.jsp?key=participate" target="_self">
			   </ui:menu-item>
				<%-- 调查结果 --%>
			   <ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.result') }" href="/km/pindagate/index.jsp?key=result#j_path=%2Findagating&docStatus=31" target="_self">
			   </ui:menu-item>
			</ui:menu-item>
			<ui:menu-source autoFetch="true" 
					href="/km/pindagate/index.jsp?key=set#j_path=%2FmydocMine&mydoc=mine&cri.q=categoryId%3A!{value}">				
				<ui:source type="AjaxJson">
					{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.pindagate.model.KmPindagateTemplate&categoryId=${kmPindagateMainForm.fdTemplateId }&currId=!{value}&nodeType=!{nodeType}"} 
				</ui:source>
			</ui:menu-source>
		</ui:menu>
		
	</template:replace>	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
			<%--开始调查--%>
			<c:if test="${kmPindagateMainForm.docStatus=='30'}">
				<kmss:auth
					requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=startIndagate&fdId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('km-pindagate:button.startIndagate')}" 
						onclick="startIndagate();" order="2">
					</ui:button>
				</kmss:auth>
			</c:if>
			<c:if test="${kmPindagateMainForm.docStatus=='31'}">

			</c:if>
			<%--结束调查--%>
			<c:if test="${kmPindagateMainForm.docStatus=='31'}">
			<kmss:authShow roles="ROLE_KMPINDAGATE_ATTRIBUTE">
					<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion.edit.Propert')}" 
						onclick="Com_OpenWindow('kmPindagateMain.do?method=updatePropert&fdId=${param.fdId}','_self');">
						</ui:button>
						</kmss:authShow>
				<kmss:auth
					requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=stopIndagate&fdId=${param.fdId}"
					requestMethod="GET">
					<%-- <ui:button text="修改可调查人员" onclick="editQuestioner()" order="2"></ui:button>
					<ui:button text="${lfn:message('km-pindagate:button.updateIndagateEndTime')}" 
						onclick="updateEndTime();" order="2">
					</ui:button> --%>
					<ui:button text="${lfn:message('km-pindagate:button.stopIndagate')}" 
						onclick="stopIndagate();" order="2">
					</ui:button>
					<ui:button text="${lfn:message('km-pindagate:button.pressAbsent')}" 
						onclick="pressAbsent();" order="2">
					</ui:button>
				</kmss:auth>
			</c:if>
			<%--生成题目模板--%>
			<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=copyAsTemplate&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.copyAsTemplate')}" 
					onclick="copyTemplates();" order="2">
				</ui:button>
			</kmss:auth>
			<%--复制问卷--%>
			<kmss:authShow roles="ROLE_KMPINDAGATE_CREATE">
				<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.copyAsNewPindagateMain')}" 
					onclick="Com_OpenWindow(Com_Parameter.ContextPath+'km/pindagate/km_pindagate_main/kmPindagateMain.do?method=add&fdTemplateId=${kmPindagateMainForm.fdTemplateId}&fdTemplateName='+encodeURI(encodeURI('${kmPindagateMainForm.fdTemplateName }'))+'&fdPindagateId=${JsParam.fdId}&copyPindagate=true','_self');" order="2">
				</ui:button>
			</kmss:authShow>
			<c:if test="${kmPindagateMainForm.docStatusFirstDigit < '3'}">
				<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
					<ui:button text="${lfn:message('button.edit')}" 
						onclick="Com_OpenWindow('kmPindagateMain.do?method=edit&fdId=${JsParam.fdId}','_self');" order="2">
					</ui:button>
				</kmss:auth>
			</c:if>
			<%--删除--%>
			<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				<ui:button text="${lfn:message('button.delete')}" 
					onclick="deleteDoc('kmPindagateMain.do?method=delete&fdId=${JsParam.fdId}');" order="2">
				</ui:button>
			</kmss:auth>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
