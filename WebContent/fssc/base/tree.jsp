<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.fssc.base.util.FsscBaseAuthUtil"%>
<%
	request.setAttribute("staffManagerList", FsscBaseAuthUtil.getFinanceStaffAndManagerList(null));
%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<template:include ref="config.tree">
<template:replace name="content">
function generateTree()
{
    window.LKSTree = new TreeView( 
        'LKSTree',
        
        '${ lfn:message("fssc-base:module.fssc.base") }',//根节点的名称
        document.getElementById('treeDiv')
    );
    var node = LKSTree.treeRoot; 
    <%-- 公共信息设置  --%>
    node1 = node.AppendURLChild("${lfn:message('fssc-base:fssc.base.public.message')}");
    <%-- 开关设置  --%>
    <kmss:auth requestURL="/fssc/base/fssc_base_switch/fsscBaseSwitch.do?method=view">
    node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseSwitch')}",
		"<c:url value="/fssc/base/fssc_base_switch/fsscBaseSwitch.do?method=modifySwitch"/>"
	);
	</kmss:auth>
	<%-- 员工账户  --%>
    <%-- node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseAccount')}",
		"<c:url value="/fssc/base/fssc_base_account/index.jsp"/>"
	); --%>
	<%-- 员工护照  --%>
	<kmss:ifModuleExist path="/fssc/ctrip/">
	<%-- node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBasePassport')}",
		"<c:url value="/fssc/base/fssc_base_passport/index.jsp"/>"
	); --%>
	</kmss:ifModuleExist>
	<%-- 提单转授权  --%>
	<%-- node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseAuthorize')}",
		"<c:url value="/fssc/base/fssc_base_authorize/index.jsp"/>"
	); --%>
	<fssc:checkVersion version="true">
	<%-- 货币  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_CURRENCY">
    <%-- node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseCurrency')}",
		"<c:url value="/fssc/base/fssc_base_currency/index.jsp"/>"
	); --%>
	</kmss:authShow>
	</fssc:checkVersion>
	<fssc:checkVersion version="false">
	<%-- 货币  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_CURRENCY">
    node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseCurrency')}",
		"<c:url value="/fssc/base/fssc_base_currency/fsscBaseCurrency.do?method=addOrEdit"/>"
	);
	</kmss:authShow>
	</fssc:checkVersion>
	<%-- 是否开启下发  选择是 --%>
	<fssc:switchOn property="fdIsOpenIssued">
	<%-- 开关设置中选择了列表展现 --%>
	<fssc:switchOn property="fdShowType">
	<%-- 会计科目(公共)  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_ACCOUNTS">
    <%-- node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseAccounts')}",
		"<c:url value="/fssc/base/fssc_base_accounts/index.jsp"/>"
	); --%>
	</kmss:authShow>
	<%-- 预算科目(公共)  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_BUDGETITEM">
    node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseBudgetItem')}",
		"<c:url value="/fssc/base/fssc_base_budget_item/index.jsp"/>"
	);
	</kmss:authShow>
	</fssc:switchOn>
	
	<%-- 开关设置中选择了树形展现 --%>
	<fssc:switchOff property="fdShowType">
	<%-- 会计科目(公共)  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_ACCOUNTS">
    n<%-- ode2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseAccounts')}",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&modelName=com.landray.kmss.fssc.base.model.FsscBaseAccounts"/>"
	); --%>
	</kmss:authShow>
	<%-- 预算科目(公共)  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_BUDGETITEM">
    node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseBudgetItem')}",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&modelName=com.landray.kmss.fssc.base.model.FsscBaseBudgetItem"/>"
	);
	</kmss:authShow>
	</fssc:switchOff>
	</fssc:switchOn>
	<%-- 预算方案  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_BUDGETSCHEME">
    node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseBudgetScheme')}",
		"<c:url value="/fssc/base/fssc_base_budget_scheme/index.jsp"/>"
	);
	</kmss:authShow>
	<fssc:checkVersion version="true">
	<kmss:ifModuleExist path="/fssc/purch/">
	<%-- 物资类别  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_PURCHER">
    <%-- node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseMaterialType')}",
		"<c:url value="/fssc/base/fssc_base_material_type/index.jsp"/>"
	); --%>
	<%-- 物资信息  --%>
	<%-- node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseMaterialInfo')}",
		"<c:url value="/fssc/base/fssc_base_material_info/index.jsp"/>"
	); --%>
	</kmss:authShow>
	</kmss:ifModuleExist>
	</fssc:checkVersion>
	<fssc:checkVersion version="true">
	<fssc:switchOn property="fdCompanyGroup">
	<%-- 公司组  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANYGROUP">
    node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseCompanyGroup')}",
		"<c:url value="/fssc/base/fssc_base_company_group/index.jsp"/>"
	);
	</kmss:authShow>
	</fssc:switchOn>
	</fssc:checkVersion>
	<%-- 公司  --%>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY;ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ORG;ROLE_FSSCBASE_FINANCIAL_ARCHIVES;ROLE_FSSCBASE_SUPPLIER;ROLE_FSSCBASE_EXPENSEITEM;ROLE_FSSCBASE_BUDGET_CONTROL;ROLE_FSSCBASE_STANDAR">
    node2 = node1.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseCompany')}",
		"<c:url value="/fssc/base/fssc_base_company/index.jsp"/>"
	);
	</kmss:authShow>
	<%-- 开关设置中未选择展现方式或选择了树形展现 --%>
	<fssc:switchOff property="fdShowType">
	<kmss:authShow roles="ROLE_FSSCBASE_ACCOUNTS;ROLE_FSSCBASE_BUDGETITEM;ROLE_FSSCBASE_COMPANY;ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ORG;ROLE_FSSCBASE_FINANCIAL_ARCHIVES;ROLE_FSSCBASE_SUPPLIER;ROLE_FSSCBASE_EXPENSEITEM;ROLE_FSSCBASE_BUDGET_CONTROL;ROLE_FSSCBASE_STANDAR">
	<%-- 记账公司相关基础数据 --%>
	node1 = node.AppendURLChild(
		"${lfn:message('fssc-base:message.tree.companyInfo')}",
		"");
	<!-- 各个记账公司 -->
	node2 = node1.AppendBeanData(
		"fsscBaseCompanyTreeService&FinaceFlag=true&parentId=!{value}",
		new Array("<c:url value="/fssc/base/baseTree.jsp?fdCompanyId=!{value}"/>",2)
	);
	</kmss:authShow>
	</fssc:switchOff>
	<%-- 开关设置中选择了列表展现 --%>
	<fssc:switchOn property="fdShowType">
	var n1,n3,n2;
	<%--财务组织 --%>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ORG" extendOrgElements="${staffManagerList}">
	n2 = node.AppendURLChild(
		"${lfn:message('fssc-base:fssc.base.financial.organization')}"
	);
	<%--成本中心类型 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseCostType" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_cost_type/index.jsp?isValidity=1" />"
	); --%>
	<%--成本中心 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseCostCenter" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_cost_center/index.jsp" />"
	);
	<%--ERP人员 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseErpPerson" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_erp_person/index.jsp" />"
	); --%>
	LKSTree.ExpandNode(n2);
	</kmss:authShow>
	<%--财务档案 --%>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ARCHIVES;ROLE_FSSCBASE_SUPPLIER"  extendOrgElements="${staffManagerList}">
	n2 = node.AppendURLChild(
		"${lfn:message('fssc-base:fssc.base.financial.archives')}"
	);
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ARCHIVES"  extendOrgElements="${staffManagerList}">
	<%--会计科目(公司) --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseAccountsCom" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_accounts_com/index.jsp" />"
	); --%>
	<%--预算科目(公司) --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseBudgetItemCom" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_budget_item_com/index.jsp" />"
	);
	<%--项目 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseProject" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_project/index.jsp" />"
	); --%>
	<fssc:configEnabled property="fdFinancialSystem" value="SAP">
	<%--内部订单 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseInnerOrder" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_inner_order/index.jsp" />"
	); --%>
	<%--WBS --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseWbs" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_wbs/index.jsp" />"
	); --%>
	</fssc:configEnabled>
	</kmss:authShow>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_SUPPLIER;ROLE_FSSCBASE_FINANCIAL_ARCHIVES"  extendOrgElements="${staffManagerList}">
	<%--客商--%>
	<%-- n3 = n2.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseSupplier')}",
		"<c:url value="/fssc/base/fssc_base_supplier/index.jsp" />"
	); --%>
	</kmss:authShow>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ARCHIVES"  extendOrgElements="${staffManagerList}">
	<%--凭证类型 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseVoucherType" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_voucher_type/index.jsp" />"
	); --%>
	<%--币种/汇率 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseExchangeRate" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_exchange_rate/index.jsp" />"
	);
	<%--现金流量项目 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseCashFlow" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_cash_flow/index.jsp" />"
	); --%>
	<%--付款方式--%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBasePayWay" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_pay_way/index.jsp" />"
	); --%>
	<%--付款银行 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBasePayBank" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_pay_bank/index.jsp" />"
	); --%>
	<%--税率 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseTaxRate" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_tax_rate/index.jsp" />"
	); --%>
	</kmss:authShow>
	LKSTree.ExpandNode(n2);
	</kmss:authShow>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_EXPENSEITEM;ROLE_FSSCBASE_BUDGET_CONTROL"  extendOrgElements="${staffManagerList}">
	<%--费用类型 --%>
	n2 = node.AppendURLChild(
		"${lfn:message('fssc-base:fssc.base.financial.expense.item')}"
	);
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_EXPENSEITEM"  extendOrgElements="${staffManagerList}">
	<%--费用类型 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseExpenseItem" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_expense_item/index.jsp" />"
	);
	</kmss:authShow>
	<%--费用类型-显示字段维护(暂时隐藏) --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseItemField" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_item_field/index.jsp" />"
	); --%>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_EXPENSEITEM;ROLE_FSSCBASE_BUDGET_CONTROL"  extendOrgElements="${staffManagerList}">
	<%--费用类型-预算控制维护 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseItemBudget" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_item_budget/index.jsp" />"
	);
	</kmss:authShow>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_EXPENSEITEM"  extendOrgElements="${staffManagerList}">
	<fssc:checkVersion version="true">
	<%--费用类型-会计科目维护 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseItemAccount" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_item_account/index.jsp" />"
	); --%>
	</fssc:checkVersion>
	<%--费用类型-进项税率 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseInputTax" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_input_tax/index.jsp" />"
	); --%>
	<fssc:checkVersion version="false">
	<%--地域 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseArea" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_area/index.jsp" />"
	);
	</fssc:checkVersion>
	</kmss:authShow>
	LKSTree.ExpandNode(n2);
	</kmss:authShow>
	<fssc:checkVersion version="true">
	<%--费用标准--%>
	<kmss:authShow roles="ROLE_FSSCBASE_STANDAR;ROLE_FSSCBASE_COMPANY_DATA"  extendOrgElements="${staffManagerList}">
	<%-- n2 = node.AppendURLChild(
		"${lfn:message('fssc-base:fssc.base.financial.expense.standar')}"
	); --%>
	
	<%--标准方案 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseStandardScheme" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_standard_scheme/index.jsp" />"
	); --%>
	<%--地域 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseArea" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_area/index.jsp" />"
	); --%>
	<%--职级 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseLevel" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_level/index.jsp" />"
	); --%>
	<%--交通工具 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseVehicle" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_vehicle/index.jsp" />"
	); --%>
	<%--舱位 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseBerth" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_berth/index.jsp" />"
	); --%>
	<%--特殊事项 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseSpecialItem" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_special_item/index.jsp" />"
	); --%>
	<%--费用标准数据 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseStandard" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_standard/index.jsp" />"
	); --%>
	
	LKSTree.ExpandNode(n2);
	</kmss:authShow>
	</fssc:checkVersion>
	</fssc:switchOn>
    LKSTree.Show();
}
</template:replace>
</template:include>