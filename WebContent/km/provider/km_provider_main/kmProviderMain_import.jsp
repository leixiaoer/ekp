<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ page import="java.util.*"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script> 
<script type="text/javascript">
	//文件上传
	function upload(){
		var file = document.getElementsByName("file");
		if(file[0].value==null || file[0].value.length==0){
			alert("<bean:message bundle='km-provider' key='kmProviderMain.import.file.required'/>");
			return false;
		}
		else{
			//修改状态为正在执行
			var uploadProcess=document.getElementById("div_uploadProcess");
			uploadProcess.innerHTML="<font color='blue'><bean:message bundle='km-provider' key='kmProviderMain.title.uploadDoing'/></font>";
			//添加参数:是否更新存在数据
			var form=document.getElementsByName("kmProviderMainForm")[0];
			var isUpdate=document.getElementsByName("isUpdate")[0];
			if(isUpdate.checked==true)
				form.action=form.action+"&isUpdate=true";
			form.target="file_frame";
			form.submit();
		}
	}

	//excel文件上传完毕,显示操作信息
	function callback(result){
		var data = eval(result);
		//msg=第%i%行出错,出错字段:%name%,原因:%reason%
		var msg="<bean:message bundle='km-provider' key='kmProviderMain.file.result'/>";
			var show="";
			for(var key in data.msg){
				//文件为空或者Excel不符合规范
				if(key=="0"){
					show+=data.msg[key];
					break;
				}
				//拼接错误详情的HTML：%i%代表第几行，%name%代表出错字段，%reason%代表出错原因
				else{
					var temp=msg;
					var strArray=data.msg[key].split("&");
					temp=temp.replace("%i%",key).replace("%name%",strArray[0]).replace("%reason%",strArray[1]);
					show+=temp+"<br/>";
				}
			}
			document.getElementById("div_successCount").innerHTML=data.success;
			document.getElementById("div_ignoreCount").innerHTML=data.ignore;
			document.getElementById("div_failureCount").innerHTML=data.failure;
			document.getElementById("div_errorCell").innerHTML=show;
			var uploadProcess=document.getElementById("div_uploadProcess");
			uploadProcess.innerHTML="<font color='red'><bean:message bundle='km-provider' key='kmProviderMain.title.uploadFinish'/></font>";
	}

	//展开出错列表
	function showMoreErrInfo(srcImg){
		var obj = document.getElementById("div_errorCell");
		if(obj.style.display=="none"){
			obj.style.display="block";
			srcImg.src = Com_Parameter.StylePath + "msg/minus.gif";
		}else{
			obj.style.display="none";
			srcImg.src = Com_Parameter.StylePath + "msg/plus.gif";
		}
	}

	//改变上传附件,重置导出结果
	function resetResult(){
		var uploadProcess=document.getElementById("div_uploadProcess");
		uploadProcess.innerHTML="<bean:message bundle='km-provider' key='kmProviderMain.title.uploadNotDo'/>";
		document.getElementById("div_successCount").innerHTML="0";
		document.getElementById("div_ignoreCount").innerHTML="0";
		document.getElementById("div_failureCount").innerHTML="0";
		document.getElementById("div_errorCell").innerHTML="";
	} 
	
</script>
<html:form action="/km/provider/km_provider_main/kmProviderMain.do?method=saveExcel"  enctype="multipart/form-data" >
	
	<iframe name="file_frame" style="display:none;"></iframe>
	<p class="txttitle">
		<bean:message bundle="km-provider" key="kmProviderMain.title.upload.file" />
	</p>
	<br />
	<center>
		<table class="tb_normal" width=60%>
			<tr>
				<td  width=15%>
					<bean:message bundle="km-provider" key="kmProviderMain.file" />
				</td>
				<td width=85%>
					<html:file property="file" style="width:70%" styleClass="inputsgl" onchange="resetResult();"/>&nbsp;&nbsp;
					<a href="#" onclick="window.open('provider_template.xls');">
						<bean:message bundle="km-provider" key="kmProviderMain.title.downLoad" />
					</a>
				</td>
			</tr>
			
			<tr>
				<td  width=15%>
					<bean:message bundle="km-provider" key="kmProviderMain.title.select" />
				</td>
				<td width=15%>
					<label><input type="checkbox" name="isUpdate"  /></label>
					<bean:message bundle="km-provider" key="kmProviderMain.tip.select" />
				</td>
			</tr>
			
			<tr><td colspan="2">&nbsp;</td></tr>
			
			<tr>
				<td colspan="2" >
					<bean:message bundle="km-provider" key="kmProviderMain.tip.upload" />
				</td>
			</tr>
			
			<tr><td colspan="2">&nbsp;</td></tr>
			
			<tr>
				<td colspan="2">
					<bean:message bundle="km-provider" key="kmProviderMain.tip.uploadResult" /><br />
					<table class="tb_noborder" width="100%">
						<tr height="25px">
							<td class="msglist" colspan="3">
								<bean:message bundle="km-provider" key="kmProviderMain.title.uploadProcess"/>
								<span id="div_uploadProcess">
										<bean:message bundle="km-provider" key="kmProviderMain.title.uploadNotDo"/>
								</span>
							</td>
						</tr>
						<tr height="25px">
							<td class="msglist">
								<bean:message bundle="km-provider" key="kmProviderMain.title.successCount"/>
								<span id="div_successCount">0</span>
							</td>
							<td class="msglist">
								<bean:message bundle="km-provider" key="kmProviderMain.title.ignoreCount"/>
								<span id="div_ignoreCount">0</span>
							</td>
							<td class="msglist">
								<bean:message bundle="km-provider" key="kmProviderMain.title.failCount"/>
								<span id="div_failureCount">0</span>
							</td>
						</tr>
						<tr height="25px">
							<td class="msglist" colspan="3">
								<image src='${KMSS_Parameter_StylePath}msg/plus.gif' onclick='showMoreErrInfo(this);' style='cursor:pointer'>
								<bean:message bundle="km-provider" key="kmProviderMain.title.detail"/>
								<div id="div_errorCell" style="display:none;margin-left: 20px;"></div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		
		</table>
		<center style="margin-top:20px">
			<input name="uploadBtn" type="button" value="<bean:message bundle="km-provider" key="kmProviderMain.btn.upload" />" onclick="upload();"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="<bean:message key="button.close"/>" onclick="window.close();">
		</center>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>