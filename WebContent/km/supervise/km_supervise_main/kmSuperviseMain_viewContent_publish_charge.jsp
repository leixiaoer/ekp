<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
   	             
	<!-- 督办计划及阶段反馈 -->
    <div class="lui_supervise_tabpage_head lui_tabpage_float_header_title">
    	<span class="lui_supervise_tabpage_title lui_text_primary"><bean:message bundle="km-supervise" key="py.supervise.planAndBack"/></span>
    	<c:if test="${kmSuperviseMainForm.docStatus=='30' && kmSuperviseMainForm.docStatus!='40' && kmSuperviseMainForm.docStatus!='50'}">
    		<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback&fdType=1&fdMainId=${param.fdId}">
     			<a class="lui_supervise_btn com_bgcolor_d" href="javascript:void();" onclick="updateAddFeedback('1');">
     			<i class="lui_icon_s icon_edit"></i><span><bean:message bundle="km-supervise" key="py.HuiZongFanKui"/></span></a>
    		</kmss:auth>
    	</c:if>
	</div>
					
	<!-- 筛选项 -->
   	<ui:dataview>
		<ui:source type="Static">
			{url: ""}
		</ui:source>
		<ui:render type="Template">
			<c:import url="/km/supervise/km_supervise_main/import/criteria_status.jsp" charEncoding="UTF-8"></c:import>
		</ui:render>
   	</ui:dataview>
   	<script>
		var planCriteria = {
			fdStatus:""
		}
		function planStatusChange(val,node){
			planCriteria["fdStatus"] = val;
			var planAndBackFrame = document.getElementById("planAndBackFrame");
			var newSrc = "${LUI_ContextPath}/km/supervise/km_supervise_main/import/plan_and_back_frame.jsp?fdId=${kmSuperviseMainForm.fdId}&fdStatus="+planCriteria["fdStatus"];
			planAndBackFrame.src = newSrc;
			$(node).addClass('sclpitl_item_active lui_text_primary').siblings().removeClass('sclpitl_item_active lui_text_primary');
		}
   	</script>
   	<ui:event event="show">
    	document.getElementById("planAndBackFrame").src = '<c:url value="/km/supervise/km_supervise_main/import/plan_and_back_frame.jsp?fdId=${kmSuperviseMainForm.fdId}" />';
	</ui:event>
	<iframe id="planAndBackFrame" width=100% height=100% frameborder=0 scrolling=no></iframe>
  			
	<!-- 任务反馈情况统计及记录 -->
   	<div class="lui_supervise_tabpage_head lui_tabpage_float_header_title">
   		<span class="lui_supervise_tabpage_title lui_text_primary"><bean:message bundle="km-supervise" key="kmSuperviseMain.taskAndBack"/></span>
   		<c:if test="${kmSuperviseMainForm.docStatus=='30' && kmSuperviseMainForm.docStatus!='40' && kmSuperviseMainForm.docStatus!='50'}">
   			<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback&fdType=0&fdMainId=${param.fdId}&fdTaskId=">
   				<a class="lui_supervise_btn com_bgcolor_d" href="javascript:void();" onclick="updateAddFeedback('0');"><i class="lui_icon_s icon_edit"></i><span><bean:message bundle="km-supervise" key="py.RenWuFanKui"/></span></a>
   			</kmss:auth>
   		</c:if>
   		<div class="lui_supervise_tabpage_float_header_close" onclick="superviseClose('taskAndBackContent',this)" title="${lfn:message('km-supervise:py.close') }"></div>
   	</div>
   	<div class="lui_supervise_tabpage_content" id="taskAndBackContent">
		<div class="lui_supervise_title1">
	    	<div class="lui_supervise_left"><bean:message bundle="km-supervise" key="py.supervise.stat"/></div>
	        <div class="lui_supervise_right lui_text_primary" onclick="backSituationView();" ><bean:message bundle="km-supervise" key="mobile.backSituationView"/><i class="lui_arrow arrow_right supervise_preview lui_text_primary"></i></div>
	    </div>
        <div class="lui_supervise_task_statistic_tb">
	       	<ui:dataview>
				<ui:source type="AjaxJson">
					{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getBackDays&fdMainId=${kmSuperviseMainForm.fdId}"}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/criteria_backday.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
		    </ui:dataview>
		    <script>
				var taskCriteria = {
				    fdBackPeriod:""
				}
				function taskDateChange(val,node){
				    taskCriteria["fdBackPeriod"] = val;
				    var taskAndBackFrame = document.getElementById("taskAndBackFrame");
				    var newSrc = "${LUI_ContextPath}/km/supervise/km_supervise_main/import/task_and_back_frame.jsp?fdId=${kmSuperviseMainForm.fdId}&fdBackPeriod="+taskCriteria["fdBackPeriod"];
				    taskAndBackFrame.src = newSrc;
				    $(node).addClass('current').siblings().removeClass('current');
				}
		    </script>
			 
			<ui:event event="show">
	        	document.getElementById("taskAndBackFrame").src = '<c:url value="/km/supervise/km_supervise_main/import/task_and_back_frame.jsp?fdId=${kmSuperviseMainForm.fdId}" />';
	        </ui:event>
			<iframe id="taskAndBackFrame" width=100% height=100% frameborder=0 scrolling=no></iframe>
    	</div>
	</div>
         
	<!-- 全部反馈记录 -->
    <div class="lui_supervise_tabpage_head lui_tabpage_float_header_title">
    	<span class="lui_supervise_tabpage_title lui_text_primary"><bean:message bundle="km-supervise" key="kmSuperviseMain.allBack"/></span>
    	<div class="lui_supervise_tabpage_float_header_close" onclick="superviseClose('allBackFrame',this)" title="${lfn:message('km-supervise:py.close') }"></div>
        <div class="lui_supervise_tabpage_tab">
         	<c:choose>
         		<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
         			<span class="lui_supervise_tab_change lui_supervise_tab_left" onclick="typeChange('unit',this)"><bean:message bundle="km-supervise" key="py.unit"/></span>
         		</c:when>
         		<c:otherwise>
         			<span class="lui_supervise_tab_change lui_supervise_tab_left" onclick="typeChange('dept',this)"><bean:message bundle="km-supervise" key="py.dept"/></span>
         		</c:otherwise>
         	</c:choose>
          	<span class="lui_supervise_tab_change lui_supervise_tab_right lui_supevise_tab_select com_bgcolor_d" onclick="typeChange('stage',this)"><bean:message bundle="km-supervise" key="py.stage"/></span>
         </div>
   	</div>
   			
   	<script>
		var allCriteria = {
			fdType:"stage"
		}
			   	
		function typeChange(type,node){
			allCriteria["fdType"] = type;
			var allBackFrame = document.getElementById("allBackFrame");
			var newSrc = "${LUI_ContextPath}/km/supervise/km_supervise_main/import/all_back_frame.jsp?fdId=${kmSuperviseMainForm.fdId}&fdType="+allCriteria["fdType"];
			allBackFrame.src = newSrc;
			$(node).addClass('lui_supevise_tab_select com_bgcolor_d').siblings().removeClass('lui_supevise_tab_select com_bgcolor_d');
		}
	</script>
   	<ui:event event="show">
        document.getElementById("allBackFrame").src = '<c:url value="/km/supervise/km_supervise_main/import/all_back_frame.jsp?fdId=${kmSuperviseMainForm.fdId}&fdType=stage" />';
    </ui:event>
	<iframe id="allBackFrame" width=100% height=100% frameborder=0 scrolling=no></iframe>
	
	<script>
		function superviseClose(contentId,node){
			var content = document.getElementById(contentId);
			var display = content.style.display;
			if(display == 'none'){
				content.style.display = 'block';
				node.title = '<bean:message bundle="km-supervise" key="py.close"/>';
			}else{
				content.style.display = 'none';
				node.title = '<bean:message bundle="km-supervise" key="py.open"/>';
			}
		}
	</script>	