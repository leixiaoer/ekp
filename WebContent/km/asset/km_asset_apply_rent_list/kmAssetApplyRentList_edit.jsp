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
		    var cardId=document.getElementsByName("fdApplyRentListForms["+ i+ "].fdAssetCardId")[0].value;  
	        trCardIds = trCardIds.replace(cardId,"");
			
			var optTR = DocListFunc_GetParentByTagName("TR");
			var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
			//var DocList_TableInfo = new Array;
			//var tbInfo = DocList_TableInfo[optTB.id];
			var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
			optTB.deleteRow(rowIndex);
			fdOrder--;
			refreshTbIndex(optTB, rowIndex);
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

		 seajs.use(['lui/dialog'], function(dialog){
				window.dialog=dialog;
		 });

	//选择卡片
	function showAssetCardList(value){
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
		data.SendToUrl(url, function(data) {
			var results = eval("(" + data.responseText + ")");
			if (results.length > 0) {
				for(var i=0;i<results.length;i++){
					if (trCardIds.indexOf(
							results[i].fdCardId, 0) == -1) {
					trHTML = '<tr align="center">';
					trHTML += '<input type="hidden" name="fdApplyRentListForms['+ trIndex +'].fdApplyRentId" value="${kmAssetApplyRentForm.fdId}"/>';
					trHTML += '<input type="hidden" name="fdApplyRentListForms['+ trIndex +'].fdAssetCardId" value="'+results[i].fdCardId+'"/>';
                   	trHTML += '<td>'+(fdOrder+1)+'</td>';
                     //资产编号
					trHTML += '<td>';
				    trHTML += results[i].fdCardCode;
					trHTML += '</td>';
					
					 //资产名称
					trHTML += '<td>';
					trHTML += results[i].fdCardName;
					trHTML += '</td>';
					
					 //资产类别
					trHTML += '<td>';
					trHTML += results[i].fdAssetCategoryName;
					trHTML += '<input type="hidden" name="fdApplyRentListForms['+ trIndex +'].fdAssetCategoryId" value="'+results[i].fdAssetCategoryId+'"/>';
					trHTML += '</td>';
					
					 //规格型号
					trHTML += '<td>';
					trHTML += results[i].fdCardStandard;
					trHTML += '</td>';
					
					 //原值
					trHTML += '<td>';
				    trHTML += new Number(results[i].fdCardFirstValue==''?0:results[i].fdCardFirstValue).toFixed(2);
					trHTML += '</td>';		
								
					 //使用部门
					trHTML += '<td align="center">';
					trHTML += '<input type="hidden" name="fdApplyRentListForms['+ trIndex +'].fdOldDeptId" value="'+results[i].docDeptId+'"/>';
				    trHTML += results[i].docDeptName;
					trHTML += '</td>';	
									
					 //责任人
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdApplyRentListForms['+ trIndex +'].fdResponsiblePersonId" value="'+results[i].fdResponsiblePersonId+'"/>';
					trHTML += results[i].fdResponsiblePersonName;
					trHTML += '</td>';
					
					 //存放地点
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdApplyRentListForms['+ trIndex +'].fdAssetAddressId" value="'+results[i].fdAssetAddressId+'"/>';
					trHTML += results[i].fdAssetAddressName;
					trHTML += '</td>';
					
                    //操作
					trHTML += '<td align="center" class="td_normal_title">';
					trHTML += '<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="deleteRow('+trIndex+')">';
					trHTML += '</td>';
					$("#divertlistTB").append(trHTML);
					trIndex++;
					fdOrder++;
					trCardIds += ","
							+ results[i].fdCardId;
				}
		     	}
			}

		});
	  }else{
		  return false;
	  }
	},{width:900,height:550});
}
	function selectCard() {
		showAssetCardList("1,2,4");
	}
	
