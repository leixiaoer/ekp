<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include  ref="default.simple">
		<template:replace name="title">
            <c:out value="${ lfn:message('km-supervise:module.km.supervise') }-${ lfn:message('km-supervise:module.km.supervise') }" />
        </template:replace>
       <template:replace name="body">
            <div style="margin:5px 10px;">
                <!-- 筛选 -->
                <list:criteria id="criteria1">
                	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('km-supervise:kmSuperviseMain.docSubject') }"></list:cri-ref>
                    <list:cri-criterion expand="false" title="${ lfn:message('km-supervise:py.YuWoXiangGuan') }" key="mydoc" multi="false">
	                    <list:box-select>
	                        <list:item-select>
	                            <ui:source type="Static">
	                                [{text:'${ lfn:message('km-supervise:py.WoGuanZhuDe') }', value:'concern'},
	                                {text:'${ lfn:message('km-supervise:py.WoFuZeDe') }',value:'duty'},
	                                {text:'${ lfn:message('km-supervise:py.SuoYouDuBan') }',value:'manage'},
	                                {text:'${ lfn:message('km-supervise:py.ChaoSongWoDe') }',value:'copy'}]
	                            </ui:source>
	                        </list:item-select>
	                    </list:box-select>
                	</list:cri-criterion>
                    <list:cri-criterion title="${ lfn:message('km-supervise:kmSuperviseMain.fdStatus')}" key="docStatus"> 
						<list:box-select>
							<list:item-select cfg-defaultValue="30">
								<ui:source type="Static">
									[{text:'${ lfn:message('km-supervise:enums.doc_status.20')}', value:'20'},
									{text:'${ lfn:message('km-supervise:enums.doc_status.30')}',value:'30'},
									{text:'${ lfn:message('km-supervise:enums.doc_status.40')}',value:'40'},
									{text:'${ lfn:message('km-supervise:enums.doc_status.50')}',value:'50'}]
								</ui:source>
							</list:item-select>
						</list:box-select>
					</list:cri-criterion>
                    <list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseMain" property="fdLead" />
                    <list:cri-criterion title="${lfn:message('km-supervise:kmSuperviseMain.fdLevel')}" key="fdLevel" multi="false">
                        <list:box-select>
                            <list:item-select>
                                <ui:source type="Static">
                                    <%=KmSuperviseUtil.buildCriteria( "kmSuperviseLevelService", "fdId,fdName", null, null) %>
                                </ui:source>
                            </list:item-select>
                        </list:box-select>
                    </list:cri-criterion>
                    <list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseMain" property="fdFinishTime" />
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
                                <list:sort property="fdStatus" text="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}" group="sort.list" />
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
                        {url:appendQueryParameter('/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&categoryId=${JsParam.categoryId}')}
                    </ui:source>
                    <!-- 列表视图 -->
                    <list:colTable isDefault="false" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
                        <list:col-checkbox />
                        <list:col-serial/>
                        <list:col-auto props="docSubject;fdLead.name;fdStatus;fdSuperviseProgress;fdFinishTime;docCreateTime" /></list:colTable>
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
				});
			</script>
            <!-- 引入JS -->
			<script type="text/javascript" src="${LUI_ContextPath}/km/supervise/resource/js/index.js"></script>
        </template:replace>
    </template:include>