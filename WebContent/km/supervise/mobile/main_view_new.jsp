<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseParamConfig"%>
<% 
	KmSuperviseParamConfig paramConfig = new KmSuperviseParamConfig();
	pageContext.setAttribute("paramConfig",paramConfig);
%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
		<mui:min-file name="mui-supervise-view.css"/>
		<mui:min-file name="mui-supervise.js"/>
		<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/allSupervision.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="title">
			<c:out value="${ kmSuperviseMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do">
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem">
					<%--切换页签--%>
					<div class="muiHeader">
						<div
							data-dojo-type="mui/nav/MobileCfgNavBar" 
							data-dojo-props="defaultUrl:'/km/supervise/mobile/view_nav_new.jsp' ">
						</div>
					</div>
				</div>
			</div>
			
			<div data-dojo-type="dojox/mobile/View" id="baseView">
				<html:hidden property="fdId" />
		       	<html:hidden property="docStatus" />
		       	<html:hidden property="fdIsNew"/>
		       	<html:hidden property="fdIsPlan"/>
		       	<html:hidden property="method_GET" />
				<table class="muiSimple" cellpadding="0" cellspacing="0">
                	<tr>
                    	<td colspan="2">
							<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
								charEncoding="UTF-8">
								<c:param name="formName" value="kmSuperviseMainForm" />
								<c:param name="fdKey" value="kmSuperviseMain" />
								<c:param name="backTo" value="scrollView" />
							</c:import>
                        </td>
                	</tr>
				</table>
			</div>
			
			<%--督办计划及反馈--%>
			<div id="planView" data-dojo-type="dojox/mobile/View">
				<div class="muiFlowInfoW muiFormContent">
					<table width="100%" cellpadding="0" cellspacing="0" id="TABLE_DocList">
						<c:forEach items="${kmSuperviseMainForm.fdItems}" var="fdItem" varStatus="vstatus">
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
													<html:hidden property="fdItems[${vstatus.index}].fdId" value="${fdItem.fdId}"/>
													<html:hidden property="fdItems[${vstatus.index}].fdOrder" value="${vstatus.index}"/>
													<xform:text property="fdItems[${vstatus.index}].docSubject" showStatus="view" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOrder')}" required="true" mobile="true"></xform:text>
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
											</td>
											<td>
												<xform:config orient="none">
													<xform:textarea property="fdItems[${vstatus.index}].docContent" mobile="true" required="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdTarget')}"/>
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true">
											<td class="muiTitle">
												${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}
											</td>
											<td>
												<xform:config  orient="none">
													<xform:datetime property="fdItems[${vstatus.index}].fdPlanStartTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" showStatus="view" required="true" mobile="true"/>	
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true"> 
											<td class="muiTitle">
												${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}
											</td>
											<td>
												<xform:config  orient="none">
													<xform:datetime property="fdItems[${vstatus.index}].fdPlanEndTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" showStatus="view" required="true" mobile="true"/>	
												</xform:config>
											</td>
										</tr>
										<c:if test="${paramConfig.taskFieldEnable }">
										<!-- 主办单位 -->
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
											</td>
											<td>
												<xform:config  orient="none">
													<c:choose>
														<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
															<html:hidden property="fdItems[${vstatus.index}].fdSysUnitId" value="${fdItem.fdSysUnitId}"/>
															<html:hidden property="fdItems[${vstatus.index}].fdSysUnitName" value="${fdItem.fdSysUnitName}"/>
															<c:out value="${fdItem.fdSysUnitName}"></c:out>
														</c:when>
														<c:otherwise>
															<xform:address propertyId="fdItems[${vstatus.index}].fdUnitId" propertyName="fdItems[${vstatus.index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}"/>
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
													<xform:address propertyId="fdItems[${vstatus.index}].fdSponsorId" propertyName="fdItems[${vstatus.index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}"/>
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
														<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
															<html:hidden property="fdItems[${vstatus.index}].fdOtherUnitIds" value="${fdItem.fdOtherUnitIds}"/>
															<html:hidden property="fdItems[${vstatus.index}].fdOtherUnitNames" value="${fdItem.fdOtherUnitNames}"/>
															<c:out value="${fdItem.fdOtherUnitNames}"></c:out>
														</c:when>
														<c:otherwise>
															<xform:address propertyId="fdItems[${vstatus.index}].fdOUnitIds" propertyName="fdItems[${vstatus.index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" mulSelect="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOtherUnits')}"/>
														</c:otherwise>
													</c:choose>
												</xform:config>
											</td>
										</tr>
										<!-- 阶段反馈周期-->
											<tr>
												<td class="muiTitle">
													<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>
												</td>
												<td>
													<xform:select property="fdBackType" showPleaseSelect="false" showStatus="view" mobile="true" value="0">
														<xform:enumsDataSource enumsType="km_supervise_task_back"></xform:enumsDataSource>
													</xform:select>
												</td>
											</tr>
											<!-- 附件上传 -->
											<tr>
												<td class="muiTitle">
													<bean:message bundle="km-supervise" key="py.FuJianShangChuan"/>
												</td>
												<td>
													<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
														<c:param name="formName" value="kmSuperviseMainForm"></c:param>
														<c:param name="fdKey" value="attTask" />
														<c:param name="fdMulti" value="true" />
														<c:param name="fdViewType" value="simple"/>
													</c:import>
												</td>
											</tr>
										</c:if>
									</table>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			
			<%--流程记录--%>
			<div data-dojo-type="dojox/mobile/View" id="folwView">
				<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
					<c:param name="fdModelId" value="${kmSuperviseMainForm.fdId }"/>
					<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain"/>
					<c:param name="formBeanName" value="kmSuperviseMainForm"/>
				</c:import>
			</div>
			
			
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
						editUrl="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=edit&fdId=${param.fdId }"
						formName="kmSuperviseMainForm"
						viewName="lbpmView"
						allowReview="true">
			<template:replace name="flowArea">
					<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  	<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain"></c:param>
					  	<c:param name="fdModelId" value="${kmSuperviseMainForm.fdId}"></c:param>
					    <c:param name="fdSubject" value="${kmSuperviseMainForm.docSubject}"></c:param>
					    <c:param name="showOption" value="label"></c:param>
			  		</c:import>
				</template:replace>
				<template:replace name="publishArea">
					<c:if test="${kmSuperviseMainForm.docStatus=='30'}">
			            <c:if test="${kmSuperviseMainForm.fdIsPlan eq false}">
			            	<c:choose>
			            		<c:when test="${ empty kmSuperviseMainForm.fdItems}">
				            		<!--任务指派-->
						            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addTask&fdId=${param.fdId}">
						                <li data-dojo-type="mui/tabbar/TabBarButton"
											data-dojo-mixins="km/supervise/mobile/resource/js/_AddTaskTabBarButtonMixin"
											data-dojo-props="label:'<bean:message bundle="km-supervise" key="py.RenWuZhiPai" />',fdId:'${param.fdId}',isAdd:true"></li>
						            </kmss:auth>
			            		</c:when>
			            		<c:otherwise>
			            			<!--任务指派-->
						            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addTask&fdId=${param.fdId}">
						            	<li data-dojo-type="mui/tabbar/TabBarButton"
											data-dojo-mixins="km/supervise/mobile/resource/js/_AddTaskTabBarButtonMixin"
											data-dojo-props="label:'<bean:message bundle="km-supervise" key="py.RenWuZhiPai" />',fdId:'${param.fdId}',isAdd:false"></li>
						            </kmss:auth>
			            		</c:otherwise>
			            	</c:choose>
			            </c:if>
		            </c:if>
				</template:replace>
			</template:include>
		</div>
				
	
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmSuperviseMainForm" />
			<c:param name="fdKey" value="kmSuperviseMain" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
			<c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainForm, 'publishDraft');" />
		</c:import>
		</html:form>
	</template:replace>
