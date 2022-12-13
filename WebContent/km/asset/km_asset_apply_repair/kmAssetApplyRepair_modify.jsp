<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!--数字转中文JS  -->
<%@include file="/km/asset/resource/chinaValue.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="title">
		<c:out value="${kmAssetApplyRepairForm.docSubject}-${ lfn:message('km-asset:module.km.asset')}"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="90%">
			<c:if test="${kmAssetApplyRepairForm.docStatus=='10' || kmAssetApplyRepairForm.docStatus=='11'|| kmAssetApplyRepairForm.docStatus=='20'}">
				<kmss:auth requestURL="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
				    <ui:button text="${ lfn:message('button.edit') }" order="2" 
									onclick="Com_OpenWindow('kmAssetApplyRepair.do?method=edit&fdId=${param.fdId}','_self');">
					 </ui:button>
				</kmss:auth>
			</c:if>
			<c:if test="${kmAssetApplyRepairForm.method_GET=='edit'}">
			     
				<c:if test="${kmAssetApplyRepairForm.docStatus=='10'||kmAssetApplyRepairForm.docStatus=='11'||kmAssetApplyRepairForm.docStatus=='20' }">
				    <ui:button text="${ lfn:message('button.submit') }" order="2" 
									onclick="commitMethod('update');">
					</ui:button>
			    </c:if>
	        </c:if>
		  <ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		  </ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.category">
			<ui:varParams  moduleTitle="${ lfn:message('km-asset:module.km.asset') }" 
			    modulePath="/km/asset/" 
				modelName="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" 
			    autoFetch="false" 
			    href="/km/asset/" 
				categoryId="${kmAssetApplyRepairForm.fdApplyTemplateId}" />
		</ui:combin>
	</template:replace>	
	<template:replace name="content">
	<script>
