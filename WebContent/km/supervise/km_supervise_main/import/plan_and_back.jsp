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
	         <div class="lui_supervise_timeline_item_title">
	         	{%data[i].docSubject%} {%data[i].fdPlanStartTime%} ~ {%data[i].fdPlanEndTime%}
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
	    	var backs = data[i].backs;
	if(backs.length > 0){
	{$
		<div class="lui_stage_tb">
			<table>
	$}
			{$
				<tr align="left">
					<%--进展情况--%> 
					<th style="width:16%">
						<bean:message bundle="km-supervise" key="kmSuperviseBack.docProgress"/>
					</th>
					<%--存在困难及下一步措施--%>
					<th style="width:20%">
						<bean:message bundle="km-supervise" key="kmSuperviseBack.docDifficulty"/>
					</th>
					<%--督办状态--%>
					<th style="width:10%">
						<bean:message bundle="km-supervise" key="kmSuperviseBack.fdStatus"/>
					</th>
					<%--进度--%>
					<th style="width:8%">
						<bean:message bundle="km-supervise" key="kmSuperviseBack.progress"/>
					</th>
					<%--反馈部门--%>
					<th style="width:10%">
						<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit"/>
					</th>
					<%--反馈人--%>
					<th style="width:10%">
						<bean:message bundle="km-supervise" key="kmSuperviseBack.fdPerson"/>
					</th>
					<%--反馈时间--%>
					<th style="width:10%">
						<bean:message bundle="km-supervise" key="kmSuperviseBack.fdFeedbackTime"/>
					</th>
					<%--文档状态--%>
					<th style="width:8%">
						<bean:message bundle="km-supervise" key="kmSuperviseBack.docStatus"/>
					</th>
					<%--操作--%>
					<th style="width:8%">
						<bean:message bundle="km-supervise" key="kmSuperviseBack.operation"/>
					</th>
				</tr>
			$}
		for(var j=0; j < backs.length; j++){
			if(j == 0){
			{$
				<tr>
			$}
			}else{
			{$
				<tr class="moreStageBack" style="display:none;" align="left">
			$}
			}
				{$
					<td title="{%backs[j].docProgress%}">
						<div class="lui_task_unit_content">
						{%backs[j].docProgress%}
						</div>
					</td>
					<td title="{%backs[j].docDifficulty%}" >
						<div class="lui_task_unit_content">
						{%backs[j].docDifficulty%}
						</div>
					</td>
					<td>
				$}
				var fdStatus = backs[j].fdStatus;
				if(fdStatus == '0'){
					{$
						<bean:message bundle="km-supervise" key="enums.back.status.normal"/>
					$}
				}else if(fdStatus == '1'){
					{$
						<bean:message bundle="km-supervise" key="enums.back.status.delay"/>
					$}
				}else if(fdStatus == '2'){
					{$
						<bean:message bundle="km-supervise" key="enums.back.status.finish"/>
					$}
				}
				{$
					</td>
					<td>
						{%backs[j].fdProgress%} %
					</td>
					<td>
						{%backs[j].fdUnitName%}
					</td>
					<td>
						{%backs[j].fdPerson%}
					</td>
					<td>
						{%backs[j].fdFeedbackTime%}
					</td>
					<td>
				$}
					var docStatus = backs[j].docStatus;
					if(docStatus == '10'){
					{$
						<bean:message key="status.draft"></bean:message>
					$}	
					}else if(docStatus == '11'){
					{$
						<bean:message key="status.refuse"></bean:message>
					$}
					}else if(docStatus == '20'){
					{$
						<bean:message key="status.examine"></bean:message>
					$}
					}else if(docStatus == '30'){
					{$
						<bean:message key="status.publish"></bean:message>
					$}
					}else if(docStatus == '00'){
					{$
						<bean:message key="status.discard"></bean:message>
					$}
					}
				{$
					</td>
					<td>
						<a class="lui_text_primary" onclick="viewDoc('{%backs[j].href%}')">查看</a>
					</td>
				$}
			{$
				</tr>
			$}
		}
	{$
		</table>
		</div>
	$}
		if(backs.length > 1){
			{$
				<div class="lui_stage_more lui_text_primary" onclick="showMore(this);">展开更多<i class="lui_arrow arrow_down lui_text_primary"></i></div>
				<div class="lui_stage_more lui_text_primary" onclick="hiddenMore(this);" style="display:none;">收起<i class="lui_arrow arrow_up lui_text_primary"></i></div>
			$}
		}
	}
	    {$
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
