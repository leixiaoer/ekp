<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss" %>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<html:form action="/km/asset/km_asset_card/kmAssetCard.do">
<div id="optBarDiv">
	<kmss:auth requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetCard.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetCard.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetCard"/></p>
<xform:text property="docStatus" showStatus="noShow" />
<center>
<table id="Label_Tabel"
		width=95%>
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetCard.page.tab1" />">
		<td>
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
						<xform:text property="fdInDeptNo" style="width:85%" />
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
						 ${kmAssetCardForm.fdParentName} &nbsp;&nbsp;
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
			  	<c:if test="${kmAssetCardForm.fdUseForm == 'false' and 1==2}">
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
						<bean:message bundle="km-asset" key="kmAssetCard.fdExplanation"/>
					</td><td colspan="3">
						<xform:rtf property="fdExplanation" height="200px" width="100%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdContent"/>
					</td><td colspan="3">
						<xform:rtf property="fdContent" height="200px" width="100%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.pic"/>
					</td><td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formBeanName" value="kmAssetCardForm" />
							<c:param name="fdKey" value="attachment" />
						</c:import>
					</td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
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
		</td>
	</tr>
	
	<!-- 以下代码为嵌入表单模板标签的代码 -->
	<tr LKS_LabelName="<kmss:message bundle="km-asset" key="kmAssetCard.page.tab2" />" style="display:none">
		<td>
			<c:import url="/km/asset/km_asset_card/kmAssetCard_include_list.jsp" 
			charEncoding="UTF-8"/>
		</td>
	</tr>
	<!-- 以上代码为嵌入表单模板标签的代码 -->
	
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetCard.page.tab3" />">
		<td>
			<c:import url="/km/asset/km_asset_card_life/assetCardLife_include_list.jsp" 
			charEncoding="UTF-8"/>
		</td>
	</tr>
	<!-- 权限 -->
	 <tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
		<table
			class="tb_normal"
			width=100%>
			<c:import
				url="/sys/right/right_view.jsp"
				charEncoding="UTF-8">
				<c:param
					name="formName"
					value="kmAssetCardForm" />
				<c:param
					name="moduleModelName"
					value="com.landray.kmss.km.asset.model.KmAssetCard" />
			</c:import>
		</table>
		</td>
	</tr>
	
</table>
</center>
</html:form>
<%@ include file="/resource/jsp/view_down.jsp"%>