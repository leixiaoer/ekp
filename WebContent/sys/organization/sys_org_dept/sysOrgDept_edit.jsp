<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/sys/organization/sys_org_dept/sysOrgDept.do">
<div id="optBarDiv">
	<logic:equal name="sysOrgDeptForm" property="method_GET" value="edit">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="__update();">
	</logic:equal>
	<logic:equal name="sysOrgDeptForm" property="method_GET" value="add">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.sysOrgDeptForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.sysOrgDeptForm, 'saveadd');">
	</logic:equal>
	<input type="button" value="<bean:message key="button.close"/>" onClick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message bundle="sys-organization" key="sysOrgElement.dept"/><bean:message key="button.edit"/></p>
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdName"/>
		</td><td width=35% colspan="3">
		    <xform:text property="fdName" validators="uniqueName invalidName" style="width:90%"></xform:text>
			<div id="fdName_id"></div>
		</td>
	</tr>
	<tr>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdParent"/>
		</td><td width=35%>
			<html:hidden property="fdParentId"/>
			<html:text style="width:90%" property="fdParentName" readonly="true" styleClass="inputsgl"/>
			<a href="#" onclick="Dialog_Tree(
				false,
				'fdParentId',
				'fdParentName',
				null,
				'organizationTree&parent=!{value}&orgType='+(ORG_TYPE_ORGORDEPT|ORG_FLAG_BUSINESSALL),
				'<bean:message bundle="sys-organization" key="organization.moduleName"/>',
				null,
				null,
				'<bean:write name="sysOrgDeptForm" property="fdId"/>');">
				<bean:message key="dialog.selectOrg"/>
			</a>
		</td>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdNo"/>
		</td><td width=35%>
			<%-- 引用通用的编号属性 --%>
			<input type="hidden" name="fdOrgType" value="2">
			<%@ include file="/sys/organization/org_common_fdNo_edit.jsp"%>
		</td>
	</tr>
	<tr>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdThisLeader"/>
		</td><td width=35%>
			<html:hidden property="fdThisLeaderId"/>
			<html:text style="width:90%" property="fdThisLeaderName" readonly="true" styleClass="inputsgl"/>
			<a href="#" onclick="Dialog_Address(false, 'fdThisLeaderId', 'fdThisLeaderName', null, ORG_TYPE_POSTORPERSON);">
				<bean:message key="dialog.selectOrg"/>
			</a>
		</td>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdSuperLeader"/>
		</td><td width=35%>
			<html:hidden property="fdSuperLeaderId"/>
			<html:text style="width:90%" property="fdSuperLeaderName" readonly="true" styleClass="inputsgl"/>
			<a href="#" onclick="Dialog_Address(false, 'fdSuperLeaderId', 'fdSuperLeaderName', null, ORG_TYPE_POSTORPERSON);">
				<bean:message key="dialog.selectOrg"/>
			</a>
		</td>
	</tr>
	<tr>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdKeyword"/>
		</td><td width=35%>
		    <xform:text property="fdKeyword" style="width:90%"></xform:text>
			
		</td>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdOrder"/>
		</td><td width=35%>
			 <xform:text property="fdOrder" style="width:90%"></xform:text>
		</td>
	</tr>
	<tr>
		<td width=15% class="td_normal_title">
		    <bean:message bundle="sys-organization" key="sysOrgElement.fdOrgEmail"/>
		</td><td width=35% colspan="3">
		    <xform:text property="fdOrgEmail" style="width:90%"></xform:text>
		</td>
	</tr>
	<tr>
		<c:set var="_colspan" value="3" />
		<c:if test="${sysOrgDeptForm.method_GET=='edit'}">
			<c:set var="_colspan" value="1" />
			<td width=15% class="td_normal_title">
				<bean:message bundle="sys-organization" key="sysOrgDept.fdIsAvailable"/>
			</td>
			<td width="35%">
				<sunbor:enums property="fdIsAvailable" enumsType="sys_org_available" elementType="radio" />
			</td>
		</c:if>
		<td width=15% class="td_normal_title">
		    <bean:message bundle="sys-organization" key="sysOrgDept.fdIsBusiness"/>	
		</td>
		<td width=35% colspan="${_colspan}">
		    <sunbor:enums property="fdIsBusiness" enumsType="common_yesno" elementType="radio" />	
		</td>
	</tr>	
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-organization" key="sysOrgElement.authElementAdmins"/>
		</td><td width="85%" colspan="3">
			<xform:address propertyId="authElementAdminIds" propertyName="authElementAdminNames" mulSelect="true" orgType="ORG_TYPE_POSTORPERSON" style="width:85%" />
			<div class="description_txt">
				<bean:message bundle="sys-organization" key="sysOrgElement.authElementAdmins.describe"/>
			</div>
		</td>
	</tr>			
	<tr>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdMemo"/>
		</td><td colspan="3">
		    <xform:textarea property="fdMemo" style="width:100%"></xform:textarea>
		</td>
	</tr>
	<%-- 引入动态属性 --%>
	<c:import url="/sys/property/custom_field/custom_fieldEdit.jsp" charEncoding="UTF-8" />
	
	<logic:equal name="sysOrgDeptForm" property="method_GET" value="edit">
	<c:if test="${'true' eq sysOrgDeptForm.fdIsRelation}">
	<tr>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgDept.fdIsRelation"/>
		</td><td colspan="3">
		    <xform:checkbox property="fdIsRelation" showStatus="edit">
			   	<xform:simpleDataSource value="true">
			   		<bean:message bundle="sys-organization" key="sysOrgDept.fdIsRelation.desc"/>
			   	</xform:simpleDataSource>
			</xform:checkbox>
		</td>
	</tr>
	</c:if>
	</logic:equal>
	<tr>
		<td colspan="4">
			<bean:message bundle="sys-organization" key="organization.org.dept.different"/><br>
			<bean:message bundle="sys-organization" key="organization.org.dept.different1"/><br>
			<bean:message bundle="sys-organization" key="organization.org.dept.different2"/><br>
			<bean:message bundle="sys-organization" key="organization.org.dept.different3"/><br>
		</td>
	</tr>
			
