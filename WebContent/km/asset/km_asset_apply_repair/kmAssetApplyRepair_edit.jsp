<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<!--数字转中文JS  -->
<%@include file="/km/asset/resource/chinaValue.jsp"%>
<script>
Com_IncludeFile("dialog.js|xform.js|doclist.js|jquery.js");
Com_IncludeFile("calendar.js");
</script>
<script>
$(document).ready(function (){
	
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
	var startDate=document.getElementsByName("fdStartDate")[0];
	var endDate=document.getElementsByName("fdEndDate")[0];

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
		var days=DateDiff(fdEndDate,fdStartDate);
		document.getElementsByName("dateNum")[0].value = days;
	}
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
<div id="optBarDiv">
	<c:if test="${kmAssetApplyRepairForm.method_GET=='edit'}">
	    <c:if test="${ kmAssetApplyRepairForm.docStatus == '10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update', 'true');">
		</c:if>
		<c:if test="${kmAssetApplyRepairForm.docStatus=='10'||kmAssetApplyRepairForm.docStatus=='11'||kmAssetApplyRepairForm.docStatus=='20' }">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update');">
		</c:if>
	</c:if>
	<c:if test="${kmAssetApplyRepairForm.method_GET=='add'}">
	    <input type="button" value="<bean:message key="button.savedraft" />"
			onclick="commitMethod('save', 'true');" />
		<input type=button value="<bean:message key="button.submit"/>"
			onclick="commitMethod('save');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

	<p class="txttitle">
		<c:if test="${not empty txttitle}">${txttitle}</c:if>
		<c:if test="${empty  txttitle}">
			<bean:message bundle="km-asset" key="table.kmAssetApplyRepair"/>
		</c:if>
	</p>

<center>
	<table id="Label_Tabel" width=95% LKS_LabelDefaultIndex="1" LKS_OnLabelSwitch="switchLabelEvent">
		<tr
			LKS_LabelName="<bean:message bundle='km-asset' key='kmAssetApplyRepair.baseinfo'/>">
			<td>
			<table class="tb_normal" width=95%>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
					<td width="85%" colspan="5">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" />
					</td>
					<td width="19%">
						<html:hidden property="fdApplyTemplateId" />
						<html:hidden property="fdApplyTemplateName" />
						${kmAssetApplyRepairForm.fdApplyTemplateName}
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo" />
					</td>
					<td width="51%" colspan="3">
					<c:choose>
						<c:when test='${kmAssetApplyRepairForm.fdNo!=null}'>
						    <xform:text property="fdNo" style="width:85%" />
						</c:when>
						<c:otherwise>
							<bean:message bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
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
					<td width="100%" colspan="6">
						<c:import url="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList_edit.jsp" charEncoding="UTF-8">
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdIsUsedExpend" />
					</td>
					<td width="35%" colspan="5">
						<xform:radio property="fdIsUsedExpend" onValueChange="event_fdIsUsedExpend(this.value);">
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
					<td width="100%" colspan="6">
						<c:import url="/km/asset/km_asset_apply_repair_expend/kmAssetApplyRepairExpend_edit.jsp" charEncoding="UTF-8"> 
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdTotalMoney" />
					</td>
					<td width="85%" colspan="5">
						<xform:text property="fdTotalMoney" style="width:25%" htmlElementProperties="readonly='readonly'"  className="inputread"/>
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
								<xform:datetime property="fdStartDate" dateTimeType="date" style="width:85%" onValueChange="checkForm"/> 
								</nobr>
							</td>
							<td width="5%" style="border: 0" >
								<bean:message bundle="km-asset" key="kmAssetApplyRent.to"/>
							</td>
							<td width="25%" style="border: 0" >
								<nobr>
								<xform:datetime property="fdEndDate" dateTimeType="date" style="width:85%" onValueChange="checkForm"/>
								</nobr>
							</td>
							<td width="40%" style="border: 0" >
								<bean:message bundle="km-asset" key="kmAssetApplyRent.total"/>&nbsp;
								<xform:text property="dateNum" style="width:50px" htmlElementProperties="readonly='true' "  className="inputread"/>
								<bean:message bundle="km-asset" key="kmAssetApplyRent.day"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdReason" />
					</td>
					<td width="85%" colspan="5">
						<xform:textarea property="fdReason" style="width:100%"/>
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.attachMent" />
					</td>
					<td colspan="5">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="attachment" />
							<c:param name="fdModelId" value="${param.fdId }" />
							<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRepair" />
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain" />
					</td>
					<td width="85%" colspan="5">
				    	<html:hidden property="fdExplain" />
		            	<kmss:showText value="${kmAssetApplyRepairForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<%---关联机制 开始----%>
		<tr
			LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
			<c:set var="mainModelForm" value="${kmAssetApplyRepairForm}"
				scope="request" />
			<c:set var="currModelName"
				value="com.landray.kmss.km.asset.model.KmAssetApplyRepair"
				scope="request" />
			<td><%@ include
				file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
		</tr>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyRepairForm" />
			<c:param name="fdKey" value="KmAssetApplyRepairDoc" />
			<c:param name="showHistoryOpers" value="true" />
		</c:import>
		<!-- 权限机制-->
		<tr
			LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />"
			style="display: none">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyRepairForm" />
					<c:param name="moduleModelName"
						value="com.landray.kmss.km.asset.model.KmAssetApplyRepair" />
				</c:import>
			</table>
			</td>
		</tr>
		<!-- 权限机制 -->
	</table>
	</center>
<html:hidden property="fdId" />
<html:hidden property="docStatus" value="20"/>
<html:hidden property="method_GET" />
<input type="hidden" name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRepair"/>
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>