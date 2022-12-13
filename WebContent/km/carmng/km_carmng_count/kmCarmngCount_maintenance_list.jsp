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
function clear_data(){
	document.getElementsByName("fdStartTime")[0].value="";
	document.getElementsByName("fdEndTime")[0].value="";
	document.getElementsByName("fdCarInfoNo")[0].value="";
	document.getElementsByName("fdCarCategoryId")[0].value="";
	document.getElementsByName("fdCarCategoryName")[0].value="";
}	
function isNullDate(){
	var fdStartTime =  document.getElementsByName("fdStartTime")[0].value;
	 var fdEndTime = document.getElementsByName("fdEndTime")[0].value;
	 if(fdStartTime == '' || fdEndTime == ''){
		 return false;
	 }
}
function exportExcel(){
    var fdStartTime = document.getElementsByName("fdStartTime")[0];
    var fdEndTime = document.getElementsByName("fdEndTime")[0];
    if(fdStartTime && fdEndTime){
    	Com_OpenWindow('${KMSS_Parameter_ContextPath}km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=saveExportExcel&fdStartTime=' + fdStartTime.value + '&fdEndTime=' + fdEndTime.value,'_blank');
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
<html:form action="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do">
<ui:tabpanel id="kmCarmngMaintenanceInfoCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmCarmngMaintenanceInfoCountContent" title="${ lfn:message('km-carmng:kmCarmng.tree.fee.count2') }">
<div style="padding-top: 20px">
	<table width="98%" class="tb_normal">
			<tr>
				<td class="td_normal_title"><bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime"/></td>
				<td>
					<input class="inputsgl" class="inputsgl" type="text" name="fdStartTime" readonly="readonly" value="${fdStartTime}">
					<a href="#"
						onclick="selectDate('fdStartTime');"><bean:message
						key="dialog.selectOther" /></a>
					<span class="txtstrong">*</span>
				</td>
				<td class="td_normal_title"><bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime"/></td>
				<td>
					<input class="inputsgl" class="inputsgl" type="text" name="fdEndTime" readonly="readonly" value="${fdEndTime}">
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
				<td class="td_normal_title"><bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/></td>
				<td>
					<input class="inputsgl" type="text" name="fdCarInfoNo" value="${fdCarInfoNo}">
				</td>
			</tr>		
	</table>
	</div>
	<div style="text-align: center;margin-top: 10px;margin-bottom:10px">
		 <ui:button text="${lfn:message('km-carmng:kmCarmng.button4') }" order="1" onclick="Com_Submit(document.kmCarmngMaintenanceInfoForm, 'count');">
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
	<tr class="tr_normal_title" height="30px" height="30px" >
		<td width=5% style="text-align:center;">
			<bean:message key="page.serial"/>
		</td>
		<td width=15% style="text-align:center;">
			<bean:message bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdVehiclesInfoId"/>
		</td>
		<td width=15% style="text-align:center;">
			<bean:message bundle="km-carmng" key="kmCarmngInfomation.docSubject"/>
		</td>
		<td width=15% style="text-align:center;">
			<bean:message bundle="km-carmng" key="kmCarmngInfomation.fdVehichesType"/>
		</td>
		<td width=15% style="text-align:center;">
			<bean:message bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdMaintenanceFee"/>
		</td>
		<td width=15% style="text-align:center;">
			<bean:message bundle="km-carmng" key="kmCarmngMaintenanceInfo.fdRepairFee"/>
		</td>
		<td width=15% style="text-align:center;">
			<bean:message bundle="km-carmng" key="kmCarmng.fdTotalFee"/>
		</td>
	</tr>
	<c:forEach items="${valueList}" var="context" varStatus="vstatus">
	<tr height="30px">
		<td width=5% style="text-align:center;">
			<c:out value="${vstatus.index+1}" />
		</td>
		<td width=15% style="text-align:center;">
			<c:out value="${context.fdCarNo}" />
		</td>
		<td width=15% style="text-align:center;">
			<c:out value="${context.fdCarName}" />
		</td>
		<td width=15% style="text-align:center;">
			<c:out value="${context.fdCarCategoryName}" />
		</td>
		<td width=15% style="text-align:center;">
			<kmss:showNumber value="${context.fdMaintenanceFee}" pattern="#.##"/>
		</td>
		<td width=15% style="text-align:center;">
			<kmss:showNumber value="${context.fdRepairFee}" pattern="#.##"/>
		</td>
		<td width=15% style="text-align:center;">
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