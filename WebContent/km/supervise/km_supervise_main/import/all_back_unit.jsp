<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
for(var i = 0; i< data.length;i++){
	{$
		<div class="lui_task_unit">{%data[i].subject%}</div>
	$}
	var backs = data[i].backs;
	{$
	<div class="lui_task_statistic_tb">
		<table style="width:100%">
			<tr align="left">
				<%--阶段--%> 
				<th style="width:5%">
					<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
				</th>
				<%--进展情况--%> 
				<th style="width:18%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.docProgress"/>
				</th>
				<%--存在困难及下一步措施--%>
				<th style="width: 18%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.docDifficulty"/>
				</th>
				<%--督办状态--%>
				<th style="width: 12%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdStatus"/>
				</th>
				<%--进度--%>
				<th style="width: 7%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.progress"/>
				</th>
				<%--反馈人--%>
				<th style="width: 10%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdPerson"/>
				</th>
				<%--反馈时间--%>
				<th style="width: 12%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.fdFeedbackTime"/>
				</th>
				<%--文档状态--%>
				<th style="width: 8%">
					<bean:message bundle="km-supervise" key="kmSuperviseBack.docStatus"/>
				</th>
				<th style="width: 10%">
					<bean:message key="list.operation"/>
				</th>
			</tr>
		$}
	if(backs.length > 0){
		for(var j=0; j < backs.length; j++){
			{$
			<tr align="left">
				
				<td >
					{%backs[j].docSubject%}
				</td>
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
				<td >
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
				<td >
					{%backs[j].fdProgress%} %
				</td>
				<td >
					{%backs[j].fdPerson%}
				</td>
				
				$}
				var isDelayBack = backs[j].isDelayBack;
				if(isDelayBack == true){
					{$
					<td >
					{%backs[j].fdFeedbackTime%}
					<span class="sclpitl_item_active">超期</span>
					</td>
					$}
				}else{
					{$
					<td >
					{%backs[j].fdFeedbackTime%}
					</td>
					$}
				}
				{$
				<td >
				$}
					var docStatus = backs[j].docStatus;
					if(docStatus == '10'){
					{$
						<bean:message key="status.draft"></bean:message>
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
					<a class="lui_text_primary" onclick="showMoreBack('{%backs[j].fdSysUnitId%}','{%backs[j].fdTaskId%}')">更多<i class="lui_arrow arrow_right"></i></a>
					<br><br>
					<a class="lui_text_primary" onclick="viewDoc('{%backs[j].href%}')">查看<i class="lui_arrow arrow_right"></i></a>
				</td>
			</tr>
			$}
		}
	}else{
		{$
		<tr>
			<td colspan="9">
				<div class="lui_supervise_noData_wrap">                    
					<div class="lui_noData_content">                        
						<h4 class="lui_noData_title">很抱歉，未找到符合条件的记录！</h4>                        
					</div>                
				</div>
			</td>
		</tr>
		$}
	}
	{$			
		</table>
	</div>
	$}
}
}else{
	{$
	<%@ include file="/resource/jsp/listview_norecord.jsp"%>
	$}
}
