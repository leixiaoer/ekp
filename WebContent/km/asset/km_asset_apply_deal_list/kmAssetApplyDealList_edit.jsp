<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script type="text/javascript">
	Com_IncludeFile("selectassetcarddialog.js",'${KMSS_Parameter_ContextPath}km/asset/resource/',null,true);
</script>
<script>
var trIndex = 0;
var trCardIds = "";
var fdOrder = 0;

function refreshTbIndex(optTB, rowIndex){
	for(var j = rowIndex; j<optTB.rows.length; j++){
		optTB.rows[j].cells[0].innerHTML = j;
	}		
}
	//删除一行
	function deleteRow(i) {
            var cardId=document.getElementsByName("fdApplyDealListForms["+ i+ "].fdAssetCardId")[0].value;  
            trCardIds = trCardIds.replace(cardId+",","");
          
			var optTR = DocListFunc_GetParentByTagName("TR");
			var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
			//var DocList_TableInfo = new Array;
			//var tbInfo = DocList_TableInfo[optTB.id];
			var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
			optTB.deleteRow(rowIndex);
			fdOrder--;
			refreshTbIndex(optTB, rowIndex);
			calculteOldTotal();
			calculteNewTotal();
	   }

	 seajs.use(['lui/dialog'], function(dialog){
			window.dialog=dialog;
	 });

	//选择卡片
     function showAssetCardList(value){
    	 seajs.use(['lui/util/str'], function(strutil){
		 	if(value=== undefined )
		 	{
		 		value='';
		 	}
		 	var url=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/asset/km_asset_card/kmAssetCard_dialog.jsp?status='+value;
		 	dialog.iframe(url,"${lfn:message('km-asset:kmAssetApplyBase.selectAsset') }",function(ids){
		 	if (null!= ids&& undefined !=ids&&ids!=""){
			var data = new KMSSData();
			var url = "${KMSS_Parameter_ContextPath}km/asset/km_asset_card/kmAssetCard.do?method=loadAssetCard&ids="
					+ ids;
			data.SendToUrl(url,function(data) {
				var results = eval("(" + data.responseText + ")");
					if (results.length > 0) {
						for ( var i = 0; i < results.length; i++) {
							if (trCardIds.indexOf(
									results[i].fdCardId, 0) == -1) {
								trHTML = '<tr align="center">';
								trHTML += '<input type="hidden" name="fdApplyDealListForms[' + trIndex + '].fdApplyDealId" value="${kmAssetApplyDealForm.fdId}"/>';
								trHTML += '<input type="hidden" name="fdApplyDealListForms['+ trIndex+ '].fdAssetCardId" value="'+ results[i].fdCardId+ '"/>';
								trHTML += '<td>'+(fdOrder+1)+'</td>';
								//资产编号
								trHTML += '<td>';		
							    trHTML += strutil.encodeHTML(results[i].fdCardCode);
								trHTML += '</td>';
								//资产名称
								trHTML += '<td>';
								trHTML += strutil.encodeHTML(results[i].fdCardName);														
								trHTML += '</td>';
								//资产类别
								trHTML += '<td>';							
								trHTML += '<input type="hidden" name="fdApplyDealListForms['
										+ trIndex
										+ '].fdAssetCategoryId" value="'
										+ results[i].fdAssetCategoryId
										+ '"/>';
								trHTML += results[i].fdAssetCategoryName;										
								trHTML += '</td>';
								
								//规格型号			
								trHTML += '<td>';
								trHTML += results[i].fdCardStandard;											
								trHTML += '</td>';
								
								//采购日期
								trHTML += '<td>';
								trHTML += results[i].fdBuyDate;
								trHTML += '</td>';
								//责任人
								trHTML += '<td>';
								trHTML += '<input type="hidden" name="fdApplyDealListForms['
										+ trIndex
										+ '].fdResponsiblePersonId" value="'
										+ results[i].fdResponsiblePersonId
										+ '"/>';
								trHTML += results[i].fdResponsiblePersonName;				
								trHTML += '</td>';
								
								//存放地点
								trHTML += '<td>';
								trHTML += '<input type="hidden" name="fdApplyDealListForms['
										+ trIndex
										+ '].fdAssetAddressId" value="'
										+ results[i].fdAssetAddressId
										+ '"/>';
								trHTML += results[i].fdAssetAddressName;
								trHTML += '</td>';
								
								//原值
								trHTML += '<td>';
								trHTML += '<input type="hidden" style="width:80%" readonly="readonly" name="fdApplyDealListForms['+trIndex+'].fdFirstValue" value="'+results[i].fdCardFirstValue+'"/>';
								trHTML += new Number(results[i].fdCardFirstValue==''?0:results[i].fdCardFirstValue).toFixed(2);					
								trHTML += '</td>';
								
								//净值
								trHTML += '<td>';
								trHTML += '<INPUT  class=inputsgl type="text" style="WIDTH: 80%" name="fdApplyDealListForms[' + trIndex + '].fdNetValue" maxlength="36" validate="currency-dollar min(0)" />';
								trHTML += '</td>';
								//残值
								trHTML += '<td>';
								trHTML += '<INPUT class=inputsgl type="text" style="WIDTH: 80%" name="fdApplyDealListForms[' + trIndex + '].fdRemainValue" maxlength="36" validate="currency-dollar min(0)" />';
								trHTML += '</td>';
								//报废变卖值
								trHTML += '<td>';
								trHTML += '<INPUT class=inputsgl type="text" style="WIDTH: 80%" name="fdApplyDealListForms[' + trIndex + '].fdDealMoney" maxlength="36" validate="currency-dollar min(0)" onblur="calculteNewTotal();"/>';
								trHTML += '</td>';
								//资产处置方式
								trHTML += '<td><xform:select property="fdApplyDealListForms[' + trIndex + '].fdDealType"><xform:enumsDataSource enumsType="km_asset_apply_deal_fd_deal_type" /></xform:select></td>';
								//备注文本
								trHTML += '<td>';
								trHTML += '<INPUT class=inputsgl type="text" style="WIDTH: 80%" name="fdApplyDealListForms[' + trIndex + '].fdRemark" maxlength="500"/>';
								trHTML += '</td>';

								//操作
								trHTML += '<td class="td_normal_title" align="center">';
								trHTML += '<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="deleteRow('+trIndex+');">';
								trHTML += '</td>';

								$("#divertlistTB").append(trHTML);
								trIndex++;
								fdOrder++;
								trCardIds += results[i].fdCardId+",";
								
							}
						}
						//原值总计
						calculteOldTotal();
					}

				});
		} else {
			return false;
		}
	},{width:900,height:550});
  });
}
	function selectCard() {
		showAssetCardList("1,2,3,4");
	}
