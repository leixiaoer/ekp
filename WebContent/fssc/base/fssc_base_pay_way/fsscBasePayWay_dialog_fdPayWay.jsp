<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBasePayWay" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBasePayWay.fdName')}" escape="false" />
        <list:data-column col="fdIsTransfer">
            ${fsscBasePayWay.fdIsTransfer}
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>
		<list:data-column col="fdDefaultPayBank.fdId">
			${fsscBasePayWay.fdDefaultPayBank.fdId}
		</list:data-column>
        <list:data-column property="fdDefaultPayBank.fdBankName" title="${lfn:message('fssc-base:fsscBasePayWay.fdDefaultPayBank')}" escape="false" />
        <list:data-column property="fdDefaultPayBank.fdBankAccount" title="${lfn:message('fssc-base:fsscBasePayBank.fdBankAccount')}" escape="false" />
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
