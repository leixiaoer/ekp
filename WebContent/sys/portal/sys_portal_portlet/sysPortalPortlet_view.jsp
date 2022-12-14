<%@page import="com.landray.kmss.util.ArrayUtil"%>
<%@page import="com.landray.kmss.sys.ui.xml.model.SysUiRender"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="org.apache.commons.beanutils.BeanUtils"%>
<%@page import="com.landray.kmss.sys.ui.xml.model.SysUiSource"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.view" width="95%" sidebar="no">
	<template:replace name="title"><bean:message  bundle="sys-portal" key="sys.portal.preview"/></template:replace>
 	<template:replace name="content">
 	<script>
 	Com_IncludeFile("dialog.js");
 	</script>
 	<style>
 	.OverChecked {
 	overflow-y:auto;
 	}
 	</style>
		<p class="txttitle">Portlet<bean:message  bundle="sys-portal" key="sys.portal.syswidget"/></p>		 
		<table class="tb_normal" width=95%>
			<tr>
				<td class="td_normal_title" width=15%>
					ID
				</td>
				<td width="85%">
					<xform:text property="fdId" style="width:85%" />
				</td>
			</tr>
			<tr>	
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="sys-portal" key="sysPortalPage.fdName"/>
				</td>
				<td width=85%>
					<xform:text property="fdName" style="width:85%" />
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="sys-portal" key="sysPortalPortlet.fdModule"/>
				</td>
				<td width="85%">
					${ sysPortalPortletForm.fdModule }
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					${ lfn:message('sys-portal:sysPortal.portal.width') }
				</td>
				<td width="85%">
				<label><input type="radio" id="width1" name="width" checked="checked"  onclick="chwidth(600)"/>600</label>
				<label><input type="radio" id="width2" name="width" onclick="chwidth(300)"/>300</label>
				<label><input type="radio" id="width3" name="width" onclick="chwidth(180)"/>180</label>
				<input type="text" id="width4" name="width" /><input type="button" name="widthButton" value="${ lfn:message('sys-portal:sysPortal.portal.diy') }" onclick="changeWidth()"/>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					${ lfn:message('sys-portal:sysPortal.portal.height') }
				</td>
				<td width="85%">
				<label><input type="radio" id="height1" name="height" onclick="chheight(600)"/>600</label>
				<label><input type="radio" id="height2" name="height"  checked="checked"  onclick="chheight(400)"/>400</label>
				<label><input type="radio" id="height3" name="height" onclick="chheight(200)"/>200</label>
				<input type="text" id="height4" name="height"/><input type="button" name="heightButton" value="${ lfn:message('sys-portal:sysPortal.portal.diy') }" onclick="changeHeight()"/>
				<input type="checkbox" id="overBox" onchange="overChange()">${ lfn:message('sys-portal:sysPortal.portal.auto.increase') }
				</td>
			</tr>
			<tr>
				<td width="100%" colspan="2">
					<table width="100%">
						<tr>
							<td valign="top" width="40%">
								<div style="border: 1px red solid;" id="previewBox" >
									<iframe id="preview_portlet" frameborder="0" width="100%" height="100%"></iframe>
								</div>
							</td>
							<td width="1%"></td>
							<td valign="top" width="40%">
								<% 	
									String jsname = "v_"+IDGenerator.generateID(); 
									String sourceId = BeanUtils.getProperty(request.getAttribute("sysPortalPortletForm"),"fdSource");
									SysUiSource source = SysUiPluginUtil.getSourceById(sourceId);
									String renderId = SysUiPluginUtil.getFormatById(source.getFdFormat()).getFdDefaultRender();
									pageContext.setAttribute("sourceId",sourceId);
									pageContext.setAttribute("renderId",renderId);
									pageContext.setAttribute("formats",ArrayUtil.concat(source.getFdFormats(),';'));
								%>
								<script src="${ LUI_ContextPath }/sys/ui/js/var.js"></script> 
								<table class="tb_normal" width="100%" id="porlet">
								<tbody>
									<tr>
										<input type="hidden" name="portlet_input_source_format" class="portlet_input_source_format" value="${ sysPortalPortletForm.fdFormat }"/>
										<input type="hidden" name="portlet_input_source_formats" class="portlet_input_source_formats"  value="${ sysPortalPortletForm.fdFormat }"/>
										<input type="hidden" name="portlet_input_source_id" class='portlet_input_source_id'  value="${ sysPortalPortletForm.fdSource }"/>
										<td><bean:message  bundle="sys-portal" key="sysHomeNav.display.data"/></td>
										<td><div class="portlet_input_source_opt" jsname='_source_opt'></div></td>
									</tr>
					<%-- 	<tr>
										<td><bean:message  bundle="sys-portal" key="sysPortalPage.desgin.msg.render"/><br>
											<a href="javascript:selectRender()"><bean:message  bundle="sys-portal" key="sysPortalPortlet.External.access"/></a>
										</td>
										<td><div class="portlet_input_render_opt" jsname='_render_opt'></div></td>
									</tr> --%>
									<tr>
										<td colspan="2" style="background: #f6f6f6;"><label><input type="checkbox" checked onclick="openPortletRenderSetting(this)" />${ lfn:message('sys-portal:sysPortalPage.desgin.msg.advOpt') }</label></td>
									</tr>
									</tbody>
									<tbody class="portlet_render_setting">							
									<tr>
										<td class="td_normal_title" width="15%">${ lfn:message('sys-portal:sysPortalPage.desgin.msg.render') }</td>
										<td>
											<input type="hidden" name="portlet_input_render_id" class="portlet_input_render_id" />
											<input type="text" readonly="readonly" name="portlet_input_render_name" class="inputsgl portlet_input_render_name" style="width:80%" />
											<a href="javascript:void(0)" class="com_btn_link" onclick="openPortletRenderDialog(this)">${ lfn:message('sys-portal:sysPortalPage.desgin.msg.select') }</a>
											<div class="portlet_input_render_opt" jsname='_render_opt' style="display:none;width:80%">${ lfn:message('sys-portal:sysPortalPage.desgin.msg.renderOpt') }</div>
										</td>
									</tr>
									<tr>
										<td class="td_normal_title">
											${ lfn:message('sys-portal:sysPortalPage.desgin.msg.refresh') }
										</td>
										<td>
											<input type="text" name="portlet_refresh_time" class="inputsgl portlet_refresh_time" onkeyup="this.value=this.value.replace(/\D/gi,'')" />${ lfn:message('sys-portal:sysPortalPage.desgin.msg.refresh1') } <span class="com_help">(${ lfn:message('sys-portal:sysPortalPage.desgin.msg.refresh2') })</span>
										</td>
									</tr>
									<tr>
										<td class="td_normal_title">											
											${ lfn:message('sys-portal:sysPortalPage.msg.extClass') }
										</td>
										<td>
											<select name="portlet_extend_class" class="inputsgl portlet_extend_class" >
												<option value=""> == ${ lfn:message('sys-portal:sysPortalPage.msg.selectExt') } == </option>
												<option value="lui_panel_ext_padding">${ lfn:message('sys-portal:sysPortalPage.msg.extPadding') }</option>
											</select>
										</td>
									</tr>
								</tbody>
								</table>
								<script>
								var lodingImg = "<img src='${LUI_ContextPath}/sys/ui/js/ajax.gif'/>";
								var dialogWin = window;
								window.scene = "${param['scene']}";
								function ondocready(cb){
									var _url = window.location.href || '';
									// ????????????
									var _renderId = Com_GetUrlParameter(_url,"renderId") || "${renderId}";
									var _renderName = Com_GetUrlParameter(_url,"renderName") || "";

									$(".portlet_input_source_opt").html(lodingImg).load("${LUI_ContextPath}/sys/ui/jsp/vars/source.jsp?x="+(new Date().getTime()),{"fdId":"${sourceId}","renderId":_renderId,"jsname":"_source_opt"},function(){
										$(".portlet_input_render_opt").attr("renderId",_renderId);
										$(".portlet_input_render_opt").show()
										$(".portlet_input_render_name").val(_renderName)
										$(".portlet_input_render_opt").html(lodingImg).load("${LUI_ContextPath}/sys/ui/jsp/vars/render.jsp?x="+(new Date().getTime()),{"fdId":_renderId,"jsname":"_render_opt"},function(){
											 if(cb)
												 cb();
										});
									});	
									chwidth(600);
									chheight(400);
								}
								function selectRender(){
									seajs.use(['lui/dialog'],function(dialog){
										dialog.iframe("/sys/portal/designer/jsp/selectportletrender.jsp?format="+encodeURIComponent("${formats}")+"&scene=portal", "${ lfn:message('sys-portal:sysPortalPage.desgin.selectrender') }", function(val){
											if(!val){
												return;
											}
											$(".portlet_input_render_opt").attr("renderId",val.renderId);
											$(".portlet_input_render_opt").html(lodingImg).load("${LUI_ContextPath}/sys/ui/jsp/vars/render.jsp?x="+(new Date().getTime()),{"fdId":val.renderId,"jsname":"_render_opt"},function(){
												onRefresh();
											});
										}, {width:750,height:550}); 
									});
								}
								function getConfigValues(){
									var config = {};
									if(window['_source_opt']!=null){
										config.sourceOpt = window['_source_opt'].getValue();
									}else{
										config.sourceOpt = {};
									}
									if(window['_render_opt']!=null){
										config.renderOpt = window['_render_opt'].getValue();
									}else{
										config.renderOpt = {};
									}
									return config;
								}
								function generateURL(vars){
									var urlPrefix = "<%= ResourceUtil.getKmssConfigString("kmss.urlPrefix")%>";
									var base = "/resource/jsp/widget.jsp?portletId=${sysPortalPortletForm.fdId}"; 
									var url = base; 
									if($.trim(vars.renderId)!=""){
										url+="&renderId="+$.trim(vars.renderId);
									}
									url+="&sourceOpt="+encodeURIComponent(domain.stringify(vars.sourceOpt)); 
									url+="&renderOpt="+encodeURIComponent(domain.stringify(vars.renderOpt)); 
									LUI.$("#portlet_url").html(urlPrefix+url).attr("href",urlPrefix+url);
									
									LUI.$("#preview_portlet").attr("src","${LUI_ContextPath}"+url);
								} 
								function onRefresh(){ 
									var tempData = getConfigValues();
									for (var key in tempData.sourceOpt)   {
										if(typeof(tempData.sourceOpt[key]) == "object"){
											tempData.sourceOpt[key] = tempData.sourceOpt[key][key];
										}
									}
									for (var key in tempData.renderOpt)   {
										if(typeof(tempData.renderOpt[key]) == "object"){
											tempData.renderOpt[key] = tempData.renderOpt[key][key];
										}
									}
									if($.trim($(".portlet_input_render_opt").attr("renderId"))!=""){
										tempData.renderId = $.trim($(".portlet_input_render_opt").attr("renderId"));
									}
	/* 								if(tempData.renderId != xtable.find(".portlet_input_render_id").val()){
										xtable.find(".portlet_input_render_id").val(val.renderId);
										xtable.find(".portlet_input_render_name").val(val.renderName);
										var xopt = xtable.find(".portlet_input_render_opt").html(lodingImg).show();
										window[xopt.attr("jsname")] = null;
										xopt.load("${LUI_ContextPath}/sys/ui/jsp/vars/render.jsp?x="+(new Date().getTime()),{"fdId":val.renderId,"jsname":xopt.attr("jsname")});
										
									} */
									generateURL(tempData);
								}
								LUI.ready(function(){
									window.$ = LUI.$;
									ondocready(onRefresh);
								});
								
								function openPortletRenderDialog(ele){
									var xtable = LUI.$(ele).closest("#porlet");
									var formats = xtable.find(".portlet_input_source_formats").val();
									if(LUI.$.trim(formats)==""){
										seajs.use(['lui/dialog'],function(dialog){
											dialog.alert("${ lfn:message('sys-portal:sysPortalPage.desgin.selectsource') }");
										},{topWin:dialogWin});
										return;
									}
									seajs.use(['lui/dialog','lui/jquery'],function(dialog){
										dialog.iframe("/sys/portal/designer/jsp/selectportletrender.jsp?format="+encodeURIComponent(formats)+"&scene="+encodeURIComponent(scene), "${ lfn:message('sys-portal:sysPortalPage.desgin.selectrender') }", function(val){
											if(!val){
												return;
											}
											$(".portlet_input_render_opt").attr("renderId",val.renderId);
											if(val.renderId != xtable.find(".portlet_input_render_id").val()){
												xtable.find(".portlet_input_render_id").val(val.renderId);
												xtable.find(".portlet_input_render_name").val(val.renderName);
												var xopt = xtable.find(".portlet_input_render_opt").html(lodingImg).show();
												window[xopt.attr("jsname")] = null;
												xopt.load("${LUI_ContextPath}/sys/ui/jsp/vars/render.jsp?x="+(new Date().getTime()),{"fdId":val.renderId,"jsname":xopt.attr("jsname")});
												
											}
										}, {width:750,height:550,topWin:dialogWin});
									});
								}
								function chwidth(width){
									$('#width4').val(width);
									if(width!=null&&!isNaN(width)){
									$('#previewBox').width(width);
									onRefresh();
									}
								}
								function changeWidth(){
									var width = $('#width4').val();
										chwidth(width);
								}
								function chheight(height){
									$('#height4').val(height);
									if(height!=null&&!isNaN(height)){
										$('#preview_portlet').css("min-height",height+"px");
										onRefresh();
									}
								}
								function changeHeight(){
									var height=$('#height4').val();
									if(height!=null&&!isNaN(height)){
										$('#preview_portlet').css("min-height",height+"px");
										onRefresh();
									}
								}
								function overChange(){
									if(document.getElementById("overBox").checked){
										$("#previewBox").addClass("OverChecked");
									}else{
										$("#previewBox").removeClass("OverChecked");
									}
									onRefresh();
								}
								function openPortletRenderSetting(obj){
									var xtable = LUI.$(obj).closest("table");
									if(obj.checked)
										xtable.find(".portlet_render_setting").show();
									else
										xtable.find(".portlet_render_setting").hide();
								}
								</script>
								<button type="button" onclick="onRefresh()"><bean:message  bundle="sys-portal" key="sysPortalPortlet.Refresh"/></button>
							</td>
						</tr>						
					</table>
								
				</td> 
				
			</tr>
			<tr>
				<td class="td_normal_title" >
					<bean:message  bundle="sys-portal" key="sysPortalPortlet.External.access"/>URL
				</td>
				<td >
					<a id="portlet_url"  style="word-break: break-word;" href="" target="_blank">
					</a>
				</td>
			</tr>
		</table>
 	</template:replace>
</template:include>