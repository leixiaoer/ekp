<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page  import="java.util.Date"%>
<%@ page  import="com.landray.kmss.util.UserUtil"%>
<script type="text/javascript">
	Com_IncludeFile("selectassetcarddialog.js",'${KMSS_Parameter_ContextPath}km/asset/resource/',null,true);
	Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath+ "km/asset/resource/", "js", true);
	Com_IncludeFile("jquery.js");
</script>
<script>

<% 
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
		java.util.Date currentDate = new java.util.Date();//得到当前系统时间 
		String str_date = formatter.format(currentDate); //将日期时间格式化 
		request.setAttribute("str_date",str_date);
		request.setAttribute("fdGetDeptId",UserUtil.getUser().getFdParent()!=null?UserUtil.getUser().getFdParent().getFdId():"");
		request.setAttribute("fdGetDeptName",UserUtil.getUser().getFdParent()!=null?UserUtil.getUser().getFdParent().getFdName():"");
		request.setAttribute("fdGetPersonId",UserUtil.getUser().getFdId());
		request.setAttribute("fdGetPersonName",UserUtil.getUser().getFdName());
%>

seajs.use(['lui/dialog'], function(dialog){
	window.dialog=dialog;
});

var trIndex = 0;
var fdOrder = 0;
var trCardIds = "";

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
			var date=new Date();
			var curDate="";
			if(Com_Parameter.Lang.indexOf("zh", 0) >-1){
				curDate = date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
			}else{
				curDate = (date.getMonth()+1)+'/'+date.getDate()+'/'+date.getFullYear();
			}
			if (results.length > 0) {
				for(var i=0;i<results.length;i++){
					if(trCardIds.indexOf(results[i].fdCardId, 0) == -1){
					trHTML = '<tr align="center">';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].nameId" value="${kmAssetApplyGetForm.fdId}"/>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdAssetCardId" value="'+results[i].fdCardId+'"/>';
					trHTML += '<td KMSS_IsRowIndex="1">'+(fdOrder+1)+'</td>';
					trHTML += '<td>';
					trHTML += ' <xform:text style="width:80%" showStatus="view" property="fdItems['+trIndex+'].fdCardNo" value="'+strutil.encodeHTML(results[i].fdCardCode)+'"/>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += strutil.encodeHTML(results[i].fdCardName);
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += results[i].fdAssetCategoryName;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += results[i].fdCardStandard;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += new Number(results[i].fdCardFirstValue==''?0:results[i].fdCardFirstValue).toFixed(2);
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<DIV onclick="selectDate(\'fdItems['+trIndex+'].fdGetDate\')" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" value='+curDate+' name=fdItems['+trIndex+'].fdGetDate validate="required"  subject="<%=ResourceUtil.getString(request,"kmAssetApplyGetList.fdGetDate","km-asset")%>"></DIV><DIV class=inputdatetime isChannel="true"></DIV><DIV class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 105px; WIDTH: 20px">*</DIV></DIV>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdGetDeptId" value="${fdGetDeptId}"/>';
					trHTML += '<DIV onclick="SelectDept(\''+trIndex+'\')" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" readonly="readonly" value="${fdGetDeptName}" name=fdItems['+trIndex+'].fdGetDeptName validate="required"  subject="<%=ResourceUtil.getString(request,"kmAssetApplyGetList.fdGetDept","km-asset")%>"></DIV><DIV class=orgelement isChannel="true"></DIV><DIV class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 105px; WIDTH: 20px">*</DIV></DIV>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdGetPersonId" value="${fdGetPersonId}"/>';
					trHTML += '<DIV onclick="SelectPerson(\''+trIndex+'\')" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" readonly="readonly" value="${fdGetPersonName}" name=fdItems['+trIndex+'].fdGetPersonName validate="required"  subject="<%=ResourceUtil.getString(request,"kmAssetApplyGetList.fdGetPerson","km-asset")%>"></DIV><DIV class=orgelement isChannel="true"></DIV><DIV class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 105px; WIDTH: 20px">*</DIV></DIV>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdAssetAddressId"  value="'+results[i].fdAssetAddressId+'"/>';
					trHTML += '<DIV onclick="SelectPlace(\''+trIndex+'\')" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" readonly="readonly"  name=fdItems['+trIndex+'].fdAssetAddressName validate="required"  subject="<%=ResourceUtil.getString(request,"kmAssetApplyGetList.fdAssetAddress","km-asset")%>"></DIV><DIV class=selectitem isChannel="true"></DIV><DIV class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 105px; WIDTH: 20px">*</DIV></DIV>';
					trHTML += '</td>';
					trHTML += '<td class="td_normal_title">';
					trHTML +='<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="DocList_DeleteRow('+trIndex+')">';
					trHTML += '</td>';
					trHTML += '</tr>';
					$("#getlistTB").append(trHTML);
					trIndex++;
					fdOrder++;
					trCardIds +=","+results[i].fdCardId;
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

	function selectCard() {
		showAssetCardList("1");
	}
	

	function SelectDept(i){
		Dialog_Address(false, "fdItems["+i+"].fdGetDeptId", "fdItems["+i+"].fdGetDeptName", null, ORG_TYPE_DEPT);
		$("INPUT[name='fdItems["+i+"].fdGetDeptName']").focus();
		$("INPUT[name='fdItems["+i+"].fdGetDeptName']").blur();
		
	}
	function SelectPerson(i){
		Dialog_Address(false, "fdItems["+i+"].fdGetPersonId", "fdItems["+i+"].fdGetPersonName", null, ORG_TYPE_PERSON);
		$("INPUT[name='fdItems["+i+"].fdGetPersonName']").focus();
		$("INPUT[name='fdItems["+i+"].fdGetPersonName']").blur();
	}
	function SelectPlace(i){
		selectResource("fdItems["+i+"].fdAssetAddressId","fdItems["+i+"].fdAssetAddressName",true);
	}

	function refreshTbIndex(tbId, rowIndex){
		var optTB = document.getElementById(tbId);
		for(var j = rowIndex; j<optTB.rows.length; j++){
			optTB.rows[j].cells[0].innerHTML = j;
		}		
	}
	function DocList_DeleteRow(i){
		var optTR = DocListFunc_GetParentByTagName("TR");
		var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
		var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
		var cardId = document.getElementsByName("fdItems["+i+"].fdAssetCardId")[0];
		trCardIds=trCardIds.replace(cardId.value, "");
		optTB.deleteRow(rowIndex);
		fdOrder--;
		refreshTbIndex("getlistTB", rowIndex);
		
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

	function batchFdDept()
	{
		Dialog_Address(false, "batchDeptId", "batchDeptName", null, ORG_TYPE_DEPT,function(){
			$("INPUT[name$='.fdGetDeptId']").val($("INPUT[name=batchDeptId]").val());
			$("INPUT[name$='.fdGetDeptName']").val($("INPUT[name=batchDeptName]").val());
			$("INPUT[name$='.fdGetDeptName']").focus();
			$("INPUT[name$='.fdGetDeptName']").blur();
		});
	}

	function batchFdPerson()
	{
		Dialog_Address(false, "batchPersonId", "batchPersonName", null, ORG_TYPE_PERSON,function(){
			$("INPUT[name$='.fdGetPersonId']").val($("INPUT[name=batchPersonId]").val());
			$("INPUT[name$='.fdGetPersonName']").val($("INPUT[name=batchPersonName]").val());
			$("INPUT[name$='.fdGetPersonName']").focus();
			$("INPUT[name$='.fdGetPersonName']").blur();
		});
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
			    $("INPUT[name$='.fdAssetAddressId']").val($("INPUT[name=batchAddressId]").val());
				$("INPUT[name$='.fdAssetAddressName']").val($("INPUT[name=batchAddressName]").val());
				$("INPUT[name$='.fdAssetAddressName']").focus();
				$("INPUT[name$='.fdAssetAddressName']").blur();
		 },{width:650,height:550});
	  });
	}
	
