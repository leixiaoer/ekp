<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<%--使用记录--%>
<ui:content title="${ lfn:message('fssc-ledger:fssc.ledger.usedList') }" expand="false">     
<ui:event event="show">
      document.getElementById("offsetListIframe").src= '${LUI_ContextPath }/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=getContractUseDetail&fdContractCode=${fsscLedgerContractForm.fdContractCode}';
</ui:event> 
<table id="Label_Tabel_1" width=100%>
    <tr>
        <td>
            <iframe id="offsetListIframe" width=100% frameborder=0 height="280px"
                    marginheight="0" marginwidth="0"
                    src=""
                    scrolling=yes></iframe>
        </td>
    </tr>
</table>
</ui:content>