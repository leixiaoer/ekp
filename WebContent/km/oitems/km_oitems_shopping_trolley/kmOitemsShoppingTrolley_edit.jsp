<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page  import="java.util.Date"%>
<%@ page  import="com.landray.kmss.util.UserUtil"%>
<script type="text/javascript">
 	Com_IncludeFile('jquery.js');
</script>
<script type="text/javascript">
seajs.use(['sys/ui/js/dialog'], function(dialog) {
	window.dialog = dialog;
});

// 两个浮点数求和
function accAdd(num1,num2){
   var r1,r2,m;
   try{
       r1 = num1.toString().split('.')[1].length;
   }catch(e){
       r1 = 0;
   }
   try{
       r2=num2.toString().split(".")[1].length;
   }catch(e){
       r2=0;
   }
   m=Math.pow(10,Math.max(r1,r2));
   return Math.round(num1*m+num2*m)/m;
}

function accMul(arg1,arg2) { 
	var m=0,s1=arg1.toString(),s2=arg2.toString(); 
	try{m+=s1.split(".")[1].length}catch(e){} 
	try{m+=s2.split(".")[1].length}catch(e){} 
	return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m) 
}

function commafy(num) {   
	//1.先去除空格,判断是否空值和非数   
	num = num + "";   
	num = num.replace(/[ ]/g, ""); //去除空格  
	    if (num == "") {   
	    return;   
	    }   
	    if (isNaN(num)){  
	    return;   
	    }   
	    //2.针对是否有小数点，分情况处理   
	    var index = num.indexOf(".");   
	    var intPart = index == -1 ? num : num.substring(0, index);
	    var pointPart = index == -1 ? "00" : num.length - index - 1 < 2 ? num.substring(index + 1, num.length) + "0" : num.substring(index + 1, num.length);
	    var reg = /(-?\d+)(\d{3})/;   
        while (reg.test(intPart)) {   
        	intPart = intPart.replace(reg, "$1,$2");   
        }
	    num = intPart +"."+ pointPart;
	return num;   
}   

var lineCount = 0;

