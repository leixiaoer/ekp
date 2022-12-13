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
			<c:out value="${ kmSuperviseMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
			<%-- <xform:text property="docCreateTime" showStatus="noShow"></xform:text> --%>
			<div class="muiTaskInfoBanner">
			
				<%-- 进度 --%>
				<div class="progress">
					<%-- <div class="pie_left">
						<div class="left"></div>
					</div>
					<div class="pie_right">
						<div class="right" style="transform: rotate(86.4deg);"></div>
					</div>
					<div class="mask"><span>${kmSuperviseMainForm.fdSuperviseProgress}</span>%</div> --%>
				</div>
				
				<dl class="txtInfoBar">
					<dt>
						<%--督办名称--%>
						<xform:text property="docSubject"></xform:text>
					</dt>
					<dd>
						<!-- <i class="mui mui-meeting_date"></i> -->
						<xform:datetime property="fdApprovalTime" dateTimeType="datetime"></xform:datetime>~
						<xform:datetime property="fdFinishTime" dateTimeType="datetime"></xform:datetime>
					</dd>
				</dl>
			</div>
			
			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem">
					<%--切换页签--%>
					<div class="muiHeader">
						<div
							data-dojo-type="mui/nav/MobileCfgNavBar" 
							data-dojo-props="defaultUrl:'/km/supervise/mobile/view_nav.jsp?docStatus=${kmSuperviseMainForm.docStatus }' ">
						</div>
					</div>
				</div>
			</div>
			
			<%--督办内容--%>
			<div id="contentView" data-dojo-type="dojox/mobile/View">
			
			<div data-dojo-type="mui/panel/AccordionPanel">
					<div class="muiFormContent muiFlowInfoW">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.docNumber')}
								</td>
								<td>
									<xform:text property="docNumber"></xform:text>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdLead')}
								</td>
								<td>
									<xform:address propertyName="fdLeadName" propertyId="fdLeadId" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdUnit')}
								</td>
								<td>
									<xform:address propertyName="fdUnitName" propertyId="fdUnitId" mobile="true"/>
								</td>
							</tr>							
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdSponsor')}
								</td><td>
									<xform:address propertyName="fdSponsorName" propertyId="fdSponsorId" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdResponsible')}
								</td><td>
									<xform:address propertyName="fdResponsibleName" propertyId="fdResponsibleId" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdRecipients')}
								</td>
								<td>
									<xform:address propertyName="fdRecipientNames" propertyId="fdRecipientIds" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdApprovalTime')}
								</td>
								<td>
				                   	<xform:datetime property="fdApprovalTime" dateTimeType="dateTime" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}
								</td><td>
									<xform:datetime property="fdFinishTime" dateTimeType="dateTime" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdContent')}
								</td><td>
									<xform:textarea property="fdContent" showStatus="view" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.attSupervise')}
								</td>
								<td>
									<c:import
										url="/sys/attachment/mobile/import/view.jsp"
										charEncoding="UTF-8">
										<c:param name="formName" value="kmSuperviseMainForm"></c:param>
										<c:param name="fdKey" value="attSupervise" />
										<c:param name="fdMulti" value="true" />
									</c:import>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdLevel')}
								</td><td>
								   <xform:select property="fdLevelId" showStatus="view">
                                        <xform:beanDataSource serviceBean="kmSuperviseLevelService" selectBlock="fdId,fdName" />
                                    </xform:select>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseMain.fdUrgency')}
								</td><td>
									 <xform:select property="fdUrgencyId" showStatus="view">
                                        <xform:beanDataSource serviceBean="kmSuperviseUrgencyService" selectBlock="fdId,fdName" />
                                    </xform:select>
								</td>
							</tr>
						
							 <c:if test="${not empty kmSuperviseMainForm.fdModelId}">
		                       	<tr>
		                          <td class="muiTitle">
		                              ${lfn:message('km-supervise:kmSuperviseMain.source')}
		                          </td>
		                          <td>
		                                <a href="<c:url value="${kmSuperviseMainForm.fdSourceUrl}"/>" target="_blank">${kmSuperviseMainForm.fdSourceSubject}</a>
		                          </td>
		                      	</tr>
	                      	</c:if>
	                      	
	                      	<tr>
	                      	<!-- <td>表单属性</td> -->
		                      	<td colspan="2">
		                      		<div data-dojo-type="dojox/mobile/View" id="_contentView">
										<c:if test="${kmSuperviseMainForm.docUseXform == 'false'}">
											<div class="muiFormContent">
												<xform:rtf property="docXform" mobile="true"></xform:rtf>
											</div>
										</c:if>
										<c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
											<div data-dojo-type="mui/table/ScrollableHContainer">
												<div data-dojo-type="mui/table/ScrollableHView" class="muiFormContent">
													<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
														charEncoding="UTF-8">
														<c:param name="formName" value="kmSuperviseMainForm" />
		                               					<c:param name="fdKey" value="kmSuperviseMain" />
														<c:param name="backTo" value="scrollView" />
													</c:import>
												</div>
											</div>
										</c:if>
									</div>
								</td>
							</tr>

						</table>
						
				</div>
				
			</div>
				
			</div>
			
			<%--督办计划--%>
			<kmss:authShow roles="ROLE_SYSTASK_DEFAULT">
			<div id="planView" data-dojo-type="dojox/mobile/View">
				<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addTask&fdId=${param.fdId}">
					<c:if test="${kmSuperviseMainForm.docStatus=='30'}">
						<ul data-dojo-type="sys/task/mobile/resource/js/OverflowTabBar" style="height: auto;">
							<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnFeedback" 
								data-dojo-props="icon:'mui mui-plus',colSize:2,href:'javascript:addTask();'">${lfn:message('km-supervise:py.RenWuZhiPai')}</li>
						</ul>
					</c:if>
				</kmss:auth>
				
			    <ul data-dojo-type="km/supervise/mobile/resource/js/list/SupervisePlanJsonStoreList" 
			    	data-dojo-mixins="km/supervise/mobile/resource/js/list/SupervisePlanItemListMixin"
			    	data-dojo-props="url:'/sys/task/sys_task_main/sysTaskIndex.do?method=list&orderby=docCreateTime&ordertype=down&fdModelId=${kmSuperviseMainForm.fdId }'">
				</ul>
			</div>
			</kmss:authShow>
			
			<%--反馈页签--%>
			<div id="feedbackView"  data-dojo-type="dojox/mobile/View">
				<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback&fdMainId=${param.fdId}">
					<c:if test="${kmSuperviseMainForm.docStatus=='30'}">
						<ul data-dojo-type="sys/task/mobile/resource/js/OverflowTabBar"  style="height: auto;">
							<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnFeedback"
								data-dojo-props="icon:'mui mui-plus',colSize:2,href:'javascript:addFeedback();'">${lfn:message('km-supervise:py.XinZengFanKui')}</li>
						</ul>
					</c:if>
				</kmss:auth>
				
			    <ul data-dojo-type="km/supervise/mobile/resource/js/list/FeedbackJsonStoreList" 
			    	data-dojo-mixins="km/supervise/mobile/resource/js/list/FeedbackItemListMixin"
			    	data-dojo-props="url:'/km/supervise/km_supervise_back/kmSuperviseBack.do?method=data&fdSuperviseId=${kmSuperviseMainForm.fdId }'">
				</ul>
			</div>
			
			<%--流程记录--%>
			<div data-dojo-type="dojox/mobile/View" id="folwView">
				<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
					<c:param name="fdModelId" value="${kmSuperviseMainForm.fdId }"/>
					<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain"/>
					<c:param name="formBeanName" value="kmSuperviseMainForm"/>
				</c:import>
			</div>
			
			<!-- 督办点评 -->
			<div style="display: none;" id="eval_formData">
				<input type="hidden" name="fdId" value="${kmSuperviseMainForm.fdId }"/> 
				<input type="hidden" name="fdFinishLevel" value="4" /> 
			</div>
			
			<c:choose>
			<c:when test="${kmSuperviseMainForm.docStatus >= '30' }">
			<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
				<c:if test="${kmSuperviseMainForm.docStatus=='30' && kmSuperviseMainForm.docStatus!='40' && kmSuperviseMainForm.docStatus!='50'}">
					<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFinish&fdId=${param.fdId}">
						<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-mixins="km/supervise/mobile/resource/js/_FinishTabBarButtonMixin"
							data-dojo-props="fdId:'${param.fdId}'">${lfn:message('km-supervise:mobile.view.finish')}</li>
					</kmss:auth>
					<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddRepeal&fdId=${param.fdId}">
						<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-mixins="km/supervise/mobile/resource/js/_RepealTabBarButtonMixin"
							data-dojo-props="fdId:'${param.fdId}'">${lfn:message('km-supervise:mobile.view.repeal')}</li>
					</kmss:auth>
				</c:if>
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddRemark&fdId=${param.fdId}">
					<c:if test="${kmSuperviseMainForm.docStatus=='40' && kmSuperviseMainForm.fdRemarkStatus!='1' }">
						<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-mixins="km/supervise/mobile/resource/js/_RemarkTabBarButtonMixin"
							data-dojo-props="fdId:'${param.fdId}'">${lfn:message('km-supervise:mobile.view.DuBanKaoPing')}</li>
					</c:if>
				</kmss:auth>
				<li data-dojo-type="mui/tabbar/TabBarButton"
					data-dojo-mixins="km/supervise/mobile/resource/js/_AttentionTabBarButtonMixin"
					data-dojo-props="label:'${lfn:message('km-supervise:py.GuanZhu')}',fdId:'${param.fdId}',hasAttention:${kmSuperviseMainForm.isConcern }"></li>
			 </ul>
			 </c:when>
			 <c:when test="${kmSuperviseMainForm.docStatus < '30' }">
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
	         "mui/util",
	         ],function(array,query,locale,date,ready,topic,registry,domGeometry,request,Tip,TransitionEvent,RtfResizeUtil,domConstruct,domStyle,util){
		
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
		
		
		ready(function(){
			var fdSuperviseProgress = '${kmSuperviseMainForm.fdSuperviseProgress}';
			buildProgress(fdSuperviseProgress);
		});
		
		function buildProgress(progress){
			if(progress == null || progress == ""){
				progress = "0";
			}
			var containerNode = query('.muiTaskInfoBanner .progress')[0];
			progress=progress.replace('%','');
			//角度=360度*progress/100
			var deg=(18*parseInt(progress)/5);
			var pie_left=domConstruct.create("div",{className:"pie_left"},containerNode);
			var left=domConstruct.create("div",{className:"left"},pie_left);
			if(deg > 180){
				var _deg=deg-180;
				domStyle.set(left,'transform','rotate('+_deg+'deg)');
				domStyle.set(left,'-webkit-transform','rotate('+_deg+'deg)');
			}
			var pie_right=domConstruct.create("div",{className:"pie_right"},containerNode);
			var right=domConstruct.create("div",{className:"right"},pie_right);
			if(deg < 180){
				domStyle.set(right,'transform','rotate('+deg+'deg)');
				domStyle.set(right,'-webkit-transform','rotate('+deg+'deg)');
			}else{
				domStyle.set(right,'transform','rotate(180deg)');
				domStyle.set(right,'-webkit-transform','rotate(180deg)');
			}
			var mask=domConstruct.create("div",{className:"mask",innerHTML:'%'},containerNode);
			var span=domConstruct.create("span",{innerHTML:progress});
			domConstruct.place(span,mask,'first');
		}
		
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
		
		
		//督办任务
		window.addTask = function(){
			var fdId = '${kmSuperviseMainForm.fdId}';
			var url = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addTaskPage";
			location.href = util.formatUrl(util.setUrlParameter(url, "fdId", fdId));
		}
		
		//督办反馈
		window.addFeedback = function(){
			var fdId = '${kmSuperviseMainForm.fdId}';
			var url = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback";
			location.href = util.formatUrl(util.setUrlParameter(url, "fdMainId", fdId));
		}
		
	});

</script>