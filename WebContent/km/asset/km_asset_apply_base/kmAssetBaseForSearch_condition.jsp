<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/kmss-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("dialog.js", "style/"+Com_Parameter.Style+"/dialog/");
</script>
<script type="text/javascript">
	Com_IncludeFile("dialog.js|xform.js|doclist.js|jquery.js");
	Com_IncludeFile("calendar.js");
</script>
<script type="text/javascript" charset="UTF-8">
 $(document).ready(function(){ 
	 $('span[class="txtstrong"]').hide();
	 	document.getElementsByName("docSubject")[0].value="${requestScope.docSubject}";
	 	document.getElementsByName("fdNo")[0].value="${requestScope.fdNo}";
		document.getElementsByName("fdCreatorId")[0].value="${requestScope.fdCreatorId}";
		document.getElementsByName("fdCreatorName")[0].value="${requestScope.fdCreatorName}";
		document.getElementsByName("docStartdate")[0].value="${requestScope.startTime}";
		document.getElementsByName("docFinishdate")[0].value="${requestScope.endTime}";
		document.getElementsByName("docStatus")[0].value="${requestScope.docStatus}";
		document.getElementsByName("templateId")[0].value="${requestScope.templateId}";
		document.getElementsByName("templateName")[0].value="${requestScope.templateName}";
		document.getElementsByName("categoryId")[0].value = "${JsParam.categoryId}";
 }); 

</script>
<script type="text/javascript">
function doSerch(){
	var categoryId = document.getElementsByName("categoryId")[0].value;
	var docSubject = document.getElementsByName("docSubject")[0].value; 
	var fdNo = document.getElementsByName("fdNo")[0].value; 
	var fdCreatorId = document.getElementsByName("fdCreatorId")[0].value; 
	var fdCreatorName = document.getElementsByName("fdCreatorName")[0].value; 
	var startTime= document.getElementsByName("docStartdate")[0].value; 
	var endTime= document.getElementsByName("docFinishdate")[0].value; 
	var docStatus = document.getElementsByName("docStatus")[0].value; 
	var nodeType = Com_GetUrlParameter(location.href, "nodeType");
	if(nodeType == null){
		nodeType="CATEGORY";
	}
	var imgdiv = document.getElementsByName("imgdiv")[0];
    var templateId = document.getElementsByName("templateId")[0].value; 
	var templateName = document.getElementsByName("templateName")[0].value; 
	var s_path = Com_GetUrlParameter(location.href, "s_path");
	var searchUrl = 'kmAssetApplyBase.do?method=listChildren';
		  searchUrl += '&templateId='+templateId + '&templateName='+encodeURI(templateName);
	             searchUrl += '&docSubject='+encodeURI(docSubject)
	                       + '&categoryId='+categoryId
	                       + '&fdNo='+encodeURI(fdNo)
	                       + '&fdCreatorId='+fdCreatorId
	                       + '&fdCreatorName='+encodeURI(fdCreatorName)
	                       + '&startTime='+startTime
	                       + '&endTime='+endTime
	                       + '&docStatus='+docStatus
	                       + '&nodeType='+nodeType
						   +'&status=${JsParam.status}'
						   +'&s_path='+ encodeURI(s_path);
	   window.location.href=searchUrl;
	}

function doReset(){
	var nodeType = Com_GetUrlParameter(location.href, "nodeType");
	if(nodeType == null){
		nodeType="CATEGORY";
	}
	var categoryId = document.getElementsByName("categoryId")[0].value;
	var s_path = Com_GetUrlParameter(location.href, "s_path");
	var resetUrl = 'kmAssetApplyBase.do?method=listChildren&s_path='+ encodeURI(s_path) + '&categoryId='+categoryId+ '&nodeType='+nodeType;
	window.location.href = resetUrl;
}


function showTemplate()
{
	var url=Dialog_Template('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','url?method=search&id=!{id}&name=!{name}',false,true);
	var id = Com_GetUrlParameter(url,"id");
	var name = Com_GetUrlParameter(url,"name");
	if(id!=null && id!='')
	{
		document.getElementsByName('templateId')[0].value=id;
	}
	if(name!=null && name !='')
	{
		document.getElementsByName('templateName')[0].value=name;
	}
}

</script>
<div style="display: block;">
<input type="hidden" name="categoryId">
		<table id="condition" class="tb_normal" width=99%>
			<tr>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
				</td>
				<td width=15%>
					<xform:text property="docSubject" style="width:100%"  showStatus="edit"/>
				</td>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</td>
				<td width=25%>
					<xform:text property="fdNo" style="width:95%"  showStatus="edit"/>
				</td>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.docStatus"/>
				</td>
				<td width=8%>
					<xform:select property="docStatus" showStatus="edit">
						<xform:enumsDataSource enumsType="kmAssetApply_docStaus"/>
					</xform:select>
				</td>
				<td width="22%">
					<input type="button" class="lui_form_button" value="<bean:message key="button.search"/>"  onclick="doSerch();">
					<input type="button" class="lui_form_button" value="<bean:message key="button.reset"/>"  onclick="doReset();">
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
				</td>
				<td width=15%>
				<nobr>
				<xform:address propertyId="fdCreatorId" propertyName="fdCreatorName" orgType="ORG_TYPE_PERSON" style="width:100%" showStatus="edit"/>
				</nobr>
				</td>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
				</td>
				<td width=25%>
				<xform:datetime
					property="docStartdate" dateTimeType="date" showStatus="edit"
					style="width:45%"/> —<xform:datetime
					property="docFinishdate" dateTimeType="date" showStatus="edit"
					style="width:45%"/>
				</td>
				<td class="td_normal_title" width=10%>
				<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyTemplate" />
				</td>
				<td width=18% colspan="3">
				<xform:dialog  propertyId="templateId" propertyName="templateName" style="width:80%" showStatus="edit"  dialogJs="showTemplate();"/> 
				</td>
			</tr>
		</table>
		<center>
		</center>
</div>
