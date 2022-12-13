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
			<c:out value="${ kmSuperviseBackForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<xform:config orient="vertical">
		<html:form action="/km/supervise/km_supervise_back/kmSuperviseBack.do">
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
			<html:hidden property="fdId" />
			<html:hidden property="docSubject" />
		   	<html:hidden property="docStatus" />
		   	<html:hidden property="method_GET" />
		   	<html:hidden property="fdSuperviseId" />
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
							data-dojo-props="defaultUrl:'/km/supervise/mobile/back_view_nav.jsp'">
						</div>
					</div>
				</div>
			</div>
			
			<%--反馈内容--%>
			<div id="contentView" data-dojo-type="dojox/mobile/View">
				<div data-dojo-type="mui/panel/AccordionPanel">
					<div class="muiFormContent muiFlowInfoW">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<!-- 反馈单位 -->
				           	<tr>
								<td>
									<c:choose>
										<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
											<xform:text property="fdSysUnitName" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdUnit') }"></xform:text>
										</c:when>
										<c:otherwise>
											<xform:address propertyName="fdUnitName" propertyId="fdUnitId" showStatus="view" subject="${lfn:message('km-supervise:kmSuperviseMain.fdUnit') }" required="true" mobile="true"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<!-- 反馈人 -->
							<tr>
								<td>
									<xform:address propertyName="fdPersonName" propertyId="fdPersonId" subject="${lfn:message('km-supervise:kmSuperviseBack.fdPerson') }" showStatus="view"  mobile="true"></xform:address>
								</td>
							</tr>
							<!-- 反馈时间 -->
							<tr>
								<td>
									<xform:datetime property="fdFeedbackTime" showStatus="view" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdFeedbackTime') }"/>
								</td>
							</tr>
							<!-- 反馈阶段 -->
							<tr>
								<td>
									<xform:text property="fdTaskSubject" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdTask') }"/>
								</td>
							</tr>
							<!-- 反馈周期 -->
							<c:if test="${kmSuperviseBackForm.fdBackType != '0'}">
							<tr>
								<td>
									<xform:text property="fdBackDay" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdBackPeriod') }"></xform:text>
								</td>
							</tr>
							</c:if>
							<!-- 阶段目标 -->
							<tr>
								<td>
									<xform:text property="fdStageTarget" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdStageTarget') }"/>
								</td>
							</tr>
							
							<!-- 任务进度 -->
				            <tr>
								<td>
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSuperviseProgress" />
									</span>
									<html:hidden property="fdProgress" />
									<span>${kmSuperviseBackForm.fdProgress}%</span>
								</td>
							</tr>
							<!-- 督办状态 -->
							<tr>
								<td>
									<xform:radio property="fdStatus" showStatus="view" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdStatus') }">
										<xform:enumsDataSource enumsType="km_supervise_back_status" />
									</xform:radio>
								</td>
							</tr>
							
							<!-- 进展情况 -->
							<tr>
								<td>
									<xform:textarea property="docProgress" style="width:98%;" showStatus="view" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.docProgress') }"/>
								</td>
							</tr>
							<!-- 存在困难及下一步措施 -->
							<tr>
								<td>
									<xform:textarea property="docDifficulty" style="width:98%;" showStatus="view" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.docDifficulty') }"/>
								</td>
							</tr>
							<!-- 相关附件 -->
							<tr>
								<td >
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="kmSuperviseBack.attBack"/>
									</span>
									<c:import
										url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmSuperviseBackForm"/>
										<c:param name="fdKey" value="attBack" />
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
					<c:param name="fdModelId" value="${kmSuperviseBackForm.fdId }"/>
					<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseBack"/>
					<c:param name="formBeanName" value="kmSuperviseBackForm"/>
				</c:import>
			</div>
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
			      docStatus="${kmSuperviseBackForm.docStatus}" 
				  editUrl="/km/supervise/km_supervise_back/kmSuperviseBack.do?method=edit&fdId=${JsParam.fdId }&fdType=${kmSuperviseBackForm.fdType}&fdIsNew=true"
				  formName="kmSuperviseBackForm"
				  viewName="lbpmView"
				  allowReview="true">
			</template:include>
		</div>
		
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmSuperviseBackForm" />
			<c:param name="fdKey" value="kmSuperviseFeedback" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
			<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseBackForm, 'publishDraft');" />
		</c:import>
		</html:form>
	</xform:config>
	</template:replace>
</template:include>
<script>
	require(["mui/form/ajax-form!kmSuperviseBackForm"]);
</script>