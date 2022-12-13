<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script type="text/javascript">
	Com_IncludeFile("selectassetcarddialog.js",'${KMSS_Parameter_ContextPath}km/asset/resource/',null,true);
	Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath
			+ "km/asset/resource/", "js", true);
	Com_IncludeFile("doclist.js");
</script>
<script> 
var trIndex = 0;
var trCardIds = "";
var fdOrder = 0;
//地址选择
function SelectAddress(i){
	selectResource("fdApplyReturnListForms["+i+"].fdAddressId","fdApplyReturnListForms["+i+"].fdAddressName");
	$("INPUT[name='fdItems["+i+"].fdAddressName']").focus();
	$("INPUT[name='fdItems["+i+"].fdAddressName']").blur();

}
	function refreshTbIndex(optTB, rowIndex){
		for(var j = rowIndex; j<optTB.rows.length; j++){
			optTB.rows[j].cells[0].innerHTML = j;
		}		
	}
	//删除一行
		function deleteRow(i) {
		    var cardId=document.getElementsByName("fdApplyReturnListForms["+ i+ "].fdAssetCardId")[0].value;  
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
 		if (null!= ids&& undefined !=ids){
			var data = new KMSSData();
		    var url = "${KMSS_Parameter_ContextPath}km/asset/km_asset_card/kmAssetCard.do?method=loadAssetCard&ids="
				+ ids;
			var curDate="${JsParam.currDate}";
		data.SendToUrl(url, function(data) {
			var results = eval("(" + data.responseText + ")");
			if (results.length > 0) {		
				for(var i=0;i<results.length;i++){
					if (trCardIds.indexOf(
							results[i].fdCardId, 0) == -1) {
					trHTML = '<tr align="center">';
					trHTML += '<input type="hidden" name="fdApplyReturnListForms['+ trIndex +'].fdApplyReturnId" value="${kmAssetApplyReturnForm.fdId}"/>';
					trHTML += '<input type="hidden" name="fdApplyReturnListForms['+ trIndex +'].fdAssetCardId" value="'+results[i].fdCardId+'"/>';
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
					trHTML += '<input type="hidden" name="fdApplyReturnListForms['+ trIndex +'].fdAssetCategoryId" value="'+results[i].fdAssetCategoryId+'"/>';
					trHTML += results[i].fdAssetCategoryName;
					trHTML += '</td>';
					
					 //规格型号
					trHTML += '<td>';
					trHTML += results[i].fdCardStandard;
					trHTML += '</td>';
					
					 //原值
					trHTML += '<td>';
					trHTML += new Number(results[i].fdCardFirstValue==''?0:results[i].fdCardFirstValue).toFixed(2);
					trHTML += '</td>';	
															
					 //归还日期
					trHTML += '<td>';
					trHTML += '<DIV onclick="selectDate(\'fdApplyReturnListForms['+trIndex+'].fdDate\')" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" value='+curDate+' name=fdApplyReturnListForms['+trIndex+'].fdDate validate="required" subject="<%=ResourceUtil.getString(request,"kmAssetApplyReturnList.fdDate","km-asset")%>"></DIV><DIV class=inputdatetime isChannel="true"></DIV><DIV class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 110px; WIDTH: 20px">*</DIV></DIV>';
					trHTML += '</td>';		
								
					 //归还后存放地点
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdApplyReturnListForms['+ trIndex +'].fdAddressId"/>';
					trHTML += '<DIV onclick="SelectAddress(\''+trIndex+'\')" class=inputselectsgl style="WIDTH: 110px;"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" readonly="readonly"  name=fdApplyReturnListForms['+trIndex+'].fdAddressName validate="required" subject="<%=ResourceUtil.getString(request,"kmAssetApplyReturnList.fdAddress","km-asset")%>"></DIV><DIV class=selectitem isChannel="true"></DIV><DIV class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 110px; WIDTH: 20px">*</DIV></DIV>';
					trHTML += '</td>';			
                    //操作
					trHTML += '<td class="td_normal_title">';
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
		showAssetCardList("2,3");
	}

	function batchFdAddress()
	{
		//selectResource("batchAddressId","batchAddressName");
		seajs.use(['lui/jquery','lui/dialog'], function($,dialog){
			 var  path= Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/asset/km_asset_address/kmAssetAddress.do?method=showAddress';
			 dialog.iframe(path,Data_GetResourceString("km-asset:kmAssetAddress.selectAddress"),function(rtn){
			 if(jQuery.isArray(rtn)){
					var obj = document.getElementsByName("batchAddressId");
					obj[0].value = "";
					obj[0].value = rtn[0];
					obj = document.getElementsByName("batchAddressName");
					obj[0].value = "";
					obj[0].value = rtn[1];
				}else {
				 	if(rtn == "cancelselect"){
						obj = document.getElementsByName("batchAddressId")[0].value="";
						obj = document.getElementsByName("batchAddressName")[0].value="";
					}
				}
			    $("INPUT[name$='.fdAddressId']").val($("INPUT[name=batchAddressId]").val());
				$("INPUT[name$='.fdAddressName']").val($("INPUT[name=batchAddressName]").val());
				//手动触发校验
				$("INPUT[name$='.fdAddressName']").focus();
				$("INPUT[name$='.fdAddressName']").blur();
		 },{width:650,height:550});
	  });
	}
</script>
<table class="tb_normal" width=100%>
    <tr>
     <td width="8%"  class="tr_normal_title">
            <bean:message bundle="km-asset" key="kmAssetApplyBase.selectAsset"/>           
    </td>
    <td>
           <input type=button class="lui_form_button" value="<bean:message key="button.select"/>" onclick="selectCard('2,3');">
    </td>
    </tr>
</table>
<table class="tb_normal" width=100% id="divertlistTB">
	<tr>
	    <td  class="td_normal_title" align="center" width="4%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyReturnList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="8%"> 
			<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="18%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="16%">
			<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
		</td>	
		<!-- 归还日期-->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetApplyReturnList.fdDate"/>
		</td>
		<!-- 归还后存放地点 -->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetApplyReturnList.fdAddress"/>
		</td>
		<!-- 操作 -->
		<td class="td_normal_title" align="center" width="4%">
			<bean:message bundle="km-asset" key="kmAssetApplyRentList.control"/>
		</td>
	
	</tr>


<c:forEach items="${kmAssetApplyReturnForm.fdApplyReturnListForms}"
		var="kmAssetApplyReturnListForm" varStatus="vstatus">
	<tr align="center">
    	<td>${vstatus.index+1}</td>
		<td>
		    <html:hidden property="fdApplyReturnListForms[${vstatus.index}].fdApplyReturnId" value="${kmAssetApplyReturnForm.fdId}"/>
		    <html:hidden property="fdApplyReturnListForms[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyReturnListForm.fdAssetCardId}"/>
		  <!--编码  -->
		    <xform:text  style="width:80%" property="fdApplyReturnListForms[${vstatus.index}].fdCode" value="${kmAssetApplyReturnListForm.fdCode}" showStatus="view"/>
		 </td>
		 <td>   
		 <!-- 卡片名称 -->
		    <xform:text  style="width:80%" property="fdApplyReturnListForms[${vstatus.index}].fdAssetCardName" value="${kmAssetApplyReturnListForm.fdAssetCardName}" showStatus="view"/>
		 </td>
		 <td> 
		  <!--资产类别  -->
		   <xform:text  style="width:80%" property="fdApplyReturnListForms[${vstatus.index}].fdAssetCategoryName" value="${kmAssetApplyReturnListForm.fdAssetCategoryName}" showStatus="view"/>
		</td> 
		<td> 
		 <!--规格型号  -->
		   <xform:text  style="width:80%" property="fdApplyReturnListForms[${vstatus.index}].fdStandard" value="${kmAssetApplyReturnListForm.fdStandard}" showStatus="view"/>
		</td> 	
		<td> 
			  <!--原值  -->
		  <xform:text  style="width:80%" property="fdApplyReturnListForms[${vstatus.index}].fdFirstValue" value="${kmAssetApplyReturnListForm.fdFirstValue}" showStatus="view"/>
		</td> 	
		<td> 
			  <!--归还日期 -->
			<xform:datetime property="fdApplyReturnListForms[${vstatus.index}].fdDate" showStatus="edit" style="width:70%" dateTimeType="date" value="${kmAssetApplyReturnListForm.fdDate}"/>
		</td>
		<td> 
			 <!--归还后存放地点 -->
			<xform:dialog  propertyId="fdApplyReturnListForms[${vstatus.index}].fdAddressId" propertyName="fdApplyReturnListForms[${vstatus.index}].fdAddressName" style="width:85%" showStatus="edit" validators="required" required="true" dialogJs="SelectAddress(${vstatus.index});"/>
		</td> 	
		<td class="td_normal_title"> 
			 <!--操作 -->
				<img src="${KMSS_Parameter_StylePath}icons/delete.gif"
						style="cursor:pointer" onclick="deleteRow(${vstatus.index});">
		</td> 	
	</tr>
	<script>
		    trIndex++;
		    fdOrder++;
		    trCardIds += "${kmAssetApplyReturnListForm.fdAssetCardId},";
	</script>
	</c:forEach>
</table>
<table class="tb_normal" width=100% id="batchTB" >
	<tr align="right"">
		<td align="right">
		<!-- 批量存放地点 -->
			<input type=button class="lui_form_button" style="padding:2px;" value="<bean:message bundle="km-asset" key="batch.fdAddress"/>"
			onclick="batchFdAddress();">
		</td>
	</tr>
</table>
<input type="hidden" name="batchAddressId" />
<input type="hidden" name="batchAddressName" />

