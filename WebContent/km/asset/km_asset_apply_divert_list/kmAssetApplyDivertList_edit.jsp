<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page  import="java.util.Date"%>
<%@ page  import="com.landray.kmss.util.UserUtil"%>
<script type="text/javascript">
	Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath+ "km/asset/resource/", "js", true);
 	Com_IncludeFile('calendar.js|jquery.js');
</script>
<script>

<% 
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
		java.util.Date currentDate = new java.util.Date();//得到当前系统时间 
		String str_date = formatter.format(currentDate); //将日期时间格式化 
		request.setAttribute("str_date",str_date);
		request.setAttribute("fdNowDeptId",UserUtil.getUser().getFdParent()!=null?UserUtil.getUser().getFdParent().getFdId():"");
		request.setAttribute("fdNowDeptName",UserUtil.getUser().getFdParent()!=null?UserUtil.getUser().getFdParent().getFdName():"");
		request.setAttribute("fdNowPersonId",UserUtil.getUser().getFdId());
		request.setAttribute("fdNowPersonName",UserUtil.getUser().getFdName());
%>

var trIndex = 0;
var fdOrder = 0;
var trCardIds = "";

		function SelectDept(i){
			Dialog_Address(false, "fdItems["+i+"].fdNowDeptId", "fdItems["+i+"].fdNowDeptName", null, ORG_TYPE_DEPT);
			$("INPUT[name='fdItems["+i+"].fdNowDeptName']").focus();
			$("INPUT[name='fdItems["+i+"].fdNowDeptName']").blur();
		}
		function SelectPerson(i){
			Dialog_Address(false, "fdItems["+i+"].fdNowPersonId", "fdItems["+i+"].fdNowPersonName", null, ORG_TYPE_PERSON);
			$("INPUT[name='fdItems["+i+"].fdNowPersonName']").focus();
			$("INPUT[name='fdItems["+i+"].fdNowPersonName']").blur();
		}
		function SelectPlace(i){
			selectResource("fdItems["+i+"].fdNewAddressId","fdItems["+i+"].fdNewAddressName",true);
		}
		 seajs.use(['lui/dialog'], function(dialog){
				window.dialog=dialog;
		 });
		 
	function loadCardContent(ids){
		seajs.use(['lui/util/str'], function(strutil){
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
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdApplyDivertId" value="${kmAssetApplyDivertForm.fdId}"/>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdAssetCardId" value="'+results[i].fdCardId+'"/>';
					trHTML += '<td>'+(fdOrder+1)+'</td>';
					trHTML += '<td>';
					trHTML += strutil.encodeHTML(results[i].fdCardCode);
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
					trHTML += '<DIV onclick="selectDate(\'fdItems['+trIndex+'].fdDivertDate\',null,function(c){__CallXFormDateTimeOnValueChange(c,__xformDispatch);})" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" value='+curDate+' name=fdItems['+trIndex+'].fdDivertDate validate="required"  subject="<%=ResourceUtil.getString(request,"kmAssetApplyDivertList.fdDivertDate","km-asset")%>"></DIV><DIV class=inputdatetime isChannel="true"></DIV><DIV class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 105px; WIDTH: 20px;">*</DIV></DIV>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdOldDeptId" value="'+results[i].docDeptId+'"/>';
					trHTML += results[i].docDeptName;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdNowDeptId" value=""/>';
					trHTML += '<DIV onclick="SelectDept(\''+trIndex+'\');setTextRequired();" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" readonly="readonly" value="" name=fdItems['+trIndex+'].fdNowDeptName  subject="<%=ResourceUtil.getString(request,"kmAssetApplyDivertList.fdNowDept","km-asset")%>"  onchange="setTextRequired();"></DIV><DIV class=orgelement isChannel="true"></DIV><DIV id="div1'+trIndex+'" class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 100px; WIDTH: 20px;display: none">*</DIV></DIV>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdGetPersonId" value="'+results[i].fdResponsiblePersonId+'"/>';
					trHTML += results[i].fdResponsiblePersonName;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdNowPersonId" value=""/>';
					trHTML += '<DIV onclick="SelectPerson(\''+trIndex+'\');setTextRequired();" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" readonly="readonly" value="" name=fdItems['+trIndex+'].fdNowPersonName subject="<%=ResourceUtil.getString(request,"kmAssetApplyDivertList.fdNowPerson","km-asset")%>" onchange="setTextRequired();"></DIV><DIV class=orgelement isChannel="true"></DIV><DIV id="div2'+trIndex+'" class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 100px; WIDTH: 20px;display: none">*</DIV></DIV>';
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdOldAddressId" value="'+results[i].fdAssetAddressId+'"/>';
					trHTML += results[i].fdAssetAddressName;
					trHTML += '</td>';
					trHTML += '<td>';
					trHTML += '<input type="hidden" name="fdItems['+trIndex+'].fdNewAddressId"/>';
					trHTML += '<DIV onclick="SelectPlace(\''+trIndex+'\');setTextRequired();" class=inputselectsgl style="WIDTH: 110px"><DIV class=input style="WIDTH: 105px"><INPUT style="WIDTH: 100px" readonly="readonly"  name=fdItems['+trIndex+'].fdNewAddressName subject="<%=ResourceUtil.getString(request,"kmAssetApplyDivertList.fdNewAddress","km-asset")%>" onchange="setTextRequired();"></DIV><DIV class=selectitem isChannel="true"></DIV><DIV id="div3'+trIndex+'" class=txtstrong style="HEIGHT: 100%; POSITION: absolute; LEFT: 100px; WIDTH: 20px;display: none">*</DIV></DIV>';
					trHTML += '</td>';
					trHTML += '<td class="td_normal_title">';
					trHTML +='<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="DocList_DeleteRow('+trIndex+')">';
					trHTML += '</td>';
					trHTML += '</tr>';
					$("#divertlistTB").append(trHTML);
					trIndex++;
					fdOrder++;
					trCardIds +=","+results[i].fdCardId;
		     	}
			   }
			}
		});
	 });
	} 
		 
	 function showAssetCardList(value){
	 	if(value=== undefined )
	 	{
	 		value='';
	 	}
	 	var url=Com_GetCurDnsHost()+Com_Parameter.ContextPath+'km/asset/km_asset_card/kmAssetCard_dialog.jsp?status='+value;
	 	dialog.iframe(url,"${lfn:message('km-asset:kmAssetApplyBase.selectAsset') }",function(ids){
	 	  if (null!= ids&& undefined !=ids&&ids!=""){
	 		 loadCardContent(ids);
		  }else{
			  return false;
		  }
	 	},{width:900,height:550});
	 }
		 
	function selectCard() {
		showAssetCardList("1,2,3,4");
	}
	
	function refreshTbIndex(optTB, rowIndex){
		for(var j = rowIndex; j<optTB.rows.length; j++){
			optTB.rows[j].cells[0].innerHTML = j;
		}		
	}
	
	function DocList_DeleteRow(i){
		var optTR = DocListFunc_GetParentByTagName("TR");
		var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
		//var DocList_TableInfo = new Array;
		//var tbInfo = DocList_TableInfo[optTB.id];
		var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
		var aa = document.getElementsByName("fdItems["+i+"].fdAssetCardId")[0];
		trCardIds=trCardIds.replace(aa.value, "");
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

	function setTextRequired()
	{
		for(var index=0;index<trIndex;index++)
		{
			if($("input[name='fdItems["+index+"].fdAssetCardId']")[0]===undefined)
			{
				continue;
			}
			var o1,o2,o3;
			o1=$("input[name='fdItems["+index+"].fdNowDeptName']");
			o2=$("input[name='fdItems["+index+"].fdNowPersonName']");
			o3=$("input[name='fdItems["+index+"].fdNewAddressName']");
			if(o2===undefined)
			{
				continue;
			}
			if(o2==null)
			{
				continue;
			}
			
			var v1=o1[0].value;
			var v2=o2[0].value;
			if(v1!='' || v2!='')
			{
				//alert('o1.value:'+v1+'====o2.value:'+v2+'   ====:show');
					o1.attr("required",true);
					o2.attr("required",true);
					o3.attr("required",true);
					o1.attr("validate","required");
					o2.attr("validate","required");
					o3.attr("validate","required");
					$("#div1"+index).css({"display": "inline"}).show();
					$("#div2"+index).css({"display": "inline"}).show();
					$("#div3"+index).css({"display": "inline"}).show();
			}
			else
			{
				if(v1=='' && v2=='')
				{
					//alert('o1.value:'+v1+'====o2.value:'+v2+'   ====:hide');
					o1.removeAttr("required");
					o2.removeAttr("required");
					o3.removeAttr("required");
					o1.removeAttr("validate");
					o2.removeAttr("validate");
					o3.removeAttr("validate");
					$(".validation-advice").hide();
					$("#div1"+index).hide();
					$("#div2"+index).hide();
					$("#div3"+index).hide();
				}
			}
		}
	}

	function batchFdDept()
	{
		Dialog_Address(false, "batchDeptId", "batchDeptName", null, ORG_TYPE_DEPT,function(){
			$("INPUT[name$='.fdNowDeptId']").val($("INPUT[name=batchDeptId]").val());
			$("INPUT[name$='.fdNowDeptName']").val($("INPUT[name=batchDeptName]").val());
			setTextRequired();
			//手动触发校验
			$("INPUT[name$='.fdNowDeptName']").focus();
			$("INPUT[name$='.fdNowDeptName']").blur();
		});
	}

	function batchFdPerson()
	{
		Dialog_Address(false, "batchPersonId", "batchPersonName", null, ORG_TYPE_PERSON,function(){
			$("INPUT[name$='.fdNowPersonId']").val($("INPUT[name=batchPersonId]").val());
			$("INPUT[name$='.fdNowPersonName']").val($("INPUT[name=batchPersonName]").val());
			setTextRequired();
			//手动触发校验
			$("INPUT[name$='.fdNowPersonName']").focus();
			$("INPUT[name$='.fdNowPersonName']").blur();
		});
	}

	function batchFdAddress()
	{
		//selectResource("batchAddressId","batchAddressName");
		//if($("INPUT[name=batchAddressId]").val()!="")
		//{
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
			    $("INPUT[name$='.fdNewAddressId']").val($("INPUT[name=batchAddressId]").val());
				$("INPUT[name$='.fdNewAddressName']").val($("INPUT[name=batchAddressName]").val());
				setTextRequired();
				//手动触发校验
				$("INPUT[name$='.fdNewAddressName']").focus();
				$("INPUT[name$='.fdNewAddressName']").blur();
		 },{width:650,height:550});
	  });
		//}
	}

	$(document).ready(
		function(){
			setTextRequired();
		}
	);
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
<table class="tb_normal" width=100% id="divertlistTB" >
	<tr align="center">
	    <td  class="td_normal_title" align="center" width="10px"> 
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOrder"/>
		</td>
		<!-- 资产编码 -->
		<td  class="td_normal_title" align="center" width="7%"> 
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdNo"/>
		</td>
		<!-- 资产名称-->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdName"/>
		</td>
		
		<!-- 资产类别-->
		<td class="td_normal_title" align="center" width="7%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdCategory"/>
		</td>
		
		<!-- 规格型号-->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdStandard"/>
		</td>
		<!-- 原值 -->
		<td class="td_normal_title" align="center" width="6%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdAssetCard.fdFirstValue"/>
		</td>
		<!-- 调拨日期 -->
		<td class="td_normal_title" align="center" width="12%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdDivertDate"/>
		</td>
		<!-- 原使用部门 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOldDept"/>
		</td>
		<!-- 现使用部门 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNowDept"/>
		</td>
		<!-- 原责任人 -->
		<td class="td_normal_title" align="center" width="8%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdGetPerson"/>
		</td>
		<!-- 现责任人 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNowPerson"/>
		</td>
		<!-- 原地点 -->
		<td class="td_normal_title" align="center" width="7%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdOldAddress"/>
		</td>
		<!-- 现地点 -->
		<td class="td_normal_title" align="center" width="10%">
			<bean:message bundle="km-asset" key="kmAssetApplyDivertList.fdNewAddress"/>
		</td><!-- 现地点 -->
		<td class="td_normal_title" align="center" >
			<bean:message bundle="km-asset" key="kmAssetApplyIn.operate"/>
		</td>
	</tr>
	<c:forEach items="${kmAssetApplyDivertForm.fdItems}"
		var="kmAssetApplyDivertListForm" varStatus="vstatus">
	<tr>
	    <td>${vstatus.index+1}</td>
		<td>
		    <html:hidden property="fdItems[${vstatus.index}].fdApplyDivertId" value="${kmAssetApplyDivertForm.fdId}"/>
		    <html:hidden property="fdItems[${vstatus.index}].fdAssetCardId" value="${kmAssetApplyDivertListForm.fdAssetCardId}"/>
		    <xform:text showStatus="view" property="fdItems[${vstatus.index}].fdCardNo" value="${kmAssetApplyDivertListForm.fdCardNo}" style="width:80%" />
		 </td>
		 <td>   
		     <xform:text showStatus="view" property="fdItems[${vstatus.index}].fdAssetCardName" value="${kmAssetApplyDivertListForm.fdAssetCardName}" style="width:80%" />
		 </td>
		 <td> 
			<xform:text showStatus="view" property="fdItems[${vstatus.index}].fdCardCate" value="${kmAssetApplyDivertListForm.fdCardCate}" style="width:80%" />
		</td> 
		<td> 
			<xform:text showStatus="view" property="fdItems[${vstatus.index}].fdCardStandard" value="${kmAssetApplyDivertListForm.fdCardStandard}"  style="width:80%" />
		</td> 	
		<td> 
		    <kmss:showNumber value="${kmAssetApplyDivertListForm.fdFirstValue}" pattern="###,##0.00"/>
		</td> 	
		<td> 
			<xform:datetime property="fdItems[${vstatus.index}].fdDivertDate" showStatus="edit" style="width:90%" dateTimeType="date" validators="required" required="true" value="${fn:substring(kmAssetApplyDivertListForm.fdDivertDate,0,10)}"/>
		</td> 	
		<td> 
		     <input type="hidden" name="fdItems[${vstatus.index}].fdOldDeptId" value="${kmAssetApplyDivertListForm.fdOldDeptId}"/>
			 <xform:text style="width:70px"  showStatus="view" property="fdItems[${vstatus.index}].fdOldDeptName" value="${kmAssetApplyDivertListForm.fdOldDeptName}"/>
		</td> 
		<td> 	
			 <xform:address propertyId="fdItems[${vstatus.index}].fdNowDeptId" propertyName="fdItems[${vstatus.index}].fdNowDeptName" showStatus="edit" style="width:85%" orgType="ORG_TYPE_DEPT" onValueChange="setTextRequired" />
			 <DIV id=div1${vstatus.index} class=txtstrong style="display: none">*</DIV>
		</td> 	
		<td>
		     <input type="hidden" name="fdItems[${vstatus.index}].fdGetPersonId" value="${kmAssetApplyDivertListForm.fdGetPersonId}"/>
			 <xform:text style="width:70px" showStatus="view" property="fdItems[${vstatus.index}].fdGetPersonName" value="${kmAssetApplyDivertListForm.fdGetPersonName}" />
		</td> 
		<td> 
			<xform:address propertyId="fdItems[${vstatus.index}].fdNowPersonId" propertyName="fdItems[${vstatus.index}].fdNowPersonName" showStatus="edit" style="width:85%" orgType="ORG_TYPE_PERSON" onValueChange="setTextRequired"/>
			<DIV id=div2${vstatus.index} class=txtstrong style="display: none">*</DIV>
		</td> 
		<td> 
		     <input type="hidden" name="fdItems[${vstatus.index}].fdOldAddressId" value="${kmAssetApplyDivertListForm.fdOldAddressId}"/>
			 <xform:text style="width:70px" showStatus="view" property="fdItems[${vstatus.index}].fdOldAddressName" value="${kmAssetApplyDivertListForm.fdOldAddressName}"/>
		</td> 
		<td> 
			<xform:dialog  propertyId="fdItems[${vstatus.index}].fdNewAddressId" propertyName="fdItems[${vstatus.index}].fdNewAddressName" showStatus="edit" style="width:85%" dialogJs="SelectPlace(${vstatus.index});"/>
			<DIV id=div3${vstatus.index} class=txtstrong style="display: none">*</DIV>
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

<table class="tb_normal" width=100% id="batchTB" >
	<tr align="right"">
		<!-- 资产编码 -->
		<td  colspan="13" align="right">

		<!-- 现使用部门 -->
			<input type=button class="lui_form_button" style="padding:2px;" value="<bean:message bundle="km-asset" key="batch.fdNowDept"/>"
			onclick="batchFdDept();">
		<!-- 现责任人 -->
			<input type=button class="lui_form_button" style="padding:2px;" value="<bean:message bundle="km-asset" key="batch.fdNowPerson"/>"
			onclick="batchFdPerson();">
		<!-- 现地点 -->
			<input type=button class="lui_form_button" style="padding:2px;" value="<bean:message bundle="km-asset" key="batch.fdNowAddress"/>"
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
