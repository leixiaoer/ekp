<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
<script language="JavaScript">
seajs.use(['theme!form']);
Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");
Com_IncludeFile("dialog.js|optbar.js");
</script>
<html:form action="/sys/circulation/sys_circulation_main/sysCirculationMain.do">
	<p class="txttitle"> <bean:message bundle="sys-circulation" key="table.sysCirculationMain" /></p>
	<center>
	<table class="tb_normal" width=95%>
	<html:hidden property="fdId" />
	<html:hidden property="fdFromParentId" />
	<html:hidden property="fdFromOpinionId" />
		<tr>
			<td class="td_normal_title" width=18%>
				<bean:message bundle="sys-circulation" key="sysCirculationMain.fdCirculatorId" />
			</td>
			<td>
				<html:text property="fdCirculatorName" readonly="true" />
			</td>
			<td class="td_normal_title" width=18%>
				<bean:message bundle="sys-circulation" key="sysCirculationMain.fdCirculationTime" />
			</td>
			<td>
				<html:text property="fdCirculationTime" readonly="true"/>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=18%>
				<bean:message bundle="sys-circulation" key="sysCirculationMain.fdExpireTime" />
			</td>
			<td colspan="3">
				<xform:datetime property="fdExpireTime" dateTimeType="datetime" style="width:50%" validators="after" subject="${ lfn:message('sys-circulation:sysCirculationMain.fdExpireTime') }"></xform:datetime>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=18%>
				<bean:message bundle="sys-circulation" key="sysCirculationMain.fdRegular" />
			</td>
			<td colspan="3">
				<xform:radio property="fdRegular"  showStatus="edit" onValueChange="changeRegular(this.value);">
					<xform:enumsDataSource enumsType="sysCirculationMain_fdRegular"></xform:enumsDataSource>
				</xform:radio>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=18%>
				<bean:message bundle="sys-circulation" key="table.sysCirculationCirculors" />
			</td>
			<td colspan="3">
				<xform:address htmlElementProperties="id='receivedCirCulator'" propertyId="receivedCirCulatorIds"  propertyName="receivedCirCulatorNames"  mulSelect="true" textarea="true"
					orgType="ORG_TYPE_ALLORG" required="true" subject="${ lfn:message('sys-circulation:table.sysCirculationCirculors') }" 
					style="width:95%">
				</xform:address><br/>
				<input name="fdOpinionRequired" type="hidden" value="0">
				<label>
			    	<input type="checkbox" name="opinionRequired" onclick="changeOpinionRequired(this);">传阅意见必填
			    </label>
		</td>
		</tr>
		<tr id="spreadScopeTr">
			<td class="td_normal_title" width=18%>
				继续传阅范围
			</td>
			<td colspan="3">
				<input name="fdAllowSpread" type="hidden" value="0">
				<label>
					<input type="checkbox" name="allowSpread" onclick="changeAllowSpread(this);">允许继续传阅
				</label>
				<br/>
				<div id="allowSpreadScope" style="display:none;margin-top:6px">
					<xform:radio property="fdSpreadScope"  showStatus="edit" onValueChange="changeScope(this.value);">
						<xform:enumsDataSource enumsType="sysCirculationMain_fdSpreadScope"></xform:enumsDataSource>
					</xform:radio><br/>
					<div id="OtherSpreadScope" style="display:none;margin-top:6px">
						<xform:address htmlElementProperties="id=spreadScope" validators="required"  textarea="true" propertyId="fdOtherSpreadScopeIds" style="width:95%;height:60px" propertyName="fdOtherSpreadScopeNames"  mulSelect="true"  orgType="ORG_TYPE_ALLORG"  >
						</xform:address><span class="txtstrong">*</span>
						<br/><font color="red">（移动端地址本不支持自定义选择范围，该自定义范围只在pc端起作用）</font>
					</div>
				</div>
			</td>
		</tr>
		
		<tr>
			<td class="td_normal_title" width=18%>
				<bean:message bundle="sys-circulation" key="sysCirculationMain.fdNotifyType" />
			</td>
			<td colspan="3">
				<kmss:editNotifyType property="fdNotifyType" />
			</td>
		</tr>
		<tr>
		   <td class="td_normal_title" width=18%>
				<bean:message bundle="sys-circulation" key="sysCirculationMain.fdRemark" />
			</td>
			<td colspan="3">
				<xform:textarea property="fdRemark" validators="maxLength(500)" style="width:94%"/>
			</td>
		</tr>
	</table>
	<div style="padding-top: 17px;">
		<ui:button text="${ lfn:message('button.submit') }" id="submit"  onclick="CommitCirculation(document.sysCirculationMainForm, 'save');">
		</ui:button>
		<ui:button text="${ lfn:message('button.close') }" styleClass="lui_toolbar_btn_gray"  onclick="Com_CloseWindow()">
		</ui:button>
    </div>
	</center>
	<html:hidden property="method_GET" />
	<html:hidden property="fdKey" />
	<html:hidden property="fdModelId" />
	<html:hidden property="fdModelName" />
