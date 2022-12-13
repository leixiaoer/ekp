<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.list">
	<template:replace name="toolbar">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="95%">
				<kmss:auth requestURL="/geesun/org/geesun_org_ekp/geesunOrgEkp.do?method=add">
					<ui:button text="${ lfn:message('button.add') }" 
						onclick="Com_OpenWindow('${LUI_ContextPath}/geesun/org/geesun_org_ekp/geesunOrgEkp.do?method=add');">
					</ui:button>
				</kmss:auth>
				<kmss:auth requestURL="/geesun/org/geesun_org_ekp/geesunOrgEkp.do?method=deleteall">
					<ui:button text="${ lfn:message('button.delete') }"
						onclick="if(!List_ConfirmDel())return;Com_Submit(document.geesunOrgEkpForm, 'deleteall');">
					</ui:button>
				</kmss:auth>
			</ui:toolbar>
	</template:replace>
 
	<template:replace name="content">
	
<html:form action="/geesun/org/geesun_org_ekp/geesunOrgEkp.do">
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
				<sunbor:column property="geesunOrgEkp.docCreateTime">
					<bean:message bundle="geesun-org" key="geesunOrgEkp.docCreateTime"/>
				</sunbor:column>
				<sunbor:column property="geesunOrgEkp.fdResult">
					<bean:message bundle="geesun-org" key="geesunOrgEkp.fdResult"/>
				</sunbor:column>
				<sunbor:column property="geesunOrgEkp.fdType">
					<bean:message bundle="geesun-org" key="geesunOrgEkp.fdType"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOrgEkp" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/org/geesun_org_ekp/geesunOrgEkp.do" />?method=view&fdId=${geesunOrgEkp.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${geesunOrgEkp.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<kmss:showDate value="${geesunOrgEkp.docCreateTime}" />
				</td>
				<td>
					<xform:select value="${geesunOrgEkp.fdResult}" property="fdResult" showStatus="view">
						<xform:enumsDataSource enumsType="geesunOrgEkp_fdResult" />
					</xform:select>
				</td>
				<td>
					<xform:select value="${geesunOrgEkp.fdType}" property="fdType" showStatus="view">
						<xform:enumsDataSource enumsType="geesunOrgEkp_fdType" />
					</xform:select>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>

	</template:replace>
</template:include>
