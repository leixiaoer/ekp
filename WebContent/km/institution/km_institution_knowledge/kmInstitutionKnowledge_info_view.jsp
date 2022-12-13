<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/info_view_top.jsp"%>
<%--bookmark--%>
<c:import url="/sys/bookmark/include/bookmark_bar.jsp"
	charEncoding="UTF-8">
	<c:param name="fdSubject" value="${kmInstitutionKnowledgeForm.docSubject}" />
	<c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId}" />
	<c:param name="fdModelName"
		value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"/>
</c:import>
<script type="text/javascript">
	Com_IncludeFile("jquery.js");
</script>
<script>

$(document).ready(function(){
	var fdTagNames = "${kmInstitutionKnowledgeForm.sysTagMainForm.fdTagNames}";
	var tagNames = fdTagNames.split(" ");
	var docTag = document.getElementById("docTag");
	var tagHtml = "";
	for(var i=0;i<tagNames.length;i++){
		var href = "<c:url value='/sys/tag/sys_tag_main/sysTagMain.do?method=searchMain'/>";
		href += "&queryString="+encodeURIComponent(tagNames[i])+"&queryType=normal";
		tagHtml += "<a onclick=\"Com_OpenNewWindow(this)\" data-href='"+href+"' target='_blank'>"+tagNames[i]+"</a>&nbsp;&nbsp;&nbsp;";
	}
	docTag.innerHTML = tagHtml;
	//将内容部分，图片宽度大于600的，限制在600内，避免过大图片把页面撑开
	$('#content').find('img').each(function(){
		this.style.cssText="";
		var pt;
		if(this.height && this.height!="" && this.width && this.width != "")
			pt = parseInt(this.height)/parseInt(this.width);//高宽比
		if(this.width>600){
			this.width = 600;
			if(pt)
				this.height = 600 * pt;
		}
	});
	$("#content").find("table").each(function(){
		this.style.cssText="";
		var width=$(this).width();
		//var height=$(this).height();
		if(width>800){
		   $(this).width(800);			  
		  // $(this).height(Math.round(height*800/width));
		   }		
	});
});

function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}

function more(categoryId){
	var url = Com_Parameter.ContextPath+"moduleindex.jsp?nav=/km/institution/tree.jsp&main=/";
	var s_path = "${kmInstitutionKnowledgeForm.fdDocTemplateName}";
	var s_pathEncode = encodeURIComponent(s_path);
	url += encodeURIComponent("km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=listChildren&categoryId="+categoryId+"&orderby=docPublishTime&ordertype=down&nodeType=CATEGORY&s_path="+s_pathEncode);
	Com_OpenWindow(url);
}
</script>

<kmss:windowTitle
	subject="${kmInstitutionKnowledgeForm.docSubject}"
	moduleKey="km-institution:table.kmdoc" />

<div id="optBarDiv">
<c:if test="${kmInstitutionKnowledgeForm.docStatusFirstDigit > '0' }">
	<kmss:auth
		requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=edit&fdId=${param.fdId}"
		requestMethod="GET">
		<input
			type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmInstitutionKnowledge.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth> 
</c:if>
<kmss:auth
	requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=delete&fdId=${param.fdId}"
	requestMethod="GET">
	<input
		type="button"
		value="<bean:message key="button.delete"/>"
		onclick="if(!confirmDelete())return;Com_OpenWindow('kmInstitutionKnowledge.do?method=delete&fdId=${param.fdId}','_self');">
</kmss:auth>
<input type="button"
		value="<bean:message key="button.more"/>"
		onclick="Com_OpenWindow('kmInstitutionKnowledge.do?method=view&fdId=${param.fdId}&more=true','_self');">
