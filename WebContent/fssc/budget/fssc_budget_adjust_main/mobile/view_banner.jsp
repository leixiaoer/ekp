<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
		<div class="muiFlowInfoW muiFormContent">
				<div class="muiFormSubject">
					<xform:text property="docSubject"></xform:text>
				</div> 
				 <c:if test="${fsscBudgetAdjustMainForm.docStatus eq '30'}">
	                <div class="muiProcessStatus" <c:if test="${empty param.loading or param.loading == 'false' }">id=processStatusDiv</c:if>>
	                    <i class="mui mui-processPass"></i>
	                </div>
                </c:if>
                 <c:if test="${fsscBudgetAdjustMainForm.docStatus eq '00'}">
	                <div class="muiDiscardStatus" <c:if test="${empty param.loading or param.loading == 'false' }">id="discardStatusDiv"</c:if>>
	                    <i class="mui mui-processDiscard"></i>
	                </div>
                </c:if>
				<table class="muiSimple muiFlowTable" cellpadding="0" cellspacing="0">
					<tr>
						<td rowspan="2" class="muiFlowIconTd">
							 <div class="muiProcessIcon">
			                    <img class="muiProcessImg" src='<person:headimageUrl contextPath="true"  personId="${fsscBudgetAdjustMainForm.docCreatorId}" size="m" />'/>
			                </div>
			                <div class="muiFlowCreator">
			                	<xform:text property="docCreatorName"></xform:text>
			                </div>
						</td>
						<td class="muiFlowSummary">
							<div>${lfn:message('fssc-budget:fsscBudgetAdjustMain.docTemplate') }：<c:out value="${fsscBudgetAdjustMainForm.docTemplateName}" /> </div>
							<div>${lfn:message('fssc-budget:fsscBudgetAdjustMain.docNumber') }： <c:out value="${fsscBudgetAdjustMainForm.docNumber}" /></div>
							<div>${lfn:message('fssc-budget:fsscBudgetAdjustMain.docCreateTime') }： <c:out value="${fsscBudgetAdjustMainForm.docCreateTime}" /></div>
						</td>
					</tr>
				</table>
			</div>
<c:if test="${not empty param.loading and param.loading == 'true' }">
	<div style="height: 100%;padding-top: 10rem;">
		<%@ include file="/sys/mobile/extend/combin/loading.jsp"%>
	</div>
</c:if>