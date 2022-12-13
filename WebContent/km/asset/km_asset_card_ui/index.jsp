<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.list"  spa="true" rwd="true">
<template:replace name="title">${ lfn:message('km-asset:module.km.asset') }</template:replace>
	<template:replace name="head">
		<script type="text/javascript">
				seajs.use(['theme!list','theme!module']);	
			</script>
			<style>
				.lui_tabpanel_list_navs_item_l{
				    max-width: 20%!important;
				}
			</style>
	</template:replace>
	<template:replace name="nav">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<ui:combin ref="menu.nav.title">
				<ui:varParam name="operation">
				<ui:source type="Static">
				[
					{
						"text": "${lfn:message('km-asset:kmAssetCard.my') }",
						"href": "/kmAssetCard_my",
						"router" : true,
						"icon": "lui_iconfont_navleft_asset_myasset"
					},
					{
						"text": "${lfn:message('km-asset:kmAssetApply.my') }",
						"href": "/kmAssetApply_my",
						"router" : true,
						"icon": "lui_iconfont_navleft_asset_myapply"
					},
					{
						"text": "${lfn:message('km-asset:kmAsset.task.my') }",
						"href": "/kmAssetApplyTask_my",
						"router" : true,
						"icon": "lui_iconfont_navleft_asset_mytask"
					},
					{
						"text": "${lfn:message('km-asset:kmAsset.inventory.my') }",
						"href": "/kmAssetInventory_my",
						"router" : true,
						"icon": "lui_iconfont_navleft_asset_myinventory"
					}
					
				]
				</ui:source>
			</ui:varParam>
		</ui:combin>
		<div id="menu_nav" class="lui_list_nav_frame">
			<ui:accordionpanel>
				<ui:content title="${ lfn:message('km-asset:tree.kmAssetApply.rootName') }" expand="true" style="padding-bottom:0;">
					 	<ui:combin ref="menu.nav.simple">
		  					<ui:varParam name="source">
		  						<ui:source type="Static">
				  					[{
				  						"text" : "${lfn:message('km-asset:kmAsset.buy') }",
				  						"href" :  "/kmAsset_buy",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_buy"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.getAndreturn.get') }",
				  						"href" :  "/kmAsset_get",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_get"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.getAndreturn.return') }",
				  						"href" :  "/kmAsset_return",
					  					"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_return"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.stockAndin.stock') }",
				  						"href" :  "/kmAsset_stock",
					  					"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_stock"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.stockAndin.in') }",
				  						"href" :  "/kmAsset_in",
					  					"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_in"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.rentAnddivert.rent') }",
				  						"href" :  "/kmAsset_rent",
					  					"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_rent"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.rentAnddivert.divert') }",
				  						"href" :  "/kmAsset_divert",
					  					"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_divert"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.repair.list') }",
				  						"href" :  "/kmAsset_repair",
					  					"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_repair"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.changeAnddeal.change') }",
				  						"href" :  "/kmAsset_change",
					  					"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_change"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.nav.changeAnddeal.deal') }",
				  						"href" :  "/kmAsset_deal",
					  					"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_deal"
				  					}]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>
				</ui:content>
				<ui:content title="${ lfn:message('km-asset:table.kmAssetApplyInventory') }" expand="false" style="padding-bottom:0;">
					 	<ui:combin ref="menu.nav.simple">
		  					<ui:varParam name="source">
		  						<ui:source type="Static">
				  					[{
				  						"text" : "${ lfn:message('km-asset:table.kmAssetCard') }",
				  						"href" :  "/kmAsset_bank",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_bank"
				  					},{
				  						"text" : "${lfn:message('km-asset:kmAsset.task') }",
				  						"href" :  "/kmAsset_task",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_task"
				  					},{
				  						"text" : "${lfn:message('km-asset:table.kmAssetApplyInventory') }",
				  						"href" :  "/kmAsset_inventory",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_asset_applyInventory"
				  					}]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>
				</ui:content>
				<ui:content title="${ lfn:message('list.otherOpt') }" expand="false" style="padding-bottom:0;">
					 	<ui:combin ref="menu.nav.simple">
		  					<ui:varParam name="source">
		  						<ui:source type="Static">
				  					[{
				  						"text" : "${lfn:message('km-asset:kmAsset.abandom') }",
				  						"href" :  "/kmAsset_abandom",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_com_discard"
				  					}
				  					<kmss:authShow roles="ROLE_KMASSET_BACKSTAGE_MANAGER">
				  					,{
				  						"text" : "${ lfn:message('list.manager') }",
				  						"href" :  "${LUI_ContextPath }/sys/profile/index.jsp#app/ekp/km/asset",
					  					"icon" : "lui_iconfont_navleft_com_background"
				  					}
				  					</kmss:authShow>
				  					]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>
				</ui:content>
			</ui:accordionpanel>
		</div>
	</template:replace>
	<template:replace name="content">
	<div style="width:100%;">
		  <ui:tabpanel id="kmAssetPanel" layout="sys.ui.tabpanel.list"  cfg-router="true">
		 <ui:content id="kmAssetApplyCardContent"  title="${lfn:message('km-asset:kmAsset.bank') }" cfg-route="{path:'/kmAssetCard_my'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_card_ui/kmAssetApplyCard_base.jsp"></ui:iframe>
		  </ui:content>
		 <ui:content id="kmAssetApplyCreateContent"  title="${lfn:message('km-asset:kmAssetApply.create.my') }" cfg-route="{path:'/kmAssetApply_my/create'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kmAssetApplyApprovalContent"  title="${lfn:message('km-asset:kmAssetApply.approval.my') }" cfg-route="{path:'/kmAssetApply_my/approval'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kmAssetApplyApprovedContent"  title="${lfn:message('km-asset:kmAssetApply.approved.my') }" cfg-route="{path:'/kmAssetApply_my/approved'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kmAssetApplyDraftsContent"  title="${lfn:message('km-asset:kmAsset.drafts') }" cfg-route="{path:'/kmAssetApply_my/drafts'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kmAssetApplyCreateTaskContent" title="${lfn:message('km-asset:kmAssetApply.create.my') }" cfg-route="{path:'/kmAssetApplyTask_my/create'}">
		 	  <ui:iframe  src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kmAssetApplyApprovalTaskContent" title="${lfn:message('km-asset:kmAssetApply.approval.my') }" cfg-route="{path:'/kmAssetApplyTask_my/approval'}">
		 	  <ui:iframe  src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kmAssetApplyApprovedTaskContent" title="${lfn:message('km-asset:kmAssetApply.approved.my') }" cfg-route="{path:'/kmAssetApplyTask_my/approved'}">
		 	  <ui:iframe  src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kmAssetApplyDraftsTaskContent" title="${lfn:message('km-asset:kmAsset.drafts') }" cfg-route="{path:'/kmAssetApplyTask_my/drafts'}">
		 	  <ui:iframe  src="${LUI_ContextPath }/km/asset/km_asset_apply_task/kmAssetApplyTask_new.jsp"></ui:iframe>
		  </ui:content>
		  <ui:content id="kAssetApplyCreateInventoryContent"  title="${lfn:message('km-asset:kmAssetApply.create.my') }"  cfg-route="{path:'/kmAssetInventory_my/create'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_apply_inventory/index.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kAssetApplyApprovalInventoryContent"  title="${lfn:message('km-asset:kmAssetApply.approval.my') }"  cfg-route="{path:'/kmAssetInventory_my/approval'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_apply_inventory/index.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kAssetApplyApprovedInventoryContent"  title="${lfn:message('km-asset:kmAssetApply.approved.my') }"  cfg-route="{path:'/kmAssetInventory_my/approved'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_apply_inventory/index.jsp"></ui:iframe>
		  </ui:content>
		   <ui:content id="kAssetApplyDraftsInventoryContent"  title="${lfn:message('km-asset:kmAsset.drafts') }"  cfg-route="{path:'/kmAssetInventory_my/drafts'}">
		 	  <ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_apply_inventory/index.jsp"></ui:iframe>
		  </ui:content>
		  <ui:content id="abandomCard" title="${lfn:message('km-asset:kmAsset.abandom.card') }" cfg-route="{path:'/kmAsset_abandom/abandomCard'}">
		 	  <ui:iframe  src="${LUI_ContextPath }/km/asset/km_asset_card_ui/kmAssetApplyCard_base.jsp"></ui:iframe>
		  </ui:content>
		  <ui:content id="abandomApply" title="${lfn:message('km-asset:kmAsset.abandom.apply') }" cfg-route="{path:'/kmAsset_abandom/abandomApply'}">
		 	  <ui:iframe  src="${LUI_ContextPath }/km/asset/km_asset_apply_base_ui/kmAssetApplyBase.jsp"></ui:iframe>
		  </ui:content>
		</ui:tabpanel>
	  </div> 
		<%
			request.setAttribute("isAdmin", UserUtil.getKMSSUser().isAdmin());
		%>
	</template:replace>
	<template:replace name="script">
	<script type="text/javascript">
      		seajs.use(['lui/framework/module'],function(Module){
      			Module.install('kmAsset',{
					//模块变量
					$var : {
							SYS_SEARCH_MODEL_NAME : "com.landray.kmss.km.asset.model.KmAssetApplyBase",
							CATEID:"",
							NODETYPE:""
					},
 					//模块多语言
 					$lang : {
 						pageNoSelect : '${lfn:message("page.noSelect")}',
 						confirmFiled : '${lfn:message("km-archives:confirm.filed")}',
 						optSuccess : '${lfn:message("return.optSuccess")}',
 						optFailure : '${lfn:message("return.optFailure")}',
 						buttonDelete : '{lfn:message("button.delete")}',
 						buttonFiled : '${lfn:message("km-archives:button.filed")}',
 						changeRightBatch : '${lfn:message("sys-right:right.button.changeRightBatch")}'
 					},
 					//搜索标识符
 					$search : ''
  				});
      		});
      	</script>
      	<script type="text/javascript" src="${LUI_ContextPath}/km/asset/resource/js/index.js"></script>
      	</template:replace>
</template:include>