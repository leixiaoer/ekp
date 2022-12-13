<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no">
	<template:replace name="title">
	<c:choose>
		<c:when test="${kmCarmngDriversInfoForm.method_GET=='add' }">
			<c:out value="${ lfn:message('km-carmng:kmCarmngDriversInfo.create.title') } - ${lfn:message('km-carmng:module.km.carmng')}"></c:out>	
		</c:when>
		<c:otherwise>
			<c:out value="${kmCarmngDriversInfoForm.fdName} - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
		</c:otherwise>
	</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
		    <c:if test="${kmCarmngDriversInfoForm.method_GET=='edit'}">
		       <ui:button text="${lfn:message('button.update') }" order="2" onclick="commitMethod('update');">
			   </ui:button>
			</c:if>
			<c:if test="${kmCarmngDriversInfoForm.method_GET=='add'}">
			    <ui:button text="${lfn:message('button.save') }" order="2" onclick="commitMethod('save');">
			    </ui:button>
			     <ui:button text="${lfn:message('button.saveadd') }" order="2" onclick="commitMethod('saveadd');">
			    </ui:button>
			</c:if>
			<ui:button text="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
<template:replace name="content"> 
<script type="text/javascript">
Com_IncludeFile("dialog.js|calendar.js");
function changeDriversInfo(obj){
	if(obj.value == '2'){
		document.getElementById("id_1").style.display="";
		document.getElementsByName("fdSysId")[0].value = "";
		document.getElementsByName("fdName")[0].value = "";
		document.getElementsByName("fdName")[0].readOnly = true;	
	}else{
		document.getElementById("id_1").style.display="none";
		document.getElementsByName("fdSysId")[0].value = "";
		document.getElementsByName("fdName")[0].value = "";
		document.getElementsByName("fdName")[0].readOnly = false;
	}
}

function initDisplay(){
	var fdType = "${kmCarmngDriversInfoForm.fdType}";
	if(fdType  == "2"){
		document.getElementById("id_1").style.display="";
		document.getElementsByName("fdName")[0].readOnly = true;
	}else{
		document.getElementById("id_1").style.display="none";
		document.getElementsByName("fdName")[0].readOnly = false;
	}
}

function __compareDate(){
	var fdCredentialsTime = document.getElementsByName("fdCredentialsTime")[0].value;
	var fdValidTime = document.getElementsByName("fdValidTime")[0].value;
	if(fdCredentialsTime != ""&&fdValidTime != ""){
	    var fdCredentialsTimeVal=Date.parse(fdCredentialsTime.replace(/\-/g,'/'));
		var fdCredentialsDate = new Date(fdCredentialsTimeVal);
	    var fdValidTimeVal=Date.parse(fdValidTime.replace(/\-/g,'/'));
		var fdValidDate = new Date(fdValidTimeVal);
		if(fdValidDate.getTime() < fdCredentialsDate.getTime()){
			alert('<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.warn1"/>');
			return false;
		}else{
			return true;
		}
	}
	return true;
}

function commitMethod(method){
	if(__compareDate()){
	  Com_Submit(document.kmCarmngDriversInfoForm, method);
	}
}
</script>
<html:form action="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do"> 

<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngDriversInfo"/></p>

