<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btnbar">
					    <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
                            <ui:button text="${lfn:message('button.add')}" onclick="addTemplate()" order="2" />
                        </kmss:authShow>
                       	<kmss:authShow roles="ROLE_KMSUPERVISE_IMPORT">
							<ui:button text="${lfn:message('km-supervise:kmSuperviseMain.import')}" onclick="importSupervise()" order="2" ></ui:button>
						</kmss:authShow>
                        <kmss:authShow roles="ROLE_KMSUPERVISE_SUPERVISOR_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport')" order="2" ></ui:button>
				     	</kmss:authShow>
                        <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall">
							<ui:button text="${lfn:message('button.deleteall')}" order="3" onclick="delDoc()"></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
			<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
		<list:listview id="listview1" cfg-criteriaInit="${empty param.categoryId?'false':'true'}">
			<ui:source type="AjaxJson">
					{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=create'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" isDefault="true" layout="sys.ui.listview.columntable" 
					rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
					<list:col-checkbox></list:col-checkbox>
					<list:col-serial></list:col-serial>
                    <list:col-auto props="docSubject;fdLead.name;fdStatus;fdSuperviseProgress;fdFinishTime;docCreateTime" />
			</list:colTable>
		</list:listview> 
		<br>
	 	<list:paging></list:paging>
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
            	  //批量导入证照
              	window.importSupervise = function() {
              		dialog.categoryForNewFile('com.landray.kmss.km.supervise.model.KmSuperviseTemplet', 
              				'/km/supervise/km_supervise_main/kmSupervise_upload.jsp?docTemplate=!{id}',
      		    			false,null,null);
              	};
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
              	window.addTemplate = function() {
              		dialog.categoryForNewFile(listOption.templateName, listOption.basePath + '?method=add&i.docTemplate=!{id}',
                            false,null,null,getValueByHash("docTemplate"),null,null,null,null,{"fdType":"10"});
              	};
             });
         </script>
	