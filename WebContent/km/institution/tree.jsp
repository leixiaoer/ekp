<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="kmInstitution.tree.title" bundle="km-institution"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5,defaultNode;
	n1 = LKSTree.treeRoot;	
	
	//类别设置
	defaultNode = n1.AppendURLChild(
		"<bean:message bundle="km-institution" key="menu.kmdoc.categoryconfig"/>",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.institution.model.KmInstitutionTemplate&actionUrl=/km/institution/km_institution_template/kmInstitutionTemplate.do&formName=kmInstitutionTemplateForm&mainModelName=com.landray.kmss.km.institution.model.KmInstitutionKnowledge&docFkName=kmInstitutionTemplate" />"
	);
	//=====================模块设置=====================
	n2 = n1.AppendURLChild(
		"<bean:message bundle="km-institution" key="menu.kmdoc.module.title"/>"
	);
	n2.isExpanded = true;
	//基础配置
	<kmss:authShow roles="ROLE_KMINSTITUTION_SETTING">
		n2.AppendURLChild(
		"<bean:message bundle="km-institution" key="kmInstitutionKnowledge.param.config"/>",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.km.institution.model.KmInstitutionConfig" />"
	);
	</kmss:authShow>
		
	//流程模板设置
	<kmss:authShow roles="ROLE_KMINSTITUTION_COMMONWORKFLOW">
	// 通用流程模板
	n2.AppendURLChild(
		"<bean:message key="tree.workflowTemplate" bundle="km-institution" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?method=list&fdModelName=com.landray.kmss.km.institution.model.KmInstitutionTemplate&fdKey=mainDoc" />"
	); 
	
	// 文档失效流程模板
	n2.AppendURLChild(
		"<bean:message key="tree.abolish.workflowTemplate" bundle="km-institution" />",
		"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?method=list&fdModelName=com.landray.kmss.km.institution.model.KmInstitutionTemplate&fdKey=abolishDoc" />"
	); 
	</kmss:authShow>
	
	// 失效流程文档
	<kmss:authShow roles="ROLE_KMINSTITUTION_ABOLISH_MAINTAINER">
	n2.AppendURLChild(
		"<bean:message key="tree.abolish.kmdoc" bundle="km-institution" />",
		"<c:url value="/km/institution/km_inst_knowledge_abolish/index.jsp" />"
	);
	</kmss:authShow>
	
	// 编号规则设置
	<kmss:authShow roles="ROLE_KMINSTITUTION_COMMONNUMBER">
	n2.AppendURLChild(
		"<bean:message bundle="sys-number" key="table.sysNumberMain"/>",
		"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />"
	);
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KMINSTITUTION_SETTING">
	n2.AppendURLChild(
		"<bean:message key="kmInstitution.tree.listshow" bundle="km-institution" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.institution.model.KmInstitutionKnowledge"/>"
	);
	</kmss:authShow>
	//文档维护
	n2 = n1.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />")
	n2.authType="01";
	<kmss:authShow roles="ROLE_KMINSTITUTION_OPTALL">
	n2.authRole="optAll";
	</kmss:authShow>
	n2.AppendSimpleCategoryDataWithAdmin ("com.landray.kmss.km.institution.model.KmInstitutionTemplate",
	"<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=manageList&categoryId=!{value}&status=all&orderBy=fdNumber"/>",
	"<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=listChildren&type=category&categoryId=!{value}"/>");
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
  </template:replace>
</template:include>
