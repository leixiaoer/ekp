<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.simple" spa="true">
    <template:replace name="title">
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }-${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
    <template:replace name="body">
    		<script type="text/javascript">
				seajs.use(['theme!list']);	
			</script>
            <!-- 筛选 -->
            <list:criteria id="criteria1">
            	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:supervise_task_docSubject') }">
				</list:cri-ref>
            	<list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false" expand="false" title="${ lfn:message('km-supervise:kmSuperviseMain.criteria.fdTemplate') }">
					<list:varParams modelName="com.landray.kmss.km.supervise.model.KmSuperviseTemplet"/>
				</list:cri-ref>
            	<list:cri-ref key="fdOperator" ref="criterion.sys.person" title="终止人"></list:cri-ref>
            	<list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseMainStop" property="fdStopTime" />
            	<list:cri-criterion expand="false" title="${ lfn:message('km-supervise:py.YuWoXiangGuan') }" key="mydoc" multi="false">
                 <list:box-select>
                     <list:item-select >
                         <ui:source type="Static">
                             [{text:'${ lfn:message('km-supervise:py.WoQiCaoDe') }', value:'create'},
                             {text:'${ lfn:message('km-supervise:py.DaiWoShenDe') }',value:'approval'},
                             {text:'${ lfn:message('km-supervise:py.WoYiShenDe') }',value:'approved'}]
                         </ui:source>
                     </list:item-select>
                 </list:box-select>
            	</list:cri-criterion>
            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">
                <!-- 全选 -->
				<%-- <div class="lui_list_operation_order_btn">
					<list:selectall></list:selectall>
				</div> --%>
				<!-- 分割线 -->
				<!-- <div class="lui_list_operation_line"></div> -->
				<!-- 排序 -->
				<div class="lui_list_operation_sort_btn">
					<div class="lui_list_operation_order_text">
						${ lfn:message('list.orderType') }：
					</div>
					<div class="lui_list_operation_sort_toolbar">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                        	<list:sortgroup>
                        		<list:sort property="fdStopTime" text="${lfn:message('km-supervise:kmSuperviseMainStop.fdStopTime')}" group="sort.list" value="down"/>
	                        </list:sortgroup>
                        </ui:toolbar>
                    </div>
                </div>
                <!-- 分页 -->
				<div class="lui_list_operation_page_top">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3" id="Btntoolbar">
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:'/km/supervise/km_supervise_main_stop/kmSuperviseMainStop.do?method=list'}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMainStop" isDefault="true" layout="sys.ui.listview.columntable" rowHref="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop.do?method=view&fdId=!{fdId}" name="columntable">
                    <%-- <list:col-checkbox /> --%>
                    <list:col-serial/>
                    <list:col-auto props="kmSuperviseMain.docTemplate.name;kmSuperviseMain.docSubject;kmSuperviseMain.fdStartTime;kmSuperviseMain.fdFinishTime;fdStopTime;fdOperator.name;fdStopDesc"/>
                </list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
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