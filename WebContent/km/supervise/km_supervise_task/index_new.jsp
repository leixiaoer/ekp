<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include ref="default.simple" spa="true">
    <template:replace name="title">
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }-${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
    <template:replace name="body">
    	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
    	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/sys/profile/resource/css/operations.css?s_cache=${LUI_Cache}"/>
    		<script type="text/javascript">
				seajs.use(['theme!list']);	
			</script>
            <!-- 筛选 -->
            <list:criteria id="criteria1">
				<list:cri-ref key="mainDocSubject" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:supervise_task_docSubject') }">
				</list:cri-ref>
	            <list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false" expand="false" title="${ lfn:message('km-supervise:kmSuperviseMain.criteria.fdTemplate') }">
					<list:varParams modelName="com.landray.kmss.km.supervise.model.KmSuperviseTemplet"/>
				</list:cri-ref>
                <list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseTask" property="fdSponsor;fdPlanStartTime;fdPlanEndTime" />
            	<list:cri-criterion expand="false" title="${ lfn:message('km-supervise:py.YuWoXiangGuan') }" key="mydoc" multi="false">
                 <list:box-select>
                     <list:item-select cfg-enable="false">
                         <ui:source type="Static">
                             [{text:'${ lfn:message('km-supervise:py.py.WoZhiPaiDe') }', value:'create'},
                             {text:'${ lfn:message('km-supervise:py.DaiWoShenDe') }',value:'approval'}]
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
                        		<list:sort property="fdPlanStartTime" text="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" group="sort.list" value="down"/>
                        		<list:sort property="fdPlanEndTime" text="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" group="sort.list" />
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
                            <!-- 批量催办 -->
                            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=urgeall">
                                <ui:button text="${lfn:message('km-supervise:py.CuiBanAll')}" onclick="urgeAll()" order="4" />
                            </kmss:auth>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:'/km/supervise/km_supervise_task/kmSuperviseTask.do?method=data&q.j_path=/RenWuZhiPai'}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseTask" isDefault="true" layout="sys.ui.listview.columntable" rowHref="/km/supervise/km_supervise_task/kmSuperviseTask.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdSupervise.docTemplate.name;fdSupervise.docSubject;fdPlanEndTime;docContent;fdUnit.name;fdSponsor.name;fdBackTime;fdTaskProgress;fdStatus;operations"/>
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
            seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'],function($,dialog,topic,toolbar){
        		
            	//新建督办
            	window.addDoc = function() {
            		dialog.categoryForNewFile(
            				'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
            				'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}',false,null,null,null,null,null,true,null,{"fdType":"10"});
            	}
            	
				//批量催办
				window.urgeAll = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					if(values.length==0){
						dialog.alert('${lfn:message("page.noSelect")}');
						return;
					}
					window.del_load = dialog.loading();
					$.ajax({
						url: Com_Parameter.ContextPath+'km/supervise/km_supervise_urge/kmSuperviseUrge.do?method=urgeTask',
						type: 'POST',
						data:$.param({"List_Selected":values},true),
						dataType: 'json',
						error: function(data){
							if(window.del_load!=null){
								window.del_load.hide(); 
							}
							dialog.failure('${lfn:message("return.optFailure")}');
						},
						success: topCallback
					});		
					
				}
				
				window.topCallback = function(data){
					if(window.del_load!=null)
						window.del_load.hide();
					if(data!=null && data.status==true){
						dialog.success('${lfn:message("return.optSuccess")}');
					}else{
						dialog.failure('${lfn:message("return.optFailure")}');
					}
				};
				
				window.urgeDoc = function(id){
					var values = [];
					if(id) {
		 				values.push(id);
			 		} 
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					window.del_load = dialog.loading();
					$.ajax({
						url: Com_Parameter.ContextPath+'km/supervise/km_supervise_urge/kmSuperviseUrge.do?method=urgeTask',
						type: 'POST',
						data:$.param({"List_Selected":values},true),
						dataType: 'json',
						error: function(data){
							if(window.del_load!=null){
								window.del_load.hide(); 
							}
							dialog.failure('${lfn:message("return.optFailure")}');
						},
						success: topCallback
					});		
				}
            }); 	
    	</script>
    </template:replace>
</template:include>