</script>
<table class="tb_normal" width=100%>
    <c:if test="${empty JsParam.fdDetailId}">
	    <tr>
	     <td width="8%"  class="tr_normal_title">
	            <bean:message bundle="km-asset" key="kmAssetApplyBase.selectAsset"/>           
	    </td>
	    <td>
	           <input type=button class="lui_form_button" value="<bean:message key="button.select"/>" onclick="selectCard('1,2,3,4');">
	    </td>
	    </tr>
    </c:if>
</table>
<table class="tb_normal" width=100% id="divertlistTB">
	<tr>
	    <td  class="td_normal_title" align="center" width="10px"> 
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="7%"> 
			<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="7%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="10%">
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
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 净值 -->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdNetValue"/>
		</td>
		<!-- 残值 -->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemainValue"/>
		</td>
		<!-- 报废变卖值 -->
		<td class="td_normal_title" align="center" width="7%">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdDealMoney"/>
		</td>
		<!--资产处置方式-->
		<td class="td_normal_title" width=9%>
			<bean:message bundle="km-asset" key="kmAssetApplyDeal.fdDealType" />
		</td>
		<!-- 备注文本 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyDealList.fdRemark"/>
		</td>
		<!-- 操作 -->
		<td class="td_normal_title" align="center" width="4%">
			<bean:message bundle="km-asset" key="kmAssetApplyRentList.control"/>
		</td>
	</tr>


