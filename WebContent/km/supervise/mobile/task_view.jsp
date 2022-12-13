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
		<script>
        	var sectionTitles=[ {
				 title:'<bean:message bundle="km-supervise" key="kmSuperviseBack.fdBackDay"/>',
				 type:'fdBackDay',
				 fdTaskId:'${kmSuperviseTaskForm.fdId}'
			 	},{
					 title:'<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit"/>',
					 type:'fdSysUnit',
					 fdTaskId:'${kmSuperviseTaskForm.fdId}'
				}
			 ]
	    </script>
	</template:replace>
	<template:replace name="title">
			<c:out value="${kmSuperviseTaskForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
			<div class="lui_asc_item" id="simpleInfo">
               <div class="lui_asc_item_title">
					<span>${kmSuperviseTaskForm.docSubject}</span>
					<span class="progress"></span>
				</div>
				<c:if test="${kmSuperviseTaskForm.fdSuperviseId != null}">
				<div class="lui_asc_item_text">
					<span>所属督办： </span>
					<span ><a href="${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${kmSuperviseTaskForm.fdSuperviseId}" style="font-size:12px;color:#4285f4;">${kmSuperviseTaskForm.fdSuperviseName}</a></span>
				</div>
				</c:if>
				<div class="lui_asc_item_text">
					<span>计划时间： </span>
				    <span>${kmSuperviseTaskForm.fdPlanStartTime} ~ ${kmSuperviseTaskForm.fdPlanEndTime}</span>
				</div>
                <div class="lui_asc_item_arr" onclick="showMoreInfo(true)">
            	</div>
            </div>
            
			<div class="lui_asc_item active" id="moreInfo" style="display:none;">
               	<div class="lui_asc_item_title">
					<span>${kmSuperviseTaskForm.docSubject}</span>
					<span class="progress"></span>
				</div>
				<c:if test="${kmSuperviseTaskForm.fdSuperviseId != null}">
				<div class="lui_asc_item_text">
					<span>所属督办： </span>
					<span ><a href="${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${kmSuperviseTaskForm.fdSuperviseId}" style="font-size:12px;color:#4285f4;">${kmSuperviseTaskForm.fdSuperviseName}</a></span>
				</div>
				</c:if>
				<div class="lui_asc_item_text">
					<span>计划时间： </span>
				    <span>${kmSuperviseTaskForm.fdPlanStartTime} ~ ${kmSuperviseTaskForm.fdPlanEndTime}</span>
				</div>
                <div class="lui_asc_item_text">
                  	<span>承办单位/部门：</span>
                  	<c:choose>
	                  	<c:when test="${kmSuperviseTaskForm.fdSysUnitEnable eq 'true'}">
	                  		<span>${kmSuperviseTaskForm.fdSysUnitName}</span>
	                  	</c:when>
	                  	<c:otherwise>
	                  		<span>${kmSuperviseTaskForm.fdUnitName}</span>
	                  	</c:otherwise>
                  	</c:choose>
                </div>
                <div class="lui_asc_item_text">
                  	<span>承办人：</span>
                  	<span>${kmSuperviseTaskForm.fdSponsorName}</span>
                </div>
                <div class="lui_asc_item_text">
                  	
                  	<c:choose>
	                  	<c:when test="${kmSuperviseTaskForm.fdSysUnitEnable eq 'true'}">
	                  		<span>协办单位：</span>
                  			<span>${kmSuperviseTaskForm.fdOtherUnitNames}</span>
                  		</c:when>
                  		<c:otherwise>
                  			<span>协办人：</span>
	                  		<span>${kmSuperviseTaskForm.fdOUnitNames}</span>
	                  	</c:otherwise>
                  	</c:choose>
                </div>
                <div class="lui_asc_item_text">
                	<span>阶段目标：</span>
			  		<span>${kmSuperviseTaskForm.docContent}</span>
				</div>
				<div class="lui_asc_item_arr" onclick="showMoreInfo(false)">
            	</div>
            </div>
			
			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem">
					<%--切换页签--%>
					<div class="muiHeader">
						<div
							data-dojo-type="mui/nav/MobileCfgNavBar" 
							data-dojo-props="defaultUrl:'/km/supervise/mobile/task_view_nav.jsp' ">
						</div>
					</div>
				</div>
			</div>
			
			<%--阶段反馈--%>
			<div id="stageBackView" data-dojo-type="dojox/mobile/View">
			    <ul data-dojo-type="km/supervise/mobile/resource/js/list/FeedbackJsonStoreList" 
			    	data-dojo-mixins="km/supervise/mobile/resource/js/list/BackItemListMixin"
			    	data-dojo-props="url:'/km/supervise/km_supervise_back/kmSuperviseBack.do?method=data&orderby=docCreateTime&ordertype=down&fdTaskId=${kmSuperviseTaskForm.fdId }&fdType=1'">
				</ul>
			</div>
			
			<%--任务反馈--%>
			<div id="taskBackView"  data-dojo-type="dojox/mobile/View">
				
				<div style="height:2rem;width:100%;" data-dojo-type="km/supervise/mobile/resource/js/taskSelectDialog"				
					data-dojo-props="sectionTitles:window.sectionTitles">
				</div>
				
			    <ul id="taskBackViewList" data-dojo-type="km/supervise/mobile/resource/js/list/FeedbackJsonStoreList" 
			    	data-dojo-mixins="km/supervise/mobile/resource/js/list/BackItemListMixin"
			    	data-dojo-props="url:'/km/supervise/km_supervise_back/kmSuperviseBack.do?method=data&orderby=docCreateTime&ordertype=down&fdTaskId=${kmSuperviseTaskForm.fdId }&fdType=0'">
				</ul>
			</div>
			
			<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				<!-- 阶段反馈 -->
				<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback&fdType=1&fdMainId=${kmSuperviseTaskForm.fdSuperviseId}">
     				<li data-dojo-type="mui/tabbar/TabBarButton"
				  		data-dojo-mixins="km/supervise/mobile/resource/js/_BackTabBarButtonMixin"
						data-dojo-props="fdId:'${kmSuperviseTaskForm.fdSuperviseId}',fdType:'1',fdTaskId:'${kmSuperviseTaskForm.fdId}'"><bean:message bundle="km-supervise" key="py.HuiZongFanKui" /></li>
    			</kmss:auth>
    			<!-- 任务反馈 -->
				<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback&fdType=0&fdMainId=${kmSuperviseTaskForm.fdSuperviseId}&fdTaskId=${kmSuperviseTaskForm.fdId}">
     				<li data-dojo-type="mui/tabbar/TabBarButton"
				  		data-dojo-mixins="km/supervise/mobile/resource/js/_BackTabBarButtonMixin"
						data-dojo-props="fdId:'${kmSuperviseTaskForm.fdSuperviseId}',fdType:'0',fdTaskId:'${kmSuperviseTaskForm.fdId}'"><bean:message bundle="km-supervise" key="py.RenWuFanKui" /></li>
    			</kmss:auth>
			</ul>
			
		</div>
			
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
		
		window.showMoreInfo = function(flag){
			var simple = document.getElementById("simpleInfo");
			var more = document.getElementById("moreInfo");
			if(flag == true){
				simple.style.display = "none";
				more.style.display = "block";
				var fdTaskProgress = '${kmSuperviseTaskForm.fdTaskProgress}';
				buildProgress(fdTaskProgress,1);
			}else if(flag == false){
				simple.style.display = "block";
				more.style.display = "none";
			}
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
		
		ready(function(){
			var fdTaskProgress = '${kmSuperviseTaskForm.fdTaskProgress}';
			buildProgress(fdTaskProgress);
		});
		
		function buildProgress(progress,index){
			if(!index){
				index = 0;
			}
			if(progress == null || progress == ""){
				progress = "0";
			}
			var containerNode = query('.progress')[index];
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
		
		window.reloadTask = function(params){
			var href=Com_GetCurDnsHost()+"${LUI_ContextPath}/km/supervise/km_supervise_back/kmSuperviseBack.do?method=data&orderby=docCreateTime&ordertype=down&fdTaskId=${kmSuperviseTaskForm.fdId}&fdType=0";
			if(params.fdBackDay){
				href += "&fdBackDay="+params.fdBackDay;
			}
			if(params.fdSysUnit){
				href += "&fdSysUnit="+params.fdSysUnit;
			}
			
			registry.byId("taskBackViewList").set('url',href);
			registry.byId("taskBackViewList").reload();
		}
		
	});

</script>