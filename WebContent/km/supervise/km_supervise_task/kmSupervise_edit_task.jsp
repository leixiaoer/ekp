<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@ page import="java.util.*"%>
<template:include ref="default.edit" sidebar="no" width="100%">
	<template:replace name="head">
		<style type="text/css">
		.lui_form_body{background:white;}
		</style> 	
		<script type="text/javascript">
		Com_IncludeFile("calendar.js");
		Com_IncludeFile("doclist.js");
		Com_IncludeFile("dialog.js");
		</script>
	</template:replace>
	<template:replace name="toolbar" >
		<ui:toolbar id="optBarDiv" layout="sys.ui.toolbar.float" count="3">
			<kmss:ifModuleExist  path = "/sys/task/">
				<c:if test="${kmSuperviseMainForm.method_GET=='edit'}">
					<ui:button id="updateBut" text="${lfn:message('button.update')}" 
						onclick="update('addDynamic');" style="float:right">
					</ui:button>
				</c:if>
				<c:if test="${kmSuperviseMainForm.method_GET=='add'}">
					<ui:button id="addBut" text="${lfn:message('button.submit')}" onclick="onSubmit('addDynamic');" style="float:right">
					</ui:button>
				</c:if>
			</kmss:ifModuleExist>
			<ui:button text="${lfn:message('button.close')}" onclick="Com_CloseWindow();" style="float:right">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
			<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do">
			<c:if test="${kmSuperviseMainForm.method_GET=='edit'}">
				<p class="txttitle"><bean:message bundle="km-supervise" key="py.RenWuBianGeng"/></p>
			</c:if>
			<c:if test="${kmSuperviseMainForm.method_GET=='add'}">
				<p class="txttitle"><bean:message bundle="km-supervise" key="py.RenWuZhiPai"/></p>
			</c:if>
			
			<div style="background:#fff; padding:16px;">
				<table class="tb_normal" width=95%>
					<tr>
						<!-- 督办事项 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.docSubject"/>
						</td>
						<td width="35%" colspan="4">
							${kmSuperviseMainForm.docSubject }
						</td>
					</tr>
					<tr>
						<!-- 主办单位负责人 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSponsor"/>
						</td>
						<td width="35%">
							${kmSuperviseMainForm.fdSponsorName }
						</td>
						<!-- 指派人 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdResponsible"/>
						</td>
						<td width="35%">
							${kmSuperviseMainForm.fdResponsibleName }
						</td>
					</tr>
					<tr>
						<!-- 立项时间 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdApprovalTime"/>
						</td>
						<td width="35%">
							${kmSuperviseMainForm.fdApprovalTime }
						</td>
						<!-- 完成时限 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdFinishTime"/>
						</td>
						<td width="35%">
							${kmSuperviseMainForm.fdFinishTime }
						</td>
					</tr>
					<tr  align="center"><td colspan="4"><bean:message bundle="km-supervise" key="kmSuperviseMain.task.title"/></td></tr>
				</table>
				<kmss:ifModuleExist  path = "/sys/task/">
					<c:import url="/km/supervise/km_supervise_task/task_add.jsp" charEncoding="UTF-8"></c:import>
				</kmss:ifModuleExist>
					
				</table>
			</div>
		<html:hidden property="fdId"/>
		<html:hidden property="fdSponsorId"/>
		<html:hidden property="method_GET" />
		</html:form>
		<script language="JavaScript">
		seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
			
			var docSubject = "${kmSuperviseMainForm.docSubject }";
			var fdLeadId = "${kmSuperviseMainForm.fdLeadId }";
			var fdLeadName = "${kmSuperviseMainForm.fdLeadName }";
			var fdSponsorId = "${kmSuperviseMainForm.fdSponsorId }";
			var fdAppointName = "${kmSuperviseMainForm.fdSponsorName }";
			var fdModelId = "${kmSuperviseMainForm.fdId }";
			var fdModelName = "com.landray.kmss.km.supervise.model.KmSuperviseMain";
			var fdSourceUrl = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId="+fdModelId;
			
			window.onSubmit = function(method){
				//防止多次点击
				$('#addBut').attr('onclick','').unbind('click'); 
				
				if(!_validation()){
					$('#addBut').attr('onclick',"onSubmit('addDynamic');"); 
					return;
				}
				
			   var arrayObj = getTABLE_DocList();
			   console.log(arrayObj);
			    
			   $.ajax({
			        type: "post",
			        url: "${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=batchSave",
			        data: {"data":JSON.stringify(arrayObj)},
			        async : false,
			        dataType: "json",
			        success: function (data ,textStatus, jqXHR)
			        {
			            if('0' == data.result ){
			            	addDynamic(method);
			            	return true;
			            }else{
			            	alert("添加督办计划失败！");
			                return false;
			            }
			        },
			        error:function (XMLHttpRequest, textStatus, errorThrown) {      
			            alert("请求失败！");
			            return false;
			        }
			     });
				
			};
			
			function addDynamic(method){
				Com_Submit(document.kmSuperviseMainForm, method);
			}
			
			function getTABLE_DocList(){
				 var arrayObj = new Array();
				 $("#TABLE_DocList").find("tr").each(function(i){
				    	if(i != 0){
			    		   	var tdArr = $(this).children();
			    		   	
			    		    var index = i - 1;
			    		   	var fdId = tdArr.find("input[name='fdItems["+index+"].fdId']").val();
			    		    var fdName = tdArr.find("input[name='fdItems["+index+"].docSubject']").val();
			    		  	var fdOrganizerId = tdArr.find("input[name='fdItems["+index+"].fdOrganizerId']").val();
					        var fdOrganizerName = tdArr.find("input[name='fdItems["+index+"].fdOrganizerName']").val();
					        
					        var fdOrganizerDutyId = tdArr.find("input[name='fdItems["+index+"].fdOrganizerDutyId']").val();
					        var fdOrganizerDutyName = tdArr.find("input[name='fdItems["+index+"].fdOrganizerDutyName']").val();
					        
					        var fdPlanStartTime = tdArr.find("input[name='fdItems["+index+"].fdPlanStartTime']").val();
					        var fdPlanEndTime = tdArr.find("input[name='fdItems["+index+"].fdPlanEndTime']").val();
					        
					        var fdPeriod = tdArr.find("select[name='fdItems["+index+"].fdPeriod']").val();
					        
					        var docContent = tdArr.find("textarea[name='fdItems["+index+"].docContent']").val();
					        
					        var data={};
					        data["docSubject"] = fdName;
					        data["fdPerformId"] = fdOrganizerDutyId;
					        data["fdPerformName"] = fdOrganizerDutyName;
					        data["fdAppointId"] = fdSponsorId;
					        data["fdAppointName"] = fdAppointName;
					        data["fdSourceSubject"] = docSubject;
					        data["fdSourceUrl"] = fdSourceUrl;
					        data["fdPlanEndTime"] = fdPlanEndTime;
					        data["fdModelId"] = fdModelId;
					        data["fdModelName"] = fdModelName;
					        data["fdId"] = fdId;
					      	//扩展字段
					        data["fdOrganizerId"] = fdOrganizerId;
					        data["fdOrganizerName"] = fdOrganizerName;
					        data["fdPeriod"] = fdPeriod;
					        data["fdPlanStartTime"] = fdPlanStartTime;
					        //督办领导
					        data["fdLeadId"] = fdLeadId;
					        data["fdLeadName"] = fdLeadName;
					        //计划内容
					        data["docContent"] = docContent;
					        arrayObj.push(data);
				    	}
				   });
				 return arrayObj;
			}
			
			//效验参数
			function _validation(){
				
				var TABLE_DocList=document.getElementById("TABLE_DocList");
				/* if(TABLE_DocList.getElementsByTagName("input").length==0){
					alert("<bean:message bundle='km-supervise' key='kmSuperviseMainList.noList' />");
					return false;
				} */
				
				var flag = true;
				$("#TABLE_DocList").find("tr").each(function(i){
			    	if(i != 0){
		    		   	var tdArr = $(this).children();
		    		   	
		    		    var index = i - 1;
		    		    var fdName = tdArr.find("input[name='fdItems["+index+"].docSubject']").val();
		    		  	var fdOrganizerId = tdArr.find("input[name='fdItems["+index+"].fdOrganizerId']").val();
				        var fdOrganizerName = tdArr.find("input[name='fdItems["+index+"].fdOrganizerName']").val();
				        
				        var fdOrganizerDutyId = tdArr.find("input[name='fdItems["+index+"].fdOrganizerDutyId']").val();
				        var fdOrganizerDutyName = tdArr.find("input[name='fdItems["+index+"].fdOrganizerDutyName']").val();
				        
				        var fdPlanStartTime = tdArr.find("input[name='fdItems["+index+"].fdPlanStartTime']").val();
				        var fdPlanEndTime = tdArr.find("input[name='fdItems["+index+"].fdPlanEndTime']").val();
				        var fdApprovalTime = '${kmSuperviseMainForm.fdApprovalTime }';
				        var fdFinishTime = '${kmSuperviseMainForm.fdFinishTime }';
				        var fdPeriod = tdArr.find("select[name='fdItems["+index+"].fdPeriod']").val();
				        if(null == fdName || fdName.length == 0){
				        	alert("<bean:message bundle='km-supervise' key='task.fdName.noNull' />");
				        	flag = false;
				        	return false;
				        }
				        if(null == fdOrganizerId || fdOrganizerId.length == 0){
				        	alert("<bean:message bundle='km-supervise' key='task.fdOrganizerId.noNull' />");
				        	flag = false;
				        	return false;
				        }
				        if(null == fdOrganizerDutyId || fdOrganizerDutyId.length == 0){
				        	alert("<bean:message bundle='km-supervise' key='task.fdOrganizerDutyId.noNull' />");
				        	flag = false;
				        	return false;
				        }
				        if(null == fdPlanStartTime || fdPlanStartTime.length == 0){
				        	alert("<bean:message bundle='km-supervise' key='task.fdPlanStartTime.noNull' />");
				        	flag = false;
				        	return false;
				        }
				        if(null == fdPlanEndTime || fdPlanEndTime.length == 0){
				        	alert("<bean:message bundle='km-supervise' key='task.fdPlanEndTime.noNull' />");
				        	flag = false;
				        	return false;
				        }
				        if(Com_GetDate(fdPlanStartTime, 'datetime').getTime() < Com_GetDate(fdApprovalTime, 'datetime').getTime() 
				        		|| Com_GetDate(fdPlanStartTime, 'datetime').getTime() > Com_GetDate(fdPlanEndTime, 'datetime').getTime()){
				        	alert("<bean:message bundle='km-supervise' key='kmSuperviseMain.validation.fdPlanStartTime' />");
				        	flag = false;
				        	return false;
				        }
				        if(Com_GetDate(fdPlanEndTime, 'datetime').getTime() > Com_GetDate(fdFinishTime, 'datetime').getTime() 
				        		|| Com_GetDate(fdPlanEndTime, 'datetime').getTime() < Com_GetDate(fdApprovalTime, 'datetime').getTime()){
				        	alert("<bean:message bundle='km-supervise' key='kmSuperviseMain.validation.fdPlanEndTime' />");
				        	flag = false;
				        	return false;
				        }
				        if(null == fdPeriod || fdPeriod.length == 0){
				        	alert("<bean:message bundle='km-supervise' key='kmSuperviseMain.validation.fdPeriod' />");
				        	flag = false;
				        	return false;
				        }
				    
				     }
			    });
				return flag ? true : false;
			}
			
			//督办变更
			window.update = function(method){
				//防止多次点击
				$('#updateBut').attr('onclick','').unbind('click'); 
				
				if(!_validation()){
					$('#updateBut').attr('onclick',"update('addDynamic');"); 
					return;
				}
				
			   var arrayObj = getTABLE_DocList();;
			   console.log(arrayObj);
			   
			   $.ajax({
			        type: "post",
			        url: "${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=batchUpdate",
			        data: {"data":JSON.stringify(arrayObj),"fdIds":deleteIds},
			        async : true,
			        dataType: "json",
			        success: function (data ,textStatus, jqXHR)
			        {
			            if('0' == data.result ){
			            	addDynamic(method);
			            	return true;
			            }else{
			            	alert("更新督办计划失败！");
			                return false;
			            }
			        },
			        error:function (XMLHttpRequest, textStatus, errorThrown) {      
			            alert("请求失败！");
			            return false;
			        }
			     });
				
				
			};
			
		});
		
		</script>
		<script language="JavaScript">
			var validation = $KMSSValidation(document.forms['kmSuperviseMainForm']);
		</script>
	</template:replace>
</template:include>

