<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.list">
	<template:replace name="toolbar">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="95%">
				<kmss:auth requestURL="/geesun/org/sys_organ_middle/sysOrganMiddle.do?method=add">
					<ui:button text="${ lfn:message('button.add') }" 
						onclick="Com_OpenWindow('${LUI_ContextPath}/geesun/org/sys_organ_middle/sysOrganMiddle.do?method=add');">
					</ui:button>
				</kmss:auth>
				<kmss:auth requestURL="/geesun/org/sys_organ_middle/sysOrganMiddle.do?method=deleteall">
					<ui:button text="${ lfn:message('button.delete') }"
						onclick="if(!List_ConfirmDel())return;Com_Submit(document.sysOrganMiddleForm, 'deleteall');">
					</ui:button>
				</kmss:auth>
			</ui:toolbar>
	</template:replace>
 
	<template:replace name="content">
	
<html:form action="/geesun/org/sys_organ_middle/sysOrganMiddle.do">
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
				<sunbor:column property="sysOrganMiddle.objid">
					<bean:message bundle="geesun-org" key="sysOrganMiddle.objid"/>
				</sunbor:column>
				<sunbor:column property="sysOrganMiddle.stext">
					<bean:message bundle="geesun-org" key="sysOrganMiddle.stext"/>
				</sunbor:column>
				<sunbor:column property="sysOrganMiddle.objidUp">
					<bean:message bundle="geesun-org" key="sysOrganMiddle.objidUp"/>
				</sunbor:column>
				<sunbor:column property="sysOrganMiddle.objidSUp">
					<bean:message bundle="geesun-org" key="sysOrganMiddle.objidSUp"/>
				</sunbor:column>
				<sunbor:column property="sysOrganMiddle.zsfyx">
					<bean:message bundle="geesun-org" key="sysOrganMiddle.zsfyx"/>
				</sunbor:column>
				<sunbor:column property="sysOrganMiddle.zhrOmJglx">
					<bean:message bundle="geesun-org" key="sysOrganMiddle.zhrOmJglx"/>
				</sunbor:column>
				<sunbor:column property="sysOrganMiddle.priox">
					<bean:message bundle="geesun-org" key="sysOrganMiddle.priox"/>
				</sunbor:column>
				<sunbor:column property="sysOrganMiddle.zzDatum">
					<bean:message bundle="geesun-org" key="sysOrganMiddle.zzDatum"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="sysOrganMiddle" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/org/sys_organ_middle/sysOrganMiddle.do" />?method=view&fdId=${sysOrganMiddle.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${sysOrganMiddle.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${sysOrganMiddle.objid}" />
				</td>
				<td>
					<c:out value="${sysOrganMiddle.stext}" />
				</td>
				<td>
					<c:out value="${sysOrganMiddle.objidUp}" />
				</td>
				<td>
					<c:out value="${sysOrganMiddle.objidSUp}" />
				</td>
				<td>
					<xform:radio value="${sysOrganMiddle.zsfyx}" property="zsfyx" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<c:out value="${sysOrganMiddle.zhrOmJglx}" />
				</td>
				<td>
					<c:out value="${sysOrganMiddle.priox}" />
				</td>
				<td>
					<c:out value="${sysOrganMiddle.zzDatum}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>

	</template:replace>
</template:include>