</table>
</center>
<html:hidden property="method_GET"/>
<html:hidden property="fdId"/>
</html:form>
<script>Com_IncludeFile("dialog.js");</script>
<script language="JavaScript">
	Com_IncludeFile("data.js");
	var _validation = $KMSSValidation(document.forms['sysOrgDeptForm']);

	var NameValidators = {
			'uniqueName' : {
				error : "<bean:message key='sysOrgDept.error.fdName.mustUnique' bundle='sys-organization' />",
				test : function (value) {
						var fdId = document.getElementsByName("fdId")[0].value;
						var result = checkNameUnique("sysOrgElementService",value,fdId,"unique");
						if (!result) 
							return false;
						return true;
				      }
			},
 			'invalidName': {
				error : "<bean:message key='sysOrgDept.error.newNameSameOldName' bundle='sys-organization' />",
				test  : function(value) {
						if (NameValidators["fdName"] && (NameValidators["fdName"]==value)){
						    return true;
					    }
					 	NameValidators["fdName"]=null;
						var fdId = document.getElementsByName("fdId")[0].value;
						var result = checkNameUnique("sysOrgElementService",value,fdId,"invalid");
						if (!result){ 
							if(window.confirm("<bean:message key='sysOrgDept.warn.fdName.ConfirmMsg' bundle='sys-organization' />")){
								NameValidators["fdName"]=value;
								return true;
							}else{
							  	return false;
							}
						}
						return true;	
			    }
			}
 	};
	_validation.addValidators(NameValidators);
		
	//校验名称是否唯一
	function checkNameUnique(bean, fdName,fdId,checkType) {
		fdName = encodeURIComponent(fdName);
		var url = encodeURI(Com_Parameter.ResPath + "jsp/ajax.jsp?&serviceName=" 
				+ bean + "&fdName=" + fdName+"&fdId="+fdId+"&checkType="+checkType+"&fdOrgType=2&date="+new Date());
		var xmlHttpRequest;
		if (window.XMLHttpRequest) { // Non-IE browsers
			xmlHttpRequest = new XMLHttpRequest();
		} else if (window.ActiveXObject) { // IE
			try {
				xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (othermicrosoft) {
				try {
					xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (failed) {
					xmlHttpRequest = false;
				}
			}
		}
		if (xmlHttpRequest) {
			xmlHttpRequest.open("GET", url, false);
			xmlHttpRequest.send();
			var result = xmlHttpRequest.responseText.replace(/\s/g, "").replace(/;/g, "\n");
			if (result != "") {
				return false;
			}
		}
		return true;
	}
	
	function __update() {
		// 更新前需要检查与业务相关的数据
		var _fdIsBusiness = document.getElementsByName("fdIsBusiness");
		var fdIsBusiness;
		for(var i=0; i<_fdIsBusiness.length; i++) {
			if(_fdIsBusiness[i].checked) {
				fdIsBusiness = _fdIsBusiness[i].value;
			}
		}
		var fdId = document.getElementsByName("fdId")[0].value;
		var result = "true" == fdIsBusiness;
		$("#fdIsBusiness_validate").remove();
		if(!result) {
			var data = new KMSSData();
			data.UseCache = false;
			data.AddBeanData("sysOrgElementService&type=1&fdId=" + fdId);
			var rtn = data.GetHashMapArray()[0];
			if(rtn) {
				result = false;
				var validate = '<div class="validation-advice" id="fdIsBusiness_validate" _reminder="true"><table class="validation-table"><tbody><tr><td><div class="lui_icon_s lui_icon_s_icon_validator"></div></td><td class="validation-advice-msg">'+rtn.msg+'</td></tr></tbody></table></div>';
				$(_fdIsBusiness).parents("td").append(validate);
			} else {
				result = true;
			}
		}
		if (result) {
			Com_Submit(document.sysOrgDeptForm, 'update');
		}
		
	}
	
</script>
<c:set var="frameShowTop" scope="page" value="${(empty param.showTop) ? 'yes' : (param.showTop)}"/>
<c:if test="${frameShowTop=='yes' }">
<ui:top id="top"></ui:top>
	<kmss:ifModuleExist path="/sys/help">
		<c:import url="/sys/help/sys_help_template/sysHelp_template_btn.jsp" charEncoding="UTF-8"></c:import>
	</kmss:ifModuleExist>
</c:if>
<%@ include file="/resource/jsp/edit_down.jsp"%>