</html:form>
	<script language="JavaScript">
		$KMSSValidation(document.forms['sysCirculationMainForm']);
		
		function CommitCirculation(form,method){
			
			var fdSpreadScope = document.getElementsByName("fdSpreadScope");
			for(var i=0;i<fdSpreadScope.length;i++){
				if(fdSpreadScope[i].checked){
					if(fdSpreadScope[i].value != '2'){
						$("#allowSpreadScope").siblings(".validation-advice").hide();
						document.getElementById("spreadScope").setAttribute("validate", "");
					}
				}
			}
			
			if($KMSSValidation(document.forms['sysCirculationMainForm']).validate()){
				LUI('submit').setDisabled(true);
			}
			Com_Submit(document.sysCirculationMainForm, 'save');
		}
		
		function changeOpinionRequired(obj){
			if(obj.checked){
				document.getElementsByName("fdOpinionRequired")[0].value="1";
			}else{
				document.getElementsByName("fdOpinionRequired")[0].value="0";
			}
		}
		
		function changeAllowSpread(obj){
			if(obj.checked){
				document.getElementsByName("fdAllowSpread")[0].value="1";
				$('#allowSpreadScope').show();
			}else{
				document.getElementsByName("fdAllowSpread")[0].value="0";
				$('#allowSpreadScope').hide();
				document.getElementsByName("fdOtherSpreadScopeIds")[0].value = "";
				document.getElementsByName("fdOtherSpreadScopeNames")[0].value = "";
			}
		}
		
		function changeRegular(value){
			$("#receivedCirCulator").parent().parent().find(".orgelement").removeAttr("onclick");
			$("#receivedCirCulator").parent().parent().find(".orgelement").unbind("click");
			if(value == '1'){
				$('#spreadScopeTr').hide();
				//Address_QuickSelection("receivedCirCulatorIds","receivedCirCulatorNames",";",ORG_TYPE_PERSON,true,null,null,null);
				var address = Address_GetAddressObj("receivedCirCulatorNames");
				address.reset(";",ORG_TYPE_PERSON,true,[]);
				$("#receivedCirCulator").parent().parent().find(".orgelement").click(function(){
					Dialog_Address(true,'receivedCirCulatorIds','receivedCirCulatorNames',';',ORG_TYPE_PERSON,null,null,null,null,null,null,null);
             	});
			}else{
				$('#spreadScopeTr').show();
				//Address_QuickSelection("receivedCirCulatorIds","receivedCirCulatorNames",";",ORG_TYPE_ALLORG,true,null,null,null);
				var address = Address_GetAddressObj("receivedCirCulatorNames");
				address.reset(";",ORG_TYPE_ALLORG,true,[]);
				$("#receivedCirCulator").parent().parent().find(".orgelement").click(function(){
					Dialog_Address(true,'receivedCirCulatorIds','receivedCirCulatorNames',';',ORG_TYPE_ALLORG,null,null,null,null,null,null,null);
             	});
			}
		}
		
		function changeScope(value){
			if(value == '2'){
				$('#OtherSpreadScope').show();
				document.getElementById("spreadScope").setAttribute("validate", "required");
			}else{
				$('#OtherSpreadScope').hide();
				$("#allowSpreadScope").siblings(".validation-advice").hide();
				document.getElementById("spreadScope").setAttribute("validate", "");
				document.getElementsByName("fdOtherSpreadScopeIds")[0].value = "";
				document.getElementsByName("fdOtherSpreadScopeNames")[0].value = "";
			}
		}
		
	</script>
	</template:replace>
</template:include>
