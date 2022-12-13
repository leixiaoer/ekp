<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ page import="com.landray.kmss.fssc.base.util.FsscBaseAuthUtil"%>
<%
	String fdCompanyId=request.getParameter("fdCompanyId");
	request.setAttribute("staffManagerList", FsscBaseAuthUtil.getFinanceStaffAndManagerList(fdCompanyId));
%>
<ui:toolbar>
	<kmss:authShow roles="ROLE_FSSCBASE_IMPORT" extendOrgElements="${staffManagerList}">
		<ui:button parentId="btn" text="${lfn:message('fssc-base:button.exportTemplate') }" onclick="downloadTemplate()"></ui:button>
		<ui:button parentId="btn" text="${lfn:message('button.import') }" onclick="importData()"></ui:button>
		<ui:button parentId="btn" text="${lfn:message('button.export') }" onclick="exportData()"></ui:button>
	</kmss:authShow>
</ui:toolbar>