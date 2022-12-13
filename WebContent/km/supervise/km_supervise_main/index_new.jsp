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
							"text": "${lfn:message('km-supervise:py.WoFenGuande')}",
							"href": "/myManage",
							"router" : true,
							"icon": "lui_iconfont_navleft_supervise_my"
						},
						{
							"text": "${lfn:message('km-supervise:py.WoFuZeDe')}",
							"href": "/myCharge",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_responsible"
						},
						{
							"text": "${lfn:message('km-supervise:py.WoChengBanDe')}",
							"href": "/myUndertake",
							"router" : true,
							"icon": "lui_iconfont_navleft_supervise_manage"
						},
						{
							"text": "${lfn:message('km-supervise:py.WoGuanZhuDe')}",
							"href": "/myConcern",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_reserve"
						},
						{
							"text": "${lfn:message('km-supervise:py.WoXieBanDe')}",
							"href": "/mySup",
							"router" : true,
							"icon": "lui_iconfont_navleft_com_reserve"
						},
						{
							"text": "${lfn:message('km-supervise:py.WoDeShenPi')}",
							"href": "/audit",
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
	  						{
		  						"text" : "${ lfn:message('km-supervise:py.DuBanGongZuoTai') }",
		  						"href" :  "/workbench",
								"router" : true	,	
								"icon" : "lui_iconfont_navleft_supervise_overview"  					
		  					}
		  					<kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
			  				,{
			  					"text" : "${ lfn:message('km-supervise:py.DuBanFaQi') }",
			  					"href" :  "/myCreate",
								"router" : true	,
								"icon" : "lui_iconfont_navleft_supervise_project"	  					
			  				}
			  				</kmss:authShow>
			  				,{
		  						"text" : "${ lfn:message('km-supervise:py.DuBanShiXiang') }",
		  						"href" :  "/superviseItem",
								"router" : true	,
								"icon" : "lui_iconfont_navleft_supervise_project"	  					
		  					},{
		  						"text" : "${ lfn:message('km-supervise:py.RenWuZhiPai') }",
		  						"href" :  "/taskPlan",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_assign"
		  					},{
		  						"text" : "${ lfn:message('km-supervise:py.DuBanKaoPing') }",
		  						"href" :  "/evaluate",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_check"
		  					},{
		  						"text" : "${ lfn:message('km-supervise:py.openSearch') }",
		  						"href" :  "/openSearch",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_com_query"
		  					}
		  					<kmss:ifModuleExist path="/dbcenter/echarts/">
								<kmss:authShow roles="ROLE_DBCENTERECHARTS_DEFAULT">
									<xform:Show bean="dbEchartsNavTreeShowService" mainModelName="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" fdKey="kmSuperviseMain">
					  					,{
					  						"text" : "${ lfn:message('dbcenter-echarts:module.dbcenter.dataChart') }",
					  						"href" :  "/dbNavTree",
											"router" : true,
											"icon" : "lui_iconfont_navleft_com_statistics"
					  					}
				  					</xform:Show>
								</kmss:authShow>
							</kmss:ifModuleExist>
							,{
		  						"text" : "${ lfn:message('km-supervise:py.LiShiDuBan') }",
		  						"href" :  "/history",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_all"
		  					}
							]
		  					</ui:source>
		  				</ui:varParam>	
					</ui:combin>
					
		          </ui:content>
		          <!-- 督办流程 -->
		          <ui:content title="${lfn:message('km-supervise:py.DuBanLiuCheng') }" expand="true">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
			  				{
			  					"text" : "${ lfn:message('km-supervise:py.LiXiangLiuCheng') }",
			  					"href" :  "/createReview",
								"router" : true	,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_approval"	  					
			  				} ,{
			  					"text" : "${ lfn:message('km-supervise:py.FanKuiLiuCheng') }",
			  					"href" :  "/backReview",
								"router" : true	,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_approval"	  					
			  				},{
		  						"text" : "${ lfn:message('km-supervise:py.BianGengLiuCheng') }",
		  						"href" :  "/changeReview",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_approval"
		  					},{
		  						"text" : "${ lfn:message('km-supervise:py.BanJieLiuCheng') }",
		  						"href" :  "/finishReview",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_approval"
		  					},{
		  						"text" : "${ lfn:message('km-supervise:py.ZhongZhiLiuCheng') }",
		  						"href" :  "/stopReview",
								"router" : true	,		  					
			  					"icon" : "lui_iconfont_navleft_supervise_approval"	  					
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
		  					,
		  					{
								"text" : "${ lfn:message('list.manager') }",
								"icon" : "lui_iconfont_navleft_com_background",
								"router" : true,
								"href" : "/management"
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
			<style>
				.lui_tabpanel_list_navs_item_l{
				    max-width: 20%!important;
				}
			</style>
			<ui:tabpanel id="kmSupervisePanel" layout="sys.ui.tabpanel.list" cfg-router="true">
				 <ui:content id="WoFenGuande" title="${lfn:message('km-supervise:py.WoFenGuande') }" cfg-route="{path:'/myManage'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_index_new.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="WoFuZeDe" title="${lfn:message('km-supervise:py.WoFuZeDe') }" cfg-route="{path:'/myCharge'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_index_new.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="WoChengBanDe" title="${lfn:message('km-supervise:py.WoChengBanDe') }" cfg-route="{path:'/myUndertake'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_index_new.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="WoXieBanDe" title="${lfn:message('km-supervise:py.WoXieBanDe') }" cfg-route="{path:'/mySup'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_index_new.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="WoGuanZhuDe" title="${lfn:message('km-supervise:py.WoGuanZhuDe') }" cfg-route="{path:'/myConcern'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_index_new.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="listDiscard" title="${lfn:message('km-supervise:py.abandon') }" cfg-route="{path:'/listDiscard'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_index_new.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="LiShiDuBan" title="${lfn:message('km-supervise:py.LiShiDuBan') }" cfg-route="{path:'/history'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_index.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="ItemView" title="${lfn:message('km-supervise:py.DuBanShiXiang') }" cfg-route="{path:'/ItemView'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_item_view.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="createReview" title="${lfn:message('km-supervise:py.LiXiangLiuCheng') }" cfg-route="{path:'/createReview'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_review.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="changeReview" title="${lfn:message('km-supervise:py.BianGengLiuCheng') }" cfg-route="{path:'/changeReview'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main_change/index.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="backReview" title="${lfn:message('km-supervise:py.FanKuiLiuCheng') }" cfg-route="{path:'/backReview'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_back/index.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="finishReview" title="${lfn:message('km-supervise:py.BanJieLiuCheng') }" cfg-route="{path:'/finishReview'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main_finish/index.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="stopReview" title="${lfn:message('km-supervise:py.ZhongZhiLiuCheng') }" cfg-route="{path:'/stopReview'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main_stop/index.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="workbench" title="${lfn:message('km-supervise:py.DuBanGongZuoTai') }" cfg-route="{path:'/workbench'}">
				 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_workBench.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="evaluate" title="${lfn:message('km-supervise:py.DuBanKaoPing') }" cfg-route="{path:'/evaluate'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/kmSuperviseMain_remark_new.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="taskPlan" title="${lfn:message('km-supervise:py.RenWuZhiPai') }" cfg-route="{path:'/taskPlan'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_task/index_new.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="superviseItem" title="${lfn:message('km-supervise:py.DuBanShiXiang') }" cfg-route="{path:'/superviseItem'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/supervise_item.jsp"></ui:iframe>
				 </ui:content>
				 <ui:content id="openSearch" title="${lfn:message('km-supervise:py.openSearch') }" cfg-route="{path:'/openSearch'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/sys/search/ui/nav_search_new.jsp?modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain"></ui:iframe>
				 </ui:content>
				 <ui:content id="dbNavTree" title="${lfn:message('km-supervise:py.dataChart') }" cfg-route="{path:'/dbNavTree'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/dbcenter/echarts/application/navTree/nav.jsp?mainModelName=com.landray.kmss.km.supervise.model.KmSuperviseTemplet&fdKey=kmSuperviseMain"></ui:iframe>
				 </ui:content>
				 <ui:content id="myCreate" title="${lfn:message('km-supervise:py.DuBanFaQi') }" cfg-route="{path:'/myCreate'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/createDoc.jsp?mainModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain&modelName=com.landray.kmss.km.supervise.model.KmSuperviseTemplet&isSimpleCategory=false"></ui:iframe>
				 </ui:content>
				 <ui:content id="recover" title="${lfn:message('km-supervise:py.recycle') }" cfg-route="{path:'/recover'}">
				 	 <ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/supervise/km_supervise_main/sysRecycleBox.jsp"></ui:iframe>
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
							'kmSuperviseSearch' : '${lfn:message("km-supervise:py.openSearch")}',
							'kmSuperviseDbTree' : '${lfn:message("dbcenter-echarts:module.dbcenter.dataChart")}'
						},
						//搜索标识符
						$search : 'com.landray.kmss.km.supervise.model.KmSuperviseMain'
					});
					
					
					window.newPageWithParam = function(href,param){
						var router = routerUtils.getRouter();
						if (router) {
							router.push(href,param);
						}
						//移除导航选中状态
						LUI.$("[data-lui-type*=AccordionPanel] li").removeClass("lui_list_nav_selected");
						LUI.$("[data-path='"+href+"']").addClass('lui_list_nav_selected');
					};
					
				});
				LUI.ready(function () {
					LUI("kmSupervisePanel").on("indexChanged", function(evt) {
						var node = evt.panel.contentsNode[evt.index.after];
						var workbench = node.find("#workbench");
						if(workbench && workbench.length > 0) {
							var iframe = workbench.find("iframe");
							if(iframe && iframe.length > 0) {
								// 重新加载iframe
								iframe[0].contentWindow.location.reload(true);
							}
						}
					});
				});
			</script>
			
            <!-- 引入JS -->
			<script type="text/javascript" src="${LUI_ContextPath}/km/supervise/resource/js/index_new.js"></script>
        </template:replace>
    </template:include>