<input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<center>
<div id="mainDiv">
		<div id="docContent">
			<%-- 模板 --%>
			<div id="navInfo">
				<c:out value="${kmInstitutionKnowledgeForm.fdDocTemplateName}" />
			</div>			
			<%-- 标题 --%>
			<div id="docTitle">
				<c:out value="${kmInstitutionKnowledgeForm.docSubject}" />
			</div>
			<div id="docSummary">
						<%-- 副标题内容 --%>
						<bean:message bundle="km-institution" key="kmInstitution.kmInstitutionKnowledgeForm.docAuthor" />&nbsp;&nbsp;
						<c:out value="${kmInstitutionKnowledgeForm.docCreatorName}" />&nbsp;&nbsp;
						<c:out value="${kmInstitutionKnowledgeForm.docPublishTime}" />&nbsp;&nbsp;
						<bean:message key="tip.view.hits" bundle="km-institution" />&nbsp;&nbsp;&nbsp;
				        <span class="number">(<c:out value="${kmInstitutionKnowledgeForm.docReadCount+1}" />)</span>						 
		    </div>
			<%-- 来源 --%>
			<%--
			<div id="sourceDiv">
				<bean:message bundle="sys-doc" key="sysDocBaseInfo.docAuthor" />
				<c:out value="${kmInstitutionKnowledgeForm.docAuthorName}" />
			</div>
			 --%>
			<%-- 内容 --%>
			<div id="content">
				<c:out value="${kmInstitutionKnowledgeForm.docContent}" escapeXml="false" />
			</div>		
			<%-- 附件 --%>
			<div id="docAttach">
				<%-- 
				<c:set var="attachmentList" value="${kmInstitutionKnowledgeForm.attachmentForms['attachment'].attachments }" />
				<c:if test="${not empty attachmentList}">
					&nbsp;<bean:message key="tip.download.attachment" bundle="km-institution"/>
					<c:forEach items="${attachmentList}" var="attachment" varStatus="vStatus">
						<br>${vStatus.index+1}.
						<a href="<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attachment.fdId}" />">${attachment.fdFileName}</a>
					</c:forEach>
				</c:if> --%>
				<%-- 文档附件 --%>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="viewType" value="link"/>
						<c:param name="fdMulti" value="true" />
						<c:param name="formBeanName" value="kmInstitutionKnowledgeForm" />
						<c:param name="fdKey" value="attachment" />
					</c:import>
			</div>
			<br><br>
			<div id="docMechanism">
				<table id="Label_Tabel" width=100% LKS_LabelClass="info_view">					
					 <!-- 发布机制开始 -->
			         <c:import url="/sys/news/include/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
			             <c:param  name="formName" value="kmInstitutionKnowledgeForm" />
			             <c:param name="fdKey" value="mainDoc" />
			         </c:import>
			         <!-- 发布机制结束 -->
			         <!-- 阅读记录 -->
			         <c:import  url="/sys/readlog/include/sysReadLog_view.jsp" charEncoding="UTF-8">
					     <c:param name="formName" value="kmInstitutionKnowledgeForm" />
				     </c:import>
				     <!-- 传阅机制 -->
				     <c:import url="/sys/circulation/import/sysCirculationMain_view.jsp"	charEncoding="UTF-8">
						<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					</c:import>
				     <c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmInstitutionKnowledgeForm" />
						<c:param name="fdKey" value="mainDoc" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isSimpleWorkflow" value="true" />
					</c:import>
					<%-- 版本机制 --%>
					<kmss:authShow roles="ROLE_KMINSTITUTION_CREATE,ROLE_KMINSTITUTION_NEWEDIT">
					<c:import url="/sys/edition/include/sysEditionMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmInstitutionKnowledgeForm" />
					</c:import>
					</kmss:authShow>
					<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
						<td>
						<table
							class="tb_normal"
							width=100%>
							<c:import
								url="/sys/right/right_view.jsp"
								charEncoding="UTF-8">
								<c:param
									name="formName"
									value="kmInstitutionKnowledgeForm" />
								<c:param
									name="moduleModelName"
									value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							</c:import>
						</table>
						</td>
	                </tr>
				</table>
			 </div>	
	  </div>
	  	<%-- 文档关联内容     右侧 --%>
		<div id="docRelation" class="sidebar">
				<%-- 文档基本信息 --%>
				<div class="sideBox">
					<h2><bean:message key="kmInstitutionKnowledgeForm.institutionInfo" bundle="km-institution" /></h2>
					<div>
						<bean:message key="kmInstitution.kmInstitutionKnowledgeForm.docAuthor" bundle="km-institution" />：<c:out value="${kmInstitutionKnowledgeForm.docCreatorName}" /><br>
						<bean:message key="kmInstitution.form.main.docDeptId" bundle="km-institution" />：<c:out value="${kmInstitutionKnowledgeForm.docDeptName}" /><br>
						&nbsp;
						<div class="docTag">
							<h3><img src="${KMSS_Parameter_ResPath}style/common/images/icon_pin.png" border="0"/><bean:message key="kmInstitutionKnowledge.docTag" bundle="km-institution" />：</h3>
							<div id="docTag"></div>
						</div>
					</div>
				</div>
				<%-- 同分类的规范制度 --%>
				<div class="sideBox" id="sameCategoryDocDiv">
					<h2><bean:message key="kmInstitutionKnowledge.sameCategoryDoc" bundle="km-institution" /><span class="more" onclick="more('${kmInstitutionKnowledgeForm.fdDocTemplateId}');"><bean:message key="kmInstitutionKnowledge.title.more" bundle="km-institution" /></span></h2>
					<div>
						<iframe id="sameCategoryDoc" 
						   src="<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do" />?method=listChildren&categoryId=${kmInstitutionKnowledgeForm.fdDocTemplateId}&excepteIds=${kmInstitutionKnowledgeForm.fdId}&orderby=docPublishTime&ordertype=down&forward=sameCategoryDoc"
							frameborder="0" scrolling="no" width="100%" height="100%">
						</iframe>
					</div>
				</div>
				<%-- xx相关文档 --%>
				<c:import url="/sys/tag/include/sysTagMain_doc_view.jsp" charEncoding="UTF-8">
					<c:param name="tagNames" value="${kmInstitutionKnowledgeForm.sysTagMainForm.fdTagNames}" />
					<c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId}" />
				</c:import>
				<%-- 关联机制 --%>
				<c:import url="/sys/relation/include/sysRelationMain_doc_view.jsp"
					charEncoding="UTF-8">
					<c:param name="mainModelForm" value="kmInstitutionKnowledgeForm" />
					<c:param name="currModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
				</c:import>
		</div>
</div>

</center>

<%@ include file="/resource/jsp/info_view_down.jsp"%>