<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto" showQrcode="false">
    <template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/asset/km_asset_card_life/css/cardlife.css" />
	</template:replace>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmAssetCardForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-asset:table.kmAssetCard.create') } - ${ lfn:message('km-asset:table.kmAssetCard') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmAssetCardForm.fdName} - ${ lfn:message('km-asset:table.kmAssetCard') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
        <ui:toolbar var-navwidth="90%" id="toolbar" layout="sys.ui.toolbar.float"> 
	        <c:if test="${kmAssetCardForm.method_GET=='edit'}">
	            <ui:button text="${ lfn:message('button.update') }" order="2" 
									onclick="Com_Submit(document.kmAssetCardForm, 'update');">
				</ui:button>
			</c:if>
			<c:if test="${kmAssetCardForm.method_GET=='add'}">
			    <ui:button text="${ lfn:message('button.save') }" order="2" 
									onclick="Com_Submit(document.kmAssetCardForm, 'save');">
				</ui:button>
				<ui:button text="${ lfn:message('button.saveadd') }" order="2" 
									onclick="Com_Submit(document.kmAssetCardForm, 'saveadd');">
				</ui:button>
			</c:if>
		    <ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
			</ui:button>
		</ui:toolbar>
	</template:replace>
		<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams 
			    moduleTitle="${ lfn:message('km-asset:table.kmAssetCard') }" 
				modelName="com.landray.kmss.km.asset.model.KmAssetCategory" 
				autoFetch="false"	
				target="_blank"
				categoryId="${kmAssetCardForm.fdAssetCategoryId}" />
		</ui:combin>
	</template:replace>	
	<template:replace name="content">
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
	seajs.use(['lui/dialog','lui/topic'], function(dialog,topic){
		window.dialog=dialog;
		window.topic=topic;
	});
	
	function selectCard(value) {
		showAssetCardList(value);
	}

	function showAssetCardList(value) {
		if(value=== undefined )
	 	{
	 		value='';
	 	}
	 	var url=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/asset/km_asset_card/kmAssetCard_dialog.jsp?isParentCard=true&status='+value;
	 	dialog.iframe(url,"${lfn:message('km-asset:kmAssetApplyBase.selectAsset') }",function(ids){
	 		if (null!= ids&& undefined !=ids&&ids!="")
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
		},{width:900,height:550})
	}

	function changeCate(){
		dialog.simpleCategory('com.landray.kmss.km.asset.model.KmAssetCategory','fdAssetCategoryId','fdAssetCategoryName',false,null);
	}
	
	function checkCode(){
		var flag = true;
		var fdCode = document.getElementsByName('fdCode')[0];
		var fdCardId = document.getElementsByName('fdId')[0];
		var url="${KMSS_Parameter_ContextPath}km/asset/km_asset_card/kmAssetCard.do?method=checkUniqueCode"; 
		 $.ajax({     
		     type:"post",   
		     url:url,     
		     data:{fdCode:fdCode.value,fdCardId:fdCardId.value},
		     async:false,    //用同步方式 
		     success:function(data){
		    	 var results =  eval("("+data+")");
		    	 if(results['isExist'] =='true'){
		    		 flag = false;
		    	 }
			}    
	    });	
	 return flag;
   }
	
