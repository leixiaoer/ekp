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
	<kmss:auth requestURL="/km/asset/km_asset_card_life/kmAssetCardLife.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetCardLife.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/asset/km_asset_card_life/kmAssetCardLife.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetCardLife.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetCardLife"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCardLife.fdOperType"/>
		</td><td width="35%">
			<xform:text property="fdOperType" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCardLife.fdOperContent"/>
		</td><td width="35%">
			<xform:rtf property="fdOperContent" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyDate"/>
		</td><td width="35%">
			<xform:datetime property="fdApplyDate" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid"/>
		</td><td width="35%">
			<xform:text property="fdApplyModelid" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelname"/>
		</td><td width="35%">
			<xform:text property="fdApplyModelname" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyPerson"/>
		</td><td width="35%">
			<c:out value="${kmAssetCardLifeForm.fdApplyPersonName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCardLife.fdAssetCardFdid"/>
		</td><td width="35%">
			<c:out value="${kmAssetCardLifeForm.fdAssetCardFdidName}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>