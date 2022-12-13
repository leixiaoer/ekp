<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmPindagateResponse.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmPindagateResponse.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<kmss:windowTitle
			subjectKey=""
			moduleKey="km-pindagate:table.kmPindagateMain" />
<p class="txttitle"><bean:message bundle="km-pindagate" key="table.kmPindagateResponse"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateResponse.fdCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="fdCreateTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateResponse.docCreator"/>
		</td><td width="35%">
			<c:out value="${kmPindagateResponseForm.docCreatorName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-pindagate" key="kmPindagateResponse.fdQuetionair"/>
		</td><td width="35%">
			<c:out value="${kmPindagateResponseForm.fdQuetionairName}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
	<%-- 所属场所 --%>
	<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
         <c:param name="id" value="${kmPindagateResponseForm.authAreaId}"/>
    </c:import> 
	
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>