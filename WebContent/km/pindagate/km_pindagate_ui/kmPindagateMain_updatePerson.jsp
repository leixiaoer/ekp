<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog"  sidebar="auto">
	<%--表单--%>
	<template:replace name="head">
		<script language="JavaScript">
		seajs.use(['theme!form']);
		Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");
		Com_IncludeFile("dialog.js|optbar.js");
		</script>
	</template:replace>
	<template:replace name="content"> 
		<form name="kmPindagateMainForm" method="post" action ="${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do">
		<div style="width:600px;margin:10px auto;">
			<table class="tb_normal" width="100%">
				<tr>
					<td class="td_normal_title" style="width:15%">修改方式</td>
					<td>
						变更调查参与人员
						<!-- <labal><input id = "addRadio" type="radio" checked="checked" name="addAndDelete" value="1" />新增人员</labal>
                  		<label><input id="deleteRadio" type="radio" name="addAndDelete" value="2"/>删除人员</label> -->
					</td>
				</tr>
               <tr >
               		<td style="width:15%;">调查参与人员</td>
               		<td>
               			<xform:address idValue="${personIds}" nameValue="${personNames}" isLoadDataDict="false" required="true" mulSelect="true" textarea="true"  subject="" 
							           propertyId="indagateParticipantIds" propertyName="indagateParticipantNames" showStatus="edit" >
						</xform:address>
						<span class="txtstrong"></span>
               		</td>
               </tr>
				<tr>
					<td>通知方式</td>
					<td>
						<!-- <label><input type="radio" checked="checked"/>待办</label>
						<label><input type="radio" />邮件</label>
						<label><input type="radio" />短消息</label> -->
						<kmss:editNotifyType property="fdNotifyType" />
					</td>
				<tr/>
			</table>
		</div>
		<script>
			var validation = $KMSSValidation();
  			var oldPersonIds = $("input[name=indagateParticipantIds]").val();
			function submitBtn(){
				if(!validation.validateElement($("[data-propertyname=indagateParticipantNames]")[0])){
					return;
				}
				var newPersonIds = $("input[name=indagateParticipantIds]").val();
				var removeIds = getChangePerson(oldPersonIds.split(";"),newPersonIds.split(";"));
				var addIds = getChangePerson(newPersonIds.split(";"),oldPersonIds.split(";"));
				addIds = addIds.length>0?addIds.join(";"):"";
				removeIds = removeIds.length>0?removeIds.join(";"):"";	
				var AuthFlag = oldPersonIds?"true":"false";
			  	 $.ajax({
					type:"POST",
					url:"kmPindagateMain.do?method=updatePindagaterRes",
					data:{
						deletedIds:removeIds,
						addedIds:addIds,
						fdId:'${param.fdId}',
						personIds:newPersonIds,
						authFlag:AuthFlag
						},
					success:function(data){
						if(data){
							$(location).attr('href', '${LUI_ContextPath}/resource/jsp/success.jsp');
						} 
					}
				}); 
				
			}
			function getChangePerson(Arr1,Arr2){
				var changeArr = [];
					for(var i = 0;i<Arr1.length;i++){
						var flag = 0;
						for(var j = 0;j<Arr2.length;j++){
							
							if(Arr1[i]===Arr2[j]){
								flag=1;
								break;
							}
						}
						if(flag===0){
							changeArr.push(Arr1[i])
						};
						
					}
					return changeArr;
			}
			
			
     	</script> 
     	</form>
	</template:replace>
</template:include>