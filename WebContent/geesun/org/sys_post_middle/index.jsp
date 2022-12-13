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
			<ui:menu-item text="${ lfn:message('geesun-org:module.geesun.org') }">
			</ui:menu-item>
		</ui:menu>
	</template:replace>
	<template:replace name="nav">
		<script>
			function addDoc(){
				Com_OpenWindow("${LUI_ContextPath}/geesun/org/geesun_org_ekp/geesunOrgEkp.do?method=add");
			}
			function delDoc(){
				var values = [];
				$("input[name='List_Selected']:checked").each(function(){
						values.push($(this).val());
					});
				if(values.length==0){
					dialog.alert('<bean:message key="page.noSelect"/>');
					return;
				}
				seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							var del_load = dialog.loading();
							$.post('${LUI_ContextPath}/geesun/org/geesun_org_ekp/geesunOrgEkp.do?method=deleteall&categoryId=${param.categoryId}',$.param({"List_Selected":values},true),function(data){
								if(del_load!=null){
									del_load.hide();
									topic.publish("list.refresh");
								}
								dialog.result(data);
							},'json');
						}
					});
				});
			}
		</script>
		<!-- 新建按钮 -->
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('geesun-org:module.geesun.org') }" />
			<ui:varParam name="button">
				[
					<kmss:auth requestURL="/geesun/org/geesun_org_ekp/geesunOrgEkp.do?method=add">
					{
						"text": "${ lfn:message('geesun-org:module.geesun.org') }",
						"href": "javascript:void(0);",
						"icon": "lui_icon_l_icon_1"
					}
					</kmss:auth>
				]
			</ui:varParam>				
		</ui:combin>
		<div class="lui_list_nav_frame">
			 <ui:accordionpanel>				 
				<!-- 常用查询 -->
				<ui:content title="${ lfn:message('list.search') }">
				<ul class='lui_list_nav_list'>
					<li><a href="javascript:void(0)" onclick="openQuery();LUI('criteria1').clearValue();">${ lfn:message('list.alldoc') }</a></li>
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
		<!-- 查询条件  -->
		<list:criteria id="criteria1">
			<list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgEkp" 
				property="fdResult;fdType;docCreateTime" expand="true"/>
		</list:criteria>
		 
		<!-- 列表工具栏 -->
		<div class="lui_list_operation">
			<table width="100%">
				<tr>
					<td style='width: 60px;'>
						${ lfn:message('list.orderType') }：
					</td>
					<td>
						<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
							<list:sort property="docCreateTime" text="${lfn:message('geesun-org:geesunOrgEkp.docCreateTime') }" group="sort.list" value="down"></list:sort>
						</ui:toolbar>
					</td>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
		 
	 	<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/geesun/org/geesun_org_ekp/geesunOrgEkp.do?method=data'}
			</ui:source>
			<!-- 列表视图 -->	
			<list:colTable isDefault="false"
				rowHref="/geesun/org/geesun_org_ekp/geesunOrgEkp.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdResult;fdType;docCreateTime"></list:col-auto>
			</list:colTable>
		</list:listview> 
		
	 	<list:paging></list:paging>	 
	</template:replace>
</template:include>
