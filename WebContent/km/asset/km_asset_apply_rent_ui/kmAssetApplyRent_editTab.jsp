<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
	<script type="text/javascript">
Com_IncludeFile("calendar.js|calendar.js");
</script>
<script language="JavaScript">
// 提交表单
function commitMethod(method, saveDraft){
	var docStatus = document.getElementsByName("docStatus")[0];
	if (saveDraft != null && saveDraft == 'true'){
		docStatus.value = "10";
	} else {
		docStatus.value = "20";
	}
	Com_Submit(document.kmAssetApplyRentForm, method);
}
</script>
<script type="text/javascript">
/**
 * 功能：借出期限结束时间计算借出天数
 */
function endSetDay(){
	if(checkForm()){//表单验证
		var fdStartDate=document.getElementsByName("fdStartDate")[0].value;
		var fdEndDate=document.getElementsByName("fdEndDate")[0].value;
		if(fdStartDate!=''&&fdEndDate!=''){//不为空,计算
		var days=DateDiff(fdEndDate,fdStartDate);
		document.getElementsByName("fdDays")[0].value=days;
		}
	}
}

/**
 * 功能：借出期限开始时间计算天数
 */
function startSetDay(){
		var fdStartDate=document.getElementsByName("fdStartDate")[0].value;
		var fdEndDate=document.getElementsByName("fdEndDate")[0].value;
		if(fdStartDate!=''&&fdEndDate!=''){//不为空,计算
		   if(checkForm()){//表单验证
		      var days=DateDiff(fdEndDate,fdStartDate);
		      document.getElementsByName("fdDays")[0].value=days;
			}
		}
}

/**
 * 功能：表单验证
 */
function checkForm(){
	var fdStartDate=document.getElementsByName("fdStartDate")[0].value;
	var fdEndDate=document.getElementsByName("fdEndDate")[0].value;
	var startDate=document.getElementsByName("fdStartDate")[0];
	var endDate=document.getElementsByName("fdEndDate")[0];

	//与当前时间比较
	if(!CompareCurrDate(fdStartDate)){
		alert("借用期限开始时间不能小于当前时间");
		startDate.value='';
		return false;
	}
	if(!CompareCurrDate(fdEndDate)){
		alert("借用期限结束时间不能小于当前时间");
		endDate.value='';
		return false;
	}
    //比较开始和结束日期大小
	if(!Compare2Date(fdEndDate,fdStartDate)){
		alert("借用期限结束时间不能小于开始时间");
		endDate.value='';
		return false;
	}
	var days=DateDiff(fdEndDate,fdStartDate);
	return true;
}

/**
*      功能：比较两个日期的大小
*      参数：maxDate 待比较日期 如：2013-12-18
*                minDate 待比较日期 如：2013-12-18
* reuturn：true 大于等于当前系统时间  
*               false 小于当前系统时间
*/
function Compare2Date(maxDate,minDate){
      var maDate= Com_GetDate(maxDate);//利用正则表达式吧-全部变成/
      var miDate= Com_GetDate(minDate);//利用正则表达式吧-全部变成/
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
	var compareDate= Com_GetDate(comDate);
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
	var maDate= new Date(maxDate.replace(/-/g,'/'));//利用正则表达式吧-全部变成/
    var miDate= new Date(minDate.replace(/-/g,'/'));//利用正则表达式吧-全部变成/
    var days  =  parseInt(Math.abs(maDate.getTime()  -  miDate.getTime())  /  1000  /  60  /  60  /24)  ;  //把相差的毫秒数转换为天数  
    return  days +1 ;
}    

</script>
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmAssetApplyRentForm" method="post" action ="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_rent/kmAssetApplyRent.do">
	</c:if>
	<html:hidden property="fdId" />
	<html:hidden property="fdCreatorId" />
	<html:hidden property="fdDeptId" />
	<html:hidden property="fdCreateDate" />
	<html:hidden property="method_GET" />
	<html:hidden property="docStatus"/>
	<html:hidden property="titleRegulation" />
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
				<c:import url="/km/asset/km_asset_apply_rent_ui/kmAssetApplyRent_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
			</ui:tabpage>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRentForm" />
					<c:param name="fdKey" value="KmAssetApplyRentDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
				<c:import url="/km/asset/km_asset_apply_rent_ui/kmAssetApplyRent_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/asset/km_asset_apply_rent_ui/kmAssetApplyRent_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="baseInfo"></c:param>
	  			</c:import>
				<c:import url="/km/asset/km_asset_apply_rent_ui/kmAssetApplyRent_editContent.jsp" charEncoding="UTF-8">
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
					<c:param name="formName" value="kmAssetApplyRentForm" />
					<c:param name="fdKey" value="KmAssetApplyRentDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRentForm" />
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
				<c:param name="formName" value="kmAssetApplyRentForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>