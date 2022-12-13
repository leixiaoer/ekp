<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.fssc.base.util.FsscBaseAuthUtil"%>
<%
	String fdCompanyId=request.getParameter("fdCompanyId");
	request.setAttribute("staffManagerList", FsscBaseAuthUtil.getFinanceStaffAndManagerList(fdCompanyId));
%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"${lfn:message('fssc-base:tree.baseInfo') }",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	<%--财务组织 --%>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ORG;ROLE_FSSCBASE_FINANCIAL_ORG" extendOrgElements="${staffManagerList}">
	n2 = n1.AppendURLChild(
		"${lfn:message('fssc-base:fssc.base.financial.organization')}"
	);
	<%--成本中心类型 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseCostType" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_cost_type/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--成本中心 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseCostCenter" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseCostCenter" />"
	);
	<%--ERP人员 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseErpPerson" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_erp_person/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	LKSTree.ExpandNode(n2);
	</kmss:authShow>
	<%--财务档案 --%>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ARCHIVES;ROLE_FSSCBASE_SUPPLIER" extendOrgElements="${staffManagerList}">
	n2 = n1.AppendURLChild(
		"${lfn:message('fssc-base:fssc.base.financial.archives')}"
	);
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ARCHIVES" extendOrgElements="${staffManagerList}">
	<%-- 是否开启下发  选择是 --%>
	<fssc:switchOn property="fdIsOpenIssued">
	<%--会计科目(公司) --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseAccountsCom" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&can=false&isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseAccountsCom" />"
	); --%>
	<%--预算科目(公司) --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseBudgetItemCom" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&can=false&isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseBudgetItemCom" />"
	);
	</fssc:switchOn>
	<%-- 是否开启下发  选择否 --%>
	<fssc:switchOff property="fdIsOpenIssued">
	<%--会计科目(公司) --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseAccountsCom" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseAccountsCom" />"
	); --%>
	<%--预算科目(公司) --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseBudgetItemCom" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseBudgetItemCom" />"
	);
	</fssc:switchOff>
	<%--项目 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseProject" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseProject" />"
	); --%>
	<fssc:configEnabled property="fdFinancialSystem" value="SAP">
	<%--内部订单 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseInnerOrder" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseInnerOrder" />"
	); --%>
	<%--WBS --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseWbs" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_wbs/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	</fssc:configEnabled>
	</kmss:authShow>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_SUPPLIER;ROLE_FSSCBASE_FINANCIAL_ARCHIVES" extendOrgElements="${staffManagerList}">
	<%--客商--%>
	<%-- n3 = n2.AppendURLChild(
		"${lfn:message('fssc-base:table.fsscBaseSupplier')}",
		"<c:url value="/fssc/base/fssc_base_supplier/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	</kmss:authShow>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_FINANCIAL_ARCHIVES" extendOrgElements="${staffManagerList}">
	<%--凭证类型 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseVoucherType" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_voucher_type/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--币种/汇率 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseExchangeRate" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_exchange_rate/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	);
	<%--现金流量项目 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseCashFlow" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseCashFlow" />"
	); --%>
	<%--付款方式--%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBasePayWay" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_pay_way/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--付款银行 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBasePayBank" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_pay_bank/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--税率 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseTaxRate" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_tax_rate/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	</kmss:authShow>
	LKSTree.ExpandNode(n2);
	</kmss:authShow>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_EXPENSEITEM;ROLE_FSSCBASE_BUDGET_CONTROL" extendOrgElements="${staffManagerList}">
	<%--费用类型 --%>
	n2 = n1.AppendURLChild(
		"${lfn:message('fssc-base:fssc.base.financial.expense.item')}"
	);
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_EXPENSEITEM" extendOrgElements="${staffManagerList}">
	<%--费用类型 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseExpenseItem" bundle="fssc-base" />",
		"<c:url value="/fssc/base/resource/jsp/tree.jsp?use=true&isValidity=1&companyId=${param.fdCompanyId}&modelName=com.landray.kmss.fssc.base.model.FsscBaseExpenseItem" />"
	);
	</kmss:authShow>
	<%--费用类型-显示字段维护(暂时隐藏) --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseItemField" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_item_field/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_EXPENSEITEM;ROLE_FSSCBASE_BUDGET_CONTROL" extendOrgElements="${staffManagerList}">
	<%--费用类型-预算控制维护 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseItemBudget" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_item_budget/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	</kmss:authShow>
	<kmss:authShow roles="ROLE_FSSCBASE_COMPANY_DATA;ROLE_FSSCBASE_EXPENSEITEM" extendOrgElements="${staffManagerList}">
	<fssc:checkVersion version="true">
	<%--费用类型-会计科目维护 --%>
	<%-- n3 = n2.AppendURLChild(
	"<bean:message key="table.fsscBaseItemAccount" bundle="fssc-base" />",
	"<c:url value="/fssc/base/fssc_base_item_account/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	</fssc:checkVersion>
	<%--费用类型-进项税率 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseInputTax" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_input_tax/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	</kmss:authShow>
	<fssc:checkVersion version="false">
	<%--地域 --%>
	n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseArea" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_area/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	);
	</fssc:checkVersion>
	LKSTree.ExpandNode(n2);
	</kmss:authShow>
	<fssc:checkVersion version="true">
	<kmss:authShow roles="ROLE_FSSCBASE_STANDAR;ROLE_FSSCBASE_COMPANY_DATA" extendOrgElements="${staffManagerList}">
	<%--费用标准--%>
	<%-- n2 = n1.AppendURLChild(
		"${lfn:message('fssc-base:fssc.base.financial.expense.standar')}"
	); --%>
	
	<%--标准方案 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseStandardScheme" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_standard_scheme/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--地域 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseArea" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_area/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--职级 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseLevel" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_level/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--交通工具 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseVehicle" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_vehicle/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--舱位 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseBerth" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_berth/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--特殊事项 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseSpecialItem" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_special_item/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	<%--费用标准数据 --%>
	<%-- n3 = n2.AppendURLChild(
		"<bean:message key="table.fsscBaseStandard" bundle="fssc-base" />",
		"<c:url value="/fssc/base/fssc_base_standard/index.jsp?isValidity=1&fdCompanyId=${param.fdCompanyId}" />"
	); --%>
	LKSTree.ExpandNode(n2);
	</kmss:authShow>
	</fssc:checkVersion>
	LKSTree.EnableRightMenu();
		LKSTree.Show();
		
}
<%@ include file="/resource/jsp/tree_down.jsp" %>