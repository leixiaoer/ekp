<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
    <div style="margin:5px 10px;">
		<!-- 筛选 -->
         <list:criteria id="${mydoc }"  channel="criteria${idNum }">
         	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('km-supervise:kmSupervise.items') }"></list:cri-ref>
            <list:cri-ref key="fdLeads" ref="criterion.sys.person" title="${lfn:message('km-supervise:kmSuperviseMain.fdLeads') }"></list:cri-ref>
               
               <list:cri-criterion title="${lfn:message('km-supervise:kmSuperviseMain.fdLevel')}" key="fdLevel"  multi="false">
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

                <!-- 全选 -->
				<div class="lui_list_operation_order_btn">
					<list:selectall channel="criteria${idNum }"></list:selectall>
				</div>
				<!-- 分割线 -->
				<div class="lui_list_operation_line"></div>
				<!-- 排序 -->
				<div class="lui_list_operation_sort_btn">
					<div class="lui_list_operation_order_text">
						${ lfn:message('list.orderType') }：
					</div>
					<div class="lui_list_operation_sort_toolbar">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" channel="criteria${idNum }">
                            <list:sort property="docCreateTime" text="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
                        </ui:toolbar>
                    </div>
                </div>
                <!-- 分页 -->
				<div class="lui_list_operation_page_top">
                    <list:paging channel="criteria${idNum }" layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">
                        	<!-- add -->
                        	 <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
                             	<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                             </kmss:authShow>
                            <kmss:authShow roles="ROLE_KMSUPERVISE_SUPERVISOR_EXPORT">
								<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport')" order="2" ></ui:button>
							</kmss:authShow>
                            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall">
                                  <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4"/>
                            </kmss:auth>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
            <!-- 列表 -->
            <list:listview id="listview${idNum }" channel="criteria${idNum }">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&type=audit&isCreateReview=true&q.j_path=/audit=&q.mydoc=${mydoc }')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" isDefault="true" layout="sys.ui.listview.columntable" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto/>
                </list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging channel="criteria${idNum }"></list:paging>
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
</div>