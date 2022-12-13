<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.length > 0){
{$
<div class="lui_task_statistic_form">
<em><bean:message bundle="km-supervise" key="mobile.back.situation"/>：</em>
<div class="lui_task_feedback_detail">
	<div class="lui_task_infoBar">
$}
	{$
		 <div class="lui_task_status_item"> 
	$}
	for(var i = 0; i < data.length; i++){
		var status = data[i].fdStatus
	
		if(status == '0'){
		{$
			<i class="lui_task_status status_normal"></i>
		$}
		}else if(status == "1"){
		{$
			<i class="lui_task_status status_defer_feedbacked"></i>
		$}
		}else if(status == "2"){
		{$
			<i class="lui_task_status status_defer_unfeedback"></i>
		$}
		}else if(status == "3"){
		{$
			<i class="lui_task_status status_unfeedbacked"></i>
		$}
		}
		 	
	{$
		 	<span class="lui_task_label">{% data[i].fdName %}</span>
	    
	$}
	}
	{$
			</div>
		    <div class="lui_task_status_help">
		       <!-- 反馈状态说明 弹出框 -->
		       <div class="lui_task_status_help_pop">
		           <div class="lui_task_status_item"> <i class="lui_task_status status_normal"></i><span
		                   class="lui_task_label"><bean:message bundle="km-supervise" key="task.status.normal"/></span>
		           </div>
		
		           <div class="lui_task_status_item"> <i
		                   class="lui_task_status status_defer_feedbacked"></i><span
		                   class="lui_task_label"><bean:message bundle="km-supervise" key="task.status.soon.delay"/></span>
		           </div>
		
		           <div class="lui_task_status_item"><i
		                   class="lui_task_status status_defer_unfeedback"></i><span
		                   class="lui_task_label"><bean:message bundle="km-supervise" key="task.status.delay"/></span>
		           </div>
		
		           <div class="lui_task_status_item"> <i
		                   class="lui_task_status status_unfeedbacked"></i><span
		                   class="lui_task_label"><bean:message bundle="km-supervise" key="task.status.not.back"/></span>
		           </div>
		       </div>
		   </div>
	$}
	   
{$    
	</div>
</div>
</div>
$}
}

