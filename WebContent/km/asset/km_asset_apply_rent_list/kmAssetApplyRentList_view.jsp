<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<table class="tb_normal" width=100% id="divertlistTB" style="margin-bottom: -18">
	<tr>
	    <td  class="td_normal_title" align="center" width="5%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="6%"> 
			<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 使用部门-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
		</td>
		<!-- 存放地点 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
		</td>
	</tr>


<c:forEach items="${kmAssetApplyRentForm.fdApplyRentListForms}"
		var="kmAssetApplyRentListForm" varStatus="vstatus">
	<tr align="center">
	    <td  width="25px">
				${vstatus.index+1}
		</td>
		<td>
		    <html:hidden property="fdApplyRentListForms[${vstatus.index}].fdApplyRentId" value="${kmAssetApplyRentForm.fdId}"/>
		    <html:hidden property="fdApplyRentListForms[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyRentListForm.fdAssetCardId}"/>
		  <!--  编码  -->
		   <c:out value="${kmAssetApplyRentListForm.fdCode}"></c:out>
		 </td>
		 <td>   
		 <!-- 卡片名称 -->
		  <c:out value="${kmAssetApplyRentListForm.fdAssetCardName}"></c:out>
		 </td>
		 <td> 
		  <!--  资产类别  -->
		   <c:out value="${kmAssetApplyRentListForm.fdAssetCategoryName}"></c:out>
		</td> 
		<td> 
		 <!--  规格型号  -->
		    <c:out value="${kmAssetApplyRentListForm.fdStandard}"></c:out>
		</td> 	
		<td> 
			  <!-- 原值  -->
			  <kmss:showNumber value="${kmAssetApplyRentListForm.fdFirstValue}" pattern="###,##0.00"/>
		</td> 	
		<td> 
			  <!-- 使用部门  -->
			  <c:out value="${kmAssetApplyRentListForm.docDeptName}"></c:out>
		</td>
		<td> 
			 <!--  责任人  -->
			 <c:out value="${kmAssetApplyRentListForm.fdResponsiblePersonName}"></c:out>
		</td> 	
		<td> 
			 <!--  存放地点 -->
			 <c:out value="${kmAssetApplyRentListForm.fdAssetAddressName}"></c:out>
		</td> 	
	</tr>
	</c:forEach>
</table>
<%@ include file="/resource/jsp/edit_down.jsp"%>