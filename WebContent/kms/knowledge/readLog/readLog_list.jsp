<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>


<c:set var="isHasWiki" value="false"></c:set>
<kmss:ifModuleExist path="/kms/wiki/">
	<c:set var="isHasWiki" value="true"></c:set>
</kmss:ifModuleExist>

<c:set var="pathTitle" value="${lfn:message('kms-knowledge:module.kms.knowledge') }"></c:set>

<template:include file="/sys/profile/resource/template/list.jsp">
	
	<template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${pathTitle}" />
            <ui:menu-item text="${ lfn:message('kms-category:kmsCategory.index.readingRecord') }" />
        </ui:menu>
    </template:replace>
	
	<template:replace name="content">
		<list:criteria  expand="true" id="criteria1">
			
			<list:cri-criterion
				title="${lfn:message('kms-category:kmsCategoryKnowledgeRel.fdSourceType') }"
				key="fdModelName" expand="true" multi="false" >
				<list:box-select>
					<list:item-select>
						<ui:source type="Static" >
							[
								{text:'${ lfn:message('kms-category:kmsCategoryKnowledgeRel.fdSourceType.KmsMultidocKnowledge') }', value:'com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge'}
								<c:if test="${isHasWiki}">
									,{text:'${ lfn:message('kms-category:kmsCategoryKnowledgeRel.fdSourceType.KmsWikiMain') }',value:'com.landray.kmss.kms.wiki.model.KmsWikiMain'}
								</c:if>
							]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			
			
			<list:cri-auto
				modelName="com.landray.kmss.sys.readlog.model.SysReadLog"
				property="fdReadTime" />
		</list:criteria>
		
       	<div class="lui_list_operation">
			
       		<div class="lui_list_operation_page_top">
				<list:paging layout="sys.ui.paging.top">
				</list:paging>
			</div>
		</div>
        
        
        <list:listview id="listview">
                <ui:source type="AjaxJson">
                	{url:'/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDocIndex.do?method=readLogdata&orderby=fdReadTime&ordertype=down'}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false"  name="columntable">
                    <list:col-serial/>
                    
                    <list:col-html  title="${ lfn:message('kms-category:kmsCategoryKnowledgeRel.docSubject') }" style="width:45%">
						{$	 
							<a target="_blank" href="${LUI_ContextPath}{%row['linkStr']%}">
								{%row['docSubject']%}
							</a>
	 					$}
					</list:col-html>
                    <list:col-auto props="docTemplate;fdSourceType;docCreateTime" />
                </list:colTable>
          </list:listview>
          <!-- 翻页 -->
        <list:paging></list:paging>
	</template:replace>
</template:include>
<script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.kms.category.model.KmsCategoryKnowledgeRel',
                templateName: '',
                basePath: '/kms/category/kms_category_knowledge_rel/kmsCategoryKnowledgeRel.do',
                canDelete: '${canDelete}',
                mode: '',
                customOpts: {
                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/kms/category/resource/js/", 'js', true);
           </script>

