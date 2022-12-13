<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<kmss:auth requestURL="/fssc/base/fssc_base_payment/fsscBasePayment.do?method=add&modelName=${param.fdModelName }">
    <ui:button parentId="toolbar" text="${lfn:message('fssc-base:button.payment')}" onclick="Com_OpenWindow('${LUI_ContextPath }/fssc/base/fssc_base_payment/fsscBasePayment.do?method=add&fdModelId=${param.fdModelId}&fdModelName=${param.fdModelName }','_self');" order="2" />
</kmss:auth>
<script>
	
</script>