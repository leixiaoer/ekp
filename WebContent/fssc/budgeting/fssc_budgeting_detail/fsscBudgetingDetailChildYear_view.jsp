<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<table class="tb_normal" width="100%">
  <tr>
      <fssc:showBudgetingDetail type="title" fdSchemeId="${lfn:escapeHtml(param.fdSchemeId)}"></fssc:showBudgetingDetail>
      <td style="width:20%;">
          ${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.item')}
      </td>
      <td style="width:20%;">
          ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdTotal')}
      </td>
  </tr>
   <c:forEach items="${yearList}" var="year" varStatus="vstatus">
	    <tr KMSS_IsContentRow="1">
	    	<c:set var="size" value="${fn:length(year)}"></c:set>
	    	<c:if test="${size>4}">
	    	<c:forEach begin="0" end="${size-4}" step="2" var="index">
	    	<td align="center">
	    		${year[index+1]}
	    		<xform:text property="fdDetailList_Form[${vstatus.index}].fdBudgetItemId" showStatus="noShow" value="${halfYear[index]}"></xform:text>
	    	</td>
	    	</c:forEach>
	    	</c:if>
	        <td align="center">
             	${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.parent')}
           		<hr />
           		${lfn:message('fssc-budgeting:fsscBudgetingDetail.surplus.canApply')}
           		<hr />
           		${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.new.budgeting')}  
             </td>
	        <td align="center">
	            <%-- 全年--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdTotal" _xform_type="text">
	            	<kmss:showNumber value="${year[size-3]}" pattern="0.00"></kmss:showNumber><hr />
	            	<kmss:showNumber value="${year[size-2]}" pattern="0.00"></kmss:showNumber><hr />
	                <kmss:showNumber value="${year[size-1]}" pattern="0.00"></kmss:showNumber>
	            </div>
	        </td>
	    </tr>
	</c:forEach>
</table>