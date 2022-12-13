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
	   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/primarycss.css?s_cache=${MUI_Cache}"></link>
	   <link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/allSupervision.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
	   <style>
	   	.mblBackground {
		    background-color: #f5f5f5;
		}
		#content{
		    overflow:auto;
		}
	   </style>
	</template:replace>
	<template:replace name="content">
		<div class="gray" data-dojo-type="mui/view/DocScrollableView">
		  	<!-- 列表导航 Starts -->
		  	<div class="ekp-ledger-nav-panel" data-dojo-type="dojox/mobile/View">
		  		<!-- 我督办的 -->
		    	<ul class="ekp-ledger-nav-list">
			      	<li onclick="window.open('${LUI_ContextPath}/km/supervise/mobile/list_audit.jsp','_self');this.style.backgroundColor='rgba(255,255,255,.125)';">
			       		<i class="mui lui_supervise_my_audit iconbox"></i>
			        	<div class="ekp-ledger-nav-caption">
			          		<h4 class="ekp-ledger-nav-caption-title"><bean:message bundle="km-supervise" key="py.DuBan.audit"/></h4>
			          		<div class="ekp-ledger-nav-caption-subhead"><span class="num" id="audit">0</span>&nbsp;<bean:message bundle="km-supervise" key="mobile.tip14"/></div>
			        	</div>
			        	<i class="mui mui-forward"></i>
			      	</li>
		    	</ul>
		    	<ul class="ekp-ledger-nav-list">
		    		<!-- 我分管的 -->
		      		<li onclick="window.open('${LUI_ContextPath}/km/supervise/mobile/list_manage.jsp?mydoc=fenguan','_self');this.style.backgroundColor='rgba(255,255,255,.125)';">
		        		<i class="mui lui_supervise_my_manage iconbox"></i>
		        		<div class="ekp-ledger-nav-caption">
		          			<h4 class="ekp-ledger-nav-caption-title"><bean:message bundle="km-supervise" key="py.WoFenGuande"/></h4>
		          			<div class="ekp-ledger-nav-caption-subhead"><span class="num" id="myManage">0</span></div>
		        		</div>
		        		<i class="mui mui-forward"></i>
		      		</li>
		      		<!-- 我负责的 -->
		      		<li onclick="window.open('${LUI_ContextPath}/km/supervise/mobile/list_charge.jsp?mydoc=duty','_self');this.style.backgroundColor='rgba(255,255,255,.125)';">
		        		<i class="mui lui_supervise_my_charge iconbox"></i>
		        		<div class="ekp-ledger-nav-caption">
		          			<h4 class="ekp-ledger-nav-caption-title"><bean:message bundle="km-supervise" key="py.WoFuZeDe"/></h4>
		          			<div class="ekp-ledger-nav-caption-subhead"><span class="num" id="myCharge">0</span></div>
		        		</div>
		        		<i class="mui mui-forward"></i>
		      		</li>
		      		<!-- 我承办的 -->
		      		<li onclick="window.open('${LUI_ContextPath}/km/supervise/mobile/list_undertake.jsp?mydoc=myUndertake','_self');this.style.backgroundColor='rgba(255,255,255,.125)';">
		        		<i class="mui lui_supervise_my_undertake iconbox"></i>
		        		<div class="ekp-ledger-nav-caption">
		          			<h4 class="ekp-ledger-nav-caption-title"><bean:message bundle="km-supervise" key="py.WoChengBanDe"/></h4>
		          			<div class="ekp-ledger-nav-caption-subhead"><span class="num" id="myUndertake">0</span></div>
		          			<i class="mui mui-forward"></i>
		        		</div>
		      		</li>
		      		<!-- 我协办的 -->
		      		<li onclick="window.open('${LUI_ContextPath}/km/supervise/mobile/list_sup.jsp?mydoc=mySup','_self');this.style.backgroundColor='rgba(255,255,255,.125)';">
		        		<i class="mui lui_supervise_my_sup iconbox"></i>
		        		<div class="ekp-ledger-nav-caption">
		          			<h4 class="ekp-ledger-nav-caption-title"><bean:message bundle="km-supervise" key="py.WoXieBanDe"/></h4>
		          			<div class="ekp-ledger-nav-caption-subhead"><span class="num" id="mySup">0</span></div>
		          			<i class="mui mui-forward"></i>
		        		</div>
		      		</li>
		    	</ul>
		    	<ul class="ekp-ledger-nav-list">
		      		<!-- 我立项的-->
			      	<li onclick="window.open('${LUI_ContextPath}/km/supervise/mobile/list_create.jsp?mydoc=create','_self');this.style.backgroundColor='rgba(255,255,255,.125)';">
			        	<i class="mui lui_supervise_my_create iconbox"></i>
			        	<div class="ekp-ledger-nav-caption">
			          		<h4 class="ekp-ledger-nav-caption-title"><bean:message bundle="km-supervise" key="py.myLiXiang"/></h4>
			          		<div class="ekp-ledger-nav-caption-subhead"><span class="num" id="myLiXiang">0</span></div>
			        	</div>
			        	<i class="mui mui-forward"></i>
			      	</li>
			      	<!-- 我关注的 -->
		      		<li onclick="window.open('${LUI_ContextPath}/km/supervise/mobile/list_concern.jsp?mydoc=concern','_self');this.style.backgroundColor='rgba(255,255,255,.125)';">
		        		<i class="mui lui_supervise_my_concern iconbox"></i>
		        		<div class="ekp-ledger-nav-caption">
		          			<h4 class="ekp-ledger-nav-caption-title"><bean:message bundle="km-supervise" key="py.WoGuanZhuDe"/></h4>
		          			<div class="ekp-ledger-nav-caption-subhead"><span class="num" id="myConcern">0</span></div>
		        		</div>
		        		<i class="mui mui-forward"></i>
		      		</li>
		  		</ul>
		  	</div>
		</div>
		
		<div class="lui_db_footer">
		    <div class="lui_db_footer_item" onclick="navigate2View(0)">
		      <div class="lui_db_footer_item_img index"></div>
		      <p>首页</p>
		    </div>
		    <div class="lui_db_footer_item" onclick="navigate2View(1)">
		      <div class="lui_db_footer_item_img leader"></div>
		      <p>领导关注</p>
		    </div>
		    <div class="lui_db_footer_item" onclick="navigate2View(2)">
		        <div class="lui_db_footer_item_img all"></div>
		        <p>所有督办</p>
		    </div>
		    <div class="lui_db_footer_item active" onclick="navigate2View(3)">
		        <div class="lui_db_footer_item_img mine"></div>
		        <p>我的</p>
		    </div>
		</div>
	</template:replace>
</template:include>
<script>
	require(["dojo/ready","dojo/dom-class","dojo/request","dojo/dom","dojo/query","dojo/on","dojo/dom-attr","dojo/dom-style","dojox/mobile/TransitionEvent"], 
		function(ready,domClass,request,dom,query,on,domAttr,domStyle,TransitionEvent) {
		request("${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getSuperviseMobileIndexNew").then(function(data){
			var json = eval("("+data+")");
			for(var p in json){
				var subject = dom.byId(json[p].name);
				subject.innerText = json[p].count
			} 
		},function(error){
		    
		});
		ready(function() {
			
		});
		
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
			}
			window.open(url, '_self');
		}
	});
</script>
