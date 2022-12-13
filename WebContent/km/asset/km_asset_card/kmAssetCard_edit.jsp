<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss" %>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("dialog.js|xform.js|doclist.js");
	Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath+ "km/asset/resource/", "js", true);
	Com_IncludeFile("selectassetcarddialog.js",'${KMSS_Parameter_ContextPath}km/asset/resource/',null,true);
	Com_IncludeFile("providerDialog.js",Com_Parameter.ContextPath+"km/provider/resource/js/","js",true); 
</script>
<script type="text/javascript">
<c:if test="${empty param.categoryId}">
	Com_NewFileFromSimpleCateory('com.landray.kmss.km.asset.model.KmAssetCategory','<c:url value="/km/asset/km_asset_card/kmAssetCard.do"/>?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}');
</c:if>
</script>
<script type="text/javascript">
	function selectCard(value) {
		var ids = showAssetCardList(value);
		if ('' != ids)
			{
				var data = new KMSSData();
			    var url = "${KMSS_Parameter_ContextPath}km/asset/km_asset_card/kmAssetCard.do?method=loadAssetCard&ids="
					+ ids;
				data.SendToUrl(url, function(data) {
					var results = eval("(" + data.responseText + ")");
						if (results.length > 0) {
							document.getElementsByName('fdParentId')[0].value= results[0].fdCardId;
							document.getElementsByName('fdParentName')[0].value = results[0].fdCardName;
							document.getElementsByName('fdParentCode')[0].value = results[0].fdCardCode;
						}
				});
			}
	}
</script>
<html:form action="/km/asset/km_asset_card/kmAssetCard.do">
<div id="optBarDiv">
	<c:if test="${kmAssetCardForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmAssetCardForm, 'update');">
	</c:if>
	<c:if test="${kmAssetCardForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmAssetCardForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmAssetCardForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetCard"/></p>
<xform:text property="docStatus" showStatus="noShow" value="30"/>
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
						<c:if test="${ kmAssetCardForm.codeRule=='1' }">
							<xform:text property="fdCode" style="width:85%" required="true"/>
						</c:if>
						<c:if test="${ kmAssetCardForm.codeRule=='2' }">
							<c:if test="${kmAssetCardForm.method_GET=='edit'}">
								<xform:text property="fdCode" style="width:85%" showStatus="readOnly"/>
							</c:if>
							<c:if test="${kmAssetCardForm.method_GET=='add'}">
								<xform:text property="fdCode" style="width:85%" showStatus="noShow"/>
								<bean:message bundle="km-asset" key="kmAssetCard.fdCode.message"/>
							</c:if>
						</c:if>
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
						<nobr>
						<xform:select property="fdFirstUnit">
							<xform:enumsDataSource enumsType="km_asset_card_fd_first_unit" />
						</xform:select>
						<xform:text property="fdFirstValue" validators="currency-dollar"/>
						</nobr>
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdCanUseYears"/>
					</td><td width="35%">
						<xform:text property="fdCanUseYears" style="width:85%" validators="number"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%"><bean:message bundle="km-asset" key="kmAssetCard.page.docDeptCode"/></td>
					<td  width="35%">
						<xform:text property="docDeptCode" style="width:85%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
					</td><td width="35%">
						<xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_DEPT" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
					</td><td width="35%">
						<xform:dialog  propertyId="fdAssetAddressId" propertyName="fdAssetAddressName" style="width:85%" showStatus="edit"  dialogJs="selectResource('fdAssetAddressId','fdAssetAddressName');"/>
						</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
					</td><td width="35%">
						<xform:address propertyId="fdResponsiblePersonId" propertyName="fdResponsiblePersonName" orgType="ORG_TYPE_PERSON" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdBuyer"/>
					</td><td width="35%">
						<xform:address propertyId="fdBuyerId" propertyName="fdBuyerName" orgType="ORG_TYPE_PERSON" style="width:85%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdBuyDate"/>
					</td><td width="35%">
						<xform:datetime property="fdBuyDate" dateTimeType="date" style="width:85%" />
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
						<xform:datetime property="fdInDeptDate"  dateTimeType="date" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdProvider"/>
					</td><td width="35%">
  						<xform:dialog  propertyId="fdProviderId" propertyName="fdProviderName" style="width:85%" showStatus="edit"  dialogJs="Dialog_Provider('fdProviderId','fdProviderName');"/>
  						</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdWarranty"/>
					</td><td width="35%">
						<xform:text property="fdWarranty" style="width:85%" validators="number"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdParent"/>
					</td><td width="35%">
						<xform:dialog  propertyId="fdParentId" propertyName="fdParentName" style="width:85%" showStatus="edit"  dialogJs="selectCard();"/>
						</td>
					<td  class="td_normal_title"  width="15%"><bean:message bundle="km-asset" key="kmAssetCard.page.fdParentCode"/></td>
					<td width="35%">
						<xform:text property="fdParentCode" showStatus="readOnly"></xform:text>
						<xform:text property="fdUseForm" showStatus="noShow"></xform:text>
					</td>
					
				</tr>
				<!-- 自定义表格 -->
				
				<c:if test="${kmAssetCardForm.fdUseForm == 'true'}">
					<tr>
						<td colspan="4">
						  <c:import url="/sys/xform/include/sysForm_edit.jsp" charEncoding="UTF-8">
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
						<xform:radio property="fdAssetStatus" required="true">
							<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
						</xform:radio>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdFirstUsedDate"/>
					</td><td colspan="3" width="35%">
						<xform:datetime property="fdFirstUsedDate"  dateTimeType="date"  style="width:25%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdExplanation"/>
					</td><td colspan="3">
						<xform:textarea property="fdExplanation" style="width=100%"></xform:textarea>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdContent"/>
					</td><td colspan="3">
						<xform:textarea property="fdContent" style="width=100%"></xform:textarea>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.pic"/>
					</td><td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attachment" /> 
						</c:import>
						
					</td>
				</tr>
				
				<c:if test="${kmAssetCardForm.method_GET!='add'}">
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.docCreator"/>
					</td>
					<td>
						<xform:text property="docCreatorName" style="width:85%"  showStatus="view"/>
						<xform:text property="docCreatorId" style="width:85%"  showStatus="noShow"/>
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
						<xform:text property="docAlterName" style="width:85%"  showStatus="view"/>
						<xform:text property="docAlterId" style="width:85%"  showStatus="noShow"/>
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdLastModifiedTime"/>
					</td><td width="35%">
						<xform:datetime property="fdLastModifiedTime" showStatus="view"/>
					</td>
				</tr>
				</c:if>
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
			&nbsp;
		</td>
	</tr>
	<!-- 权限机制-->
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />" style="display:none">
			<td>
				<table class="tb_normal" width=100%>
					<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
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
		<!-- 权限机制 -->
	
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="fdApplyInListId" />
<html:hidden property="fdNum" />
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("calendar.js");
	$KMSSValidation();
</script>

</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>