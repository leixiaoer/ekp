<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
		
		<div class="lui_supervise_panel_content">
			<ui:dataview id="intruction">
				<ui:source type="AjaxJson">
					{url:'/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=getAllInstructions&fdMainId=${param.fdMainId}&fdType=0&rowSize=3'}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/instruction_list.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
			
				<script>
				seajs.use(['lui/dialog','lui/jquery'],function(dialog,$){
					
					window.submitInstruction = function(){
						var desc = document.getElementsByName("fdInstructionDesc")[0].value;
						if(desc != ""){
							$.ajax({
								url: Com_Parameter.ContextPath+'km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=saveInstruction&fdMainId=${param.fdMainId}',
								type: 'POST',
								data:$.param({"desc":desc,"fdType":'0'},true),
								dataType: 'json',
								error: function(data){
									if(window.del_load!=null){
										window.del_load.hide(); 
									}
									dialog.failure('<bean:message key="return.optFailure" />');
								},
								success: topCallback
							});	
						}
					}
					window.topCallback = function(data){
						if(window.del_load!=null)
							window.del_load.hide();
						if(data!=null && data.status==true){
							dialog.success('<bean:message key="return.optSuccess" />');
							window.location.reload();
						}else{
							dialog.failure('<bean:message key="return.optFailure" />');
							window.location.reload();
						}
					};
					//删除
					window.delInstruction = function(fdId){
						dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
							if(value==true){
								window.del_load = dialog.loading();
								$.get('${LUI_ContextPath}/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=delete&fdId='+fdId,
										null,delCallback,'json');
							}
						});
					}
					
					window.delCallback = function(data){
						if(window.del_load!=null)
							window.del_load.hide();
						if(data!=null && data.status==true){
							dialog.success('<bean:message key="return.optSuccess" />');
							window.location.reload();
						}else{
							dialog.failure('<bean:message key="return.optFailure" />');
							window.location.reload();
						}
					}
					
					window.showMore=function(rowSize){
						LUI("intruction").source.setUrl('/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=getAllInstructions&fdMainId=${param.fdMainId}&fdType=0&rowSize='+rowSize);
						LUI("intruction").source.get();
					}
					
				});
				</script>
			</ui:dataview>
			<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddInstruction&fdId=${param.fdMainId}" requestMethod="GET">
          		<div class="lui_supervise_idea_input">
            		<div class="lui_supervise_idea_input_wrap">
              			<textarea class="lui_supervise_idea_input_write" name="fdInstructionDesc" maxlength="200" placeholder="请输入你的批示意见"></textarea>
            		</div>
            		<div class="lui_supervise_idea_input_btn com_bgcolor_d" onclick="submitInstruction();">发表</div>
          		</div>
          	</kmss:auth>
		</div>
	</template:replace>
</template:include>	


