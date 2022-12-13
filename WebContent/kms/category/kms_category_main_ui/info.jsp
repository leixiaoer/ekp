<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
[ 
	<kmss:ifModuleExist path="/kms/multidoc/">
	{ text:"${lfn:message('kms-category:kmsCategory.index.document')}",count_url:'/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDocIndex.do?method=count&q.template=1','href':'/multidoc',router:true,icon:'lui_iconfont_navleft_com_all'},
	</kmss:ifModuleExist>
	<kmss:ifModuleExist path="/kms/wiki/">
	{ text:"${lfn:message('kms-category:kmsCategory.index.wiki')}",count_url:'/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDocIndex.do?method=count&q.template=2','href':'/wiki',router:true,icon:'lui_iconfont_navleft_kms_wiki'}, 
	</kmss:ifModuleExist>
	<kmss:ifModuleExist path="/kms/kem/">
	{ text:"${lfn:message('kms-category:kmsCategory.index.kem')}", count_url:'/kms/kem/kms_kem_main/kmsKemMain.do?method=count','href':'/kem',router:true,icon:'lui_iconfont_navleft_kms_kem'} 
	</kmss:ifModuleExist>
]
