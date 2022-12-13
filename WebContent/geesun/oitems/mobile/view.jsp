<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ArrayUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.geesun.oitems.forms.GeesunOitemsShoppingTrolleyForm"%>
<%@page import="com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="loading">
		<c:import url="/geesun/oitems/mobile/view_banner.jsp" charEncoding="UTF-8">
			<c:param name="formBeanName" value="geesunOitemsBudgerApplicationForm"></c:param>
			<c:param name="loading" value="true"></c:param>
		</c:import>
	</template:replace>
	<template:replace name="title">
		<c:out value="${geesunOitemsBudgerApplicationForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
	   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/geesun/oitems/mobile/resource/css/cardlist.css?s_cache=${MUI_Cache}"></link>
	  <script type="text/javascript">
	   	require(["dojo/store/Memory","dojo/topic"],function(Memory, topic){
	   		window._narStore = new Memory({data:[{'text':'<bean:message bundle="sys-mobile" key="mui.mobile.info" />',
	   			'moveTo':'_contentView','selected':true},{'text':'<bean:message bundle="sys-mobile" key="mui.mobile.review.record" />',
	   			'moveTo':'_noteView'}]});
	   		topic.subscribe("/mui/navitem/_selected",function(evtObj){
	   			setTimeout(function(){topic.publish("/mui/list/resize");},150);
	   		});
	   	});
	   </script>
	</template:replace>
	<template:replace name="content">

			<div id="scrollView" data-dojo-type="mui/view/DocScrollableView">
			<c:import url="/geesun/oitems/mobile/view_banner.jsp"
				charEncoding="UTF-8">
				<c:param name="formBeanName" value="geesunOitemsBudgerApplicationForm"></c:param>
			</c:import>

			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem">
					<div data-dojo-type="mui/nav/NavBarStore"
						data-dojo-props="store:_narStore"></div>
				</div>
			</div>
			<div data-dojo-type="dojox/mobile/View" id="_contentView">
				<div data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
					<div data-dojo-type="mui/panel/Content"
						data-dojo-props="title:'<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.baseInfo"/>',icon:'mui-ul'">
						<div class="muiFormContent">
							<table class="muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="muiTitle"><bean:message bundle="geesun-oitems"
											key="geesunOitemsBudgerApplication.docSubject" /></td>
									<td><c:out
											value="${geesunOitemsBudgerApplicationForm.docSubject}"></c:out>
									</td>
								</tr>
								<tr>
									<td class="muiTitle"><c:if
											test="${geesunOitemsTempletForm.fdTempletType=='1'}">
											<bean:message bundle="geesun-oitems"
												key="geesunOitemsBudgerApplication.fdApplicants.deptId" />
										</c:if> <c:if test="${geesunOitemsTempletForm.fdTempletType!='1'}">
											<bean:message bundle="geesun-oitems"
												key="geesunOitemsBudgerApplication.fdApplicantsId" />
										</c:if></td>
									<td><c:out
											value="${geesunOitemsBudgerApplicationForm.fdApplicantsName}" />
									</td>
								</tr>
								<c:if test="${geesunOitemsTempletForm.fdTempletType!='1'}">
									<tr>
										<td class="muiTitle"><bean:message bundle="geesun-oitems"
												key="geesunOitemsBudgerApplication.creator.dept" /></td>
										<td><c:out
												value="${geesunOitemsBudgerApplicationForm.docDeptName}" /></td>
									</tr>
								</c:if>
								<tr>
									<td class="muiTitle"><bean:message bundle="geesun-oitems"
											key="geesunOitemsBudgerApplication.fdReason" /></td>
									<td style="vertical-align: middle;"><kmss:showText
											value="${geesunOitemsBudgerApplicationForm.fdReason}" /></td>
								</tr>
								<tr>
									<td class="muiTitle"><bean:message bundle="geesun-oitems"
											key="geesunOitemsBudgerApplication.fdDesc" /></td>
									<td style="vertical-align: middle;"><kmss:showText
											value="${geesunOitemsBudgerApplicationForm.fdDesc}" /></td>
								</tr>
							</table>
						</div>
					</div>
					<c:if
						test="${not empty geesunOitemsBudgerApplicationForm.attachmentForms['attachment'].attachments}">
						<c:import url="/sys/attachment/mobile/import/view.jsp"
							charEncoding="UTF-8">
							<c:param name="fdKey" value="attachment" />
							<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
							<c:param name="fdModelId" value="${param.fdId }" />
							<c:param name="fdModelName"
								value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
						</c:import>
					</c:if>
					<div data-dojo-type="mui/panel/Content"
						data-dojo-props="title:'<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.detail"/>',icon:'mui-ul'"
						style="padding: 10px;">
						<%
					 IGeesunOitemsListingService geesunOitemsListingService= (IGeesunOitemsListingService)SpringBeanUtil.getBean("geesunOitemsListingService");
					%>
						<section class="muiApplyItem">
							<div class="attachContent">
								<ul class="mblEdgeToEdgeList muiShoppingTrolleyList">
									<c:forEach
										items="${geesunOitemsBudgerApplicationForm.geesunOitemsShoppingTrolleyFormList}"
										var="geesunOitemsShoppingTrolleyForm" varStatus="vstatus">
										<li><a>
												<div class="applyCardIcon">
													<span> <%  Object basedocObj = pageContext.getAttribute("geesunOitemsShoppingTrolleyForm");
										   if(basedocObj != null) { 
											   GeesunOitemsShoppingTrolleyForm geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolleyForm)basedocObj;
											   String ids = geesunOitemsListingService.getPicIdsByListingId(geesunOitemsShoppingTrolley.getFdListingId());
											    String imgUrl="";
												if(StringUtil.isNotNull(ids)){
													imgUrl = request.getContextPath()+"/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId="+ids.split(";")[0];
												}else{
													imgUrl = request.getContextPath()+"/geesun/oitems/mobile/resource/images/defaulthead.jpg";
												}
												out.print("<img src='"+imgUrl+"'/>");
											}
								         %>
													</span>
												</div>
												<div class="applyCardInfo">
													<div>
														<h3 class="">
															<c:out value="${geesunOitemsShoppingTrolleyForm.fdName }" />
														</h3>
														<span class="price"> <em> ¥ <c:choose>
																	<c:when
																		test="${not empty geesunOitemsShoppingTrolleyForm.fdReferencePrice}">
																		<kmss:showNumber
																			value="${geesunOitemsShoppingTrolleyForm.fdReferencePrice}" />
																	</c:when>
																	<c:otherwise>0</c:otherwise>
																</c:choose>
														</em> <c:if
																test="${not empty geesunOitemsShoppingTrolleyForm.fdUnit }">
									        /<c:out value="${geesunOitemsShoppingTrolleyForm.fdUnit }" />
															</c:if>
														</span>
													</div>
													<div class="applyDetail">
														<div class="code">
															<span>
																<div class="num">
																	<span><i class="mui mui-assetCode"></i>
																	<c:out value="${geesunOitemsShoppingTrolleyForm.fdNo}" /></span>
																</div>
															</span>
														</div>
														<div class="num">
															<span>x
																${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}</span>
														</div>
													</div>
												</div>
										</a></li>
									</c:forEach>
								</ul>
							</div>
						</section>
						<div style="text-align: right">
							<span style="font-size: 12px"><bean:message
									bundle="geesun-oitems"
									key="geesunOitemsBudgerApplication.fdTotalAmount" />： ¥</span>
							<kmss:showNumber
								value="${geesunOitemsBudgerApplicationForm.fdTotalAmount}"
								pattern="###,##0.00" />
						</div>
					</div>
				</div>
			</div>
			<div data-dojo-type="dojox/mobile/View" id="_noteView">
				<div class="muiFormContent muiFlowInfoW">
					<c:import
						url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp"
						charEncoding="UTF-8">
						<c:param name="fdModelId"
							value="${geesunOitemsBudgerApplicationForm.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
						<c:param name="formBeanName" value="geesunOitemsBudgerApplicationForm" />
					</c:import>
				</div>
			</div>

			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp"
				editUrl="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=edit&fdId=${param.fdId}"
				formName="geesunOitemsBudgerApplicationForm" viewName="lbpmView"
				allowReview="true">
				<template:replace name="flowArea">
					<c:import url="/sys/relation/mobile/import/view.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
						<c:param name="showOption" value="label"></c:param>
					</c:import>
				</template:replace>
				<template:replace name="publishArea">
		    		<c:if test="${geesunOitemsBudgerApplicationForm.docStatus == '30'}">
	    				<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=receive&fdId=${param.fdId}&type=${param.type}" requestMethod="GET">
	    					<li class="muiBtnNext" data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="colSize:2" onclick="Receive();">
	    						<bean:message key="geesunOitems.button.receive" bundle="geesun-oitems"/>
	    					</li>
	    				</kmss:auth>
	    			</c:if>
		    	</template:replace>
			</template:include>
		</div>
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/lding">
			<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
			</c:import>
		</kmss:ifModuleExist>
		<!-- 钉钉图标 end -->
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
			<c:param name="fdKey" value="geesunOitemsTemplet" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
		</c:import>
	</template:replace>
