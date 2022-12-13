<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.list">
	<template:replace name="toolbar">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="95%">
				<kmss:auth requestURL="/geesun/org/sys_post_middle/sysPostMiddle.do?method=add">
					<ui:button text="${ lfn:message('button.add') }" 
						onclick="Com_OpenWindow('${LUI_ContextPath}/geesun/org/sys_post_middle/sysPostMiddle.do?method=add');">
					</ui:button>
				</kmss:auth>
				<kmss:auth requestURL="/geesun/org/sys_post_middle/sysPostMiddle.do?method=deleteall">
					<ui:button text="${ lfn:message('button.delete') }"
						onclick="if(!List_ConfirmDel())return;Com_Submit(document.sysPostMiddleForm, 'deleteall');">
					</ui:button>
				</kmss:auth>
			</ui:toolbar>
	</template:replace>
 
	<template:replace name="content">
	
<html:form action="/geesun/org/sys_post_middle/sysPostMiddle.do">
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt">
					<input type="checkbox" name="List_Tongle">
				</td>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="sysPostMiddle.objid">
					<bean:message bundle="geesun-org" key="sysPostMiddle.objid"/>
				</sunbor:column>
				<sunbor:column property="sysPostMiddle.stext">
					<bean:message bundle="geesun-org" key="sysPostMiddle.stext"/>
				</sunbor:column>
				<sunbor:column property="sysPostMiddle.objidUp">
					<bean:message bundle="geesun-org" key="sysPostMiddle.objidUp"/>
				</sunbor:column>
				<sunbor:column property="sysPostMiddle.objidSUp">
					<bean:message bundle="geesun-org" key="sysPostMiddle.objidSUp"/>
				</sunbor:column>
				<sunbor:column property="sysPostMiddle.zsfyx">
					<bean:message bundle="geesun-org" key="sysPostMiddle.zsfyx"/>
				</sunbor:column>
				<sunbor:column property="sysPostMiddle.priox">
					<bean:message bundle="geesun-org" key="sysPostMiddle.priox"/>
				</sunbor:column>
				<sunbor:column property="sysPostMiddle.zzDatum">
					<bean:message bundle="geesun-org" key="sysPostMiddle.zzDatum"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="sysPostMiddle" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/org/sys_post_middle/sysPostMiddle.do" />?method=view&fdId=${sysPostMiddle.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${sysPostMiddle.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${sysPostMiddle.objid}" />
				</td>
				<td>
					<c:out value="${sysPostMiddle.stext}" />
				</td>
				<td>
					<c:out value="${sysPostMiddle.objidUp}" />
				</td>
				<td>
					<c:out value="${sysPostMiddle.objidSUp}" />
				</td>
				<td>
					<xform:radio value="${sysPostMiddle.zsfyx}" property="zsfyx" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<c:out value="${sysPostMiddle.priox}" />
				</td>
				<td>
					<c:out value="${sysPostMiddle.zzDatum}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>

	</template:replace>
</template:include>