</script>
<table class="tb_normal" width=100%>
    <tr>
	    <td width="8%"  class="tr_normal_title">
	     	<bean:message bundle="km-asset" key="kmAssetApplyBase.selectAsset"/>           
	    </td>
	    <td>
	    	<input type=button class="lui_form_button" value="<bean:message key="button.select"/>" onclick="selectCard('1,2,4');">
	    </td>
    </tr>
</table>
<table class="tb_normal" width=100% id="divertlistTB" style="margin-bottom: -18">
	<tr>
		<td  class="td_normal_title" align="center" width="4%">
			<bean:message bundle="km-asset" key="kmAssetApplyRentList.fdOrder"/>
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
		<td class="td_normal_title" align="center" width="9%">
			<bean:message bundle="km-asset" key="kmAssetApplyChangeList.fdNewDept"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
		</td>
		<!-- 存放地点 -->
		<td class="td_normal_title" align="center" width="9%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
		</td>
		<!-- 操作 -->
		<td class="td_normal_title" align="center" width="4%">
			<bean:message bundle="km-asset" key="kmAssetApplyRentList.control"/>
		</td>
	</tr>
<c:forEach items="${kmAssetApplyRentForm.fdApplyRentListForms}" var="kmAssetApplyRentListForm" varStatus="vstatus">
	<tr align="center">
		<td>${vstatus.index+1}</td>
		<!--  编码  -->
		<td>
		    <html:hidden property="fdApplyRentListForms[${vstatus.index}].fdApplyRentId" value="${kmAssetApplyRentForm.fdId}"/>
		    <html:hidden property="fdApplyRentListForms[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyRentListForm.fdAssetCardId}"/>
		    <xform:text style="width:80%" property="fdApplyRentListForms[${vstatus.index}].fdCardNo" value="${kmAssetApplyRentListForm.fdCode}" showStatus="view"/>
		 </td>
		 <!-- 卡片名称 -->
		 <td>   
		    <xform:text style="width:80%" property="fdApplyRentListForms[${vstatus.index}].fdAssetCardName" value="${kmAssetApplyRentListForm.fdAssetCardName}" showStatus="view"/>
		 </td>
		<!--  资产类别  -->
		 <td> 
		    <xform:text style="width:80%" property="fdApplyRentListForms[${vstatus.index}].fdAssetCategoryName" value="${kmAssetApplyRentListForm.fdAssetCategoryName}" showStatus="view"/>
		</td> 
		<!--  规格型号  -->
		<td> 
		    <xform:text style="width:80%" property="fdApplyRentListForms[${vstatus.index}].fdStandard" value="${kmAssetApplyRentListForm.fdStandard}" showStatus="view"/>
		</td> 	
		<!-- 原值  -->
		<td> 
		   <xform:text style="width:80%" property="fdApplyRentListForms[${vstatus.index}].fdFirstValue" value="${kmAssetApplyRentListForm.fdFirstValue}" showStatus="view"/>
		</td> 	
		<!-- 使用部门  -->
		<td align="center"> 
			<xform:text style="width:80%" property="fdApplyRentListForms[${vstatus.index}].docDeptName" value="${kmAssetApplyRentListForm.docDeptName}" showStatus="view"/>
		</td>
		<!--  责任人  -->
		<td> 
			<xform:text style="width:80%" property="fdApplyRentListForms[${vstatus.index}].fdResponsiblePersonName" value="${kmAssetApplyRentListForm.fdResponsiblePersonName}" showStatus="view"/>
		</td> 	
		<!--  存放地点 -->
		<td> 
			<xform:text style="width:80%" property="fdApplyRentListForms[${vstatus.index}].fdAssetAddressName" value="${kmAssetApplyRentListForm.fdAssetAddressName}" showStatus="view"/>
		</td> 	
		<td align="center" class="td_normal_title"> 
			<!--  操作 -->
			<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="deleteRow(${vstatus.index});">
		</td> 	
	</tr>
	<script>
		    trIndex++;
		    fdOrder++;
		    trCardIds += "${kmAssetApplyRentListForm.fdAssetCardId},";
	</script>
	</c:forEach>
</table>
