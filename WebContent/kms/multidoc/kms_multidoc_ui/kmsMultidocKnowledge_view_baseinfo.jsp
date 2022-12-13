<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:if test="${kmsMultidocKnowledgeForm.docStatus=='10'}">
	<ui:event event="layoutDone">
		$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
    </ui:event>
</c:if>
<ui:content title="${lfn:message('kms-multidoc:kmsMultidocKnowledge.docInfo') }" titleicon="lui-fm-icon-2">
	<c:import url="/sys/evaluation/import/sysEvaluationMain_view_star.jsp"
		charEncoding="UTF-8">
		<c:param
			name="formName"
			value="kmsMultidocKnowledgeForm" />
	</c:import>
	<ul class='lui_form_info'>
		<li>
			<bean:message bundle="kms-multidoc" key="kmsMultidoc.creator" />：
			<ui:person personId="${kmsMultidocKnowledgeForm.docCreatorId}" personName="${kmsMultidocKnowledgeForm.docCreatorName}">
			</ui:person>
		</li>
		<li>
			<bean:message bundle="sys-doc" key="sysDocBaseInfo.docDept" />：
			<c:out  value="${kmsMultidocKnowledgeForm.docDeptName}" />
		</li>
		<li>
			<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.createTime" />：
			${createTime}
		</li>
		
		<c:if test="${not empty kmsMultidocKnowledgeForm.docEffectiveTime }">
		    <li>
			   <bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.docEffectiveTime" />：
			   ${kmsMultidocKnowledgeForm.docEffectiveTime}
		    </li>
		</c:if>
		
		<c:if test="${ not empty kmsMultidocKnowledgeForm.docFailureTime }">
		     <li>
				<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.docFailureTime" />：
				${kmsMultidocKnowledgeForm.docFailureTime}
		   </li>
		</c:if>
		
		<c:if test="${ not empty kmsMultidocKnowledgeForm.docExpireTime }">
			<li>
				<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.docExpireTime" />：
				<xform:datetime value="${kmsMultidocKnowledgeForm.docExpireTime}" 
								property="docExpireTime" dateTimeType="date" />
			</li>
		</c:if>
		
	
		
		<li>
			<bean:message bundle="sys-doc" key="sysDocBaseInfo.docStatus" />：
			<sunbor:enumsShow	value="${sysDocBaseInfoForm.docStatus}"	enumsType="kms_doc_status" />
		</li>
		<li>
			<bean:message bundle="sys-edition" key="sysEditionMain.tab.label" />：
			V ${kmsMultidocKnowledgeForm.editionForm.mainVersion}.${kmsMultidocKnowledgeForm.editionForm.auxiVersion}
		</li>
		<c:if test="${not empty kmsMultidocKnowledgeForm.fdNumber}">
			<li>
				<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.fdNumber"/>：
				<c:out value="${kmsMultidocKnowledgeForm.fdNumber}"/>
			</li>
		</c:if>
		<c:if test="${not empty kmsMultidocKnowledgeForm.docAlterorId}">
			<li>
				<bean:message bundle="kms-multidoc" key="kmsMultidoc.lastUpdateUser" />：
				<ui:person personId="${kmsMultidocKnowledgeForm.docAlterorId}" personName="${kmsMultidocKnowledgeForm.docAlterorName}">
				</ui:person>
			</li>
			<li>
				<bean:message bundle="kms-multidoc" key="kmsMultidoc.lastUpdateTime" />：
				${ alterTime}
			</li>	
		</c:if>
		<c:if test="${not empty lbpmTitle }">
			<li>
			<bean:message bundle="kms-multidoc" key="kmsMultidoc.source" />：
			<a class="com_btn_link" href="${ LUI_ContextPath}${lbpmUrl }" target="blank"><c:out value="${lbpmTitle }"></c:out></a>
			</li>
		</c:if>		
		<li>
				${HtmlParam.kmsMultidocKnowledgeTemplateName } :
			<a href="${LUI_ContextPath }/kms/multidoc/?categoryId=${kmsMultidocKnowledgeForm.docCategoryId}" target="_blank"><c:out value="${kmsMultidocKnowledgeForm.docCategoryName}"/></a>
		</li>
		<li>
			<c:choose>
				<c:when test="${HtmlParam.kmsCategoryEnabled}">
					<!-- 知识分类信息 -->
					<c:import
						url="/kms/category/kms_category_main/import/kmsCategoryMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmsMultidocKnowledgeForm" />
					</c:import>
				</c:when>
				<c:otherwise>
					<!-- 辅助分类 -->
					<c:if test="${not empty secondCategoriesNames[0]}">
						<bean:message bundle="kms-multidoc" key="kmsMultidoc.kmsMultidocKnowledge.docProperties"/> :
						<c:forEach items="${secondCategoriesNames}" var="docSecondCateName" varStatus="varStatus">
							<a href="${LUI_ContextPath }/kms/multidoc/?categoryId=${secondCategoriesIds[varStatus.index]}" target="_blank">${docSecondCateName}</a>
							<c:if test="${!varStatus.last }">;</c:if>
						</c:forEach>
					</c:if>
				</c:otherwise>
			</c:choose>
			
		</li>
	</ul>
<!-- 知识标签 -->
<c:import url="/sys/tag/import/sysTagMain_view.jsp" charEncoding="UTF-8">
		<c:param name="isInContent" value="true"></c:param>
		<c:param name="formName" value="kmsMultidocKnowledgeForm" />
		<c:param name="useTab" value="false"></c:param>
		<c:param name="toolbarOrder" value="3"></c:param>
		<c:param name="showEditButton" value="true"></c:param>
		<c:param name="fdQueryCondition" value="${kmsMultidocKnowledgeForm.docCategoryId };${kmsMultidocKnowledgeForm.docDeptId }" />
		<c:param name="titleicon" value="lui-fm-icon-2"/>
</c:import>
</ui:content>
<!-- 智能标签 -->
<kmss:ifModuleExist path="/third/intell/">
	<c:import url="/third/intell/import/sysTagMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmsMultidocKnowledgeForm" />
			<c:param name="modelName" value="com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge" />
			<c:param name="modelId" value="${kmsMultidocKnowledgeForm.fdId}" />
			<c:param name="titleicon" value="lui-fm-icon-2"/>
	</c:import>
</kmss:ifModuleExist>