</script>
<html:form action="/km/asset/km_asset_card/kmAssetCard.do">
<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetCard"/></p>
<xform:text property="docStatus" showStatus="noShow" value="30"/>
<div class="lui_form_content_frame" style="padding-top:20px"> 
<table class="tb_normal" width="100%"> 
<html:hidden property="fdId" />
<html:hidden property="fdApplyInListId" />
<html:hidden property="fdNum" />
<html:hidden property="fdTaskId" />
<html:hidden property="method_GET" />
<html:hidden property="fdItemIds" />
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
					</td><td width="35%">
						<xform:text property="fdName" style="width:95%" />
					</td>
					<td class="td_normal_title">
						<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
					</td><td width="35%">
						<c:if test="${ kmAssetCardForm.codeRule=='1' }">
							<xform:text property="fdCode" style="width:95%" required="true" validators="codeUnique"/>
						</c:if>
						<c:if test="${ kmAssetCardForm.codeRule=='2' }">
							<c:if test="${kmAssetCardForm.method_GET=='edit'}">
								<xform:text property="fdCode" style="width:95%" showStatus="readOnly"/>
							</c:if>
							<c:if test="${kmAssetCardForm.method_GET=='add'}">
								<xform:text property="fdCode" style="width:95%" showStatus="noShow"/>
								<bean:message bundle="km-asset" key="kmAssetCard.fdCode.message"/>
							</c:if>
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
					</td><td width="35%">
					    <html:hidden property="fdAssetCategoryId" />
					    <html:text property="fdAssetCategoryName" readonly="true" style="width:50%;border:none" />
						&nbsp;&nbsp;
						<a href="javascript:changeCate()" class="com_btn_link">
							<bean:message key="kmAssetCard.changeCate" bundle="km-asset" /> 
						</a>
					</td>
					<td class="td_normal_title">
						<bean:message bundle="km-asset" key="kmAssetCard.fdNo"/>
					</td><td width="35%">
						<xform:text property="fdNo" style="width:95%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
					</td><td width="35%">
						<xform:text property="fdStandard" style="width:95%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdMeasure"/>
					</td><td width="35%">
						<xform:text property="fdMeasure" style="width:95%"  subject="${ lfn:message('km-asset:kmAssetCard.fdMeasure') }"/>
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
						<input type="text" name="fdFirstValue" value="<kmss:showNumber value="${kmAssetCardForm.fdFirstValue}" pattern="0.00#"/>" style="width:85%"  class="inputsgl" subject='<bean:message bundle="km-asset" key="kmAssetCard.fdFirstValue"/>'>
						</nobr>
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdCanUseYears"/>
					</td><td width="35%">
						<xform:text property="fdCanUseYears" style="width:95%" validators="number"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%"><bean:message bundle="km-asset" key="kmAssetCard.page.docDeptCode"/></td>
					<td  width="35%">
						<xform:text property="docDeptCode" style="width:95%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
					</td><td width="35%">
						<xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_DEPT" style="width:95%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
					</td><td width="35%">
						<xform:dialog  propertyId="fdAssetAddressId" propertyName="fdAssetAddressName" style="width:95%" showStatus="edit"  dialogJs="selectResource('fdAssetAddressId','fdAssetAddressName');"/>
						</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
					</td><td width="35%">
						<xform:address propertyId="fdResponsiblePersonId" propertyName="fdResponsiblePersonName" orgType="ORG_TYPE_PERSON" style="width:95%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdBuyer"/>
					</td><td width="35%">
						<xform:address propertyId="fdBuyerId" propertyName="fdBuyerName" orgType="ORG_TYPE_PERSON" style="width:95%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdBuyDate"/>
					</td><td width="35%">
						<xform:datetime property="fdBuyDate" dateTimeType="date" style="width:95%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdInDeptNo"/>
					</td><td width="35%">
						<xform:text property="fdInDeptNo" style="width:95%" />
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdInDeptDate"/>
					</td><td width="35%">
						<xform:datetime property="fdInDeptDate"  dateTimeType="date" style="width:95%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdProvider"/>
					</td><td width="35%">
  						<xform:dialog  propertyId="fdProviderId" propertyName="fdProviderName" style="width:95%" showStatus="edit"  dialogJs="Dialog_Provider('fdProviderId','fdProviderName');"/>
  						</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdWarranty"/>
					</td><td width="35%">
						<xform:text property="fdWarranty" style="width:95%" validators="number"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdParent"/>
					</td><td width="35%">
						<xform:dialog  propertyId="fdParentId" propertyName="fdParentName" style="width:95%" showStatus="edit"  dialogJs="selectCard();"/>
						</td>
					<td  class="td_normal_title"  width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.fdParentCode"/>
					</td>
					<td width="35%">
						<xform:text property="fdParentCode" style="width:95%" showStatus="readOnly"></xform:text>
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
			  	<c:if test="${kmAssetCardForm.fdUseForm == 'false'}">
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
					</td><td width="35%">
						<xform:radio property="fdAssetStatus" required="true">
							<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
						</xform:radio>
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdFirstUsedDate"/>
					</td><td width="35%">
						<xform:datetime property="fdFirstUsedDate" dateTimeType="date"  style="width:95%" />
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
					</td>
					<td colspan="3">
						<xform:textarea property="fdExplanation" style="width:97%"></xform:textarea>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdContent"/>
					</td><td colspan="3">
						<xform:textarea property="fdContent" style="width:97%"></xform:textarea>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.pic"/>
					</td><td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attachment"/> 
								<c:param name="fdMulti" value="true" />
							    <c:param name="fdAttType" value="pic" />
						</c:import>
					</td>
				</tr>
				
				<c:if test="${kmAssetCardForm.method_GET!='add'}">
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.page.docCreator"/>
					</td>
					<td>
						<xform:text property="docCreatorName" style="width:95%"  showStatus="view"/>
						<xform:text property="docCreatorId" style="width:95%"  showStatus="noShow"/>
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
						<xform:text property="docAlterName" style="width:95%"  showStatus="view"/>
						<xform:text property="docAlterId" style="width:95%"  showStatus="noShow"/>
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-asset" key="kmAssetCard.fdLastModifiedTime"/>
					</td><td width="35%">
						<xform:datetime property="fdLastModifiedTime" showStatus="view"/>
					</td>
				</tr>
				</c:if>
		 	</table>
</div>
<ui:tabpage expand="false" var-navwidth="90%" >
	 <c:if test="${kmAssetCardForm.method_GET=='edit'}">
		<ui:content title="${ lfn:message('km-asset:kmAssetCard.page.tab2') }">
		    <list:listview id="cardListView">
				<ui:source type="AjaxJson">
						{url:'/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&parentId=${kmAssetCardForm.fdId}'}
				</ui:source>
				<list:colTable isDefault="false" name="columntable" layout="sys.ui.listview.columntable" rowHref="/km/asset/km_asset_card/kmAssetCard.do?method=view&fdId=!{fdId}">
					<list:col-checkbox></list:col-checkbox>
					<list:col-serial></list:col-serial>
					<list:col-auto props="fdIsLocked;fdCode;fdName;fdStandard;docDept.fdName;fdResponsiblePerson.fdName;fdAssetAddress.fdAddress;fdAssetCategory.fdName;fdAssetStatus"></list:col-auto>
				</list:colTable>
			</list:listview>
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
	</c:if>
	<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetCardForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetCard" />
    </c:import>
</ui:tabpage>
<script>
	Com_IncludeFile("calendar.js");
	var _validation = $KMSSValidation(document.forms['kmAssetCardForm']);
	_validation.addValidator("codeUnique","${lfn:message('km-asset:kmAssetCard.import.fdCode.isExists')}",function(v, e, o) {
		return checkCode();
	});
</script>
</html:form>
	</template:replace>
</template:include>
