<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js|calendar.js|jquery.js|calendar.js");
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

</script>
<html:form action="/km/asset/km_asset_apply_rent/kmAssetApplyRent.do">
<div id="optBarDiv">
   <%-- 编辑 --%>
	<c:if test="${kmAssetApplyRentForm.method_GET=='edit'}">
		<c:if test="${kmAssetApplyRentForm.docStatus=='10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="commitMethod('update','true');">
		</c:if>
		<c:if test="${kmAssetApplyRentForm.docStatus<'20'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="commitMethod('update','false');">
		</c:if>
		<c:if test="${kmAssetApplyRentForm.docStatus=='20'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="Com_Submit(document.kmAssetApplyRentForm, 'update');">
		</c:if>
		<c:if test="${kmAssetApplyRentForm.docStatus>='30'}">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="Com_Submit(document.kmAssetApplyRentForm, 'update');">
		</c:if>
	</c:if>
	
	<%-- 增加--%>
	<c:if test="${kmAssetApplyRentForm.method_GET=='add'}">
		<%-- 暂存 --%>
		<input type="button" value="<bean:message key="button.savedraft" />"
			onclick=" commitMethod ('save', 'true');" />
		<%-- 提交 --%>
		<input type="button" value="<bean:message key="button.update" />"
			onclick=" commitMethod ('save');" />
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

	<p class="txttitle">
		<c:if test="${not empty txttitle}">${txttitle}</c:if>
		<c:if test="${empty  txttitle}">
			<bean:message bundle="km-asset" key="table.kmAssetApplyRent"/>
		</c:if>
	</p>

<center>
<table id="Label_Tabel" width="95%" LKS_LabelDefaultIndex="1" LKS_OnLabelSwitch="switchLabelEvent">
 <!-- 基本信息 -->
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="KmAssetApply.baseApply"/>">
		<td>
<table class="tb_normal" width=95%>
		<tr>
			<!--标题-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
			<td colspan="5"><xform:text property="docSubject" style="width:85%" /></td>
		</tr>
		<tr>
			<!--所属模板 -->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/></td>
			<td width="19%">
			     <html:hidden property="fdApplyTemplateId" />
				 <xform:text property="fdApplyTemplateName" style="width:85%" showStatus="view"/>
			</td>
					<!--申请单编号 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
				    	<td colspan="3">  <c:choose>
						<c:when test='${kmAssetApplyRentForm.fdNo!=null}'>
						    <xform:text property="fdNo" style="width:85%" showStatus="view"/>
						</c:when>
						<c:otherwise>
						<bean:message
						bundle="km-asset" key="kmAssetApplyBase.autoCreate" />
					    </c:otherwise>
					</c:choose> 
					</td>
		</tr>	
		<tr>
			<!--申请人-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
			<td width="19%"><xform:address propertyId="fdCreatorId"
				propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON"
				style="width:85%"  showStatus="view"/></td>			
				<!--申请部门-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
			<td width="19%"><html:hidden property="fdDeptId" />
				<xform:address propertyId="fdDeptId"
						propertyName="fdDeptName" orgType="ORG_TYPE_DEPT" style="width:85%" showStatus="view"/>
			</td>
			<!--申请日期-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
			<td width="19%"><xform:datetime property="fdCreateDate"  style="width:85%" showStatus="view"/></td>
		</tr>

       
         <tr>
					<td width="100%" colspan="6"><c:import
						url="/km/asset/km_asset_apply_rent_list/kmAssetApplyRentList_edit.jsp"
						charEncoding="UTF-8">
					</c:import></td>
				</tr>  
		<tr>
			<!--借用期限-->
			<td class="td_normal_title" width=15%><bean:message bundle="km-asset" key="kmAssetApplyRent.deadline"/></td>
			<td colspan="5">
				<table style="border: 0" width="70%">
				<tr>
					<td width="7%" style="border: 0" >
						<bean:message bundle="km-asset" key="kmAssetApplyRent.from"/>
					</td>
					<td width="25%" style="border: 0" >
						<nobr>
						<xform:datetime property="fdStartDate" dateTimeType="date" style="width:85%" onValueChange="startSetDay()"/> 
						</nobr>
					</td>
					<td width="5%" style="border: 0" >
						<bean:message bundle="km-asset" key="kmAssetApplyRent.to"/>
					</td>
					<td width="25%" style="border: 0" >
						<nobr>
						<xform:datetime property="fdEndDate" dateTimeType="date" style="width:85%" onValueChange="endSetDay()"/>
						</nobr>
					</td>
					<td width="40%" style="border: 0" >
						<bean:message bundle="km-asset" key="kmAssetApplyRent.total"/>&nbsp;
						<xform:text property="fdDays" htmlElementProperties="readonly='true' "/>
						<bean:message bundle="km-asset" key="kmAssetApplyRent.day"/>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		
	<tr>
   	 <!-- 借入单位 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyRent.fdForeignBranch"/>
		</td><td width="19%">
			<xform:text property="fdForeignBranch" style="width:85%" />
		</td>
	  <!-- 借入部门 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetApplyRent.fdForeignDept"/>
		</td><td colspan="3">
			<xform:text property="fdForeignDept" style="width:85%" />
		</td>
	</tr>		
	<tr>
			<!--借出单位 -->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyRent.fdRentBranch" /></td>
			<td width="19%">
				<xform:address propertyId="fdRentBranchId" propertyName="fdRentBranchName" orgType="ORG_TYPE_DEPT" style="width:85%" />
			</td>
			<!--借出部门-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyRent.fdRentDept" /></td>
			<td colspan="3">
				<xform:address propertyId="fdRentDeptId" propertyName="fdRentDeptName" orgType="ORG_TYPE_DEPT" style="width:85%" />
			</td>
		</tr>

        <tr>	
		  <!--借出事由-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyRent.reason" /></td>
			<td colspan="5"><xform:textarea property="fdReason" style="width:100%" /></td>
		</tr>
		
		<tr>
			<!--附件机制-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.attachMent" /></td>
			<td colspan="5">
        <c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="attachment"/>
			<c:param name="fdModelId" value="${param.fdId }" />
			<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyRent" />
        </c:import>
			</td>
		</tr>
			
		<tr>	
		  <!--说明-->
			<td class="td_normal_title" width=15%><bean:message
				bundle="km-asset" key="kmAssetApplyBase.fdExplain" /></td>
			<td colspan="5">
			    <html:hidden property="fdExplain" />
			    <kmss:showText value="${kmAssetApplyRentForm.fdExplain}"></kmss:showText> 
			</td>
		</tr>
</table>
</td>
</tr>
	<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyRentForm" />
			<c:param name="fdKey" value="KmAssetApplyRentDoc" />
		</c:import>
		<!-- 权限页签 -->
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table
				class="tb_normal"
				width=100%>
				<c:import
					url="/sys/right/right_edit.jsp"
					charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmAssetApplyRentForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.asset.model.KmAssetApplyRent" />
				</c:import>
			</table>
			</td>
		</tr>
<!-- 关联机制 -->
	<tr LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />" style="display:none">
		<c:set
			var="mainModelForm"
			value="${kmAssetApplyRentForm}"
			scope="request" />
		<c:set
			var="currModelName"
			value="com.landray.kmss.km.asset.model.KmAssetApplyRent"
			scope="request" />
		<td><%@ include file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
	</tr>
	<!-- 关联机制 -->

</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="fdCreatorId" />
<html:hidden property="fdDeptId" />
<html:hidden property="fdCreateDate" />
<html:hidden property="method_GET" />
<html:hidden property="docStatus"/>
<script>
	Com_IncludeFile("calendar.js");
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>