<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/lbpmservice/taglib/taglib.tld" prefix="lbpm"%>
<lbpm:lbpmApproveModel modelName="com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge"></lbpm:lbpmApproveModel>
<%@ page
	import="com.landray.kmss.kms.category.model.KmsCategoryConfig"%>
<c:set var="kmsCategoryEnabled" value="false"></c:set>
<c:set var="kmsMultidocKnowledgeTemplateName" value="${ lfn:message('kms-multidoc:kmsMultidocKnowledge.fdTemplateName') }"></c:set>		
<c:if test="${kms_professional}">
	<%
		KmsCategoryConfig kmsCategoryConfig = new KmsCategoryConfig();
		String kmsCategoryEnabled = (String) kmsCategoryConfig.getDataMap().get("kmsCategoryEnabled");
		if ("true".equals(kmsCategoryEnabled)) {
	%>
		<c:set var="kmsCategoryEnabled" value="true"></c:set>
		<c:set var="kmsMultidocKnowledgeTemplateName" value="${ lfn:message('kms-multidoc:kmsMultidocKnowledge.fdTemplateName.categoryTrue') }"></c:set>
	<%
		}
	%>
</c:if>
<c:set var="isHasIstorage" value="false"></c:set>
<kmss:ifModuleExist path="/kms/istorage/">
	<c:set var="isHasIstorage" value="true"></c:set>
</kmss:ifModuleExist>
<c:choose>
	<%-- 流程引擎默认设置是否开启右侧审批模式 --%>
	<c:when test="${lbpmApproveModel eq 'right'}">
		<%-- 流程右侧审批三级页面模板 --%>
		<c:set var="ref" value="lbpm.right"></c:set>
		<c:set var="isShowQrcode" value="false"></c:set>
		<c:set var="isEdit" value="true"></c:set>
		<c:set var="formName" value="kmsMultidocKnowledgeForm"></c:set>
		<c:set var="formUrl" value="${KMSS_Parameter_ContextPath}kms/multidoc/kms_multidoc_knowledge/kmsMultidocKnowledge.do"></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="ref" value="default.edit"></c:set>
		<c:set var="showQrcode" value="false"></c:set>
	</c:otherwise>
</c:choose>

