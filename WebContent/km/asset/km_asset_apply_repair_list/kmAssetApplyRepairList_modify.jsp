<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/common.jsp"%>
<!--数字转中文JS  -->
<%@include file="/km/asset/resource/chinaValue.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script type="text/javascript">
	Com_IncludeFile("selectassetcarddialog.js",'${KMSS_Parameter_ContextPath}km/asset/resource/',null,true);
	Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath+ "km/asset/resource/", "js", true);
	Com_IncludeFile("dialog.js", "style/"+Com_Parameter.Style+"/dialog/");
</script>
<script type="text/javascript">
var trIndex = 0;
var trCardIds = "";
var fdRepairType='<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdRepairType"/>';
var fdMoney='<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdMoney"/>';
var fdForeignRepairAdd='<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdForeignRepairAdd"/>';

	function selectCard() {
		var ids = showAssetCardList("1,2,3");
		if ("" != ids){
			var data = new KMSSData();
		    var url = "${KMSS_Parameter_ContextPath}km/asset/km_asset_card/kmAssetCard.do?method=loadAssetCard&ids="
				+ ids;
		    data.SendToUrl(url, function(data) {
			var results = eval("(" + data.responseText + ")");
			if (results.length > 0) {
				for(var i=0;i<results.length;i++){
					if(trCardIds.indexOf(results[i].fdCardId, 0) == -1){
					trHTML = '<tr align="center">';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdApplyRepairId" value="${kmAssetApplyRepairForm.fdId}"/>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdAssetCardId" value="'+results[i].fdCardId+'"/>';
					trHTML += '<td>';
					trHTML += results[i].fdCardCode;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += results[i].fdCardName;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += results[i].fdCateName;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += results[i].fdCardStandard;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdFirstValue" value="'+(new Number(results[i].fdCardFirstValue==''?0:results[i].fdCardFirstValue).toFixed(2))+'"/>';
					trHTML += new Number(results[i].fdCardFirstValue==''?0:results[i].fdCardFirstValue).toFixed(2);
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdResponsiblePersonId" value="'+results[i].fdResponsiblePersonId+'"/>';
					trHTML += results[i].fdResponsiblePersonName;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<xform:text style="width:80%" subject="'+fdRepairType+'"  showStatus="edit" property="fdItems['+trIndex+'].fdRepairType" />';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<xform:text style="width:80%" subject="'+fdMoney+'"  showStatus="edit" property="fdItems['+trIndex+'].fdMoney"  value=""  onValueChange="calPercent('+trIndex+');void" validators="currency-dollar"/>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="text"  class="inputread" style="width:80%" value=""  name="fdItems['+trIndex+'].fdDegree" readonly="readonly"/>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<xform:text style="width:80%" subject="'+fdForeignRepairAdd+'"  showStatus="edit" property="fdItems['+trIndex+'].fdForeignRepairAdd" />';
					trHTML += '</td>';
					trHTML += '<td class="td_normal_title">';
					trHTML +='<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="DocList_Delete('+trIndex+')">';
					trHTML += '</td>';
					trHTML += '</tr>';
					$("#RepairlistTB").append(trHTML);
					trIndex++;
					trCardIds +=","+results[i].fdCardId;
		     	}
			   }
			}
		});
	  }else{
		  return false;
	  }
	}
</script>

