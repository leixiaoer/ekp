<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<c:set var="geesunOitemsBudgerApplicationForm" value="${requestScope[param.formBeanName]}" />
		<div class="muiFlowInfoW muiFormContent">
				<div class="muiFormSubject">
						<xform:text property="docSubject"></xform:text>
				</div> 
				 <c:if test="${geesunOitemsBudgerApplicationForm.docStatus eq '30'}">
	                <div class="muiProcessStatus"  <c:if test="${empty param.loading or param.loading == 'false' }">id=processStatusDiv</c:if>>
	                    <i class="mui mui-processPass"></i>
	                </div>
                </c:if>
                 <c:if test="${geesunOitemsBudgerApplicationForm.docStatus eq '00'}">
	                <div class="muiDiscardStatus" <c:if test="${empty param.loading or param.loading == 'false' }">id="discardStatusDiv"</c:if>>
	                    <i class="mui mui-processDiscard"></i>
	                </div>
                </c:if>
				<table class="muiSimple muiFlowTable" cellpadding="0" cellspacing="0">
					<tr>
						<td rowspan="2" class="muiFlowIconTd">
							 <div class="muiProcessIcon">
			                    <img class="muiProcessImg" src='<person:headimageUrl contextPath="true"  personId="${geesunOitemsBudgerApplicationForm.docCreatorId}" size="m" />'/>
			                </div>
			                <div class="muiFlowCreator">
			                	<xform:text property="docCreatorName"></xform:text>
			                </div>
						</td>
						<td class="muiFlowSummary">
							<div>${lfn:message('geesun-oitems:geesunOitems.tree.application.type') }：<sunbor:enumsShow value="${geesunOitemsBudgerApplicationForm.fdType}" enumsType="geesunOitemsBudgerApplication_fdType" /></div>
							<div>${lfn:message('geesun-oitems:geesunOitemsBudgerApplication.creator.dept') }： <xform:text property="docDeptName"></xform:text></div>
							<div>${lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docCreateTime') }： <xform:text property="docCreateTime"></xform:text></div>
						</td>
					</tr>
				</table>
			</div>
<c:if test="${not empty param.loading and param.loading == 'true' }">
	<div style="height: 100%;padding-top: 10rem;">
		<%@ include file="/sys/mobile/extend/combin/loading.jsp"%>
	</div>
</c:if>
