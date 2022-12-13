<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
{$
<div class="lui_task_statistic_tb">
	<table>
		<tr align="left">
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
			<%--反馈部门--%>
			<th style="width: 10%">
				<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit"/>
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
{$
			<tr align="left">
				<td width="20%" >
					<div class="lui_task_unit_content" title="{%data[i].docProgress%}">
					{%data[i].docProgress%}
					</div>
				</td>
				<td width="20%" >
					<div class="lui_task_unit_content" title="{%data[i].docDifficulty%}">
					{%data[i].docDifficulty%}
					</div>
				</td>
				<td width="10%">
				$}
					var fdStatus = data[i].fdStatus;
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
					{%data[i].fdProgress%} %
				</td>
				<td width="10%" >
					{%data[i].fdUnitName%}
				</td>
				<td width="10%" >
					{%data[i].fdPerson%}
				</td>
				<td width="16%" >
					{%data[i].fdFeedbackTime%}
				</td>
				<td width="10%" >
				$}
					var docStatus = data[i].docStatus;
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
					<a class="lui_text_primary" onclick="viewDoc('{%data[i].href%}')">查看</a>
				</td>
			</tr>
			$}
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
