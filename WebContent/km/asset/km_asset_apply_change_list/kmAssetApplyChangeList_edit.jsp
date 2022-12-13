<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script type="text/javascript">
	Com_IncludeFile("selectassetcarddialog.js",'${KMSS_Parameter_ContextPath}km/asset/resource/',null,true);
	Com_IncludeFile("doclist.js");
	Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath+ "km/asset/resource/", "js", true);
</script>
<script>
var trIndex = 0;
var fdOrder = 0;
var trCardIds = "";

function refreshTbIndex(optTB, rowIndex){
	for(var j = rowIndex; j<optTB.rows.length; j++){
		optTB.rows[j].cells[0].innerHTML = j;
	}		
}

	//删除一行
		function deleteRow(i) {
		    var cardId=document.getElementsByName("fdApplyChangeListForms["+ i+ "].fdAssetCardId")[0].value;  
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


		function SelectDept(i){
			Dialog_Address(false, "fdApplyChangeListForms["+i+"].fdNewDeptId", "fdApplyChangeListForms["+i+"].fdNewDeptName", null, ORG_TYPE_DEPT);
			
		}
		function SelectPerson(i){
			Dialog_Address(false, "fdApplyChangeListForms["+i+"].fdNewResponsiblePersonId", "fdApplyChangeListForms["+i+"].fdNewResponsiblePersonName", null, ORG_TYPE_PERSON);
		}
		function SelectAddress(i){
			selectResource("fdApplyChangeListForms["+i+"].fdNewAddressId","fdApplyChangeListForms["+i+"].fdNewAddressName");

		}

		 seajs.use(['lui/dialog'], function(dialog){
				window.dialog=dialog;
		 });

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
					data.SendToUrl(url, function(data) {
						var results = eval("(" + data.responseText + ")");
						if (results.length > 0) {
							for(var i=0;i<results.length;i++){
								if (trCardIds.indexOf(
										results[i].fdCardId, 0) == -1) {
								trHTML = '<tr align="center">';
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+ trIndex +'].fdApplyChangeId" value="${kmAssetApplyChangeForm.fdId}"/>';
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+ trIndex +'].fdAssetCardId" value="'+results[i].fdCardId+'"/>';
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
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+ trIndex +'].fdAssetCategoryId" value="'+results[i].fdAssetCategoryId+'"/>';
								trHTML += results[i].fdAssetCategoryName;
								trHTML += '</td>';
								 //规格型号
								trHTML += '<td>';
								trHTML += results[i].fdCardStandard;
								trHTML += '</td>';	
								 //使用部门
								trHTML += '<td>';
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+ trIndex +'].fdOldDeptId" value="'+results[i].docDeptId+'"/>';
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+trIndex+'].fdNewDeptId"  value="'+results[i].docDeptId+'"/>';
								trHTML += '<DIV onclick="SelectDept(\''+trIndex+'\');" class=inputselectsgl style="WIDTH: 85%"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" readonly="readonly" value="'+results[i].docDeptName+'" name=fdApplyChangeListForms['+trIndex+'].fdNewDeptName isChannel="true" onchange=""></DIV><DIV class=orgelement isChannel="true"></DIV></DIV>';
								trHTML += '</td>';				
								 //责任人
								trHTML += '<td>';
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+ trIndex +'].fdOldResponsiblePersonId" value="'+results[i].fdResponsiblePersonId+'"/>';
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+trIndex+'].fdNewResponsiblePersonId" value="'+results[i].fdResponsiblePersonId+'"/>';
								trHTML += '<DIV onclick="SelectPerson(\''+trIndex+'\');" class=inputselectsgl style="WIDTH: 85%"><DIV class=input style="WIDTH: 85px"><INPUT style="WIDTH: 80px" readonly="readonly" value="'+results[i].fdResponsiblePersonName+'" name=fdApplyChangeListForms['+trIndex+'].fdNewResponsiblePersonName isChannel="true"></DIV><DIV class=orgelement isChannel="true"></DIV></DIV>';
								trHTML += '</td>';
								 //存放地点
								trHTML += '<td>';
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+ trIndex +'].fdOldAddressId" value="'+results[i].fdAssetAddressId+'"/>';
								trHTML += '<input type="hidden" name="fdApplyChangeListForms['+trIndex+'].fdNewAddressId" value="'+results[i].fdAssetAddressId+'"/>';
								trHTML += '<DIV onclick="SelectAddress(\''+trIndex+'\');" class=inputselectsgl style="WIDTH: 85%"><DIV class=input style="WIDTH: 85px"><INPUT style="WIDTH: 80px" readonly="readonly"  name=fdApplyChangeListForms['+trIndex+'].fdNewAddressName isChannel="true" value="'+results[i].fdAssetAddressName+'"></DIV><DIV class=selectitem isChannel="true"></DIV></DIV>';
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
			 });
			 }
		
	//选择卡片
	function selectCard() {
		showAssetCardList("1,2,3,4");
	}
		
</script>
<table class="tb_normal" width=100%>
    <tr>
     <td width="8%"  class="tr_normal_title">
            <bean:message bundle="km-asset" key="kmAssetApplyBase.selectAsset"/>           
    </td>
    <td>
           <input type=button class="lui_form_button" value="<bean:message key="button.select"/>" onclick="selectCard('1,2,3,4');">
    </td>
    </tr>
</table>
<table class="tb_normal" width=100% id="divertlistTB" style="margin-bottom: -18">
	<tr>
	    <td  class="td_normal_title" align="center" width="4%">
			<bean:message bundle="km-asset" key="kmAssetApplyChangeList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="10%"> 
			<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
		</td>
		<!-- 使用部门-->
		<td class="td_normal_title" align="center" width="13%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDept"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
		</td>
		<!-- 存放地点 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
		</td>
		<!-- 操作 -->
		<td class="td_normal_title" align="center" width="4%">
			<bean:message bundle="km-asset" key="kmAssetApplyRentList.control"/>
		</td>
	
	</tr>

<c:forEach items="${kmAssetApplyChangeForm.fdApplyChangeListForms}"
		var="kmAssetApplyChangeListForm" varStatus="vstatus">
	<tr align="center"> 
	    <td>${vstatus.index+1}</td>
		<td>
		    <html:hidden property="fdApplyChangeListForms[${vstatus.index}].fdApplyChangeId" value="${kmAssetApplyChangeForm.fdId}"/>
		    <html:hidden property="fdApplyChangeListForms[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyChangeListForm.fdAssetCardId}"/>
		 <!-- 编码   -->
		    <xform:text  style="width:80%" property="fdApplyChangeListForms[${vstatus.index}].fdCardNo" value="${kmAssetApplyChangeListForm.fdCode}" showStatus="view"/>
		 </td>
		 <td>   
		  <!-- 卡片名称 -->
		   <xform:text  style="width:80%" property="fdApplyChangeListForms[${vstatus.index}].fdAssetCardName" value="${kmAssetApplyChangeListForm.fdAssetCardName}" showStatus="view"/>
		 </td>
		 <td> 
		    <!-- 资产类别  -->
		    <xform:text  style="width:80%" property="fdApplyChangeListForms[${vstatus.index}].fdAssetCategoryName" value="${kmAssetApplyChangeListForm.fdAssetCategoryName}" showStatus="view"/>
		</td> 
		<td> 
		   <!-- 规格型号 --> 
		   <xform:text  style="width:80%" property="fdApplyChangeListForms[${vstatus.index}].fdStandard" value="${kmAssetApplyChangeListForm.fdStandard}" showStatus="view"/>
		</td> 		
		<td> 
			  <!--  使用部门  -->
			<input type="hidden" name="fdApplyChangeListForms[${vstatus.index}].fdOldDeptId" value="${kmAssetApplyChangeListForm.fdOldDeptId}"/>
		    <xform:address propertyId="fdApplyChangeListForms[${vstatus.index}].fdNewDeptId" propertyName="fdApplyChangeListForms[${vstatus.index}].fdNewDeptName" showStatus="edit" orgType="ORG_TYPE_DEPT" style="width:90%" />
		</td>
		<td> 
			 <!--   责任人-->  
			<input type="hidden" name="fdApplyChangeListForms[${vstatus.index}].fdOldResponsiblePersonId" value="${kmAssetApplyChangeListForm.fdOldResponsiblePersonId}"/>
		    <xform:address propertyId="fdApplyChangeListForms[${vstatus.index}].fdNewResponsiblePersonId" propertyName="fdApplyChangeListForms[${vstatus.index}].fdNewResponsiblePersonName" showStatus="edit" orgType="ORG_TYPE_PERSON"  style="width:90%" />
		</td> 	
		<td> 
			  <!-- 存放地点 -->
			<input type="hidden" name="fdApplyChangeListForms[${vstatus.index}].fdOldAddressId" value="${kmAssetApplyChangeListForm.fdOldAddressId}"/>
		    <xform:dialog  propertyId="fdApplyChangeListForms[${vstatus.index}].fdNewAddressId" propertyName="fdApplyChangeListForms[${vstatus.index}].fdNewAddressName" style="width:90%" showStatus="edit" dialogJs="SelectAddress(${vstatus.index});"/>
		</td> 	       
		<td align="center" class="td_normal_title"> 
			 <!-- 操作 -->
			<img src="${KMSS_Parameter_StylePath}icons/delete.gif"
						style="cursor:pointer" onclick="deleteRow(${vstatus.index});">
		</td> 	
	</tr>
<script>
		    trIndex++;
		    fdOrder++;
		    trCardIds += "${kmAssetApplyChangeListForm.fdAssetCardId},";
	</script>
	</c:forEach>

</table>
