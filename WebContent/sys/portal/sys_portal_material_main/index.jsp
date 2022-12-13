<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="/sys/ui/jsp/common.jsp"%>

        <template:include ref="default.print" sidebar="no">
            <template:replace name="title">
                <c:out value="${ lfn:message('sys-portal:module.sys.portal') }-${ lfn:message('sys-portal:table.sysPortalMaterialMain') }" />
            </template:replace>
            <template:replace name="content">
                <link rel="stylesheet" type="text/css" href="${LUI_ContextPath}/sys/portal/sys_portal_material_main/source/material_main.css" />
                <script>
                    Com_IncludeFile('doclist.js|jquery.js|plugin.js');
                    Com_IncludeFile("material_main.js", "${LUI_ContextPath}/sys/portal/sys_portal_material_main/source/", 'js', true);
                    var mType = '${param.type}';
                    mType = mType ? mType : '1';
                    var listOption = {
                        contextPath: '${LUI_ContextPath}',
                        jPath: 'material_main',
                        modelName: 'com.landray.kmss.sys.portal.model.SysPortalMaterialMain',
                        templateName: '',
                        basePath: '/sys/portal/sys_portal_material_main/sysPortalMaterialMain.do',
                        canDelete: '${canDelete}',
                        mode: '',
                        templateService: '',
                        templateAlert: '${lfn:message("sys-portal:treeModel.alert.templateAlert")}',
                        customOpts: {
                            ____fork__: 0
                        },
                        lang: {
                            noSelect: '${lfn:message("page.noSelect")}',
                            comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                        }
                    };
                 
                </script>
                <style>
                
                
                </style>
                <div style="margin: 5px 10px;">
	                <div class="lui_material_type_bar">
		                <span class="clicked" >${ lfn:message('sys-portal:sysPortalMaterialMain.type.pic')}</span>
		                 <span onclick=' Com_OpenWindow("${LUI_ContextPath}/sys/portal/sys_portal_material_main/index_icon.jsp","_self");'>
		                 ${ lfn:message('sys-portal:sysPortalMaterialMain.type.icon')}</span>
	                </div>
                 	<list:criteria id="criteria_pic">
                                <list:cri-ref key="fdTagsName" ref="criterion.sys.docSubject" title="${ lfn:message('sys-portal:sysPortalMaterialMain.search.help')}" />
                            </list:criteria>
                            <!-- 筛选 -->
                            <!-- 操作 -->
                            <div class="lui_list_operation lui_list_operation_pic">
                            	 <div style='float: left; padding-top: 1px;'>
                             		 <label style='color:#333333'><input type="checkbox"  name="selectAll" onclick="selectAll()">
                           			 ${ lfn:message('sys-portal:sysPortalMaterialMain.btn.selectAll')} &emsp;</label>
                                 </div>
                                <div style='color: #979797; float: left; padding-top: 1px;'>
                                    ${ lfn:message('list.orderType') }：</div>
                                <div style="float: left">
                                    <div style="display: inline-block; vertical-align: middle;">
                                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                                            <list:sort property="sysPortalMaterialMain.docCreateTime" text="${lfn:message('sys-portal:sysPortalMaterialMain.docCreateTime')}" group="sort.list" />
                                        </ui:toolbar>
                                    </div>
                                </div>
                                <div style="float: left;">
                                    <list:paging layout="sys.ui.paging.top" />
                                </div>
                                <div style="float: right">
                                    <div style="display: inline-block; vertical-align: middle;">
                                        <ui:toolbar count="3">
                                            <!-- 上传 -->
                                            <kmss:auth requestURL="/sys/portal/sys_portal_material_main/sysPortalMaterialMain.do?method=add">
                                                <ui:button text="${ lfn:message('sys-portal:sysPortalMaterialMain.btn.upload')}" onclick="uploadDoc('1')" order="2" />
                                            </kmss:auth>
                                            <!-- 删除  批量  -->
                                            <kmss:auth requestURL="/sys/portal/sys_portal_material_main/sysPortalMaterialMain.do?method=deleteall">
                                                <c:set var="canDelete" value="true" />
                                            </kmss:auth>
                                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                                        </ui:toolbar>
                                    </div>
                                </div>
                            </div>
                            <ui:fixed elem=".lui_list_operation_pic" />
                            <list:listview id="listview_pic">
                                <ui:source type="AjaxJson">
                                    {url:'/sys/portal/sys_portal_material_main/sysPortalMaterialMain.do?method=gridData&type=1'}
                                </ui:source>
                                <list:gridTable name="gridtable_pic" columnNum="3" gridHref="">
                                    <list:row-template>
                                        var XSSPattern = new RegExp("[$&(){}':,\\[\\].<>]","g");
                                        grid['fdName']= grid['fdName'].replace(XSSPattern, '');
                                        {$
                                        <!-- #####################################grid item start[pic]###########################################################  -->
                                        <div class="lui_material_view_box lui_material_vbox_pic">
                                            <div class="lui_material_img">
                                                <img src="${LUI_ContextPath }{% grid['imageUrl']%}" alt="">
                                                <div class="lui_material_cover">
                                                    <div class="lui_material_cover_preview">
                                                        <span onclick="onPreview('{% grid['imageUrl']%}','{%grid['fdName']%}')"><em>${ lfn:message('sys-portal:sysPortalMaterialMain.btn.preview')}</em></span>
                                                    </div>
                                                    <div class="lui_material_cover_option">
                                                        <span onclick="onEdit('{%grid['fdId']%}')">${ lfn:message('sys-portal:sysPortalMaterialMain.btn.edit')}</span>
                                                        <span onclick="onDeleteItem('{% grid['fdId']%}')">${ lfn:message('sys-portal:sysPortalMaterialMain.btn.del')}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="lui_material_text">
                                                <p class="lui_material_text_title">
                                                    <input type="checkbox" value="{% grid['fdId']%}" name="List_Selected">
                                                    <%--onclick="Com_OpenWindow('${LUI_ContextPath }/sys/portal/sys_portal_material_main/sysPortalMaterialMain.do?method=view&fdId={% grid['fdId']%}','——blank');" --%>
                                                        <b> {%grid['fdName']%}</b>
                                                </p>
                                                <p class="lui_material_text_tags">{%grid['tags']%}</p>
                                            </div>
                                        </div>
                                        <!-- #####################################grid item end###########################################################  -->
                                        $}
                                    </list:row-template>
                                </list:gridTable>
                            </list:listview>
                            <!-- 翻页 -->
                            <list:paging />
                </div>   
            </template:replace>
        </template:include>
        <script>
        var isAll = false;
        window.selectAll=function(){
			isAll = !isAll;
			if(isAll){
				//全选
				$("input[name='List_Selected']").each(function(idx,ele){
					$(ele).prop("checked",true)
				});
			}else{
				//清空
				$("input[name='List_Selected']").each(function(idx,ele){
					$(ele).prop("checked",false)
				});
			}
		}
        //素材库宽度未匹配页面宽度
        $(document).ready(function() {
            $(".lui_print_main_content").removeClass("lui_print_main_content");
        });
        </script>