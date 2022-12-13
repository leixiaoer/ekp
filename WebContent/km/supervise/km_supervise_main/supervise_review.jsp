<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
			<script type="text/javascript">
				seajs.use(['theme!list']);	
			</script>
            <!-- 筛选 -->
            <list:criteria id="criteria1">
            	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:supervise_task_docSubject') }">
				</list:cri-ref>
				<list:tab-criterion title="" key="docStatus"> 
			   		 <list:box-select>
			   		 	<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas" >
							<ui:source type="Static">
								[{text:'${ lfn:message('status.draft') }', value:'10'},
								{text:'${ lfn:message('status.examine') }', value:'20'},
								{text:'${ lfn:message('status.refuse') }', value:'11'},
								{text:'${ lfn:message('status.publish') }', value:'30'},
								{text:'${ lfn:message('status.discard') }',value:'00'}]
							</ui:source>
						</list:item-select>
			    	</list:box-select>
			    </list:tab-criterion>
            	<list:cri-ref ref="criterion.sys.category" key="fdTemplate" multi="false" expand="false" title="${ lfn:message('km-supervise:kmSuperviseMain.criteria.fdTemplate') }">
					<list:varParams modelName="com.landray.kmss.km.supervise.model.KmSuperviseTemplet"/>
				</list:cri-ref>
				<list:cri-ref key="docCreator" ref="criterion.sys.person" title="立项人"></list:cri-ref>
                <list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseMain" property="fdApprovalTime;fdStartTime;fdFinishTime" />
            	<list:cri-criterion expand="false" title="${ lfn:message('km-supervise:py.YuWoXiangGuan') }" key="mydoc" multi="false">
                 <list:box-select>
                     <list:item-select cfg-enable="false">
                         <ui:source type="Static">
                             [{text:'${ lfn:message('km-supervise:py.py.WoQiCaoDe') }', value:'create'},
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
	                            <list:sort property="fdStartTime" text="${lfn:message('km-supervise:kmSuperviseMain.fdStartTime')}" group="sort.list" />
	                            <list:sort property="fdApprovalTime" text="${lfn:message('km-supervise:kmSuperviseMain.fdApprovalTime')}" group="sort.list" value="down"/>
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
                            <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:authShow>
                            
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&isCreateReview=true'}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" isDefault="true" layout="sys.ui.listview.columntable" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
                    <%-- <list:col-checkbox /> --%>
                    <list:col-serial/>
                    <list:col-auto/>
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
                    canDelete: 'false',
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