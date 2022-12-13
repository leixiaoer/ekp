<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/tree.jsp">
    <template:replace name="content">
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.km.asset" bundle="km-asset"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5,n31,n311,n41,n51,defaultNode;
	n1 = LKSTree.treeRoot;
	
	<%-- 基础设置--%>
	n3 = n1.AppendURLChild(
		"<bean:message key="tree.baseSet.rootName" bundle="km-asset" />"
	);
	n3.isExpanded = true;
	<kmss:authShow roles="ROLE_KMASSET_BASESET">
		<%-- 参数设置--%>
	n31 = n3.AppendURLChild(
		"<bean:message key="tree.baseSet.paramSet" bundle="km-asset" />" ,
		"<c:url value="/km/asset/km_asset_config/kmAssetConfig.do?method=edit" />"
	);
	
	</kmss:authShow>
	<%-- 资产类别 --%>
	defaultNode = n3.AppendURLChild(
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
		"<c:url value="/km/asset/km_asset_address/index.jsp" />" 
	);
	n31.AppendSimpleCategoryData(
		"com.landray.kmss.km.asset.model.KmAssetAddressCate",
		"<c:url value="/km/asset/km_asset_address/index.jsp?categoryId=!{value}" />"
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
    	"<c:url value="/km/provider/km_provider_main/index.jsp" />"
	);
	n31.AppendSimpleCategoryData(
		"com.landray.kmss.km.provider.model.KmProviderCategory",
		"<c:url value="/km/provider/km_provider_main/index.jsp?categoryId=!{value}" />"
	);	
	n31 = n3.AppendURLChild(
		"<bean:message key="sysListShow.setting" bundle="km-asset" />"
	);
	n31.AppendURLChild(
		"<bean:message key="tree.kmAssetApply.rootName" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyBase"/>"
	);
	n31.AppendURLChild(
		"<bean:message key="kmAssetApplyDivertList.fdAssetCard" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetCard"/>"
	);
	n31.AppendURLChild(
		"<bean:message key="table.kmAssetApplyInventory" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyInventory"/>"
	);
	n31.AppendURLChild(
		"<bean:message key="kmAsset.tree.task" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyTask"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.buy" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyBuy"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.getAndreturn.get" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyGet"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.getAndreturn.return" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyReturn"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.stockAndin.stock" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyStock"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.stockAndin.in" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyIn"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.rentAnddivert.rent" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyRent"/>"
	);
	
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.rentAnddivert.divert" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyDivert"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.repair.list" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyRepair"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.changeAnddeal.change" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyChange"/>"
	);
		n31.AppendURLChild(
		"<bean:message key="kmAsset.nav.changeAnddeal.deal" bundle="km-asset" />",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyDeal"/>"
	);
	
	<%-- 模块设置--%>
	n4 = n1.AppendURLChild(
		"<bean:message key="tree.modelSet.rootName" bundle="km-asset" />" 
	);
	n4.isExpanded = true;
		<%-- 资产申请类别设置--%>
	n41 = n4.AppendURLChild(
		"<bean:message key="table.kmAssetApplyCategory" bundle="km-asset" /><bean:message key="tree.set" bundle="km-asset" />",
		"<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyTemplate&mainModelName=com.landray.kmss.km.asset.model.KmAssetApplyBase&templateName=fdApplyTemplate&categoryName=docCategory&authReaderNoteFlag=2" />"
	);
		<%-- 资产申请模板 --%>
	n41 = n4.AppendCV2Child("<bean:message key="table.kmAssetApplyTemplate" bundle="km-asset" />",
		"com.landray.kmss.km.asset.model.KmAssetApplyTemplate",
		"<c:url value="/km/asset/km_asset_apply_template/index.jsp?parentId=!{value}&ower=1" />");
	 
	 <kmss:authShow roles="ROLE_KMASSET_BASESET">
	 <%-- 编号机制 --%>
	n41=n4.AppendURLChild(
			"<bean:message key="tree.kmAssetApply.rootName" bundle="km-asset" /><bean:message bundle="sys-number" key="sysNumber.config.tree.numberMain"/>",
			"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyBase" />"
		);
	n41=n4.AppendURLChild(
			"<bean:message key="table.kmAssetCard" bundle="km-asset" /><bean:message bundle="sys-number" key="sysNumber.config.tree.numberMain"/>",
			"<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetCard" />"
		);
	</kmss:authShow>
	
	<%-- 文档维护 --%>
	n5 = n1.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />");
	
	<%-- 资产申请--%>
	n51 = n5.AppendURLChild("<bean:message key="tree.kmAssetApply.rootName" bundle="km-asset" />");
	n51.authType="01";
	<kmss:authShow roles="ROLE_KMASSET_OPTALL">
		n51.authRole="optAll";
	</kmss:authShow>
	n51.AppendCategoryDataWithAdmin("com.landray.kmss.km.asset.model.KmAssetApplyTemplate","<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=manageList&categoryId=!{value}"/>","<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=listChildren&categoryId=!{value}"/>");
	
	<%-- 资产卡片--%>
	n51 = n5.AppendURLChild("<bean:message key="table.kmAssetCard" bundle="km-asset" />");
	n51.authType="01";
	<kmss:authShow roles="ROLE_KMASSET_OPTALL">
		n51.authRole="optAll";
	</kmss:authShow>
	n51.AppendSimpleCategoryDataWithAdmin ("com.landray.kmss.km.asset.model.KmAssetCategory","<c:url value="/km/asset/km_asset_card/kmAssetCard.do?method=manageList&categoryId=!{value}"/>","<c:url value="/km/asset/km_asset_card/kmAssetCard.do?method=listChildren&categoryId=!{value}&type=category" />");	
			
	LKSTree.EnableRightMenu();
	LKSTree.Show();
	LKSTree.ClickNode(defaultNode);
}
</template:replace>
</template:include>