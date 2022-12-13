<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ page import="java.util.*"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<script type="text/javascript">
	
	function upload(){
		var file = $("#trolleyUploadForm [name='fdUploadFile']")[0];
		if(file.value==null || file.value.length==0){
			alert("<bean:message bundle='km-oitems' key='kmOitemsWarehousingRecord.please.checked'/>");
			return;
		}
		Com_Submit(document.getElementById('trolleyUploadForm'),'saveExcel');
	}
	
	//关闭	
	function shutDown(){
		// 遍历所有父窗口判断是否存在$dialog
		var parent = window;
		while (parent) {
			if (typeof(parent.$dialog) != 'undefined') {
				parent.$dialog.hide('colse');
				return;
			}
			if (parent == parent.parent)
				break;
			parent = parent.parent;
		}
		try {
			var win = window;
			for (var frameWin = win.parent; frameWin != null && frameWin != win; frameWin = win.parent) {
				if (frameWin["Frame_CloseWindow"] != null) {
					frameWin["Frame_CloseWindow"](win);
					return;
				}
				win = frameWin;
			}
		} catch (e) {
		}
		try {
			top.opener = top;
			top.open("", "_self");
			top.close();
		} catch (e) {
		}
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
	
</script>
<html:form action="/km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do" styleId="trolleyUploadForm" enctype="multipart/form-data">
	
	<div id="optBarDiv">
		<input type=button value="模板下载" onclick="window.open('imp_shop_template.xls');" />
		<input type=button value="上传" onclick="upload();" />
		<input type="button" value="<bean:message key='button.close'/>" onclick="shutDown();" />
	</div>
	
	<p class="txttitle">数据导入</p>
	<br />
	<center>
		<table class="tb_normal" width=60%>
			<tr>
				<td class="td_normal_title" width=15%>
					文件
				</td>
				<td width=85%>
					<html:file property="fdUploadFile" style="width:90%" styleClass="inputsgl"/>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					导入类型
				</td>
				<td width=15%>
					<xform:radio showStatus="edit" property="fdUploadType" value="append">
						<xform:simpleDataSource value="append">追加数据</xform:simpleDataSource>
						<xform:simpleDataSource value="replace">替换数据</xform:simpleDataSource>
					</xform:radio>
					<input type="hidden" name="fdApplicationId" value="${param.fdAppId}" />
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<bean:message bundle="km-oitems" key="kmOitems.tip.uploadResult" /><br />
					<table class="tb_noborder" width="90%">
						<tr height="25px">
							<td class="msglist" colspan="3">
								<bean:message bundle="km-oitems" key="kmOitems.title.uploadProcess"/>
								<span id="div_uploadProcess">
									<c:if test="${empty result}">
										<bean:message bundle="km-oitems" key="kmOitems.title.uploadNotDo"/>
									</c:if>
									<c:if test="${not empty result}">
										<font color="red"><bean:message bundle="km-oitems" key="kmOitems.title.uploadFinish"/></font>
										<c:if test="${fn:length(result.errorMsgs)>0}">
											&nbsp;<font color="red"><bean:message bundle="km-oitems" key="kmOitems.import.addError"/></font>
										</c:if>
									</c:if>
								</span>
							</td>
						</tr>
						<tr height="25px">
							<td class="msglist" colspan="2">
								<image src='${KMSS_Parameter_StylePath}msg/plus.gif' onclick='showMoreErrInfo(this);' style='cursor:pointer'>
								<bean:message bundle="km-oitems" key="kmOitems.title.detail"/>
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
	</center>
	<html:hidden property="method_GET" />
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>