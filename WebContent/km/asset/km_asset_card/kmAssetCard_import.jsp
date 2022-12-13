<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ page import="java.util.*"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<script type="text/javascript">
		//初始化
		window.onload = function () {
			var div_success = document.getElementById("div_successCount");
			var div_ignore = document.getElementById("div_ignoreCount");
			var div_failure = document.getElementById("div_failureCount");
			if (div_success.innerHTML == "") {
				div_success.innerHTML = "0";
			}
			if (div_ignore.innerHTML == "") {
				div_ignore.innerHTML = "0";
			}
			if (div_failure.innerHTML == "") {
				div_failure.innerHTML = "0";
			}
		};
		//展开出错列表
		function showMoreErrInfo(srcImg) {
			var obj = document.getElementById("div_errorCell");
			if (obj.style.display == "none") {
				obj.style.display = "block";
				srcImg.src = Com_Parameter.StylePath + "msg/minus.gif";
			} else {
				obj.style.display = "none";
				srcImg.src = Com_Parameter.StylePath + "msg/plus.gif";
			}
		}

		//改变上传附件,重置导出结果
		function resetResult() {
			var uploadProcess = document.getElementById("div_uploadProcess");
			uploadProcess.innerHTML = "<bean:message bundle='km-provider' key='kmProviderMain.title.uploadNotDo'/>";
			document.getElementById("div_successCount").innerHTML = "0";
			document.getElementById("div_ignoreCount").innerHTML = "0";
			document.getElementById("div_failureCount").innerHTML = "0";
			document.getElementById("div_errorCell").innerHTML = "";
		}
		seajs.use([ 'lui/jquery', 'lui/dialog' ], function($, dialog) {
			//检查是否有文件上传
			window.checkFile = function () {
				var file = document.getElementsByName("file");
				if (file[0].value == null || file[0].value.length == 0) {
					dialog.alert("<bean:message bundle='km-asset' key='kmAssetCard.import.file.required'/>");
					return false;
				}else {
					//添加参数:是否更新存在数据
					var form = document.getElementsByName("kmAssetCardForm")[0];
					var isUpdate = document.getElementsByName("isUpdate")[0];
					if (isUpdate.checked == true){
						form.action = form.action + "&isUpdate=true";
					}
					document.getElementsByName("submit")[0].disabled = "disabled";
				}
				return true;
			};

			//进度条处理
			window._progress = function () {
				$.ajax({
					url: Com_Parameter.ContextPath +"km/asset/km_asset_card/kmAssetCard.do?method=getProgressData",
					type: 'post',
					dataType : 'json',
					success: function (data) {//操作成功
						var rtn = data;
						var getProgress = true;
						if(window.progress) {
							var currentCount = parseInt(rtn.currentCount || 0);
							var allCount = parseInt(rtn.totalCount || 0);
							if(rtn.importState == 1 || currentCount >= allCount) {
								var _result = data.result;
								$("#div_successCount").text(_result.successCount);
								$("#div_ignoreCount").text(_result.ignoreCount);
								$("#div_failureCount").text(_result.failCount);
								$("#div_uploadProcess").html('<font color="red"><bean:message bundle="km-provider" key="kmProviderMain.title.uploadFinish"/></font>');
								var errors = [];
								$.each(_result.errorMsgs, function(i, n) {
									errors.push(n);
								});
								$("#div_errorCell").html(errors.join('<br>'));
								window.progress.hide();
								getProgress = false;
								return false;
							}
							// 设置进度值
							if(allCount == -1 || allCount == 0) {
								window.progress.setProgress(0);
							} else {
								window.progress.setProgressText('<bean:message bundle="km-asset" key="km.asset.cardImport.progress"/>' + currentCount + '/' + allCount);
								window.progress.setProgress(currentCount, allCount);
							}
						}
						if(getProgress) {
							setTimeout(function(){
								window._progress();
							}, 2000);
						}
					}
				});
			};
			<c:if test="${'true' eq doImport}">
			//开启进度条
			window.progress = dialog.progress(false);
			window._progress();
			</c:if>
		});
</script>
<html:form action="/km/asset/km_asset_card/kmAssetCard.do?method=importExcel"
	enctype="multipart/form-data" onsubmit="return checkFile();">
	<p class="txttitle">
		<bean:message bundle="km-asset" key="kmAssetCard.import.title" />
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
					<a href="#" onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}km/asset/km_asset_card/kmAssetCard.do?method=downloadTemplet');">
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
					<bean:message bundle="km-asset" key="kmAssetCard.tip.select" />
				</td>
			</tr>
			
			<tr><td colspan="2">&nbsp;</td></tr>
			
			<tr>
				<td colspan="2" >
					<bean:message bundle="km-asset" key="kmAssetCard.tip.upload" />
				</td>
			</tr>
			
			<tr><td colspan="2">&nbsp;</td></tr>
			
			<tr>
				<td colspan="2">
					<bean:message bundle="km-provider" key="kmProviderMain.tip.uploadResult" /><br />
					<table class="tb_noborder" width="90%">
						<tr height="25px">
							<td class="msglist" colspan="3">
								<bean:message bundle="km-provider" key="kmProviderMain.title.uploadProcess"/>
								<span id="div_uploadProcess">
									<c:if test="${empty result}">
										<bean:message bundle="km-provider" key="kmProviderMain.title.uploadNotDo"/>
									</c:if>
									<c:if test="${not empty result}">
										<font color="red"><bean:message bundle="km-provider" key="kmProviderMain.title.uploadFinish"/></font>
									</c:if>
								</span>
							</td>
						</tr>
						<tr height="25px">
							<td class="msglist">
								<bean:message bundle="km-provider" key="kmProviderMain.title.successCount"/>
								<span id="div_successCount">${result.successCount}</span>
							</td>
							<td class="msglist" align="left">
									<bean:message bundle="km-provider" key="kmProviderMain.title.ignoreCount"/>
									<span id="div_ignoreCount">${result.ignoreCount}</span>
							</td>
							<td class="msglist" align="left">
									<bean:message bundle="km-provider" key="kmProviderMain.title.failCount"/>
									<span id="div_failureCount">${result.failCount}</span>
							</td>
						</tr>
						<tr height="25px">
							<td class="msglist" colspan="2">
								<image src='${KMSS_Parameter_StylePath}msg/plus.gif' onclick='showMoreErrInfo(this);' style='cursor:pointer'>
								<bean:message bundle="km-provider" key="kmProviderMain.title.detail"/>
								<br>
								<div id="div_errorCell" style="display:none;margin-left: 20px;width:80%;">
									<c:forEach items="${result.errorMsgs}" var="errorMsg" varStatus="vstatus">
										${errorMsg.value}<br />
									</c:forEach>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		
		</table>
		<center>
			<input name="submit" type="submit" value="<bean:message bundle="km-provider" key="kmProviderMain.btn.upload" />">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="<bean:message key="button.close"/>" onclick="window.close();">
		</center>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>