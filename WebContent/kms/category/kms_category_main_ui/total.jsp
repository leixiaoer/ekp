<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
[ 
	<kmss:ifModuleExist path="/kms/multidoc/">
	{count_url:'/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDocIndex.do?method=count&q.template=1'},
	</kmss:ifModuleExist>
	<kmss:ifModuleExist path="/kms/wiki/">
	{count_url:'/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDocIndex.do?method=count&q.template=2'}, 
	</kmss:ifModuleExist>
	<kmss:ifModuleExist path="/kms/kem/">
	{count_url:'/kms/kem/kms_kem_main/kmsKemMain.do?method=count'} 
	</kmss:ifModuleExist>
]
