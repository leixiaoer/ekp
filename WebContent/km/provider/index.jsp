<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<template:include ref="default.list" spa="true" rwd="true" spa-groups="[ ['docCategory','fdIsvalidate' ] ]">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-provider:module.km.provider') }"></c:out>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams 
				id="simplecategoryId"
				moduleTitle="${ lfn:message('km-provider:module.km.provider') }" 
				modelName="com.landray.kmss.km.provider.model.KmProviderCategory" 
				extkey="fdIsvalidate"
				/>
				 
		</ui:combin>
	</template:replace>
	<template:replace name="nav">
			<div class="lui_list_noCreate_frame">
				<ui:combin ref="menu.nav.create">
				<ui:varParam name="title" value="${ lfn:message('km-provider:module.km.provider') }" />
					<ui:varParam name="button">
						[
							{
								"text": "",
								"href": "javascript:void(0);",
								"icon": "km_provider"
							}
						]
					</ui:varParam>			
				</ui:combin>
			</div>
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
			<ui:content style="padding:0px;" title="${lfn:message('sys-category:menu.sysCategory.index') }">
					<ui:combin ref="menu.nav.simplecategory.flat.all">
						<ui:varParams
							modelName="com.landray.kmss.km.provider.model.KmProviderCategory"
							/>
					</ui:combin>
				</ui:content>
				<ui:content title="${ lfn:message('km-provider:module.km.provider') }">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[{
		  						"text" : "${ lfn:message('km-provider:kmProviderMain.page.all') }",
		  						"href" :  "/providerAll",
								"router" : true,
								"icon":"lui_iconfont_navleft_com_all"
										  					
		  					},
		  					{
		  						"text" : "${ lfn:message('km-provider:table.kmProviderMain.abandon') }",
		  						"href" :  "/providerCreate",
								"router" : true,
								"icon":"lui_iconfont_navleft_com_discard"		  					
		  					}]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>	
				</ui:content>
				<kmss:authShow roles="ROLE_KMPROVIDER_BACKSTAGE_MANAGER">
				<ui:content title="${ lfn:message('list.otherOpt') }">
				<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
		  					
		  					{
								"text" : "${ lfn:message('list.manager') }",
								"icon" : "lui_iconfont_navleft_com_background",
								"router" : true,
								"href" : "/management"
							}
  				
		  					]
		  					</ui:source>
		  				</ui:varParam>	
					</ui:combin>
				</ui:content>
				</kmss:authShow>
			</ui:accordionpanel>
		</div>
	</template:replace>
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria  id="criteria" expand="false">
		     <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('km-provider:kmProviderMain.fdName') }">
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.km.provider.model.KmProviderMain" property="fdBiao"/>
			<list:cri-criterion title="${ lfn:message('km-provider:kmProviderMain.fdIsvalidate')}" key="fdIsvalidate" >
				<list:box-select>
					<list:item-select>
						<ui:source type="Static" cfg-defaultValue="${empty JsParam.fdIsvalidate ? 'true' : JsParam.fdIsvalidate}">
							[{text:'${ lfn:message('message.yes')}', value:'true'},
							{text:'${ lfn:message('message.no')}',value:'false'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
		</list:criteria>
		<!-- 操作栏 -->
		<div class="lui_list_operation">
			<!-- 排序 -->
			<div style='color: #979797;float: left;padding-top:1px;'>
				${ lfn:message('list.orderType') }：
			</div>
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
					<list:sortgroup>
						<list:sort property="docCreateTime" text="${lfn:message('km-provider:kmProviderMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
						<list:sort property="fdName" text="${lfn:message('km-provider:kmProviderMain.fdName') }" group="sort.list"></list:sort>
					</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div style="float:left;">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar" count="8" >
					    <kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=add" requestMethod="GET">
					        <ui:button text="${lfn:message('button.add')}" onclick="moduleAPI.kmProvider.add()" order="1"></ui:button>	
					        <ui:button text="${lfn:message('button.import')}" onclick="moduleAPI.kmProvider.importExcel();" order="3" ></ui:button>
						</kmss:auth>
						<ui:button text="${lfn:message('button.deleteall')}" onclick="moduleAPI.kmProvider.deleteAll();" order="2"
						    cfg-map="{\"docCategory\":\"criteria('docCategory')\"}"
							cfg-auth="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall&categoryId=!{docCategory}">
						</ui:button>
						<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall&categoryId=${param.categoryId}" requestMethod="GET">
						    <ui:button id="invalidate" text="${lfn:message('km-provider:kmProviderMain.btn.invalidate')}" onclick="invalidateAll();" order="4" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall&categoryId=${param.categoryId}" requestMethod="GET">
						    <ui:button id="validate" text="${lfn:message('km-provider:kmProviderMain.btn.validate')}" onclick="moduleAPI.kmProvider.validateAll();" order="5" ></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表  -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/provider/km_provider_main/kmProviderMain.do?method=list'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			     rowHref="/km/provider/km_provider_main/kmProviderMain.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdName,docCategory.fdName,fdBiao,fdAddress,fdLegal,fdContactPerson,fdPhoneNo"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic','lui/spa/Spa'], function($, dialog, topic,Spa) {
		 		window.invalidateAll = function(id){
					var values = [];
					if(id){
						values.push(id);
					}else{
						$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}
					}
					dialog.confirm('<bean:message bundle="km-provider" key="kmProviderMain.alert.comfirmAbandon"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/provider/km_provider_main/kmProviderMain.do?method=invalidateAll"/>',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};

				window.validateAll = function(id){
					var values = [];
					if(id){
						values.push(id);
					}else{
						$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
						if(values.length==0){
							dialog.alert('<bean:message key="page.noSelect"/>');
							return;
						}
					}
					dialog.confirm('<bean:message bundle="km-provider" key="kmProviderMain.alert.comfirmUse"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/provider/km_provider_main/kmProviderMain.do?method=validateAll"/>',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
						topic.publish("list.refresh");
					}
					dialog.result(data);
				};

				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
							//根据筛选项显示启用或禁用按钮
				topic.subscribe('criteria.changed',function(evt){
					$('#validate').hide();
					$('#invalidate').hide();
					for(var i=0;i<evt['criterions'].length;i++){
	             	  if(evt['criterions'][i].key=="fdIsvalidate"){
		             	  var isValidate = evt['criterions'][i].value[0];
		             	  if(isValidate=='true'){
		             		 $('#invalidate').show();
		             	  }else if(isValidate=='false'){
		             		 $('#validate').show();
		             	  }
	             	  }
					}
					
				});
		 	});
	 	</script>
	</template:replace>
	   	<template:replace name="script">
   		<%-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 --%>
      	<script type="text/javascript">
      		seajs.use(['lui/framework/module'],function(Module){
      			Module.install('kmProvider',{
					//模块变量
					$var : {
					},
 					//模块多语言
 					$lang : {
 						providerAll : '${ lfn:message("km-provider:kmProviderMain.page.all") }',
 						providerCreate : '${ lfn:message("km-provider:table.kmProviderMain.abandon") }',
 						pageNoSelect : '${lfn:message("page.noSelect")}',
 						confirmFiled : '${lfn:message("km-archives:confirm.filed")}',
 						optSuccess : '${lfn:message("return.optSuccess")}',
 						optFailure : '${lfn:message("return.optFailure")}',
 						buttonDelete : '{lfn:message("button.delete")}',
 						buttonFiled : '${lfn:message("km-archives:button.filed")}',
 						comfirmDelete :'${lfn:message("page.comfirmDelete")}',
 						comfirmAbandon :'${lfn:message("km-provider:kmProviderMain.alert.comfirmAbandon")}',
 						comfirmUse :'${lfn:message("km-provider:kmProviderMain.alert.comfirmUse")}',
 					},
 					//搜索标识符
 					$search : ''
  				});
      		});
      	</script>
      	<script type="text/javascript" src="${LUI_ContextPath}/km/provider/resource/js/index.js"></script>
	</template:replace>
</template:include>
