<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
{$
<div class="lui_supervise_tabpage_content">
	<div class="lui_supervise_timeline">
$}
	
for(var i=0; i < data.length; i++){
	{$
		<div class="lui_supervise_timeline_item">
	         <div class="lui_supervise_timeline_item_color"><i></i></div>
	         <div class="lui_supervise_timeline_item_title">{%data[i].docSubject%}</div>
	         <div class="lui_supervise_timeline_item_wrap">
	         <div class="lui_supervise_timeline_item_title">
	         	{%data[i].fdPlanStartTime%} ~ {%data[i].fdPlanEndTime%}
	$}
	 	var fdStatus = data[i].fdStatus;
	 	var process = data[i].fdTaskProgress;
	 	if(fdStatus == '2'){
	 		{$
	 			<span class="lui_supervise_label status_done">已完成</span>
	 		$}
	 	}else if(fdStatus == '1'){
	 		{$
		 		<span class="lui_supervise_progress">
	        		<span class="lui_supervise_bar">
	           			<div class="lui_supervise_inner_bar com_bgcolor_d" style="width:{%process%}%"></div>
	        		</span>
	        		<span class="lui_supervise_rate">{%process%} %</span>
	    		</span>
	 		$}
	 	}else if(fdStatus == '0'){
	 		{$
	 			<span class="lui_supervise_label status_done">未开始</span>
	 		$}
	 	}
	 	{$        	
	         <span class="lui_supervise_timeline_item_back lui_text_primary" onclick="showStageBacks('{%data[i].fdId%}','{%data[i].docSubject%}')">汇总反馈<i class="lui_arrow arrow_right"></i></span>
	         </div>
	         
	         <div class="lui_supervise_timeline_item_content">
	             <div class="lui_stage_list">
	                 <div class="lui_stage_target">
	                     <em><bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>：</em>
	                     <ul>
	                         <li>{%data[i].docContent%}</li>
	                     </ul>
	                 </div>
	             </div>
	             <div class="lui_stage_info">
	                 <div class="lui_stage_item"><em><bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>：</em><span>{%data[i].fdUnitName%}</span></div>
	                 <div class="lui_stage_item"><em><bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>：</em><span>{%data[i].fdSponsorName%}</span></div>
	                 <div class="lui_stage_item"><em><bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>：</em><span>{%data[i].fdOtherUnitNames%}</span></div>
	             </div>
	    $}
	
	    {$
	         </div>
	         </div>
	     </div>
	$}
	
}
	
{$
	</div>
</div>
$}
}else{
	{$
	<%@ include file="/resource/jsp/listview_norecord.jsp"%>
	$}
}