<c:forEach items="${kmAssetApplyDealForm.fdApplyDealListForms}"
		var="kmAssetApplyDealListForm" varStatus="vstatus">
	<tr align="center">
	    <td>${vstatus.index+1}</td>
		<td>
		    <html:hidden property="fdApplyDealListForms[${vstatus.index}].fdApplyDealId" value="${kmAssetApplyDealForm.fdId}"/>
		    <html:hidden property="fdApplyDealListForms[${vstatus.index}].fdTaskDetailRef" value="${kmAssetApplyDealListForm.fdTaskDetailRef}"/>
		    <html:hidden property="fdApplyDealListForms[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyDealListForm.fdAssetCardId}"/>
		  <!--  编码  -->
		    <xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdCardNo" value="${kmAssetApplyDealListForm.fdCode}" showStatus="view"/>
		 </td>
		 
		 <td>   
		 <!-- 卡片名称 -->
		     <xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdAssetCardName" value="${kmAssetApplyDealListForm.fdAssetCardName}" showStatus="view"/>
		 </td>
		 
		 <td> 
		  <!--  资产类别  -->
	        <xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdAssetCategoryName" value="${kmAssetApplyDealListForm.fdAssetCategoryName}" showStatus="view"/>
		</td> 
		
		<td> 
		 <!--  规格型号  -->
		    <xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdStandard" value="${kmAssetApplyDealListForm.fdStandard}" showStatus="view"/>
		</td> 
			
		<td> 
			 <!--  采购日期 -->
			 <xform:datetime  style="width:80%"  showStatus="view" dateTimeType="date" property="fdApplyDealListForms[${vstatus.index}].fdBuyDate" value="${kmAssetApplyDealListForm.fdBuyDate}"/>
		</td> 	
			<td> 
			 <!--  责任人  -->
			 <xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdResponsiblePersonName" value="${kmAssetApplyDealListForm.fdResponsiblePersonName}" showStatus="view"/>
		</td> 	
			<td> 
			 <!--  存放地点 -->
			 <xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdAssetAddressName" value="${kmAssetApplyDealListForm.fdAssetAddressName}" showStatus="view"/>
		</td> 	
			<td> 
			  <!-- 原值  -->
			<xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdFirstValue" value="${kmAssetApplyDealListForm.fdFirstValue}" showStatus="noShow"/>
		     <c:out value="${kmAssetApplyDealListForm.fdFirstValue}"></c:out>
		</td> 	
			<td> 
			 <!--  净值  -->
			<xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdNetValue" validators="currency-dollar min(0)"/>
		</td> 	
		
			<td> 
			 <!--  残值  -->
			<xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdRemainValue" validators="currency-dollar min(0)"/>
		</td> 	
		
			<td> 
			 <!--  报废变卖值  -->
			<xform:text  style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdDealMoney" validators="currency-dollar min(0)" onValueChange="calculteNewTotal();"/>
		</td>
		<td>
			<!--资产处置方式-->
			<xform:select property="fdApplyDealListForms[${vstatus.index}].fdDealType">
						<xform:enumsDataSource
							enumsType="km_asset_apply_deal_fd_deal_type" />
			</xform:select>
		</td>
		<td>
			 <!--  备注文本 -->
			<xform:text style="width:80%" property="fdApplyDealListForms[${vstatus.index}].fdRemark" value="${kmAssetApplyDealListForm.fdRemark}"/>
		</td> 
		     <!--  操作 -->
		<td class="td_normal_title" align="center" >
			<img src="${KMSS_Parameter_StylePath}icons/delete.gif"
						style="cursor:pointer" onclick="deleteRow(${vstatus.index});">
		</td>
	</tr>
	<script>
		    trIndex++;
		    fdOrder++;
		    trCardIds += "${kmAssetApplyDealListForm.fdAssetCardId},";
	</script>
	</c:forEach>
</table>
