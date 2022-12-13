<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/sys/task/maxhub/import/resource/css/view.css?s_cache=${MUI_Cache}">
<div id="taskView_${JsParam.fdModelId}" class="mhuiViewSec mhui-hidden">
	<div class="taskList">
		<div class="taskTitle"><div class="taskTitleBorder">面对面建任务</div></div>
		<div data-dojo-type="mhui/list/ItemListBase"
			data-dojo-mixins="sys/task/maxhub/import/resource/js/TaskListMixin"
			id="datalist"
			data-dojo-props="url:'${LUI_ContextPath}/sys/task/sys_task_main/sysTaskIndex.do?method=list&fdModelId=${kmImeetingMainForm.fdId}&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain'"
		></div> 
    </div>
</div>

<script>
require([
         'dojo/query',
         'dojo/dom-style',
         'dojo/on',
         'dojo/dom-construct',
         'mhui/dialog/Dialog',
         'mui/qrcode/QRcode',
         'dojo/topic',
         'mui/dialog/Tip',
         'dijit/registry',
         'dojo/request',
         'dojo/_base/array'
        ], 
		function(query,domStyle,on,domConstruct,dialog,qrcode,topic,tip,registry,request,array){
		 	var addTaskBtn = query('.taskTitle')[0];
			//面对面建任务		
			
			on(addTaskBtn,'click',function(){
				tip.processing();
				query("iframe").onload=function(){
					tip.success();
				}
				taskDialog();
			});
			function taskDialog(){
				var dialogObj = dialog.show({
					  width:"73.75rem",
					  height:"56.5rem",
					  title:"面对面建任务",
					  iframe:'${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=add&fdModelId=${JsParam.fdId}&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&fdName=${kmImeetingMainForm.fdName }',
					  iframeHeight:"46.5rem",
					  buttons:[{text:'取消',onClick:unpdataTaskCancel},{text:'确定',onClick:updateTask}]
				  });
				function updateTask(){
					tip.processing();
					var iframe = query("iframe");
					var commit_promise = iframe[0].contentWindow.task_commit();
					if(commit_promise){
						commit_promise.then(function(){
							dialogObj.hide();
							var dataList = registry.byId('datalist');
							dataList.getRequest().then(function(){
								dataList.renderList(dataList.__data,false);
								tip.success();
							});
						});
					}else{
						console.log("出错");
					}
						
				}
				
				function unpdataTaskCancel(){
					dialogObj.hide();
				} 
			}
		
		
});

</script>
