<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include ref="default.simple" spa="true">
    <template:replace name="title">
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }-${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
    <%-- <template:replace name="path">
        <ui:menu layout="sys.ui.menu.nav">
            <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
            <ui:menu-item text="${ lfn:message('km-supervise:module.km.supervise') }" />
            <ui:menu-item text="${ lfn:message('km-supervise:py.RenWuZhiPai') }" />
        </ui:menu>
    </template:replace>
    <template:replace name="nav">
        <!-- 新建按钮 -->
        <ui:combin ref="menu.nav.create">
            <ui:varParam name="title" value="${ lfn:message('km-supervise:module.km.supervise') }" />
            <ui:varParam name="button">
                [
                <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
                    {"text": "${ lfn:message('button.add') }","href": "javascript:addDoc();","icon": "lui_icon_l_icon_65"}
                </kmss:authShow>
                ]
            </ui:varParam>
        </ui:combin>
        <div class="lui_list_nav_frame">
            <ui:accordionpanel>
              	<c:import url="/km/supervise/import/nav.jsp" charEncoding="UTF-8">
			         <c:param name="key" value="supervise"></c:param>
			         <c:param name="criteria" value="task"></c:param>
			      </c:import>
            </ui:accordionpanel>
        </div>
    </template:replace> --%>
    <template:replace name="body">
    	<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
    	<ui:tabpanel layout="sys.ui.tabpanel.list">
		 	<ui:content title="${lfn:message('km-supervise:py.RenWuZhiPai') }">
		    	<kmss:ifModuleExist  path = "/sys/task/">
		    		<c:import url="/sys/task/sys_task_supervise/sysTaskMain_supervise_index.jsp" charEncoding="UTF-8">
					</c:import>	
				</kmss:ifModuleExist>
			</ui:content>
		</ui:tabpanel>
        
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
    </template:replace>
</template:include>