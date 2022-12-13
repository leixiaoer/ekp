<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.km.keydata.base" bundle="km-keydata-base"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5,defaultNode;
	n1 = LKSTree.treeRoot;
	
	<kmss:authShow roles="ROLE_KMCUSTOMER_MAINTAINER">
    
	n2 = n1.AppendChild("<bean:message key="table.kmCustomerMain" bundle="km-keydata-customer" />");
	n2.isExpanded = true;
	<%-- 客户 
	n3 = n2.AppendURLChild(
		"<bean:message key="table.kmCustomerMain" bundle="km-keydata-customer" />",
		"<c:url value="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=list&fdIsAvailable=true" />"
	);
	--%>
	//按类别
	defaultNode = n2.AppendURLChild(
		"<bean:message key="kmCustomerMain.all" bundle="km-keydata-customer" />",
		"<c:url value="/km/keydata/customer/km_customer_main/index.jsp?fdIsAvailable=true" />"
	
	);
	defaultNode.AppendSimpleCategoryData(
		"com.landray.kmss.km.keydata.customer.model.KmCustomerCategory",
		"<c:url value="/km/keydata/customer/km_customer_main/index.jsp?fdIsAvailable=true&categoryId=!{value}" />"
	);
	
	n2.AppendURLChild(
		"<bean:message key="kmCustomerMain.invalidate" bundle="km-keydata-customer" />",
		"<c:url value="/km/keydata/customer/km_customer_main/index.jsp?fdIsAvailable=false" />"
	
	);
	
	<kmss:auth requestURL="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.keydata.customer.model.KmCustomerCategory">
	//类别设置
	n3 = n2.AppendURLChild(
		"<bean:message bundle="km-keydata-customer" key="table.kmCustomerCategory"/>",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.keydata.customer.model.KmCustomerCategory&actionUrl=/km/keydata/customer/km_customer_category/kmCustomerCategory.do&formName=kmCustomerCategoryForm&mainModelName=com.landray.kmss.km.keydata.customer.model.KmCustomerMain&docFkName=kmCustomerCategory" />"
	);
	</kmss:auth>
	
	<kmss:authShow roles="ROLE_KMCUSTOMER_MAINTAINER,ROLE_KMKEYDATA_MAINTAINER">
     n3 = n2.AppendURLChild(
          "<bean:message bundle="sys-number" key="table.sysNumberMain"/>",
          "<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.keydata.customer.model.KmCustomerMain" />"
           );
    </kmss:authShow>
    
    <kmss:auth requestURL="/sys/transport/sys_transport_import/SysTransportImport.do?method=list&fdModelName=com.landray.kmss.km.keydata.customer.model.KmCustomerMain">
    n3 = n2.AppendURLChild(
          "<bean:message bundle="km-keydata-base" key="keydata.import.excel"/>",
          "<c:url value="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.km.keydata.customer.model.KmCustomerMain" />"
           );
    </kmss:auth>
	</kmss:authShow>
	
	<kmss:authShow roles="ROLE_KMPROJECT_MAINTAINER">
	n2 = n1.AppendChild("<bean:message key="table.kmProjectMain" bundle="km-keydata-project" />");
	n2.isExpanded = true;
	<%-- 项目 
	n3 = n2.AppendURLChild(
		"<bean:message key="table.kmProjectMain" bundle="km-keydata-project" />",
		"<c:url value="/km/keydata/project/km_project_main/kmProjectMain.do?method=list" />"
	);
	--%>
	//按类别
	n3 = n2.AppendURLChild(
		"<bean:message key="kmProjectMain.all" bundle="km-keydata-project" />",
		"<c:url value="/km/keydata/project/km_project_main/index.jsp?fdIsAvailable=true" />"
	
	);
	
	n3.AppendSimpleCategoryData(
		"com.landray.kmss.km.keydata.project.model.KmProjectCategory",
		"<c:url value="/km/keydata/project/km_project_main/index.jsp?fdIsAvailable=true&categoryId=!{value}" />"
	);
	
	
	n2.AppendURLChild(
		"<bean:message key="kmProjectMain.invalidate" bundle="km-keydata-project" />",
		"<c:url value="/km/keydata/project/km_project_main/index.jsp?fdIsAvailable=false" />"
	
	);
	
	<kmss:auth requestURL="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.keydata.project.model.KmProjectCategory">
	//类别设置
	n3 = n2.AppendURLChild(
		"<bean:message bundle="km-keydata-project" key="table.kmProjectCategory"/>",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.keydata.project.model.KmProjectCategory&actionUrl=/km/keydata/project/km_project_category/kmProjectCategory.do&formName=kmProjectCategoryForm&mainModelName=com.landray.kmss.km.keydata.project.model.KmProjectMain&docFkName=kmProjectCategory" />"
	);
	</kmss:auth>
	
	<kmss:authShow roles="ROLE_KMPROJECT_MAINTAINER,ROLE_KMKEYDATA_MAINTAINER">
     n3 = n2.AppendURLChild(
          "<bean:message bundle="sys-number" key="table.sysNumberMain"/>",
          "<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.keydata.project.model.KmProjectMain" />"
           );
    </kmss:authShow>
    
    <kmss:auth requestURL="/sys/transport/sys_transport_import/SysTransportImport.do?method=list&fdModelName=com.landray.kmss.km.keydata.project.model.KmProjectMain">
    n3 = n2.AppendURLChild(
          "<bean:message bundle="km-keydata-base" key="keydata.import.excel"/>",
          "<c:url value="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.km.keydata.project.model.KmProjectMain" />"
           );
	</kmss:auth>
	</kmss:authShow>
	
	
	<kmss:authShow roles="ROLE_KMSUPPLIER_MAINTAINER">
	n2 = n1.AppendChild("<bean:message key="table.kmSupplierMain" bundle="km-keydata-supplier" />");
	n2.isExpanded = true;
	<%-- 供应商
	n3 = n2.AppendURLChild(
		"<bean:message key="table.kmSupplierMain" bundle="km-keydata-supplier" />",
		"<c:url value="/km/keydata/supplier/km_supplier_main/kmSupplierMain.do?method=list&fdIsAvailable=true" />"
	);
	 --%>
	//按类别
	n3 = n2.AppendURLChild(
		"<bean:message key="kmSupplierMain.all" bundle="km-keydata-supplier" />",
		"<c:url value="/km/keydata/supplier/km_supplier_main/index.jsp?fdIsAvailable=true" />"
	
	);
	n3.AppendSimpleCategoryData(
		"com.landray.kmss.km.keydata.supplier.model.KmSupplierCategory",
		"<c:url value="/km/keydata/supplier/km_supplier_main/index.jsp?fdIsAvailable=true&categoryId=!{value}" />"
	);
	
	n3 = n2.AppendURLChild(
		"<bean:message key="kmSupplierMain.invalidate" bundle="km-keydata-supplier" />",
		"<c:url value="/km/keydata/supplier/km_supplier_main/index.jsp?fdIsAvailable=false" />"
	
	);
	
	<kmss:auth requestURL="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.keydata.supplier.model.KmSupplierCategory">
	//类别设置
	n3 = n2.AppendURLChild(
		"<bean:message bundle="km-keydata-supplier" key="table.kmSupplierCategory"/>",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.keydata.supplier.model.KmSupplierCategory&actionUrl=/km/keydata/supplier/km_supplier_category/kmSupplierCategory.do&formName=kmSupplierCategoryForm&mainModelName=com.landray.kmss.km.keydata.supplier.model.KmSupplierMain&docFkName=kmSupplierCategory" />"
	);
	</kmss:auth>
	
	<kmss:authShow roles="ROLE_KMSUPPLIER_MAINTAINER,ROLE_KMKEYDATA_MAINTAINER">
     n3 = n2.AppendURLChild(
          "<bean:message bundle="sys-number" key="table.sysNumberMain"/>",
          "<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.keydata.supplier.model.KmSupplierMain" />"
           );
    </kmss:authShow>
    
    <kmss:auth requestURL="/sys/transport/sys_transport_import/SysTransportImport.do?method=list&fdModelName=com.landray.kmss.km.keydata.supplier.model.KmSupplierMain">
    n3 = n2.AppendURLChild(
          "<bean:message bundle="km-keydata-base" key="keydata.import.excel"/>",
          "<c:url value="/sys/transport/sys_transport_import/index.jsp?fdModelName=com.landray.kmss.km.keydata.supplier.model.KmSupplierMain" />"
           );
     </kmss:auth>
     </kmss:authShow>  
     

   <kmss:auth requestURL="/km/keydata/base/kmKeydataPluginShow.do?method=list">
    n1.AppendURLChild(
          "<bean:message bundle="km-keydata-base" key="keydata.module.used"/>",
          "<c:url value="/km/keydata/base/index_plugin_show.jsp" />"
          );
<%--    
   	n1.AppendURLChild(
          "导入'关键数据'使用模块",
          "<c:url value="/km/keydata/base/kmKeydataPluginShow.do?method=importPluginShowData" />"
          );
--%>    
    </kmss:auth>    
	
	
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
window.onload = function(){
		if(window.parent){
			window.parent.document.title="<bean:message bundle="km-keydata-base" key="keydata.name"/>";
		}
		
	}
  </template:replace>
</template:include>