</script>
<table class="tb_normal" width=100%>
    <tr>
    <td  class="tr_normal_title" width="8%">
        <bean:message bundle="km-asset" key="kmAssetApplyBase.selectAsset"/>
    </td>
    <td>
         <input type=button class="lui_form_button" value="<bean:message key="button.select"/>"
			onclick="selectCard();">
    </td>
    </tr>
</table>
<table class="tb_normal" width=100% id="getlistTB" >
	<tr>
		<td  class="td_normal_title" align="center" width="10px"> 
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="8%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdNo"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="17%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="10%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="11%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdStandard"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 领用日期 -->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDate"/>
		</td>
		<!--资产使用部门 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetDept"/>
		</td>
		<!-- 责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdGetPerson"/>
		</td>
		<!-- 存放地点 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyGetList.fdAssetAddress"/>
		</td>
		<td class="td_normal_title" align="center" >
			<bean:message bundle="km-asset" key="kmAssetApplyIn.operate"/>
		</td>
	</tr>
	<c:forEach items="${kmAssetApplyGetForm.fdItems}"
		var="kmAssetApplyGetListForm" varStatus="vstatus">
	<tr align="center">
     	<td>${vstatus.index+1}</td>
		<td>
		    <html:hidden property="fdItems[${vstatus.index}].nameId" value="${kmAssetApplyGetForm.fdId}"/>
		    <html:hidden property="fdItems[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyGetListForm.fdAssetCardId}"/>
		    <xform:text  property="fdItems[${vstatus.index}].fdCardNo" value="${kmAssetApplyGetListForm.fdCardNo}" style="width:80%" showStatus="view"/>
		 </td>
		 <td>   
		    <xform:text  property="fdItems[${vstatus.index}].fdAssetCardName" value="${kmAssetApplyGetListForm.fdAssetCardName}" style="width:80%" showStatus="view"/>
		 </td>
		 <td> 
			 <xform:text  property="fdItems[${vstatus.index}].fdCardCate" value="${kmAssetApplyGetListForm.fdCardCate}" style="width:80%" showStatus="view"/>
		</td> 
		<td> 
			 <xform:text  property="fdItems[${vstatus.index}].fdCardStandard" value="${kmAssetApplyGetListForm.fdCardStandard}"  style="width:80%" showStatus="view"/>
		</td> 	
		<td> 
			 <xform:text  property="fdItems[${vstatus.index}].fdFirstValue" value="${kmAssetApplyGetListForm.fdFirstValue}" style="width:80%" showStatus="view"/>
		</td> 	
		<td> 
			<xform:datetime property="fdItems[${vstatus.index}].fdGetDate" showStatus="edit" style="width:90%" dateTimeType="date" value="${kmAssetApplyGetListForm.fdGetDate}" required="true"/>
		</td> 	
		<td> 	
			 <xform:address propertyId="fdItems[${vstatus.index}].fdGetDeptId" propertyName="fdItems[${vstatus.index}].fdGetDeptName" showStatus="edit" orgType="ORG_TYPE_DEPT" validators="required" required="true" style="width:90%" />
		</td> 	
		<td> 
			 <xform:address propertyId="fdItems[${vstatus.index}].fdGetPersonId" propertyName="fdItems[${vstatus.index}].fdGetPersonName" showStatus="edit" orgType="ORG_TYPE_PERSON" validators="required" required="true" style="width:90%" />
		</td> 
		<td> 
			<xform:dialog  propertyId="fdItems[${vstatus.index}].fdAssetAddressId" propertyName="fdItems[${vstatus.index}].fdAssetAddressName" showStatus="edit" style="width:90%" validators="required" required="true"  dialogJs="SelectPlace(${vstatus.index});"/>
		</td> 
		<td class="td_normal_title" align="center" >
			<img src="${KMSS_Parameter_StylePath}icons/delete.gif"
						style="cursor:pointer" onclick="DocList_DeleteRow(${vstatus.index});">
		</td>
	</tr>
	    <script>
		    trIndex++;
		    fdOrder++;
		    trCardIds += "${kmAssetApplyDivertListForm.fdAssetCardId},";
		</script>
	</c:forEach>
</table>

<table class="tb_normal" width=100% id="bathTable" >
	<tr align="right"">
		<!-- 资产编码 -->
		<td align="right"" width="66%" colspan="10">
			<!--资产使用部门 -->
				<input type=button class="lui_form_button" style="padding:2px;" value="<bean:message bundle="km-asset" key="batch.fdDept"/>"
				onclick="batchFdDept();">
			<!-- 责任人 -->
				<input type=button class="lui_form_button" style="padding:2px;" value="<bean:message bundle="km-asset" key="batch.fdPerson"/>"
				onclick="batchFdPerson();">
			<!-- 存放地点 -->
				<input type=button class="lui_form_button" style="padding:2px;" value="<bean:message bundle="km-asset" key="batch.fdAddress"/>"
				onclick="batchFdAddress();">
		</td>
	</tr>
</table>
<input type="hidden" name="batchDeptId" />
<input type="hidden" name="batchDeptName" />
<input type="hidden" name="batchPersonId" />
<input type="hidden" name="batchPersonName" />
<input type="hidden" name="batchAddressId" />
<input type="hidden" name="batchAddressName" />
