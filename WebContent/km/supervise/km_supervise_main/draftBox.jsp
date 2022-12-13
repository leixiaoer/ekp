<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/sys/profile/resource/css/operations.css?s_cache=${LUI_Cache}"/>
		<div class="lui_list_operation">
			<div style='color: #979797;float: left;padding-top:1px;'>
				${ lfn:message('list.orderType') }：
			</div>
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<div style="float:left;">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
			<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
		<list:listview id="listview" cfg-criteriaInit="${empty param.categoryId?'false':'true'}">
			<ui:source type="AjaxJson">
					{url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.docStatus=10&q.mydoc=create&q.j_path=/draftBox'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" isDefault="true" layout="sys.ui.listview.columntable" 
					rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
					<%-- <list:col-checkbox></list:col-checkbox> --%>
					<list:col-serial></list:col-serial>
                    <list:col-auto></list:col-auto>
			</list:colTable>
		</list:listview> 
		<br>
	 	<list:paging></list:paging>
	 	<script type="text/javascript">
	 	var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.supervise.model.KmSuperviseMain";
	 	seajs.use(['lui/jquery', 'lui/dialog','lui/topic'], function($, dialog , topic) {
		 	//删除
	 		window.delDoc = function(){
	 			var values = [];
				$("input[name='List_Selected']:checked").each(function(){
						values.push($(this).val());
					});
				if(values.length==0){
					dialog.alert('<bean:message key="page.noSelect"/>');
					return;
				}
				url = '<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall&draft=true"/>';
				var config = {
					url : url, // 删除数据的URL
					data : $.param({"List_Selected":values},true), // 要删除的数据
					modelName : "com.landray.kmss.km.supervise.model.KmSuperviseMain" // 主要是判断此文档是否有部署软删除
				};
				// 通用删除方法
				Com_Delete(config, delCallback);
			};
			window.deleteDoc = function(fdId){
				var values = [];
					values.push(fdId);
				var url = '<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall&draft=true"/>';
				var config = {
					url : url, // 删除数据的URL
					data : $.param({"List_Selected":values},true), // 要删除的数据
					modelName : "com.landray.kmss.km.supervise.model.KmSuperviseMain" // 主要是判断此文档是否有部署软删除
				};
				// 通用删除方法
				Com_Delete(config, delCallback);
			};
			window.delCallback = function(data){
				topic.publish("list.refresh");
				dialog.result(data);
			};
			
			// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				topic.publish('list.refresh');
			});
	 	});
	 	</script>
	