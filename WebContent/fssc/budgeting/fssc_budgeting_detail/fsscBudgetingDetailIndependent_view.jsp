<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<table class="tb_normal" width="100%" id="TABLE_DocList_fdDetailList_Form" align="center" tbdraggable="true">
	<tr align="center" class="tr_normal_title">
		<c:if test="${(fsscBudgetingMainForm.fdStatus=='2' and approvalAuth) or (fsscBudgetingMainForm.fdStatus=='4' and effectAuth)}">
		<td style="width:20px;">
			<input type="checkbox" name="List_Tongle">
		</td>
		</c:if>
	    <td style="width:40px;">
	        ${lfn:message('page.serial')}
	    </td>
	    <fssc:showBudgetingDetail type="title" fdSchemeId="${fsscBudgetingMainForm.fdSchemeId}"></fssc:showBudgetingDetail>
         <td style="text-align: center; min-width: 65px;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.item')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdTotal')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodOne')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwo')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodThree')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFour')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFive')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSix')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSeven')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEight')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodNine')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTen')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEleven')}
         </td>
         <td style="width:5%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwelve')}
         </td>
	</tr>
	<c:forEach items="${fsscBudgetingMainForm.fdDetailList_Form}" var="fdDetailList_FormItem" varStatus="vstatus">
	    <tr KMSS_IsContentRow="1">
	    	<!-- ?????????????????? -->
	    	<c:if test="${ fsscBudgetingMainForm.fdStatus=='2'||fsscBudgetingMainForm.fdStatus=='4'}">
	    		<c:choose>
		    		<c:when test="${((fdDetailList_FormItem.fdStatus=='2' and approvalAuth) or (fdDetailList_FormItem.fdStatus=='4' and effectAuth)) and (fdDetailList_FormItem.fdIsLastStage=='1' or noBudgetItem)}">
	    			 <td align="center">
			             <input type='checkbox' name='List_Selected' value="${fdDetailList_FormItem.fdId}" />
			         </td>
			        </c:when>
		    		<c:when test="${(fsscBudgetingMainForm.fdStatus=='2' and approvalAuth) or (fsscBudgetingMainForm.fdStatus=='4' and effectAuth)}">
		    			<td align="center">
			            
			         	</td>
			        </c:when>
			        <c:otherwise>
			        </c:otherwise>
		        </c:choose>
	    	</c:if>
	        <td align="center">
	            ${vstatus.index+1}
	            <xform:text property="fdDetailList_Form[${vstatus.index}].docMainId" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].docMainId'" showStatus="noShow"></xform:text>
	            <input type="hidden" name="fdDetailList_Form[${vstatus.index}].fdId" value="${fdDetailList_FormItem.fdId}" />
	            <xform:text property="fdDetailList_Form[${vstatus.index}].fdParentId" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdParentId'" showStatus="noShow"></xform:text>
                <xform:text property="fdDetailList_Form[${vstatus.index}].fdIsLastStage" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdIsLastStage'" showStatus="noShow"></xform:text>
                <xform:text property="fdDetailList_Form[${vstatus.index}].fdBudgetItemId" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdBudgetItemId'" showStatus="noShow"></xform:text>
                 <!-- ?????????????????????????????????readOnly???????????????????????????edit -->
             	 <c:set var="showStatus" value="edit"></c:set>
             	 <c:if test="${fdDetailList_FormItem.fdIsLastStage=='0'}">
             	 	<c:set var="showStatus" value="readOnly"></c:set>
             	 </c:if>
	        </td>
	        <fssc:showBudgetingDetail type="contentline" fdSchemeId="${fsscBudgetingMainForm.fdSchemeId}" detailForm="${fdDetailList_FormItem}" method="view" tdIndex="${vstatus.index}"></fssc:showBudgetingDetail>
	        <td align="center">
           		${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.new.budgeting')}
             </td>
	        <td align="center">
	            <%-- ??????--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdTotal" _xform_type="text">
	                <kmss:showNumber value="${fdDetailList_FormItem.fdTotal}" pattern="#0.00"></kmss:showNumber>
	                <xform:text property="fdDetailList_Form[${vstatus.index}].fdTotal" value="${fdDetailList_FormItem.fdTotal}" showStatus="noShow"></xform:text>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 1???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodOne" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodOne" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodOne}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 2???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTwo" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodTwo" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTwo}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 3???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodThree" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodThree" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodThree}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 4???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodFour" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodFour" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodFour}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 5???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodFive" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodFive" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodFive}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 6???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodSix" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodSix" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodSix}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 7???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodSeven" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodSeven" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodSeven}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 8???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodEight" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodEight" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodEight}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 9???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodNine" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodNine" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodNine}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 10???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTen" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodTen" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTen}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 11???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodEleven" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodEleven" class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
	                <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodEleven}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	        <td align="center">
	            <%-- 12???--%>
	            <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTwelve" _xform_type="text">
	            	<c:if test="${display=='true'}">
	            		<input id="fdDetailList_Form[${vstatus.index}].fdPeriodTwelve"  class="inputsgl" style="width:48px;color: #333;text-align: center;" readonly="readonly" />
		            	<hr />
		            </c:if>
		            <kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTwelve}" pattern="#0.00"></kmss:showNumber>
	            </div>
	        </td>
	    </tr>
	</c:forEach>
	</table>