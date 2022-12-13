<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
		<mui:min-file name="mui-supervise-view.css"/>
		<mui:min-file name="mui-supervise.js"/>
	</template:replace>
	<template:replace name="title">
			<c:out value="${ kmSuperviseMainFinishForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do">
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
			<html:hidden property="fdId" />
			<html:hidden property="docSubject" />
		    <html:hidden property="fdMainId" />
		    <html:hidden property="docStatus" />
		    <html:hidden property="method_GET" />
			<div class="muiTaskInfoBanner">
				<dl class="txtInfoBar">
					<dt>
						<%--名称--%>
						<xform:text property="docSubject"></xform:text>
					</dt>
				</dl>
			</div>
			
			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem">
					<%--切换页签--%>
					<div class="muiHeader">
						<div
							data-dojo-type="mui/nav/MobileCfgNavBar" 
							data-dojo-props="defaultUrl:'/km/supervise/mobile/finish_view_nav.jsp?docStatus=${kmSuperviseMainForm.docStatus }' ">
						</div>
					</div>
				</div>
			</div>
			
			<%--办结内容--%>
			<div id="contentView" data-dojo-type="dojox/mobile/View">
				<div data-dojo-type="mui/panel/AccordionPanel">
					<div class="muiFormContent muiFlowInfoW">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseMainFinish.fdOperator" />
								</td>
								<td>
									<xform:address propertyName="fdOperatorName" propertyId="fdOperatorId" showStatus="view" mobile="true"/>
								</td>
							</tr>
							
							<!-- 办结日期 -->
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseMainFinish.fdRealFinishTime" />
								</td>
								<td >
									<xform:datetime property="fdRealFinishTime" showStatus="view" required="true" mobile="true"/>
								</td>
							</tr>
							
							<!-- 办结情况 -->
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseMainFinish.fdFinishDesc" />
								</td>
								<td>
									<xform:textarea property="fdFinishDesc" style="width:90%;"
										required="true" showStatus="view" validators="maxLength(1500)" mobile="true"></xform:textarea>
								</td>
							</tr>
									
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="py.FuJianShangChuan"/>
								</td>
								<td>
									<c:import
										url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmSuperviseMainFinishForm"></c:param>
										<c:param name="fdKey" value="attFinish" />
										<c:param name="fdMulti" value="true" />
									</c:import>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			<%--流程记录--%>
			<div data-dojo-type="dojox/mobile/View" id="folwView">
				<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
					<c:param name="fdModelId" value="${kmSuperviseMainFinishForm.fdId }"/>
					<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMainFinish"/>
					<c:param name="formBeanName" value="kmSuperviseMainFinishForm"/>
				</c:import>
			</div>
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
			      docStatus="${kmSuperviseMainFinishForm.docStatus}" 
				  editUrl="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do?method=edit&fdId=${param.fdId }&fdMainId=${kmSuperviseMainFinishForm.fdMainId }"
				  formName="kmSuperviseMainFinishForm"
				  viewName="lbpmView"
				  allowReview="true">
			</template:include>
		</div>
		
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmSuperviseMainFinishForm" />
			<c:param name="fdKey" value="kmSuperviseSetup" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
			<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainFinishForm, 'publishDraft');" />
		</c:import>
		</html:form>
		<script>
			require(["mui/form/ajax-form!kmSuperviseMainFinishForm"]);
		</script>
	</template:replace>
</template:include>