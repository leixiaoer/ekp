<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="config.list">
	<template:replace name="path">
		<span class="txtlistpath">
			<div class="lui_icon_s lui_icon_s_home" style="float: left;"></div>
			<div style="float: left;margin:5px 10px;">
				<bean:message key="page.curPath" /><%=java.net.URLDecoder.decode(request.getParameter("s_path"), "utf-8")%>
			</div></span>
    </template:replace>
    <template:replace name="content">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('fssc-base:fsscBaseAccounts.fdName')}" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseAccounts" property="fdCode" expand="true" />
                <list:cri-criterion title="${lfn:message('fssc-base:fsscBaseAccounts.fdParent')}"  key="parentId" expand="true" multi="false">
					<list:box-select>
						<list:item-select id="parent-id">
							<ui:source type="AjaxXml">
								  {"url":"/sys/common/dataxml.jsp?s_bean=fsscBaseTreeService&modelName=com.landray.kmss.fssc.base.model.FsscBaseAccounts&fdCompanyId=&authCurrent=true"}
							</ui:source>
							<ui:event event="selectedChanged" args="evt">
								var vals = evt.values;
								if (vals.length > 0 && vals[0] != null) {
									var val = vals[0].value;
									LUI('parent-id').source.setUrl("/sys/common/dataxml.jsp?s_bean=fsscBaseTreeService&modelName=com.landray.kmss.fssc.base.model.FsscBaseAccounts&authCurrent=true&parentId="+val);
									LUI('parent-id').source.resolveUrl();
									LUI('parent-id').refresh();
								}
							</ui:event>
						</list:item-select>
					</list:box-select>
				</list:cri-criterion>
                <list:cri-criterion title="${lfn:message('fssc-base:fsscBaseAccounts.fdIsAvailable')}" key="fdIsAvailable">
					<list:box-select>
						<list:item-select  cfg-defaultValue="true">
							<ui:source type="Static">
							    [{text:'${ lfn:message('message.yes')}', value:'true'},
								{text:'${ lfn:message('message.no')}',value:'false'}]
							</ui:source>
						</list:item-select>
					</list:box-select>
				</list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseAccounts" property="docCreator" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBaseAccounts" property="docCreateTime" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="fdCode" text="${lfn:message('fssc-base:fsscBaseAccounts.fdCode')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="9" id="btn">
                        	<ui:button text="${lfn:message('fssc-base:button.showTree')}" onclick="switchTree()" order="1" />
	                       	<kmss:auth requestURL="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=add">
	                            <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
							<kmss:auth requestURL="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=enable">
                                <ui:button text="${lfn:message('fssc-base:button.enable') }" onclick="enable()" order="3" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=disable">
                                <ui:button text="${lfn:message('fssc-base:button.disable') }" onclick="disable()" order="3" />
                            </kmss:auth>
							<kmss:auth requestURL="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=post">
                                <ui:button text="${lfn:message('fssc-base:button.post') }" onclick="post()" order="5" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="6" id="btnDelete" />

                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdName;fdCode;fdParent.name;fdIsAvailable.name;docCreator.name;docCreateTime;operations" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccounts',
                templateName: '',
                basePath: '/fssc/base/fssc_base_accounts/fsscBaseAccounts.do',
                canDelete: '${canDelete}',
                mode: '',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
            seajs.use(['lui/dialog','lui/topic'],function(dialog,topic){
            	
            	//启用
            	window.enable = function(){
            		var ids = [];
                	$("[name=List_Selected]:checked").each(function(){
                		ids.push(this.value);
                	});
                	if(ids.length==0){
                		dialog.alert(listOption.lang.noSelect);
                		return;
                	}
                	var load = dialog.loading();
                	$.ajax({
                   		url:'${LUI_ContextPath}/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=enable',
                   		data:{ids:ids.join(";")},
                   		dataType:'json',
                   		success:function(rtn){
                   			load.hide();
                   			dialog.result(rtn);
                   			topic.publish("list.refresh");
                   		}
                	});
            	}
            	//禁用
            	window.disable = function(){
            		var ids = [];
                	$("[name=List_Selected]:checked").each(function(){
                		ids.push(this.value);
                	});
                	if(ids.length==0){
                		dialog.alert(listOption.lang.noSelect);
                		return;
                	}
                	var load = dialog.loading();
                	$.ajax({
                   		url:'${LUI_ContextPath}/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=disable',
                   		data:{ids:ids.join(";")},
                   		dataType:'json',
                   		success:function(rtn){
                   			load.hide();
                   			dialog.result(rtn);
                   			topic.publish("list.refresh");
                   		}
                	});
            	}
            })
        </script>
        <c:import url="/fssc/base/resource/jsp/fsscBaseImport_include.jsp">
        </c:import>
    </template:replace>
</template:include>