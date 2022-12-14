<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<table class="tb_normal" width="100%" id="TABLE_DocList_fdDetailList_Form" align="center">
     <tr align="center" class="tr_normal_title">
         <td style="width:20px;"></td>
         <td style="width:40px;">
             ${lfn:message('page.serial')}
         </td>
         <fssc:showBudgetingDetail type="title" fdSchemeId="${lfn:escapeHtml(param.fdSchemeId)}"></fssc:showBudgetingDetail>
         <td style="width:12%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.item')}
         </td>
         <td style="width:8%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdTotal')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodOne')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwo')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodThree')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFour')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFive')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSix')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSeven')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEight')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodNine')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTen')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEleven')}
         </td>
         <td style="width:6%;">
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwelve')}
         </td>
         <td style="width:3%;">
         </td>
     </tr>
     <tr KMSS_IsReferRow="1" style="display:none;">
         <td align="center">
             <input type='checkbox' name='DocList_Selected' />
             <xform:text property="fdDetailList_Form[!{index}].docMainId" htmlElementProperties="id='fdDetailList_Form[!{index}].docMainId'" showStatus="noShow"></xform:text>
             <xform:text property="fdDetailList_Form[!{index}].fdParentId" htmlElementProperties="id='fdDetailList_Form[!{index}].fdParentId'" showStatus="noShow"></xform:text>
             <xform:text property="fdDetailList_Form[!{index}].fdIsLastStage" htmlElementProperties="id='fdDetailList_Form[!{index}].fdIsLastStage'" showStatus="noShow"></xform:text>
             <xform:text property="fdDetailList_Form[!{index}].fdStatus" htmlElementProperties="id='fdDetailList_Form[!{index}].fdStatus'" showStatus="noShow"></xform:text>
         </td>
         <td align="center" KMSS_IsRowIndex="1">
             !{index}
         </td>
         <fssc:showBudgetingDetail type="datumline" fdSchemeId="${lfn:escapeHtml(param.fdSchemeId)}"></fssc:showBudgetingDetail>
         <td align="center">
             <%-- ????????????--%>
             ${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.new.budgeting')}
         </td>
         <td align="center">
             <%-- ??????--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdTotal" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdTotal" showStatus="edit" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdTotal')}" onValueChange="reCalYear" validators="required number scaleLength(2)" style="width:95%;color: #333;" />
                 <span style="cursor:pointer;" onclick="shareAmount(this.previousElementSibling.value,this.previousElementSibling);">${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdShare')}</span>
                 <input name="fdDetailList_Form[!{index}].fdParentTotal" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyTotal" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdTotal" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdTotal" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 1???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodOne" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodOne" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodOne')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodOne" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodOne" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdOne" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdOne" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 2???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodTwo" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodTwo" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwo')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodTwo" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodTwo" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdTwo" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdTwo" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 3???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodThree" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodThree" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodThree')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodThree" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodThree" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdThree" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdThree" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 4???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodFour" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodFour" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFour')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodFour" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodFour" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdFour" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdFour" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 5???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodFive" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodFive" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFive')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodFive" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodFive" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdFive" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdFive" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 6???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodSix" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodSix" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSix')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodSix" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodSix" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdSix" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdSix" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 7???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodSeven" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodSeven" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSeven')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodSeven" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodSeven" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdSeven" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdSeven" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 8???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodEight" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodEight" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEight')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodEight" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodEight" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdEight" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdEight" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 9???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodNine" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodNine" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodNine')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodNine" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodNine" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdNine" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdNine" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 10???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodTen" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodTen" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTen')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodTen" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodTen" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdTen" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdTen" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 11???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodEleven" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodEleven" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEleven')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodEleven" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodEleven" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdEleven" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdEleven" type="hidden" />
             </div>
         </td>
         <td align="center">
             <%-- 12???--%>
             <div id="_xform_fdDetailList_Form[!{index}].fdPeriodTwelve" _xform_type="text">
                 <xform:text property="fdDetailList_Form[!{index}].fdPeriodTwelve" showStatus="edit" onValueChange="recountMonthAmount" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwelve')}"  validators="number scaleLength(2)" style="width:95%;color: #333;" />
                 <input name="fdDetailList_Form[!{index}].fdParentPeriodTwelve" type="hidden" />
                 <input name="fdDetailList_Form[!{index}].fdCanApplyPeriodTwelve" type="hidden" />
                 <input name="fdDetailList_noShow_Form[!{index}].fdTwelve" type="hidden" />
                 <input name="fdDetailList_db_Form[!{index}].fdTwelve" type="hidden" />
             </div>
         </td>
         <td align="center">
             <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
                 <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
             </a>
         </td>
     </tr>
     <c:forEach items="${fsscBudgetingMainForm.fdDetailList_Form}" var="fdDetailList_FormItem" varStatus="vstatus">
     	<!-- ????????????????????? -->
     	<c:if test="${empty oneLine}">
         <tr KMSS_IsContentRow="1">
             <td align="center">
                 <input type="checkbox" name="DocList_Selected" />
                 <xform:text property="fdDetailList_Form[${vstatus.index}].docMainId" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].docMainId'" showStatus="noShow"></xform:text>
                 <xform:text property="fdDetailList_Form[${vstatus.index}].fdParentId" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdParentId'" showStatus="noShow"></xform:text>
                 <xform:text property="fdDetailList_Form[${vstatus.index}].fdIsLastStage" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdIsLastStage'" showStatus="noShow"></xform:text>
             	 <xform:text property="fdDetailList_Form[${vstatus.index}].fdStatus" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdStatus'" value="${fdDetailList_FormItem.fdStatus}" showStatus="noShow"></xform:text>
             	  <!-- ???????????????/????????????????????????????????????readOnly???????????????????????????edit -->
             	 <c:set var="showStatus" value=""></c:set>
             	 <c:if test="${fdDetailList_FormItem.fdIsLastStage=='0'  or fdDetailList_FormItem.fdStatus=='4'}">
             	 	<c:set var="showStatus" value="readOnly=\"readOnly\""></c:set>
             	 </c:if>
             	 <!-- ????????????????????????????????????????????????????????????????????????????????? -->
             	 <c:set var="display" value="false"></c:set>
             	 <c:if test="${fdDetailList_FormItem.fdIsLastStage=='1'}">
             	 	<c:set var="display" value="true"></c:set>
             	 </c:if>
             </td>
             <td align="center">
                 ${vstatus.index+1}
             </td>
             <c:choose>
             	<c:when test="${fdDetailList_FormItem.fdStatus=='4'  or fdDetailList_FormItem.fdIsLastStage=='0'}">
             		<fssc:showBudgetingDetail type="contentline" fdSchemeId="${lfn:escapeHtml(param.fdSchemeId)}" detailForm="${fdDetailList_FormItem}" method="view" tdIndex="${vstatus.index}"></fssc:showBudgetingDetail>
             	</c:when>
             	<c:otherwise>
             		<fssc:showBudgetingDetail type="contentline" fdSchemeId="${lfn:escapeHtml(param.fdSchemeId)}" detailForm="${fdDetailList_FormItem}" method="edit" tdIndex="${vstatus.index}"></fssc:showBudgetingDetail>
             	</c:otherwise>
             </c:choose>
             <td align="center">
             		${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.parent')}
             		<hr />
             		${lfn:message('fssc-budgeting:fsscBudgetingDetail.surplus.canApply')}
             		<hr />
             		${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.new.budgeting')}
             </td>
             <td align="center">
                 <%-- ??????--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdTotal" _xform_type="text">
                 	 <!-- ???????????? -->
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentTotal" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyTotal" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdTotal" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdTotal" value="${fdDetailList_FormItem.fdTotal}" type="hidden" />
                     <c:choose>
                     	<c:when test="${fdDetailList_FormItem.fdIsLastStage=='0'  or fdDetailList_FormItem.fdStatus=='4'}">
	                     	<input name="fdDetailList_Form[${vstatus.index}].fdTotal" value="<kmss:showNumber value="${fdDetailList_FormItem.fdTotal }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdTotal')}" ${showStatus} validate="number" onchange="reCalYear(this.value,this);" class="inputsgl" style="width:95%;color: #333;">
	                     </c:when>
	                     <c:otherwise>
	                     	<input name="fdDetailList_Form[${vstatus.index}].fdTotal" value="<kmss:showNumber value="${fdDetailList_FormItem.fdTotal }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdTotal')}" ${showStatus} validate="required number scaleLength(2)" onchange="reCalYear(this.value,this);" class="inputsgl" style="width:95%;color: #333;">
                   	 		<span style="cursor:pointer;" onclick="shareAmount(this.previousElementSibling.value,this.previousElementSibling);">${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdShare')}</span>
	                     </c:otherwise>
                     </c:choose>
                 </div>
             </td>
             <td align="center">
                 <%-- 1???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodOne" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodOne" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodOne" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodOne" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodOne" value="${fdDetailList_FormItem.fdPeriodOne}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodOne" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodOne }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodOne')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 2???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTwo" _xform_type="text">
	                 <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodTwo" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
	                 <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodTwo" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodTwo" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodTwo" value="${fdDetailList_FormItem.fdPeriodTwo}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodTwo" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTwo }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwo')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 3???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodThree" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodThree" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodThree" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodThree" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodThree" value="${fdDetailList_FormItem.fdPeriodThree}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodThree" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodThree }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodThree')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 4???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodFour" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodFour" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodFour" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodFour" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodFour" value="${fdDetailList_FormItem.fdPeriodFour}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodFour" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodFour }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFour')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 5???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodFive" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodFive" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodFive" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodFive" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodFive" value="${fdDetailList_FormItem.fdPeriodFive}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodFive" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodFive }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFive')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 6???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodSix" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodSix" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodSix" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodSix" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodSix" value="${fdDetailList_FormItem.fdPeriodSix}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodSix" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodSix }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSix')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 7???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodSeven" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodSeven" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodSeven" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodSeven" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodSeven" value="${fdDetailList_FormItem.fdPeriodSeven}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodSeven" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodSeven }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSeven')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 8???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodEight" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodEight" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodEight" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodEight" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodEight" value="${fdDetailList_FormItem.fdPeriodEight}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodEight" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodEight }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEight')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 9???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodNine" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodNine" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodNine" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodNine" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodNine" value="${fdDetailList_FormItem.fdPeriodNine}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodNine" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodNine }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodNine')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 10???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTen" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodTen" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodTen" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodTen" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodTen" value="${fdDetailList_FormItem.fdPeriodTen}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodTen" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTen }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTen')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 11???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodEleven" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodEleven" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodEleven" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodEleven" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodEleven" value="${fdDetailList_FormItem.fdPeriodEleven}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodEleven" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodEleven }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEleven')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <%-- 12???--%>
                 <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTwelve" _xform_type="text">
                     <input name="fdDetailList_Form[${vstatus.index}].fdParentPeriodTwelve" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <hr />
                     <input name="fdDetailList_Form[${vstatus.index}].fdCanApplyPeriodTwelve" class="inputsgl" style="width:38px;color: #333;text-align: center;" readonly="readonly" />
                     <input name="fdDetailList_noShow_Form[${vstatus.index}].fdPeriodTwelve" type="hidden" />
                     <hr />
                     <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodTwelve" value="${fdDetailList_FormItem.fdPeriodTwelve}" type="hidden" />
                     <input name="fdDetailList_Form[${vstatus.index}].fdPeriodTwelve" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTwelve }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwelve')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
                 </div>
             </td>
             <td align="center">
                 <c:if test="${fdDetailList_FormItem.fdStatus!='4'}">
                 <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
                     <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
                 </a>
                 </c:if>
             </td>
         </tr>
         </c:if>
         <c:if test="${oneLine}">
         <!-- ??????????????? -->
         	<tr KMSS_IsContentRow="1">
		         <td align="center">
		             <input type="checkbox" name="DocList_Selected" />
		             <xform:text property="fdDetailList_Form[${vstatus.index}].docMainId" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].docMainId'" showStatus="noShow"></xform:text>
		             <xform:text property="fdDetailList_Form[${vstatus.index}].fdParentId" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdParentId'" showStatus="noShow"></xform:text>
		             <xform:text property="fdDetailList_Form[${vstatus.index}].fdIsLastStage" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdIsLastStage'" showStatus="noShow"></xform:text>
		         	 <xform:text property="fdDetailList_Form[${vstatus.index}].fdStatus" htmlElementProperties="id='fdDetailList_Form[${vstatus.index}].fdStatus'" value="${fdDetailList_FormItem.fdStatus}" showStatus="noShow"></xform:text>
		         	  <!-- ???????????????/????????????????????????????????????readOnly???????????????????????????edit -->
		         	 <c:set var="showStatus" value=""></c:set>
		         	 <c:if test="${fdDetailList_FormItem.fdIsLastStage=='0'  or fdDetailList_FormItem.fdStatus=='4'}">
		         	 	<c:set var="showStatus" value="readOnly=\"readOnly\""></c:set>
		         	 </c:if>
		         	 <!-- ????????????????????????????????????????????????????????????????????????????????? -->
		         	 <c:set var="display" value="false"></c:set>
		         	 <c:if test="${fdDetailList_FormItem.fdIsLastStage=='1'}">
		         	 	<c:set var="display" value="true"></c:set>
		         	 </c:if>
		         </td>
		         <td align="center">
		             ${vstatus.index+1}
		         </td>
		         <c:choose>
		         	<c:when test="${fdDetailList_FormItem.fdStatus=='4'  or fdDetailList_FormItem.fdIsLastStage=='0'}">
		         		<fssc:showBudgetingDetail type="contentline" fdSchemeId="${lfn:escapeHtml(param.fdSchemeId)}" detailForm="${fdDetailList_FormItem}" method="view" tdIndex="${vstatus.index}"></fssc:showBudgetingDetail>
		         	</c:when>
		         	<c:otherwise>
		         		<fssc:showBudgetingDetail type="contentline" fdSchemeId="${lfn:escapeHtml(param.fdSchemeId)}" detailForm="${fdDetailList_FormItem}" method="edit" tdIndex="${vstatus.index}"></fssc:showBudgetingDetail>
		         	</c:otherwise>
		         </c:choose>
		         <td align="center">
		         		${lfn:message('fssc-budgeting:fsscBudgetingDetail.gather.new.budgeting')}
		         </td>
		         <td align="center">
		             <%-- ??????--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdTotal" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdTotal" value="${fdDetailList_FormItem.fdTotal}" type="hidden" />
		               	 <input name="fdDetailList_Form[${vstatus.index}].fdTotal" value="<kmss:showNumber value="${fdDetailList_FormItem.fdTotal }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdTotal')}" ${showStatus} validate="required number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		               	 <span style="cursor:pointer;" onclick="shareAmount(this.previousElementSibling.value,this.previousElementSibling);">${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdShare')}</span>
		             </div>
		         </td>
		         <td align="center">
		             <%-- 1???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodOne" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodOne" value="${fdDetailList_FormItem.fdPeriodOne}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodOne" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodOne }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodOne')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 2???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTwo" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodTwo" value="${fdDetailList_FormItem.fdPeriodTwo}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodTwo" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTwo }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwo')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 3???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodThree" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodThree" value="${fdDetailList_FormItem.fdPeriodThree}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodThree" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodThree }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodThree')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 4???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodFour" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodFour" value="${fdDetailList_FormItem.fdPeriodFour}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodFour" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodFour }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFour')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 5???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodFive" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodFive" value="${fdDetailList_FormItem.fdPeriodFive}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodFive" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodFive }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodFive')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 6???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodSix" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodSix" value="${fdDetailList_FormItem.fdPeriodSix}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodSix" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodSix }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSix')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 7???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodSeven" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodSeven" value="${fdDetailList_FormItem.fdPeriodSeven}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodSeven" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodSeven }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodSeven')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 8???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodEight" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodEight" value="${fdDetailList_FormItem.fdPeriodEight}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodEight" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodEight }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEight')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 9???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodNine" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodNine" value="${fdDetailList_FormItem.fdPeriodNine}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodNine" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodNine }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodNine')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 10???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTen" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodTen" value="${fdDetailList_FormItem.fdPeriodTen}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodTen" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTen }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTen')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 11???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodEleven" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodEleven" value="${fdDetailList_FormItem.fdPeriodEleven}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodEleven" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodEleven }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodEleven')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <%-- 12???--%>
		             <div id="_xform_fdDetailList_Form[${vstatus.index}].fdPeriodTwelve" _xform_type="text">
		                 <input name="fdDetailList_db_Form[${vstatus.index}].fdPeriodTwelve" value="${fdDetailList_FormItem.fdPeriodTwelve}" type="hidden" />
		                 <input name="fdDetailList_Form[${vstatus.index}].fdPeriodTwelve" value="<kmss:showNumber value="${fdDetailList_FormItem.fdPeriodTwelve }" pattern="0.00"/>" subject="${lfn:message('fssc-budgeting:fsscBudgetingDetail.fdPeriodTwelve')}" onchange="recountMonthAmount(this.value,this);" ${showStatus} validate="number scaleLength(2)" class="inputsgl" style="width:95%;color: #333;">
		             </div>
		         </td>
		         <td align="center">
		             <c:if test="${fdDetailList_FormItem.fdStatus!='4'}">
	                 <a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
	                     <img src="${KMSS_Parameter_StylePath}icons/icon_del.png" border="0" />
	                 </a>
	                 </c:if>
		         </td>
		     </tr>
         </c:if>
     </c:forEach>
     <tr type="optRow" class="tr_normal_opt" invalidrow="true">
          <td colspan="22">
              <a href="javascript:void(0);" onclick="DocList_AddRow();">
                  <img src="${KMSS_Parameter_StylePath}icons/icon_add.png" border="0" title="${lfn:message('doclist.add')}" />
              </a>
          </td>
      </tr>
 </table>
 <input type="hidden" name="fdDetailList_Flag" value="1">
 <script>
     Com_IncludeFile("doclist.js");
 </script>
 <script>
     DocList_Info.push('TABLE_DocList_fdDetailList_Form');
 </script>