<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.list">
	<template:replace name="title">
		<c:out value="${ lfn:message('geesun-org:module.geesun.org') }"></c:out>
	</template:replace>
	<template:replace name="path">			
		<ui:menu layout="sys.ui.menu.nav"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>	
		<c:if test="${ empty param.pKey or param.pKey eq 'SAP' }">
			<ui:menu-item text="SAP组织架构同步"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('geesun-org:menus.title.flona.sap') }" >
			</ui:menu-item>
		</c:if>
		<c:if test="${ param.pKey eq 'ORGAN' }">
			<ui:menu-item text="SAP组织架构同步"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('geesun-org:menus.title.organ.middle') }" >
			</ui:menu-item>
		</c:if>
		<c:if test="${ param.pKey eq 'PERSON' }">
			<ui:menu-item text="SAP组织架构同步"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('geesun-org:menus.title.person.middle') }" >
			</ui:menu-item>
		</c:if>
		<c:if test="${ param.pKey eq 'POST' }">
			<ui:menu-item text="SAP组织架构同步"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('geesun-org:menus.title.post.middle') }" >
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
			    var srcUrl = "${LUI_ContextPath}/geesun/org/index.jsp?pKey="+key;
				if(hash!=""){
					srcUrl+="#"+hash;
			    }
				window.open(srcUrl,"_self");
			};
			
                  
		</script>
		<!-- 新建按钮 -->
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('geesun-org:module.geesun.org') }" />
			<ui:varParam name="button">
				[
					{
						"text": "${ lfn:message('geesun-org:module.geesun.org') }",
						"icon": "lui_icon_l_icon_1"
					}
				]
			</ui:varParam>				
		</ui:combin>
		<div class="lui_list_nav_frame">
			 <ui:accordionpanel>				 
				<!-- 查询 -->
				<ui:content title="${ lfn:message('geesun-org:menus.title.leave') }">
				<ul class='lui_list_nav_list'>
					<li><a href="javascript:void(0)" onclick="setUrl('SAP','','');">${ lfn:message('geesun-org:geesun-org:menus.title.flona.sap') }</a></li>
					<li><a href="javascript:void(0)" onclick="setUrl('ORGAN','','');">${ lfn:message('geesun-org:menus.title.organ.middle') }</a></li>
					<li><a href="javascript:void(0)" onclick="setUrl('PERSON','','');">${ lfn:message('geesun-org:menus.title.person.middle') }</a></li>
					<li><a href="javascript:void(0)" onclick="setUrl('POST','','');">${ lfn:message('geesun-org:menus.title.post.middle') }</a></li>
				</ul>
				</ui:content>
				<!-- 其他操作 -->
				<kmss:authShow roles="ROLE_GEESUNORG_BACKGROUND">
					<ui:content title="${ lfn:message('list.otherOpt') }">
						<ul class='lui_list_nav_list'>
							<li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/geesun/org" target="_blank">${ lfn:message('list.manager') }</a></li>
						</ul>
					</ui:content>
				</kmss:authShow>
			</ui:accordionpanel>
		</div>
	</template:replace>
	<template:replace name="content">
		<c:if test="${ empty param.pKey or param.pKey eq 'SAP' }">
			<%@ include file="/geesun/org/geesun_org_ekp/criteria.jsp"%>
		</c:if>
		<c:if test="${param.pKey eq 'ORGAN' }">
			<%@ include file="/geesun/org/sys_organ_middle/criteria.jsp"%>
		</c:if>
		<c:if test="${param.pKey eq 'PERSON' }">
			<%@ include file="/geesun/org/sys_person_middle/criteria.jsp"%>
		</c:if>
		<c:if test="${param.pKey eq 'POST' }">
			<%@ include file="/geesun/org/sys_post_middle/criteria.jsp"%>
		</c:if>
	</template:replace>
</template:include>
