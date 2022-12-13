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
  	        fdReferencePrice = document.getElementsByName("geesunOitemsShoppingTrolleyFormList["+i+"].fdReferencePrice");
  	        fdApplicationNumber =document.getElementsByName("geesunOitemsShoppingTrolleyFormList["+i+"].fdApplicationNumber");
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
		arguments.title='<bean:message bundle="geesun-oitems" key="geesunOitemsListing.geesunOitemsListing"/>';
		var href = Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication_add.jsp?fdApplicationId="+fdApplicationId;
		dialog.iframe(href,"${lfn:message('geesun-oitems:geesunOitemsBudgerApplication.add') }",function(rtnData){
		  if(rtnData != null){
				getContent(rtnData);
  		  }else{
  			_validation.validateElement(document.getElementById("listingValidate"));
  		  }
		},{width:900,height:550});
	}
	
	function openUpload(){
		var fdAppId = document.getElementsByName('fdId')[0].value;
		dialog.iframe('/geesun/oitems/geesun_oitems_shopping_trolley/geesun_oitems_shopping_trolley_upload.jsp?fdAppId='+fdAppId,'用品数据导入',function(rtnData){
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
	    var url = "${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do?method=loadTrolley&orderby=fdNo&fdApplicationId=${geesunOitemsBudgerApplicationForm.fdId}";
	    data.SendToUrl(url, function(data) {
		var results = eval("(" + data.responseText + ")");
		$("#TABLE_DocList tr:not(:first)").remove();
		if (results.length > 0) {
			lineCount = 0;
			for(var i=0;i<results.length;i++){
				trHTML = '<tr id="'+results[i].trolleyId+'">';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdId" value="'+results[i].trolleyId+'"/>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].kmApplicationId" value="${geesunOitemsBudgerApplicationForm.fdId}"/>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdApplicationId" value="${geesunOitemsBudgerApplicationForm.fdId}"/>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdListingId" value="'+results[i].fdListingId+'"/>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].kmWarehousingRecordJoinListId" value="'+results[i].kmWarehousingRecordJoinListId+'"/>';
				trHTML += '<td>'+(i+1)+'</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdNo" value="'+results[i].fdNo+'"/>'+results[i].fdNo;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdName" value="'+results[i].fdName+'"/>'+results[i].fdName;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdCategoryName" value="'+results[i].fdCategoryName+'"/>'+results[i].fdCategoryName;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdSpecification" value="'+results[i].fdSpecification+'"/>'+results[i].fdSpecification;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdBrand" value="'+results[i].fdBrand+'"/>'+results[i].fdBrand;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdUnit" value="'+results[i].fdUnit+'"/>'+results[i].fdUnit;
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdReferencePrice" value="'+results[i].fdReferencePrice+'"/>'+commafy(results[i].fdReferencePrice);
				trHTML += '</td>';
				trHTML += '<td>';
				trHTML += '<input type="hidden" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdAmount" value="'+results[i].fdAmount+'"/>'+results[i].fdAmount;
				trHTML += '</td>';
				var count =results[i].fdApplicationNumber ;
				if(rtnData[results[i].trolleyId]){
					count = rtnData[results[i].trolleyId];
				}
				if(countDetail[results[i].trolleyId]){
					count = countDetail[results[i].trolleyId];
				}
				trHTML += '<td>';
				trHTML += '<input type="text" style="width:50px" class="inputsgl" name="geesunOitemsShoppingTrolleyFormList['+i+'].fdApplicationNumber" onblur="sumTotal(this);" data-trolleyid="'+results[i].trolleyId+'"  subject="<bean:message bundle="geesun-oitems" key="geesunOitemsShoppingTrolley.fdApplicationNumber"/>" validate="digits range(1,2147483647)" value="'+count+'"/>';
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
    var url = "${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do?method=deleteTrolley&trolleyId="+trolleyId;
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
<center><b><bean:message  bundle="geesun-oitems" key="geesunOitems.list"/></b></center>
<table class="tb_normal" width=100% style="margin-top:15px">
    <tr>
	    <td>
	         <input type=button class="lui_form_button" value="<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.add"/>" onclick="addOitems();">
			<c:if test="${geesunOitemsBudgerApplicationForm.fdType =='1'}">
				<input type="button" class="lui_form_button" value="<bean:message bundle="geesun-oitems" key="geesunOitemsShoppingTrolley.import.button" />" onclick="openUpload();" />
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
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
				</td>
				<td class="td_normal_title"  style="width:20%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
				</td>
				<td class="td_normal_title" style="width:13%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
				</td>
				<td class="td_normal_title" style="width:10%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
				</td>
				<td class="td_normal_title" style="width:6%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
				</td>
				<td class="td_normal_title" style="width:6%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
				</td>
				<td class="td_normal_title" style="width:9%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
				</td>
				<td class="td_normal_title" style="width:7%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
				</td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsShoppingTrolley.fdApplicationNumber"/>
				</td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitems.button.operation"/>
				</td>
		</tr>
		<c:forEach items="${geesunOitemsBudgerApplicationForm.geesunOitemsShoppingTrolleyFormList}" var="geesunOitemsShoppingTrolleyForm" varStatus="vstatus">
			<tr width="100%" id="${geesunOitemsShoppingTrolleyForm.fdId}">
				<td>${vstatus.index+1}</td>
				<td>
				<html:hidden property="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].kmApplicationId" value="${geesunOitemsBudgerApplicationForm.fdId}"/>
				<html:hidden property="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdApplicationId" value="${geesunOitemsBudgerApplicationForm.fdId}"/>
				<html:hidden property="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdListingId" value="${geesunOitemsShoppingTrolleyForm.fdListingId}"/>
				<html:hidden property="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].kmWarehousingRecordJoinListId" value="${geesunOitemsShoppingTrolleyForm.kmWarehousingRecordJoinListId}"/>
			      <input type="hidden" name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdNo" value="${geesunOitemsShoppingTrolleyForm.fdNo}"/>
			     <c:out value="${geesunOitemsShoppingTrolleyForm.fdNo}"/>
				</td>
				<td>
				<input type="hidden" name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdName" value="${geesunOitemsShoppingTrolleyForm.fdName}"/>
			     <c:out value="${geesunOitemsShoppingTrolleyForm.fdName}"/>
				</td>
				<td>
				<input type="hidden" name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdCategoryName" value="${geesunOitemsShoppingTrolleyForm.fdCategoryName}"/>
			     <c:out value="${geesunOitemsShoppingTrolleyForm.fdCategoryName}"/>
				</td>
				<td>
				<input type="hidden" name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdSpecification" value="${geesunOitemsShoppingTrolleyForm.fdSpecification}"/>
			     <c:out value="${geesunOitemsShoppingTrolleyForm.fdSpecification}"/>
				</td>
				<td>
				<input type="hidden" name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdBrand" value="${geesunOitemsShoppingTrolleyForm.fdBrand}"/>
			     <c:out value="${geesunOitemsShoppingTrolleyForm.fdBrand}"/>
				</td>
				<td>
				<input type="hidden" name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdUnit" value="${geesunOitemsShoppingTrolleyForm.fdUnit}"/>
			     <c:out value="${geesunOitemsShoppingTrolleyForm.fdUnit}"/>
				</td>
				<td>
					<kmss:showNumber value="${geesunOitemsShoppingTrolleyForm.fdReferencePrice}" pattern="###,##0.00"/>
					<input name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdReferencePrice" type="hidden" value="${geesunOitemsShoppingTrolleyForm.fdReferencePrice}">
				</td>
				<td>
					<input name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdAmount" type="hidden" value="${geesunOitemsShoppingTrolleyForm.fdCurNum}">
					<c:out value="${geesunOitemsShoppingTrolleyForm.fdCurNum}"/>
				</td>
				<td>
				    <c:if test="${geesunOitemsShoppingTrolley.fdCurNum-geesunOitemsShoppingTrolley.fdApplicationNumber<0}">
					<input class="inputsgl" style="width:50px" type="text" name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdApplicationNumber" onblur="sumTotal(this);" value="${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}" style="color: red">
					</c:if>
					<c:if test="${geesunOitemsShoppingTrolley.fdCurNum-geesunOitemsShoppingTrolley.fdApplicationNumber>=0}">
					<input class="inputsgl" style="width:50px" type="text" name="geesunOitemsShoppingTrolleyFormList[${vstatus.index}].fdApplicationNumber" onblur="sumTotal(this);" value="${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}">
					</c:if>
				</td>
				<td align="center">
				    <img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="deleteRow('${geesunOitemsShoppingTrolleyForm.fdId}')">
				</td>
			</tr>
			<script>
				lineCount++;
			</script>
		</c:forEach>
	</table>
