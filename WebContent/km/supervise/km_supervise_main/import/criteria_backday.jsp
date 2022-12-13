<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.length > 0){
{$
<div class="lui_task_statistic_form">
<em>反馈日：</em>
	<div class="lui_task_sliderProcess_wrap">
	    <ul>
$}
    for(var i = 0; i < data.length; i++){
    	var isOn = data[i].isOn;
    	var isCurrent = data[i].isCurrent;
    	var fdBackPeriod = data[i].fdBackPeriod;
    	if(isOn && isCurrent){
    	{$
    		<li class="on current" onclick="taskDateChange('{%fdBackPeriod%}',this)"><span>{%data[i].date%}</span></li>
    	$}
    	}else if(isOn){
    	{$
    		<li class="on" onclick="taskDateChange('{%fdBackPeriod%}',this)"> <span>{%data[i].date%}</span></li>
    	$}
    	}else{
    	{$
    		<li><span>{%data[i].date%}</span></li>
    	$}
    	}
    }
{$
	    </ul>
	</div>
</div>
$}
}
