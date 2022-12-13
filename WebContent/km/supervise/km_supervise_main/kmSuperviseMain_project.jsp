<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
    <template:include ref="default.simple">
        <template:replace name="title">
            <c:out value="${ lfn:message('km-supervise:module.km.supervise') }-${ lfn:message('km-supervise:module.km.supervise') }" />
        </template:replace>
        <%-- <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('km-supervise:module.km.supervise') }" />
                <ui:menu-item text="${ lfn:message('km-supervise:kmSuperviseMain.approved') }" />
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
			          <c:param name="criteria" value="project"></c:param>
			       </c:import>
                </ui:accordionpanel>
            </div>
        </template:replace> --%>
        <template:replace name="body">
            <div style="margin:5px 10px;">
                <!-- 筛选 -->
                <list:criteria id="project">
                	<list:cri-criterion expand="false" title="${lfn:message('km-supervise:lbpm.my')}" key="mydoc" multi="false">
                        <list:box-select>
                            <list:item-select>
                                <ui:source type="Static">
                                    [{text:'${ lfn:message('km-supervise:lbpm.create.my') }', value:'create'},{text:'${ lfn:message('km-supervise:lbpm.approval.my') }',value:'approval'}, {text:'${ lfn:message('km-supervise:lbpm.approved.my') }', value: 'approved'}]
                                </ui:source>
                            </list:item-select>
                        </list:box-select>
                    </list:cri-criterion>
                    <list:cri-criterion title="${ lfn:message('km-supervise:kmSuperviseMain.docStatus')}" key="docStatus"> 
						<list:box-select>
							<list:item-select cfg-defaultValue="30">
								<ui:source type="Static">
									[{text:'${lfn:message('status.draft') }', value:'10'},
									{text:'${lfn:message('status.examine') }',value:'20'},
									{text:'${lfn:message('status.refuse') }',value:'11'},
									{text:'${lfn:message('km-supervise:status.publish') }',value:'30'},
									{text:'${lfn:message('status.discard') }',value:'00'}]
								</ui:source>
							</list:item-select>
						</list:box-select>
					</list:cri-criterion>
					<list:cri-criterion title="${lfn:message('km-supervise:kmSuperviseMain.type')}" key="fdLevel" multi="false">
                        <list:box-select>
                            <list:item-select>
                                <ui:source type="Static">
                                    <%=KmSuperviseUtil.buildCriteria( "kmSuperviseLevelService", "fdId,fdName", null, null) %>
                                </ui:source>
                            </list:item-select>
                        </list:box-select>
                    </list:cri-criterion>
                    <list:cri-ref key="docCreator" ref="criterion.sys.person" title="发起人"></list:cri-ref>
                    <list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseMain" property="docCreateTime;fdFinishTime" />
                </list:criteria>
                <!-- 操作 -->
                <div class="lui_list_operation">

                    <div style='color: #979797;float: left;padding-top:1px;'>
                        ${ lfn:message('list.orderType') }：
                    </div>
                    <div style="float:left">
                        <div style="display: inline-block;vertical-align: middle;">
                            <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sortgroup>
                                <list:sort property="docCreateTime" text="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime')}" group="sort.list" />
                                <list:sort property="fdFinishTime" text="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}" group="sort.list" />
                            </list:sortgroup>
                            </ui:toolbar>
                        </div>
                    </div>
                    <div style="float:left;">
                        <list:paging layout="sys.ui.paging.top" />
                    </div>
                    <div style="float:right">
                        <div style="display: inline-block;vertical-align: middle;">
                            <ui:toolbar count="3">

                                <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
                                    <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                                </kmss:authShow>
                                <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall">
                                    <c:set var="canDelete" value="true" />
                                </kmss:auth>
                                <!---->
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
                        {url:appendQueryParameter('/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data')}
                    </ui:source>
                    <!-- 列表视图 -->
                    <list:colTable isDefault="false" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
                        <list:col-checkbox />
                        <list:col-serial/>
                        <list:col-auto props="docSubject;docCreator.name;docCreateTime;docStatus;nodeName;fdFinishTime;handlerName" /></list:colTable>
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
            </script>
        </template:replace>
    </template:include>