Com_IncludeFile("xform.js|doclist.js");
Com_IncludeFile("calendar.js");
</script>
<script>
$(document).ready(function (){
	var fdStartDate=document.getElementsByName("fdStartDate")[0].value;
	var fdEndDate=document.getElementsByName("fdEndDate")[0].value;
	var days=DateDiff(fdEndDate,fdStartDate);
	document.getElementsByName("dateNum")[0].value = days;
	
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
function checkForm(){
	var fdStartDate=document.getElementsByName("fdStartDate")[0].value;
	var fdEndDate=document.getElementsByName("fdEndDate")[0].value;
//	var startDate=document.getElementsByName("fdStartDate")[0];
//	var endDate=document.getElementsByName("fdEndDate")[0];
/**
	//与当前时间比较
	if(!CompareCurrDate(fdStartDate)){
		alert("开始时间不能小于当前时间");
		startDate.value='';
		return false;
	}
	if(!CompareCurrDate(fdEndDate)){
		alert("结束时间不能小于当前时间");
		endDate.value='';
		return false;
	}
	if(fdStartDate!=""&&fdEndDate!=""){
   //比较开始和结束日期大小
	if(!Compare2Date(fdEndDate,fdStartDate)){
		alert("结束时间不能小于开始时间");
		endDate.value='';
		return false;
	}
**/
   if(fdStartDate!=""&&fdStartDate!=null&&fdEndDate!=""&&fdEndDate!=null){
        var days=DateDiff(fdEndDate,fdStartDate);
		document.getElementsByName("dateNum")[0].value = days;
   }
	//}
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
	var maDate= new Date(maxDate.replace(/-/g,'/'));//利用正则表达式吧-全部变成/
   var miDate= new Date(minDate.replace(/-/g,'/'));//利用正则表达式吧-全部变成/
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
<html:form action="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do">
	<p class="txttitle">
		<c:if test="${not empty txttitle}">${txttitle}</c:if>
		<c:if test="${empty  txttitle}">
			<bean:message bundle="km-asset" key="table.kmAssetApplyRepair"/>
		</c:if>
	</p>
	<div class="lui_form_content_frame">
	<table class="tb_normal" width=95%>
	<html:hidden property="fdId" />
	<html:hidden property="docStatus" value="20"/>
	<html:hidden property="method_GET" />
	<html:hidden property="hasProcessing" value="true"/>
	<input type="hidden" name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRepair"/>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
					<td width="85%" colspan="5"><xform:text property="docSubject"
						style="width:85%" showStatus="readOnly"/></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="19%"><html:hidden property="fdApplyTemplateId" />
					<html:hidden property="fdApplyTemplateName" />
					${kmAssetApplyRepairForm.fdApplyTemplateName}</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
					<td width="51%" colspan="3">
					<c:choose>
						<c:when test='${kmAssetApplyRepairForm.fdNo!=null}'>
						    <xform:text property="fdNo" style="width:85%"  showStatus="readOnly"/>
						</c:when>
						<c:otherwise>
						<bean:message
						bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
					<td width="19%">
						<html:hidden property="fdCreatorId" />
						<xform:text property="fdCreatorName" value="${kmAssetApplyRepairForm.fdCreatorName}" showStatus="view"></xform:text>
					</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
					<td width="19%">
					    <html:hidden property="fdDeptId" />
						<xform:text property="fdDeptName" value="${kmAssetApplyRepairForm.fdDeptName}" showStatus="view"></xform:text>
					</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
					<td width="19%">
					    <html:hidden property="fdCreateDate" />
					    <xform:datetime property="fdCreateDate" dateTimeType="date" showStatus="view"/>
					</td>
				</tr>
				
				<!-- 资产基本信息 -->
				<tr>
					<td width="100%" colspan="6" class="td_normal_title" align="center">
				 	<bean:message bundle="km-asset" key="kmAssetApplyRepairList.cardBaseInfo" />
					</td>
				</tr>
				
				<!-- 维修保养明细 -->
				<tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList_modify.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr>
								<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyRepair.fdIsUsedExpend" /></td>
					<td width="35%" colspan="5"><xform:radio
						property="fdIsUsedExpend" onValueChange="event_fdIsUsedExpend(this.value);" showStatus="edit">
						<xform:enumsDataSource enumsType="km_asset_repair_is_used_expend"/>
					</xform:radio>
					</td>
				</tr>
				
				<!-- 耗材基本信息 -->
				<tr id="RepairExpendInfoBase">
					<td width="100%" class="td_normal_title" colspan="6" align="center">
				 	<bean:message bundle="km-asset" key="kmAssetApplyRepairList.expendInfo" />
					</td>
				</tr>
				
				<!-- 耗材明细 -->	  
				<tr id="RepairExpendInfo">
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_repair_expend/kmAssetApplyRepairExpend_edit.jsp"
						charEncoding="UTF-8"> 
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyRepair.fdTotalMoney" /></td>
					<td width="85%" colspan="5"><xform:text
						property="fdTotalMoney" style="width:25%" htmlElementProperties="readonly='readonly'" showStatus="edit" className="inputread"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
							<%--中文大写--%>
							<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
							<span id="chinaValue"></span>
						</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdStartEndDate" />
					</td>
					<td colspan="5">
						<table style="border: 0" width="70%">
						<tr>
							<td width="25%" style="border: 0" >
								<nobr>
								<xform:datetime property="fdStartDate" dateTimeType="date"  showStatus="edit" onValueChange="checkForm"/> 
								</nobr>
							</td>
							<td width="5%" style="border: 0" >
								<bean:message bundle="km-asset" key="kmAssetApplyRent.to"/>
							</td>
							<td width="25%" style="border: 0" >
								<nobr>
								<xform:datetime property="fdEndDate" dateTimeType="date"  showStatus="edit" onValueChange="checkForm"/>
								</nobr>
							</td>
							<td width="40%" style="border: 0" >
								<bean:message bundle="km-asset" key="kmAssetApplyRent.total"/>&nbsp;
								<xform:text property="dateNum" style="width:50px" htmlElementProperties="readonly='true' " showStatus="readOnly" className="inputread"/>
								<bean:message bundle="km-asset" key="kmAssetApplyRent.day"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyRepair.fdReason" /></td>
					<td width="85%" colspan="5"><xform:textarea
						property="fdReason" style="width:100%" /></td>
				</tr>
								<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
					<td colspan="5"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.km.asset.model.KmAssetApplyRepair" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
					<td width="85%" colspan="5">
					 <html:hidden property="fdExplain" />
			         <kmss:showText value="${kmAssetApplyRepairForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>

			</table>
	</div>
	<ui:tabpage expand="false" var-navwidth="90%">
	   <c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyRepairForm" />
			<c:param name="fdKey" value="KmAssetApplyRepairDoc" />
			<c:param name="onClickSubmitButton" value=" Com_Submit(document.kmAssetApplyRepairForm,'modifyRepairInfo')"></c:param>
			<c:param name="showHistoryOpers" value="true" />
		</c:import>
		<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyRepairForm" />
				<c:param name="moduleModelName"
					value="com.landray.kmss.km.asset.model.KmAssetApplyRepair" />
		</c:import>
    </ui:tabpage>
<script>
	$KMSSValidation();
</script>
</html:form>
	</template:replace>
	<template:replace name="nav">
		<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyRepairForm" />
		</c:import>
	</template:replace>
</template:include>