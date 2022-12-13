<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="java.util.Date"%>
<script>Com_Parameter.IsAutoTransferPara = true;</script>
<script language="JavaScript">
	Com_IncludeFile("dialog.js|optbar.js|list.js");
</script>
<script language="JavaScript">
	function dyniFrameSize() {
		try {
			//????
			var arguObj = document.getElementsByTagName("table")[0];
			if (arguObj != null && window.frameElement != null && window.frameElement.tagName == "IFRAME") {
				window.frameElement.style.height = (arguObj.offsetHeight + 50) + "px";
			}
		} catch (e) {}
	}
	window.onload =function (){
		setTimeout(dyniFrameSize,100);
	}; 
</script>

<%--bookmark--%>
<c:import url="/sys/bookmark/include/bookmark_bar_all.jsp"
	charEncoding="UTF-8">
	<c:param name="fdTitleProName" value="docSubject" />
	<c:param name="fdModelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
</c:import>
<c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
	<c:param name="fdModelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
</c:import>
<c:import
	url="/sys/right/doc_right_change_button.jsp"
	charEncoding="UTF-8">
	<c:param
		name="modelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
</c:import>

<c:import
	url="/sys/simplecategory/include/doc_cate_change_button.jsp"
	charEncoding="UTF-8">
	<c:param
		name="modelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
	<c:param
		name="docFkName"
		value="kmInstitutionTemplate" />
	<c:param
		name="cateModelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionTemplate" />
</c:import>

<!--chang the  right -->
<script type="text/javascript">
function checkSelect() {
	var values="";
	var selected;
	var select = document.getElementsByName("List_Selected");
	for(var i=0;i<select.length;i++) {
		if(select[i].checked){
			values+=select[i].value;
			values+=",";
			selected=true;
		}
	}
	if(selected) {
		values = values.substring(0,values.length-1);
		if(selected) {
			Com_OpenWindow(Com_Parameter.ContextPath+'km/institution/km_institution_knowledge/kmInstitutionKnowledge_change_template.jsp?method=changeTemplate&values='+values,'_blank','height=300, width=450, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
			return;
		}
	}
	alert("<bean:message key="page.noSelect" />");
	return false;
}
</script>
<script type="text/javascript">
function List_CheckSelect(checkName){
	if(checkName==null)
		checkName = List_TBInfo[0].checkName;
	var obj = document.getElementsByName("List_Selected");
		for(var i=0; i<obj.length; i++)
		  if(obj[i].checked)
			return true;		
	alert("<bean:message key="page.noSelect"/>");
	return false;
}
function List_ConfirmInduct(checkName){
	return List_CheckSelect(checkName);
}
</script>
<div id="optBarDiv">
		<c:if test="${param.pink!='true'}">
		
		<kmss:authShow roles="ROLE_KMINSTITUTION_CREATE">
			<c:if test="${not empty param.categoryId}">
				<c:set var="flg" value="no"/>
				<kmss:auth
					requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=add&fdTemplateId=${param.categoryId}"
					requestMethod="GET">
					<input type="button" value="<bean:message key="button.add"/>"
						onclick="Com_OpenWindow('<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do" />?method=add&fdTemplateId=${JsParam.categoryId}');">
					<c:set var="flg" value="yes"/>
				</kmss:auth>
				<c:if test="${flg eq 'no'}">
					<input type="button" value="<bean:message key="button.add"/>"
						onclick="Dialog_SimpleCategoryForNewFile('com.landray.kmss.km.institution.model.KmInstitutionTemplate','<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do" />?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}');">						
				</c:if>
			</c:if>
		
			<c:if test="${empty param.categoryId}">
				<input type="button" value="<bean:message key="button.add"/>"
					onclick="Dialog_SimpleCategoryForNewFile('com.landray.kmss.km.institution.model.KmInstitutionTemplate','<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do" />?method=add&fdTemplateId=!{id}&fdTemplateName=!{name}');">
			</c:if>							
		</kmss:authShow>
		
		<kmss:auth
			requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall&status=${param.status}&categoryId=${param.categoryId}"
			requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmInstitutionKnowledgeForm, 'deleteall');">
		</kmss:auth>
</c:if> <c:if test="${param.pink=='true'}">
	<c:import url="/sys/introduce/include/sysIntroduceMain_cancelbtn.jsp"
		charEncoding="UTF-8">
		<c:param name="fdModelName"
			value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
	</c:import>
</c:if> <input type="button" value="<bean:message key="button.search"/>"
	onclick="Search_Show();"></div>
