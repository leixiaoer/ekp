<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.list" compatibleMode="true">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<bean:message bundle="km-supervise" key="module.km.supervise"/>
		</c:if>
	</template:replace>
	<template:replace name="head">	   
	   	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
	   	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/primarycss.css?s_cache=${MUI_Cache}"></link>
	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/allSupervision.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/sys/mportal/mobile/css/portal.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="content">
		<div class="gray" data-dojo-type="mui/view/DocScrollableView">
			<div data-dojo-type="dojox/mobile/View">
				<!-- 我的督办 -->
				<div class="lui_db_mine">
			        <div class="lui_db_mine_wrap">
			          	<p class="lui_db_tit">我的督办</p>
			          	<div class="lui_db_content">
			            	<div class="lui_db_mine_slide">
		                		<div id="mySuperviseList" data-dojo-type="mui/list/JsonStoreList" 
							    	data-dojo-mixins="km/supervise/mobile/resource/js/list/MySuperviseItemListMixin"
							    	data-dojo-props="url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getNormalCount',lazy:false">
								</div>
			            	</div>
			        	</div>
			        </div>
			    </div>
			    
			    
			    <div data-dojo-type="dojox/mobile/View" id="myCharge" class="lui_asc_box" style="margin-bottom:10px;background:#fff;">
					<div class="lui_asc_list" style="padding:10px 0px 0px 0px;" data-dojo-type="mui/list/JsonStoreList" 
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/ManageAndChargeItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=duty&orderby=docCreateTime&ordertype=down&isDelay=true&rowsize=3',lazy:false">
					</div>
					<a class="muiCardFooter" href="javascript:;" onclick="navigate2View(4)"><button class="muiCardFooterMore"><span>查看更多</span><i class="mui mui-forward"></i></button></a>
				</div>
				
				<div data-dojo-type="dojox/mobile/View" id="myUndertakeAndSup" class="lui_asc_box" style="display:none;margin-bottom:10px;background:#fff;">
					<div class="lui_asc_list" style="padding:10px 0px 0px 0px;" data-dojo-type="mui/list/JsonStoreList" id="undertakeAndSupList"
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/UndertakeAndSupItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&fdType=myUndertake&isDelay=true&rowsize=4',lazy:false">
					</div>
					<a class="muiCardFooter" href="javascript:;" id="undertakeMore" onclick="navigate2View(5)"><button class="muiCardFooterMore"><span>查看更多</span><i class="mui mui-forward"></i></button></a>
					
					<a class="muiCardFooter" href="javascript:;" id="supMore" onclick="navigate2View(6)"><button class="muiCardFooterMore"><span>查看更多</span><i class="mui mui-forward"></i></button></a>
				</div>
			    
				<!-- 督办动态 -->
				<div class="lui_sm_mc_card" data-dojo-type="sys/mportal/mobile/Card"
					data-dojo-props="
						title: '督办动态',
						configs:[{
							'operations': {
								'toolbar': true,
								'random': {
									'href': '',
									'name': '换一批',
									'type': 'random'
								}
							},
							'url': '/km/supervise/mobile/dynamic_portal.jsp?rowsize=6'
						}]">
				</div>
			</div>
		</div>
		<!-- 快速入口 Starts -->
	  	<div id="head" data-dojo-type="mui/header/Header">
		    <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
		          <!-- 督办立项 -->
		          <div class="lui_supervise_create" data-dojo-type="km/supervise/mobile/resource/js/CreateButton"
				  		data-dojo-mixins="mui/syscategory/SysCategoryMixin"
				  		data-dojo-props="key:'10',iconclass:'ekp-ledger-fast-nav-btn',createUrl:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&i.docTemplate=!{curIds}',mainModelName:'com.landray.kmss.km.supervise.model.KmSuperviseMain',
				  		modelName:'com.landray.kmss.km.supervise.model.KmSuperviseTemplet'" style="bottom:11rem;right:0.5rem">
			  		</div>
		     </kmss:authShow>
		</div>
		<!-- 快速入口 Ends -->
		
		<div class="lui_db_footer">
		    <div class="lui_db_footer_item active" onclick="navigate2View(0)">
		      <div class="lui_db_footer_item_img index"></div>
		      <p>首页</p>
		    </div>
		    <div class="lui_db_footer_item " onclick="navigate2View(1)">
		      <div class="lui_db_footer_item_img leader"></div>
		      <p>领导关注</p>
		    </div>
		    <div class="lui_db_footer_item" onclick="navigate2View(2)">
		        <div class="lui_db_footer_item_img all"></div>
		        <p>所有督办</p>
		    </div>
		    <div class="lui_db_footer_item" onclick="navigate2View(3)">
		        <div class="lui_db_footer_item_img mine"></div>
		        <p>我的</p>
		    </div>
		</div>
	</template:replace>
</template:include>
<script>
	require(["dojo/ready","dojo/dom-class","dojo/request","dojo/dom","dojo/query","dojo/on","dojo/dom-attr","dojo/dom-style","dojox/mobile/TransitionEvent", 'dojo/topic','dijit/registry'], 
		function(ready,domClass,request,dom,query,on,domAttr,domStyle,TransitionEvent,topic,registry) {
		window.navigate2View = function(view) {
			var url ="${LUI_ContextPath}/km/supervise/mobile/";
			if(0 == view){
				url += "index.jsp"
			}else if(1 == view){
				url += "index_leader_concern.jsp"
			}else if(2 == view){
				url += "index_all.jsp"
			}else if(3 == view){
				url += "index_my.jsp"
			}else if(4 == view){
				url += "list_charge.jsp?mydoc=duty"
			}else if(5 == view){
				url += "list_undertake.jsp?mydoc=myUndertake"
			}else if(6 == view){
				url += "list_sup.jsp?mydoc=mySup"
			}
			window.open(url, '_self');
		}
		
		ready(function(){
			if(checkWeixin() && checkIOS()){
		    	if(window.history.length == 1){
		    		window.history.pushState(null, null, "#");
		    	}
		    }
		});
		
		window.checkWeixin = function(){
			var userAgent = navigator.userAgent;
			if(userAgent.indexOf("MicroMessenger") > -1){
				return true;
			}
			return false;
		}
		
		window.checkIOS = function(){
			var userAgent = navigator.userAgent;
			var isIos = !!userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
			return isIos;
		}
		
		window.reloadMySupervise = function(type,node){
			var items = query(".lui_db_mine_slide_item");
			for(var i = 0;i < items.length; i++){
				items[i].classList.remove("active");
			}
			node.classList.add("active");
			var myCharge = document.getElementById("myCharge");
			var myUndertakeAndSup = document.getElementById("myUndertakeAndSup");
			var undertakeMore = document.getElementById("undertakeMore");
			var supMore = document.getElementById("supMore");
			if(type == "myCharge"){
				myCharge.style.display='block';
				myUndertakeAndSup.style.display='none';
			}else{
				console.log(type)
				myCharge.style.display='none';
				myUndertakeAndSup.style.display='block';
				if(type=="myUndertake"){
					undertakeMore.style.display='-webkit-box';
					supMore.style.display='none';
				}else{
					supMore.style.display='-webkit-box';
					undertakeMore.style.display='none';
				}
				var href = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&isDelay=true&rowsize=3&fdType="+type;
				registry.byId("undertakeAndSupList").set('url',href);
				registry.byId("undertakeAndSupList").reload();
			}
			
			
		}
		
	});
</script>
