<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="org.apache.commons.beanutils.PropertyUtils"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.xform.service.DictLoadService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.common.forms.IExtendForm" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%
boolean isEditMode = "edit".equals(request.getParameter("method"))||"add".equals(request.getParameter("method"))
	||(request.getParameter("method")==null? "":request.getParameter("method")).startsWith("add");
if(isEditMode){
	request.setAttribute("SysForm.showStatus","readOnly"); 
	request.setAttribute("SysForm.base.showStatus", "readOnly"); 
	pageContext.setAttribute("SysForm.importType", "edit");
}else{
	request.setAttribute("SysForm.showStatus", "view");
	request.setAttribute("SysForm.base.showStatus", "view");
	pageContext.setAttribute("SysForm.importType", "view");
}
%>
<%
String formBeanName = request.getParameter("formName");
String mainFormName = null;
String xformFormName = null;
int indexOf = formBeanName.indexOf('.');
if (indexOf > -1) {
	mainFormName = formBeanName.substring(0, indexOf);
	xformFormName = formBeanName.substring(indexOf + 1);
	pageContext.setAttribute("_formName", xformFormName);
} else {
	mainFormName = formBeanName;
	pageContext.setAttribute("_formName", null);
}

DictLoadService dictService=(DictLoadService)SpringBeanUtil.getBean("sysFormDictLoadService");
Object mainForm = request.getAttribute(mainFormName);
Object xform = xformFormName == null ? mainForm : PropertyUtils.getProperty(mainForm, xformFormName);
String path = "";
if(xform instanceof IExtendForm){
	IExtendForm extendForm = (IExtendForm)xform;
	path=dictService.findExtendFileFullPath(extendForm);
}else{
	path = (String) PropertyUtils.getProperty(xform, "extendDataFormInfo.extendFilePath");
	path=dictService.findExtendFileFullPath(path);
}
if (!isEditMode) {
	if (mainForm instanceof com.landray.kmss.sys.workflow.interfaces.ISysWfMainForm 
			&& "view".equals(pageContext.getAttribute("SysForm.importType"))) {
		com.landray.kmss.sys.workflow.interfaces.ISysWfMainForm wfForm = (com.landray.kmss.sys.workflow.interfaces.ISysWfMainForm) mainForm;
		if (wfForm.getDocStatus().charAt(0) < '3') {
			request.setAttribute("SysForm.base.showStatus", "readOnly");
		}
	}
}
if(xform instanceof IExtendForm){
	IExtendForm extendForm = (IExtendForm)xform;
	String mainModelName = extendForm.getModelClass().getName();
	request.setAttribute("_mainModelName", mainModelName);
}
request.setAttribute("_xformMainForm", mainForm);
request.setAttribute("_xformForm", xform);
pageContext.setAttribute("_formFilePath", path);
// ??????EKP3.1??????
	//out.println("<!-- ????????????EKP3.01??????  -->");
	Object originFormBean = pageContext.getAttribute("com.landray.kmss.web.taglib.FormBean", PageContext.REQUEST_SCOPE);
	pageContext.setAttribute("com.landray.kmss.web.taglib.FormBean", mainForm, PageContext.REQUEST_SCOPE);
%>
<script>
_xformMainModelClass="${_xformMainForm.modelClass.name}";
_xformMainModelId="${_xformMainForm.fdId}";
</script>
<c:if test="${_formFilePath!=null}">
	<c:if test="${empty JsParam._data }"><mui:cache-file name="mui-xform.js" cacheType="md5"/></c:if>
	<mui:min-file name="sys-xform.css"/>
	<script>
		require(['sys/xform/mobile/controls/xform']);
		require(["dojo/topic","dojo/query"], function(topic,query) {
			topic.subscribe('parser/done',function(){
				__fixLabelStyle();
			});
			function __fixLabelStyle(argus) {
				var context = document;
				if (argus && argus.row) {
					context = argus.context;
				}
				var xformLables = query('.xform_label',context);
				for (var i = 0; i < xformLables.length; i++) {
					var html = xformLables[i].innerHTML;
					var reg = new RegExp("&nbsp;","g");
					html = html.replace(reg, " ");
					html = html.replace(/\s*$/g, "");
					html = html.replace(/^\s*/g, "");
					xformLables[i].innerHTML = html;
				}
			}
			
			//???????????????
			$(document).on('table-copy-new','table[showStatisticRow]',function(e,argus){
				__fixLabelStyle(argus);
			});
			
			//???????????????
			$(document).on('table-add-new','table[showStatisticRow]',function(e,argus){
				__fixLabelStyle(argus);
			});
		});
		//????????????????????????????????????????????????????????????????????????????????????????????????
		//?????????????????????????????????iframe?????????
		function getBaseInfoTableStyle(){
			var baseInfoTableStyle = null;
			if(window.baseInfoTbClassname
					&& window.baseInfoTbStylePath
					&& window.baseInfoTbStyleFileName){
				baseInfoTableStyle = {};
				baseInfoTableStyle.isDefault = false;
				baseInfoTableStyle.className = window.baseInfoTbClassname;
				baseInfoTableStyle.path = window.baseInfoTbStylePath;
				baseInfoTableStyle.fileName = window.baseInfoTbStyleFileName;
			}
			//???????????????????????????????????????????????????
			/* else{//??????????????????????????????????????????
				var fdKey = '${param.fdKey}';
				//???????????????div
				var xformArea = $("#__xform_"+fdKey)[0] || $(".muiXformArea")[0];
				//????????????baseInfoTableStyle???????????????
				var $table = $("table",xformArea).eq(0);
				if($table.length > 0){
					baseInfoTableStyle.isDefault = true;
					baseInfoTableStyle.className = $table.attr("class");
				}
			} */
			return baseInfoTableStyle;
		}
	</script>
	<xform:config formName="${_formName}" orient="none">
		<div id='__xform_${param.fdKey}' class="muiXformArea">
			<input type="hidden" name="extendDataFormInfo.extendFilePath" value="${_formFilePath}"/>
			<%-- ??????add?????????????????????,???mainModel??????????????????mainModel --%>
			<input type="hidden" name="extendDataFormInfo.mainModelName" value="${_mainModelName}"/>
			<c:import url="/${_formFilePath}.4m.jsp" charEncoding="UTF-8">
				<c:param name="method" value="${param.method}" />
				<c:param name="fdKey" value="${param.fdKey}" />
				<c:param name="optType" value="${pageScope['SysForm.importType']}"/>
				<c:param name="mainModelName" value="${_mainModelName}" />
			</c:import>
		</div>
	</xform:config>
</c:if>
<%
	//??????EKP3.1??????
	pageContext.setAttribute("com.landray.kmss.web.taglib.FormBean", originFormBean, PageContext.REQUEST_SCOPE);
pageContext.removeAttribute("_formName");
pageContext.removeAttribute("_formFilePath");
request.removeAttribute("SysForm.base.showStatus");
request.removeAttribute("SysForm.isPrint");
request.removeAttribute("SysForm.showStatus");
request.removeAttribute("_xformMainForm");
request.removeAttribute("_xformForm");
if(xform instanceof IExtendForm){
	request.removeAttribute("_mainModelName");
}
%>