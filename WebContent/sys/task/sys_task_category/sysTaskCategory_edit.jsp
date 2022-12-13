<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/sys/task/sys_task_category/sysTaskCategory.do" >
<div id="optBarDiv">
	<c:if test="${sysTaskCategoryForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.sysTaskCategoryForm, 'update');">
	</c:if>
	<c:if test="${sysTaskCategoryForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.sysTaskCategoryForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.sysTaskCategoryForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
 
<p class="txttitle"><bean:message  bundle="sys-task" key="table.sysTaskCategory"/></p>

<center>
<table class="tb_normal" width=95%>
		<html:hidden property="fdId"/>
		
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="sys-task" key="sysTaskCategory.fdName"/>
		</td><td width=35%  colspan=3>
			<xform:text	property="fdName" validators="uniqueFdName"  style="width:90%;" />
		</td>
	
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="sys-task" key="sysTaskCategory.fdOrder"/>
		</td><td width=35%>
			<xform:text property="fdOrder"/>
		</td>
		<td class="td_normal_title" width=15% >
			<bean:message  bundle="sys-task" key="sysTaskCategory.fdIsAvailable"/>
		</td><td width=35%>
		<sunbor:enums property="fdIsAvailable" enumsType="common_yesno" elementType="radio"/>
		</td>
	
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<script type="text/javascript">
	Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js|xform.js",null,"js");
</script>
<script language="JavaScript">
var _validation =$KMSSValidation(document.forms['sysTaskCategoryForm']);//加载校验框架

	var FdNameValidators = {
		'uniqueFdName' : {
			error : "名称已使用,请重新输入!",
			test : function(value) {
				var fdId = document.getElementsByName("fdId")[0].value;
				var result = fdNameCheckUnique(
						"sysTaskCategoryService", value, fdId);
				if (!result)
					return false;
				return true;
			}
		}
	};
	_validation.addValidators(FdNameValidators);
	//类型名称做唯一性校验

	function fdNameCheckUnique(bean, fdName, fdId) {
		var url = encodeURI(Com_Parameter.ResPath
				+ "jsp/ajax.jsp?&serviceName=" + bean + "&fdName=" + fdName
				+ "&fdId=" + fdId);
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
			var result = xmlHttpRequest.responseText.replace(/\s/g, "")
					.replace(/;/g, "\n");
			if (result != "") {
				return false;
			}
		}
		return true;
	}
</script>
<%@ include file="/resource/jsp/edit_down.jsp"%>