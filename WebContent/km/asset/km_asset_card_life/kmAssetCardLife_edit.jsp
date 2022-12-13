<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/asset/km_asset_card_life/kmAssetCardLife.do">
<div id="optBarDiv">
	<c:if test="${kmAssetCardLifeForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmAssetCardLifeForm, 'update');">
	</c:if>
	<c:if test="${kmAssetCardLifeForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmAssetCardLifeForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmAssetCardLifeForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
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
			<xform:address propertyId="fdApplyPersonId" propertyName="fdApplyPersonName" orgType="ORG_TYPE_ALL" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCardLife.fdAssetCardFdid"/>
		</td><td width="35%">
			<xform:select property="fdAssetCardFdidId">
				<xform:beanDataSource serviceBean="kmAssetCardService" selectBlock="fdId,fdName" orderBy="fdOrder" />
			</xform:select>
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("calendar.js");
	Com_IncludeFile("dialog.js");
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>