<div class="lui_form_content_frame" style="padding-top:20px">
<table class="tb_normal" width=95%>
	<html:hidden property="fdId"/>
	<tr>
		<!-- 姓名 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdName"/>
		</td>
		<td width=35%>
			<html:hidden property="fdSysId"/>
			<xform:text property="fdName" required="true"/>
			<span id="id_1" style="display:none">
				<a href="javascript:void(0)" onclick="Dialog_Address(false, 'fdSysId', 'fdName', ';', ORG_TYPE_PERSON,function(rtnVal){selectPhoneNumber(rtnVal);})">
					<bean:message key="dialog.selectOrg" />
				</a>
			</span>
			<sunbor:enums property="fdType"  enumsType="kmCarmngDriversInfo_fdType" elementType="radio" htmlElementProperties="onclick='changeDriversInfo(this)'"/>
			<script type="text/javascript">
				initDisplay();
			</script>			
		</td>
		<!-- 排序号 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdOrder"/>
		</td><td width=35%>
			<xform:text property="fdOrder" validators="digits"/>
		</td>
		<!-- 单图片附件 -->
		<td width=35% rowspan="6">
			<div>
				<c:import
					url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="fdKey" value="kmCarmngDriverPic" />
					<c:param name="fdMulti" value="false" />
					<c:param name="fdAttType" value="pic" />
					<c:param name="fdImgHtmlProperty" value="width=120" />
					<%-- 图片设定大小 --%>
					<c:param name="picWidth" value="150" />
					<c:param name="picHeight" value="100" />
					<c:param name="fdLayoutType" value="pic"/>
					<c:param name="fdPicContentWidth" value="155"/>
					<c:param name="fdPicContentHeight" value="200"/>
					<c:param name="fdViewType" value="pic_single"/>
				</c:import>
			</div>
		</td>
	</tr>
	<tr>
		<!-- 所属车队 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdMotorcadeId"/>
		</td><td width=35%>
			<xform:select property="fdMotorcadeId" required="true" subject="${lfn:message('km-carmng:kmCarmngDriversInfo.fdMotorcadeId')}" style="width:95%">
			  <xform:beanDataSource serviceBean="kmCarmngMotorcadeSetService" whereBlock="kmCarmngMotorcadeSet.isEffective = 'true' or kmCarmngMotorcadeSet.isEffective is null" orderBy="kmCarmngMotorcadeSet.fdId desc"></xform:beanDataSource>
			</xform:select>
		</td>
		<!-- 手机 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdRelationPhone"/>
		</td>
		<td width=35%>
			<xform:text property="fdRelationPhone" required="true" validators="phoneNumber"/>
		</td>
	</tr>
	<tr>
		<!-- 证件类型 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdCredentialsType"/>
		</td><td width=35%>
			<xform:text property="fdCredentialsType"/>			
		</td>
		<!-- 证件号码 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdCredentialsNumber"/>
		</td><td width=35%>
			<xform:text property="fdCredentialsNumber" validators="mask maxLength(20)"/>
		</td>
		
	</tr>
	<tr>
		<!-- 初次领证时间 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdCredentialsTime"/>
		</td><td width=35%>
			<xform:datetime dateTimeType="date" property="fdCredentialsTime"/>
		</td>
		<!-- 证件有效期限 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdValidTime"/>
		</td><td width=35%>
			<xform:datetime dateTimeType="date"  property="fdValidTime"/>
		</td>
	</tr>
	<tr>
		<!-- 驾驶证号 -->	
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdDriverNumber"/>
		</td><td width=35%>
			<xform:text property="fdDriverNumber" required="true"/>
		</td>
		<!-- 驾龄 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdDriveYear"/>
		</td><td width=35%>
			<xform:text property="fdDriveYear" validators="digits"/><bean:message  bundle="km-carmng" key="kmCarmng.message.year"/>
		</td>
		
	</tr>
	<tr>
		<!-- 年审时间 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdAnnualAuditingTime"/>
		</td><td width=35%>
			<xform:datetime  dateTimeType="date"  property="fdAnnualAuditingTime"/>
		</td>
		<!-- 年审频率 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdAnnualExamFrequency"/>
		</td><td width=35%>
			<xform:text property="fdAnnualExamFrequency" validators="digits"/>
			<bean:message  bundle="km-carmng" key="kmCarmng.message.frequency"/>
		</td>
	</tr>
	<tr>
		<!-- 备注 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdRemark"/>
		</td><td width=35% colspan="4">
			<xform:textarea style="width:95%" htmlElementProperties="data-actor-expand='true'" property="fdRemark"/>
		</td>
		
	</tr>
	<tr>
		<!-- 创建者 -->
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-carmng" key="kmCarmngDriversInfo.docCreatorId"/>
		</td><td width=35%>
			<html:hidden property="docCreatorId"/>
			<html:text readonly="true" property="docCreatorName"/>
		</td>
		<!-- 创建时间 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.docCreateTime"/>
		</td><td width=35% colspan="3">
			<html:text readonly="true" property="docCreateTime"/>
		</td>
	</tr>
</table>
</div>
<html:hidden property="method_GET"/>
 <script language="JavaScript">
 		var _validation = $KMSSValidation(document.forms['kmCarmngDriversInfoForm']);
		_validation.addValidator('mask','<bean:message bundle="km-carmng" key="kmCarmngDriversInfo.fdCredentialsNumber.message" />',function(v,e,o){
			return /^[a-zA-Z0-9]*$/.test(v);
		});
 </script>
 <script>
	seajs.use(['lui/jquery'], function($) {
		window.selectPhoneNumber = function(rtnVal){
			var url = "${LUI_ContextPath}/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=selectPhoneNumber";
			$.post(url,$.param({"fdId":rtnVal.data[0].id},true),function(data){
				document.getElementsByName('fdRelationPhone')[0].value=data.phoneNumber;
				},'json');
			
		}
	});
 </script>
</html:form>
</template:replace>
</template:include>