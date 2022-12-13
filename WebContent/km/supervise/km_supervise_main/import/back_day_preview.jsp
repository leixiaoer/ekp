<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
{$<table class="tb_normal" width=95% style="table-layout:fixed;">$}
	{$
		<tr align="center">
			<%--反馈日--%> 
			<td class="td_normal_title" style="width:20%">
				反馈日
			</td>
			<%--涉及阶段--%> 
			<td class="td_normal_title" style="width:80%">
				涉及阶段
			</td>
		</tr>
	$}
	
for(var i=0; i < data.length; i++){
	{$
		<tr>
			<td width="20%">
				{%data[i].fdBackDay%}
			</td>
			<td width="80%">
				{%data[i].fdBackStage%}
			</td>
		</tr>
	$}
}
{$</table>$}
				
}else{
	{$${lfn:message('km-supervise:kmSuperviseMain.not.null.record')}$}
}
