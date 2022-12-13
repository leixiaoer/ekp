<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp" spa="true">
	<template:replace name="content">
	  <%-- 筛选器 --%>	
	  <list:criteria id="criteria1" multi="true">
			<list:cri-auto modelName="com.landray.kmss.km.institution.model.KmInstitutionKnowledgeAbolish" property="docSubject,docCreator,docCreateTime"/>
			<%-- 搜索条件:状态 --%>	
			<list:cri-criterion title="${ lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docStatus')}" key="docStatus" >
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[
							{text:'${ lfn:message('km-institution:kmInstitution.status.examine') }',value:'20'}, {text:'${ lfn:message('km-institution:kmInstitution.status.refuse') }', value: '11'},
							{text:'${ lfn:message('km-institution:kmInstitution.status.discard') }', value:'00'},{text:'${ lfn:message('km-institution:kmInstitution.status.publish') }', value:'30'}
							]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
	  </list:criteria>
	  <div class="lui_list_operation">
	  		<!-- 全选 -->
			<div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
			</div>
	  		<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar">
						<kmss:auth requestURL="/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=deleteall" requestMethod="GET">
							<ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll();" order="2" ></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
	    <ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=list&q.mydoc=${JsParam.mydoc }&q.j_path=${JsParam.path }'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
				rowHref="/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="docSubject,docStatus,docCreator.fdName,docCreateTime,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
	 	<list:paging></list:paging>	
	 	<script type="text/javascript">
	 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
		 	window.deleteAll = function(id){
				var values = [];
				if(id) {
	 				values.push(id);
		 		} else {
					$("input[name='List_Selected']:checked").each(function() {
						values.push($(this).val());
					});
		 		}
				if(values.length==0){
					dialog.alert('<bean:message key="page.noSelect"/>');
					return;
				}
				var url = '<c:url value="/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=deleteall"/>';
				dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
					if(value==true){
						window.del_load = dialog.loading();
						$.ajax({
							url: url,
							type: 'POST',
							data:$.param({"List_Selected":values},true),
							dataType: 'json',
							error: function(data){
								if(window.del_load!=null){
									window.del_load.hide(); 
								}
								dialog.result(data.responseJSON);
							},
							success: delCallback
					   });
					}
				});
			};
			window.delCallback = function(data){
				if(window.del_load!=null){
					window.del_load.hide();
					topic.publish("list.refresh");
				}
				dialog.result(data);
			};
	 	});
	 	</script>
	</template:replace>
</template:include>
