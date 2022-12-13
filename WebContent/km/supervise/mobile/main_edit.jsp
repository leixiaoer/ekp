<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:if test="${empty  kmSuperviseMainForm.docSubject}">
			<bean:message bundle="km-supervise" key="module.km.supervise" />
		</c:if>
		<c:out value="${kmSuperviseMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-supervise-view.css"/>
		<%-- <link rel="stylesheet" type="text/css" 
			href="<%=request.getContextPath()%>/sys/attend/map/mobile/resource/css/location.css?s_cache=${MUI_Cache}"></link> --%>
		<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic","dijit/registry"],function(Memory,topic,registry){
		   		var navData = [{'text':'01  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.info" />',
		   			'moveTo':'scrollView','selected':true},{'text':'02  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.review" />',
			   		'moveTo':'lbpmView'}]
		   		window._narStore = new Memory({data:navData});
		   		var changeNav = function(view){
		   			var wgt = registry.byId("_flowNav");
		   			for(var i=0;i<wgt.getChildren().length;i++){
		   				var tmpChild = wgt.getChildren()[i];
		   				if(view.id == tmpChild.moveTo){
		   					tmpChild.beingSelected(tmpChild.domNode);
		   					return;
		   				}
		   			}
		   		}
		   		topic.subscribe("mui/form/validateFail",function(view){
		   			changeNav(view);
		   		});
				topic.subscribe("mui/view/currentView",function(view){
					changeNav(view);
		   		});
		   	});
	   </script>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=save">
			<div>
				<div data-dojo-type="mui/fixed/Fixed" class="muiFlowEditFixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowEditFixedItem">
						<div data-dojo-type="mui/nav/NavBarStore" id="_flowNav" data-dojo-props="store:_narStore">
						</div>
					</div>
				</div>
				<div data-dojo-type="mui/view/DocScrollableView" 
					data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
					<div class="muiFlowInfoW muiFormContent">
						<html:hidden property="fdId" />
						<html:hidden property="fdModelId" />
						<html:hidden property="fdModelName" />
						<html:hidden property="docStatus" />
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.docSubject') }
								</td>
								<td>
									<xform:text property="docSubject" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseMain.docSubject') }"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.docNumber') }
								</td>
								<td>
									<c:choose>
										<c:when test='${kmSuperviseMainForm.docNumber!=null}'>
										    <xform:text property="docNumber" showStatus="view" style="width:95%;" />
										</c:when>
										<c:otherwise>
											<bean:message bundle="km-supervise" key="kmSuperviseMain.auto.number" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdLead') }
								</td>
								<td>
									<xform:address propertyName="fdLeadName" propertyId="fdLeadId" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdLead')}" required="true" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdSponsor') }
								</td>
								<td>
									<xform:address propertyName="fdSponsorName" propertyId="fdSponsorId" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdSponsor')}" required="true"  onValueChange="selectDept(this);"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdUnit') }
								</td>
								<td>
									<xform:address propertyName="fdUnitName" propertyId="fdUnitId" showStatus="edit" orgType="ORG_TYPE_ORG|ORG_TYPE_DEPT" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdUnit')}" required="true" htmlElementProperties="id='fdUnit'"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdResponsible') }
								</td>
								<td>
									<xform:address propertyName="fdResponsibleName" propertyId="fdResponsibleId" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdResponsible')}" required="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdRecipients') }
								</td>
								<td>
									<xform:address propertyName="fdRecipientNames" propertyId="fdRecipientIds" mulSelect="true" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true" />
								</td>
							</tr>
							<!-- 立项时间 -->
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdApprovalTime') }
								</td>
								<td>
									<xform:datetime property="fdApprovalTime" dateTimeType="dateTime" showStatus="edit" required="true" mobile="true"/>	
								</td>
							</tr>
							<!-- 完成时间 -->
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime') }
								</td>
								<td>
									<xform:datetime property="fdFinishTime" dateTimeType="dateTime" onValueChange="checkFinishTime" showStatus="edit" required="true" mobile="true"/>	
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdContent') }
								</td>
								<td>
									<xform:textarea property="fdContent" showStatus="edit" style="width:95%;" mobile="true"/>
								</td>
							</tr>
							<tr>
                                <td class="muiTitle">
                                    ${lfn:message('km-supervise:kmSuperviseMain.attSupervise')}
                                </td>
                                <td  colspan="2">
                                    <c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
										    <c:param name="fdKey" value="attSupervise" />
	                                        <c:param name="formName" value="kmSuperviseMainForm" />
	                                        <c:param name="fdMulti" value="true" />
									</c:import> 
                                </td>
                            </tr>
                             <tr>
                                <td class="muiTitle">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdLevel')}
                                </td>
                                <td>
									<xform:select property="fdLevelId" style="width:115px;" mobile="true">
										<xform:beanDataSource serviceBean="kmSuperviseLevelService" selectBlock="fdId,fdName" whereBlock="fdIsAvailable=true" />
									</xform:select>
                                </td>
                            </tr>
                             <tr>
                                <td class="muiTitle">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdUrgency')}
                                </td>
                                <td>
									<xform:select property="fdUrgencyId" style="width:115px;" mobile="true">
										 <xform:beanDataSource serviceBean="kmSuperviseUrgencyService" selectBlock="fdId,fdName" whereBlock="fdIsAvailable=true" />
									</xform:select>
                                </td>
                            </tr>
                             <tr>
                               <!--  <td class="muiTitle">
                                	表单属性
                                </td> -->
                                <td colspan="2">
                               		<!-- <div class="muiFlowInfoW muiFormContent"> -->
										<c:if test="${kmSuperviseMainForm.docUseXform == 'false'}">
											<table class="muiSimple" cellpadding="0" cellspacing="0">
												<tr>
													<td colspan="2">
														<xform:textarea property="docXform" mobile="true" placeholder="请输入督办内容"/>
													</td>
												</tr>
											</table>
										</c:if>
										<c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
											<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
												charEncoding="UTF-8">
												<c:param name="formName" value="kmSuperviseMainForm" />
												<c:param name="fdKey" value="kmSuperviseMain" />
												<c:param name="backTo" value="scrollView" />
											</c:import>
										</c:if>
									<!-- </div> -->
                                </td>
                            </tr>
						</table>
						<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
							  <c:param name="formName" value="kmSuperviseMainForm" />
                       		  <c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
						</c:import>
					</div>
			
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" <c:if test="${'false' ne kmReviewMainForm.fdIsMobileCreate}">data-dojo-props='fill:"grid"'</c:if>>
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'>
					  		<bean:message  bundle="km-supervise"  key="button.next" /></li>
					</ul>
				</div>
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="supervise_submit();" />
				</c:import>
				<script type="text/javascript">
				require(["mui/form/ajax-form!kmSuperviseMainForm"]);
				require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
				         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'], 
						function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip){
							window.supervise_submit = function(){
								if(!checkFinishTime()){
									return false;
								}
								var status = document.getElementsByName("docStatus")[0];
								var method = Com_GetUrlParameter(location.href,'method');
								query('[name="docStatus"]').val('20');
								if(method=='add'){
									Com_Submit(document.forms[0],'save');
								}else{
									Com_Submit(document.forms[0],'update');
								}
							};
							window.checkFinishTime = function(){
								var fdApprovalTime = query('[name="fdApprovalTime"]')[0].value;
								var fdFinishTime = query('[name="fdFinishTime"]')[0].value;
								if(new Date(fdApprovalTime.replace(/\-/g, '/')) >= new Date(fdFinishTime.replace(/\-/g, '/'))){
									Tip.fail({
										text : '完成时限在立项时间之后！'
									});
									return false;
								}
								return true;
							};
							window.selectDept = function(dom){
								var url = "${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=getApplicantDept";
								var fdSponsorId = dom.value;
								var data = {fdSponsorId:fdSponsorId}
								request.post(url, {
									data : data,
									handleAs : 'json',
									sync: true
								}).then(function(data){
				           	 	    if(data.deptId!=""&&data.deptName!=""){
					      	          	registry.byId('fdUnit')._setCurIdsAttr(data.deptId);
										registry.byId('fdUnit')._setCurNamesAttr(data.deptName);
				           	   	 	}
								},function(data){
								});
							}
							
				 });
				</script>
			</div>
		</html:form>
	</template:replace>
</template:include>
