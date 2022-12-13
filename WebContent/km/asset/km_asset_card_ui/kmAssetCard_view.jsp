<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/asset/km_asset_card_life/css/cardlife.css" />
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmAssetCardForm.fdName} - ${ lfn:message('km-asset:table.kmAssetCard')}"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="90%">
			<kmss:auth requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			    <ui:button text="${ lfn:message('button.edit') }" order="2" 
							onclick="Com_OpenWindow('kmAssetCard.do?method=edit&fdId=${JsParam.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			    <ui:button text="${ lfn:message('button.delete') }" order="2" 
							onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetCard.do?method=delete&fdId=${JsParam.fdId}','_self');">
				</ui:button>
			</kmss:auth>
			<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		    </ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
			<ui:combin ref="menu.path.simplecategory">
				<ui:varParams 
					moduleTitle="${ lfn:message('km-asset:table.kmAssetCard') }"
					modulePath="/km/asset/km_asset_card_ui/index.jsp" 
					modelName="com.landray.kmss.km.asset.model.KmAssetCategory" 
					autoFetch="false"
					href="/km/asset/#j_path=/kmAsset_bank"
					categoryId="${kmAssetCardForm.fdAssetCategoryId}" />
			</ui:combin>
	</template:replace>	
	<template:replace name="content">
	<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<html:form action="/km/asset/km_asset_card/kmAssetCard.do">
<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetCard"/></p>
<xform:text property="docStatus" showStatus="noShow" />
<div class="lui_form_content_frame">
<table class="tb_normal" width="100%"> 
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
					</td><td width="35%">
						<xform:text property="fdName" style="width:85%" />
					</td>
					<td class="td_normal_title">
						<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
					</td><td width="35%">
						<xform:text property="fdCode" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
					</td><td width="35%">
						<xform:text property="fdAssetCategoryId" showStatus="noShow"></xform:text>
						<xform:text property="fdAssetCategoryName" showStatus="view"></xform:text>
					</td>
					<td class="td_normal_title">
						<bean:message bundle="km-asset" key="kmAssetCard.fdNo"/>
					</td><td width="35%">
						<xform:text property="fdNo" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
					</td><td width="35%">
						<xform:text property="fdStandard" style="width:85%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdMeasure"/>
					</td><td width="35%">
						<xform:text property="fdMeasure" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdFirstValue"/>
					</td><td width="35%">
						<xform:select property="fdFirstUnit">
							<xform:enumsDataSource enumsType="km_asset_card_fd_first_unit" />
						</xform:select>
						<input type="text" name="fdFirstValue" value="<kmss:showNumber value="${kmAssetCardForm.fdFirstValue}" pattern="###,##0.00"/>" style="width:85%;border: none;color: black" readonly="readonly" class="inputsgl">
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdCanUseYears"/>
					</td><td width="35%">
						<xform:text property="fdCanUseYears" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%"><bean:message bundle="km-asset" key="kmAssetCard.page.docDeptCode"/></td>
					<td  width="35%">
						<xform:text property="docDeptCode"/>
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
					</td><td width="35%">
						<xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_ALL" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
					</td><td width="35%">
						<xform:text property="fdAssetAddressId" showStatus="noShow"/>
						<xform:text property="fdAssetAddressName" showStatus="view" style="width:85%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
					</td><td width="35%">
						<xform:address propertyId="fdResponsiblePersonId" propertyName="fdResponsiblePersonName" orgType="ORG_TYPE_ALL" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdBuyer"/>
					</td><td width="35%">
						<xform:address propertyId="fdBuyerId" propertyName="fdBuyerName" orgType="ORG_TYPE_ALL" style="width:85%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdBuyDate"/>
					</td><td width="35%">
						<xform:datetime property="fdBuyDate"  dateTimeType="date"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdInDeptNo"/>
					</td><td width="35%">
						<a target="_blank" data-href='<c:url value="/km/asset/km_asset_apply_in/kmAssetApplyIn.do?method=view&fdId=${kmAssetCardForm.fdApplyInId}"/>' onclick="Com_OpenNewWindow(this)"><xform:text property="fdInDeptNo" style="width:85%" /></a>
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdInDeptDate"/>
					</td><td width="35%">
						<xform:datetime property="fdInDeptDate"  dateTimeType="date"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdProvider"/>
					</td><td width="35%">
  						 ${kmAssetCardForm.fdProviderName}
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdWarranty"/>
					</td><td width="35%">
						<xform:text property="fdWarranty" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdParent"/>
					</td><td width="35%">
						<c:out value="${kmAssetCardForm.fdParentName}"/> &nbsp;&nbsp;
						 <c:if test="${kmAssetCardForm.fdParentName !=null and kmAssetCardForm.fdParentName !=''}">
						 		<a data-href="${KMSS_Parameter_ContextPath}km/asset/km_asset_card/kmAssetCard.do?method=view&fdId=${kmAssetCardForm.fdParentId}" target="_blank" onclick="Com_OpenNewWindow(this)">
						 			<img id="imgParentCardImg" align="bottom" alt="<bean:message bundle="km-asset" key="kmAssetCard.showParentCard"/>" src="${KMSS_Parameter_ContextPath}km/asset/resource/image/parent_card.png" />
						 		</a> 
						 </c:if>
					</td>
					<td  class="td_normal_title"  width="15%"><bean:message bundle="km-asset" key="kmAssetCard.page.fdParentCode"/></td>
					<td width="35%">
						<xform:text property="fdParentCode" showStatus="view"></xform:text>
					</td>
					
				</tr>
				<!-- 自定义表格 -->
				
				<c:if test="${kmAssetCardForm.fdUseForm == 'true'}">
					<tr>
						<td colspan="4">
						  <c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmAssetCardForm" />
								<c:param name="fdKey" value="assetMainDoc" />
								<c:param name="useTab" value="false" />
						  </c:import>
				  		</td>
				  	</tr>
			  	</c:if>
			  	<c:if test="${kmAssetCardForm.fdUseForm == 'false' }">
				  	<tr>
				  		<td colspan="4">
				  		<table class="tb_normal" width=100%>
							<tr>
								<td colspan="2">
									<kmss:editor property="docContent" toolbarSet="Default" height="200" needFilter="true"/>
								</td>
							</tr>
						</table>
						</td>
					</tr>
			  	</c:if>
				<!-- 自定义表格 -->
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
					</td><td colspan="3" width="35%">
						<xform:radio property="fdAssetStatus">
							<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
						</xform:radio>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdFirstUsedDate"/>
					</td><td colspan="3" width="35%">
						<xform:datetime property="fdFirstUsedDate"  dateTimeType="date"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetApplyInventory.fdTask"/>
					</td>
					<td colspan="3">
						<c:out value="${kmAssetCardForm.fdTaskName }"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdExplanation"/>
					</td><td colspan="3">
						<xform:textarea property="fdExplanation" style="width:100%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdContent"/>
					</td><td colspan="3">
						<xform:textarea property="fdContent" style="width:100%"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.pic"/>
					</td><td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formBeanName" value="kmAssetCardForm" />
							<c:param name="fdKey" value="attachment" />
							<c:param name="fdMulti" value="true" />
							<c:param name="fdAttType" value="pic" />
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.docCreator"/>
					</td>
					<td>
						<xform:text property="docCreatorName" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetCard.docCreateTime"/>
					</td><td width="35%">
						<xform:datetime property="docCreateTime" showStatus="view" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.fdLastModifiedPerson"/>
					</td>
					<td width="35%">
						<xform:text property="docAlterName" style="width:85%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdLastModifiedTime"/>
					</td><td width="35%">
						<xform:datetime property="fdLastModifiedTime" />
					</td>
				</tr>
		 	</table>
