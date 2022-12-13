<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.list">
	<template:replace name="toolbar">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="95%">
				<kmss:auth requestURL="/geesun/org/sys_person_middle/sysPersonMiddle.do?method=add">
					<ui:button text="${ lfn:message('button.add') }" 
						onclick="Com_OpenWindow('${LUI_ContextPath}/geesun/org/sys_person_middle/sysPersonMiddle.do?method=add');">
					</ui:button>
				</kmss:auth>
				<kmss:auth requestURL="/geesun/org/sys_person_middle/sysPersonMiddle.do?method=deleteall">
					<ui:button text="${ lfn:message('button.delete') }"
						onclick="if(!List_ConfirmDel())return;Com_Submit(document.sysPersonMiddleForm, 'deleteall');">
					</ui:button>
				</kmss:auth>
			</ui:toolbar>
	</template:replace>
 
	<template:replace name="content">
	
<html:form action="/geesun/org/sys_person_middle/sysPersonMiddle.do">
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
				<sunbor:column property="sysPersonMiddle.pernr">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.pernr"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.nachn">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.nachn"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.vnamc">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.vnamc"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.orger">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.orger"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.plans01">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.plans01"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.plans02">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.plans02"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.phone">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.phone"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.email">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.email"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.ccall">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.ccall"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.wxid">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.wxid"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.zhrOmGwzj">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.zhrOmGwzj"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.zhrOmGwzd">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.zhrOmGwzd"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.zsfyx">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.zsfyx"/>
				</sunbor:column>
				<sunbor:column property="sysPersonMiddle.zzDatum">
					<bean:message bundle="geesun-org" key="sysPersonMiddle.zzDatum"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="sysPersonMiddle" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/org/sys_person_middle/sysPersonMiddle.do" />?method=view&fdId=${sysPersonMiddle.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${sysPersonMiddle.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${sysPersonMiddle.pernr}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.nachn}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.vnamc}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.orger}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.plans01}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.plans02}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.phone}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.email}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.ccall}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.wxid}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.zhrOmGwzj}" />
				</td>
				<td>
					<c:out value="${sysPersonMiddle.zhrOmGwzd}" />
				</td>
				<td>
					<xform:radio value="${sysPersonMiddle.zsfyx}" property="zsfyx" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<c:out value="${sysPersonMiddle.zzDatum}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>

	</template:replace>
</template:include>
