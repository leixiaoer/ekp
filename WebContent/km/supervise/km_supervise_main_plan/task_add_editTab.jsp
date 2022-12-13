<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:replace name="content"> 
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmSuperviseMainPlanForm" method="post" action ="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main_plan/kmSuperviseMainPlan.do">
	</c:if>
	<html:hidden property="fdId"/>
	<html:hidden property="docSubject"/>
	<html:hidden property="docStatus"/>
	<html:hidden property="fdMainId"/>
	<html:hidden property="method_GET" />
    <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpage collapsed="true" id="reviewTabPage">
				<script>
					LUI.ready(function(){
						setTimeout(function(){
							var reviewTabPage = LUI("reviewTabPage");
							if(reviewTabPage!=null){
								reviewTabPage.element.find(".lui_tabpage_float_collapse").hide();
								reviewTabPage.element.find(".lui_tabpage_float_navs_mark").hide();
							}
						},100)
					})
				</script>
				<c:import url="/km/supervise/km_supervise_main_plan/task_add_editContent.jsp" charEncoding="UTF-8">
	  				<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
			</ui:tabpage>
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainPlanForm" />
					<c:param name="fdKey" value="kmSuperviseMakePlan" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
				<c:import url="/km/supervise/km_supervise_main_plan/task_add_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	 		 		<c:param name="approveModel" value="${param.approveModel}"></c:param>
	  			</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/supervise/km_supervise_main_plan/task_add_editContent.jsp" charEncoding="UTF-8">
	  				<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
	  			<c:import url="/km/supervise/km_supervise_main_plan/task_add_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	  			</c:import>
			</ui:tabpage>
			</form>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript">
		var validation = $KMSSValidation(document.forms['kmSuperviseMainPlanForm']);
		var fdStartTime = "${kmSuperviseMainPlanForm.fdStartTime}";
		var fdFinishTime = "${kmSuperviseMainPlanForm.fdFinishTime}";
		validation.addValidator('validateTime','11111',function(v,e,o){
			var flag = false;
			var result = _validateTime(v,e,o);
			if(result == "0"){
				flag = true;
			}
			if(result == "1"){
				validator = this.getValidator('validateTime');
				var error = '督办开始时间和结束时间不能为空';
				validator.error = error;
			}
			if(result == "2"){
				validator = this.getValidator('validateTime');
				var error = '计划开始时间不能早于督办开始时间';
				validator.error = error;
			}
			if(result == "3"){
				validator = this.getValidator('validateTime');
				var error = '计划开始时间不能晚于督办结束时间';
				validator.error = error;
			}
			if(result == "4"){
				validator = this.getValidator('validateTime');
				var error = '计划截止时间不能早于督办开始时间';
				validator.error = error;
			}
			if(result == "5"){
				validator = this.getValidator('validateTime');
				var error = '计划截止时间不能晚于督办结束时间';
				validator.error = error;
			}
			if(result == "6"){
				validator = this.getValidator('validateTime');
				var error = '计划截止时间不能早于计划开始时间';
				validator.error = error;
			}
			if(result == "7"){
				validator = this.getValidator('validateTime');
				var error = '计划开始时间不能早于计划结束时间';
				validator.error = error;
			}
			return flag;
		});
		
		var _validateTime = function(v,e,o){
			if(fdStartTime == "" || fdFinishTime==""){
				return "1";
			}
			var ds = Com_GetDate(fdStartTime);
			var de = Com_GetDate(fdFinishTime);
			var dv = Com_GetDate(v);

			if(e.name.indexOf("fdPlanStartTime") > -1 ){
				var fdPlanEndTime = e.name.replace("fdPlanStartTime","fdPlanEndTime");
				var endTime = $('[name="'+fdPlanEndTime+'"]').val();
				var end = Com_GetDate(endTime);
				if(dv < ds){
					return "2";
				}
				if(dv > de){
					return "3";
				}
				if(dv > end){
					return "7";
				}
			}else if(e.name.indexOf("fdPlanEndTime") > -1){
				var fdPlanStartTime = e.name.replace("fdPlanEndTime","fdPlanStartTime");
				var startTime = $('[name="'+fdPlanStartTime+'"]').val();
				var start = Com_GetDate(startTime);
				if(dv < ds){
					return "4";
				}
				if(dv > de){
					return "5";
				}
				if(dv < start){
					return "6";
				}
			}
			return "0";
		};
		
		var isSysUnitEnable = "${kmSuperviseMainPlanForm.fdSysUnitEnable}";
		var fdOtherUnitIds = "${kmSuperviseMainPlanForm.fdOtherUnitIds}";
		var fdOtherUnitNames = "${kmSuperviseMainPlanForm.fdOtherUnitNames}";
		var fdOUnitIds = "${kmSuperviseMainPlanForm.fdOUnitIds}";
		var fdOUnitNames = "${kmSuperviseMainPlanForm.fdOUnitNames}";
		//增加行
		function addRow(){
			var fieldValues = new Object();
			var optTB = document.getElementById("TABLE_DocList");
			var tbInfo = DocList_TableInfo[optTB.id];
			var index = tbInfo.lastIndex;
			var length = tbInfo.lastIndex - tbInfo.firstIndex;
			fieldValues["fdTaskItems[!{index}].docSubject"]="阶段"+ tbInfo.lastIndex;
			fieldValues["fdTaskItems[!{index}].fdPlanStartTime"]=fdStartTime;
			fieldValues["fdTaskItems[!{index}].fdPlanEndTime"]=fdFinishTime;
			if(isSysUnitEnable == 'true'){
				fieldValues["fdTaskItems[!{index}].fdOtherUnitIds"]=fdOtherUnitIds;
				fieldValues["fdTaskItems[!{index}].fdOtherUnitNames"]=fdOtherUnitNames;
			}else{
				fieldValues["fdTaskItems[!{index}].fdOUnitIds"]=fdOUnitIds;
				fieldValues["fdTaskItems[!{index}].fdOUnitNames"]=fdOUnitNames;
			}
			DocList_AddRow("TABLE_DocList",null,fieldValues);
		}
		
		if(isSysUnitEnable == 'true'){
			$(document).on('table-add',"table[id$='TABLE_DocList']",function(e, row) {
				if(window.$) {
					try {
						var ads = $(row).find('[xform-newdialog="true"]');
						$.each(ads,function(index,item) {
							var $item = $(item);
							var xformName = $item.attr('xform-name');
							var _field = $("[xform-name='"+xformName+"']")[0];
							var idField = document.getElementsByName($item.data('propertyid'))[0];
							var nameField = document.getElementsByName($item.data('propertyname'))[0];
							var idValue = idField.value;
							var nameValue = nameField.value;
							var $input = $(_field);
							var propertyId = $input.data('propertyid');
							var propertyName = $input.data('propertyname');
							var isMulti = eval($input.data('ismulti'));
							emptyNewAddress(propertyName,null,0,false);
							initNewDialog(propertyId,propertyName,";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",isMulti,"","",null);
							if(idValue != "" && nameValue !=""){
								resetNewDialog(propertyId,propertyName,";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",isMulti,idValue,nameValue,null);
							}
						});
					}catch(err) {
						kmss_console_log(err);
					}
				}
			});
		}
		
		function commitMethod(commitType, saveDraft){
			var formObj = document.kmSuperviseMainPlanForm;
			var docStatus = document.getElementsByName("docStatus")[0];
			if(saveDraft=="true"){
				docStatus.value="10";
			}else{
				docStatus.value="20";
			}
			if('save'==commitType){
				Com_Submit(formObj, commitType,'fdId');
		    }else{
		    	Com_Submit(formObj, commitType); 
		    }
		}
		
		window.onload = function(){
			addRow();
		}
		
		seajs.use(['lui/dialog','lui/jquery'],function(dialog,$){
			window.stageChange = function(val){
				var stage = "";
				if(val == "0"){
					stage = "默认";
				}else if(val == "1"){
					stage = "周";
				}else if(val == "2"){
					stage = "双周";
				}else if(val == "3"){
					stage = "月";
				}else if(val == "4"){
					stage = "季度";
				}else if(val == "5"){
					stage = "年";
				}
				dialog.confirm("${lfn:message('km-supervise:py.description.refreshStage')}".replace('%stage%',stage),function(flag){
					if(flag){
						var allTR = document.getElementById("TABLE_DocList").getElementsByClassName("task_add_class");
						for(var i = allTR.length - 1 ; i >= 0 ;i--){
							DocList_DeleteRow(allTR[i]);
						}
						var data = new KMSSData();
						var url = "${KMSS_Parameter_ContextPath}km/supervise/km_supervise_task/kmSuperviseTask.do?method=autoAddTask&fdStartTime="+fdStartTime+"&fdFinishTime="+fdFinishTime+"&fdStageType="+val;
					    data.SendToUrl(url, function(data) {
							var results = eval("(" + data.responseText + ")");
							if (results.length > 0) {
								
								for(var i=0;i<results.length;i++){
									var fieldValues = new Object();
									fieldValues["fdTaskItems[!{index}].docSubject"]="阶段"+(i+1);
									fieldValues["fdTaskItems[!{index}].fdPlanStartTime"]=results[i].fdPlanStartTime;
									fieldValues["fdTaskItems[!{index}].fdPlanEndTime"]=results[i].fdPlanEndTime;
									if(isSysUnitEnable == 'true'){
										fieldValues["fdTaskItems[!{index}].fdOtherUnitIds"]=fdOtherUnitIds;
										fieldValues["fdTaskItems[!{index}].fdOtherUnitNames"]=fdOtherUnitNames;
									}else{
										fieldValues["fdTaskItems[!{index}].fdOUnitIds"]=fdOUnitIds;
										fieldValues["fdTaskItems[!{index}].fdOUnitNames"]=fdOUnitNames;
									}
									DocList_AddRow(document.getElementById("TABLE_DocList"),null,fieldValues);
							   }
							}
						});
					}
				});
			}
			
			window.downloadTemlate = function(){
				Com_OpenWindow('<c:url value="/km/supervise/km_supervise_task/kmSuperviseTask.do" />?method=downloadTemplate&isSysUnitEnable=${kmSuperviseMainPlanForm.fdSysUnitEnable}');
			}
			
			window.importExcel = function(){
				var path = "/km/supervise/km_supervise_task/task_upload.jsp?isSysUnitEnable=${kmSuperviseMainPlanForm.fdSysUnitEnable}"
				dialog.iframe(path,"${lfn:message('km-supervise:kmSuperviseTask.import.title')}",function(results){
					if (results.length > 0) {
						for(var i=0;i<results.length;i++){
							var fieldValues = new Object();
							fieldValues["fdTaskItems[!{index}].docSubject"]=results[i].docSubject;
							fieldValues["fdTaskItems[!{index}].docContent"]=results[i].docContent;
							fieldValues["fdTaskItems[!{index}].fdPlanStartTime"]=results[i].fdPlanStartTime;
							fieldValues["fdTaskItems[!{index}].fdPlanEndTime"]=results[i].fdPlanEndTime;
							if(isSysUnitEnable == 'true'){
								if(results[i].fdSysUnitId&&results[i].fdSysUnitName){
									fieldValues["fdTaskItems[!{index}].fdSysUnitId"]=results[i].fdSysUnitId;
									fieldValues["fdTaskItems[!{index}].fdSysUnitName"]=results[i].fdSysUnitName;
								}
								if(results[i].fdOtherUnitIds&&results[i].fdOtherUnitNames){
									fieldValues["fdTaskItems[!{index}].fdOtherUnitIds"]=results[i].fdOtherUnitIds;
									fieldValues["fdTaskItems[!{index}].fdOtherUnitNames"]=results[i].fdOtherUnitNames;
								}
							}else{
								if(results[i].fdUnitId&&results[i].fdUnitName){
									fieldValues["fdTaskItems[!{index}].fdUnitId"]=results[i].fdUnitId;
									fieldValues["fdTaskItems[!{index}].fdUnitName"]=results[i].fdUnitName;
								}
								if(results[i].fdOUnitIds&&results[i].fdOUnitNames){
									fieldValues["fdTaskItems[!{index}].fdOUnitIds"]=results[i].fdOUnitIds;
									fieldValues["fdTaskItems[!{index}].fdOUnitNames"]=results[i].fdOUnitNames;
								}
							}
							
							if(results[i].fdSponsorId&&results[i].fdSponsorName){
								fieldValues["fdTaskItems[!{index}].fdSponsorId"]=results[i].fdSponsorId;
								fieldValues["fdTaskItems[!{index}].fdSponsorName"]=results[i].fdSponsorName;
							}
							DocList_AddRow(document.getElementById("TABLE_DocList"),null,fieldValues);
					   }
					}
				},{width:450,height:240});
			}
			
			window.previewBackDay = function(){
				var fdBackType = document.getElementsByName("fdBackType")[0];
				var backType = fdBackType.value;
				var allTR = document.getElementById("TABLE_DocList").getElementsByTagName("TR");
				var stages = []; 
				for(var i = 1 ;i < allTR.length;i++){
					var vals = {};
					var optTR = allTR[i];
					$(optTR).find(":input").each(function(idx, elem){
						var domNode = $(elem); 
						if(elem && elem.name){
							if(elem.name.indexOf("fdPlanStartTime") > -1 ){
								vals["fdPlanStartTime"] = DocList_getFiledValue(optTR,elem.name);
							}else if(elem.name.indexOf("fdPlanEndTime") > -1){
								vals["fdPlanEndTime"] = DocList_getFiledValue(optTR,elem.name);
							}else if(elem.name.indexOf("docSubject") > -1){
								vals["docSubject"] = DocList_getFiledValue(optTR,elem.name);
							}
						}
					});
					stages.push(vals);
				}
				var stageStr = JSON.stringify(stages);
				stageStr = encodeURI(stageStr);
				dialog.iframe("/km/supervise/km_supervise_main/import/back_day_preview_frame.jsp?&fdBackType="+backType+"&stages="+stageStr,
	           			'反馈日预览',null,{width:600,height:360});
			}
			
		});
	</script>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
	<template:replace name="barRight">
		<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
			<%--流程--%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainPlanForm" />
				<c:param name="fdKey" value="kmSuperviseMakePlan" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
				<c:param name="approveType" value="right" />
				<c:param name="approvePosition" value="right" />
			</c:import>
		</ui:tabpanel>
	</template:replace>
</c:if>
