<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
	
<%--右侧--%>
<script>
	var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.sys.task.model.SysTaskMain";
   seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {

		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
		
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
	
		
		
   });
  </script>
  <style>
  	.listview .columnTable .lui_listview_body
  	{
  		overflow: inherit;
  	}
	.pro_barline{width: 113px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;}
	.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
	.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
  </style>
  
<list:criteria id="sysTaskMainCriteria">		
	<!-- 主题、任务状态、任务接收人、任务指派人、接收人部门、指派人部门、要求完成时间
	搜索条件:任务名称 -->
	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:supervise_task_docSubject') }">
	</list:cri-ref>
	
	<!-- 与我相关 -->
	<list:cri-criterion title="${ lfn:message('sys-task:sysTask.sysTaskMain.my') }" key="flag" multi="false">
		<list:box-select>
			<list:item-select>
				<ui:source type="Static">
					[{text:'${ lfn:message('sys-task:sysTaskMain.list.attention') }', value:'0'},{text:'${ lfn:message('sys-task:sysTaskMain.list.appoint') }',value:'1'}, {text:'${ lfn:message('sys-task:sysTaskMain.list.perform') }', value: '2'},{text:'${ lfn:message('sys-task:sysTaskMain.list.copy') }', value: '3'}]
				</ui:source>
			</list:item-select>
		</list:box-select>
	</list:cri-criterion>
	
	<!-- 任务状态 -->
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
	
	<!-- 是否过期 -->
	<list:cri-criterion title="${ lfn:message('sys-task:sysTaskMain.fdPastDue') }" key="fdPastDue" >
		<list:box-select><list:item-select>
			<ui:source type="Static">
					[{text:'${ lfn:message('sys-task:sysTaskMain.status.overdure') }', value:'1'},
					{text:'${ lfn:message('sys-task:sysTaskMain.status.unexpired') }', value: '0'}]
				</ui:source>
		</list:item-select></list:box-select>
	</list:cri-criterion>
	
	<!-- 任务类型 -->
	<list:cri-criterion title="${ lfn:message('sys-task:sysTaskMain.fdCategoryId') }" key="taskCategory" >
		<list:box-select><list:item-select>
			<ui:source type="AjaxJson">
				{url:'/sys/task/sys_task_category/sysTaskCategory.do?method=getTaskCategory'}
			</ui:source>
		</list:item-select></list:box-select>
	</list:cri-criterion>
	
	<!-- 任务评价 -->
	<list:cri-criterion title="${ lfn:message('sys-task:table.sysTaskEvaluate') }" key="taskApproves" multi="false">
		<list:box-select><list:item-select>
			<ui:source type="AjaxJson">
				{url:'/sys/task/sys_task_approve/sysTaskApprove.do?method=getTaskApprove'}
			</ui:source>
		</list:item-select></list:box-select>
	</list:cri-criterion>
			
	<list:cri-ref ref="criterion.sys.person"   key="perform.personId"  title="${ lfn:message('sys-task:sysTaskMain.fdPerform') }"></list:cri-ref>
	<list:cri-auto modelName="com.landray.kmss.sys.task.model.SysTaskMain" property="fdAppoint" />
	<list:cri-auto modelName="com.landray.kmss.sys.task.model.SysTaskMain"  property="fdPlanCompleteDateTime" />
	
</list:criteria>

<%--操作栏--%>
<div class="lui_list_operation">
	<div style='color: #979797;float: left;padding-top:1px;'>
		${ lfn:message('list.orderType') }：
	</div>
	<div style="float:left">
		<div style="display: inline-block;vertical-align: middle;">
			<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count="3">
				<list:sortgroup>
					<list:sort property="docCreateTime" text="${lfn:message('sys-task:sysTaskMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
					<list:sort property="fdPlanCompleteDateTime" text="${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime') }" group="sort.list" ></list:sort>
					<list:sort property="fdProgressNumber" text="${lfn:message('sys-task:sysTaskMain.fdProgress') }" group="sort.list"></list:sort>
				</list:sortgroup>
			</ui:toolbar>
		</div>
	</div>
	<div style="float:left;">	
		<list:paging layout="sys.ui.paging.top" > 		
		</list:paging>
	</div>
	<div style="float:right">
		<div style="display: inline-block;vertical-align: middle;">
			<ui:toolbar count="3">
					<!-- 删除 -->
					<kmss:auth
						requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=deleteall&status=${param.status}&categoryId=${param.categoryId}&nodeType=${param.nodeType}"
						requestMethod="GET">								
						<ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="4"></ui:button>
					</kmss:auth>
                    <kmss:authShow roles="ROLE_KMSUPERVISE_SUPERVISOR_EXPORT">
						<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain')" order="4" ></ui:button>
					</kmss:authShow>
				</ui:toolbar>
		</div>
	</div>
</div>
<ui:fixed elem=".lui_list_operation"></ui:fixed>
<%--list视图--%>
<list:listview id="listview">
	<ui:source type="AjaxJson">
		{url:'/sys/task/sys_task_main/sysTaskIndex.do?method=listbyModelName&fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain'}
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
    
 seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
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
	 
	 <%@ include file='/sys/task/resource/treeTable/jquery.treeTable.jsp' %>
		topic.subscribe('list.loaded', function() {
			if(getHashLength()==0){
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
					        },
					        onSelect : function($treeTable, id) {
					           // window.console && console.log('onSelect:' + id);
					        }

					    };
				$('#taskTable').treeTable(option);
			}
		});
 });
</script> 