<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="key" value="${param.key}"/>
<c:set var="criteria" value="${param.criteria}"/>
<div class="lui_list_nav_frame">
	<ui:accordionpanel>
		<%--任务查询--%>
		<ui:content title="${ lfn:message('sys-task:sysTaskMain.list.search') }" expand="${param.key != 'sysTaskMain'?'false':'true' }">
			<%--0.我关注的、1.我负责的、2.我指派的、3.所有任务--%>
			<ul class='lui_list_nav_list'>
				<li><a id="sysTaskMain_all" href="javascript:void(0)" onclick="setUrl('sysTaskMain','flag',''); resetMenuNavStyle(this);">${ lfn:message('sys-task:sysTaskMain.list.all') }</a></li>
				<li><a id="sysTaskMain_0" href="javascript:void(0)" onclick="setUrl('sysTaskMain','flag','0');resetMenuNavStyle(this);">${ lfn:message('sys-task:sysTaskMain.list.attention') }</a></li>					
				<li><a id="sysTaskMain_1" href="javascript:void(0)" onclick="setUrl('sysTaskMain','flag','1');resetMenuNavStyle(this);">${ lfn:message('sys-task:sysTaskMain.list.appoint') }</a></li>
				<li><a id="sysTaskMain_2" href="javascript:void(0)" onclick="setUrl('sysTaskMain','flag','2');resetMenuNavStyle(this);">${ lfn:message('sys-task:sysTaskMain.list.perform') }</a></li>
				<li><a id="sysTaskMain_3" href="javascript:void(0)" onclick="setUrl('sysTaskMain','flag','3');resetMenuNavStyle(this);">${ lfn:message('sys-task:sysTaskMain.list.copy') }</a></li>
			</ul>
			<ui:operation href="javascript:openPage('${LUI_ContextPath }/sys/task/sys_task_ui/calendar.jsp')" name="${ lfn:message('sys-task:tree.task.calendar') }" target="_self" />
		</ui:content>		
		<%--任务分析--%>
		<ui:content title="${ lfn:message('sys-task:tree.analyze') }"  expand="${param.key != 'sysTaskAnalyze'?'false':'true' }">
			<%--0.我关注的、1.我负责的、2.我指派的、3.所有任务--%>
			<ul class='lui_list_nav_list'>
				<li><a id="sysTaskAnalyze_1" href="javascript:void(0)" onclick="setUrl('sysTaskAnalyze','type','1');resetMenuNavStyle(this);">${ lfn:message('sys-task:tree.load') }</a></li>					
				<li><a id="sysTaskAnalyze_2" href="javascript:void(0)" onclick="setUrl('sysTaskAnalyze','type','2');resetMenuNavStyle(this);">${ lfn:message('sys-task:tree.degree') }</a></li>
				<li><a id="sysTaskAnalyze_4" href="javascript:void(0)" onclick="setUrl('sysTaskAnalyze','type','4');resetMenuNavStyle(this);">${ lfn:message('sys-task:tree.type') }</a></li>
				<li><a id="sysTaskAnalyze_5" href="javascript:void(0)" onclick="setUrl('sysTaskAnalyze','type','5');resetMenuNavStyle(this);">${ lfn:message('sys-task:tree.trend') }</a></li>
			</ul>
		</ui:content>				
		<kmss:authShow roles="ROLE_SYSTASK_BACKSTAGE_MANAGER">
			<%--后台管理--%>
			<ui:content title="${ lfn:message('list.otherOpt') }">
				<ul class='lui_list_nav_list'>
					<li><a href="${LUI_ContextPath }/sys/profile/index.jsp#app/ekp/sys/task" target="_blank">${ lfn:message('list.manager') }</a></li>
				</ul>
			</ui:content>
		</kmss:authShow>
	</ui:accordionpanel>
	
	<script type="text/javascript">
		seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog'], function($, strutil, dialog){
			window.setUrl= function (key,mykey,type){
				//打开新页面
				if(key!="${key}"){
					if(key=="sysTaskMain"){
						if(type==""){
							openUrl('${LUI_ContextPath}/sys/task/index.jsp','');
						}
						else{
							openUrl('${LUI_ContextPath}/sys/task/index.jsp','cri.q='+mykey+':'+type);
						}
					}
					if(key=="sysTaskAnalyze"){
						openUrl('${LUI_ContextPath}/sys/task/sys_task_analyze_ui/index.jsp','cri.q='+mykey+':'+type);
					}
				}
				//只更新list列表
			 	else{
			 		openQuery();
			 		 LUI('${criteria}').setValue(mykey, type);
				}
			};
			window.openUrl = function(srcUrl,hash){
				if(hash!=""){
					srcUrl+="#"+hash;
			    }
				window.open(srcUrl,"_self");
			};
			LUI.ready(function(){
				  // 初始化左则菜单样式
			  setTimeout("initMenuNav('${param.key}')", 300);
			});
			window.initMenuNav= function(key){
				if(key=="sysTaskMain"){
					var flag=getValueByHash("flag");
					if(flag!=""){
					    resetMenuNavStyle($("#"+key+"_"+flag)); 
					}else{
						resetMenuNavStyle($("#"+key+"_all")); 
					}
				}
				else if(key=="sysTaskAnalyze"){
					var type=getValueByHash("type");
				    resetMenuNavStyle($("#"+key+"_"+type)); 
				}
			};
		});
	</script>
</div>
