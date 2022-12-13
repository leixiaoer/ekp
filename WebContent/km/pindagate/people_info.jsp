<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("jquery.js");
</script>
<div id="optBarDiv">
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<center>
	<table class="tb_normal"  width="100%"  >
		<tr>
			<td id="title" colspan=2>  
			</td>
		</tr>
		<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagate.indagated.persons" />
				</td>
				<td id="participateList" width="85%" ></td>
		</tr>	
		<tr>
				<td width="15%" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagate.indagating.persons" />
				</td>
				<td id="notInvolvedList"  width="85%" ></td>
		</tr>
	</table>

</center>
<script type="text/javascript">
$(document).ready(function (){
	var obj = window.dialogArguments;
	var total = obj.participateNum + obj.notInvolvedNum;
	$("#title").html("<bean:message bundle="km-pindagate" key="kmPindagate.indagator.description"/>".
			replace("%total%",total).replace("%participateNum%",obj.participateNum).replace("%notInvolvedNum%",obj.notInvolvedNum));
	$("#participateList").html(obj.participateList);
	$("#notInvolvedList").html(obj.notInvolvedList);
});
</script>
<%@ include file="/resource/jsp/edit_down.jsp"%>

<!--[if IE]><script type="text/javascript" src="${KMSS_Parameter_ResPath}js/excanvas.js"></script><![endif]-->