</template:include>
<script type="text/javascript">
	require(['dojo/topic', 'mui/dialog/Confirm', 'dojo/_base/lang', 'dojo/request', 'mui/util', 'mui/dialog/Tip'],function(topic, Confirm, lang, request, util, Tip){
		window.Receive = function(){
			Confirm('<span><bean:message bundle="geesun-oitems" key="geesunOitems.receive.message" /></span>', '', function(check, d) {
				if(!check) {
					return;
				}
				
				var processTip = Tip.processing('<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.checkListing"/>');
				request('${LUI_ContextPath}/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=checkListing', {
					method: 'post',
					data: {
						fdId: '${param.fdId}', 
					}
				}).then(function(data){
					processTip.hide();
					var results =  eval("("+data+")");
					if(results['isMore'] == 'false'){
	    		    	Tip.fail({
							text: results['names']+" "+"${lfn:message('geesun-oitems:geesunOitemsShoppingTrolley.fdApplicationNumberRunout')}"
						});
	    			}else{
	    				request('${LUI_ContextPath}/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=receive&fdId=${JsParam.fdId}', {
	    					method: 'get'
	    				}).then(function(data){
	    					Tip.success({
	    						text: '<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.receive.success"/>'
	    					});
	    					setTimeout(function() {
	    						location.reload();
	    					},200);
	    				});
    	    		}
				}, function(err) {
					processTip.hide();
					
					Tip.fail({
						text: '<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.receive.failure"/>'
					});
					
				});
			}, false, function() {
			
			});
		}
	});
</script>
