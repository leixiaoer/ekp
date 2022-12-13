<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<template:include ref="default.view" sidebar="no" showQrcode="false">
	<template:replace name="head">
		<style type="text/css">
			@media print {
				.com_goto{
					display: none;
				}
				#toolBarDiv{
					display: none;
				}
			}
		</style>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmAssetApplyRepairForm.docSubject} - ${ lfn:message('km-asset:module.km.asset')}"></c:out>
	</template:replace>
		
	<template:replace name="content">
	<%@ include file="/km/asset/resource/assetcommon.jsp"%>
    <%@include file="/km/asset/resource/chinaValue.jsp"%>
<script>
	Com_IncludeFile("jquery.js");
</script>
	<script>
$(document).ready(function(){
	var fdStartDate=document.getElementsByName("fdStartDate")[0].value;
	var fdEndDate=document.getElementsByName("fdEndDate")[0].value;
	var days=DateDiff(fdEndDate,fdStartDate);
	document.getElementById("dateNum").innerHTML = days;

	var fdTotalMoney= document.getElementsByName('fdTotalMoney')[0].value;
	if(fdTotalMoney!='')
	{
		//更新中文数字
		var chinaValue=document.getElementById("chinaValue");
		chinaValue.innerHTML=showChinaValue(fdTotalMoney);
	}
});

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
	   if(maxDate==''&&minDate==''){
           return "";
    }
	   return  days+1  ;
	} 
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div style="padding-top:50px">
<p class="txttitle">${txttitle}</p>
<div class="lui_form_content_frame">
<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
					<td width="85%" colspan="5"><xform:text property="docSubject"
						style="width:85%" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="19%">${kmAssetApplyRepairForm.fdApplyTemplateName}</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
					<td width="51%" colspan="3"><xform:text property="fdNo"
						style="width:85%" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
					<td width="19%">
					<c:out value="${kmAssetApplyRepairForm.fdCreatorName}" /></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
					<td width="19%">
					<c:out value="${kmAssetApplyRepairForm.fdDeptName}" />
					</td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
					<td width="19%"><xform:datetime property="fdCreateDate" dateTimeType="datetime"/></td>
				</tr>
					<!-- 资产基本信息 -->
				<tr>
					<td width="100%" colspan="6" class="td_normal_title" align="center">
				    <bean:message bundle="km-asset" key="kmAssetApplyRepairList.cardBaseInfo" />
					</td>
				</tr>	
				<!--维修保养明细 -->
				 
				<tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_repair_list/kmAssetApplyRepairList_view.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr>
			   
			    <!-- 是否有效-->
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyRepair.fdIsUsedExpend"/>
				</td><td colspan="5">
					<xform:select property="fdIsUsedExpend">
							<xform:enumsDataSource enumsType="km_asset_repair_is_used_expend" />
					</xform:select>
				</td> 
			   
				<!--  耗材明细 -->
		      <c:if test="${kmAssetApplyRepairForm.fdIsUsedExpend=='true'}"> 
				 <!-- 耗材基本信息 -->
				<tr id="RepairExpendInfoBase">
					<td width="100%" class="td_normal_title" colspan="6" align="center">
				 	<bean:message bundle="km-asset" key="kmAssetApplyRepairList.expendInfo" />
					</td>
				</tr>
				  
				<tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_repair_expend/kmAssetApplyRepairExpend_view.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr>
				</c:if>		
			
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyRepair.fdTotalMoney" /></td>
					<td width="85%" colspan="5">
					<input type="hidden" name="fdTotalMoney" value="${kmAssetApplyRepairForm.fdTotalMoney}"/>
					<kmss:showNumber value="${kmAssetApplyRepairForm.fdTotalMoney}" pattern="###,##0.00"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
							<%--中文大写--%>
							<bean:message bundle="km-asset" key="kmAssetApplyBuy.patten.chinaCase"/>
							<span id="chinaValue"></span>
					 </td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyRepair.fdStartEndDate" /></td>
					<td width="85%" colspan="5">
					<input type="hidden" name="fdStartDate" value="${kmAssetApplyRepairForm.fdStartDate}"/>${kmAssetApplyRepairForm.fdStartDate}&nbsp;
					<bean:message bundle="km-asset" key="kmAssetApplyRepair.to" />&nbsp;<input type="hidden" name="fdEndDate" value="${kmAssetApplyRepairForm.fdEndDate}"/>${kmAssetApplyRepairForm.fdEndDate}
					&nbsp;<bean:message bundle="km-asset" key="kmAssetApplyRepair.total" />&nbsp;<span style="width:15px" id="dateNum"></span><bean:message bundle="km-asset" key="kmAssetApplyRepair.day" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyRepair.fdReason" /></td>
					<td width="85%" colspan="5"><kmss:showText  value="${kmAssetApplyRepairForm.fdReason}"/></td>

				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
					<td colspan="5"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }"/>
						<c:param name="fdModelName"
							value="com.landray.kmss.km.asset.model.KmAssetApplyRepair" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
					<td width="85%" colspan="5">
			           <kmss:showText value="${kmAssetApplyRepairForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>
		</table>
		<br/>
			<table class="tb_normal" width="100%">
			   <tr>
			   		<td class="td_normal_title" width="100%" align="center">
					    审批记录
					</td>
				</tr>
				<tr>
					<td width="100%">
					    <c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmAssetApplyRepairForm" />
						</c:import>
					</td>
				</tr>
			</table>
			<div id="toolBarDiv" style="padding-top:20px;text-align:right;">
			      <input type="button" class="lui_form_button"  value="<bean:message key='button.print' />"  onclick="window.print();"  style="width:100px;height:60px;font-size:18px"/>
		    </div>
	</div>
</div>
	</template:replace>
</template:include>
