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
	<kmss:auth requestURL="/km/asset/km_asset_address/kmAssetAddress.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetAddress.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/asset/km_asset_address/kmAssetAddress.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetAddress.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetAddress"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
	   <!-- 地址名-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.fdAddress"/>
		</td><td width=35%>
			<xform:text property="fdAddress" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
		   <bean:message bundle="km-asset" key="kmAssetAddressCate.fdCategoryId"/>
		</td>
		<td width=35%>
		 <xform:text property="fdAssetAddressCateName" style="width:85%" />
		 </td>
	</tr>
	
	<tr>
	   <!-- 排序号-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.fdOrder"/>
		</td><td width=35%>
			<xform:text property="fdOrder" style="width:85%" />
		</td>
		 <!-- 是否有效-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.fdIsvalidate"/>
		</td><td width=35%>
			<xform:select property="fdIsvalidate">
					<xform:enumsDataSource enumsType="common_yesno" />
			</xform:select>
		</td>
	</tr>
	<tr>
	   <!--创建者-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.docCreator"/>
		</td><td width="35%">
			<c:out value="${kmAssetAddressForm.docCreatorName}" />
		</td>
		   <!-- 创建时间-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" />
		</td>
	</tr>
	
	<c:if test="${kmAssetAddressForm.docAlterorId!=null}">
	<tr>
	   <!-- 修改者-->
    	<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.docAlteror"/>
		</td><td width="35%">
			<c:out value="${kmAssetAddressForm.docAlterorName}" />
		</td>
	
	   <!-- 修改时间-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.docAlterTime"/>
		</td><td width="35%">
			<xform:datetime property="docAlterTime" />
		</td>
	</tr>	
	</c:if>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>