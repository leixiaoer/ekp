<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
{$
<div style="color: #666;">反馈内容：</div>
<div class="lui_task_statistic_form">
	
    <div class="lui_task_statistic_tb">
    	<table style="width:100%">
$}
{$
			<tr align="left">
				<%--阶段--%> 
				<th style="width:10%">
					<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
				</th>
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
for(var j=0; j < data.length; j++){
	var isNull = data[j].isNull;
	var fdTaskId = data[j].fdTaskId;
	var fdUnitId = data[j].fdUnitId;
	if(isNull==false){
{$
			<tr align="left">
				<td>
					{%data[j].docSubject%}
				</td>
				<td title="{%data[j].docProgress%}">
					<div class="lui_task_unit_content">
					{%data[j].docProgress%}
					</div>
				</td>
				<td title="{%data[j].docDifficulty%}" >
					<div class="lui_task_unit_content">
					{%data[j].docDifficulty%}
					</div>
				</td>
				<td>
$}
				var fdStatus = data[j].fdStatus;
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
					{%data[j].fdProgress%} %
				</td>
				<td>
					{%data[j].fdPerson%}
				</td>
				<td>
					{%data[j].fdFeedbackTime%}
				</td>
				<td>
$}
				var docStatus = data[j].docStatus;
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
					<a class="lui_text_primary" onclick="viewDoc('{%data[j].href%}')">查看</a>
				</td>
			</tr>
$}
	} else {
	{$
		<tr>
			<td>
				{%data[j].docSubject%}
			</td>
			<td colspan="8">
	$}
				var canBack = data[j].canBack;
				var canUrge = data[j].canUrge;
				if(canBack == true || canUrge == true){
					{$
					<div class="lui_supervise_noData_wrap lui_supervise_has_button">
					$}
				}else{
					{$
					<div class="lui_supervise_noData_wrap">
					$}
				}
				
	 {$
                    <div class="lui_noData_img"></div>
                    <div class="lui_noData_content">
                        <h4 class="lui_noData_title">很抱歉，未找到符合条件的记录！</h4>
                        <div class="lui_noData_btnGroup">
      $}
      					var canBack = data[j].canBack;
      					if(canBack == true){
      						{$
      						<span class=" lui_supervise_plain lui_text_primary" onclick="feedback('0')">立即反馈</span>
      						$}
      					}
                        var canUrge = data[j].canUrge;
                        if(canUrge == true){
                        	{$
                        	<span class=" lui_supervise_plain lui_text_primary" onclick="urge('{%fdTaskId%}','{%fdUnitId%}')">催办</span>
                        	$}
                        }    
    {$                      
                        </div>
                    </div>
                </div>
			</td>
		</tr>
	$}
	}
}
{$
		</table>
	</div>
</div>
$}
}
