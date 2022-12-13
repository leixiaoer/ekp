<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>

<template:include file="/sys/profile/resource/template/list.jsp">
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
            	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('km-supervise:kmSupervise.items') }"></list:cri-ref>
               <%--  <list:cri-criterion expand="false" title="${lfn:message('km-supervise:lbpm.my')}" key="mydoc" multi="false">
                    <list:box-select>
                        <list:item-select>
                            <ui:source type="Static">
                                [{text:'${ lfn:message('km-supervise:lbpm.create.my') }', value:'create'},{text:'${ lfn:message('km-supervise:lbpm.approval.my') }',value:'approval'}, {text:'${ lfn:message('km-supervise:lbpm.approved.my') }', value: 'approved'}]
                            </ui:source>
                        </list:item-select>
                    </list:box-select>
                </list:cri-criterion> --%>
                <list:cri-criterion expand="false" title="${ lfn:message('km-supervise:py.DuBanYiLan') }" key="mydoc" multi="false">
                 <list:box-select>
                     <list:item-select>
                         <ui:source type="Static">
                             [{text:'${ lfn:message('km-supervise:py.WoGuanZhuDe') }', value:'concern'},
                             {text:'${ lfn:message('km-supervise:py.WoFuZeDe') }',value:'duty'},
                             {text:'${ lfn:message('km-supervise:py.ChaoSongWoDe') }',value:'copy'}]
                         </ui:source>
                     </list:item-select>
                 </list:box-select>
            	</list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseMain" property="docStatus" />
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
                            <list:sort property="docCreateTime" text="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime')}" group="sort.list" value="down"/>
                            <list:sort property="fdFinishTime" text="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}" group="sort.list" />
                            <list:sort property="fdStatus" text="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}" group="sort.list" />
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
                        <ui:toolbar count="3">
                            <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:authShow>
                            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall&categoryId=${JsParam.categoryId}" requestMethod="GET">
                                 <ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc('${JsParam.categoryId}')" order="4" />
                            </kmss:auth>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            
        	  <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=tempData&categoryId=${JsParam.categoryId}&isShowAll=${JsParam.isShowAll }&nodeType=${nodeType }&q.j_path=/createReview'}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto/>
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
         //删除
			window.delDoc = function(cateId){
				var values = [];
				$("input[name='List_Selected']:checked").each(function(){
						values.push($(this).val());
					});
				if(values.length==0){
					dialog.alert('${lfn:message("page.noSelect")}');
					return;
				}
				/* 软删除配置 */
				var url='<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall"/>'+'&categoryId='+cateId;
				var config = {
					url : url, // 删除数据的URL
					data : $.param({"List_Selected":values},true), // 要删除的数据
					modelName : "com.landray.kmss.km.supervise.model.KmSuperviseMain"
				};
				// 通用删除方法
				Com_Delete(config, delCallback);
			};
      	</script>

    </template:replace>
</template:include>