<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/asset/km_asset_address/kmAssetAddress.do">
<script type="text/javascript">
	Com_IncludeFile("dialog.js");
</script>
<script>
$(document).ready(function (){
	var val ="${kmAssetAddressForm.fdIsvalidate}";  
	if(val=='1'||val=='true'){
		document.getElementsByName("fdIsvalidate")[0].checked="checked";
	}else{
		document.getElementsByName("fdIsvalidate")[1].checked="checked";
	}
});

function addCategory(){
	seajs.use(['lui/dialog'],function(dialog){
		dialog.simpleCategory('com.landray.kmss.km.asset.model.KmAssetAddressCate','fdAssetAddressCateId','fdAssetAddressCateName',false,null,null,true,null,false);
	});
}
</script>
<div id="optBarDiv">
	<c:if test="${kmAssetAddressForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmAssetAddressForm, 'update');">
	</c:if>
	<c:if test="${kmAssetAddressForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmAssetAddressForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmAssetAddressForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
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
		   <xform:dialog  propertyId="fdAssetAddressCateId" propertyName="fdAssetAddressCateName"  style="width:90%" required="true"
		   subject='<%=ResourceUtil.getString(request,"kmAssetAddressCate.fdCategoryId","km-asset")%>'
				dialogJs = "addCategory();"/>
		</td>
	</tr>
	<tr>
	<!-- 排序号-->
	<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.fdOrder"/>
		</td><td width=35%>
			<xform:text style="width:85%" property="fdOrder"/>
		</td>
		<!-- 是否有效-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.fdIsvalidate"/>
		</td><td width=35%>
			<xform:radio property="fdIsvalidate">
				<xform:enumsDataSource enumsType="km_asset_address_fdIsvalidate"/>
			</xform:radio>
		</td>	
	</tr>
<c:if test="${kmAssetAddressForm.method_GET!='add'}">
	<tr>
	   <!-- 创建者-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.docCreator"/>
		</td><td width="35%">
			<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="view"/>
		</td>
		<!-- 创建时间-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" showStatus="view"/>
		</td>
	</tr>
</c:if>
	<c:if test="${kmAssetAddressForm.docAlterorId!=null}">
	<tr>
	   <!-- 修改者-->
    	<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.docAlteror"/>
		</td><td width="35%">
	       	<xform:address propertyId="docAlterorId" propertyName="docAlterorName" orgType="ORG_TYPE_PERSON" showStatus="view"/>
		</td>
	
	   <!-- 修改时间-->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.docAlterTime"/>
		</td><td width="35%">
			<xform:datetime property="docAlterTime" showStatus="view"/>
		</td>
	</tr>	
	</c:if>
	
	</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>