<script type="text/javascript">

	//求原值百分比
	function calPercent(i){
	var fee = document.getElementsByName("fdItems["+i+"].fdMoney")[0].value;
	var firstVal = document.getElementsByName("fdItems["+i+"].fdFirstValue")[0].value;
	if(firstVal!= '' && firstVal!=0){
		var a = (parseFloat(fee)/parseFloat(firstVal))*100;
		if(!isNaN(a)){
		 document.getElementsByName("fdItems["+i+"].fdDegree")[0].value = a.toFixed(2)+'%';
		}
	}
	 var sum=DocList_GetSum(document.getElementById("RepairlistTB"),/fdItems\[\d+\]\.fdMoney/);
	 if(!isNaN(sum)){
	 	document.getElementsByName("fdTotalMoney")[0].value = sum+"%";
	 	}
	 //并计算总和
	 calTotalAll();
	}

	//求耗材+明细总计
   function calTotalAll(){
	   var totalMoney=document.getElementsByName("fdTotalMoney")[0];
		//耗材明细总和
		var expendTotal=DocList_GetSum(document.getElementById("TABLE_DocList"),/fdExpendItems\[\d+\]\.fdSubTotal/);
		//维修明细总和
		var repairTotal=DocList_GetSum(document.getElementById("RepairlistTB"),/fdItems\[\d+\]\.fdMoney/);
		totalMoney.value = new Number(expendTotal+repairTotal).toFixed(2);
		//更新中文数字
		var chinaValue=document.getElementById("chinaValue");
		chinaValue.innerHTML=showChinaValue(totalMoney.value);
   }
	//删除一行
	function DocList_Delete(i){
		var optTR = DocListFunc_GetParentByTagName("TR");
		var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
		var DocList_TableInfo = new Array;
		var tbInfo = DocList_TableInfo[optTB.id];
		var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
		var cardId = document.getElementsByName("fdItems["+i+"].fdAssetCardId")[0];
		trCardIds=trCardIds.replace(cardId.value, "");
		optTB.deleteRow(rowIndex);
		calTotalAll();
		
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
<table class="tb_normal" width=100% id="RepairlistTB" >
	<tr>
		<!-- 资产编码 -->
		<td  class="td_normal_title" width="8%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdNo"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdStandard"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdGetPerson"/>
		</td>
		<!-- 维修方式 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdRepairType"/>
		</td>
		<!--维修费用 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdMoney"/>
		</td>
		<!-- 占原值百分比 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdDegree"/>
		</td>
		<!-- 外部维修单位-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyRepairList.fdForeignRepairAdd"/>
		</td>
		<td class="td_normal_title" align="center" >
			操作
		</td>
	</tr>
	<c:forEach items="${kmAssetApplyRepairForm.fdItems}"
		var="kmAssetApplyRepairListForm" varStatus="vindex">
	<tr align="center">
		<td>
		    <html:hidden property="fdItems[${vindex.index}].fdApplyRepairId" value="${kmAssetApplyRepairForm.fdId}"/>
		    <html:hidden property="fdItems[${vindex.index}].fdAssetCardId" value="${kmAssetApplyRepairListForm.fdAssetCardId}"/>
		   <xform:text showStatus="view" property="fdItems[${vindex.index}].fdCardNo" value="${kmAssetApplyRepairListForm.fdCardNo}" style="width:80%" />
		 </td>
		 <td>   
		     <xform:text showStatus="view" property="fdItems[${vindex.index}].fdAssetCardName" value="${kmAssetApplyRepairListForm.fdAssetCardName}" style="width:80%" />
		 </td>
		 <td> 
			<xform:text showStatus="view" property="fdItems[${vindex.index}].fdCardCate" value="${kmAssetApplyRepairListForm.fdCardCate}" style="width:80%" />
		</td> 
		<td> 
			<xform:text showStatus="view" property="fdItems[${vindex.index}].fdCardStandard" value="${kmAssetApplyRepairListForm.fdCardStandard}"  style="width:80%" />
		</td> 	
		<td> 
		    <input type="hidden" name="fdItems[${vindex.index}].fdFirstValue" value="${kmAssetApplyRepairListForm.fdFirstValue}"/>
			${kmAssetApplyRepairListForm.fdFirstValue}
		</td> 
		<td> 
		     <input type="hidden" name="fdItems[${vindex.index}].fdResponsiblePersonId" value="${kmAssetApplyRepairListForm.fdResponsiblePersonId}"/>
			 <xform:text showStatus="view" style="width:70px" property="fdItems[${vindex.index}].fdResponsiblePersonName" value="${kmAssetApplyRepairListForm.fdResponsiblePersonName}"/>
		</td> 
		<td> 
			<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairList.fdRepairType","km-asset")%>' property="fdItems[${vindex.index}].fdRepairType"  style="width:80%" showStatus="edit"/>
		</td>
		<td> 
			<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairList.fdMoney","km-asset")%>' property="fdItems[${vindex.index}].fdMoney" value="" style="width:80%" validators="currency-dollar" onValueChange="calPercent(${vindex.index});void"  showStatus="edit"/>
		</td>
		<td> 
			<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairList.fdDegree","km-asset")%>' property="fdItems[${vindex.index}].fdDegree" value="" style="width:80%" htmlElementProperties="readonly='readonly'" className="inputread" showStatus="edit"/>
		</td>
		<td> 
			<xform:text subject='<%=ResourceUtil.getString(request,"kmAssetApplyRepairList.fdForeignRepairAdd","km-asset")%>' property="fdItems[${vindex.index}].fdForeignRepairAdd" style="width:80%" showStatus="edit"/>
		</td>
		<td>
		<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="DocList_Delete(${vindex.index})">
		</td>
	</tr>
	    <script>
		    trIndex++;
		    trCardIds += "${kmAssetApplyDivertListForm.fdAssetCardId},";
		</script>
	</c:forEach>
</table>
<%@ include file="/resource/jsp/edit_down.jsp"%>