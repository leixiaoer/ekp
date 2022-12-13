<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
		<mui:min-file name="mui-supervise-view.css"/>
		<mui:min-file name="mui-supervise.js"/>
		<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/allSupervision.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="title">
			<c:out value="${ kmSuperviseMainPlanForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
	<html:form action="/km/supervise/km_supervise_main_plan/kmSuperviseMainPlan.do">
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
			<html:hidden property="fdId"/>
			<html:hidden property="docSubject"/>
			<html:hidden property="docStatus"/>
			<html:hidden property="fdMainId"/>
			<html:hidden property="method_GET" />
			<div class="muiTaskInfoBanner">
				<dl class="txtInfoBar">
					<dt>
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
							data-dojo-props="defaultUrl:'/km/supervise/mobile/plan_view_nav_new.jsp' ">
						</div>
					</div>
				</div>
			</div>
			
			<%--督办计划及反馈--%>
			<div id="planView" data-dojo-type="dojox/mobile/View">
				<table width="100%" cellpadding="0" cellspacing="0" id="TABLE_DocList">
					<c:forEach items="${kmSuperviseMainPlanForm.fdTaskItems}" var="fdItem" varStatus="vstatus">
						<tr KMSS_IsContentRow="1">
							<td class="detail_wrap_td">
								<table class="muiSimple">
									<tr celltr-title="true">
										<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
											<div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
											<span onclick="expandRow(this);">
												${fdItem.docSubject}
											</span>
										</td>
									</tr>
									<tr data-celltr="true">
										<td class="muiTitle">
											<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
										</td>
										<td>
											<xform:config  orient="none">
												<html:hidden property="fdTaskItems[${vstatus.index}].fdId" value="${fdItem.fdId}"/>
												<html:hidden property="fdTaskItems[${vstatus.index}].fdOrder" value="${vstatus.index}"/>
												<xform:text property="fdTaskItems[${vstatus.index}].docSubject" value="${fdItem.docSubject}" showStatus="view" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOrder')}" mobile="true"></xform:text>
											</xform:config>
										</td>
									</tr>
									<tr data-celltr="true">
										<td class="muiTitle">
											<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
										</td>
										<td>
											<xform:config orient="none">
												<xform:textarea property="fdTaskItems[${vstatus.index}].docContent" value="${fdItem.docContent}" mobile="true" required="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdTarget')}" showStatus="view"/>
											</xform:config>
										</td>
									</tr>
									<tr data-celltr="true">
										<td class="muiTitle">
											${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}
										</td>
										<td>
											<xform:config  orient="none">
												<xform:datetime property="fdTaskItems[${vstatus.index}].fdPlanStartTime" value="${fdItem.fdPlanStartTime}" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" showStatus="view" required="true" mobile="true"/>	
											</xform:config>
										</td>
									</tr>
									<tr data-celltr="true"> 
										<td class="muiTitle">
											${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}
										</td>
										<td>
											<xform:config  orient="none">
												<xform:datetime property="fdTaskItems[${vstatus.index}].fdPlanEndTime" dateTimeType="datetime" value="${fdItem.fdPlanEndTime}" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" showStatus="view" required="true" mobile="true"/>	
											</xform:config>
										</td>
									</tr>
									<!-- 主办单位 -->
									<tr data-celltr="true">
										<td class="muiTitle">
											<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
										</td>
										<td>
											<xform:config  orient="none">
												<c:choose>
													<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
														<html:hidden property="fdItems[${vstatus.index}].fdSysUnitId" value="${fdItem.fdSysUnitId}"/>
														<html:hidden property="fdItems[${vstatus.index}].fdSysUnitName" value="${fdItem.fdSysUnitName}"/>
														<c:out value="${fdItem.fdSysUnitName}"></c:out>
													</c:when>
													<c:otherwise>
														<xform:address propertyId="fdTaskItems[${vstatus.index}].fdUnitId" required="true" propertyName="fdTaskItems[${vstatus.index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}"/>
													</c:otherwise>
												</c:choose>
											</xform:config>
										</td>
									</tr>
									<!-- 承办人 -->
									<tr data-celltr="true">
										<td class="muiTitle">
											<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
										</td>
										<td>
											<xform:config  orient="none">
												<xform:address propertyId="fdTaskItems[${vstatus.index}].fdSponsorId" propertyName="fdTaskItems[${vstatus.index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}" required="true" showStatus="view"/>
											</xform:config>
										</td>
									</tr>
														
									<!-- 协办单位 -->
									<tr data-celltr="true">
										<td class="muiTitle">
											<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>
										</td>
										<td>
											<xform:config  orient="none">
												<c:choose>
													<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
														<html:hidden property="fdItems[${vstatus.index}].fdOtherUnitIds" value="${fdItem.fdOtherUnitIds}"/>
														<html:hidden property="fdItems[${vstatus.index}].fdOtherUnitNames" value="${fdItem.fdOtherUnitNames}"/>
														<c:out value="${fdItem.fdOtherUnitNames}"></c:out>
													</c:when>
													<c:otherwise>
														<xform:address propertyId="fdTaskItems[${vstatus.index}].fdOUnitIds" propertyName="fdTaskItems[${vstatus.index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" mulSelect="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOtherUnits')}"/>
													</c:otherwise>
												</c:choose>
											</xform:config>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<%--流程记录--%>
			<div data-dojo-type="dojox/mobile/View" id="folwView">
				<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
					<c:param name="fdModelId" value="${kmSuperviseMainPlanForm.fdId }"/>
					<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMainPlan"/>
					<c:param name="formBeanName" value="kmSuperviseMainPlanForm"/>
				</c:import>
			</div>
			
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
						formName="kmSuperviseMainPlanForm"
						viewName="lbpmView"
						allowReview="true">
			</template:include>
		</div>
				
	
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmSuperviseMainPlanForm" />
			<c:param name="fdKey" value="kmSuperviseMakePlan" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
			<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainPlanForm, 'publishDraft');" />
		</c:import>
		</html:form>
	</template:replace>
</template:include>
<script>
	require(["mui/form/ajax-form!kmSuperviseMainPlanForm"]);
	require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
	         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading",'mui/dialog/Dialog',"dojo/_base/lang"], 
			function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading,Dialog,lang){
		window.expandRow = function(domNode){
			var domTable = $(domNode).closest('table')[0];
			var display = domAttr.get(domTable,'data-display'),
				newdisplay = (display == 'none' ? '' : 'none');
			domAttr.set(domTable,'data-display',newdisplay);
			var items = query('tr[data-celltr="true"],tr[statistic-celltr="true"]',domTable);
			for(var i = 0; i < items.length; i++){
				if(newdisplay == 'none'){
					domStyle.set(items[i],'display','none');
				}else{
					domStyle.set(items[i],'display','');
				}
			}
			var opt = query('.muiDetailDisplayOpt',domTable)[0];
			if(newdisplay == 'none'){
				domClass.add(opt,'muiDetailUp');
				domClass.remove(opt,'muiDetailDown');
			}else{
				domClass.add(opt,'muiDetailDown');
				domClass.remove(opt,'muiDetailUp');
			}
		};
	});
</script>