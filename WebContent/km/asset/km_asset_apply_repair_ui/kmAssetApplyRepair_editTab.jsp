<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<%@include file="/km/asset/resource/chinaValue.jsp"%>
	<script>
Com_IncludeFile("dialog.js|xform.js|doclist.js|jquery.js");
Com_IncludeFile("calendar.js");
</script>
<script>
$(document).ready(function (){
	<c:if test="${ kmAssetApplyRepairForm.method_GET == 'edit' }">
		var fdStartDate=document.getElementsByName("fdStartDate")[0].value;
		var fdEndDate=document.getElementsByName("fdEndDate")[0].value;
		var days=DateDiff(fdEndDate,fdStartDate);
		document.getElementsByName("dateNum")[0].value = days;
	</c:if>
	
	var fdTotalMoney= document.getElementsByName('fdTotalMoney')[0].value;
	if(fdTotalMoney!='')
	{
		//更新中文数字
		var chinaValue=document.getElementById("chinaValue");
		chinaValue.innerHTML=showChinaValue(fdTotalMoney);
	}
	var radio=$("input[name='fdIsUsedExpend'][checked]").val();
	if(radio!='true')
	{
		$('#RepairExpendInfo').hide();
		$('#RepairExpendInfoBase').hide();
	}
});

/**
* 功能：是否选择需要耗材
*/
function event_fdIsUsedExpend(value){
	if(value=='true'){
		$('#RepairExpendInfo').show();
		$('#RepairExpendInfoBase').show();
		DocList_AddRow('TABLE_DocList');
	}else{
		var table = document.getElementById("TABLE_DocList");
		var len = table.rows.length; 
        for(var i=len-1; i>0; i--){   
          table.deleteRow(i);  
         var tbInfo = DocList_TableInfo[table.id];
     	 tbInfo.lastIndex--;
        } 
		$('#RepairExpendInfo').hide();
		$('#RepairExpendInfoBase').hide();
	}	
}	
/**
* 功能：表单日期验证
*/
function checkForm(v,o){
	var fdStartDate=document.getElementsByName("fdStartDate")[0].value;
	var fdEndDate=document.getElementsByName("fdEndDate")[0].value;

    if(fdStartDate!=""&&fdStartDate!=null&&fdEndDate!=""&&fdEndDate!=null){ 
        var days=DateDiff(fdEndDate,fdStartDate);
		document.getElementsByName("dateNum")[0].value = days;
    }
	//return true;
}

/**
*      功能：比较两个日期的大小
*      参数：maxDate 待比较日期 如：2013-12-18
*                minDate 待比较日期 如：2013-12-18
* reuturn：true 大于等于当前系统时间  
*               false 小于当前系统时间
*/
function Compare2Date(maxDate,minDate){
     var maDate= new Date(maxDate.replace(/-/g,'/'));//利用正则表达式吧-全部变成/
     var miDate= new Date(minDate.replace(/-/g,'/'));//利用正则表达式吧-全部变成/
     if(maDate<miDate){
         return false;
     }
     return true;
}


/**
*      功能：与当前日期比较
*      参数：comDate 待比较日期 如：2013-12-18
* reuturn：true 大于等于当前系统时间  
*               false 小于当前系统时间
*/
function CompareCurrDate(comDate){
	var currDate = new Date();    //取当前年月日
	var compareDate=new Date(comDate.replace(/-/g,'/'));
	compareDate.setHours(currDate.getHours(), currDate.getMinutes(),currDate.getSeconds(),currDate.getMilliseconds());
   var n = compareDate.getTime() - currDate.getTime(); 
   if(n<0){
       return false;
   }else{
       return true;
   }
}

/**
* 计算两个日期相隔天数 
* 参数：sDate1：较大日期 如：2013-12-18
*           sDate2 : 较小日期 如：2013-11-18
*return:日期相差天数
* 
*/
function  DateDiff(maxDate,minDate){    //sDate1和sDate2是2006-12-18格式  
	var maDate= Com_GetDate(maxDate);//利用正则表达式吧-全部变成/
   var miDate= Com_GetDate(minDate);//利用正则表达式吧-全部变成/
   var days  =  parseInt(Math.abs(maDate.getTime()  -  miDate.getTime())  /  1000  /  60  /  60  /24)  ;  //把相差的毫秒数转换为天数  
   return  days +1 ;
}    

//提交表单
function commitMethod(method, saveDraft){
	var docStatus = document.getElementsByName("docStatus")[0];
	if (saveDraft != null && saveDraft == 'true'){
		docStatus.value = "10";
	} else {
		docStatus.value = "20";
	}
	Com_Submit(document.kmAssetApplyRepairForm, method);
}

</script>
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmAssetApplyRepairForm" method="post" action ="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_repair/kmAssetApplyRepair.do">
	</c:if>
	<html:hidden property="fdId" />
	<html:hidden property="docStatus" value="20"/>
	<html:hidden property="method_GET" />
	<html:hidden property="titleRegulation" />
	<input type="hidden" name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRepair"/>
	 <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpage collapsed="true" id="reviewTabPage">
				<script>
					LUI.ready(function(){
						setTimeout(function(){
							var reviewTabPage = LUI("reviewTabPage");
							if(reviewTabPage!=null){
								reviewTabPage.element.find(".lui_tabpage_float_collapse").hide();
								reviewTabPage.element.find(".lui_tabpage_float_navs_mark").hide();
							}
						},100)
					})
				</script>
				<c:import url="/km/asset/km_asset_apply_repair_ui/kmAssetApplyRepair_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
			</ui:tabpage>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRepairForm" />
					<c:param name="fdKey" value="KmAssetApplyRepairDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
				<c:import url="/km/asset/km_asset_apply_repair_ui/kmAssetApplyRepair_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/asset/km_asset_apply_repair_ui/kmAssetApplyRepair_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
				<c:import url="/km/asset/km_asset_apply_repair_ui/kmAssetApplyRepair_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	  			</c:import>
			</ui:tabpage>
			</form>
		</c:otherwise>
	</c:choose>
	</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRepairForm" />
					<c:param name="fdKey" value="KmAssetApplyRepairDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRepairForm" />
					<c:param name="approveType" value="right" />
					<c:param name="needTitle" value="true" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<%--关联机制(与原有机制有差异)--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyRepairForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>