function initAmout(){
	 var totalAmount =0;
	 var fdReferencePrice;
	 var fdApplicationNumber;
    var fdNumber = $("input[name$='fdApplicationNumber']");
    if(fdNumber.length>0){
    	  for(var i=0;i<lineCount ;i++){
  	        fdReferencePrice = document.getElementsByName("kmOitemsShoppingTrolleyFormList["+i+"].fdReferencePrice");
  	        fdApplicationNumber =document.getElementsByName("kmOitemsShoppingTrolleyFormList["+i+"].fdApplicationNumber");
  	    	if(fdReferencePrice.length >0  && fdApplicationNumber.length >0 ){
  	    		 totalAmount = accAdd(totalAmount,accMul(parseFloat(fdReferencePrice[0].value),parseFloat(fdApplicationNumber[0].value)));
  	    	}
  	    }
  	   document.getElementsByName("fdTotalAmount")[0].value = totalAmount;
  	   $(".total").html(commafy(totalAmount));
    }else{
    	 $(".total").html("");
    }
}

	function addOitems(){
		var fdApplicationId = document.getElementsByName("fdId")[0].value ;
		var arguments = new Object();
		arguments.title='<bean:message bundle="km-oitems" key="kmOitemsListing.kmOitemsListing"/>';
		var href = Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication_add.jsp?fdApplicationId="+fdApplicationId;
		dialog.iframe(href,"${lfn:message('km-oitems:kmOitemsBudgerApplication.add') }",function(rtnData){
		  if(rtnData != null){
				getContent(rtnData);
  		  }else{
  			_validation.validateElement(document.getElementById("listingValidate"));
  		  }
		},{width:900,height:550});
	}
	
	function openUpload(){
		var fdAppId = document.getElementsByName('fdId')[0].value;
		dialog.iframe('/km/oitems/km_oitems_shopping_trolley/km_oitems_shopping_trolley_upload.jsp?fdAppId='+fdAppId,'用品数据导入',function(rtnData){
			if(rtnData != null){
				getContent(rtnData);
  		  	}else{
  				_validation.validateElement(document.getElementById("listingValidate"));
  		  	}
		},{
			"width" : 600,
			"height" : 400,
			"close":false
		});
	}

	//记录用户已选用品的数量
	var countDetail={};
	
	function  getContent(rtnData){
		var data = new KMSSData();
	    var url = "${KMSS_Parameter_ContextPath}km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=loadTrolley&orderby=fdNo&fdApplicationId=${kmOitemsBudgerApplicationForm.fdId}";
	    data.SendToUrl(url, function(data) {
		var results = eval("(" + data.responseText + ")");
		$("#TABLE_DocList tr:not(:first)").remove();
		if (results.length > 0) {
			lineCount = 0;
			for(var i=0;i<results.length;i++){
				trHTML = '<tr id="'+results[i].trolleyId+'">';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdId" value="'+results[i].trolleyId+'"/>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].kmApplicationId" value="${kmOitemsBudgerApplicationForm.fdId}"/>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdApplicationId" value="${kmOitemsBudgerApplicationForm.fdId}"/>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdListingId" value="'+results[i].fdListingId+'"/>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].kmWarehousingRecordJoinListId" value="'+results[i].kmWarehousingRecordJoinListId+'"/>';
				trHTML += '<td>'+(i+1)+'</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdNo" value="'+results[i].fdNo+'"/>'+results[i].fdNo;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdName" value="'+results[i].fdName+'"/>'+results[i].fdName;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdCategoryName" value="'+results[i].fdCategoryName+'"/>'+results[i].fdCategoryName;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdSpecification" value="'+results[i].fdSpecification+'"/>'+results[i].fdSpecification;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdBrand" value="'+results[i].fdBrand+'"/>'+results[i].fdBrand;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdUnit" value="'+results[i].fdUnit+'"/>'+results[i].fdUnit;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdReferencePrice" value="'+results[i].fdReferencePrice+'"/>'+commafy(results[i].fdReferencePrice);
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="kmOitemsShoppingTrolleyFormList['+i+'].fdAmount" value="'+results[i].fdAmount+'"/>'+results[i].fdAmount;
				trHTML += '</td>';
				var count =results[i].fdApplicationNumber ;
				if(rtnData[results[i].trolleyId]){
					count = rtnData[results[i].trolleyId];
				}
				if(countDetail[results[i].trolleyId]){
					count = countDetail[results[i].trolleyId];
				}
				trHTML += '<td>';
				trHTML += '<input type="text" style="width:50px" class="inputsgl" name="kmOitemsShoppingTrolleyFormList['+i+'].fdApplicationNumber" onblur="sumTotal(this);" data-trolleyid="'+results[i].trolleyId+'"  subject="<bean:message bundle="km-oitems" key="kmOitemsShoppingTrolley.fdApplicationNumber"/>" validate="required digits min(1)" value="'+count+'"/>';
				trHTML += '</td>';
				trHTML += '<td align="center" class="td_normal_title">';
				trHTML +='<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick=deleteRow("'+results[i].trolleyId+'")>';
				trHTML += '</td>';
				trHTML += '</tr>';
				$("#TABLE_DocList").append(trHTML);
				lineCount++;
		   }
			_validation.validateElement(document.getElementById("listingValidate"));
		}else{
			_validation.validateElement(document.getElementById("listingValidate"));
		}
		initAmout();
	});
}
	
function deleteRow(trolleyId){
	var data = new KMSSData();
    var url = "${KMSS_Parameter_ContextPath}km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=deleteTrolley&trolleyId="+trolleyId;
    data.SendToUrl(url, function(data) {
    	$("#"+trolleyId).remove();
    	$("#TABLE_DocList tr:not(:first)").each(function(index,item) {
    		$(item).find('td:first').html(index+1);
    	});
    	//lineCount--;
    	initAmout();
    });
}	


function sumTotal(obj){
	initAmout();
	//记录用户已修改的用品数量
	countDetail[$(obj).attr("data-trolleyid")] = obj.value;
}

$(document).ready(function(){
	 initAmout();
});

</script>
<center><b><bean:message  bundle="km-oitems" key="kmOitems.list"/></b></center>
<table class="tb_normal" width=100% style="margin-top:15px">
    <tr>
	    <td>
	         <input type=button class="lui_form_button" value="<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.add"/>" onclick="addOitems();">
			<c:if test="${kmOitemsBudgerApplicationForm.fdType =='1'}">
				<input type="button" class="lui_form_button" value="<bean:message bundle="km-oitems" key="kmOitemsShoppingTrolley.import.button" />" onclick="openUpload();" />
			</c:if>
			<span class="txtstrong">*</span>
			<span>
			  <input type="text" id="listingValidate"  name="listingValidate"  validate="listingNotNull" readonly="readonly" style="border:0"/>
			</span> 
	    </td>
    </tr>
