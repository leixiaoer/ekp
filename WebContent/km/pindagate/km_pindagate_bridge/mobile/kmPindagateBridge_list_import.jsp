<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.landray.kmss.util.StringUtil" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<link rel="stylesheet" 
	  type="text/css" 
	  href="${LUI_ContextPath}/km/pindagate/km_pindagate_bridge/mobile/style/pIndagateBridgeList.css">
<%
	String unid = request.getParameter("unid");
	unid = StringEscapeUtils.escapeJavaScript(unid);
	String query = "method=findBridge&unid=" + unid;
	
	String  others = request.getParameter("others");
	JSONObject obj = new JSONObject();
	if(others != null && !"".equals(others.trim())) {
		String strObj = URLDecoder.decode(others , "UTF-8");
		obj = JSONObject.fromObject(strObj);
	}
	if(!obj.isEmpty()) {
		Iterator<String> it = obj.keys(); 
		while(it.hasNext()){
			String key = (String)it.next();
			String value = (String)obj.get(key);
			key = StringEscapeUtils.escapeJavaScript(key);
			value = StringEscapeUtils.escapeJavaScript(value);
			query = StringUtil.setQueryParameter(query, key, value);
		}
	}
	String url = "/km/pindagate/km_pindagate_bridge/kmPindagateBridge.do?"  + query;
	pageContext.setAttribute("url", url);
%>

<div data-dojo-type="km/pindagate/km_pindagate_bridge/mobile/kmPindagateBridgeView"
	 data-dojo-props="url:'${url}'">
</div>



<%-- 
<list:listview id="listview" channel="kmPindagateBridge_${JsParam.unid}">
	<ui:source type="AjaxJson">
		{url:'${url}'}
	</ui:source>
	<list:colTable 
		layout="sys.ui.listview.columntable"
		name="columntable"
		rowHref="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=view&fdId=!{fdPindageteMain.fdId}">
		<list:col-serial title="${ lfn:message('page.serial') }" headerStyle="width:5%"></list:col-serial>
		<list:col-auto props="fdTModelDisplayName,fdPindageteMain.docSubject,docStatus,fdPindageteMain.fdParticipantNum,fdPindageteMain.fdLastStatNum,qrcode,operations"/>
	</list:colTable>
</list:listview>
<list:paging channel="kmPindagateBridge_${JsParam.unid}"></list:paging>



<ui:dataview>
	<ui:source type="AjaxJson">
		{url:'${url}'}
	</ui:source>
	<ui:render type="Template">
		{$
		<div>
		$}
			if(data && data.length > 0) {
			
		{$	
			<table class="tb_normal lui_train_attend_infotb" style="width:100%">
				<thead>
					<td>序号</td>
					<td>评估对象</td>
					<td>评估名称</td>
					<td>评估状态</td>
					<td>调查人数</td>
					<td>已完成人数</td>
					<td>得分</td>
					<td>二维码</td>
					<td>${lfn:message('list.operation') }</td>
				</thead>
				
		$}
					for(var i = 0; i < data.length; i ++) {
		{$
					<tr>
						<td>{%i+1%}</td>
						<td>{%env.fn.formatText(data[i].fdTModelDisplayName)%}</td>
						<td>{%env.fn.formatText(data[i].fdPindageteMainSubject)%}</td>
						<td>{%data[i].fdKmPindagateStatus%}</td>
						<td>{%data[i].fdParticipantNum%}</td>
						<td>{%data[i].fdLastStatNum%}</td>
						<td>{%data[i].score ? data[i].score : '-'%}</td>
						<td>
							<a href="javascript:window.qrcodeShow('{%data[i].fdPindageteMainId%}')">	
								<img width="20px" src="/kms/sys/ui/extend/theme/default/images/qrcode.png" alt="">	
							</a>
						</td>
						<td>
		$}
							{$
								<a href="{%env.fn.formatUrl('/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=view&fdId=' + data[i].fdPindageteMainId)%}" 
									target="_blank">详情</a>
							$}
							if(data[i].addResponseUrl) {
		{$
								<a href="{%env.fn.formatUrl(data[i].addResponseUrl)%}" target="_blank">参与调查</a>
		$}
							}
							if(data[i].resultUrl) {
		{$
								<a href="{%env.fn.formatUrl(data[i].resultUrl)%}" target="_blank">查看结果</a>
		$}
							}
							if(data[i].startUrl) {
		{$
								<a data-pindagate-btn="1" data-pindagate-url="{%data[i].startUrl%}"  target="_blank">开始评估</a>
		$}
							}
							if(data[i].stopUrl) {
		{$
								<a data-pindagate-btn="0" data-pindagate-url="{%data[i].stopUrl%}" target="_blank">结束评估</a>
		$}
							}
		
		{$
						</td>
					</tr>
		$}
		
					}
		{$
			</table>
		$}
			}
		{$
		</div>
		$}
		
	</ui:render>
	<ui:event event="load" args="args">
		var luiId = args.source.cid;
		$("#" + luiId).on("click", "[data-pindagate-btn]", function(evt) {
			seajs.use(["lui/jquery",  "lui/util/env", "lui/dialog"], function($, env, dialog) {
				var $target = $(evt.currentTarget);
				var status = $target.attr("data-pindagate-btn");
				var url = $target.attr("data-pindagate-url");
				var txt = status == 1 ? "${lfn:message('km-pindagate:view.comfirmStartIndagate') }" : "${lfn:message('km-pindagate:view.comfirmStopIndagate')}";
				dialog.confirm(txt, function(flag, d) {
					if(flag) {
						$.ajax({
							url : env.fn.formatUrl(url),
							type : "POST",
							dataType : "json",
							success : function() {
								dialog.success("${lfn:message('return.optSuccess')}");
								LUI(luiId).refresh();
							},
							error :  function() {
								dialog.error("${lfn:message('return.optFailure')}");
							}
						});
					}
				});
				
			});
		});
	</ui:event>
</ui:dataview>
<%@ include file="/km/pindagate/qrCode.jsp"%> --%>