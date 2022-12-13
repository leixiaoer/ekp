<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.kms.knowledge.borrow.util.KmsKnowledgeBorrowUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/ui.tld" prefix="ui"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>

<kmss:auth
	requestURL="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=add"
	requestMethod="GET">
	<ui:button text="${lfn:message('button.add')}" order="2"
		onclick="window.moduleAPI.kmsKnowledge.addDoc(null,${kmsCategoryEnabled})"></ui:button>
</kmss:auth>
<c:if test="${kms_professional}">
    <ui:button text="${lfn:message('kms-knowledge:kms.knowledge.borrow')}" order="1"
        style='<%=KmsKnowledgeBorrowUtil.checkBorrowOpen(request)?"":"display:none;"%>'
        onclick="window.moduleAPI.kmsKnowledge.docBorrow()"></ui:button>
</c:if>

<ui:button text="${lfn:message('button.delete')}"
	cfg-if="auth(/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=deleteall&categoryId=!{docCategory})||criteria('myDraft')[0]=='myDraft'||(param['myDraft']&&param['myDraft'].indexOf('myDraft')>=0)"
	order="5" onclick="window.moduleAPI.kmsKnowledge.deleteall()"></ui:button>

<c:if test="${kms_professional}">
	<ui:button text="${lfn:message('kms-knowledge:button.changeProperty')}"
		cfg-auth="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=editPropertys&templateId=!{docCategory}"
		onclick="window.moduleAPI.kmsKnowledge.editProperty()"></ui:button>
</c:if>

<ui:button onclick="window.moduleAPI.kmsKnowledge.setTop()"
	cfg-auth="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=setTop&local=index&categoryId=!{docCategory}"
	text="${lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.setTop')}"></ui:button>

<%-- 修改权限 --%>
<c:import url="/sys/right/import/doc_right_change_button.jsp"
	charEncoding="UTF-8">
	<c:param name="modelName"
		value="com.landray.kmss.kms.knowledge.model.KmsKnowledgeBaseDoc" />
	<c:param name="spa" value="true" />
</c:import>

<%-- 取消推荐 --%>
<c:import url="/kms/knowledge/kms_knowledge_ui/kmsKnowledge_cancel_introduce.jsp"
	charEncoding="UTF-8">
	<c:param name="fdModelName"
		value="com.landray.kmss.kms.knowledge.model.KmsKnowledgeBaseDoc" />
</c:import>
<c:if test="${kms_professional}">
	<ui:button
		cfg-auth="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=exportExcel&categoryId=!{docCategory}"
		text="${lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.export.btn') }"
		onclick="window.moduleAPI.kmsKnowledge.exportToExcel()"></ui:button>


	<form name="exportData" action="" method="post">
		<input type="hidden" name="List_Selected" value="">
	</form>

<kmss:ifModuleExist path="/kms/multidoc">
	<kmss:auth
		requestURL="/kms/multidoc/kms_multidoc_knowledge/kmsMultidocKnowledge.do?method=add"
		requestMethod="GET">
		<c:import
			url="/kms/knowledge/kms_knowledge_multiple_upload/kms_multiple_upload.jsp"
			charEncoding="UTF-8">
			<c:param name="fdCategoryModelName"
				value="com.landray.kmss.kms.knowledge.model.KmsKnowledgeCategory" />
			<c:param name="fdMainModelName"
				value="com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge" />
			<c:param name="categoryIndicateName" value="fdTemplateId" />
			<c:param name="fdKey" value="attachment" />
			<c:param name="pathTitle" value="kms-multidoc:title.kms.multidoc" />
		</c:import>
	</kmss:auth>
</kmss:ifModuleExist>
</c:if>
<c:if test="${kms_professional}">
	<%--维基导入 --%>
	<kmss:ifModuleExist path="/kms/wiki/">
		<kmss:auth
			requestURL="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=add"
			requestMethod="GET">
			<ui:button
				text="${lfn:message('kms-wiki:kmsWikiMain.button.wikiImport')}"
				order="2" onclick="window.moduleAPI.kmsKnowledge.wikiImport()"></ui:button>
		</kmss:auth>
	</kmss:ifModuleExist>
</c:if>
<script>
	//搜索本模块变量
	var SYS_SEARCH_MODEL_NAME = "com.landray.kmss.kms.wiki.model.KmsWikiMain;com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge";
</script>

