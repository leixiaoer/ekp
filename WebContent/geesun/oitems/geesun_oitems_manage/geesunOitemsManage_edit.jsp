<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<kmss:windowTitle
	subjectKey="geesun-oitems:geesunOitemsManage.opt.create"
	moduleKey="geesun-oitems:geesunOitems.tree.modelName" />
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<html:form action="/geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do" onsubmit="return validateGeesunOitemsManageForm(this);">
<div id="optBarDiv">
	<c:if test="${geesunOitemsManageForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.geesunOitemsManageForm, 'update');">
	</c:if>
	<c:if test="${geesunOitemsManageForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.geesunOitemsManageForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.geesunOitemsManageForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsManage"/></p>

<center>
<table id="Label_Tabel" width="95%">
    <!--<c:import url="/sys/simplecategory/include/sysCategoryMain_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="geesunOitemsManageForm" />
		<c:param name="requestURL" value="geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do?method=add" />
		<c:param name="fdModelName" value="${param.fdModelName}" />
	</c:import>-->
	<c:set var="selectEmpty" value="true" />
  	<tr LKS_LabelName="<bean:message bundle="sys-simplecategory" key="table.sysSimpleCategory" />">
         <td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
					<c:if test="${empty param.fdParentName}"><bean:message bundle="sys-simplecategory" key="sysSimpleCategory.fdParentName" /></c:if>
					<c:if test="${not empty param.fdParentName}">${HtmlParam.fdParentName}</c:if>
					</td>
					<td colspan="3"><html:hidden property="fdParentId" /> 
						<input type="text" value="${geesunOitemsManageForm.fdParentName}" name="fdParentName" readonly="readonly" style="width:90%" class="inputsgl" unselectable="on">
						<a href="#"
						onclick="addCategory();Cate_getParentMaintainer();">
					<bean:message key="dialog.selectOther" /> </a></td>
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
					<c:choose>
						<c:when test="${'saveadd' eq param.method}">
							<bean:message bundle="sys-simplecategory" key="sysSimpleCategory.fdName" />
						</c:when>
						<c:otherwise>
							<c:if test="${empty param.fdName}"><bean:message bundle="sys-simplecategory" key="sysSimpleCategory.fdName" /></c:if>
				            <c:if test="${not empty param.fdName}">${HtmlParam.fdName}</c:if>
						</c:otherwise>
					</c:choose>
					</td>
					<td colspan="3">
						<xform:text property="fdName" style="width:90%" required="true"></xform:text>
					</td>
					
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							key="model.fdOrder" /></td>
						<td colspan="3"><xform:text property="fdOrder" validators="digits min(0)" /></td>
					</tr>
					
					<tr>
						<td class="td_normal_title" width=15%><bean:message bundle="sys-simplecategory"
							key="sysSimpleCategory.parentMaintainer" /></td>
						<td colspan="3" id="parentMaintainerId">${parentMaintainer}</td>
					</tr>
					
					<tr>
						<td class="td_normal_title" width=15%><bean:message bundle="geesun-oitems" key="geesunOitemsManage.class.fdnName" /></td>
						<td colspan="3">
						<input type="checkbox" name="authNotReaderFlag" value="${geesunOitemsManageForm.authNotReaderFlag}" onclick="Cate_CheckNotReaderFlag(this);" 
						<c:if test="${geesunOitemsManageForm.authNotReaderFlag eq 'true'}">checked</c:if>>
						<bean:message bundle="sys-simplecategory" key="description.main.tempReader.notUse" />
						<div id="Cate_AllUserId">
						<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:90%;" ></xform:address>
						</div>
						<div id="Cate_AllUserNote">
						<bean:message bundle="geesun-oitems" key="geesunOitemsManage.class.fdnName.description" />
						</div>
						</td>
					</tr>
					
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							key="model.tempEditorName" /></td>
						<td colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:90%;" ></xform:address>
						<div class="description_txt">
						<bean:message	bundle="sys-simplecategory" key="description.main.tempEditor" />
						</div>
						</td>
					</tr>
			
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							key="model.tempReaderName" /></td>
						<td colspan="3">
						<input type="checkbox" name="authNotUseFlag" value="${geesunOitemsManageForm.authNotUseFlag}" onclick="checkNotReaderFlag(this);" 
						<c:if test="${geesunOitemsManageForm.authNotUseFlag eq 'true'}">checked</c:if>>
						<bean:message bundle="sys-simplecategory" key="description.main.tempReader.notUse" />
						<div id="AllUserId">
							<xform:address textarea="true" mulSelect="true" propertyId="authUseIds" propertyName="authUseNames" orgType="ORG_TYPE_ALL" style="width:90%;" ></xform:address>
						</div>
						<div id="AllUserNote">
						<bean:message bundle="geesun-oitems" key="description.main.tempReader.desc" />
						</div>
						</td>
					</tr>
					
				</tr>
			</table>
		 </td>
     </tr>
            
            
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="geesunOitemsManageForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsManage" />
				</c:import>
			</table>
			</td>
		</tr>
</table>
</center>
<html:hidden property="fdId"/>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="geesunOitemsManageForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>
<script type="text/javascript">
Com_IncludeFile("jquery.js");
function Cate_CheckNotReaderFlag(el){
	document.getElementById("Cate_AllUserId").style.display=el.checked?"none":"";
	document.getElementById("Cate_AllUserNote").style.display=el.checked?"none":"";
	el.value=el.checked;
}

function checkNotReaderFlag(el){
	document.getElementById("AllUserId").style.display=el.checked?"none":"";
	document.getElementById("AllUserNote").style.display=el.checked?"none":"";
	el.value=el.checked;
}

function Cate_Win_Onload(){
	Cate_CheckNotReaderFlag(document.getElementsByName("authNotReaderFlag")[0]);
	checkNotReaderFlag(document.getElementsByName("authNotUseFlag")[0]);
}

//自动带出继承上级分类维护者
function Cate_getParentMaintainer(){
	var parameters ="parentId="+document.getElementsByName("fdParentId")[0].value;
	var s_url = Com_Parameter.ContextPath+"geesun/oitems/geesun_oitems_manage/geesunOitemsManage.do?method=getParentMaintainer";
	$.ajax({
			url: s_url,
			type: "GET",
			data: parameters,
			dataType:"text",
			async: false,
			success: function(text){
				$("#parentMaintainerId").text(text);
			}});
}

Com_AddEventListener(window, "load", Cate_Win_Onload);

function addCategory(){
	seajs.use(['lui/dialog'],function(dialog){
		dialog.simpleCategory('${param.fdModelName}','fdParentId','fdParentName',false,Cate_getParentMaintainer,null,true,null,false);
	});
}


</script>
