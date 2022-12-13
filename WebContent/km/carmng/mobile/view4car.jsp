<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${kmCarmngInfomationForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/mobile/css/themes/default/calendar.css?s_cache=${MUI_Cache}"></link>
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/carmng/mobile/css/view.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/mobile/css/themes/default/listview.css?s_cache=${MUI_Cache}"></link>
	</template:replace>
	<template:replace name="content">
	    <script type="text/javascript">
			Com_IncludeFile("jquery.js", null, "js");
		</script>
		<div id="scrollView" data-dojo-type="mui/view/DocScrollableView" class="gray">
		    <section class="muiCarSecHeader">
		    <%
		       String firstImgId = (String)request.getAttribute("firstImgId");
		       String firstImgUrl="";
		       if(StringUtil.isNotNull(firstImgId)){
		    	   firstImgUrl = request.getContextPath()+"/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=big&fdId="+firstImgId;
		       }else{
		    	   firstImgUrl = request.getContextPath()+"/km/carmng/mobile/js/list/item/defaulthead.jpg";
		       }
		       request.setAttribute("firstImgUrl",firstImgUrl);
		    %>
		        <div class="imgHeader">
		            <img src="${firstImgUrl}" width="100%" />
		        </div>
		        <div class="muiCarSecHeaderTool">
		            <div class="txt"><xform:text property="docSubject" mobile="true"></xform:text></div>
		            <div>
		            <c:if test="${kmCarmngInfomationForm.docStatus eq '1'}">
			            <a class="muiCarSecHeaderBtn" href="javascript:void(0);">
			              <sunbor:enumsShow enumsType = "kmCarmngInformation_status"  value="${kmCarmngInfomationForm.docStatus}"/>
			            </a>
		            </c:if>
		            <c:if test="${kmCarmngInfomationForm.docStatus eq '2'}">
			             <a class="muiCarSecHeaderBtn repair" href="javascript:void(0);">
			              <sunbor:enumsShow enumsType = "kmCarmngInformation_status"  value="${kmCarmngInfomationForm.docStatus}"/>
			             </a>
			         </c:if>
			         <c:if test="${kmCarmngInfomationForm.docStatus eq '3'}">
			             <a class="muiCarSecHeaderBtn scrap" href="javascript:void(0);">
			              <sunbor:enumsShow enumsType = "kmCarmngInformation_status"  value="${kmCarmngInfomationForm.docStatus}"/>
			             </a>
			         </c:if>
		            </div>
		        </div>
		         <ul class="muiCarInfoBox">
		            <li>
		                <span class="title"><bean:message  bundle="km-carmng" key="kmCarmngInfomation.carNo"/>&nbsp;</span>
		                <span class="txt"><c:out value="${kmCarmngInfomationForm.fdNo}"></c:out></span>
		            </li>
		            <li>
		                <span class="title"><bean:message  bundle="km-carmng" key="kmCarmngInfomation.fdSeatNumber"/>&nbsp;</span>
		                <span class="txt"><c:out value="${kmCarmngInfomationForm.fdSeatNumber}"></c:out>&nbsp;${ lfn:message('km-carmng:kmCarmngInfomation.seat') }</span>
		            </li>
		            <li>
		                <span class="title"><bean:message  bundle="km-carmng" key="kmCarmngInfomation.driver"/>&nbsp;</span>
		                <span class="txt"><c:out value="${kmCarmngInfomationForm.fdDriverName}"></c:out></span>
		            </li>
		            <li>
		                <span class="title"><bean:message  bundle="km-carmng" key="kmCarmngInfomation.phone"/>&nbsp;</span>
		                <span class="txt"><c:out value="${kmCarmngInfomationForm.fdRelationPhone}"></c:out><i class="mui mui-tel" onclick="window.location.href='tel://<c:out value="${kmCarmngInfomationForm.fdRelationPhone}"/>'"></i></span>
		            </li>
		        </ul>
		    </section>
		    <section class="muiCarSecBody">
		        <a href="javascript:void(0)" class="muiCarItem"><bean:message  bundle="km-carmng" key="kmCarmngInfomation.borrow.cycle"/></a>
		        <div class="muiCalendarContainer">
					<div id="calendar" 
						data-dojo-type="mui/calendar/CalendarView" data-dojo-props="defaultDisplay:'week',changeDisplay:false,isNotScroll:true">
						<div data-dojo-type="mui/calendar/CalendarHeader" data-dojo-props="" style="min-height:4rem"></div>
						<div data-dojo-type="mui/calendar/CalendarWeek"></div>
						<div data-dojo-type="mui/calendar/CalendarContent"></div>
						<div data-dojo-type="mui/calendar/CalendarBottom" data-dojo-props="url:''">
							<div data-dojo-type="dojox/mobile/View" style="margin-top: 80px;">
								<ul data-dojo-type="mui/calendar/CalendarJsonStoreList" class="muiCarTimeAxis"
									data-dojo-mixins="km/carmng/mobile/js/list/CalendarItemListMixin"
									data-dojo-props="url:'/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfoIndex.do?method=historyDispatch&fdStart=!{fdStart}&fdEnd=!{fdEnd}&fdCarId=${param.fdId}'">
								</ul>
							</div>
						</div>
					</div>
				</div>
		    </section>
		    
		</div>
	    <div id='dispatchInfoView' data-dojo-type="dojox/mobile/View">
		    <div class="basicInfoHeader" data-dojo-type="mui/header/Header" data-dojo-props="height:'4rem'">
				<div class="basicInfoHeaderBack" onclick="backToDocView(this)">
					<i class="mui mui-back"></i>
					<span class="personHeaderReturnTxt"><bean:message  bundle="km-carmng" key="kmCarmng.back"/></span>
				</div>
				<div class="basicInfoHeaderTitle"><bean:message  bundle="km-carmng" key="kmCarmng.history.record"/></div>
				<div></div>
			</div>
			<div data-dojo-type="mui/list/StoreScrollableView">
				<ul data-dojo-type="mui/list/JsonStoreList" id="dispatchInfo" class="muiCarTimeAxis"
	                data-dojo-mixins="km/carmng/mobile/js/list/CarInfoItemListMixin"
					data-dojo-props="url:''">
				</ul>
			</div>
		</div>
		<div id='InfringeInfoView' data-dojo-type="dojox/mobile/View">
		    <div class="basicInfoHeader" data-dojo-type="mui/header/Header" data-dojo-props="height:'4rem'">
				<div class="basicInfoHeaderBack" onclick="backToDocView(this)">
					<i class="mui mui-back"></i>
					<span class="personHeaderReturnTxt"><bean:message  bundle="km-carmng" key="kmCarmng.back"/></span>
				</div>
				<div class="basicInfoHeaderTitle"><bean:message  bundle="km-carmng" key="kmCarmng.tree.car.information3"/></div>
				<div></div>
			</div>
			<div data-dojo-type="mui/list/StoreScrollableView">
				<ul data-dojo-type="mui/list/JsonStoreList" id="InfringeInfo" class="muiCarRecordList"
	                data-dojo-mixins="km/carmng/mobile/js/list/CarInfoItemListMixin"
					data-dojo-props="url:''">
				</ul>
			</div>
		</div>
		<div id='InsuranceInfoView' data-dojo-type="dojox/mobile/View">
		    <div class="basicInfoHeader" data-dojo-type="mui/header/Header" data-dojo-props="height:'4rem'">
				<div class="basicInfoHeaderBack" onclick="backToDocView(this)">
					<i class="mui mui-back"></i>
					<span class="personHeaderReturnTxt"><bean:message  bundle="km-carmng" key="kmCarmng.back"/></span>
				</div>
				<div class="basicInfoHeaderTitle"><bean:message  bundle="km-carmng" key="kmCarmng.tree.car.information4"/></div>
				<div></div>
			</div>
			<div data-dojo-type="mui/list/StoreScrollableView">
				<ul data-dojo-type="mui/list/JsonStoreList" id="InsuranceInfo" class="muiCarRecordList"
	                data-dojo-mixins="km/carmng/mobile/js/list/CarInfoItemListMixin"
					data-dojo-props="url:''">
				</ul>
			</div>
		</div>
		<div id='maintenanceInfoView' data-dojo-type="dojox/mobile/View">
		    <div class="basicInfoHeader" data-dojo-type="mui/header/Header" data-dojo-props="height:'4rem'">
				<div class="basicInfoHeaderBack" onclick="backToDocView(this)">
					<i class="mui mui-back"></i>
					<span class="personHeaderReturnTxt"><bean:message  bundle="km-carmng" key="kmCarmng.back"/></span>
				</div>
				<div class="basicInfoHeaderTitle"><bean:message  bundle="km-carmng" key="kmCarmng.tree.car.information5"/></div>
				<div></div>
			</div>
			<div data-dojo-type="mui/list/StoreScrollableView">
				<ul data-dojo-type="mui/list/JsonStoreList" id="maintenanceInfo" class="muiCarRecordList"
	                data-dojo-mixins="km/carmng/mobile/js/list/CarInfoItemListMixin"
					data-dojo-props="url:''">
				</ul>
			</div>
		</div>
		<div class="muiCarOptionTooltip">
	        <div class="muiCarDropToggle"><i class="mui mui-carToggle"></i></div>
	        <ul class="muiCarDropMenu">
	            <li id="one1" onclick="showInfo(this,'dispatchInfo',1,4);"><a href="javascript:void(0);"><i class="mui mui-carUse"></i><bean:message  bundle="km-carmng" key="kmCarmng.history.record"/></a></li>
	            <li id="one2" onclick="showInfo(this,'InfringeInfo',2,4);"><a href="javascript:void(0);"><i class="mui mui-carInfo"></i><bean:message  bundle="km-carmng" key="kmCarmng.tree.car.information3"/></a></li>
	            <li id="one3" onclick="showInfo(this,'InsuranceInfo',3,4);"><a href="javascript:void(0);"><i class="mui mui-carInsurance"></i><bean:message  bundle="km-carmng" key="kmCarmng.tree.car.information4"/></a></li>
	            <li id="one4" onclick="showInfo(this,'maintenanceInfo',4,4);"><a href="javascript:void(0);"><i class="mui mui-carMaintenance"></i><bean:message  bundle="km-carmng" key="kmCarmng.tree.car.information5"/></a></li>
	        </ul>
	    </div>
	</template:replace>
</template:include>
<script>
$(function () {
    //底部工具栏收展
    $(".muiCarOptionTooltip .muiCarDropToggle").bind("click", function () {
        $(this).toggleClass("on").next(".muiCarDropMenu").slideToggle(300);
    });
});

require(['dojo/topic',
         'dojo/ready',
         'dijit/registry',
         'dojox/mobile/TransitionEvent',
         'mui/device/adapter'
         ],function(topic,ready,registry,TransitionEvent,adapter){

	     ready(function(){
		   //alert();
		 });
	
		//资产搜索视图
		window.showInfo=function(obj,type,cursel,n){
			for (var i = 1; i <= n; i++) {
	            var menu = document.getElementById("one" + i);
	            menu.className = i == cursel ? "cur" : "";
	        }
			var url="";
			if(type=='dispatchInfo'){
				url=Com_GetCurDnsHost()+"${LUI_ContextPath}/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfoIndex.do?method=listDispatch&fdCarId=${param.fdId}&orderby=docCreateTime&ordertype=up&flag=true";
			}
			if(type=='InfringeInfo'){
				url=Com_GetCurDnsHost()+"${LUI_ContextPath}/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfoIndex.do?method=listInfringe&fdCarId=${param.fdId}&orderby=docCreateTime&ordertype=up&flag=true";
			}
			if(type=='InsuranceInfo'){
				url=Com_GetCurDnsHost()+"${LUI_ContextPath}/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfoIndex.do?method=listInsurance&fdCarId=${param.fdId}&orderby=docCreateTime&ordertype=up&flag=true";
			}
			if(type=='maintenanceInfo'){
				url=Com_GetCurDnsHost()+"${LUI_ContextPath}/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfoIndex.do?method=lisMaintenancet&fdCarId=${param.fdId}&orderby=docCreateTime&ordertype=up&flag=true";
			}
			registry.byId(type).set('url',url);
			var opts = {
				transition : 'slide',
				transitionDir:1,
				moveTo:type+'View'
			};
			new TransitionEvent(obj, opts).dispatch();
			registry.byId(type).reload();
		};
		
		//返回主视图
		window.backToDocView=function(obj){
			$(".muiCarOptionTooltip .muiCarDropToggle").click();
			for (var i = 1; i <= 4; i++) {
	            var menu = document.getElementById("one" + i);
	            menu.className = "";
	        }
			var opts = {
				transition : 'slide',
				transitionDir:-1,
				moveTo:'scrollView'
			};
			new TransitionEvent(obj, opts).dispatch();
		};
	});
 </script>
