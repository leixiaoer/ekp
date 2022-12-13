<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:replace name="content"> 
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmSuperviseBackForm" method="post" action ="${KMSS_Parameter_ContextPath}km/supervise/km_supervise_back/kmSuperviseBack.do">
	</c:if>
	<html:hidden property="fdId" />
	<html:hidden property="docSubject" />
   	<html:hidden property="docStatus" />
   	<html:hidden property="method_GET" />
   	<html:hidden property="fdSuperviseId" />
    <c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'>
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseBackForm" />
					<c:param name="fdKey" value="kmSuperviseFeedback" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:tabpage expand="false" var-navwidth="90%" >
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="xform"></c:param>
	  			</c:import>
				<c:import url="/km/supervise/km_supervise_back/kmSuperviseBack_editContent.jsp" charEncoding="UTF-8">
	 		 		<c:param name="contentType" value="other"></c:param>
	  			</c:import>
			</ui:tabpage>
			</form>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript" src="${KMSS_Parameter_ContextPath}km/supervise/resource/js/slider_extras.js"></script>
    <script>
    	var isUndertake = '${kmSuperviseBackForm.isUndertake}';
    	var backType = '${kmSuperviseBackForm.fdBackType}';
    	var method ='${kmSuperviseBackForm.method_GET}';
    	if(isUndertake == 'true' || method == 'edit'){
	        function setProgress(){
	        	var value = document.getElementsByName('fdProgress')[0].value;
	            var type= /^[0-9]*[1-9]*[0-9]*$/;
	           	if(!type.test(value)){
	            	alert("<bean:message bundle='km-supervise' key='kmSuperviseMain.fdSuperviseProgress.alert' />");
	                document.getElementsByName('fdProgress')[0].value = "0";
	            }
	           	sliderImage.setValue(document.getElementsByName('fdProgress')[0].value);
	        }
	        var sliderImage = new neverModules.modules.slider(
					{targetId: "sliderProcess",
						sliderCss: "imageSlider",
						barCss: "imageBar",
						min: 0,
						max: 100,
						hints: ""
					});
			sliderImage.onstart  = function () {
				document.getElementsByName("fdProgress")[0].value = sliderImage.getValue();
			}
			sliderImage.onchange = function () {
				document.getElementsByName("fdProgress")[0].value = sliderImage.getValue();
			};
			sliderImage.onend = function () {
				document.getElementsByName("fdProgress")[0].value = sliderImage.getValue();
				if(sliderImage.getValue() == 100){
					var fdProgress = document.getElementsByName("fdProgress")[0];
					var periodId = document.getElementsByName("fdBackPeriod")[0].value;
					var taskId = document.getElementsByName("fdTaskId")[0].value;
					if(taskId == ''){
						alert("请选择反馈阶段！！");
						return;
					}
					if(periodId == ''){
						alert("请选择反馈周期！！");
						return;
					}
					var fdStatus = document.getElementsByName("fdStatus");
					for(var i = 0;i<fdStatus.length;i++){
						if(i == fdStatus.length - 1){
							//$(fdStatus[i]).attr("checked",true);//已完成
							$(fdStatus[i]).click();
						}else{
							$(fdStatus[i]).removeAttr("checked");
						}
						$(fdStatus[i]).attr("disabled",true);
					}
				}else{
					var fdStatus = document.getElementsByName("fdStatus");
					for(var i = 0;i<fdStatus.length;i++){
						$(fdStatus[i]).attr("disabled",false);
					}
				}
			}
			sliderImage.create();
    	}
    	
    	window.setfdStatus = function(){
    		//获取状态
    		var fdStatus = $('input[name="fdStatus"]:checked').val();
    		//判断状态是否是已完成 是已完成修改督办进度
    		if(fdStatus =='2'){
    			sliderImage.setValue("100");
    		}
    	}
    	window.changePerson = function(){
    		if(method != 'edit'){
	    		var fdPerson = document.getElementsByName('fdPersonId')[0];
	        	var fdPersonId = fdPerson.value;
	        	if(fdPersonId){
	        		var taskData = new KMSSData();
	    		    taskData.AddBeanData("kmSuperviseBackTaskService&fdMainId=${kmSuperviseBackForm.fdSuperviseId}&type=0&fdType=${kmSuperviseBackForm.fdType}");
	    		    taskData.PutToSelect("fdTaskId","id","name");
	        	} 
    		}
    	}
    	
        $().ready(function() {
			if(isUndertake == 'true' || method == 'edit'){
				//setTimeout(setProgress,200);
			}
			
		    if(method != 'edit'){
		    	var taskData = new KMSSData();
			    taskData.AddBeanData("kmSuperviseBackTaskService&fdMainId=${kmSuperviseBackForm.fdSuperviseId}&type=0&fdType=${kmSuperviseBackForm.fdType}");
			    taskData.PutToSelect("fdTaskId","id","name");
		    }
		    
		}); 
        
        function getBackPeriod(val){
        	var data = new KMSSData();
        	if(backType != '0'){
        		var fdPerson = document.getElementsByName('fdPersonId')[0];
            	var fdPersonId = fdPerson.value;
            	data.AddBeanData("kmSuperviseBackTaskService&fdMainId=${kmSuperviseBackForm.fdSuperviseId}&fdTaskId="+val+"&type=1&fdPersonId="+fdPersonId);
            	data.PutToSelect("fdBackPeriod","id","name");
        	}else{
            	data.AddBeanData("kmSuperviseBackTaskService&fdMainId=${kmSuperviseBackForm.fdSuperviseId}&fdTaskId="+val+"&type=3");
            	data.PutToField("fdBackPeriod","fdBackPeriod","",false);
        	}
        	
        	data = new KMSSData();
        	data.AddBeanData("kmSuperviseBackTaskService&fdTaskId="+val+"&type=2");
	    	data.PutToField("fdStageTarget:fdProgress","fdStageTarget:fdProgress","",false);
	    	if(isUndertake == 'true'){
	    		setProgress();
	    	}else{
	    		var progress = document.getElementsByName("fdProgress")[0].value;
		    	document.getElementById("lui_supervise_inner_bar").setAttribute("style","width:"+progress+"%")
		    	document.getElementById("lui_supervise_rate").innerHTML=progress+"%";
	    	}
	    	document.getElementById("fdStageTargetSpan").innerHTML=document.getElementsByName("fdStageTarget")[0].value;
        }
        
    </script>
</template:replace>
<c:choose>
	<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseBackForm" />
					<c:param name="fdKey" value="kmSuperviseFeedback" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				<!-- 关联机制(与原有机制有差异) -->
				<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseBackForm" />
					<c:param name="approveType" value="right" />
					<c:param name="needTitle" value="true" />
				</c:import>
			</ui:tabpanel>
		</template:replace>
	</c:when>
	<c:otherwise>
		<template:replace name="nav">
			<%--关联机制(与原有机制有差异)--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseBackForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
</c:choose>
