<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script>
	function DocList_DeleteRow(i){
		var optTR = DocListFunc_GetParentByTagName("TR");
		var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
		var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
		optTB.deleteRow(rowIndex);
		refreshTbIndex("detailTB", rowIndex);
	}
	function refreshTbIndex(tbId, rowIndex){
		var optTB = document.getElementById(tbId);
		for(var j = rowIndex; j<optTB.rows.length; j++){
			optTB.rows[j].cells[0].innerHTML = j;
		}
	}
	function DocListFunc_GetParentByTagName(tagName, obj){
		if(obj==null){
			if(Com_Parameter.IE)
				obj = event.srcElement;
			else
				obj = Com_GetEventObject().target;
		}
		for(; obj!=null; obj = obj.parentNode)
			if(obj.tagName == tagName)
				return obj;
	}
</script>
<table class="tb_normal" width=100% id="detailTB">
	<tr id="titleTr">
		<td class="td_normal_title" align="center" width=5%>
			<bean:message key="page.serial"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="10%"> 
			<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width=15%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
		</td>
		<!-- 地点 -->
		<td class="td_normal_title" align="center" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
		</td>
		<!-- 使用部门 -->
		<td class="td_normal_title" align="center" width=15%>
			<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
		</td>
		<!-- 资产状态 -->
		<td class="td_normal_title" align="center" width=10%>
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
		</td>
		<!-- 备注文本 -->
		<td class="td_normal_title" align="center" width=25%>
			<bean:message bundle="km-asset" key="kmAssetApplyInventory.fdText"/>
		</td>
		<!-- 操作 -->
		<td class="td_normal_title" align="center" width="5%">
			<bean:message bundle="km-asset" key="kmAssetApplyTask.operate"/>
		</td>
	</tr>
	<c:forEach items="${kmAssetApplyInventoryForm.fdDetail_Form}" var="kmAssetApplyInventoryDetailForm" varStatus="vstatus">
		<tr align="center">
			<td>${vstatus.index+1}</td>
			<td>
				<html:hidden property="fdDetail_Form[${vstatus.index}].fdId" value="${kmAssetApplyInventoryDetailForm.fdId}"/>
				<html:hidden property="fdDetail_Form[${vstatus.index}].fdTaskDetailRef" value="${kmAssetApplyInventoryDetailForm.fdTaskDetailRef}"/>
				<html:hidden property="fdDetail_Form[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyInventoryDetailForm.fdAssetCardId}"/>
				<xform:text property="fdDetail_Form[${vstatus.index}].fdAssetCardCode" value="${kmAssetApplyInventoryDetailForm.fdAssetCardCode}" showStatus="view"/>
			</td>
			<td>
				<xform:text property="fdDetail_Form[${vstatus.index}].fdAssetCardName" value="${kmAssetApplyInventoryDetailForm.fdAssetCardName}" showStatus="view"/>
			</td>
			<td>
				<xform:address propertyId="fdDetail_Form[${vstatus.index}].fdResponsiblePersonId" propertyName="fdDetail_Form[${vstatus.index}].fdResponsiblePersonName" orgType="ORG_TYPE_PERSON" style="width:85%" idValue="${kmAssetApplyInventoryDetailForm.fdResponsiblePersonId}" nameValue="${kmAssetApplyInventoryDetailForm.fdResponsiblePersonName}"/>
			</td>
			<td>
				<xform:select property="fdDetail_Form[${vstatus.index}].fdAssetAddressId" value="${kmAssetApplyInventoryDetailForm.fdAssetAddressId}">
					<xform:beanDataSource serviceBean="kmAssetAddressService" selectBlock="fdId,fdAddress" orderBy="fdOrder" />
				</xform:select>
			</td>
			<td>
				<xform:address propertyId="fdDetail_Form[${vstatus.index}].docDeptId" propertyName="fdDetail_Form[${vstatus.index}].docDeptName" orgType="ORG_TYPE_DEPT" style="width:85%" idValue="${kmAssetApplyInventoryDetailForm.docDeptId }" nameValue="${kmAssetApplyInventoryDetailForm.docDeptName }"/>
			</td>
			<td>
				<xform:select property="fdDetail_Form[${vstatus.index}].fdAssetStatus" showPleaseSelect="true">
					<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
				</xform:select>
			</td>
			<td>
				<xform:text property="fdDetail_Form[${vstatus.index}].fdText" style="width:85%" />
			</td>
			<td>
				<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="DocList_DeleteRow(${vstatus.index});">
			</td>
		</tr>
	</c:forEach>
</table>