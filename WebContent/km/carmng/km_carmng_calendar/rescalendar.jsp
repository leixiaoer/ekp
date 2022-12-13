<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="java.util.Date"%>
<%@ page import=" com.landray.kmss.util.ResourceUtil"%>
<%
	request.setAttribute("dateFormatter", ResourceUtil.getString("date.format.date"));
	request.setAttribute("dateTimeFormatter",ResourceUtil.getString("date.format.datetime"));
	request.setAttribute("userId", UserUtil.getUser().getFdId());
	request.setAttribute("now", new Date().getTime());
%>
<template:include ref="default.simple">
	<%-- 标签页标题 --%>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	
	<%-- 导航路径 --%>
	<%-- <template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-carmng:module.km.carmng') }" href="/km/carmng/" target="_self">
			</ui:menu-item>
		</ui:menu>
	</template:replace> --%>
	
	<%-- 右侧内容区域 --%>
	<template:replace name="body">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/carmng/km_carmng_calendar/calendar.css" />
		<script>
			seajs.use([
				'lui/dialog',
				'lui/topic',
				'lui/jquery',
				'km/carmng/resource/js/dateUtil',
				'lui/util/env'
				], function(dialog,topic,$,dateUtil,env) {

					//数据初始化
					window.transformData=function(datas){
						var main=datas.main;
						for(var key in main){
							for(var i=0;i<main[key].list.length;i++){
								var item=main[key].list[i];
								if(checkStatus(item)==-1){
									item.color=$('.meeting_calendar_label_unhold').css('background-color');
								}
								if(checkStatus(item)==0){
									item.color=$('.meeting_calendar_label_holding').css('background-color');
								}
								if(checkStatus(item)==1){
									item.color=$('.meeting_calendar_label_hold').css('background-color');
								}
							}
						}
						datas.categoryName = '<bean:message key="kmCarmngInfomation.fdMotorcade" bundle="km-carmng" />';
						return datas;
					};

					//当前会议状态
					var checkStatus=function(item){
						var startDate=dateUtil.parseDate(item.start),endDate=dateUtil.parseDate(item.end);
						var now=new Date(parseFloat('${now}'));
						//已完成
						if(item.fdIsDispatcher == '3' || item.fdIsDispatcher == '4'){
							return 1;
						}
						//未召开
						if(now.getTime()<startDate.getTime()){
							return -1;
						}
						//进行中
						if(now.getTime()>=startDate.getTime()){
							return 0;
						}
					};
				
					//定位
					var getPos=function(evt,obj){
						var sWidth=obj.width();var sHeight=obj.height();
						x=evt.pageX;
						y=evt.pageY;
						if(y+sHeight>$(window).height()){
							y-=sHeight;
						}
						if(x+sWidth>$(document.body).outerWidth(true)){
							x-=sWidth;
						}
						return {"top":y,"left":x};
					};
					

					//查看
					topic.subscribe('calendar.thing.click',function(arg){
						$('.meeting_calendar_dialog').hide();
						var viewDialog=$("#carmng_calendar_view");;//弹出框
						//时间格式2014-7-11~2014-7-12
						var date=dateUtil.formatDate(arg.data.start,"${dateTimeFormatter}");
						if(arg.data.start!=arg.data.end){
							date+=" ~ "+dateUtil.formatDate(arg.data.end,"${dateTimeFormatter}");
						}
						viewDialog.find(".fdId").html(arg.data.fdId);//fdId
						viewDialog.find(".fdName").html( env.fn.formatText(arg.data.title) );
						var fdUserPersons = ""
						var results = eval("(" + arg.data.fdUserPersons + ")");
						for(var i=0;i<results.length;i++){
							fdUserPersons = fdUserPersons + '<ui:person personId="'+results[i].fdId+'" personName="'+results[i].fdName+'"></ui:person>' + ",";
						}
						viewDialog.find(".fdUserPersons").html(fdUserPersons.substring(0,fdUserPersons.length-1));
						
						viewDialog.find(".docCreator").html('<ui:person personId="'+arg.data.docCreatorId+'" personName="'+arg.data.docCreator+'"></ui:person>');
						var date=dateUtil.formatDate(arg.data.start,"${dateTimeFormatter}");
						if(arg.data.start!=arg.data.end){
							date+=" ~ "+dateUtil.formatDate(arg.data.end,"${dateTimeFormatter}");
						}
						viewDialog.find(".fdHoldDate").html(date);

						viewDialog.css(getPos(arg.evt,viewDialog)).fadeIn("fast");
					});
					
					//字符串截取
					function textEllipsis(text){
						text = text || '';
						if(text && text.length>200){
							text=text.substring(0,200)+"......";
						}
						return text;
					}
			});
		</script>
	<ui:tabpanel id="kmCarmngEvaluationPanel" layout="sys.ui.tabpanel.list" >
		<ui:content id="kmCarmngResCalendar" title="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher4') }">
		<ui:calendar id="____calendar____carmng" showStatus="drag" mode="day" type="lui/rescalendar!ResCalendar"  layout="km.carmng.calendar.default" customMode="{'id':'meetingCalendar','name':'会议日历','func':'km/carmng/km_carmng_calendar/calendar'}">
			<%--数据--%>
			<ui:dataformat>
				<ui:source type="AjaxJson">
					{url:'/km/carmng/km_carmng_calendar/kmCarmngCalendarAction.do?method=rescalendar'}
				</ui:source>
				<ui:transform type="ScriptTransform">
					return transformData(data);
				</ui:transform>
			</ui:dataformat>
		</ui:calendar>
		<%@ include file="/km/carmng/km_carmng_calendar/kmCarmngCalendar_view.jsp"%>
	 	</ui:content>
	 </ui:tabpanel>	
	</template:replace>
</template:include>