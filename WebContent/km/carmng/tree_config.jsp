<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="kmCarmng.tree.title" bundle="km-carmng"/>",
		document.getElementById("treeDiv")
	);
	var  n2,n3,defaultNode;
	n2 = LKSTree.treeRoot;
	
	<kmss:authShow roles="ROLE_KMCARMNG_DEFAULT">
	
	//基础设置
	//n2 = n1.AppendURLChild("<bean:message key="kmCarmng.tree.base.set" bundle="km-carmng"/>");
	
	//车队设置
	defaultNode = n2.AppendURLChild("<bean:message key="kmCarmng.tree.base.set1" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_motorcade_set/index.jsp" />");
	
	</kmss:authShow>
	
	<kmss:authShow roles="ROLE_KMCARMNG_CARMANAGE">
	//车辆信息
	n2.AppendURLChild(
		"<bean:message key="kmCarmngInfomation.all" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_info_ui/index2.jsp" />"
	);
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KMCARMNG_SETTING">
		n3 = n2.AppendURLChild(
			"<bean:message bundle="sys-number" key="table.sysNumberMain"/>",
			"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.carmng.model.KmCarmngApplication" />"
		);
	
	//驾驶员信息
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.base.set2" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_drivers_info/index.jsp" />"
	);
	//车辆类别
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.base.set3" bundle="km-carmng"/>",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.carmng.model.KmCarmngCategory&actionUrl=/km/carmng/km_carmng_category/kmCarmngCategory.do&formName=kmCarmngCategoryForm&mainModelName=com.landray.kmss.km.carmng.model.KmCarmngInfomation&docFkName=fdVehichesType" />"
	);
	//通用流程模板
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.base.set4" bundle="km-carmng"/>",
	"<c:url value="/sys/lbpmservice/support/lbpm_template/index.jsp?fdModelName=com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet&fdKey=kmCarmngMotorcadeSet" />"
	); 
	<!-- "列表显示设置", -->
	n2.AppendURLChild(
		 "<bean:message key="sys.profile.list.display.config" bundle="sys-profile"/>",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.carmng.model.KmCarmngApplication"/>"
	);
	</kmss:authShow>
	n3 = n2.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />")
	<!-- 违章信息 -->
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.car.information3" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=list&docStatus=10&myDoc=true" />"	
	);
	<!-- 保险信息 -->
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.car.information4" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=list&docStatus=10&myDoc=true" />"	
	);
	<!-- 保养信息 -->
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.car.information5" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=list&docStatus=10&myDoc=true" />"	
	);
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
 </template:replace>
</template:include>