<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
    <template:include ref="default.simple" spa="true">
        <template:replace name="title">
            <c:out value="${ lfn:message('km-supervise:module.km.supervise') }-${ lfn:message('km-supervise:module.km.supervise') }" />
        </template:replace>
       <%--  <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('km-supervise:module.km.supervise') }" />
                <ui:menu-item text="${ lfn:message('km-supervise:py.DuBanKaoPing') }" />
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
			          <c:param name="criteria" value="remark"></c:param>
			       </c:import>
                </ui:accordionpanel>
            </div>
        </template:replace> --%>
        <template:replace name="body">
        	<script type="text/javascript">
				seajs.use(['theme!list']);	
			</script>
		<ui:tabpanel layout="sys.ui.tabpanel.list">
		  <ui:content title="${lfn:message('km-supervise:py.DuBanKaoPing') }">
            <div style="margin:5px 10px;">
                <!-- 筛选 -->
                <list:criteria id="remark">
                	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('km-supervise:kmSupervise.items') }"></list:cri-ref>
                    <list:cri-criterion expand="true" title="${lfn:message('km-supervise:py.DuBanKaoPing')}" key="mydoc" multi="false">
                        <list:box-select>
                            <list:item-select>
                                <ui:source type="Static">
                                    [{text:'${ lfn:message('km-supervise:py.DaiWoKaoPing') }', value:'noRemark'},
                                    {text:'${ lfn:message('km-supervise:py.WoYiKaoPing') }', value: 'remarked'}]
                                </ui:source>
                            </list:item-select>
                        </list:box-select>
                    </list:cri-criterion>
                </list:criteria>
                <!-- 操作 -->
                <div class="lui_list_operation">
					<!-- 全选 -->
					<div class="lui_list_operation_order_btn">
						<list:selectall></list:selectall>
					</div>
					<!-- 分割线 -->
					<div class="lui_list_operation_line"></div>
					<!-- 排序 -->
					<div class="lui_list_operation_sort_btn">
						<div class="lui_list_operation_order_text">
							${ lfn:message('list.orderType') }：
						</div>
						<div class="lui_list_operation_sort_toolbar">
                            <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                                <list:sort property="fdFinishLevel" text="${lfn:message('km-supervise:kmSuperviseMain.fdFinishLevel')}" group="sort.list" value="down"/>
                            </ui:toolbar>
                        </div>
                    </div>
                    <!-- 分页 -->
					<div class="lui_list_operation_page_top">
                        <list:paging layout="sys.ui.paging.top" />
                    </div>
                    <div style="float:right">
                        <div style="display: inline-block;vertical-align: middle;">
                            <ui:toolbar count="3">
                                <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall">
                                    <c:set var="canDelete" value="true" />
                                </kmss:auth>
                            <kmss:authShow roles="ROLE_KMSUPERVISE_SUPERVISOR_EXPORT">
								<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport')" order="2" ></ui:button>
							</kmss:authShow>
                                <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            </ui:toolbar>
                        </div>
                    </div>
                </div>
                <ui:fixed elem=".lui_list_operation" />
                	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
                <!-- 列表 -->
                <list:listview id="listview">
                    <ui:source type="AjaxJson">
                        {url:appendQueryParameter('/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&type=remark&q.j_path=/DuBanKaoPing')}
                    </ui:source>
                    <!-- 列表视图 -->
                    <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" isDefault="true" layout="sys.ui.listview.columntable" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}&remark=!{fdRemarkStatus}" name="columntable">
                        <list:col-checkbox />
                        <list:col-serial/>
                        <list:col-auto />
                    </list:colTable>
                </list:listview>
                <!-- 翻页 -->
                <list:paging />
            </div>
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