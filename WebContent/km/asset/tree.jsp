﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.km.asset" bundle="km-asset"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5,n31,n311,n41,n51;
	n1 = LKSTree.treeRoot;
	
	<%-- 资产卡片 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.kmAssetCard" bundle="km-asset" />" 
	);
	
	n2.AppendURLChild(
		"<bean:message key="kmAssetCard.page.all" bundle="km-asset" />",
		"<c:url value="/km/asset/km_asset_card/kmAssetCard.do?method=list" />"
	);
	
	n5 = n2.AppendURLChild(
		"<bean:message key="kmAssetCard.page.cate" bundle="km-asset" />"
	);
	<%-- &status=30&orderby=docPublishTime&ordertype=down--%>
	n51=n5.AppendSimpleCategoryData(
    	"com.landray.kmss.km.asset.model.KmAssetCategory",
    	"<c:url value="/km/asset/km_asset_card/kmAssetCard.do?method=listChildren&categoryId=!{value}" />"
    );
	
	
	<%-- 资产申请--%>
	n3 = n1.AppendURLChild(
		"<bean:message key="tree.kmAssetApply.rootName" bundle="km-asset" />" 
	);
	
	<%-- 所有申请单 --%>
	n3.AppendURLChild(
		"<bean:message key="table.kmAssetApplyBase.all" bundle="km-asset" />",
		"<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=listChildren&nodeType=CATEGORY" />"
	);
	
		//=========按类别=======
	n31 = n3.AppendURLChild(
		"<bean:message key="kmAssetApplyBase.byCategory" bundle="km-asset" />"
	);
    n31.AppendCategoryData(
    	"com.landray.kmss.km.asset.model.KmAssetApplyTemplate",
    	"<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=listChildren&categoryId=!{value}" />"
    );
    <%--我的资产申请--%>
    n31 = n3.AppendURLChild(
		"<bean:message key="tree.kmAssetApply.my" bundle="km-asset" /><bean:message key="tree.kmAssetApply.rootName" bundle="km-asset" />",
		"<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=list&mydoc=true" />"
	);
	n311 = n31.AppendURLChild(
		"<bean:message key="status.draft" />",
		"<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=list&mydoc=true&docStatus=10" />"
	);
	n311 = n31.AppendURLChild(
		"<bean:message key="status.examine" />",
		"<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=list&mydoc=true&docStatus=20" />"
	);	
	n311 = n31.AppendURLChild(
		"<bean:message key="status.refuse" />",
		"<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=list&mydoc=true&docStatus=11" />"
	);
	n311 = n31.AppendURLChild(
		"<bean:message key="status.discard"/>",
		"<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=list&mydoc=true&docStatus=00" />"
	);
	n311 = n31.AppendURLChild(
		"<bean:message key="status.publish" />",
		"<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=list&mydoc=true&docStatus=30" />"
	);
	
	<%-- 基础设置--%>
	n3 = n1.AppendURLChild(
		"<bean:message key="tree.baseSet.rootName" bundle="km-asset" />"
	);
	<kmss:authShow roles="ROLE_KMASSET_BASESET">
		<%-- 参数设置--%>
	n31 = n3.AppendURLChild(
		"<bean:message key="tree.baseSet.paramSet" bundle="km-asset" />" ,
		"<c:url value="/km/asset/km_asset_config/kmAssetConfig.do?method=edit" />"
	);
	</kmss:authShow>
	<%-- 资产类别 --%>
	n31 = n3.AppendURLChild(
		"<bean:message key="table.kmAssetCategory" bundle="km-asset" />",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetCategory&actionUrl=/km/asset/km_asset_category/kmAssetCategory.do&formName=kmAssetCategoryForm&mainModelName=com.landray.kmss.km.asset.model.KmAssetCard&docFkName=fdAssetCategory" />"
	);
	<kmss:authShow roles="ROLE_KMASSET_BASESET">
	n31 = n3.AppendURLChild(
		"<bean:message bundle="km-asset" key="table.kmAssetAddressCate"/>",
		"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetAddressCate&actionUrl=/km/asset/km_asset_address_cate/kmAssetAddressCate.do&formName=kmAssetAddressCateForm&mainModelName=com.landray.kmss.km.asset.model.KmAssetAddress&docFkName=fdAssetAddressCate" />"
	);
		<%-- 地点信息管理--%>
	n31 = n3.AppendURLChild(
		"<bean:message key="tree.baseSet.addressManage" bundle="km-asset" />",
		"<c:url value="/km/asset/km_asset_address/kmAssetAddress.do?method=list" />" 
	);
	</kmss:authShow>
	<%-- 供应商类别 --%>
	n31 = n3.AppendURLChild(
			"<bean:message key="table.kmProviderCategory" bundle="km-provider"/>",
			"<c:url value="/sys/simplecategory/sys_simple_category/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.provider.model.KmProviderCategory&actionUrl=/km/provider/km_provider_category/kmProviderCategory.do&formName=kmProviderCategoryForm&mainModelName=com.landray.kmss.km.provider.model.KmProviderMain&docFkName=docCategory" />"
	);
		<%-- 供应商管理--%>
    n31 = n3.AppendURLChild(
		"<bean:message key="table.kmProviderMain" bundle="km-provider" />",
    	"<c:url value="/km/provider/km_provider_main/kmProviderMain.do?method=list" />"
	);
		<%-- 无效供应商--%>
	n31 = n3.AppendURLChild(
		"<bean:message key="table.kmProviderMain.abandon" bundle="km-provider" />",
		"<c:url value="/km/provider/km_provider_main/kmProviderMain.do?method=list&fdIsAbandon=true" />"
	);
	
	<%-- 模块设置--%>
	n4 = n1.AppendURLChild(
		"<bean:message key="tree.modelSet.rootName" bundle="km-asset" />" 
	);
		<%-- 资产申请类别设置 --%>
	n41 = n4.AppendURLChild(
		"<bean:message key="table.kmAssetApplyCategory" bundle="km-asset" /><bean:message key="tree.set" bundle="km-asset" />",
		"<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyTemplate&mainModelName=com.landray.kmss.km.asset.model.KmAssetApplyBase&templateName=fdApplyTemplate&categoryName=docCategory&authReaderNoteFlag=2" />"
	);
		<%-- 资产申请模板 --%>
	n41 = n4.AppendCV2Child("<bean:message key="table.kmAssetApplyTemplate" bundle="km-asset" />",
		"com.landray.kmss.km.asset.model.KmAssetApplyTemplate",
		"<c:url value="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=listChildren&parentId=!{value}&ower=1" />");
	 
	 <kmss:authShow roles="ROLE_KMASSET_BASESET">
	 <%-- 编号机制 --%>
	n41=n4.AppendURLChild(
			"<bean:message key="tree.kmAssetApply.rootName" bundle="km-asset" /><bean:message bundle="sys-number" key="sysNumber.config.tree.numberMain"/>",
			"<c:url value="/sys/number/sys_number_main/sysNumberMain.do?method=list&modelName=com.landray.kmss.km.asset.model.KmAssetApplyBase" />"
		);
	n41=n4.AppendURLChild(
			"<bean:message key="table.kmAssetCard" bundle="km-asset" /><bean:message bundle="sys-number" key="sysNumber.config.tree.numberMain"/>",
			"<c:url value="/sys/number/sys_number_main/sysNumberMain.do?method=list&modelName=com.landray.kmss.km.asset.model.KmAssetCard" />"
		);
	</kmss:authShow>
		<%-- 搜索模块--%>
	n3 = n1.AppendURLChild(
		"<bean:message key="button.search" />" 
	);
	<%--资产卡片搜索--%>
    n31=n3.AppendURLChild(
	"<bean:message bundle="km-asset" key="kmAssetCard.search"/>",
	"<c:url value="/sys/search/search.do?method=condition&fdModelName=com.landray.kmss.km.asset.model.KmAssetCard"/>"
	);
	
	<%--申请单搜索--%>
    n31=n3.AppendURLChild(
	"<bean:message bundle="km-asset" key="kmAssetApplyBase.search"/>",
	"<c:url value="/sys/search/search.do?method=condition&fdModelName=com.landray.kmss.km.asset.model.KmAssetApplyBase"/>"
	);
		
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp" %>