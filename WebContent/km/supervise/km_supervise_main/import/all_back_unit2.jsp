<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
{$
<div class="lui_task_statistic_tb">
	<table>
		<tr align="left">
			<%--阶段--%> 
			<th style="width:5%">
				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
			</th>
			<%--进展情况--%> 
			<th style="width:16%">
				<bean:message bundle="km-supervise" key="kmSuperviseBack.docProgress"/>
			</th>
			<%--存在困难及下一步措施--%>
			<th style="width: 16%">
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
			<th style="width: 16%">
				<bean:message bundle="km-supervise" key="kmSuperviseBack.fdFeedbackTime"/>
			</th>
			<%--文档状态--%>
			<th style="width: 10%">
				<bean:message bundle="km-supervise" key="kmSuperviseBack.docStatus"/>
			</th>
			<th style="width: 8%">
				<bean:message key="list.operation"/>
			</th>
		</tr>
$}
for(var i = 0; i< data.length;i++){
	var backs = data[i].backs;
	if(backs.length > 0){
		for(var j=0; j < backs.length; j++){
			{$
			<tr align="left">
				<td width="9%">
					{%backs[j].docSubject%}
				</td>
				<td width="20%" >
					<div class="lui_task_unit_content" title="{%backs[j].docProgress%}">
					{%backs[j].docProgress%}
					</div>
				</td>
				<td width="20%" >
					<div class="lui_task_unit_content" title="{%backs[j].docDifficulty%}">
					{%backs[j].docDifficulty%}
					</div>
				</td>
				<td width="10%">
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
				<td width="5%">
					{%backs[j].fdProgress%} %
				</td>
				<td width="10%" >
					{%backs[j].fdPerson%}
				</td>
				<td width="16%" >
					{%backs[j].fdFeedbackTime%}
				</td>
				<td width="10%" >
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
					<a class="lui_text_primary" onclick="viewDoc('{%backs[j].href%}')">查看</a>
				</td>
			</tr>
			$}
		}
	}
}
{$			
	</table>
</div>
$}
}else{
	{$
	<%@ include file="/resource/jsp/listview_norecord.jsp"%>
	$}
}
