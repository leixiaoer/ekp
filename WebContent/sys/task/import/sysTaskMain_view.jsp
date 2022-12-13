 <%@ include file="/resource/jsp/common.jsp"%>
 <c:set var="mainForm" value="${requestScope[param.formName]}" />
 <c:if test="${mainForm.docStatus!=10}">
<kmss:auth requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=add" requestMethod="GET">
	    <ui:button text="${ lfn:message('sys-task:tag.task') }" order="4" parentId="toolbar"
	    onclick="Com_OpenWindow('${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=add&fdModelId=${mainForm.fdId}&fdModelName=${JsParam.fdModelName}');">
        </ui:button>
</kmss:auth>
</c:if>
<kmss:authShow roles="ROLE_SYSTASK_DELETE">	
	<c:set var="validateAuth" value="true" />
</kmss:authShow>
<script>
seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
window.deleteTask=function(fdId){
	dialog.confirm("${lfn:message('sys-task:systaskMain.message.delete')}",function(flag){
    	if(flag==true){
    		window.del_load  = dialog.loading();
			$.get('<c:url value="/sys/task/sys_task_main/sysTaskMain.do?method=delete"/>', 
					$.param({"fdId":fdId,"fdModelId":"${mainForm.fdId}","fdModelName":"${JsParam.fdModelName}"},true),delCallback,'json')
					.error(delfail);
    	}else{
    		return;
	    }
    },"warn");
};

window.delCallback = function(data){
	if(window.del_load!=null)
		window.del_load.hide();
	if(data!=null && data.status==true){
		topic.channel("paging").publish("list.refresh");
		dialog.success('<bean:message key="return.optSuccess" />');
	}else{
		dialog.failure('<bean:message key="return.optFailure" />');
	}
};

window.delfail=function(data){
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
<c:set var="order" value="${empty param.order ? '10' : param.order}"/>
<c:set var="disable" value="${empty param.disable ? 'false' : param.disable}"/>
 <ui:content title="${ lfn:message('sys-task:sysTaskMain.relatedTask') }"  cfg-order="${order}" cfg-disable="${disable}">
		<table width=100%>
			<tr>	  
			   <td >
			   <div id="taskMainDiv">
				<list:listview channel="paging">
						<ui:source type="AjaxJson">
							{"url":"/sys/task/sys_task_main/sysTaskIndex.do?method=list&flag=3&&fdModelId=${mainForm.fdId}&fdModelName=${JsParam.fdModelName}"}
						</ui:source>
						<list:colTable isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple" rowHref="/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId=!{fdId}">
							<list:col-auto props=""></list:col-auto>
						<c:if test="${validateAuth=='true'}">
							<list:col-html style="width:60px;" title="">			
									{$<a href="javascript:;" onclick="deleteTask('{%row.fdId%}')" class="com_btn_link"><bean:message key="button.delete" /></a>$}
							</list:col-html>
					    </c:if>
						</list:colTable>						
					</list:listview>
					<div style="height: 15px;"></div>
					<list:paging channel="paging" layout="sys.ui.paging.simple"></list:paging>
				</div>
			   </td>
			  </tr>
		</table> 
</ui:content>