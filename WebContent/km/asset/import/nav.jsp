<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="key" value="${param.key}"/>
<c:set var="criteria" value="${param.criteria}"/>
		<ui:content title="${ lfn:message('km-asset:module.km.asset') }" expand="true" style="padding-bottom:0;">
				<ul class='lui_list_nav_list'>
				 	<li><a id="kmAsset_stockAndin" href="javascript:void(0)" onclick="openSearch('${LUI_ContextPath}/km/asset/import/kmAssetApply_stockAndin.jsp');resetMenuNavStyle(this);" title="${lfn:message('km-asset:kmAsset.stockAndin') }"><i class="fontmui">&#xe76b;</i>${lfn:message('km-asset:kmAsset.stockAndin') }</a></li>
				 	<li><a id="kmAsset_rentAnddivert" href="javascript:void(0)" onclick="openSearch('${LUI_ContextPath}/km/asset/import/kmAssetApply_rentAnddivert.jsp');resetMenuNavStyle(this);" title="${lfn:message('km-asset:kmAsset.rentAnddivert') }"><i class="fontmui">&#xe76b;</i>${lfn:message('km-asset:kmAsset.rentAnddivert') }</a></li>
				 	<li><a id="kmAsset_repair" href="javascript:void(0)" onclick="openSearch('${LUI_ContextPath}/km/asset/import/kmAssetApply_repair.jsp');resetMenuNavStyle(this);" title="${lfn:message('km-asset:kmAsset.repair') }"><i class="fontmui">&#xe76b;</i>${lfn:message('km-asset:kmAsset.repair') }</a></li>
				 	<li><a id="kmAsset_changeAnddeal" href="javascript:void(0)" onclick="openSearch('${LUI_ContextPath}/km/asset/import/kmAssetApply_changeAnddeal.jsp');resetMenuNavStyle(this);" title="${lfn:message('km-asset:kmAsset.changeAnddeal') }"><i class="fontmui">&#xe76b;</i>${lfn:message('km-asset:kmAsset.changeAnddeal') }</a></li>
				</ul>
		</ui:content>
		<ui:content title="${ lfn:message('km-asset:table.kmAssetApplyInventory') }" expand="true" style="padding-bottom:0;">
				<ul class='lui_list_nav_list'>
				<li><a id="kmAsset_task" href="javascript:void(0)" onclick="openSearch('${LUI_ContextPath}/km/asset/import/kmAssetApply_task.jsp');resetMenuNavStyle(this);" title="${lfn:message('km-asset:kmAssetApplyBase.fdTask') }"><i class="fontmui">&#xe76b;</i>${lfn:message('km-asset:kmAssetApplyBase.fdTask') }</a></li>
				</ul>
		</ui:content>
		<kmss:authShow roles="ROLE_KMASSET_BACKSTAGE_MANAGER">
		<ui:content title="${ lfn:message('list.otherOpt') }" expand="false">
					<ul class='lui_list_nav_list'>
						<li><a id="kmAsset_abandom " href="javascript:void(0)" onclick="openSearch('${LUI_ContextPath}/km/asset/import/kmAssetApply_abandom.jsp');resetMenuNavStyle(this);" title="${lfn:message('km-asset:kmAsset.abandom') }"><i class="fontmui">&#xe75c;</i>${lfn:message('km-asset:kmAsset.abandom') }</a></li>
						<li><a href="${LUI_ContextPath }/sys/profile/index.jsp#app/ekp/km/asset" target="_blank"><i class="fontmui">&#xe6a7;</i>${ lfn:message('list.manager') }</a></li>
					</ul>
		 </ui:content>
        </kmss:authShow>
	<script type="text/javascript">
	seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog'], function($, strutil, dialog){
		
		window.openSearch=function(url){
			LUI.pageQuickOpen(url,'_rIframe');
		}
		window.setUrl= function (key,mykey,type){
		     if(key!="${key}"){
		    	 if(key == 'assetApply'){
			        if(type ==''){
			         openUrl('km_asset_apply_base_ui','',key);
				    }else{
		    		 openUrl('km_asset_apply_base_ui','cri.q='+mykey+':'+type,key);
				    }
			     }
		    	  if(key == 'assetCard'){
		    		 if(type ==''){
			          openUrl('km_asset_card_ui','',key);
				     }else{
		    		  openUrl('km_asset_card_ui','cri.q='+mykey+':'+type,key);
				     }
				   }
		    	  if(key == 'assetInventory'){
			    		 if(type ==''){
				          openUrl('km_asset_apply_task','',key);
					     }else{
			    		  openUrl('km_asset_apply_task','cri.q='+mykey+':'+type,key);
					     }
			      }
				}else{
					openQuery();
					if(type==''){
						LUI('${criteria}').clearValue();
					}else{
					 LUI('${criteria}').setValue(mykey, type);
					}
				}
			 };
			 
		LUI.ready(function(){
		   //初始化左侧导航样式
		    setTimeout("initMenuNav('${param.key}')", 300);
		});
		
		window.initMenuNav=function(key){
			var mydoc = getValueByHash("mydoc");
			var mycard=getValueByHash("mycard");
			var inventory=getValueByHash("inventory");
			var fdApplyTemplate = getValueByHash("fdApplyTemplate");
			if(mydoc!=""){
				resetMenuNavStyle($("#"+key+"_"+mydoc));
			}else if(mycard!=""){
				resetMenuNavStyle($("#"+key+"_"+mycard));
			}else if(inventory!=""){
				resetMenuNavStyle($("#"+key+"_"+inventory));
			}else if(fdApplyTemplate!=""){
				resetMenuNavStyle($("#menu_nav a[href*=" + fdApplyTemplate + "]"));
			}else{
				resetMenuNavStyle($("#"+key+"_all"));
			}
		};
		
		window.openUrl = function(prefix,hash,key){
			    var srcUrl = "${LUI_ContextPath}/km/asset/";
			    if(key=='assetApply'){
			    	 srcUrl = srcUrl+"index.jsp";
			    }else{
				   srcUrl = srcUrl+ prefix+"/index.jsp";
			    }
				if(hash!=""){
					srcUrl+="#"+hash;
			    }
				window.open(srcUrl,"_self");
			};
       /*window.clearAllValue = function() {
		 		
			 	this.location = "${LUI_ContextPath}/km/asset";
			};
	  window.clearcardValue = function() {
				 	this.location = "${LUI_ContextPath}/km/asset/km_asset_card_ui/index.jsp";
				};*/
	 window.getmycard = function() {
		    LUI("cardListView").source.setUrl("/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&mycard=true");//修改请求地址
			LUI("cardListView").source.get();
		};
				
	});
	 	</script>
