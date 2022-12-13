<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.geesun.annual.model.GeesunAnnualUse";
seajs.use(['lui/jquery', 'lui/dialog','lui/topic','lui/toolbar'],function($, dialog, topic, toolbar) {
	//删除
	window.delUseDoc = function(){
		var values = [];
		$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
			});
		if(values.length==0){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		var url  = '<c:url value="/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=deleteall"/>';
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
					success: delUseCallback
			   });
			}
		});
	};
	window.delUseCallback = function(data){
		if(window.del_load!=null){
			window.del_load.hide(); 
			topic.publish("list.refresh");
		}
		dialog.result(data);
	};
});
</script>
		<!-- 查询条件  -->
		<list:criteria id="criteria1">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('geesun-annual:geesunAnnualUse.docSubject')}" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualUse" property="fdModelId" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualUse" property="fdModelName" />
                <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualUse" property="fdUse" />
		</list:criteria>
		 
		<!-- 列表工具栏 -->
		<div class="lui_list_operation">
			<table width="100%">
				<tr>
					<div style='color: #979797;float: left;padding-top:1px;'>
						${ lfn:message('list.orderType') }：
					</div>
					<div style="float:left">
						<div style="display: inline-block;vertical-align: middle;">
							<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
								<list:sort property="geesunAnnualUse.docCreateTime" text="${lfn:message('geesun-annual:geesunAnnualUse.docCreateTime')}" group="sort.list" />
							</ui:toolbar>
						</div>
					</div>
					<div style="float:left;">	
						<list:paging layout="sys.ui.paging.top" > 		
						</list:paging>
					</div>
					<div style="float:right">
						<div style="display: inline-block;vertical-align: middle;">
							<ui:toolbar id="Btntoolbar">
								<kmss:authShow roles="ROLE_GEESUNANNUAL_ADMIN">
									<ui:button id="del" text="${lfn:message('button.delete')}" order="1" onclick="delUseDoc();"></ui:button>
								</kmss:authShow>
							</ui:toolbar>
						</div>
					</div>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
	 	<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=data'}
			</ui:source>
			<!-- 列表视图 -->	
			<list:colTable isDefault="true" name="columntable" layout="sys.ui.listview.columntable" rowHref="/geesun/annual/geesun_annual_use/geesunAnnualUse.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="docSubject;fdModelId;fdUse;docCreator.name;docCreateTime;fdAnnual.name"></list:col-auto>
			</list:colTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>		 	