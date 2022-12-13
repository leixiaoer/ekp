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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/primarycss.css?s_cache=${MUI_Cache}"></link>
		<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/allSupervision.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="title">
			<c:out value="${ kmSuperviseMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
			<div class="lui_asc_item" >
               	<div class="lui_asc_item_title">
                 	<span style="word-break: break-all;">${kmSuperviseMainForm.docSubject}</span>
                 	<c:if test="${kmSuperviseMainForm.fdStatus eq '10'}">
						<c:choose>
							<c:when test="${kmSuperviseMainForm.isSoonStart}">
								<span class="lui_asc_item_notice">
	                  				<kmss:message bundle="km-supervise" key="enums.status.soon.start" />
	                  			</span>
							</c:when>
							<c:otherwise>
								<span class="lui_asc_item_notice">
	                  				<kmss:message bundle="km-supervise" key="enums.status.normal" />
	                  			</span>
							</c:otherwise>
						</c:choose>
				    </c:if>
				    <c:if test="${kmSuperviseMainForm.fdStatus eq '20'}">
				    	<span class="lui_asc_item_notice warning">
               				<kmss:message bundle="km-supervise" key="enums.status.soon.delay" />
               			</span>
				    </c:if>
				    <c:if test="${kmSuperviseMainForm.fdStatus eq '30'}">
				    	<span class="lui_asc_item_notice warning">
               				<kmss:message bundle="km-supervise" key="enums.status.delay" />
               			</span>
				    </c:if>
				    <c:if test="${kmSuperviseMainForm.fdStatus eq '40'}">
				    	<span class="lui_asc_item_notice">
               				<kmss:message bundle="km-supervise" key="enums.status.finish" />
               			</span>
				    </c:if>
				    <c:if test="${kmSuperviseMainForm.fdStatus eq '50'}">
				    	<span class="lui_asc_item_notice">
                 				<kmss:message bundle="km-supervise" key="enums.status.stop" />
                 			</span>
				    </c:if>
				    <c:if test="${kmSuperviseMainForm.fdStatus eq '60'}">
				    	<span class="lui_asc_item_notice">
                 				<kmss:message bundle="km-supervise" key="enums.status.change" />
                 			</span>
				    </c:if>
               	</div>
				<div class="lui_asc_item_detail">
			  		<span>${kmSuperviseMainForm.fdContent}</span>
				</div>
               	<div id="simpleInfo" class="lui_asc_item_arr" onclick="showMoreInfo(true)">
            	</div>
               	<div id="moreInfo" style="display:none;">
	               	<div class="lui_asc_item_text">
	                  	<span><kmss:message bundle="km-supervise" key="mobile.main.plan.time" />： </span>
	                  	<span>${kmSuperviseMainForm.fdStartTime} ~ ${kmSuperviseMainForm.fdFinishTime}</span>
	                </div>
	               	<div class="lui_asc_item_text">
	                 		<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.docTemplateName" />：</span>
	                 		<span>${kmSuperviseMainForm.docTemplateName }</span>
	               	</div>
	               	<c:if test="${kmSuperviseMainForm.fdModelId != null && kmSuperviseMainForm.fdModelName != null}">
		                <div class="lui_asc_item_text">
		                  	<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.source" />：</span>
		                  	<span><a href="<c:url value="${kmSuperviseMainForm.fdSourceUrl}"/>" target="_blank">${kmSuperviseMainForm.fdSourceSubject}</a></span>
		                </div>
	                </c:if>
	                <c:choose>
		            	<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true'}">
			                <c:if test="${kmSuperviseMainForm.fdSysUnitId != null && kmSuperviseMainForm.fdSysUnitName != null}">
				                <div class="lui_asc_item_text">
				                  	<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit" />：</span>
				                  	<span>${kmSuperviseMainForm.fdSysUnitName}</span>
				                </div>
			                </c:if>
	                	</c:when>
                  		<c:otherwise>
                  			<c:if test="${kmSuperviseMainForm.fdUnitId != null && kmSuperviseMainForm.fdUnitName != null}">
				                <div class="lui_asc_item_text">
				                  	<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit" />：</span>
				                  	<span>${kmSuperviseMainForm.fdUnitName}</span>
				                </div>
			                </c:if>
                  		</c:otherwise>
		            </c:choose>
	                <c:if test="${kmSuperviseMainForm.fdSponsorId != null && kmSuperviseMainForm.fdSponsorName != null}">
		                <div class="lui_asc_item_text">
		                  	<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.fdSponsor" />：</span>
		                  	<span>${kmSuperviseMainForm.fdSponsorName}</span>
		                </div>
	                </c:if>
	                <c:if test="${kmSuperviseMainForm.fdLeadIds != null && kmSuperviseMainForm.fdLeadNames != null}">
		                <div class="lui_asc_item_text">
		                  	<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.fdLeads" />：</span>
		                  	<span>${kmSuperviseMainForm.fdLeadNames}</span>
		                </div>
	                </c:if>
	                <c:choose>
		            	<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true'}">
			                <c:if test="${kmSuperviseMainForm.fdOtherUnitIds != null && kmSuperviseMainForm.fdOtherUnitNames != null}">
				                <div class="lui_asc_item_text">
				                  	<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.fdOtherUnits" />：</span>
				                  	<span>${kmSuperviseMainForm.fdOtherUnitNames}</span>
				                </div>
			                </c:if>
	                	</c:when>
		                <c:otherwise>
		                	<c:if test="${kmSuperviseMainForm.fdOUnitIds != null && kmSuperviseMainForm.fdOUnitNames != null}">
				                <div class="lui_asc_item_text">
				                  	<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.fdOtherUnits" />：</span>
				                  	<span>${kmSuperviseMainForm.fdOUnitNames}</span>
				                </div>
			                </c:if>
		                </c:otherwise>
	                </c:choose>
	       			<c:if test="${kmSuperviseMainForm.fdApprovalTime != null }">         
		                <div class="lui_asc_item_text">
		                  	<span><kmss:message bundle="km-supervise" key="kmSuperviseMain.fdApprovalTime" />：</span>
		                  	<span>${kmSuperviseMainForm.fdApprovalTime}</span>
		                </div>
	                </c:if>
	                <div class="lui_asc_item_arr lui_asc_item_arr_active" onclick="showMoreInfo(false)">
            		</div>
                </div>
            	
            </div>

			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem">
					<%--切换页签--%>
					<div class="muiHeader">
						<div
							data-dojo-type="mui/nav/MobileCfgNavBar" 
							data-dojo-props="defaultUrl:'/km/supervise/mobile/view_nav_new_publish.jsp?tabIndex=${JsParam.tabIndex }' ">
						</div>
					</div>
				</div>
			</div>
			
			<%--督办计划及反馈--%>
			<div id="planAndBackView" class="lui_asc_tab" data-dojo-type="dojox/mobile/View">
				<div class="lui_asc_box">
	              	<!-- 反馈情况一览表 -->
			    	<ul class="ekp-ledger-nav-list" style="border-bottom:1px solid #e2e2e2">
				      	<li onclick="window.open('${LUI_ContextPath}/km/supervise/mobile/situation_view.jsp?fdMainId=${kmSuperviseMainForm.fdId}','_self');this.style.backgroundColor='rgba(255,255,255,.125)';" style="padding-left:2rem">
				        	<div class="ekp-ledger-nav-caption">
				          		<h4 class="ekp-ledger-nav-caption-title"><bean:message key="mobile.backSituationView" bundle="km-supervise"/></h4>
				        	</div>
				        	<i class="mui mui-forward"></i>
				      	</li>
			    	</ul>
				    <div class="lui_asc_list" data-dojo-type="km/supervise/mobile/resource/js/list/SupervisePlanJsonStoreList" 
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/PlanAndBackItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_task/kmSuperviseTask.do?method=data&orderby=fdPlanStartTime&ordertype=up&fdMainId=${kmSuperviseMainForm.fdId}'">
					</div>
					<!--附件-->
					<c:if test="${kmSuperviseMainForm.fdBackType != null}">
						<div class="lui_text_Att">
							<span><bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>：</span>
							<span>
						<c:choose>
							<c:when test="${kmSuperviseMainForm.fdBackType eq '0'}">
								<bean:message bundle="km-supervise" key="enums.task.back.default"/>
							</c:when>
							<c:when test="${kmSuperviseMainForm.fdBackType eq '1'}">
								<bean:message bundle="km-supervise" key="enums.task.back.week"/>
							</c:when>
							<c:when test="${kmSuperviseMainForm.fdBackType eq '2'}">
								<bean:message bundle="km-supervise" key="enums.task.back.double.week"/>
							</c:when>
							<c:when test="${kmSuperviseMainForm.fdBackType eq '3'}">
								<bean:message bundle="km-supervise" key="enums.task.back.month"/>
							</c:when>
							<c:when test="${kmSuperviseMainForm.fdBackType eq '4'}">
								<bean:message bundle="km-supervise" key="enums.task.back.three.month"/>
							</c:when>
							<c:when test="${kmSuperviseMainForm.fdBackType eq '5'}">
								<bean:message bundle="km-supervise" key="enums.task.back.year"/>
							</c:when>
						</c:choose>
						</span>
						</div>
					</c:if>
					<div class="lui_text_Att">
						<span><bean:message bundle="km-supervise" key="py.FuJian"/>：</span>
						<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmSuperviseMainForm"></c:param>
							<c:param name="fdKey" value="attTask" />
							<c:param name="fdMulti" value="true" />
							<c:param name="fdViewType" value="simple"/>
						</c:import>
					</div>
				</div>
			</div>
			
			<!-- 领导批示 -->
			<div class="lui_asc_approve" id="instructionView" data-dojo-type="dojox/mobile/View">
				<div class="lui_asc_box">
					<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddInstruction&fdId=${kmSuperviseMainForm.fdId}" requestMethod="GET">
	                <div class="lui_asc_item">
	                  <div class="lui_asc_item_title">
	                    <div class="lui_asc_item_textarea">
	                      <textarea placeholder="${lfn:message('km-supervise:mobile.main.enter.instruction') }" name="fdInstructionDesc"cols="20" rows="3"></textarea>
	                      <span style="color:red">*</span>
	                    </div>
	                    <div id="desc_err_info" style="display: none; color: red;font-size: 14px;">${lfn:message('km-supervise:mobile.main.enter.instruction') }</div>
	                    <div class="lui_asc_item_btn" onclick="submitInstruction()"><bean:message key="button.update"/></div>
	                  </div>
	                </div>
	                </kmss:auth>
					
				    <div id="instructionList" data-dojo-type="km/supervise/mobile/resource/js/list/SuperviseInstructionJsonStoreList" 
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/InstructionItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=data&orderby=docCreateTime&ordertype=down&fdType=0&fdMainId=${kmSuperviseMainForm.fdId}'">
					</div>
				</div>
			</div>
			<!-- 督办留言 -->
			<div class="lui_asc_approve" id="instructionViewMsg" data-dojo-type="dojox/mobile/View">
				<div class="lui_asc_box">
					<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddInstruction&fdId=${kmSuperviseMainForm.fdId}" requestMethod="GET">
						<div class="lui_asc_item">
							<div class="lui_asc_item_title">
								<div class="lui_asc_item_textarea">
									<textarea placeholder="${lfn:message('km-supervise:mobile.main.enter.instruction.msg') }" name="fdInstructionDescMsg"cols="20" rows="3"></textarea>
									<span style="color:red">*</span>
								</div>
								<div id="desc_err_info_msg" style="display: none; color: red;font-size: 14px;">${lfn:message('km-supervise:mobile.main.enter.instruction.msg') }</div>
								<div class="lui_asc_item_btn" onclick="submitInstructionMsg();"><bean:message key="button.update"/></div>
							</div>
						</div>
					</kmss:auth>
					<div id="instructionListMsg" data-dojo-type="km/supervise/mobile/resource/js/list/SuperviseInstructionJsonStoreList"
						 data-dojo-mixins="km/supervise/mobile/resource/js/list/InstructionItemListMixin"
						 data-dojo-props="url:'/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=data&orderby=docCreateTime&ordertype=down&fdType=1&fdMainId=${kmSuperviseMainForm.fdId}'">
					</div>
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
			
			<%--变更记录--%>
			<div id="otherView" data-dojo-type="dojox/mobile/View">
			    <div class="lui_asc_item">
					<div class="lui_asc_item_title">
	                	<span><bean:message key="py.changeRecord" bundle="km-supervise"/></span>
	                </div>
					<ul data-dojo-type="km/supervise/mobile/resource/js/list/SuperviseOtherJsonStoreList" 
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/ChangeItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&isChange=true&showAll=true&fdOriginId=${kmSuperviseMainForm.fdId}&orderby=docCreateTime&ordertype=down',lazy:false">
					</ul>
				</div>
				<div class="lui_asc_item">
					<div class="lui_asc_item_title">
	                	<span><bean:message key="mobile.main.finish.info" bundle="km-supervise"/></span>
	                </div>
					<ul data-dojo-type="km/supervise/mobile/resource/js/list/SuperviseOtherJsonStoreList" 
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/FinishItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do?method=list&fdMainId=${kmSuperviseMainForm.fdId}',lazy:false">
					</ul>
				</div>
				<div class="lui_asc_item">
					<div class="lui_asc_item_title">
	                	<span><bean:message key="mobile.main.stop.info" bundle="km-supervise"/></span>
	                </div>
					<ul data-dojo-type="km/supervise/mobile/resource/js/list/SuperviseOtherJsonStoreList" 
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/StopItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_main_stop/kmSuperviseMainStop.do?method=list&fdMainId=${kmSuperviseMainForm.fdId}',lazy:false">
					</ul>
				</div>
				<div class="lui_asc_item">
					<div class="lui_asc_item_title">
	                	<span><bean:message key="mobile.main.remark.info" bundle="km-supervise"/></span>
	                </div>
					<ul data-dojo-type="km/supervise/mobile/resource/js/list/SuperviseOtherJsonStoreList" 
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/RemarkItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_main_remark/kmSuperviseMainRemark.do?method=data&fdSuperviseId=${kmSuperviseMainForm.fdId}&orderby=docCreateTime&ordertype=down',lazy:false">
					</ul>
				</div>
			</div>
			
			<!-- 督办点评 -->
			<div style="display: none;" id="eval_formData">
				<input type="hidden" name="fdFinishLevel" value="4" /> 
			</div>
			
			<c:choose>
				<c:when test="${kmSuperviseMainForm.docStatus == '30' }">
					 <template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
								editUrl="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=edit&fdId=${param.fdId }"
								formName="kmSuperviseMainForm"
								viewName="lbpmView"
								allowReview="true">
						<template:replace name="publishArea">
							<!-- 关注/取消关注 -->
							<li data-dojo-type="mui/tabbar/TabBarButton"
								data-dojo-mixins="km/supervise/mobile/resource/js/_AttentionTabBarButtonMixin"
								data-dojo-props="label:'<bean:message bundle="km-supervise" key="py.GuanZhu" />',fdId:'${param.fdId}',hasAttention:${kmSuperviseMainForm.isConcern }"></li>
							<c:if test="${kmSuperviseMainForm.docStatus=='30' && kmSuperviseMainForm.docStatus!='40' && kmSuperviseMainForm.docStatus!='50'}">
								<!-- 阶段反馈 -->
								<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback&fdType=1&fdMainId=${param.fdId}">
				     				<li data-dojo-type="mui/tabbar/TabBarButton"
								  		data-dojo-mixins="km/supervise/mobile/resource/js/_BackTabBarButtonMixin"
										data-dojo-props="fdId:'${param.fdId}',fdType:'1'"><bean:message bundle="km-supervise" key="py.HuiZongFanKui" /></li>
				    			</kmss:auth>
				    			<!-- 任务反馈 -->
								<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback&fdType=0&fdMainId=${param.fdId}&fdTaskId=">
				     				<li data-dojo-type="mui/tabbar/TabBarButton"
								  		data-dojo-mixins="km/supervise/mobile/resource/js/_BackTabBarButtonMixin"
										data-dojo-props="fdId:'${param.fdId}',fdType:'0'"><bean:message bundle="km-supervise" key="py.RenWuFanKui" /></li>
				    			</kmss:auth>
							</c:if>
							<c:if test="${kmSuperviseMainForm.docStatus=='30' && kmSuperviseMainForm.docStatus!='40' && kmSuperviseMainForm.docStatus!='50'}">
								<!--督办变更-->
					            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=changeSupervise&fdId=${param.fdId}">
									<c:set var="showMoreBtn" value="true"></c:set>
					            </kmss:auth>
								<!-- 办结 -->
								<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFinish&fdId=${param.fdId}">
									<c:set var="showMoreBtn" value="true"></c:set>
								</kmss:auth>
								 <!--终止-->
					            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddStop&fdId=${param.fdId}">
									<c:set var="showMoreBtn" value="true"></c:set>
					            </kmss:auth>
					            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=urgeSupervise&fdId=${param.fdId}" requestMethod="GET">
									<c:set var="showMoreBtn" value="true"></c:set>
								</kmss:auth>
							</c:if>
							<c:if test="${showMoreBtn eq true }">
								 <li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnFeedback"  id="otherListBtn" data-dojo-props="">
								 	<bean:message bundle="km-supervise" key="button.other" />
								 </li> 
							</c:if>
						</template:replace>
					</template:include>
				 </c:when>
				 <c:when test="${kmSuperviseMainForm.docStatus == '40' }">
					 <template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
								editUrl="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=edit&fdId=${param.fdId }"
								formName="kmSuperviseMainForm"
								viewName="lbpmView"
								allowReview="true">
						<template:replace name="publishArea">
							<!-- 关注/取消关注 -->
							<li data-dojo-type="mui/tabbar/TabBarButton"
								data-dojo-mixins="km/supervise/mobile/resource/js/_AttentionTabBarButtonMixin"
								data-dojo-props="label:'<bean:message bundle="km-supervise" key="py.GuanZhu" />',fdId:'${param.fdId}',hasAttention:${kmSuperviseMainForm.isConcern }"></li>
							<!-- 考评 -->
							<c:if test="${kmSuperviseMainForm.docStatus=='40' && kmSuperviseMainForm.fdRemarkStatus!='1' }">
					            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddRemark&fdId=${param.fdId}">
									<li data-dojo-type="mui/tabbar/TabBarButton"
								  		data-dojo-mixins="km/supervise/mobile/resource/js/_RemarkTabBarButtonNewMixin"
										data-dojo-props="fdId:'${param.fdId}'"><bean:message bundle="km-supervise" key="mobile.view.DuBanKaoPing" /></li>
								</kmss:auth>
							</c:if>
						</template:replace>
					</template:include>
				 </c:when>
				 <c:when test="${kmSuperviseMainForm.docStatus == '50' ||kmSuperviseMainForm.docStatus == '60'}">
					 <template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
								editUrl="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=edit&fdId=${param.fdId }"
								formName="kmSuperviseMainForm"
								viewName="lbpmView"
								allowReview="true">
						<template:replace name="publishArea">
							<!-- 关注/取消关注 -->
							<li data-dojo-type="mui/tabbar/TabBarButton"
								data-dojo-mixins="km/supervise/mobile/resource/js/_AttentionTabBarButtonMixin"
								data-dojo-props="label:'<bean:message bundle="km-supervise" key="py.GuanZhu" />',fdId:'${param.fdId}',hasAttention:${kmSuperviseMainForm.isConcern }"></li>
						</template:replace>
					</template:include>
				 </c:when>
			</c:choose>
		</div>
				
	
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmSuperviseMainForm" />
			<c:param name="fdKey" value="kmSuperviseMain" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
		</c:import>
		<c:if test="${showMoreBtn eq true }">
			<div id="kmSuperviseMain_otherBox" style="display:none;" >
	  			<div id="kmSuperviseMain_other" class="kmSuperviseMain_other">
					<ul>
						<c:if test="${kmSuperviseMainForm.docStatus=='30' && kmSuperviseMainForm.docStatus!='40' && kmSuperviseMainForm.docStatus!='50'}">
					    	<!--变更-->
				            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=changeSupervise&fdId=${param.fdId}">
				                <li data-dojo-type="mui/tabbar/TabBarButton"
							  		data-dojo-mixins="km/supervise/mobile/resource/js/_ChangeTabBarButtonMixin"
									data-dojo-props="fdId:'${param.fdId}'"><bean:message bundle="km-supervise" key="mobile.view.change" /></li>
				            </kmss:auth>
							<!-- 办结 -->
							<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFinish&fdId=${param.fdId}">
								<li data-dojo-type="mui/tabbar/TabBarButton"
							  		data-dojo-mixins="km/supervise/mobile/resource/js/_FinishTabBarButtonNewMixin"
									data-dojo-props="fdId:'${param.fdId}'"><bean:message bundle="km-supervise" key="mobile.view.finish" /></li>
							</kmss:auth>
							 <!--终止-->
				            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddStop&fdId=${param.fdId}">
				                <li data-dojo-type="mui/tabbar/TabBarButton"
							  		data-dojo-mixins="km/supervise/mobile/resource/js/_StopTabBarButtonMixin"
									data-dojo-props="fdId:'${param.fdId}'"><bean:message bundle="km-supervise" key="mobile.view.stop" /></li>
				            </kmss:auth>
				            <!-- 催办 -->
							<kmss:auth
								requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=urgeSupervise&fdId=${param.fdId}" requestMethod="GET">
								<li data-dojo-type="mui/tabbar/TabBarButton"
							  		data-dojo-mixins="km/supervise/mobile/resource/js/_UrgeTabBarButtonMixin"
									data-dojo-props="fdId:'${param.fdId}'"><bean:message bundle="km-supervise" key="py.CuiBan" /></li>
							</kmss:auth>
			            </c:if>
			 		</ul>
			 		<div class="otherDialogCancel">
						<bean:message bundle="km-supervise" key="button.cancel" />
					</div>
			 	</div>
			 </div>
		</c:if> 	
	</template:replace>
