<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
	function checkPassword(){
		var password = document.getElementById("password").value ;
		if(password.length==0){
			alert('<bean:message  bundle="km-oitems" key="kmOitemsGetApplication.please.password"/>');
			return false ;
		}else{
			document.forms[0].submit();
			return true ;
		}
	}
</script>
<html:form action="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=checkedUser">
<p class="txttitle"><bean:message  bundle="km-oitems" key="kmOitemsGetApplication.please.password"/></p>
<center>
<table class="tb_normal" width=95%>
<input name="fdId" type="hidden" value="${HtmlParam.fdId}"/>
	<tr>
		<td>
			<center><input name="password" type="password" class="inputsgl"></center>
		</td>
	</tr>
	<tr>
		<td>
			<center><input type=button value="<bean:message key="button.update"/>"
			onclick="checkPassword();">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="<bean:message key="button.close"/>" onclick="window.close();"></center>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>