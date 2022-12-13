<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<%@ page import="com.landray.kmss.util.UserUtil" %>

    <template:include ref="default.list"  spa="true" rwd="true">
        <template:replace name="title">
            <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
        </template:replace>
        <template:replace name="path">
           <%--  <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('km-supervise:py.DuBanYiLan') }" />
            </ui:menu> --%>
        </template:replace>
        <template:replace name="nav">
            
            <ui:combin ref="menu.nav.title">
				<ui:varParam name="title" value="${ lfn:message('km-supervise:module.km.supervise') }"></ui:varParam>
				<ui:varParam name="operation">
					<ui:source type="Static">
					[
						{
							"text": "${lfn:message('km-supervise:py.WoDuBanDe')}",
							"href": "/WoDuBanDe",
							"router" : true,
							"icon": "lui_iconfont_navleft_supervise_my"
						},
						{
							"text": "${lfn:message('km-supervise:py.WoFuZeDe')}",
							"href": "/WoFuZeDe",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_responsible"
						},
						{
							"text": "${lfn:message('km-supervise:py.SuoYouDuBan')}",
							"href": "/SuoYouDuBan",
							"router" : true,
							"icon": "lui_iconfont_navleft_supervise_manage"
						},
						{
							"text": "${lfn:message('km-supervise:py.WoGuanZhuDe')}",
							"href": "/WoGuanZhuDe",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_my_follow"
						},
						{
							"text": "${lfn:message('km-supervise:py.ChaoSongWoDe')}",
							"href": "/ChaoSongWoDe",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_reserve"
						}
					]
					</ui:source>
				</ui:varParam>	
			</ui:combin>
		
            <div id="menu_nav" class="lui_list_nav_frame">
			  	<ui:accordionpanel>
		     	<!-- 督办管理 -->
		          <ui:content title="${ lfn:message('km-supervise:module.km.supervise') }" expand="true">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
		  					<kmss:authShow roles="ROLE_KMSUPERVISE_OVERVIEW">
			  					{
			  						"text" : "${ lfn:message('km-supervise:py.DuBanGaiLan') }",
			  						"href" :  "/DuBanGaiLan",
									"router" : true,		  					
				  					"icon" : "lui_iconfont_navleft_supervise_overview"
			  					},
		  					</kmss:authShow>
		  					<kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
			  					{
			  						"text" : "${ lfn:message('km-supervise:py.DuBanLiXiang') }",
			  						"href" :  "/DuBanLiXiang",
									"router" : true,		  					
				  					"icon" : "lui_iconfont_navleft_supervise_project"
			  					},
		  					</kmss:authShow>
		  					{
		  						"text" : "${ lfn:message('km-supervise:py.DuBan.audit') }",
		  						"href" :  "/audit",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_approval"
		  					}
		  					,{
		  						"text" : "${ lfn:message('km-supervise:py.RenWuZhiPai') }",
		  						"href" :  "/RenWuZhiPai",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_assign"
		  					},{
		  						"text" : "${ lfn:message('km-supervise:py.DuBanKaoPing') }",
		  						"href" :  "/DuBanKaoPing",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_check"
		  					},{
		  						"text" : "${ lfn:message('km-supervise:py.openSearch') }",
		  						"href" :  "/openSearch",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_com_query"
		  					},{
		  						"text" : "${ lfn:message('km-supervise:py.DuBanALL') }",
		  						"href" :  "/DuBanALL",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_all"
		  					}]
		  					</ui:source>
		  				</ui:varParam>	
					</ui:combin>
					
		          </ui:content>
				
		          <!-- 其他操作 -->
		          <ui:content title="${ lfn:message('list.otherOpt') }" expand="false" >
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[{
		  						"text" : "${ lfn:message('km-supervise:py.abandon') }",
		  						"href" :  "/listDiscard",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_com_discard"
		  					}
		  					<% if(com.landray.kmss.sys.recycle.util.SysRecycleUtil.isEnableSoftDelete("com.landray.kmss.km.supervise.model.KmSuperviseMain")) { %>
		  					,{
		  						"text" : "${ lfn:message('km-supervise:py.recycle') }",
		  						"href" :  "/recover",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_com_recycle"
		  					}
		  					<% } %>
		  					<kmss:authShow roles="ROLE_KMSUPERVISE_SETTING">
		  					,{
		  						"text" : "${ lfn:message('list.manager') }",
		  						"href" :  "javascript:LUI.pageOpen('${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/km/supervise','_blank');",
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
        	
       	     <ui:tabpanel id="kmSupervisePanel" layout="sys.ui.tabpanel.list" cfg-router="true">
				 <ui:content id="kmSuperviseContent" title="${lfn:message('km-supervise:py.DuBanALL') }" cfg-route="{path:'/DuBanALL'}">
				 	  <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_index.jsp"></ui:iframe>
				  </ui:content>
			</ui:tabpanel>
        
        	<%  request.setAttribute("isAdmin",UserUtil.getKMSSUser().isAdmin()); %>
			<script type="text/javascript">
				seajs.use(['lui/framework/module', 'lui/framework/router/router-utils'],function(Module, routerUtils){
					Module.install('supervise',{
						//模块变量
						$var : {
							isAdmin : '${isAdmin}'
						},
						//模块多语言
						$lang : {
							'kmSuperviseSearch' : '${lfn:message("km-supervise:py.openSearch")}'
						},
						//搜索标识符
						$search : 'com.landray.kmss.km.supervise.model.KmSuperviseMain'
					});
					
					window.newPage = function(status){
						var router = routerUtils.getRouter();
						if (router) {
							router.push(status);
						}
					};
					
				});
			</script>
			
            <!-- 引入JS -->
			<script type="text/javascript" src="${LUI_ContextPath}/km/supervise/resource/js/index.js"></script>
        </template:replace>
    </template:include>