<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ModelUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.km.pindagate.forms.KmPindagateMainForm"%>
<%
	ISysAttMainCoreInnerService sysAttMainCoreInnerService=(ISysAttMainCoreInnerService)
			SpringBeanUtil.getBean("sysAttMainService");
	KmPindagateMainForm form=(KmPindagateMainForm)request.getAttribute("kmPindagateMainForm");
	List list=sysAttMainCoreInnerService.findByModelKey("com.landray.kmss.km.pindagate.model.KmPindagateMain",form.getFdId(),"pic");
	if(list!=null && list.size()>0){
		SysAttMain att=(SysAttMain)list.get(0);
		request.setAttribute("pictureUrl", "/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=big&fdId="+att.getFdId());
	}else{
		request.setAttribute("pictureUrl", "/km/pindagate/resource/images/pindagate_bg.jpg");
	}
%>
<template:include ref="mobile.view" >
	
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${lfn:message('km-pindagate:kmPindagate.tree.result')}"></c:out>
	</template:replace>
	
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/pindagate/mobile/resource/css/resultView.css?s_cache=${MUI_Cache}" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/sys/mobile/js/dijit/charting.js?s_cache=${MUI_Cache}"></script>
		<mui:min-file name="mui-pindagate.js"/>
		<mui:min-file name="mui-pindagate-question.js"/>
	</template:replace>
	
	<template:replace name="content">
	
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
			<%-- 基本信息 --%>
			<div id="basicInfoView">
				<section class="muiPindagateHeader">
					<div class="muiPindagateHeaderImgBox">
						<%-- 标题图片 --%>
						<img alt="" src="${LUI_ContextPath}${pictureUrl}">
						<%-- 标题 --%>
						<h4 class="muiPindagateHeaderTitle">
							<span><c:out value="${kmPindagateMainForm.docSubject}"></c:out></span>
						</h4>
					</div>
					<%-- 状态 --%>
					<div class="muiPindagateStatusBtn">
						<c:choose>
							<c:when test="${kmPindagateMainForm.docStatus=='30'}">
								${ lfn:message('km-pindagate:kmPindagate.tree.status.publish') }
							</c:when>
							<c:when test="${kmPindagateMainForm.docStatus=='31'}">
								${ lfn:message('km-pindagate:kmPindagate.tree.status.indagating') }
							</c:when>
							<c:when test="${kmPindagateMainForm.docStatus=='32'}">
								${ lfn:message('km-pindagate:kmPindagate.tree.status.complete') }
							</c:when>
						</c:choose>
					</div>
					<div class="muiPindagateHeaderTooltip">
						<%--截止日期 --%>
						<div class="muiPindagateTimeCard"></div>
						<%-- 参加人数 --%>
						<p class="muiPindagateHomePeople">
							<i class="mui mui-person"></i>
							<c:out value="${kmPindagateMainForm.fdParticipantNum }"></c:out>
							<bean:message bundle="km-pindagate" key="mobile.kmPindagateMain.person" />
						</p>
					</div>
				</section>
				<c:if test="${not empty kmPindagateMainForm.fdQuestionExplain}">
					<section class="muiPindagateHomeBody" id='fdQuestionExplainSection'>
						<%-- 问卷说明 --%>
						<p class="muiPindagateHomeTxt">
							<c:out value="${kmPindagateMainForm.fdQuestionExplain }" escapeXml="false"></c:out>
							<script type="text/javascript">
								require(['mui/rtf/RtfResize','dojo/ready'],function(Rtf,ready){
									ready(function(){
										new Rtf({
											containerNode:document.getElementById('fdQuestionExplainSection')
										});
									});
								});
							</script>
						</p>
					</section>
				</c:if>
			</div>
			
			
			<ul id="toolbar" data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
			  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit muiPindagateSubmit" 
				  	data-dojo-props='colSize:2,transition:"slide",moveTo:"statisticView"'>
				  		<i class="mui mui-survey"></i><bean:message bundle="km-pindagate" key="mobile.kmPindagateMain.statistics" />
				 </li>
			</ul>
			
		</div>
	
		<div id="statisticView" class="gray" data-dojo-type="mui/view/DocScrollableView" data-dojo-props="scrollDir:''">
			<div id="statisticList" data-dojo-type="km/pindagate/mobile/resource/js/QuestionStatisticList">
			<div class="pindagate_nav" id="statisticNav"/>
			</div>
			<script type="text/javascript">
				function kmPindagateStatictisInit(datas){
					require(["dojo/ready","dijit/registry","mui/dialog/BarTip","dojo/_base/window","dojo/query","dojo/dom-style","dojo/dom-geometry"],
							function(ready,registry,BarTip,win,query,domStyle,domGeo){
						ready(function(){
							var statisticList = registry.byId('statisticList');
							statisticList.init(datas);
							
							if("${canViewResult}" == "false"){
								var barTip = BarTip.tip({
									text: '${lfn:message("km-pindagate:kmPindagateMain.not.participation")}'
								});
								var clientHeight = win.global.innerHeight,
									tabBarHeight = domGeo.getMarginSize(query('#toolbar')[0]).h,
									tipHeight = domGeo.getMarginSize(barTip.domNode).h;
								domStyle.set(barTip.domNode,'top',clientHeight - tabBarHeight - tipHeight +'px');
							}
							
						});
					});
				}
			</script>
			<c:import url="/${kmPindagateStatistic.fdStatisticUrl}" charEncoding="UTF-8"></c:import>			
		</div>		
	</template:replace>
</template:include>