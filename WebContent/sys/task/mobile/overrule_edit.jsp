<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${lfn:message('sys-task:table.sysTaskOverrule')}"></c:out>
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-task-edit.css"/>
		<style>
		/*  */
			#scrollView{
				background-color:#fff;
			}
			.overruleBox{
				
			}
			.muiImportBox{
				padding:1rem;
				font-size:2.8rem;
			}
			.muiImportBox .overruleTitle{
				color:#999;
				font-size:1.6rem;
				line-height:4.0rem;
			}
			.overruleLine{
				border-top:1px solid #e0e0e0;
				margin-top:1rem;
			}
			.progressTitle{
				margin:1rem auto;
				width:90%;
				font-size: 1.6rem;
			}
			.overruleSubject{
				font-size:2rem;
			}
			.muiFormRequired{
				font-size:1.5rem;
			}
		</style>
	</template:replace>
	<template:replace name="content"> 
		<html:form action="/sys/task/sys_task_overrule/sysTaskOverrule.do">
			<html:hidden property="fdId"/>
			<html:hidden property="fdTaskId"/>
			<html:hidden property="method_GET"/>
			<html:hidden property="fdNotifyType"/> 
			<div class="overruleBox" data-dojo-type="mui/view/DocScrollableView" id="scrollView" data-dojo-mixins="mui/form/_ValidateMixin">
				<div class="muiImportBox">
						<div class="overruleTitle">${lfn:message('sys-task:sysTaskMain.docSubject')}</div>
						<div class="overruleSubject">
							<c:out value="${sysTaskOverruleForm.fdTaskName}"/>
						</div>
					
						<div class="overruleTitle overruleLine">${lfn:message('sys-task:sysTaskOverrule.fdReason')}</div>
						<div  data-dojo-type='mui/form/Textarea' 
						data-dojo-props='"placeholder":"",
						"name":"fdReason","showStatus":"edit",opt:false' 
						required ="true"
						></div>
				</div>
				<div class="muiProgressBox">
					<c:import url="/sys/task/mobile/import/status.jsp"  charEncoding="UTF-8">
						<c:param name="fdProgress" value="${fdStatus}"></c:param>
					</c:import>
					<%-- 截止时间 --%>
					<div class="time"></div>
					<div class="progressAuto">
						<%-- #11654 移除“自动根据子任务更新进度 ”,为兼容旧数据,暂时保留字段 --%>
						<html:hidden property="fdProgressAuto" value="true"/>
					</div>
					<%-- 进度 --%>
					
					<div class="progressTitle">${lfn:message('sys-task:sysTaskOverrule.fdProgress')}</div>
					<input data-dojo-type="dojox/mobile/Slider" 
						data-dojo-mixins="sys/task/mobile/resource/js/_ProgressSliderMixin"
						data-dojo-props="valueText:'${sysTaskOverruleForm.fdProgress }'"
						id="progress" name="fdProgress" class="progress"/>
				</div>
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit " 
				  		data-dojo-props='colSize:2,href:"javascript:window.commitMethod(\"save\");",transition:"slide"'>
				  		${lfn:message('sys-task:sysTaskFeedback.button.submit')}	
				  	</li>
				</ul>
			</div>
		</html:form>
	</template:replace>
</template:include>
<script type="text/javascript">
require(["mui/form/ajax-form!sysTaskOverruleForm"]);
require(['dojo/query','dojo/date/locale','dojo/date','dojo/topic','dijit/registry','dojo/ready','dojo/dom-style','dojo/dom-construct'],
	function(query,locale,date,topic,registry,ready,domStyle,domConstruct){
	//提交表单
	
	ready(function(){
		validorObj=registry.byId('scrollView');
	});
	var validorObj = null;
 	window.commitMethod=function(commitType){
		if(validorObj.validate()){
			var formObj = document.sysTaskOverruleForm;
			query('[name="fdNotifyType"]')[0].value='todo'; 
			if('save'==commitType){
				Com_Submit(formObj, commitType);
		    }
		}
		
	};
	//提交后返回查看页面
	 Com_Submit.ajaxAfterSubmit=function(data){
		setTimeout(function(){
			//window.location='${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId=${sysTaskFeedbackForm.fdTaskId}';
		},2000)
	}; 
	
});
</script>