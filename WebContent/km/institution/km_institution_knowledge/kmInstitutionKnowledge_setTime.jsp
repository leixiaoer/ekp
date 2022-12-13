<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@page import="java.util.Date"%>
<script language="javascript">
Com_IncludeFile("doclist.js|dialog.js|calendar.js|optbar.js");
</script>
<% String abolishTime = DateUtil.convertDateToString(new Date(),
		DateUtil.TYPE_DATE, request.getLocale());%>
<br><br>
<center>
<script>
	function clickOK(){
		var field = document.getElementsByName("abolishTime")[0];
		if(field.value==""){
			alert("<kmss:message key="errors.required" argKey0="km-institution:kmInstitution.fdAbolishTime" />");
			return;
		}
		returnValue=field.value;
		top.close();
	}
</script>
<bean:message bundle="km-institution" key="kmInstitution.fdAbolishTime" />
<input class="inputsgl" name="abolishTime" value="<%=abolishTime%>" size="10" onkeydown="if(event.keyCode==13)clickOK();">
<a href="#" onclick="selectDate('abolishTime');">
			<bean:message key="dialog.selectOther"/>
			</a>
<br><br>
<input type="button" value="<bean:message key="button.ok" />" class="btnopt"
	onclick="clickOK();">&nbsp;&nbsp;&nbsp;
<input type="button" value="<bean:message key="button.cancel" />" class="btnopt"
	onclick="top.close();">
</center>
<%@ include file="/resource/jsp/edit_down.jsp"%>
