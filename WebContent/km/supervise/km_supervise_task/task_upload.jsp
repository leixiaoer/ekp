<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=Edge"); %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
seajs.use(['lui/jquery','lui/dialog',],function($,dialog){
	//excel文件上传完毕
	window.callback = function(result){
		var flag = false;
		if(result){
			if (result.length > 0) {
				for(var i=0;i<result.length;i++){
					if(i==0){
						var temp = result[i].flag;
						if(temp == true){
							flag = true;
							$("#errorDiv").show();
						}
						break;
					}
				}
			}
		}
		if(!flag){
			if(typeof($dialog)!="undefined"){
				//dialog.iframe形式
				$dialog.hide(result);
			}else{
				//兼容window.open和dialog.showModalDialog形式
				if(window.showModalDialog){
					window.returnValue=result;
				}else{
					opener.dialogCallback(result);
				}
				window.close();
			}
		}
		
	}
	
	window.upload = function(){
		var file = document.getElementsByName("file");
		if(file[0].value==null || file[0].value.length==0){
				dialog.alert("<bean:message bundle='km-supervise' key='kmSuperviseMain.import.file.required'/>");
			return false;
		}
		else{
			var form=document.getElementsByName("kmSuperviseTaskForm")[0];
			form.target="file_frame";
			form.submit();
		}
	}
});
</script>
<html:form action="/km/supervise/km_supervise_task/kmSuperviseTask.do?method=importTask&isSysUnitEnable=${JsParam.isSysUnitEnable}" 
	enctype="multipart/form-data"	onsubmit="return validateForm(this);">
	<iframe name="file_frame" style="display:none;"></iframe>	
	<center>
		<div class="upload-container">
			<table class="tb_normal" width="95%">
				<tr>
					<td class="td_normal_title" width="15%">
						<bean:message  bundle="km-supervise" key="kmSuperviseMain.upload.file"/>
					</td>
					<td colspan="3">
						<input name="file" accept=".xls,.xlsx" type="file" class="upload" />
					</td>
				</tr>
			</table>
			<div style="margin-top:20px;">
				<ui:button text="${lfn:message('km-supervise:kmSuperviseMain.button.upload')}" onclick="upload();" />
			</div>
		</div>
		
		<br>
		<div style="display:none;" id="errorDiv">
			<img src="${LUI_ContextPath}/km/supervise/resource/images/status_faile.gif" /> ${lfn:message('km-supervise:tip.import.failed')}
			<br>
			<bean:message bundle="km-supervise" key="tip.import.file.failed"/>
		</div>
	</center>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>