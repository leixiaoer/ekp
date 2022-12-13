<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include file="/sys/profile/resource/template/list.jsp">
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('km-supervise:kmSuperviseTemplet.fdName')}" />
				<%-- 搜索条件:是否有效 --%>
				<list:cri-criterion title="${ lfn:message('km-supervise:kmSuperviseTemplet.fdIsAvailable')}" key="fdIsAvailable" multi="false" >
					<list:box-select>
						<list:item-select cfg-defaultValue="1">
							<ui:source type="Static">
								[{text:'${ lfn:message('km-supervise:kmSuperviseTemplet.fdIsAvailable.yes')}', value:'1'},
								{text:'${ lfn:message('km-supervise:kmSuperviseTemplet.fdIsAvailable.no')}',value:'0'}]
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
                        	<list:sortgroup>
	                            <list:sort property="fdOrder" text="${lfn:message('km-supervise:kmSuperviseTemplet.fdOrder')}" group="sort.list" value="up"/>
	                            <list:sort property="docCreateTime" text="${lfn:message('km-supervise:kmSuperviseTemplet.docCreateTime')}" group="sort.list" />
	                            <list:sort property="fdName" text="${lfn:message('km-supervise:kmSuperviseTemplet.fdName')}" group="sort.list" />
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
                        <ui:toolbar count="2">

                            <kmss:auth requestURL="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addTemplate()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
							<c:import url="/sys/right/cchange_tmp_right/cchange_tmp_right_button_new.jsp" charEncoding="UTF-8">
								<c:param name="mainModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
								<c:param name="tmpModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" />
								<c:param name="templateName" value="docTemplate" />
								<c:param name="authReaderNoteFlag" value="2" />
							</c:import>
							<c:import url="/sys/workflow/import/sysWfTemplate_auditorBtn.jsp" charEncoding="UTF-8">
								<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseTemplet"/>
								<c:param name="cateid" value="${param['q.docCategory']}"/>
							</c:import>
							<!-- 快速排序 -->
							<c:import url="/sys/profile/common/change_order_num.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.supervise.model.KmSuperviseTemplet"></c:param>
								<c:param name="property" value="fdOrder"></c:param>
							</c:import>
							<c:import url="/sys/xform/lang/include/sysFormCommonMultiLang_button_new.jsp" charEncoding="UTF-8">
								<c:param name="fdModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" />
								<c:param name="isCommonTemplate" value ="false"/>
							</c:import>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=data&_fdType=${param.fdType }')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=view&fdId=!{fdId}&fdKey=${param.fdKey }" name="columntable">
                    <list:col-checkbox />
                    <list:col-auto props="fdOrder;fdName;fdIsAvailable;docCreator.fdName;docCreateTime;operations" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
                templateName: '',
                basePath: '/km/supervise/km_supervise_templet/kmSuperviseTemplet.do',
                canDelete: '${canDelete}',
                mode: 'config_template',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
            seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
                function getValueByHash(key){
                    var value = Com_GetUrlParameter(location.href, 'q.'+key);
                    if(value){
                        return value;
                    }
                    var hash = window.location.hash;
                    if(hash.indexOf(key)<0){
                        return "";
                    }
                    var url = hash.split("cri.q=")[1];
                        var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
                    var r=url.match(reg);
                    if(r!=null){
                        return unescape(r[2]);
                    }
                    return "";
                }
                window.addTemplate = function(){
                    dialog.categoryForNewFile(listOption.modelName, listOption.basePath + '?method=add&i.docCategory=!{id}&fdType=${param.fdType}&fdKey=${param.fdKey }',
                            false,null,null,getValueByHash("docCategory"),null,null,false);
                };
            	// 编辑
		 		window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do" />?method=edit&fdId=' + id +'&fdKey=${param.fdKey }');
		 		};
		 		window.deleteTemplet = function(id){
					var values = [];
					if(id) {
		 				values.push(id);
			 		} 
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					var url = '<c:url value="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=deleteall"/>';
					var config = {
						url : url, // 删除数据的URL
						data : $.param({"List_Selected":values},true), // 要删除的数据
						modelName : "com.landray.kmss.km.supervise.model.KmSuperviseTemplet"
					};
					// 通用删除方法
					Com_Delete(config, delCallback);
				};
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
		 	});
        </script>
    </template:replace>
</template:include>