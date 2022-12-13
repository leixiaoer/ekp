<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmOitemsBudgerApplicationForm.method_GET == 'add' }">
				 <c:if test="${kmOitemsBudgerApplicationForm.fdType =='1'}">
					<c:out value="${lfn:message('km-oitems:kmOitems.create.title.dept') } - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
				 </c:if>
				 <c:if test="${kmOitemsBudgerApplicationForm.fdType =='2'}">
				 	<c:out value="${lfn:message('km-oitems:kmOitems.create.title.person') } - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
				 </c:if>
			</c:when>
			<c:otherwise>
				<c:out value="${kmOitemsBudgerApplicationForm.docSubject} - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/oitems/mobile/resource/css/edit.css?s_cache=${MUI_Cache}"></link>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/oitems/mobile/resource/css/oitemselector.css?s_cache=${MUI_Cache}"></link>
		<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic","dijit/registry"],function(Memory,topic,registry){
		   		var navData = [{'text':'01  /  ${lfn:message("sys-mobile:mui.mobile.info") }',
		   			'moveTo':'scrollView','selected':true},{'text':'02  /  ${lfn:message("sys-mobile:mui.mobile.review") }',
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
		<html:form action="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do">
			<div>
				<div data-dojo-type="mui/fixed/Fixed" class="muiFlowEditFixed">
					<div data-dojo-type="mui/fixed/FixedItem"
						class="muiFlowEditFixedItem">
						<div data-dojo-type="mui/nav/NavBarStore" id="_flowNav"
							data-dojo-props="store:_narStore"></div>
					</div>
				</div>
				<div data-dojo-type="mui/view/DocScrollableView" 
					data-dojo-mixins="km/oitems/mobile/resource/js/SelectOitemsMixin" id="scrollView">
					<html:hidden property="fdId"/>
					<html:hidden property="docStatus"/>
					<html:hidden property="fdType"/>
					<html:hidden property="fdTempletType" value="${kmOitemsBudgerApplicationForm.fdType}"/>
					<html:hidden property="docCreatorId"/>
					
					<div class="muiFlowInfoW muiFormContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
	                            <td class="muiTitle">
	                                <bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docSubject"/>
	                            </td>
	                            <td>
	                                <c:if test="${kmOitemsBudgerApplicationForm.titleRegulation==null || kmOitemsBudgerApplicationForm.titleRegulation=='' }">
										<xform:text property="docSubject" mobile="true"/>
									</c:if>
									<c:if test="${kmOitemsBudgerApplicationForm.titleRegulation!=null && kmOitemsBudgerApplicationForm.titleRegulation!='' }">
										<xform:text property="docSubject" mobile="true" showStatus="readOnly" value="${lfn:message('km-review:kmReviewMain.docSubject.info') }" />
									</c:if>
	                            </td>
                        	</tr>
                        	<tr>
	                            <td class="muiTitle">
	                                <c:if test="${kmOitemsBudgerApplicationForm.fdType =='1'}">
										<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicants.deptId"/>
									</c:if>
									<c:if test="${kmOitemsBudgerApplicationForm.fdType =='2'}">
										<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicantsId"/>
									</c:if>
	                            </td>
	                            <td width="35%">
	                            	<c:if test="${kmOitemsBudgerApplicationForm.fdType =='1'}">
						     			<xform:address propertyId="fdApplicantsId" propertyName="fdApplicantsName" orgType="ORG_TYPE_DEPT" style="width:95%" required="true" subject="${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdApplicants.deptId')}" mobile="true"></xform:address>
									</c:if>
									<c:if test="${kmOitemsBudgerApplicationForm.fdType =='2'}">
									     <xform:address propertyId="fdApplicantsId" propertyName="fdApplicantsName" orgType="ORG_TYPE_PERSON" style="width:95%" required="true" subject="${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdApplicantsId')}" mobile="true"></xform:address>
									</c:if>
	                            </td>
                        	</tr>
                        	<c:if test="${kmOitemsBudgerApplicationForm.fdType!='1'}">
                        		<tr>
                        			<td class="muiTitle">
                        				<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.creator.dept"/>
                        			</td>
                        			<td width="35%">
                        				<xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_DEPT" style="width:95%" required="true" subject="${ lfn:message('km-oitems:kmOitemsBudgerApplication.creator.dept')}" mobile="true"></xform:address>
                        			</td>
                        		</tr>
                        	</c:if>
                        	<tr>
			                    <td class="muiTitle">
									<bean:message  bundle="km-oitems" key="table.kmOitemsTemplet"/>
								</td>
								<td width="35%">
									<html:hidden property="fdTemplateId"/>
									<xform:text property="fdTemplateName" mobile="true" showStatus="view"></xform:text>
								</td>					
							</tr>
                        	<tr>
                        		<td colspan="2">
	                        		<div style="position: relative;">
										<div class="muiFormEleTip"><span class="muiFormEleTitle" style="display: inherit;"><bean:message  bundle="km-oitems" key="kmOitems.list"/></span></div>
										<div class="muiFormRequired">*</div>
										<%@include file="/km/oitems/mobile/edit_oitem.jsp"%>
									</div>
									<div data-dojo-type="km/oitems/mobile/resource/js/OitemsTotalAmount" data-dojo-props="label:'${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdTotalAmount')}'"></div>
									<div>
									   	<div 
									   		data-dojo-type="km/oitems/mobile/resource/js/OitemsSelectorButton"
									   		data-dojo-mixins="km/oitems/mobile/resource/js/OitemsSelectorMixin"
									   		data-dojo-props="isMul:true"
											id="selectOitemButton">
											+ <bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.add"/>
										</div>
										<div class="muiValidate" style="display: none;" id="selectOitemTips">
											<div class="muiValidateContent">
												<div class="muiValidateShape"></div>
												<div class="muiValidateInfo">
													<span class="muiValidateIcon"></span>
													<span class="muiValidateMsg">
														<span class="muiValidateTitle"><bean:message bundle="km-oitems" key="kmOitems.error.message1"/></span> 
													</span>
												</div>
											</div>
										</div>
									</div>
                        		</td>
                        	</tr>
                        	<tr>
                        		<td class="muiTitle">
                        			<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdReason"/>
                        		</td>
	                            <td>
	                                <xform:textarea property="fdReason" showStatus="edit" mobile="true" />
	                            </td>
                        	</tr>
                        	<tr>
                        		<td class="muiTitle">
                        			<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdDesc"/>
                        		</td>
                        		<td>
                        			<xform:textarea property="fdDesc" showStatus="edit" mobile="true" />
                        		</td>
                        	</tr>
                        	<tr>
                        		<td class="muiTitle">
                                	<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.attachment"/>
                            	</td>
	                            <td>
	                                <c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
										<c:param name="fdKey" value="attachment" />
	                                    <c:param name="fdMulti" value="true" />
									</c:import>
	                            </td>
                        	</tr>
						</table>
					</div>
					
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  		<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext " 
				  			data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'>
				  			<bean:message bundle="km-oitems" key="button.next"/>
				  		</li>
					</ul>
				</div>
				<!-- 权限机制 -->
				<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" />
				</c:import>
				<!-- 流程机制 -->		
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
					<c:param name="fdKey" value="kmOitemsTemplet" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="commitMethod();" />
				</c:import>
				<script type="text/javascript">
					require(["mui/form/ajax-form!kmOitemsBudgerApplicationForm"]);
					require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
					         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'dojo/on', 'dojo/touch'], function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, on, touch){
						var selectOitemTips = null;
						//校验对象
						var validorObj=null;
						ready(function(){
							// 填充流程信息（临时解决方案）
							query('input[name="sysWfBusinessForm.fdParameterJson"]')[0].value = '${kmOitemsBudgerApplicationForm.sysWfBusinessForm.fdParameterJson}';
							selectOitemTips = dom.byId('selectOitemTips');
							validorObj = registry.byId('scrollView');
							
						});
						topic.subscribe('km/oitems/oitemselector/result', function(res){
							
							if(Object.prototype.toString.call(res) == '[object Array]') {
								topic.publish('km/oitems/selectedoitem/res', res);
							} else {
								topic.publish('km/oitems/selectedoitem/add', res);
							}
							domStyle.set(selectOitemTips, 'display', 'none');
						});
						/*************** 提交表单 ***************/
						window.commitMethod = function(){
							var method = Com_GetUrlParameter(location.href,'method');
							var status = document.getElementsByName("docStatus")[0];
							status.value='20';
							if(method=='add4m'){
								Com_Submit(document.forms[0],'save');
							}else{
								Com_Submit(document.forms[0],'update');
							}
						};
						
					});
				</script>
			</div>		
		</html:form>
	</template:replace>
</template:include>