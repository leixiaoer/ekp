<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
{$
	<div class="lui_task_infoBar lui_task_infoBar_padding">
        <div class="lui_task_status_item"> <i class="lui_task_status status_normal"></i><span
                class="lui_task_label">正常反馈</span>
        </div>

        <div class="lui_task_status_item"> <i class="lui_task_status status_defer_feedbacked"></i><span
                class="lui_task_label">超期已反馈</span>
        </div>

        <div class="lui_task_status_item"><i class="lui_task_status status_defer_unfeedback"></i><span
                class="lui_task_label">超期未反馈</span>
        </div>

        <div class="lui_task_status_item"> <i class="lui_task_status status_unfeedbacked"></i><span
                class="lui_task_label">未反馈</span>
        </div>
    </div>
$}
{$<table class="tb_normal" width=95% style="table-layout:fixed;">$}
	{$
		<tr align="left">
			<%--反馈日--%> 
			<td class="td_normal_title" style="width:20%">
				反馈日
			</td>
			<%--涉及阶段--%> 
			<td class="td_normal_title" style="width:30%">
				涉及阶段
			</td>
			<%--部门反馈情况--%>
			<td class="td_normal_title" style="width: 50%">
				反馈情况
			</td>
		</tr>
	$}
	
for(var i=0; i < data.length; i++){
	var isBefore = data[i].isBefore;
	var isAfter = data[i].isAfter;
	if(isBefore == true){
		{$
			<tr class="lui_supervise_tr_isBefore">
		$}
	}else if(isAfter == true){
		{$
			<tr class="lui_supervise_tr_isAfter">
		$}
	}else{
		{$
			<tr>
		$}
	}
	{$
		
			<td width="20%">
				{%data[i].fdBackDay%}
			</td>
			<td width="30%">
				{%data[i].fdBackStage%}
			</td>
			<td width="50%" >
				<div class="lui_task_infoBar">
	$}
	var results = data[i].results;
	if(results.length > 0){
		for(var j=0; j < results.length; j++){ 
			var fdStatus = results[j].fdStatus;
			var fdName = results[j].fdName;
			if(fdStatus == '0'){
			{$
			        <div class="lui_task_status_item"> <i class="lui_task_status status_normal"></i><span
			                class="lui_task_label">{%fdName%}</span>
			        </div>
			$}
			}else if(fdStatus == '1'){
			{$
			        <div class="lui_task_status_item"> <i class="lui_task_status status_defer_feedbacked"></i><span
			                class="lui_task_label">{%fdName%}</span>
			        </div>
			$}
			}else if(fdStatus == '2'){
			{$
			        <div class="lui_task_status_item"> <i class="lui_task_status status_defer_unfeedback"></i><span
			                class="lui_task_label">{%fdName%}</span>
			        </div>
			$}	
			}else if(fdStatus == '3'){
			{$
			        <div class="lui_task_status_item"> <i class="lui_task_status status_unfeedbacked"></i><span
			                class="lui_task_label">{%fdName%}</span>
			        </div>
			$}	
			}
		} 
	}
	{$			
			</div>
		</td>
	</tr>
	$}
}
{$</table>$}
				
}else{
	{$${lfn:message('km-supervise:kmSuperviseMain.not.null.record')}$}
}
