<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
<template:replace name="body">
<script type="text/javascript">
	seajs.use(['theme!form']);
</script>
<script type="text/javascript" src="../js/tableSort.js"></script>
<script type="text/javascript">
Com_IncludeFile("dialog.js|calendar.js", null, "js");
window.onload = function(){
	var deptAll = '${deptAll}';
	if(null != deptAll && deptAll == '1'){
		$("#deptAll").prop("checked",true);
	}
};
function clear_data(){
	document.getElementsByName("fdStartTime")[0].value="";
	document.getElementsByName("fdEndTime")[0].value="";
	document.getElementsByName("fdCarCategoryId")[0].value="";
	document.getElementsByName("fdCarCategoryName")[0].value="";
	document.getElementsByName("fdDeptIds")[0].value="";
	document.getElementsByName("fdDeptNames")[0].value="";
	document.getElementsByName("fdPersonIds")[0].value="";
	document.getElementsByName("fdPersonNames")[0].value="";
 }	
function isNullDate(){
	var fdStartTime = document.getElementsByName("fdStartTime")[0].value;
	 var fdEndTime = document.getElementsByName("fdEndTime")[0].value;
	 if(fdStartTime == '' || fdEndTime == ''){
		 return true;
	 }
}
function checkDate(){
	
    var fdStartDate=document.getElementsByName("fdStartTime")[0].value;
	var fdEndDate = document.getElementsByName("fdEndTime")[0].value;
    var nowDate=new Date();
    var now=nowDate.getFullYear()+"-";
    now = now+(nowDate.getMonth()+1)+"-";
    now = now+nowDate.getDate();
    now = now.replace(/-/g,"/");
    fdStartDate=fdStartDate.replace(/-/g,"/");
    fdEndDate = fdEndDate.replace(/-/g,"/");
	if(Date.parse(fdStartDate)-Date.parse(fdEndDate)>0){
		 alert('<bean:message bundle="km-carmng" key="kmCarmng.error.message10"/>');
		 return false; 
	}
}
function exportExcel(){
    var fdStartTime = document.getElementsByName("fdStartTime")[0];
    var fdEndTime = document.getElementsByName("fdEndTime")[0];
    var fdCarCategoryId = document.getElementsByName("fdCarCategoryId")[0];
    var fdCarCategoryName = document.getElementsByName("fdCarCategoryName")[0];
    var fdDeptIds = document.getElementsByName("fdDeptIds")[0];
    var fdDeptNames = document.getElementsByName("fdDeptNames")[0];
    if(fdStartTime && fdEndTime){
    	Com_OpenWindow('${KMSS_Parameter_ContextPath}km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=saveExportExcel&fdStartTime=' 
    			+ fdStartTime.value + '&fdEndTime=' + fdEndTime.value + '&fdCarCategoryId=' + fdCarCategoryId.value+ '&fdCarCategoryName=' + fdCarCategoryName.value
    			+ '&fdDeptIds=' + fdDeptIds.value+ '&fdDeptNames=' + encodeURIComponent(fdDeptNames.value),'_blank');
    	//Com_SubmitNoEnabled(document.kmCarmngUserFeeInfoForm, 'saveExportExcel&fdStartTime=' + fdStartTime.value + '&fdEndTime=' + fdEndTime.value);
    }
}
</script>
<script language="javascript" for="document" event="onkeydown">   
        var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;   
        if (keyCode == 13) {   
        	var clickObj = document.getElementById("ok_id"); 		  
  		 	 clickObj.click();
        }