</table>
<table class="tb_normal" width="100%" id="TABLE_DocList">
		<tr width="100%">
				<td  class="td_normal_title" style="width:5%;text-align:center"><bean:message key="page.serial"/></td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
				</td>
				<td class="td_normal_title"  style="width:20%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
				</td>
				<td class="td_normal_title" style="width:13%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
				</td>
				<td class="td_normal_title" style="width:10%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
				</td>
				<td class="td_normal_title" style="width:6%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
				</td>
				<td class="td_normal_title" style="width:6%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
				</td>
				<td class="td_normal_title" style="width:9%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/>
				</td>
				<td class="td_normal_title" style="width:7%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/>
				</td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitemsShoppingTrolley.fdApplicationNumber"/>
				</td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="km-oitems" key="kmOitems.button.operation"/>
				</td>
		</tr>
		<c:forEach items="${kmOitemsBudgerApplicationForm.kmOitemsShoppingTrolleyFormList}" var="kmOitemsShoppingTrolleyForm" varStatus="vstatus">
			<tr width="100%" id="${kmOitemsShoppingTrolleyForm.fdId}">
				<td>${vstatus.index+1}</td>
				<td>
				<html:hidden property="kmOitemsShoppingTrolleyFormList[${vstatus.index}].kmApplicationId" value="${kmOitemsBudgerApplicationForm.fdId}"/>
				<html:hidden property="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdApplicationId" value="${kmOitemsBudgerApplicationForm.fdId}"/>
				<html:hidden property="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdListingId" value="${kmOitemsShoppingTrolleyForm.fdListingId}"/>
				<html:hidden property="kmOitemsShoppingTrolleyFormList[${vstatus.index}].kmWarehousingRecordJoinListId" value="${kmOitemsShoppingTrolleyForm.kmWarehousingRecordJoinListId}"/>
			      <input type="hidden" name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdNo" value="${kmOitemsShoppingTrolleyForm.fdNo}"/>
			     <c:out value="${kmOitemsShoppingTrolleyForm.fdNo}"/>
				</td>
				<td>
				<input type="hidden" name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdName" value="${kmOitemsShoppingTrolleyForm.fdName}"/>
			     <c:out value="${kmOitemsShoppingTrolleyForm.fdName}"/>
				</td>
				<td>
				<input type="hidden" name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdCategoryName" value="${kmOitemsShoppingTrolleyForm.fdCategoryName}"/>
			     <c:out value="${kmOitemsShoppingTrolleyForm.fdCategoryName}"/>
				</td>
				<td>
				<input type="hidden" name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdSpecification" value="${kmOitemsShoppingTrolleyForm.fdSpecification}"/>
			     <c:out value="${kmOitemsShoppingTrolleyForm.fdSpecification}"/>
				</td>
				<td>
				<input type="hidden" name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdBrand" value="${kmOitemsShoppingTrolleyForm.fdBrand}"/>
			     <c:out value="${kmOitemsShoppingTrolleyForm.fdBrand}"/>
				</td>
				<td>
				<input type="hidden" name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdUnit" value="${kmOitemsShoppingTrolleyForm.fdUnit}"/>
			     <c:out value="${kmOitemsShoppingTrolleyForm.fdUnit}"/>
				</td>
				<td>
					<kmss:showNumber value="${kmOitemsShoppingTrolleyForm.fdReferencePrice}" pattern="###,##0.00"/>
					<input name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdReferencePrice" type="hidden" value="${kmOitemsShoppingTrolleyForm.fdReferencePrice}">
				</td>
				<td>
					<input name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdAmount" type="hidden" value="${kmOitemsShoppingTrolleyForm.fdCurNum}">
					<c:out value="${kmOitemsShoppingTrolleyForm.fdCurNum}"/>
				</td>
				<td>
				    <c:if test="${kmOitemsShoppingTrolley.fdCurNum-kmOitemsShoppingTrolley.fdApplicationNumber<0}">
					<input class="inputsgl" style="width:50px" type="text" name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdApplicationNumber" onblur="sumTotal(this);" value="${kmOitemsShoppingTrolleyForm.fdApplicationNumber}" style="color: red">
					</c:if>
					<c:if test="${kmOitemsShoppingTrolley.fdCurNum-kmOitemsShoppingTrolley.fdApplicationNumber>=0}">
					<input class="inputsgl" style="width:50px" type="text" name="kmOitemsShoppingTrolleyFormList[${vstatus.index}].fdApplicationNumber" onblur="sumTotal(this);" value="${kmOitemsShoppingTrolleyForm.fdApplicationNumber}">
					</c:if>
				</td>
				<td align="center">
				    <img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="deleteRow('${kmOitemsShoppingTrolleyForm.fdId}')">
				</td>
			</tr>
			<script>
				lineCount++;
			</script>
		</c:forEach>
	</table>