<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include ref="default.list">
    <template:replace name="title">
         <c:out value="${ lfn:message('km-supervise:module.km.supervise') }-${ lfn:message('km-supervise:module.km.supervise') }" />
     </template:replace>
     <template:replace name="path">
         <ui:menu layout="sys.ui.menu.nav">
             <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
             <ui:menu-item text="${ lfn:message('km-supervise:module.km.supervise') }" />
         </ui:menu>
     </template:replace>
     <template:replace name="nav">
         <!-- 新建按钮 -->
         <ui:combin ref="menu.nav.create">
             <ui:varParam name="title" value="${ lfn:message('km-supervise:module.km.supervise') }" />
             <ui:varParam name="button">
                 [
                 <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add">
                     {"text": "${ lfn:message('button.add') }","href": "javascript:addDoc();","icon": "lui_icon_l_icon_65"}
                 </kmss:auth>
                 ]
             </ui:varParam>
         </ui:combin>
         <div class="lui_list_nav_frame">
             <ui:accordionpanel>
               	<c:import url="/km/supervise/import/nav.jsp" charEncoding="UTF-8">
          <c:param name="key" value="supervise"></c:param>
          <c:param name="criteria" value="certificateCriteria"></c:param>
       </c:import>
             </ui:accordionpanel>
         </div>
     </template:replace>
    
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                
            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">
            	<!-- 全选 -->
				<div class="lui_list_operation_order_btn">
					<list:selectall></list:selectall>
				</div>
                <!-- 分页 -->
				<div class="lui_list_operation_page_top">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/km/supervise/km_supervise_concern/kmSuperviseConcern.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdSuperviseId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="docSubject;fdLead;fdFinishTime;fdStatus;fdSuperviseProgress;docCreateTime" />
                </list:colTable> 
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
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
            function addDoc() {
            	Com_OpenWindow("${LUI_ContextPath}/km/supervise/km_supervise_main/kmsuperviseMain.do?method=add");
            }
        </script>
    </template:replace>
</template:include>