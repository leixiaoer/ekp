<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<table class="tb_normal" width=100% id="divertlistTB" style="margin-bottom: -18px">
	<tr>
	    <td  class="td_normal_title" align="center" width="25px">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="8%"> 
			<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="11%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
		</td>
		<!-- 采购日期 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdBuyDate"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
		</td>
		<!-- 存放地点 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="5%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 净值 -->
		<td class="td_normal_title" align="center" width="5%">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdNetValue"/>
		</td>
		<!-- 残值 -->
		<td class="td_normal_title" align="center" width="5%">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemainValue"/>
		</td>
		<!-- 报废变卖值 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdDealMoney"/>
		</td>
		<!--资产处置方式-->
		<td class="td_normal_title" width=10%><bean:message
			bundle="km-asset" key="kmAssetApplyDeal.fdDealType" /></td>
		<!-- 备注文本 -->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemark"/>
		</td>
	</tr>


<c:forEach items="${kmAssetApplyDealForm.fdApplyDealListForms}"
		var="kmAssetApplyDealListForm" varStatus="vstatus">
	<tr align="center">
	    <td  width="25px">
				${vstatus.index+1}
		</td>
		<td align="center">
		    <html:hidden property="fdApplyDealListForms[${vstatus.index}].fdApplyDealId" value="${kmAssetApplyDealForm.fdId}"/>
		    <html:hidden property="fdApplyDealListForms[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyDealListForm.fdAssetCardId}"/>
	  <!--  编码  -->	   
	        <c:out value="${kmAssetApplyDealListForm.fdCode}"></c:out>
		 </td>
		 <td align="center">   
		 <!-- 卡片名称 -->
		     <c:out value="${kmAssetApplyDealListForm.fdAssetCardName}"></c:out>
		 </td>
		 <td align="center"> 
		  <!--  资产类别  -->
		    <c:out value="${kmAssetApplyDealListForm.fdAssetCategoryName}"></c:out>
		</td> 
		<td> 
		 <!--  规格型号  -->
		    <c:out value="${kmAssetApplyDealListForm.fdStandard}"></c:out> 
		</td> 	
			<td> 
			 <!--  采购日期 -->
			<c:out value="${kmAssetApplyDealListForm.fdBuyDate}"></c:out>
		</td> 	
			<td align="center"> 
			 <!--  责任人  -->
		    <c:out value="${kmAssetApplyDealListForm.fdResponsiblePersonName}"></c:out>
		</td> 	
			<td align="center"> 
			 <!--  存放地点 -->
		     <c:out value="${kmAssetApplyDealListForm.fdAssetAddressName}"></c:out>
		</td> 	
			<td align="center"> 
			  <!-- 原值  -->
			 <kmss:showNumber value="${kmAssetApplyDealListForm.fdFirstValue}" pattern="###,##0.00"/>
		</td> 	
			<td align="center"> 
			 <!--  净值  -->
			 <kmss:showNumber value="${kmAssetApplyDealListForm.fdNetValue}" pattern="###,##0.00"/>
		</td> 	
		
			<td align="center"> 
			 <!--  残值  -->
			 <kmss:showNumber value="${kmAssetApplyDealListForm.fdRemainValue}" pattern="###,##0.00"/>
		</td> 	
		
			<td align="center"> 
			 <!--  报废变卖值  -->
			 <kmss:showNumber value="${kmAssetApplyDealListForm.fdDealMoney}" pattern="###,##0.00"/>
		</td>
		<td>
			<xform:select property="fdApplyDealListForms[${vstatus.index}].fdDealType">
					<xform:enumsDataSource enumsType="km_asset_apply_deal_fd_deal_type" />
			</xform:select>
		</td>
		<td align="center"> 
			 <!--  备注文本 -->
			 <c:out value="${kmAssetApplyDealListForm.fdRemark}"></c:out>
		</td> 	
	</tr>
	</c:forEach>
</table>
<%@ include file="/resource/jsp/edit_down.jsp"%>