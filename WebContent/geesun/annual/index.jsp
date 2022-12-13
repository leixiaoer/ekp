<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.list">
	<template:replace name="title">
		<c:out value="${ lfn:message('geesun-annual:module.geesun.annual') }"></c:out>
	</template:replace>
	<template:replace name="path">			
		<ui:menu layout="sys.ui.menu.nav"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>	
		<c:if test="${ empty param.pKey or param.pKey eq 'annual' }">
			<ui:menu-item text="年假查询"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('geesun-annual:menus.search.annual.record') }" >
			</ui:menu-item>
		</c:if>
		<c:if test="${ param.pKey eq 'use' }">
			<ui:menu-item text="年假查询"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('geesun-annual:menus.search.use.record') }" >
			</ui:menu-item>
		</c:if>
		<c:if test="${ param.pKey eq 'reset' }">
			<ui:menu-item text="年假查询"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('geesun-annual:menus.search.reset.record') }" >
			</ui:menu-item>
		</c:if>
		</ui:menu>
	</template:replace>
	<template:replace name="nav">
		<script>
			window.setUrl= function (key,mykey,type){
				if(key != "${key}"){
			        if(type ==''){
			        	openUrl('',key);
				    }else{
					    if(mykey!=null && mykey!='' && mykey.indexOf("|")!=-1){
					    	var ks = mykey.split("|");
					    	openUrl('cri.'+ks[0]+'.q='+ks[1]+':'+type,key);
					    } else {
		    				openUrl('cri.q='+mykey+':'+type,key);
					    }
					}
				} else {
					openQuery();
					if(type==''){
						LUI('criteria').clearValue();
					}else{
					 	LUI('criteria').setValue(mykey, type);
					}
				 }
			};
			window.openUrl = function(hash,key){
			    var srcUrl = "${LUI_ContextPath}/geesun/annual/index.jsp?pKey="+key;
				if(hash!=""){
					srcUrl+="#"+hash;
			    }
				window.open(srcUrl,"_self");
			};
			
                  
		</script>
		<!-- 新建按钮 -->
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('geesun-annual:module.geesun.annual') }" />
			<ui:varParam name="button">
				[
					{
						"text": "${ lfn:message('geesun-annual:module.geesun.annual') }",
						"icon": "lui_icon_l_icon_1"
					}
				]
			</ui:varParam>				
		</ui:combin>
		<div class="lui_list_nav_frame">
			 <ui:accordionpanel>				 
				<!-- 考勤查询 -->
				<ui:content title="${ lfn:message('geesun-annual:menus.title.annual.record') }">
				<ul class='lui_list_nav_list'>
					<li><a href="javascript:void(0)" onclick="setUrl('annual','','');">${ lfn:message('geesun-annual:menus.search.annual.record') }</a></li>
					<kmss:authShow roles="ROLE_GEESUNANNUAL_ADMIN">
						<li><a href="javascript:void(0)" onclick="setUrl('use','','');">${ lfn:message('geesun-annual:menus.search.use.record') }</a></li>
						<li><a href="javascript:void(0)" onclick="setUrl('reset','','');">${ lfn:message('geesun-annual:menus.search.reset.record') }</a></li>
					</kmss:authShow>
				</ul>
				</ui:content>
				<kmss:authShow roles="ROLE_GEESUNANNUAL_SETTING">
					<!-- 其他操作 -->
					<ui:content title="${ lfn:message('list.otherOpt') }">
						<ul class='lui_list_nav_list'>
							<li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/geesun/annual" target="_blank">${ lfn:message('list.manager') }</a></li>
						</ul>
					</ui:content>
				</kmss:authShow>
			</ui:accordionpanel>
		</div>
	</template:replace>
	<template:replace name="content">
		<c:if test="${ empty param.pKey or param.pKey eq 'annual' }">
			<%@ include file="/geesun/annual/geesun_annual_main/criteria.jsp"%>
		</c:if>
		<c:if test="${param.pKey eq 'use' }">
			<%@ include file="/geesun/annual/geesun_annual_use/criteria.jsp"%>
		</c:if>
		<c:if test="${param.pKey eq 'reset' }">
			<%@ include file="/geesun/annual/geesun_annual_reset/criteria.jsp"%>
		</c:if>
	</template:replace>
</template:include>
