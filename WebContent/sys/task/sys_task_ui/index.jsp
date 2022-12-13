<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
	<script type="text/javascript">
		seajs.use(['theme!list']);	
	</script>
	<style>
		.listview .columnTable .lui_listview_body {
			overflow-x:inherit;
		}
	</style>
	<%--右侧--%>
		<list:criteria id="sysTaskMainCriteria">
			<%-- 主题、任务状态、任务接收人、任务指派人、接收人部门、指派人部门、要求完成时间--%>
			<%-- 搜索条件:任务名称--%>
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:sysTaskMain.docSubject') }">
			</list:cri-ref>
			
			<%--任务状态--%>
			<list:cri-criterion title="${ lfn:message('sys-task:sysTaskMain.fdStatus') }" key="taskStatus" >
				<list:box-select><list:item-select>
					<ui:source type="Static">
							[{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.inactive') }', value:'1'},
							{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.progress') }',value:'2'}, 
							{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.complete') }', value: '3'},
							{text:'${ lfn:message('sys-task:sysTaskMain.status.overrule') }', value: '5'},
							{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.terminate') }', value: '4'},
							{text:'${ lfn:message('sys-task:tree.sysTaskMain.status.close') }', value: '6'}]
						</ui:source>
				</list:item-select></list:box-select>
			</list:cri-criterion>
			
			<%--是否过期--%>
			<list:cri-criterion title="${ lfn:message('sys-task:sysTaskMain.fdPastDue') }" key="fdPastDue" >
				<list:box-select><list:item-select>
					<ui:source type="Static">
							[{text:'${ lfn:message('sys-task:sysTaskMain.status.overdure') }', value:'1'},
							{text:'${ lfn:message('sys-task:sysTaskMain.status.unexpired') }', value: '0'}]
						</ui:source>
				</list:item-select></list:box-select>
			</list:cri-criterion>
			
			<%--任务类型--%>
			<list:cri-criterion title="${ lfn:message('sys-task:sysTaskMain.fdCategoryId') }" key="taskCategory" >
				<list:box-select><list:item-select>
					<ui:source type="AjaxJson">
						{url:'/sys/task/sys_task_category/sysTaskCategory.do?method=getTaskCategory'}
					</ui:source>
				</list:item-select></list:box-select>
			</list:cri-criterion>
			
			<%--任务评价--%>
			<list:cri-criterion title="${ lfn:message('sys-task:table.sysTaskEvaluate') }" key="taskApproves" multi="false">
				<list:box-select><list:item-select>
					<ui:source type="AjaxJson">
						{url:'/sys/task/sys_task_approve/sysTaskApprove.do?method=getTaskApprove'}
					</ui:source>
				</list:item-select></list:box-select>
			</list:cri-criterion>
			
			<!-- 任务来源 -->
			<list:cri-criterion title="${lfn:message('sys-task:sysTaskMain.fdSourceSubject') }" key="fdModelName" multi="true">
				<list:box-select>
					<list:item-select type="lui/criteria!CriterionSelectDatas">
						<ui:source type="AjaxJson" >
							{url: "/sys/task/sys_task_main/sysTaskIndex.do?method=getModules"}
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			
			<list:cri-ref ref="criterion.sys.person"   key="perform.personId"  title="${ lfn:message('sys-task:sysTaskMain.fdPerform') }" cfg-if="param['flag'] != '2'"></list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.sys.task.model.SysTaskMain" property="fdAppoint" cfg-if="param['flag'] != '1'"/>
			<list:cri-auto modelName="com.landray.kmss.sys.task.model.SysTaskMain"  property="fdPlanCompleteDateTime" />
			
		</list:criteria>
		
		<%--操作栏--%>
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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count="3">
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('sys-task:sysTaskMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
							<list:sort property="fdPlanCompleteDateTime" text="${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime') }" group="sort.list" ></list:sort>
							<list:sort property="fdProgressNumber" text="${lfn:message('sys-task:sysTaskMain.fdProgress') }" group="sort.list"></list:sort>
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
					<ui:toolbar count="3">
							<%--新建--%>
							<kmss:authShow roles="ROLE_SYSTASK_CREATE">
								<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>	
							</kmss:authShow>
							<%--
							<kmss:authShow roles="ROLE_SYSTASK_TRANSPORT_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport')" order="2" ></ui:button>
							</kmss:authShow>
							 --%>
							<%--删除--%>
							<kmss:auth
								requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=deleteall&status=${param.status}&categoryId=${param.categoryId}&nodeType=${param.nodeType}"
								requestMethod="GET">								
								<ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="4"></ui:button>
							</kmss:auth>
						</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<%--list视图--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/sys/task/sys_task_main/sysTaskIndex.do?method=list'}
			</ui:source>
			<%--列表形式--%>
			<list:colTable isDefault="false" layout="sys.task.listview.columntable" 
				rowHref="/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>   
		</list:listview> 
	 	<list:paging></list:paging> 
	 	<script>
		var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.sys.task.model.SysTaskMain";
		 seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/spa/Spa'], function($, dialog , topic, Spa) {
		   // 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				topic.publish('list.refresh');
			});
			
	 		//新建
			window.addDoc = function() {
				Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=add');
			};
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
				dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
					if(value==true){
						window.del_load = dialog.loading();
						$.post('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=deleteall"/>',
								$.param({"List_Selected":values},true),delsuccess,'json')
								.error(delfail);
					}
				});
			};
			//删除成功回调函数
			window.delsuccess = function(data){
				if(window.del_load!=null)
					window.del_load.hide();
				if(data!=null && data.status==true){
					topic.publish("list.refresh");
					dialog.success('<bean:message key="return.optSuccess" />');
				}else{
					dialog.failure('<bean:message key="return.optFailure" />');
				}
			};
			
			window.delfail=function(data){
				//存在子任务，提示无法删除
				if(window.del_load!=null)
					window.del_load.hide();
				if(data!=null && data.responseJSON){
					data=data.responseJSON;
					var message=data.message;
					if(message && message.length>0 && message[message.length-1].msg){
						dialog.failure(message[message.length-1].msg);
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				}
			};
			//根据地址获取key对应的筛选值
		      window.getHashLength = function(){
				var length = 0;
		        var hash = window.location.hash;
		        if(hash != ""){
		      	  var url = hash.split("cri.q=")[1];
		      	  if(url){
		      		length =  url.split(";").length;
		      	  }
			    }
		        return length;
	          };
	          window.getFromHash = function(key,isCriteria){
	        	  if(isCriteria) {
	        		  var hash = window.location.hash ? window.location.hash.split("cri.q=")[1]:null;
	        		  if(hash) {
	        			  hash = decodeURIComponent(hash); 
	        			  var params = hash.split(';');
	        			  for (var i = 0; i < params.length; i++) {
	        				  if (!params[i])
				 			  	 continue;
				 			  var a = params[i].split(":");
				 			  if(a[0] == key)
				 				  return a[1];
	        			  }
	        		  }
	        	  }else {
	        		  var params = window.location.hash ? window.location.hash.substr(1)
			 					.split("&") : [], paramsObject = {};
			 			for (var i = 0; i < params.length; i++) {
			 				if (!params[i])
			 					continue;
			 				var a = params[i].split("=");
			 				if(a[0] == key){
			 					return decodeURIComponent(a[1]);
			 				}
			 			} 
	        	  }
		 			return "";
		 		};
		 		
			 <%@ include file='/sys/task/resource/treeTable/jquery.treeTable.jsp' %>
				topic.subscribe('list.loaded', function() {
					//只有是选择所有任务并且没有筛选标题的时候才生成表格树
					if(getFromHash('j_path')=='/listAll' && getFromHash('docSubject',true) == ''){
						 var option = {
							        theme:'default',
							        expandLevel : 1,
							        beforeExpand : function($treeTable, id) {
							            if ($('.' + id, $treeTable).length) { return; }
							            $.ajax({
							            	type:"POST",
							            	url:"${pageContext.request.contextPath}/sys/task/sys_task_main/sysTaskIndex.do?method=getChildTask&orderby=sysTaskMain.docSubject",
							            	dataType:"html",
							            	async:false,
							            	data:{parentId:id},
							            	success:function(data){
							            		$treeTable.addChilds(data);
							            	},
							            	error:function(e){
							            		dialog.failure('<bean:message key="return.optFailure" />'+e);
							            	}
							            });
							           // $treeTable.addChilds('<tr data-lui-mark-id="lui-rowId-38" id="14dd6de2209460777812f3d46c28ca05" pid="14dd6dd23240989ad7fbbfa4a4d86d20" haschild="true" class="14dd6dd23240989ad7fbbfa4a4d86d20" style="cursor: pointer; display: table-row;"><td style="text-align:left;" class="">&nbsp;<input type="checkbox" name="List_Selected" value="14dd6de2209460777812f3d46c28ca04" data-lui-mark="table.content.checkbox"></td><td style="width:5%" class="">2</td><td style="text-align:left" class=""><span class="com_subject">b1</span></td><td style="width:80px;" class=""><p title="黄娟霞"><a class="com_author" href="/sys/person/sys_person_zone/sysPersonZone.do?method=view&amp;fdId=131fec7f32596d94bbce49342408b258" target="_blank">黄娟霞</a></p></td><td style="width:120px;" class=""><p title="2015-06-10 13:26">2015-06-10 13:26</p></td><td style="text-align:center;width:60px;" class=""><img src="/sys/task/images/STATUS_PROGRESS.gif" title="进行中"></td><td style="width:60px;" class=""><style>.pro_barline{width: 113px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;}.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}</style>0%<div class="pro_barline"><div class="uncomplete" style="width:0%"></div></div></td><td style="width:60px;" class=""><a class="com_author" href="/sys/person/sys_person_zone/sysPersonZone.do?method=view&amp;fdId=1183b0b84ee4f581bba001c47a78b2d9" target="_blank">管理员</a></td><td style="width:60px;" class="">待评</td></tr>');
							        },
							        onSelect : function($treeTable, id) {
							            window.console && console.log('onSelect:' + id);
							        }
	
							    };
						$('#taskTable').treeTable(option);
					}
				});
		 });
		</script> 
	</template:replace>
	
</template:include>