</div>
<ui:tabpage expand="false" var-navwidth="90%">
	    <ui:content title="${ lfn:message('km-asset:kmAssetCard.page.tab2') }">
		    <list:listview id="cardListView" channel="kmAssetCardIndex">
				<ui:source type="AjaxJson">
						{url:'/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&parentId=${kmAssetCardForm.fdId}'}
				</ui:source>
				<list:colTable isDefault="false" name="columntable" layout="sys.ui.listview.columntable" rowHref="/km/asset/km_asset_card/kmAssetCard.do?method=view&fdId=!{fdId}" channel="kmAssetCardIndex">
					<list:col-checkbox></list:col-checkbox>
					<list:col-serial></list:col-serial>
					<list:col-auto props="fdIsLocked;fdCode;fdName;fdStandard;docDept.fdName;fdResponsiblePerson.fdName;fdAssetAddress.fdAddress;fdAssetCategory.fdName;fdAssetStatus"></list:col-auto>
				</list:colTable>
			</list:listview>
			<list:paging channel="kmAssetCardIndex"></list:paging>
		</ui:content>
		<ui:content title="${ lfn:message('km-asset:kmAssetCard.page.tab3') }">
			<ui:dataview>
				<ui:source type="AjaxJson">
					{url:'/km/asset/km_asset_card/kmAssetCard.do?method=getCardLife&cardId=${kmAssetCardForm.fdId }'}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/asset/km_asset_card_life/assetCardLife_include_list.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
			</ui:dataview>
		</ui:content>
         <c:import
			url="/sys/right/import/right_view.jsp"
			charEncoding="UTF-8">
			<c:param
				name="formName"
				value="kmAssetCardForm" />
			<c:param
				name="moduleModelName"
				value="com.landray.kmss.km.asset.model.KmAssetCard" />
		</c:import>

</ui:tabpage>
</html:form>
	</template:replace>
</template:include>