</template:include>
<script>
	require(["mui/form/ajax-form!kmSuperviseMainForm"]);
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
		topic.subscribe("mui/form/validationInitFinish",function(wgt){
			var Validates = {
					'validateSuperviseTime':{
						error : '请先选择结束时间',
						test  : function(v) {
							var fdStartTime = $('[name="fdStartTime"]').val();
							var fdFinishTime = $('[name="fdFinishTime"]').val();
							var ds = Com_GetDate(fdStartTime);
							var de = Com_GetDate(fdFinishTime);
							if(de < ds){
								validator = this.getValidator('validateSuperviseTime');
								var error = '结束时间不能早于开始时间';
								validator.error = error;
								return false;
							}else{
								return true
							}
						}
					},
				'validateStartTime':{
					error : '请先选择开始时间',
					test  : function(v) {
						var fdStartTime = $('[name="fdStartTime"]').val();
						var fdFinishTime = $('[name="fdFinishTime"]').val();
						var ds = Com_GetDate(fdStartTime);
						var de = Com_GetDate(fdFinishTime);
						if(de < ds){
							validator = this.getValidator('validateStartTime');
							var error = '开始时间不能晚于结束时间';
							validator.error = error;
							return false;
						}else{
							return true
						}
					}
				}
			}
			for (var type in Validates) {
				wgt._validation.addValidator(type, Validates[type].error, Validates[type].test);
			}
		});
	});
</script>