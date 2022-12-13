<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
    <c:forEach items="${fsscExpenseMain.fdDetailList}" var="fdDetailList_FormItem" varStatus="vstatus">
        <tr>
            <td align="center">
                ${vstatus.index+1}
                <input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdApprovedApplyMoney" value="${fdDetailList_FormItem.fdApprovedApplyMoney }" />
            	<input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdApprovedStandardMoney" value="${fdDetailList_FormItem.fdApprovedStandardMoney }" />
                <input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdId" value="${fdDetailList_FormItem.fdId }" />
	            <input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdCompanyId" value="${fdDetailList_FormItem.fdCompany.fdId }" />
	            <input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdCompanyName" value="${fdDetailList_FormItem.fdCompany.fdName }" />
	            <input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdCostCenterId" value="${fdDetailList_FormItem.fdCostCenter.fdId }" />
	            <input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdCurrencyId" value="${fdDetailList_FormItem.fdCurrency.fdId }" />
	            <input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdCurrencyName" value="${fdDetailList_FormItem.fdCurrency.fdName }" />
	            <input type="hidden" name="fdDetailList_Form1[${vstatus.index}].fdExchangeRate" value="${fdDetailList_FormItem.fdExchangeRate }" />
            </td>
            <td align="center">
                ${fdDetailList_FormItem.fdCompany.fdName }
            </td>
            <td align="center">
                ${fdDetailList_FormItem.fdCostCenter.fdName }
            </td>
            <td align="center">
	            ${fdDetailList_FormItem.fdExpenseItem.fdName }
	        </td>
            <td align="center">
                ${fdDetailList_FormItem.fdRealUser.fdName }
            </td>
            <td align="center">
	            <kmss:showDate value="${fdDetailList_FormItem.fdHappenDate }" type="date"/>
	        </td>
            <td align="center">
            	<kmss:showNumber value="${fdDetailList_FormItem.fdApplyMoney}" pattern="0.00"/>
            </td>
            <td align="center">
                ${fdDetailList_FormItem.fdCurrency.fdName }
            </td>
            <td align="center">
            	<kmss:showNumber value="${fdDetailList_FormItem.fdStandardMoney}" pattern="0.00"/>
            </td>
            <td align="center">
                ${fdDetailList_FormItem.fdUse }
            </td>
        </tr>
    </c:forEach>
