<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.km.pindagate" bundle="km-pindagate"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4,defaultNode;
	n1 = LKSTree.treeRoot;
	
    	<%-- 模块设置 --%>
	    n2 = n1.AppendURLChild(
		      "<bean:message bundle="km-pindagate" key="kmPindagate.tree.module.setting"/>"
		);
		n2.isExpanded = true;
	    <%-- 问卷分类设置 --%>
	    defaultNode = n2.AppendURLChild(
		      "<bean:message bundle="km-pindagate" key="kmPindagateMain.tree.category.set"/>","<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.pindagate.model.KmPindagateTemplate&mainModelName=com.landray.kmss.km.pindagate.model.KmPindagateMain&categoryName=docCategory&templateName=kmPindagateTemplate" />"
	    );
	    
	    n2.AppendCV2Child("<bean:message key="table.kmPindagateTemplate" bundle="km-pindagate" />",
			 "com.landray.kmss.km.pindagate.model.KmPindagateTemplate",
			 "<c:url value="/km/pindagate/km_pindagate_template/index.jsp?parentId=!{value}" />");
		
	    <%-- 通用流程模板设置 --%>
		<kmss:authShow roles="ROLE_KMPINDAGATE_PARAMETER_CONFIG">
		n3=n2.AppendURLChild(
				"<bean:message key="kmPindagate.tree.common.template" bundle="km-pindagate" />",
				"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.pindagate.model.KmPindagateTemplate&fdKey=pindagateMain" />"
		); 
		</kmss:authShow>
	   	<%-- 问卷题目分类设置 --%>
	    n3 = n2.AppendURLChild(
		      "<bean:message bundle="km-pindagate" key="kmPindagateMain.title.tree.category.set"/>","<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.pindagate.model.KmPindagateMainTemp" />"
	    );
	    
	    <%--问卷题目模板设置--%>
	    n2.AppendCV2Child("<bean:message key="kmPindagate.tree.question.template.set" bundle="km-pindagate" />",
			 "com.landray.kmss.km.pindagate.model.KmPindagateMainTemp",
			 "<c:url value="/km/pindagate/km_pindagate_main_temp/index.jsp?parentId=!{value}" />");
	 <kmss:authShow roles="ROLE_KMPINDAGATE_PARAMETER_CONFIG">
	  <%-- 导出Excel参数配置 --%>
		n3 = n2.AppendURLChild(
			"<bean:message key="kmPindagate.tree.parameter.config" bundle="km-pindagate" />",
			"<c:url value="/km/pindagate/km_pindagate_config/kmPindagateConfig.do?method=edit" />"
		);
	 <%-- 门户缓存参数配置 --%>
		n2.AppendURLChild(
		"<bean:message key="kmPindagate.tree.parameter.portal.config" bundle="km-pindagate" />",
		"<c:url value="/km/pindagate/km_pindagate_config/kmPindagateCacheConfig.do?method=edit&modelName=com.landray.kmss.km.pindagate.model.KmPindagateCacheConfig" />"
	   );
	   
       n2.AppendURLChild(
		"<bean:message key="kmPindagate.tree.list.config" bundle="km-pindagate" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.pindagate.model.KmPindagateMain"/>"
	   );
	</kmss:authShow>
    
     <%-- 文档维护 --%>
	  n2 = n1.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />");
	  n2.authType="01";
	<kmss:authShow roles="ROLE_KMPINDAGATE_OPTALL">
		n2.authRole="optAll";
	</kmss:authShow>
	
	 n2.AppendCategoryDataWithAdmin("com.landray.kmss.km.pindagate.model.KmPindagateTemplate",
	 "<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=manageList&categoryId=!{value}"/>",
	 "<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=listChildren&type=category&categoryId=!{value}"/>");
     
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
 </template:replace>
</template:include>