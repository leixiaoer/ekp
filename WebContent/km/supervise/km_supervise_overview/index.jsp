<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include ref="default.list" spa="true">
	<template:replace name="title">
		 <c:out value="${ lfn:message('km-supervise:module.km.supervise') }-${ lfn:message('km-supervise:module.km.supervise') }" />
	</template:replace>
	<template:replace name="head">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_index.css?s_cache=${LUI_Cache}"/>
	</template:replace>
	<template:replace name="path">
		 <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('km-supervise:py.DuBanYiLan') }" />
         </ui:menu>
	</template:replace>
	<template:replace name="nav">
        
        <ui:combin ref="menu.nav.title">
			<ui:varParam name="title" value="${ lfn:message('km-supervise:module.km.supervise') }"></ui:varParam>
			<ui:varParam name="operation">
				<ui:source type="Static">
				[
					{
						"text": "${lfn:message('km-supervise:py.WoFuZeDe')}",
						<!-- "href": "javascript:moduleAPI.supervise.createDoc(this, 'supervise',{ cri :{'mydoc':'duty'},title :'我负责的'});", -->
						"href": "javascript:moduleAPI.supervise.createDoc('cri.q=mydoc:duty', 'main');",
						"icon": "&#xe76a;",
						"target": "_rIframe"
					},
					{
						"text": "${lfn:message('km-supervise:py.SuoYouDuBan')}",
						<!-- "href": "javascript:moduleAPI.supervise.switchMenuItem(this, 'supervise',{ cri :{'mydoc':'manage'},title :'我经办的'});", -->
						"href": "javascript:moduleAPI.supervise.createDoc('cri.q=mydoc:manage', 'main');",
						"icon": "&#xe6cd;"
					},
					{
						"text": "${lfn:message('km-supervise:py.WoGuanZhuDe')}",
						<!-- "href": "javascript:moduleAPI.supervise.switchMenuItem(this, 'supervise',{ cri :{'mydoc':'concern'},title :'我关注的'});", -->
						"href": "javascript:moduleAPI.supervise.createDoc('cri.q=mydoc:concern', 'main');",
						"icon": "&#xe769;"
					},
					{
						"text": "${lfn:message('km-supervise:py.ChaoSongWoDe')}",
						<!-- "href": "javascript:moduleAPI.supervise.switchMenuItem(this, 'supervise',{ cri :{'mydoc':'copy'},title :'抄送我的'});", -->
						"href": "javascript:moduleAPI.supervise.createDoc('cri.q=mydoc:copy', 'main');",
						"icon": "&#xe765;"
					}
				]
				</ui:source>
			</ui:varParam>	
		</ui:combin>
		
		<div id="menu_nav" class="lui_list_nav_frame">
		  	<ui:accordionpanel>
	     	<!-- 督办管理 -->
	          <ui:content title="${ lfn:message('km-supervise:module.km.supervise') }" expand="true">
	              <ul class='lui_list_nav_list'>
	              	  <kmss:authShow roles="ROLE_KMSUPERVISE_OVERVIEW">
		                  <li><a id="supervise_res" href="javascript:void(0)" onclick="LUI.pageOpen('${LUI_ContextPath }/km/supervise/km_supervise_overview/supervise_overview.jsp','_rIframe');resetMenuNavStyle(this);">${lfn:message('km-supervise:py.DuBanGaiLan')}</a>
		                  </li>
	                  </kmss:authShow>
	                  <li><a id="supervise_project" href="javascript:void(0)" onclick="LUI.pageOpen('${LUI_ContextPath }/km/supervise/km_supervise_main/kmSuperviseMain_project.jsp','_rIframe');resetMenuNavStyle(this);">${lfn:message('km-supervise:py.DuBanLiXiang')}</a>
	                  </li>
	                  <li><a id="supervise_task" href="javascript:void(0)" onclick="LUI.pageOpen('${LUI_ContextPath }/km/supervise/km_supervise_task/index.jsp','_rIframe');resetMenuNavStyle(this);">${lfn:message('km-supervise:py.RenWuZhiPai')}</a>
	                  </li>
	                  <li><a id="supervise_remark" href="javascript:void(0)" onclick="LUI.pageOpen('${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain_remark.jsp','_rIframe');resetMenuNavStyle(this);">${lfn:message('km-supervise:py.DuBanKaoPing')}</a>
	                  </li>
	                  <li><a id="supervise_remark" href="javascript:void(0)" onclick="moduleAPI.supervise.switchMenuItem(this, 'supervise',{ cri :{'mydoc':'all'},title :'所有督办'});resetMenuNavStyle(this);">所有督办</a>
	                  </li>
	              </ul>
	          </ui:content>
	          <!-- 其他操作 -->
	          <kmss:authShow roles="ROLE_KMSUPERVISE_SETTING">
		          <ui:content title="${ lfn:message('km-supervise:py.QiTaCaoZuo') }" expand="true">
			            <ul class='lui_list_nav_list'>
			            	<li>
								<a href="javascript:void(0)" onclick="moduleAPI.supervise.switchMenuItem(this,{ cri :{'docStatus':'00'},title :'废弃的流程'});resetMenuNavStyle(this);">
									<i class="fontmui">&#xe75c;</i>废弃的流程
								</a>
							</li>
							<li>
								<a href="javascript:void(0)" onclick="LUI.pageOpen('${LUI_ContextPath}/sys/recycle/import/sysRecycle_index.jsp?modelName=com.landray.kmss.km.review.model.KmReviewMain','_rIframe');resetMenuNavStyle(this);">
									<i class="fontmui">&#xe761;</i>回收站
								</a>
							</li>
			                <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/km/supervise" target="_blank"><i class="fontmui">&#xe6a7;</i>${ lfn:message('list.manager') }</a>
			                </li>
			            </ul>
		          </ui:content>
		      </kmss:authShow>
		  </ui:accordionpanel>
	  </div>
	  
	</template:replace>
	<template:replace name="content">  
		
		  <script>
                var listOption = {
                    contextPath: '${LUI_ContextPath}',
                    modelName: 'com.landray.kmss.km.supervise.model.KmSuperviseMain',
                    templateName: 'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
                    basePath: '/km/supervise/km_supervise_main/kmSuperviseMain.do',
                    canDelete: '${canDelete}',
                    mode: 'main_template',
                    customOpts: {

                        ____fork__: 0
                    },
                    lang: {
                        noSelect: '${lfn:message("page.noSelect")}',
                        comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                    }

                };
                Com_IncludeFile("list.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
            </script>
            <!-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 -->
			<script type="text/javascript">
				seajs.use(['lui/framework/module'],function(Module){
					Module.install('supervise',{
						//模块变量
						$var : {},
						//模块多语言
						$lang : {
							
						},
						//搜索标识符
						$search : ''
					});
					
					LUI.ready(function(){
						LUI.pageOpen('${LUI_ContextPath }/km/supervise/km_supervise_overview/supervise_overview.jsp','_rIframe');
						
					});
				});
			</script>
            <!-- 引入JS -->
			<script type="text/javascript" src="${LUI_ContextPath}/km/supervise/resource/js/index.js"></script>
	</template:replace>
</template:include>