</script> 
<center>
<html:form action="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do">
<ui:tabpanel id="kmCarmngUserFeeInfoCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmCarmngUserFeeInfoCountContent" title="${ lfn:message('km-carmng:kmCarmng.tree.fee.count1') }">
	<div style="padding-top:20px">	
		<table width="98%" class="tb_normal">
				<tr>
					<td class="td_normal_title"><bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime"/></td>
					<td>
						<input class="inputsgl" class="inputsgl" type="text" name="fdStartTime" readonly="readonly" value="${fdStartTime }">
						<a href="#"
							onclick="selectDate('fdStartTime');"><bean:message
							key="dialog.selectOther" /></a>
							<span class="txtstrong">*</span>
					</td>
					<td class="td_normal_title"><bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime"/></td>
					<td>
						<input class="inputsgl" class="inputsgl" type="text" name="fdEndTime" readonly="readonly" value="${fdEndTime }">
						<a href="#"
							onclick="selectDate('fdEndTime');"><bean:message
							key="dialog.selectOther" /></a>
							<span class="txtstrong">*</span>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title"><bean:message bundle="km-carmng" key="kmCarmngInfomation.fdVehichesType"/></td>
					<td>
						<input class="inputsgl" type="hidden" name="fdCarCategoryId" value="${fdCarCategoryId}">
						<input class="inputsgl" type="text" name="fdCarCategoryName" value="${fdCarCategoryName}">
						<a href="#"
							onclick="Dialog_Tree(true, 
					 	'fdCarCategoryId', 
					 	'fdCarCategoryName', 
					 	';', 
					 	'kmCarmngCategoryTreeService&categoryId=!{value}', 
					 	'<bean:message key="table.kmCarmngCategory" bundle="km-carmng"/>',
					 	 true, null,
					 	 null, null, null,
					 	 '<bean:message key="table.kmCarmngCategory" bundle="km-carmng"/>')"><bean:message
							key="dialog.selectOther" /> </a>
					</td>
					<td class="td_normal_title"><bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdDeptIds"/></td>
					<td>
						<input class="inputsgl" type="hidden" name="fdDeptIds" value="${fdDeptIds}">
						<input class="inputsgl" type="text" name="fdDeptNames" value="${fdDeptNames}">
						<a id="a_dept_id" href="#"
							onclick="Dialog_Address(true, 'fdDeptIds', 'fdDeptNames', ';',ORG_TYPE_DEPT|ORG_TYPE_ORG);"><bean:message
							key="dialog.selectOther" /></a>
						<input type="checkbox" name="deptAll" id='deptAll' value="1">包含所有子部门
					</td>
				</tr>
				<tr>
					<td class="td_normal_title">用车人</td>
					<td>
						<input class="inputsgl" type="hidden" name="fdPersonIds" value="${fdPersonIds}">
						<input class="inputsgl" type="text" name="fdPersonNames" value="${fdPersonNames}">
						<a id="a_dept_id" href="#"
							onclick="Dialog_Address(true, 'fdPersonIds', 'fdPersonNames', ';',ORG_TYPE_PERSON);"><bean:message
							key="dialog.selectOther" /></a>
					</td>
				</tr>		
		</table>
	</div>
	<div style="text-align: center;margin-top: 10px;margin-bottom:10px">
		 <ui:button text="${lfn:message('km-carmng:kmCarmng.button4') }" order="1" onclick="Com_Submit(document.kmCarmngUserFeeInfoForm, 'count');">
		 </ui:button>&nbsp;&nbsp;
		  <ui:button text="${lfn:message('km-carmng:kmCarmng.button3') }" order="2" onclick="clear_data();">
		 </ui:button>&nbsp;&nbsp;
		 <c:if test="${valueListSize > 0}">
		 <ui:button text="${lfn:message('km-carmng:kmCarmng.button1') }" order="3" onclick="exportExcel();">
		 </ui:button>
		 </c:if>
	</div>
	</ui:content>
</ui:tabpanel>	
</html:form>
<c:if test="${valueListSize > 0}">
<div style="height:400px;">
<table id="table_id" class="tb_normal" style="table-layout:fixed;" width="98%" border="0">
	<tr class="tr_normal_title">
		<td width=5%>
			<bean:message key="page.serial"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdVehiclesInfoId"/>
		</td>
		<td>
			<bean:message bundle="km-carmng" key="kmCarmngInfomation.docSubject"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngInfomation.fdVehichesType"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
		</td>
		<c:if test="${fdDeptIds == null || fdDeptIds == ''}">
		<td>
			<bean:message bundle="km-carmng" key="kmCarmngInsuranceInfo.fdInsurancePrice"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngInfringeInfo.fdInfringeFee"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceFee"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRepairFee"/>
		</td>
		</c:if>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdStopFee"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdTurnpikeFee"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdFuelFee"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdCarwashFee"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdOtherFee"/>
		</td>
		<td >
			<bean:message bundle="km-carmng" key="kmCarmng.fdTotalFee"/>
		</td>
	</tr>
	<c:forEach items="${valueList}" var="context" varStatus="vstatus">
	<tr>
		<td width=5%>
			<c:out value="${vstatus.index+1}" />
		</td>
		<td >
			<c:out value="${context.fdCarNo}" />
		</td>
		<td style="word-break:break-all">
			<c:out value="${context.fdCarName}" />
		</td>
		<td style="word-break:break-all">
			<c:out value="${context.fdCarCategoryName}" />
		</td>
		<td >
			<kmss:showNumber value="${context.fdMileageNumber}" pattern="#.##"/>
		</td>
		<c:if test="${fdDeptIds == null || fdDeptIds == ''}">
		<td >
			<kmss:showNumber value="${context.fdInsuranceInfoFee}" pattern="#.##"/>
		</td>
		<td >
			<kmss:showNumber value="${context.fdInfringeFee}" pattern="#.##"/>
		</td>
		<td >
			<kmss:showNumber value="${context.fdMaintenanceFee}" pattern="#.##"/>
		</td>
		<td >
			<kmss:showNumber value="${context.fdRepairFee}" pattern="#.##"/>
		</td>
		</c:if>
		<td >
			<kmss:showNumber value="${context.fdStopFee}" pattern="#.##"/>
		</td>
		<td >
			<kmss:showNumber value="${context.fdTurnpikeFee}" pattern="#.##"/>
		</td>
		<td >
			<kmss:showNumber value="${context.fdFuelFee}" pattern="#.##"/>
		</td>
		<td >
			<kmss:showNumber value="${context.fdCarwashFee}" pattern="#.##"/>
		</td>
		<td >
			<kmss:showNumber value="${context.fdOtherFee}" pattern="#.##"/>
		</td>		
		<td>
			<kmss:showNumber value="${context.fdTotalFee}" pattern="#.##"/>
		</td>
	</tr>
	</c:forEach>
</table>
</div>
</c:if>
<c:if test="${valueListSize <= 0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
</center>
</template:replace>
</template:include>