<template:include
	ref="${ref }"
	showQrcode="${showQrcode }"
	isShowQrcode="${isShowQrcode}"
	isEdit="${isEdit }"
	formName="${formName }"
	formUrl="${formUrl }" >
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/kms/multidoc/kms_multidoc_ui/style/edit.css" />
	</template:replace>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmsMultidocKnowledgeForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('kms-multidoc:kmsMultidoc.create.title') } - ${ lfn:message('kms-multidoc:table.kmdoc') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmsMultidocKnowledgeForm.docSubject} - ${ lfn:message('kms-multidoc:table.kmdoc') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<c:if test="${kmsMultidocKnowledgeForm.docDeleteFlag ==1}">
			<div id="toolbar" style="display:none"></div>
		</c:if>
		<c:if test="${kmsMultidocKnowledgeForm.docDeleteFlag !=1}">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
				<c:choose>
					<c:when test="${ kmsMultidocKnowledgeForm.method_GET == 'add' }">
						<ui:button text="${lfn:message('kms-multidoc:kmsMultidoc.button.savedraft') }" order="2" onclick="commitMethod('save','true');">
						</ui:button>
						<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('save','false');">
						</ui:button>
					</c:when>
					<c:when test="${ kmsMultidocKnowledgeForm.method_GET == 'edit' }">
						<c:if test="${kmsMultidocKnowledgeForm.docStatusFirstDigit=='1'}">
							<ui:button text="${lfn:message('kms-multidoc:kmsMultidoc.button.savedraft') }" order="4" onclick="commitMethod('update','true');">
							</ui:button>
						</c:if>
						<c:if test="${kmsMultidocKnowledgeForm.docStatusFirstDigit<'3'}">
							<ui:button text="${lfn:message('button.submit') }" order="4" onclick="commitMethod('update','false');">
							</ui:button>
						</c:if>
						<c:if test="${kmsMultidocKnowledgeForm.docStatusFirstDigit>='3'}">
							<ui:button text="${lfn:message('button.submit') }" order="4" onclick="directCommitMethod(document.kmsMultidocKnowledgeForm, 'update');">
							</ui:button>
						</c:if>			
					</c:when>
				</c:choose>
				<ui:button text="${lfn:message('button.close') }" onclick="Com_CloseWindow();" order="5">
				</ui:button>
			</ui:toolbar>
		</c:if>
	</template:replace>
	<template:replace name="path">
			<ui:combin ref="menu.path.simplecategory">
				<ui:varParams 
					moduleTitle="${ lfn:message('kms-multidoc:table.kmdoc') }" 
					modulePath="/kms/multidoc/" 
					modelName="com.landray.kmss.kms.knowledge.model.KmsKnowledgeCategory" 
					autoFetch="false"
					target="_blank"
					categoryId="${kmsMultidocKnowledgeForm.docCategoryId}" />
			</ui:combin>
	</template:replace>	
	<c:if test="${lbpmApproveModel eq 'right'}">
	<%-- 流程右侧审批三级页面模板 --%>
	<template:replace name="barRight">
		<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
		<c:choose>
			<c:when test="${kmsMultidocKnowledgeForm.docStatus>='30' || kmsMultidocKnowledgeForm.docStatus=='00' }">
			<ui:content title="${ lfn:message('kms-multidoc:kmsMultidoc.docInfo') }" 
				titleicon="lui-fm-icon-2" id="barRight_kmsMultidoc_baseInfo">
				<ul class='lui_form_info'>
					<li>
						<bean:message bundle="kms-multidoc" key="kmsMultidoc.creator" />：
						<ui:person personId="${kmsMultidocKnowledgeForm.docCreatorId}" personName="${kmsMultidocKnowledgeForm.docCreatorName}">
						</ui:person>
					</li>
					<li>
						<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.createTime" />：
						${createTime}
					</li>
					<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docStatus" />：<sunbor:enumsShow	value="${kmsMultidocKnowledgeForm.docStatus}"	enumsType="common_status" /></li>
					<li><bean:message bundle="sys-edition" key="sysEditionMain.tab.label" />：${ kmsMultidocKnowledgeForm.docMainVersion }.${ kmsMultidocKnowledgeForm.docAuxiVersion }</li>
					<c:if test="${not empty kmsMultidocKnowledgeForm.fdNumber}">
						<li>
							<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.fdNumber"/>：
							<c:out value="${kmsMultidocKnowledgeForm.fdNumber}"/>
						</li>
					</c:if>
					<li>
						<bean:message bundle="kms-multidoc" key="kmsMultidoc.lastUpdateUser" />：
						<ui:person personId="${kmsMultidocKnowledgeForm.docAlterorId}" personName="${kmsMultidocKnowledgeForm.docAlterorName}">
						</ui:person>
					</li>
					<c:if test="${not empty alterTime }">
						<li><bean:message bundle="kms-multidoc" key="kmsMultidoc.lastUpdateTime" />：${alterTime }</li>
					</c:if>					
				</ul>
			</ui:content>
			</c:when>
			<c:otherwise>
			<%--流程--%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmsMultidocKnowledgeForm" />
				<c:param name="fdKey" value="mainDoc" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
				<c:param name="approveType" value="right" />
				<c:param name="approvePosition" value="right" />
			</c:import>
			</c:otherwise>
		</c:choose>
			<!-- 关联机制(与原有机制有差异) -->
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmsMultidocKnowledgeForm" />
				<c:param name="approveType" value="right" />
				<c:param name="needTitle" value="true" />
			</c:import>
		<c:choose>
			<c:when test="${kmsMultidocKnowledgeForm.docStatus>='30' || kmsMultidocKnowledgeForm.docStatus=='00' }">
			</c:when>
			<c:otherwise>
			<ui:content title="${ lfn:message('kms-multidoc:kmsMultidoc.docInfo') }" 
				titleicon="lui-fm-icon-2" id="barRight_kmsMultidoc_baseInfo">
				<ul class='lui_form_info'>
					<li>
						<bean:message bundle="kms-multidoc" key="kmsMultidoc.creator" />：
						<ui:person personId="${kmsMultidocKnowledgeForm.docCreatorId}" personName="${kmsMultidocKnowledgeForm.docCreatorName}">
						</ui:person>
					</li>
					<li>
						<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.createTime" />：
						${createTime}
					</li>
					<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docStatus" />：<sunbor:enumsShow	value="${kmsMultidocKnowledgeForm.docStatus}"	enumsType="common_status" /></li>
					<li><bean:message bundle="sys-edition" key="sysEditionMain.tab.label" />：${ kmsMultidocKnowledgeForm.docMainVersion }.${ kmsMultidocKnowledgeForm.docAuxiVersion }</li>
					<c:if test="${not empty kmsMultidocKnowledgeForm.fdNumber}">
						<li>
							<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.fdNumber"/>：
							<c:out value="${kmsMultidocKnowledgeForm.fdNumber}"/>
						</li>
					</c:if>
					<li>
						<bean:message bundle="kms-multidoc" key="kmsMultidoc.lastUpdateUser" />：
						<ui:person personId="${kmsMultidocKnowledgeForm.docAlterorId}" personName="${kmsMultidocKnowledgeForm.docAlterorName}">
						</ui:person>
					</li>
					<c:if test="${not empty alterTime }">
						<li><bean:message bundle="kms-multidoc" key="kmsMultidoc.lastUpdateTime" />：${alterTime }</li>
					</c:if>					
				</ul>
			</ui:content>
			</c:otherwise>
		</c:choose>
		</ui:tabpanel>
	</template:replace>
	</c:if>
	<template:replace name="content"> 
		<%@ include file="/kms/multidoc/kms_multidoc_ui/kmsMultidocKnowledge_edit_script.jsp"%>
		<c:if test="${lbpmApproveModel ne 'right'}">
			<%-- 普通模式页面模板 --%>
			<form name="kmsMultidocKnowledgeForm" method="post" 
				action="${KMSS_Parameter_ContextPath}kms/multidoc/kms_multidoc_knowledge/kmsMultidocKnowledge.do">
		</c:if>
			<html:hidden property="fdImportInfo" />
			<html:hidden property="fdId" />
		<c:if test="${empty kmsMultidocKnowledgeForm.docSubject}">
			<p class="txttitle" style="display: none;"><bean:message bundle="kms-multidoc" key="kmsMultidoc.form.title" /></p>
		</c:if>
		<c:if test="${!empty kmsMultidocKnowledgeForm.docSubject}">
			<p class="txttitle" style="display: none;"><c:out value='${kmsMultidocKnowledgeForm.docSubject}'/></p>
		</c:if> 
		<html:hidden property="fdId" />
		<html:hidden property="fdModelId" />
		<html:hidden property="fdModelName" />
		<html:hidden property="fdWorkId" />
		<html:hidden property="docStatus" />
		<html:hidden property="fdPhaseId" />
		<html:hidden property="extendFilePath"/>
		<html:hidden property="extendDataXML"/>
		
		<html:hidden property="docCreateTime" />
		<html:hidden property="docAlterTime" />
		<html:hidden property="docSourceId"/>
		<html:hidden property="docIsIndexTop"/>
		<ui:tabpage expand="false">
			<ui:content title="${ lfn:message('kms-multidoc:kmsMultidoc.fddoc') }" toggle="false">
				<table class="tb_simple" width=100%>
					<tr>
						<td width="15%" class="td_normal_title" valign="top">
							<bean:message bundle="sys-doc" key="sysDocBaseInfo.docAttachments" />
						</td>
						<td width="85%" colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attachment" />
								<c:param name="totalWidth" value="95.5%" />
							</c:import>
						</td>
					</tr>
					
					<tr>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="sys-doc" key="sysDocBaseInfo.docSubject" />
						</td>
						<td width="85%" colspan="3">
							<xform:text isLoadDataDict="false" validators="maxLength(200)" 
								property="docSubject" required="true" className="inputsgl" style="width:98%;"
								onValueChange="${isHasIstorage?'getSimdoc();getBigDataCategory();getBigDataTag();':'' }"/>
						</td>
					</tr>
					
					<c:import url="/sys/tag/import/sysTagMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmsMultidocKnowledgeForm" />
						<c:param name="fdKey" value="mainDoc" /> 
						<c:param name="fdQueryCondition" value="docCategoryId;docDeptId" /> 
						<c:param name="fdInputWidth" value="98.6%" /> 
					</c:import>
					
					<tr>
						<td class="td_normal_title" width="15%">
							${kmsMultidocKnowledgeTemplateName }
						</td>
						<td width="35%">
							<html:hidden property="docCategoryId" /> 
							<bean:write name="kmsMultidocKnowledgeForm" property="docCategoryName" />
							<c:if test="${param.method == 'add' }">
								<a href="javascript:modifyCate(true)" style="margin-left:15px;display:none;" class="com_btn_link">${lfn:message('kms-multidoc:kmsMultidoc.changeTemplate') }</a>
								<span class="txtstrong" style="display:none;">*</span>
							</c:if>
						</td>
						
						<td class="td_normal_title" width="15%">
							<c:if test="${!kmsCategoryEnabled}">
								<bean:message key="kmsMultidoc.kmsMultidocKnowledge.docProperties" bundle="kms-multidoc" />
							</c:if>
						</td>
						<td width="35%">
							<c:if test="${!kmsCategoryEnabled}">
								<xform:dialog propertyId="docSecondCategoriesIds" propertyName="docSecondCategoriesNames" style="width:96%" >
									modifySecondCate(true);
								</xform:dialog>	
							</c:if>
						</td>
					</tr>
					
					<!-- 知识分类-->
					<c:if test="${kmsCategoryEnabled}">
						<c:if test="${kms_professional}">
							<tr>
								<c:import url="/kms/category/kms_category_main/import/kmsCategoryMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmsMultidocKnowledgeForm" />
									<c:param name="modelName" value="com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge" />
									<c:param name="fdInputWidth" value="98.5%" /> 
								</c:import>
							</tr>
						</c:if>
					</c:if>
					<c:if test="${kms_professional}">
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.docExpireTime" />
							</td>
							
							<td width="40%">
								<xform:datetime 
										property="docExpireTime" 
										dateTimeType="Date" style="width:100%" 
										validators='${kmsMultidocKnowledgeForm.docStatusFirstDigit < 3 ? "checkDocExpireTime checkDocFailureTime" : " checkDocFailureTime"}'/>						
							</td>
							<td colspan="2" width="45%">
								<bean:message key="message.storetime.day" bundle="kms-multidoc" />
							</td>		
						</tr>
					</c:if>
					
					<tr>
					
						<td width="15%" class="td_normal_title">
							<bean:message bundle="kms-multidoc" key="kmsMultidoc.authorType" />
						</td>
						<td width="35%">
							<xform:radio property="authorType" onValueChange="changeAuthorType" value="${not empty kmsMultidocKnowledgeForm.fdDocAuthorList?1:2}">
								<xform:enumsDataSource enumsType="kmsKnowledgeAuthorType">
								</xform:enumsDataSource>
							</xform:radio>
						</td>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="sys-doc" key="sysDocBaseInfo.docAuthor" />
						</td>
						<!-- 内部作者 -->
						<td width="35%" id="innerAuthor" <c:if test="${empty kmsMultidocKnowledgeForm.fdDocAuthorList }">style="display: none;"</c:if> >
							<c:if test="${empty kmsMultidocKnowledgeForm.fdDocAuthorList }">
								<xform:address mulSelect="true" isLoadDataDict="false" style="width:96%" propertyId="docAuthorId" propertyName="docAuthorName" orgType='ORG_TYPE_PERSON'  subject="${lfn:message('sys-doc:sysDocBaseInfo.docAuthor') }" onValueChange="changeAuthodInfo"></xform:address>
							    <span class="txtstrong">*</span>
							</c:if>
							<c:if test="${not empty kmsMultidocKnowledgeForm.fdDocAuthorList }">
								<xform:address 
								    mulSelect="true"
									required="true" 
									isLoadDataDict="false" 
									style="width:96%" 
									propertyId="docAuthorId" 
									propertyName="docAuthorName" 
									orgType='ORG_TYPE_PERSON'  
									subject="${lfn:message('sys-doc:sysDocBaseInfo.docAuthor') }"
									onValueChange="changeAuthodInfo" />
							</c:if>
						</td>
						<!-- 外部作者 -->
						<td width="35%" id="outerAuthor" <c:if test="${not empty kmsMultidocKnowledgeForm.fdDocAuthorList }">style="display: none;"</c:if>>
							<c:if test="${not empty kmsMultidocKnowledgeForm.fdDocAuthorList }">
								<xform:text property="outerAuthor"  style="width:90%" subject="${lfn:message('sys-doc:sysDocBaseInfo.docAuthor') }"></xform:text>
							    <span class="txtstrong">*</span>
							</c:if>
							<c:if test="${empty kmsMultidocKnowledgeForm.fdDocAuthorList }">
								<xform:text property="outerAuthor"  validators="checkName maxLength(200)" required="true" style="width:96%" subject="${lfn:message('sys-doc:sysDocBaseInfo.docAuthor') }"></xform:text>
							</c:if>
							
						</td>
					</tr>

					<c:if test="${docLifeCycleShowFlag eq 'true' }">
						<tr>
							<!-- 生效时间 -->
							<td width="15%" class="td_normal_title">
								<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.docEffectiveTime" />
							</td>
							<td width="35%">
								<xform:datetime property="docEffectiveTime" style="width:96%" validators="checkDocEffectiveTime" />
							</td>
							<!-- 失效时间 -->
							<td width="15%" class="td_normal_title">
								<bean:message bundle="kms-multidoc" key="kmsMultidocKnowledge.docFailureTime" />
							</td>
							<td width="35%">
								<xform:datetime property="docFailureTime" style="width:96%" validators="checkDocFailureTime checkDocEffectiveTime" />
							</td>
						</tr>					
					</c:if>

					<tr>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="sys-doc" key="sysDocBaseInfo.docDept" />
						</td>
						<td width="35%">
							<xform:address required="false" validators="" 
								style="width:100%" propertyId="docDeptId"
								 propertyName="docDeptName" orgType='ORG_TYPE_ORGORDEPT'></xform:address>
						</td>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="kms-multidoc" key="table.kmsMultidocMainPost" />
						</td>
						<td width="35%">
							<xform:address 
								required="false" 
								style="width:96%" 
								propertyId="docPostsIds" 
								propertyName="docPostsNames" 
								mulSelect="true"
								orgType='ORG_TYPE_POST'>
							</xform:address>
						</td>
					</tr>
       
					<!-- 摘要 -->
					<tr>
						<td width="15%" class="td_normal_title" valign="top">
							<bean:message bundle="sys-doc" key="sysDocBaseInfo.fdDescription" />
						</td>
						<td width="85%" colspan="3">
							<xform:textarea isLoadDataDict="false" 
							property="fdDescription" validators="maxLength(4000)"
							 style="width:98%;height:90px;padding-left:4px;" className="inputmul" 
							 onValueChange="${isHasIstorage?'getSimdoc();getBigDataTag();':'' }"/>
						</td>
					</tr>
	
					<!-- 封面 -->
					<tr>
						<td width="15%" class="td_normal_title" valign="top">
							<bean:message bundle="kms-multidoc" key="kmsMultidoc.uploadCoverPic" />
						</td>
						<td width="85%" colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="spic"/>
								<c:param name="fdAttType" value="pic"/>
								<c:param name="fdShowMsg" value="true"/>
								<c:param name="fdMulti" value="false"/>
								<c:param name="fdLayoutType" value="pic"/>
								<c:param name="fdPicContentWidth" value="207"/>
								<c:param name="fdPicContentHeight" value="150"/>
								<c:param name="fdViewType" value="pic_single"/>
							</c:import>
						</td>
					</tr>
					
				</table>
			</ui:content>
			<!-- 文档内容 -->
			<ui:content title="${ lfn:message('kms-multidoc:kmsMultidoc.kmsMultidocKnowledge.docContent') }" toggle="false">
				
				<table class="tb_simple" width=100%>
					<tr>
						
						<td width="85%" colspan="3">
							<kmss:editor property="docContent" toolbarSet="Default" height="500" width="98%"/>
						</td>
					</tr>
				</table>
			</ui:content>
			
			<c:if test="${lbpmApproveModel ne 'right'}">
				  <div style="display: none;">
					     <table id="authorsArrary">
					        <c:if test="${ not empty kmsMultidocKnowledgeForm.fdDocAuthorList }">
						         <c:forEach items="${ kmsMultidocKnowledgeForm.fdDocAuthorList }" var="kmsMultidocKnowledgeForm"  varStatus="varStatus">
						              <tr>
						                <td>
						                     <input type='hidden' name='fdDocAuthorList[${ kmsMultidocKnowledgeForm.fdAuthorFag }].fdOrgId' value='${kmsMultidocKnowledgeForm.fdOrgId }'>
						                     <input type='hidden' name='fdDocAuthorList[${ kmsMultidocKnowledgeForm.fdAuthorFag }].fdAuthorFag' value='${ kmsMultidocKnowledgeForm.fdAuthorFag }'>
						                 </td>
						              </tr>
						         </c:forEach>
					          </c:if>
					     </table>
				    </div>
			
			
			<c:if test="${kms_professional}">
				<!-- 属性 -->
				<c:if test="${not empty kmsMultidocKnowledgeForm.extendFilePath}">
					<ui:content id="validate_ele2" title="${ lfn:message('kms-multidoc:kmsMultidoc.docProperty') }" toggle="false">
						<table class="tb_simple tb_property" width=100%>
							<c:import url="/sys/property/include/sysProperty_edit.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmsMultidocKnowledgeForm" />
								<c:param name="fdDocTemplateId" value="${kmsMultidocKnowledgeForm.docCategoryId}" />
							</c:import>
						</table>
					</ui:content>
				</c:if>
			</c:if>
			<!-- 权限 -->
			<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmsMultidocKnowledgeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge" />
			</c:import>
			<!-- 版本 -->
			<c:import url="/sys/edition/import/sysEditionMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmsMultidocKnowledgeForm" />
			</c:import>
			<!-- 流程 -->
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmsMultidocKnowledgeForm" />
				<c:param name="fdKey" value="mainDoc" />
			</c:import>
				<%---发布机制---%>
			<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmsMultidocKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" />	 
					<c:param name="isShow" value="true" />
			</c:import> 
			<c:if test="${lbpmApproveModel ne 'right'}">
			    <!-- 通知 -->
				<c:import url="/kms/knowledge/support/kmsKnowledgeOperationNotify.jsp" charEncoding="UTF-8">
				</c:import>
			</c:if>
			
			<c:if test="${kms_professional}">
			<kmss:ifModuleExist path="/kms/learn">
				<c:if test="${kmsMultidocKnowledgeForm.docStatus == '10' || param.method == 'newEdition'}">
					<ui:content title="${ lfn:message('kms-multidoc:kmsMultidoc.courseware.publish') }" expand="true">
						<c:import url="/kms/learn/kms_learn_courseware/import/KmsLearnCoursewarePublishMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmsMultidocKnowledgeForm" />
							<c:param name="fdKey" value="mainDoc" />	 
						</c:import>
					</ui:content>
				</c:if>
			</kmss:ifModuleExist>
			</c:if>
		</c:if>
			<ui:event event="layoutDone">
			<c:if test="${lbpmApproveModel eq 'right'}">
				this.element.find(".lui_tabpage_float_collapse").hide();
				this.element.find(".lui_tabpage_float_navs_mark").hide();
				this.element.find(".lui_tabpage_float_navs").hide();
			</c:if>
		    </ui:event>
		
		</ui:tabpage>
		<c:if test="${lbpmApproveModel eq 'right'}">
		<ui:nonepanel>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="6" var-average='false' var-useMaxWidth='true'>
				  <div style="display: none;">
					     <table id="authorsArrary">
					        <c:if test="${ not empty kmsMultidocKnowledgeForm.fdDocAuthorList }">
						         <c:forEach items="${ kmsMultidocKnowledgeForm.fdDocAuthorList }" var="kmsMultidocKnowledgeForm"  varStatus="varStatus">
						              <tr>
						                <td>
						                     <input type='hidden' name='fdDocAuthorList[${ kmsMultidocKnowledgeForm.fdAuthorFag }].fdOrgId' value='${kmsMultidocKnowledgeForm.fdOrgId }'>
						                     <input type='hidden' name='fdDocAuthorList[${ kmsMultidocKnowledgeForm.fdAuthorFag }].fdAuthorFag' value='${ kmsMultidocKnowledgeForm.fdAuthorFag }'>
						                 </td>
						              </tr>
						         </c:forEach>
					          </c:if>
					     </table>
				    </div>
			
			
			<c:if test="${kms_professional}">
			<!-- 属性 -->
			<c:if test="${not empty kmsMultidocKnowledgeForm.extendFilePath}">
				<ui:content id="validate_ele2" title="${ lfn:message('kms-multidoc:kmsMultidoc.docProperty') }" toggle="false">
					<table class="tb_simple tb_property" width=100%>
						<c:import url="/sys/property/include/sysProperty_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmsMultidocKnowledgeForm" />
							<c:param name="fdDocTemplateId" value="${kmsMultidocKnowledgeForm.docCategoryId}" />
						</c:import>
					</table>
				</ui:content>
			</c:if>
			</c:if>
			<!-- 权限 -->
			<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmsMultidocKnowledgeForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge" />
			</c:import>
			<!-- 版本 -->
			<c:import url="/sys/edition/import/sysEditionMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmsMultidocKnowledgeForm" />
			</c:import>
		<c:choose>
			<c:when test="${kmsMultidocKnowledgeForm.docStatus>='30' || kmsMultidocKnowledgeForm.docStatus=='00' }">
			</c:when>
			<c:otherwise>
			<%--流程主要信息 --%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmsMultidocKnowledgeForm" />
				<c:param name="fdKey" value="mainDoc" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
				<c:param name="approveType" value="right" />
			</c:import>
			</c:otherwise>
		</c:choose>
				<%---发布机制---%>
			<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmsMultidocKnowledgeForm" />
					<c:param name="fdKey" value="mainDoc" />	 
					<c:param name="isShow" value="true" />
			</c:import> 
			<c:if test="${kms_professional}">
			<kmss:ifModuleExist path="/kms/learn">
				<c:if test="${kmsMultidocKnowledgeForm.docStatus == '10' || param.method == 'newEdition'}">
					<ui:content title="${ lfn:message('kms-multidoc:kmsMultidoc.courseware.publish') }" expand="true">
						<c:import url="/kms/learn/kms_learn_courseware/import/KmsLearnCoursewarePublishMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmsMultidocKnowledgeForm" />
							<c:param name="fdKey" value="mainDoc" />	 
						</c:import>
					</ui:content>
				</c:if>
			</kmss:ifModuleExist>
			</c:if>
			<c:import url="/kms/knowledge/support/kmsKnowledgeOperationNotify.jsp" charEncoding="UTF-8">
			</c:import>
			</ui:tabpanel>
			</ui:nonepanel>
		</c:if>
	<c:if test="${lbpmApproveModel ne 'right'}">
		</form>
	</c:if>
		
		<kmss:ifModuleExist path="/kms/istorage/">
			<%-- <ui:drawerpanel width="350">
				<!--相类似知识	-->
				<ui:content
					title="${lfn:message('kms-knowledge:kms.knowledge.repeat') }"
					toggle="false" titleicon="lui_iconfont_navleft_similar">
					<c:import url="/kms/istorage/import/simdocAsyn.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmsMultidocKnowledgeForm" />
					</c:import>
				</ui:content>
			</ui:drawerpanel> --%>
			<c:import url="/kms/istorage/import/simdocAsyn.jsp"
				charEncoding="UTF-8">
				<c:param name="formName" value="kmsMultidocKnowledgeForm" />
			</c:import>
		</kmss:ifModuleExist>
		
	</template:replace>
<c:if test="${lbpmApproveModel ne 'right'}">
	<template:replace name="nav">
		<div style="min-width:200px;"></div>
		<ui:panel toggle="false">
			<ui:content title="${ lfn:message('kms-multidoc:kmsMultidoc.docInfo') }">
				<ul class='lui_form_info'>
					<li>
						<bean:message bundle="kms-multidoc" key="kmsMultidoc.creator" />：
						<ui:person personId="${kmsMultidocKnowledgeForm.docCreatorId}" personName="${kmsMultidocKnowledgeForm.docCreatorName}">
						</ui:person>
					</li>
					<li><bean:message bundle="sys-doc" key="sysDocBaseInfo.docStatus" />：<sunbor:enumsShow	value="${kmsMultidocKnowledgeForm.docStatus}"	enumsType="common_status" /></li>
					<li><bean:message bundle="sys-edition" key="sysEditionMain.tab.label" />：${ kmsMultidocKnowledgeForm.docMainVersion }.${ kmsMultidocKnowledgeForm.docAuxiVersion }</li>
					<li>
						<bean:message bundle="kms-multidoc" key="kmsMultidoc.lastUpdateUser" />：
						<ui:person personId="${kmsMultidocKnowledgeForm.docAlterorId}" personName="${kmsMultidocKnowledgeForm.docAlterorName}">
						</ui:person>
					</li>
					<c:if test="${not empty alterTime }">
						<li><bean:message bundle="kms-multidoc" key="kmsMultidoc.lastUpdateTime" />：${alterTime }</li>
					</c:if>					
				</ul>
			</ui:content>
		</ui:panel>
		<%--关联机制(与原有机制有差异)--%>
		<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="layout" value="sys.ui.accordionpanel.simpletitle"/>
			<c:param name="formName" value="kmsMultidocKnowledgeForm" />
		</c:import>
	</template:replace>
</c:if>
</template:include>

<script language="JavaScript">
	$KMSSValidation(document.forms['kmsMultidocKnowledgeForm']).addValidators(validations);
</script>	
<script >
$KMSSValidation();
Com_IncludeFile("jquery.js|dialog.js|data.js");
var _validation = $KMSSValidation(document.forms['kmsMultidocKnowledgeForm']);
LUI.ready(function() {
	var validators = {
			'checkName' : 
			{
				error : "<bean:message key='kmsMultidoc.validateOutAuthorFormat' bundle='kms-multidoc'/>",
				test:function(v,e,o) {
					v = $.trim(v);
					if (v.indexOf("；")==-1 
							&& v.indexOf("，")==-1 
							&& v.indexOf(",")==-1
							&& v.indexOf("-")==-1 
							&& v.indexOf("_")==-1 ) {
						return true;
					}else {
						return false;
					}
				}
			}
		};
      _validation.addValidators(validators);
});
</script>
<c:import url="/sys/recycle/import/redirect.jsp">
	<c:param name="formBeanName" value="kmsMultidocKnowledgeForm"></c:param>
</c:import>