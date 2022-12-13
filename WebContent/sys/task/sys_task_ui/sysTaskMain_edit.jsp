<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.task.model.SysTaskConfig"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%	
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();	
	String nowStr = formatter.format(now);
	request.setAttribute("now", nowStr);
%>
<%
	SysTaskConfig taskConfig = new SysTaskConfig();
	request.setAttribute("taskAssignorConfig", taskConfig.getTaskAssignorConfig());
%>
<template:include ref="default.edit" sidebar="no">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ sysTaskMainForm.method_GET == 'add' || sysTaskMainForm.method_GET == 'copyTask'}">
				<c:out value="${ lfn:message('sys-task:tree.task.create') } - ${ lfn:message('sys-task:module.sys.task') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${sysTaskMainForm.docSubject} - ${ lfn:message('sys-task:module.sys.task') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:choose>
				<%--add页面的按钮--%>
				<c:when test="${ sysTaskMainForm.method_GET == 'add' || sysTaskMainForm.method_GET == 'copyTask'}">
					<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('save','false');">
					</ui:button>
				</c:when>
				<%--edit页面的按钮--%>
				<c:when test="${ sysTaskMainForm.method_GET == 'edit' }">
					<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod_update('update','false');">
					</ui:button>
				</c:when>
			</c:choose>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	<%--导航路径--%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" >
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('sys-task:module.sys.task') }">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('sys-task:table.sysTaskMain') }">
			</ui:menu-item>
		</ui:menu>
	</template:replace>	
	
	<%--任务安排表单--%>
	<template:replace name="content"> 
		<style>
			.task_slideDown {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowd_blue.png) no-repeat 0 3px;cursor: pointer;}
			.task_slideUp {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowU_blue.png) no-repeat 0 3px;cursor: pointer;}
		</style>
		<script type="text/javascript">
			Com_IncludeFile("data.js|dialog.js|validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js|xform.js|calendar.js",null,"js");
		</script>
		<script type="text/javascript">
			seajs.use(['lui/dialog'], function(dialog) {
				window.dialog = dialog;
			});
			function changeResolveFlag(){
				var fdResolveFlag=document.getElementsByName("fdResolveFlag")[1];
				if(fdResolveFlag.checked){
				 	//勾选了权限范围
				 	$("#divideAutoHtml").hide();
					$("#TABLE_DocList").hide();
					$("#TABLE_DocList_TITLE").hide(); 
				}else{
					$("#divideAutoHtml").show();
					$("#TABLE_DocList").show(); 
					$("#TABLE_DocList_TITLE").show();
				}
			}
			//设置自动进度、权限范围仅限于此文档的checkbox值
			function setCheckBoxValue(){
				/*
				var fdProgressAuto=document.getElementsByName("fdProgressAuto")[1];
				if(fdProgressAuto.checked){
					document.getElementsByName("fdProgressAuto")[0].value="true";
					fdProgressAuto.value="true";
				}else{
					document.getElementsByName("fdProgressAuto")[0].value="false";
					fdProgressAuto.value="false";
				}
				*/
				var fdResolveFlag=document.getElementsByName("fdResolveFlag")[1];
				if(fdResolveFlag.checked){
					document.getElementsByName("fdResolveFlag")[0].value="true";
					fdResolveFlag.value="true";
				}else{
					document.getElementsByName("fdResolveFlag")[0].value="false";
					fdResolveFlag.value="false";
				}
			}
			//提交表单
			var submitCount = 0;
			function commitMethod(commitType, saveDraft){
				//防止表单重复提交
				if(submitCount>=1){
					return;
				}
				var curr_time = new Date(Date.parse("${now}".replace(/\-/g,'/')));
				var _fdPlanCompleteDate = document.getElementsByName("fdPlanCompleteDate")[0];			
				var _fdPlanCompleteTime = document.getElementsByName("fdPlanCompleteTime")[0];
				var _fdPlanCompleteDateTime = _fdPlanCompleteDate.value+" "+_fdPlanCompleteTime.value;
				var rs = validateCurTaskMainFormData(curr_time,_fdPlanCompleteDate,_fdPlanCompleteTime,_fdPlanCompleteDateTime);
				if(rs==false) return;
				if ('save'==commitType) {
					var result=validateSysTaskMainFormData(curr_time,_fdPlanCompleteDate,_fdPlanCompleteTime,_fdPlanCompleteDateTime);
					if(result==false) return;
				}
				setCheckBoxValue();//设置自动进度、权限范围仅限于此文档的checkbox值
				if("${sysTaskMainForm.method_GET}" == 'add' || "${sysTaskMainForm.method_GET}" == 'copyTask'){
					var ele = document.getElementsByName("fdFirstLevelChildForms[0].docSubject");
					if(ele.length>0){
						document.getElementsByName("isDivide")[0].value="true";
					}else{
						document.getElementsByName("isDivide")[0].value="false";
					}
				}
				var formObj = document.sysTaskMainForm;
				var docStatus = document.getElementsByName("docStatus")[0];
				if(saveDraft=="true"){
					docStatus.value="10";
				}else{
					docStatus.value="20";
				}
				//提交表单校验
				for(var i=0; i<Com_Parameter.event["submit"].length; i++){
					if(!Com_Parameter.event["submit"][i]()){
						return false;
					}
				}
				//提交表单消息确认
				for(var i=0; i<Com_Parameter.event["confirm"].length; i++){
					if(!Com_Parameter.event["confirm"][i]()){
						return false;
					}
				}
				if('save'==commitType){
					Com_Submit(formObj, commitType,'fdId');
			    }else{
			    	var parentId = document.getElementsByName("fdParentId")[0].value;
			    	if(parentId != null && parentId != undefined && parentId != ''){
			    		Com_Submit(formObj, commitType);
			    	}else{
			    		validateChildData(_fdPlanCompleteDateTime).done(function(){
				    		Com_Submit(formObj, commitType);
						}).fail(function(){
							LUI('__step').fireJump("0");
						});
			    		return;
			    	}
			    }
				submitCount++;
			}
			//更新前校验
			function commitMethod_update(commitType,saveDraft){
				var parentId = document.getElementsByName("fdParentId")[0].value;
				if( parentId != null && parentId != undefined && parentId != ''){
					var currentWeight = document.getElementsByName("fdWeights")[0].value;	
					if(isNaN(currentWeight)){
						alert("<bean:message bundle='sys-task' key='sysTaskMain.fdWeights.message.number'/>");
						return;	
					}else{	
						var tempWeight = parseInt(currentWeight);
						if(tempWeight!=currentWeight){
							alert("<bean:message bundle='sys-task' key='sysTaskMain.fdWeights.message.integer'/>");
							return;
						}
					}
					//子任务完成时间不得晚于父任务完成时间
					var _fdPlanCompleteDate = document.getElementsByName("fdPlanCompleteDate")[0];			
					var _fdPlanCompleteTime = document.getElementsByName("fdPlanCompleteTime")[0];
					var ParentPlanCompleteDate='${sysTaskMainForm.fdParentPlanCompleteDate}';
					var ParentPlanCompleteTime='${sysTaskMainForm.fdParentPlanCompleteTime}';
					if((_fdPlanCompleteDate.value > ParentPlanCompleteDate)||((_fdPlanCompleteDate.value == ParentPlanCompleteDate)&&(_fdPlanCompleteTime.value > ParentPlanCompleteTime))){			
						alert("<bean:message bundle='sys-task' key='sysTaskMain.ChildNotLateThanFather'/>");
						return;
					}
				}
				commitMethod(commitType,saveDraft);
			}
			// 重新编辑，校验子任务截止时间
			function validateChildData(_fdPlanCompleteDateTime){
				var deferred=$.Deferred();
				var id = '${sysTaskMainForm.fdId}';
				$.ajax({
					type : 'get',
					url : Com_Parameter.ContextPath + 'sys/task/sys_task_main/sysTaskMain.do?method=getMaxPlanTime&id='+id,
					dataType : 'json',
					success : function(data){
						var d = eval(data);
						if(d.value){
							var date = Com_GetDate(d.value).getTime();
							var plan = Com_GetDate(_fdPlanCompleteDateTime, 'datetime').getTime();
							if(plan < date){
								dialog.alert('<bean:message bundle="sys-task" key="sysTaskMain.planTime.validator" />');
								deferred.reject();
							}else{
								deferred.resolve();
							}
						}else{
							deferred.resolve();
						}
					}
				});
				return deferred.promise();
			}
			// 比较当前时间
			function validateCurTaskMainFormData(curr_time,_fdPlanCompleteDate,_fdPlanCompleteTime,_fdPlanCompleteDateTime){
				var msg = '';
				var strDate = curr_time.getFullYear()+"-";
				strDate += curr_time.getMonth()+1+"-";
				strDate += curr_time.getDate()+" ";
				var strTime = curr_time.getHours()+":";
				strTime += curr_time.getMinutes();
				var nowDateTime = strDate+strTime;
				if (_fdPlanCompleteTime != null && strDate != null && (Com_GetDate(_fdPlanCompleteDateTime, 'datetime').getTime() < curr_time.getTime())) {
					msg += '<bean:message key="sys-task:sysTaskMain.min" argKey0="sys-task:sysTaskMain.fdPlanCompleteTime" argKey1="sys-task:sysTaskMain.fdCurrentTime" />' + '\r\n';
				}
				if (msg != '') {
					dialog.alert(msg);
					return  false;
				}
				return true;
			}
			// 比较当前时间和计划完成时间
			function validateSysTaskMainFormData(curr_time,_fdPlanCompleteDate,_fdPlanCompleteTime,_fdPlanCompleteDateTime){	
				var childmsg = '';
				var childTaskTitleMsg = '';
				$('[name$=".fdPlanCompleteDateTime"]').each(function(index) {
					if(Com_GetDate(this.value, 'datetime').getTime() < curr_time.getTime()){
						var subject = 'fdFirstLevelChildForms['+index+'].docSubject';
						childmsg += '【'+index+'】';
						childTaskTitleMsg += '【'+$("[name*='"+subject+"']").val()+'】,';
					}
				 });
				if(childTaskTitleMsg != ''){
					childTaskTitleMsg = childTaskTitleMsg.substring(0, childTaskTitleMsg.lastIndexOf(','))
					dialog.alert("<bean:message bundle='sys-task' key='tag.childtasks'/>"+childTaskTitleMsg+"<bean:message bundle='sys-task' key='sysTaskMain.ChildNotEarlyThanNow.Msg'/>");
					return  false;
				}
				var childmsg1 = '';
				var childTaskTitle = '';
				$('[name$=".fdPlanCompleteDateTime"]').each(function(index) {
					if(Com_GetDate(_fdPlanCompleteDateTime, 'datetime').getTime() < Com_GetDate(this.value, 'datetime').getTime()){
						var subject = 'fdFirstLevelChildForms['+index+'].docSubject';
						childmsg1 += '【'+index+'】';
						childTaskTitle += '【'+$("[name*='"+subject+"']").val()+'】,';
					}
				 });
				
				if(childTaskTitle != ''){
					childTaskTitle = childTaskTitle.substring(0, childTaskTitle.lastIndexOf(','))
					dialog.alert("<bean:message bundle='sys-task' key='tag.childtasks'/>"+childTaskTitle+"<bean:message bundle='sys-task' key='sysTaskMain.ChildNotLateThanFatherTaix'/>");
					return  false;
				}
				return true;
			}
			//展开、收起
			function showMoreSet(){
				if(document.getElementById("show_more_set_id").style.display==""){
					document.getElementById("showMoreSet").className ="task_slideDown";
					document.getElementById("showMoreSet").innerHTML="<bean:message bundle='sys-task' key='sysTaskMain.more.set.slideDown' />";
					document.getElementById("show_more_set_id").style.display="none";
				}else{
					document.getElementById("showMoreSet").className ="task_slideUp";
					document.getElementById("showMoreSet").innerHTML="<bean:message bundle='sys-task' key='sysTaskMain.more.set.slideUp' />";
					document.getElementById("show_more_set_id").style.display="";
				}
			}
			//计算权重
			function calculateParentWeight(){
				var currentWeight = document.getElementsByName("fdWeights")[0].value;	
				if(isNaN(currentWeight)){
					alert("<bean:message bundle='sys-task' key='sysTaskMain.fdWeights.message.number'/>");
					return;	
				}else{	
					var tempWeight = parseInt(currentWeight);
					if(tempWeight!=currentWeight){
						alert("<bean:message bundle='sys-task' key='sysTaskMain.fdWeights.message.integer'/>");
						return;
					}
				}
				var otherWeight = document.getElementsByName("fdOtherChildWeights")[0].value;
				var allWeight = parseFloat(currentWeight)+parseFloat(otherWeight);
				if(otherWeight==0){
					document.getElementById("parentWeight").innerHTML=100;
				}else{
					var percent = (100/allWeight)*parseInt(currentWeight);
					document.getElementById("parentWeight").innerHTML=Math.round(percent*100)/100;
				}
			}
			//快速选择时间
			function changeDateTime(obj){
				var date=new Date(Date.parse("${now}".replace(/\-/g,'/')));
				switch(obj){
					case "1":date.setDate(date.getDate());break;
					case "2":date.setDate(date.getDate()+1);break;
					case "3":date.setDate(date.getDate()+2);break;
					case "4":date.setDate(date.getDate()+7);break;
					case "5":date.setMonth(date.getMonth()+1);break;
				}
				//var month=date.getMonth()+1<10?"0"+(date.getMonth()+1):""+(date.getMonth()+1);
				//var day=date.getDate()<10?"0"+date.getDate():""+date.getDate();
				document.sysTaskMainForm.fdPlanCompleteDate.value=date.format(Data_GetResourceString("date.format.date"));
				document.sysTaskMainForm.fdPlanCompleteTime.value="18:00";
				var fdPlanCompleteDate = $('[name="fdPlanCompleteDate"]')[0];
				var fdPlanCompleteTime = $('[name="fdPlanCompleteTime"]')[0];
				KMSSValidation_HideWarnHint(fdPlanCompleteDate);
				KMSSValidation_HideWarnHint(fdPlanCompleteTime);
				
			}
			
			//快速选择时间
			function changeDateTimeChild(obj){
				var optTR = DocListFunc_GetParentByTagName("TR");
				var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);	
				var tbInfo = DocList_TableInfo[optTB.id];
				var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
				var index = rowIndex-1;
				var date=new Date(Date.parse("${now}".replace(/\-/g,'/')));
				switch(obj){
					case "1":date.setDate(date.getDate());break;
					case "2":date.setDate(date.getDate()+1);break;
					case "3":date.setDate(date.getDate()+2);break;
					case "4":date.setDate(date.getDate()+7);break;
					case "5":date.setMonth(date.getMonth()+1);break;
				}
				document.getElementsByName("fdFirstLevelChildForms["+index+"].fdPlanCompleteDateTime")[0].value = date.format(Data_GetResourceString("date.format.date"))+" 18:00";
				var fdPlanCompleteDateTime = $('[name="fdFirstLevelChildForms['+index+'].fdPlanCompleteDateTime"]')[0];
				KMSSValidation_HideWarnHint(fdPlanCompleteDateTime);
			}
			
			
			function genHtml(){
				var docSubject = document.getElementsByName("docSubject")[0].value;
				var fdPerformIds = document.getElementsByName("fdPerformId")[0].value ;
		        var fdPerformNames = document.getElementsByName("fdPerformName")[0].value ;
		        
		        var fdCcIds = document.getElementsByName("fdCcIds")[0].value ;
		        var fdCcNames = document.getElementsByName("fdCcNames")[0].value ;
		     	
				var fdPerformIdArr = fdPerformIds.split(";");
		        var fdPerformNameArr = fdPerformNames.split(";");
		        //var weightValue = parseInt(100/(fdPerformIdArr.length));
		        var weightValue = 1;
		        var _fdPlanCompleteDate = document.getElementsByName("fdPlanCompleteDate")[0];			
				var _fdPlanCompleteTime = document.getElementsByName("fdPlanCompleteTime")[0];
				var d = "";
				if(_fdPlanCompleteDate.value != null &&_fdPlanCompleteTime.value != null){
					d = _fdPlanCompleteDate.value+" "+_fdPlanCompleteTime.value;
				}
				var optTB=document.getElementById("TABLE_DocList");
		        for(var i = 0 ;i<fdPerformIdArr.length;i++){
		        	var oneRow = [];
		        	oneRow["fdFirstLevelChildForms[!{index}].fdParentId"]="${sysTaskMainForm.fdId}";
		        	oneRow["fdFirstLevelChildForms[!{index}].docSubject"]=docSubject;
		        	oneRow["fdFirstLevelChildForms[!{index}].fdPerformId"]=fdPerformIdArr[i];
		        	oneRow["fdFirstLevelChildForms[!{index}].fdPerformName"]=fdPerformNameArr[i];
		        	oneRow["fdFirstLevelChildForms[!{index}].fdCcIds"]=fdCcIds;
		        	oneRow["fdFirstLevelChildForms[!{index}].fdCcNames"]=fdCcNames;
		        	oneRow["fdFirstLevelChildForms[!{index}].fdPlanCompleteDateTime"]=d;
		        	oneRow["fdFirstLevelChildForms[!{index}].fdWeights"]=weightValue;

		        	oneRow["fdFirstLevelChildForms[!{index}].fdParentId"]="${sysTaskMainForm.fdId}";
		        	DocList_AddRow(optTB,null,oneRow); 
		        }
		        calculatePercent();
			}
			
			function divideTask(){
				var fdPerformIds = document.getElementsByName("fdPerformId")[0].value ;
		        var ele = document.getElementsByName("fdFirstLevelChildForms[0].docSubject");
		        var optTB=document.getElementById("TABLE_DocList");
		        var row_length=optTB.rows.length;
		        if(fdPerformIds != null && fdPerformIds != ""){
		        	 if(ele.length > 0){
		        		 dialog.confirm("<bean:message bundle='sys-task' key='sysTaskMain.divide.auto.comfirm'/>",function(value){
     						if(value==true){
     							//$(optTB).find("span[class='optStyle opt_del_style']").each(function(){
     							//	$(this).trigger($.Event("onmousedown"),this);
     							//});
     							
     							var tbRows = optTB.rows;
     							var count = optTB.rows.length;
     							for(var i= 2;i < count;i++){
     								if(i != count){
     									var optTR = tbRows[1];
     									DocList_DeleteRow_ClearLast(optTR);
     								}
     							}
     							genHtml();
       					    }
             	        });
				     }else{
				    	 genHtml();
				     }
				}else{
					dialog.alert("<bean:message bundle='sys-task' key='sysTaskMain.divide.auto.select'/>");
				}
			}
			
			function SelectPerson(i){
				Dialog_Address(false, "fdFirstLevelChildForms["+i+"].fdPerformId", "fdFirstLevelChildForms["+i+"].fdPerformName", null, ORG_TYPE_PERSON);
			}
			
			//快速选择接收人初始化
			function putQuickSelectValue(rtnVal){
				var creatorId = document.getElementsByName("docCreatorId")[0].value;
				var quickSelect = document.getElementById("select_quick");
				var kmssData = new KMSSData();
				kmssData.AddBeanData("sysTaskMainTreeService&creatorId="+creatorId);
				var selectData = kmssData.GetHashMapArray();
				for(var j =1 ; j < quickSelect.options.length; j++){
					quickSelect.options.remove(1);
				}
				if(selectData.length > 0){
					quickSelect.style.display = "inline-block";
					for(var i = 0; i< selectData.length; i++){
						quickSelect.options.add(new Option(selectData[i]['name'],selectData[i]['id'])); 
					}	
				}else{
					quickSelect.style.display = "none";
				}
			}
			//修改接收人
			function changePerform(obj){
			  if(obj.selectedIndex != 0){
				  var performId=obj.options[obj.selectedIndex].value;    
		          var performName=obj.options[obj.selectedIndex].text;    
		          //document.getElementsByName("fdPerformId")[0].value = performId;
		          //document.getElementsByName("fdPerformName")[0].value = performName;
		          var kmssData = new KMSSData();
		          kmssData.AddHashMap({fdPerformId:performId,fdPerformName:performName});
		          kmssData.PutToField("fdPerformId:fdPerformName", "fdPerformId:fdPerformName", "", false);
			  }
			}
			
			function DocList_AddRow_Task(){
				DocList_AddRow();
				calculatePercent();
			}
			
			function calculatePercent(){
				var allWeight = 0;
				var flag = true;
				$(".dragTrbox").each(function(idx,ele) {
		   			var value = $(ele).find(".fdWeightsNode input").eq(0).val();
		   			if (!isNaN(value) && parseInt(value) > 0 && /^-?\d+$/.test(value)) {
		   				allWeight += parseFloat(value);
					} else {
						flag = false;
						return false;
					}
     	       	});
				if (allWeight > 0 && flag) {
					$(".dragTrbox").each(function(idx,ele) {
						var value = $(ele).find(".fdWeightsNode input").eq(0).val();
						var percent = (100/allWeight)*parseInt(value);
						$(ele).find(".taskPercent").eq(0).text(Math.round(percent*100)/100);
					});
				}
			}
			
		</script>
		<html:form action="/sys/task/sys_task_main/sysTaskMain.do">
			<html:hidden property="fdId" />
			<html:hidden property="docStatus" />
			<html:hidden property="fdRootId" />
			<html:hidden property="fdParentId" />
			<html:hidden property="docCreatorId" />
			<html:hidden property="fdWorkId" />
			<html:hidden property="fdPhaseId" />
			<html:hidden property="fdModelId" /> 
			<html:hidden property="fdModelName" />
			<html:hidden property="fdKey" />
			<html:hidden property="fdStatus" />
			<html:hidden property="isDivide" value="${sysTaskMainForm.isDivide}"/>
			<html:hidden property="method_GET" />
			<div class="lui_form_content_frame" style="padding-top: 10px;">
				
				<table class="tb_normal" width=100% > 	
					<tr>
						<%--任务名称--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="sys-task" key="sysTaskMain.docSubject" />
						</td>
						<td width="35%">
							<xform:text showStatus="edit" property="docSubject" style="width:95%;" />
						</td>
						<%--指派人--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="sys-task" key="sysTaskMain.fdAppoint" />
						</td>
						<td width="35%">
							<c:choose>
								<c:when test="${taskAssignorConfig eq 'true'}">
									<xform:address isLoadDataDict="false" style="width:95%" required="true"  subject="${lfn:message('sys-task:sysTaskMain.fdAppoint') }" propertyId="fdAppointId" propertyName="fdAppointName" orgType='ORG_TYPE_PERSON'></xform:address>
								</c:when>
								<c:otherwise>
									<xform:address showStatus = "readOnly" isLoadDataDict="false" style="width:95%" required="true"  subject="${lfn:message('sys-task:sysTaskMain.fdAppoint') }" propertyId="fdAppointId" propertyName="fdAppointName" orgType='ORG_TYPE_PERSON'></xform:address>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<%--接收人--%>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="sys-task" key="sysTaskMain.fdPerform.add" />
						</td>
						<td width="85%" style="border-right:none;" colspan=2>
							<xform:address showStatus="edit" isLoadDataDict="false" style="width:96%" required="true" subject="${lfn:message('sys-task:sysTaskMainPerform.fdPerformId') }" propertyId="fdPerformId" propertyName="fdPerformName" orgType='ORG_TYPE_PERSON' mulSelect="true"></xform:address>
						</td>
						<!-- 用于修复火狐浏览器边框问题 -->
						<td style="border-left:none;">
							<div style="display:inline-block;">
								<%--快速选择--%>
								<select id="select_quick"  onchange="changePerform(this);" style="vertical-align:top;display:none">
									<option value="0"><bean:message bundle="sys-task" key="sysTaskMain.quick.select"/></option>
								</select>
								<label id="divideAutoHtml">
								  <span style="margin-left:8px">
								  	<c:if test="${sysTaskMainForm.method_GET == 'add' || sysTaskMainForm.method_GET == 'copyTask'}">
								  		<ui:button text="${lfn:message('sys-task:sysTaskMain.divide.auto') }" order="2" onclick="divideTask();">
										</ui:button>
								  	</c:if>
								  </span>
								</label>
							</div>
						</td>
					</tr>
							
					<tr>
						<%--要求完成时间--%>
						<td width="15%" class="td_normal_title" >
							<bean:message bundle="sys-task" key="sysTaskMain.fdPlanCompleteTime" />
						</td>
						<td width="35%">
							<xform:datetime showStatus="edit" isLoadDataDict="false" required="true" subject="${lfn:message('sys-task:sysTaskMain.fdPlanCompleteDate') }" property="fdPlanCompleteDate" dateTimeType="date" style="width:35%" ></xform:datetime>
							<xform:datetime showStatus="edit" isLoadDataDict="false" required="true" subject="${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime') }" property="fdPlanCompleteTime" dateTimeType="time" style="width:25%"></xform:datetime>
							<%--快速选择--%>
							<select name="select_time" onChange="changeDateTime(this.value)"  style="vertical-align: top;">
								<option value="0"><bean:message bundle="sys-task" key="sysTaskMain.quick.select" /></option>
								<option value="1"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.today" /></option>
								<option value="2"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.tomorrow" /></option>
								<option value="3"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.after.tomorrow" /></option>
								<option value="4"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.next.week" /></option>
								<option value="5"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.next.month" /></option>
							</select>
						</td>
						<%--抄送人--%>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="sys-task" key="sysTaskMainCc.fdCcId.add" />
						</td>
						<td width="35%">
							<xform:address showStatus="edit" style="width:95%" propertyId="fdCcIds" propertyName="fdCcNames" orgType='ORG_TYPE_ALL' mulSelect="true"></xform:address>
						</td>
					</tr>
					
					<c:if test="${not empty sysTaskMainForm.fdParentName }">
						<tr>
							<%--上级任务--%>
							<td class="td_normal_title" width="15%">
								<bean:message bundle="sys-task" key="sysTaskMain.fdParentId" />
							</td>
							<td width="35%">
								<c:out value="${sysTaskMainForm.fdParentName}" />
							</td>
							<%--上级任务要求完成时间--%>
							<td class="td_normal_title" width="15%">
	   							<bean:message bundle="sys-task" key="sysTaskMain.parent.fdPlanCompleteTime"/> 
	  						</td>
	  						<td width="35%">
	  							<c:out value="${sysTaskMainForm.fdParentPlanCompleteDate}"/>&nbsp;<c:out value="${sysTaskMainForm.fdParentPlanCompleteTime}"/>
	  						</td>
  						</tr>
					</c:if>
					<tr <c:if test="${sysTaskMainForm.method_GET == 'edit'}">style="display:none"</c:if>>
						<td class="td_normal_title" style="display:none;">
							<bean:message bundle="sys-task" key="tag.childtasks"/> 
						</td>
						<td colspan="8">
							<h2 id="TABLE_DocList_TITLE" style="text-align:center;margin-bottom:4px;"><bean:message bundle="sys-task" key="tag.childtasks"/></h2>
						 	<table border="0" width=100%  tbdraggable="true" class="tb_normal" id="TABLE_DocList" align="center">
						 		<tr>
						 			<td class="td_normal_title" width="5%">
						 			</td>
						 			<td class="td_normal_title" width="23%">
										<bean:message bundle="sys-task" key="sysTaskMain.docSubject" />
									</td>
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskMainPerform.fdPerformId" />
									</td>
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskMainCc.fdCcId" />
									</td>
									<td class="td_normal_title" width="24%">
										<bean:message bundle="sys-task" key="sysTaskMain.fdPlanCompleteTime" />
									</td>
									<td class="td_normal_title" width="6%">
										<bean:message bundle="sys-task" key="sysTaskMain.fdWeights" />
									</td>
									<td class="td_normal_title" width="6%">
										<bean:message bundle="sys-task" key="sysTaskMain.percent" />
									</td>
									<td  width="7%">
									</td>
						 		</tr>
								<!-- 基准行 -->
								<tr KMSS_IsReferRow="1" style="display: none" draggable="true" class="dragTrbox">
									<td align="center">
										<input type="checkbox" name="DocList_Selected">
									</td>
									<td>
										<input type="hidden" name="fdFirstLevelChildForms[!{index}].fdParentId" value="${sysTaskMainForm.fdId}" />
										<xform:text showStatus="edit" property="fdFirstLevelChildForms[!{index}].docSubject" required="true" style="width:95%"/>
									</td>
									<td>
										<xform:address showStatus="edit" required="true" orgType='ORG_TYPE_PERSON' style="width:92%" subject="${lfn:message('sys-task:sysTaskMainPerform.fdPerformId') }" propertyName="fdFirstLevelChildForms[!{index}].fdPerformName" propertyId="fdFirstLevelChildForms[!{index}].fdPerformId"></xform:address>
									</td>
									<td id="fdCcNode">
										<xform:address  showStatus="edit"  orgType='ORG_TYPE_PERSON'  subject="${lfn:message('sys-task:sysTaskMainPerform.fdCcIds') }" propertyName="fdFirstLevelChildForms[!{index}].fdCcNames" propertyId="fdFirstLevelChildForms[!{index}].fdCcIds" mulSelect="true"></xform:address>
									</td>
									<td>
										<xform:datetime showStatus="edit" property="fdFirstLevelChildForms[!{index}].fdPlanCompleteDateTime" required="true" subject="${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime') }" dateTimeType="datetime" style="width:160px"></xform:datetime>
										<span style="text-align:right;width:160px;">
											<select name="select_time" onChange="changeDateTimeChild(this.value)"  style="vertical-align: top;">
												<option value="0"><bean:message bundle="sys-task" key="sysTaskMain.quick.select" /></option>
												<option value="1"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.today" /></option>
												<option value="2"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.tomorrow" /></option>
												<option value="3"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.after.tomorrow" /></option>
												<option value="4"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.next.week" /></option>
												<option value="5"><bean:message bundle="sys-task" key="sysTaskMain.DateTime.next.month" /></option>
											</select>
										</span>
									</td>
									<td class="fdWeightsNode">
										<xform:text showStatus="edit" style="width:45px;" value="1" property="fdFirstLevelChildForms[!{index}].fdWeights" required="true" validators="digits notVal(0) min(1)" onValueChange="calculatePercent" subject="${lfn:message('sys-task:sysTaskMain.fdWeights')}"/>
									</td>
									<td>
										<span class="taskPercent"></span>%
									</td>
									<!-- 删除按钮 -->
									<td align="center"  class="td_operate">
										<span style='cursor:pointer' class='optStyle opt_copy_style'  title='<bean:message bundle="sys-xform" key="xform.button.copy" />' onmousedown='DocList_CopyRow();'>
										</span>&nbsp;&nbsp;
										<span style="cursor:pointer" class="optStyle opt_del_style" title="<bean:message bundle="sys-xform" key="xform.button.delete" />" onmousedown="DocList_DeleteRow_ClearLast();">
										</span>
									</td>
								</tr>
								<tr class="tr_normal_opt" type="optRow" invalidrow="true">
									<td colspan="4" align="center" column="0" row="3" coltype="optCol">
										<div class="tr_normal_opt_content">
											<div class="tr_normal_opt_l">
												<label class="opt_ck_style">
													<input type="checkbox" name="DocList_SelectAll" onclick="DocList_SelectAllRow(this);"><bean:message bundle="sys-xform" key="xform.button.selectAll" />
												</label>
												<span class="optStyle opt_batchDel_style" onclick="DocList_BatchDeleteRow();" title="<bean:message bundle="sys-xform" key="xform.button.delete" />">
												</span>
											</div>
												<div class="tr_normal_opt_c"> 
													<span class="optStyle opt_add_style" title='<bean:message bundle="sys-xform" key="xform.button.add" />'  onclick="DocList_AddRow_Task()"></span>
													<span class="optStyle opt_up_style"  title='<bean:message bundle="sys-xform" key="xform.button.moveup" />'  onclick="DocList_MoveRowBySelect(-1);"></span>
													<span class="optStyle opt_down_style" title='<bean:message bundle="sys-xform" key="xform.button.movedown" />'  onclick="DocList_MoveRowBySelect(1);"></span>
												</div>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<%--任务内容描述--%>
						<td class="td_normal_title" width="15%" valign="middle">
							<bean:message bundle="sys-task" key="sysTaskMain.docContent" />
						</td>
						<td colspan="3">
							<kmss:editor property="docContent" toolbarSet="Default" height="300" width="97%"/>
						</td>
					</tr>
					<tr>
						<%--相关附件--%>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="sys-task" key="sysTaskMain.attachment" />
						</td>
						<td colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attachment" />
								<c:param name="fdModelId" value="${sysTaskMainForm.fdId }" />
								<c:param name="fdModelName" value="com.landray.kmss.sys.task.model.SysTaskMain" />
							</c:import>
						</td>
					</tr>
					<tr>
						<%--更多设置按钮--%>
						<td colspan="4" style="text-align: center;">
							<a href="javascript:void(0);" onclick="showMoreSet();" id="showMoreSet" class="task_slideDown">
							<bean:message bundle="sys-task" key="sysTaskMain.more.set.slideDown" /></a>
						</td>
					</tr>  
					<tr id="show_more_set_id" style="display: none">
						<%--设置--%>
						<td  width="100%" colspan=4 style="padding: 0px;">
							<table width="100%" class="tb_normal" height="100%">
								<tr>
									<%--权限范围仅限此文档 --%>
									<td class="td_normal_title" colspan="4" width="15%">
										<html:hidden property="fdResolveFlag" />
										<html:checkbox property="fdResolveFlag" styleId="fdResolveFlag" onclick="changeResolveFlag()"/>
										<label for="fdResolveFlag">
											<bean:message bundle="sys-task" key="sysTaskMain.fdResolveFlag" />	
											<span class="com_help"><bean:message bundle="sys-task" key="sysTaskMain.fdResolveFlag.help" /></span>
										</label>
									</td>
								</tr>
								<tr>	
									<%--当前进度
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskFeedback.fdProgress" />
									</td>
									<td width=35%>
										<html:hidden property="fdProgress" />
										<html:hidden property="fdProgressAuto" />
										<html:checkbox property="fdProgressAuto" />
										<bean:message bundle="sys-task" key="sysTaskMain.fdProgressAuto" />
									</td>--%>
									
									<%-- #11654 移除“自动根据子任务更新进度 ”,为兼容旧数据,暂时保留字段 --%>
									<html:hidden property="fdProgressAuto" value="true"/>
									<html:hidden property="fdProgress" />
									
									<%--任务来源--%>
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskMain.fdSourceSubject" />
									</td>
									<td width="85%" colspan="3">
										<c:choose> 
											<c:when test="${not empty sysTaskMainForm.fdSourceSubject && not empty sysTaskMainForm.fdSourceUrl}">
												<a data-href='<c:url value="${sysTaskMainForm.fdSourceUrl}"/>' target="_blank" onclick="Com_OpenNewWindow(this)" >
													<c:out value="${sysTaskMainForm.fdSourceSubject}" />
												</a>
												<html:hidden property="fdSourceSubject"/>
												<html:hidden property="fdSourceUrl"/>
											</c:when>
											<c:when test="${not empty sysTaskMainForm.fdSourceSubject && empty sysTaskMainForm.fdSourceUrl}">
												<c:out value="${sysTaskMainForm.fdSourceSubject}" />
												<html:hidden property="fdSourceSubject"/>
												<html:hidden property="fdSourceUrl"/>
											</c:when>
											<c:otherwise>
												<bean:message bundle="sys-task" key="sysTaskMain.no.message"/>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<c:choose>
										<%--任务类型--%>
										<c:when test="${sysTaskMainForm.fdParentId != null}">
											<td class="td_normal_title" width="15%">
												<bean:message key="sysTaskMain.fdCategoryId" bundle="sys-task" />
											</td>
											<td width="35%">							
												<kmss:dropList property="fdCategoryId" serviceBean="sysTaskCategoryService" whereBlock="sysTaskCategory.fdIsAvailable = 1" orderBy="sysTaskCategory.fdOrder asc"></kmss:dropList>
											</td>
											<%--权重--%>
											<td class="td_normal_title" width=15%>
												<bean:message bundle="sys-task" key="sysTaskMain.fdWeights" />
											</td>
											<td width=35%>
												<html:text property="fdWeights" size="3"  onchange = "calculateParentWeight()"/>
												<html:hidden property="fdOtherChildWeights" />
												<bean:message bundle="sys-task" key="sysTaskMain.fdWeights.message" />
												<span id = "parentWeight"><c:out value="${sysTaskMainForm.fdParentWeights}"/></span>%
											</td>
										</c:when>
										<c:otherwise>
											<td class="td_normal_title" width="15%">
												<bean:message key="sysTaskMain.fdCategoryId" bundle="sys-task" />
											</td>
											<td width="85%" colspan=3>
												<kmss:dropList property="fdCategoryId" serviceBean="sysTaskCategoryService" whereBlock="sysTaskCategory.fdIsAvailable = 1" orderBy="sysTaskCategory.fdOrder asc"></kmss:dropList>
											</td>
										</c:otherwise>
									</c:choose>
								</tr>
								<%--可阅读者
								<tr>
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskMainReader.docReaderIds" />
									</td>
									<td colspan="3">
										<xform:address style="width:97%" propertyId="docReaderIds" propertyName="docReaderNames" orgType='ORG_TYPE_ALL' mulSelect="true"></xform:address>
										<br/><span class="com_help"><bean:message bundle="sys-task" key="sysTaskMainReader.docReaderIds.message" /></span>
									</td>
								</tr>
								--%>
								<tr>
									<%--通知类型--%>
									<td class="td_normal_title" width="15%">
										<bean:message bundle="sys-task" key="sysTaskMain.fdNotifyType" />
									</td>
									<td width="35%" colspan=3>
										<kmss:editNotifyType property="fdNotifyType" />
									</td>
								</tr>
								<tr>
									<%--创建人--%>
									<td class="td_normal_title" width="15%"><bean:message bundle="sys-task" key="sysTaskMain.docCreatorId" /></td>
									<td width="35%"><html:text property="docCreatorName" readonly="true" /></td>
									<%--创建时间--%>
									<td class="td_normal_title" width="15%"><bean:message bundle="sys-task" key="sysTaskMain.docCreateTime" /></td>
									<td width="35%"><html:text property="docCreateTime" readonly="true" /></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<ui:tabpage expand="false">
				<ui:content title="${ lfn:message('sys-agenda:module.sys.agenda.syn') }">
					<table class="tb_normal" width=100%>
						<tr>
						   <td width="15%"  class="tb_normal">
						   		<%--同步时机--%>
						       	<bean:message bundle="sys-agenda" key="module.sys.agenda.syn.time" />
						   </td>
						   <td width="85%" colspan="3">
						       <xform:radio property="syncDataToCalendarTime" showStatus="edit">
						       		<xform:enumsDataSource enumsType="sysTaskMain_syncDataToCalendarTime" />
								</xform:radio>
						   </td>
						</tr>
						<tr>
							<td colspan="4" style="padding: 0px;">
								 <c:import url="/sys/agenda/import/sysAgendaMain_general_edit.jsp"	charEncoding="UTF-8">
							    	<c:param name="formName" value="sysTaskMainForm" />
							    	<c:param name="fdKey" value="taskMainDoc" />
							    	<c:param name="fdPrefix" value="sysAgendaMain_formula_edit" />
							    	<c:param name="fdModelName" value="com.landray.kmss.sys.task.model.SysTaskMain" />
							    	<%--可选字段 1.syncTimeProperty:同步时机字段； 2.noSyncTimeValues:当syncTimeProperty为此值时，隐藏同步机制 --%>
									<c:param name="syncTimeProperty" value="syncDataToCalendarTime" />
									<c:param name="noSyncTimeValues" value="noSync" />
							 	</c:import>
							</td>
						</tr>
					</table>
				</ui:content>
			</ui:tabpage>
		</html:form>
		<script language="JavaScript">
			putQuickSelectValue(null);//初始化接收人
			var _validation = $KMSSValidation(document.forms['sysTaskMainForm']);//加载校验框架
			_validation.addValidator('notVal(val)', '<bean:message bundle="sys-task" key="sysTaskMain.validator.msg" />',
				function(v,e,o){
					var val = parseInt(o['val']);
					return parseInt(v) != val;
			});
		</script>
	</template:replace>
</template:include>