</template:include>
<script>
	require(['dojo/_base/array',
	         'dojo/query',
	         'dojo/date/locale',
	         'dojo/date',
	         'dojo/ready',
	         'dojo/topic',
	         'dijit/registry',
	         'dojo/dom-geometry',
	         'dojo/request',
	         'mui/dialog/Tip',
	         'dojox/mobile/TransitionEvent',
	         'mui/rtf/RtfResizeUtil',
	         "dojo/dom-construct",
	         "dojo/dom-style",
	         "dojo/_base/lang",
	         "mui/util",
	         'mui/dialog/Dialog',
	         "dojo/dom"
	         ],function(array,query,locale,date,ready,topic,registry,domGeometry,request,Tip,TransitionEvent,RtfResizeUtil,domConstruct,domStyle,lang,util,Dialog,dom){
		
		//切换标签重新计算高度
		var _position=domGeometry.position(query('#fixed')[0]),
			_scrollTop=0;
		topic.subscribe("/mui/list/_runSlideAnimation",function(srcObj, evt) {
			_scrollTop= Math.abs(evt.to.y);
		});
		topic.subscribe("/mui/navitem/_selected",function(){
			var view=registry.byId("scrollView"),
				evt={ y: 0 - _scrollTop };
			if(_scrollTop > _position.y){
				evt={y: 0 -  _position.y };
			}
			view.handleToTopTopic(null,evt);
		});
		
		//切换标签时resize rtf中的表格
		var hasResize=false;
		topic.subscribe("/mui/navitem/_selected",function(widget,args){
			var feedbackView=registry.byId("feedbackView");
			if(!hasResize  && widget.moveTo=='feedbackView'  ){
				hasResize=true;
				setTimeout(function(){
					var arr=query('#feedbackView .content');
					array.forEach(arr,function(item){
						new RtfResizeUtil({
							channel:item.id,
							containerNode:item
						});
					});
				},1);
			}
		});
		
		ready(function(){
			//添加点击事件
			window.addClick();
			
			// 点击更多
			window.showMore();
		});
		
		window.showMoreInfo = function(flag){
			var simple = document.getElementById("simpleInfo");
			var more = document.getElementById("moreInfo");
			if(flag == true){
				simple.style.display = "none";
				more.style.display = "block";
			}else if(flag == false){
				simple.style.display = "block";
				more.style.display = "none";
			}
		}
		
		window.showMore = function(){
			 /* 其他更多操作 */
			 var otherListBtn = dom.byId("otherListBtn");
			 if(otherListBtn){
				 var OtherList = dom.byId("kmSuperviseMain_other");
				 dom.byId("otherListBtn").onclick= function (){
						var DialogObj = new Dialog.claz({
							element:OtherList,
							scrollable:false,
							parseable:false,
							position:"bottom",
							canClose:false
						});
						DialogObj.show();
					    var dialogCancel =  query(".muiDialogElementContainer_bottom .otherDialogCancel");
						dialogCancel[0].onclick=function(){
							DialogObj.hide();
						}; 					
				  } 
			 }
		}
		
		
		window.addClick = function(){
			var submitInstruction = dom.byId("submitInstruction");
			if(submitInstruction){
				submitInstruction.dojoClick = true;
				submitInstruction.onclick = function(){
					window.submitInstruction();
				}
			}
		}
		
		
		//返回
		window.doBack=function(){
			window.open('${LUI_ContextPath}/km/supervise/mobile/index.jsp','_self');
		};
		
		//String类型转化为Date类型
		function parseDate(/*String*/ date){
			return locale.parse(date,{
				selector : 'time',
				timePattern : "${ lfn:message('date.format.datetime') }"
			});
		}
		
		//初始化页面
		function resziePage(){
			var scrollView=registry.byId('scrollView').domNode,
				dateView=registry.byId('dateView').domNode,
				labelView=registry.byId('labelView').domNode,
				notifyView=registry.byId('notifyView').domNode,
				minHeight=scrollView.offsetHeight - dateView.offsetTop;
			domStyle.set(dateView,'min-height',minHeight+'px');
			domStyle.set(labelView,'min-height',minHeight+'px');
			domStyle.set(notifyView,'min-height',minHeight+'px');
		}
		/* 提交领导批示 */
		window.submitInstruction = function(){
			var desc = document.getElementsByName("fdInstructionDesc")[0].value;
			var err = document.getElementById("desc_err_info");
			if(desc != ""){
				err.style.display = "none";
				var url = "${LUI_ContextPath}/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=saveInstruction&fdMainId=${kmSuperviseMainForm.fdId}&fdType=0";
				var processing = Tip.processing();
				var promise = request.post(
						url,
						{
							data : {
								desc:desc
							},
							timeout : 30000
						});
				promise.response.then(function(data) {
					if (data.status == 200 && data.getHeader("lui-status") == "true") {
						document.getElementsByName("fdInstructionDesc")[0].value = "";
						processing.hide();
						Tip.success({
							text : "操作成功"
						});
						//刷新批示列表数据
						reloadInstruction();
					}else
						Tip.fail({
							text : "操作失败"
						});
				});
			} else {
				err.style.display = "block";
			}
		}
		
		window.delInstruction = function(fdId){
			var url = "${LUI_ContextPath}/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=delete&fdId="+fdId;
			var delDialog = new Dialog.claz({
				'element' : '<br/><br/><div>是否确认删除？</div><br/><br/>',
				'destroyAfterClose':true,
				'closeOnClickDomNode':false,
				'scrollable' : false,
				'parseable': true,
				'position':'center',
				'buttons' : [{
					title : "${lfn:message('button.cancel')}",
					fn : function(dialog) {
						dialog.hide();
					}
				} ,{
					title : "${lfn:message('button.ok')}",
					fn : lang.hitch(this,function(dialog) {
						var processing = Tip.processing();
						var promise = request.get(url);
						promise.response.then(function(data) {
							if (data.status == 200 && data.getHeader("lui-status") == "true" ) {
								dialog.hide();
								processing.hide();
								Tip.success({
									text : "操作成功"
								});
								//刷新批示列表数据
								reloadInstruction();
							}else
								Tip.fail({
									text : "操作失败"
								});
						});
					})
				}]
			});
		}
		
		/* 提交督办留言 */
		window.submitInstructionMsg = function(){
			var desc = document.getElementsByName("fdInstructionDescMsg")[0].value;;
			var err =err = document.getElementById("desc_err_info_msg");
			if(desc != ""){
				err.style.display = "none";
				var url = "${LUI_ContextPath}/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=saveInstruction&fdMainId=${kmSuperviseMainForm.fdId}&fdType=1";
				var processing = Tip.processing();
				var promise = request.post(
						url,
						{
							data : {
								desc:desc
							},
							timeout : 30000
						});
				promise.response.then(function(data) {
					if (data.status == 200 && data.getHeader("lui-status") == "true") {
						document.getElementsByName("fdInstructionDescMsg")[0].value = "";
						processing.hide();
						Tip.success({
							text : "操作成功"
						});
						//刷新留言列表数据
						reloadInstructionMsg();
					}else
						Tip.fail({
							text : "操作失败"
						});
				});
			} else {
				err.style.display = "block";
			}
		}
		//刷新批示页面
		window.reloadInstruction = function(){
			var href=Com_GetCurDnsHost()+"${LUI_ContextPath}/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=data&orderby=docCreateTime&fdType=0&ordertype=down&fdMainId=${kmSuperviseMainForm.fdId}"
			registry.byId("instructionList").set('url',href);
			registry.byId("instructionList").reload();
		}
		//刷新督办留言的页面
		window.reloadInstructionMsg = function(){
			var href=Com_GetCurDnsHost()+"${LUI_ContextPath}/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=data&orderby=docCreateTime&ordertype=down&fdType=1&fdMainId=${kmSuperviseMainForm.fdId}"
			registry.byId("instructionListMsg").set('url',href);
			registry.byId("instructionListMsg").reload();
		}
		
		window.backSituationView = function(){
			window.open('${LUI_ContextPath}/km/supervise/mobile/situation_view.jsp?fdMainId=${kmSuperviseMainForm.fdId}','_self');
		}
	});
</script>