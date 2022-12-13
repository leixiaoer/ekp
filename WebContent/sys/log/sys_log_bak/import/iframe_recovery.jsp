<%@page import="com.landray.kmss.sys.log.util.LogBakConstant"%>
<%@page import="com.landray.kmss.sys.log.model.SysLogBakDetail"%>
<%@page import="com.landray.kmss.sys.log.model.SysLogBak"%>
<%@page import="com.landray.kmss.sys.log.service.ISysLogBakService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%
	String fdId = request.getParameter("fdId");
	if(fdId != null){
		ISysLogBakService service = (ISysLogBakService)SpringBeanUtil.getBean("sysLogBakService");
		SysLogBak bak = (SysLogBak)service.findByPrimaryKey(fdId);
		if(bak!=null){
			//从明细中查找最新一条成功的备份信息对应的文件名
			Date lastDate = null;
			String lastFile = "";
			List<SysLogBakDetail> list = bak.getFdDetail();
			for(SysLogBakDetail detail : list){
				if(LogBakConstant.detailType.BACKUP.getVal().equals(detail.getFdType()) &&
						LogBakConstant.detailStatus.SUCCESS.getVal().equals(detail.getFdStatus())){
					if(detail.getFdEndTime() != null && (lastDate == null || lastDate.getTime() < detail.getFdEndTime().getTime())){
						lastDate = detail.getFdEndTime();
						lastFile = detail.getFdFileName();
					}
				}
			}
			request.setAttribute("lastFile", lastFile);
			request.setAttribute("filePath", service.getElasticPath());
		}
	}
%>

<template:include ref="default.dialog">
	<template:replace name="content">
		<center>
			<script  type="text/javascript">
				seajs.use([ 'lui/jquery','lui/dialog'],function($, dialog) {
					//确认
					window.clickOK = function() {
						var data = $dialog.content.params.data;
						var url = $dialog.content.params.url;
						if(!url) {
							dialog.alert('<bean:message key="errors.required" arg0="URL"/>');
							return false;
						}
						
						var fileName = $("input[name='fileName']").val();
						data += "&fileName=" + fileName;

						if(!fileName){
							dialog.alert('<bean:message key="errors.required" arg0="${lfn:message(\'sys-log:sysLogBakDetail.fdFileName\')}"/>');
							return false;
						}
						
						var config = {
								url: url,
								data: data
						};
						__Com_Delete_Ajax(config, callback, dialog);
					};
					
					window.callback = function(data) {
						$dialog.hide(data);
					}
				});
				
			</script>
			
			<!-- 提示框 Starts -->
			<div>
			<br/><br/>
                ${lfn:message('sys-log:page.comfirmRecovery')}<br/>
               	<span style="color:gray">${filePath }</span><xform:text value="${lastFile }" property="fileName" required="true" htmlElementProperties="placeholder='${lfn:message('sys-log:sysLogBakDetail.fdFileName')}'" style="width:250px" showStatus="edit"/><br/>
                <span style="color:gray">(${lfn:message('sys-log:page.error.fileName')})</span><br/>
			</div>
			<!-- 提示框 Ends -->
			<ui:button onclick="clickOK();" text="${lfn:message('button.ok')}" />
			<ui:button onclick="Com_CloseWindow();" text="${lfn:message('button.close')}" />
		</center>
		<style>
			span{
			    padding: 8px;
				word-break: break-word;
			}
		</style>
	</template:replace>
</template:include>
