<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.landray.kmss.util.StringUtil" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>

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
<ui:dataview id="km_pindagate_bridge_record">
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
					<td>${lfn:message("page.serial")}</td>
					<td>${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.person") }</td>
					<td>${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.docSubject") }</td>
					<td>${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.status") }</td>
					<td>${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.fdParticipantNum") }</td>
					<td>${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.fdInvestigatedNum") }</td>
					<td>${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.score") }</td>
		$}
					if(!!document.createElement('canvas').getContext) {
		{$			
					<td>${lfn:message("km-pindagate:kmPindagateMain.operations") }</td>
		$}
					}
		{$
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
		$}
						if(!!document.createElement('canvas').getContext) {
		{$
						<td>
							<a href="javascript:window.qrcodeShow('{%data[i].fdPindageteMainId%}')">	
								<img width="20px" src="${LUI_ContextPath}/sys/ui/extend/theme/default/images/qrcode.png" alt="">	
							</a>
						</td>
		$}
						}
		{$
						<td>
		$}
							<c:if test="${JsParam.isAdmin }">
							{$
								<a class="com_btn_link" 
								   onclick="Com_OpenNewWindow(this)" data-href="{%env.fn.formatUrl('/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=view&fdId=' + data[i].fdPindageteMainId)%}" 
								   target="_blank">${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.detail") }</a>
							$}
							</c:if>
							if(data[i].addResponseUrl) {
		{$
								<a class="com_btn_link" 
								  onclick="Com_OpenNewWindow(this)" data-href="{%env.fn.formatUrl(data[i].addResponseUrl)%}" 
								  target="_blank">{%data[i].addResponseTxt%}</a>
		$}
							}
							<c:if test="${JsParam.isAdmin }">
							if(data[i].resultUrl) {
		{$
								<a class="com_btn_link" 
								   onclick="Com_OpenNewWindow(this)" data-href="{%env.fn.formatUrl(data[i].resultUrl)%}" 
								   target="_blank">${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.result.view") }</a>
		$} 
							}
							if(data[i].startUrl) {
		{$
								<a class="com_btn_link" 
								   data-pindagate-btn="1" 
								   data-pindagate-url="{%data[i].startUrl%}"  
								   target="_blank">${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.start") }</a>
		$}
							}
							if(data[i].stopUrl) {
		{$
								<a class="com_btn_link" 
								   data-pindagate-btn="0" 
								   data-pindagate-url="{%data[i].stopUrl%}" 
								   target="_blank">${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.stop") }</a>
		$}
							}
							</c:if>
		
		{$
						</td>
					</tr>
		$}
		
					}
		{$
			</table>
		$}
			} else {
		{$
		${lfn:message("km-pindagate-bridge:kmPindagateMain.bridge.norecord") }
		$}	
			
			}
		{$
		</div>
		$}
		
	</ui:render>
	<ui:event topic="successReloadPage" args="args" >
		LUI("km_pindagate_bridge_record") &&
		LUI("km_pindagate_bridge_record").refresh
		&& LUI("km_pindagate_bridge_record").refresh();
	</ui:event>
	<ui:event event="load" args="args" >
		var luiId = args.source.cid;
		if(!LUI(luiId)) return;
		if(LUI(luiId).isIndagateBtnBind) return;
		
		$("#" + luiId).on("click", "[data-pindagate-btn]", function(evt) {
			seajs.use(["lui/jquery",  "lui/util/env", "lui/dialog"], function($, env, dialog) {
				var $target = $(evt.currentTarget);
				var status = $target.attr("data-pindagate-btn");
				var url = $target.attr("data-pindagate-url");
				if(!status) return;
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
		LUI(luiId).isIndagateBtnBind = true;
	</ui:event>
</ui:dataview>
<%@ include file="/km/pindagate/qrCode.jsp"%>