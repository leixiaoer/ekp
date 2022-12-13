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
				<ui:button text="${lfn:message('button.update')}" 
					onclick="onSubmit('addDynamic');" style="float:right">
				</ui:button>
			</kmss:ifModuleExist>
			<ui:button text="${lfn:message('button.close')}" onclick="Com_CloseWindow();" style="float:right">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
			<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do">
			<p class="txttitle"><bean:message bundle="km-supervise" key="py.ZeRenRenBianGeng"/></p>
			
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
					<c:import url="/km/supervise/km_supervise_task/task_updatePerform.jsp" charEncoding="UTF-8"></c:import>
				</kmss:ifModuleExist>
					
				</table>
			</div>
		<html:hidden property="fdId"/>
		<html:hidden property="fdSponsorId"/>
		<html:hidden property="method_GET" />
		</html:form>
		<script language="JavaScript">
		seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
			window.onSubmit = function(method){
				
				var TABLE_DocList=document.getElementById("TABLE_DocList");
				if(TABLE_DocList.getElementsByTagName("input").length==0){
					alert("<bean:message bundle='km-supervise' key='kmSuperviseMainList.noList' />");
					return false;
				}
				
				var arrayObj = new Array();
			    
			    $("#TABLE_DocList").find("tr").each(function(i){
			    	if(i != 0){
		    		   	var tdArr = $(this).children();
		    		   	
		    		    var index = i - 1;
		    		    var fdId = tdArr.find("#fdId").val();
				        var fdOrganizerDutyId = tdArr.find("input[name='fdItems["+index+"].fdNewOrganizerDutyId']").val();
				        var fdOrganizerDutyName = tdArr.find("input[name='fdItems["+index+"].fdNewOrganizerDutyName']").val();
				        if(fdOrganizerDutyId == null || fdOrganizerDutyId.length == 0){
				        	return;
				        }
				        
				        var data={};
				        data["fdPerformId"] = fdOrganizerDutyId;
				        data["fdPerformName"] = fdOrganizerDutyName;
				        data["fdId"] = fdId;
				        
				        arrayObj.push(data);
			    	}
			     
			    });
			   
			   $.ajax({
			        type: "post",
			        url: "${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=updatePerform",
			        data: {"data":JSON.stringify(arrayObj)},
			        async : true,
			        dataType: "json",
			        success: function (data ,textStatus, jqXHR)
			        {
			            if('0' == data.result ){
			            	addDynamic("updatePerform");
			            	return true;
			            }else{
			            	alert("责任人变更失败!");
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
			
		});
		
		</script>
	</template:replace>
</template:include>

