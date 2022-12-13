<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="p_defconfig" value="${p_defconfig}" scope="request"/>
<%
String base = (String)request.getAttribute("base");
String info = (String)request.getAttribute("info");
String note = (String)request.getAttribute("note");
String p_config=request.getParameter("p_config");
java.util.ArrayList showConfig = new java.util.ArrayList(3);
if (p_config == null || p_config.length() == 0 ) {
	if(!"0".equals(base))
		showConfig.add("base");
	if(!"0".equals(info))
		showConfig.add("info");
	if(!"0".equals(note))
		showConfig.add("note");
	
} else {
	String[] configs = p_config.split(";");
	for (int i = 0; i < configs.length; i ++) {
		String cfg = configs[i];
		if (cfg != null && cfg.length() != 0 ) {
			showConfig.add(cfg);
		}
	}
}
String defValue = "";
for (int i = 0; i < showConfig.size(); i ++) {
	defValue += ",'" + showConfig.get(i) + "'";
}
defValue = defValue.substring(1);
%>
<template:include ref="default.view" showQrcode="false" width="90%" sidebar="no">
	<template:replace name="head">
	<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/resource/css/carmng.css?s_cache=${MUI_Cache}" />
		<script type="text/javascript">
		Com_IncludeFile("dialog.js|doclist.js");
		var defValue = [<%=defValue%>];
		var defOptions = [{id:'base', name:'<bean:message bundle="km-carmng" key="kmCarmng.config.base" />'}, //用车申请
		                  {id:'info', name:'<bean:message bundle="km-carmng" key="kmCarmng.config.info" />'}, //调度信息
		                  {id:'note', name:'<bean:message bundle="km-carmng" key="kmCarmng.config.note" />'}];//流程处理
		function ShowPrintList() {
			var optionData = new KMSSData();
			optionData.AddHashMapArray(defOptions);
			var valueData = new KMSSData();
			for (var i = 0; i < defValue.length; i ++) {
				var defV = defValue[i];
				for (var j = 0; j < defOptions.length; j ++) {
					var opt = defOptions[j];
					if (opt.id == defV) {
						valueData.AddHashMap(opt);
					}
				}
			}
			
			var dialog = new KMSSDialog(true, true);
			dialog.AddDefaultOption(optionData);
			dialog.AddDefaultValue(valueData);
			dialog.SetAfterShow(function(rtn) {
				if (rtn == null || rtn.IsEmpty()) {
					return ;
				}
				var value = '';
				var values = rtn.GetHashMapArray();
				
				for (var i = 0; i < values.length; i ++) {
					value += ';' + values[i].id;
				}
				var url = Com_SetUrlParameter(window.location.href, 'p_config', value);
				setTimeout(function(){window.location.href = url;},500);
			});
			dialog.Show();
		}
		var toPageBreak = false;
		function ShowToPageBreak(event) {
			event.cancelBubble = true;
			toPageBreak = true;
			document.body.style.cursor = 'pointer';
		}
		function AbsPosition(node, stopNode) {
			var x = y = 0;
			for (var pNode = node; pNode != null && pNode !== stopNode; pNode = pNode.offsetParent) {
				x += pNode.offsetLeft - pNode.scrollLeft; y += pNode.offsetTop - pNode.scrollTop;
			}
			x = x + document.body.scrollLeft;
			y = y + document.body.scrollTop;
			return {'x':x, 'y':y};
		};
		function MousePosition(event) {
			if(event.pageX || event.pageY) return {x:event.pageX, y:event.pageY};
			return {
				x:event.clientX + document.body.scrollLeft - document.body.clientLeft,
				y:event.clientY + document.body.scrollTop  - document.body.clientTop
			};
		};
		function SetPageBreakLine(tr) {
			var pos = AbsPosition(tr);
			var line = document.createElement('div');
			line.className = 'page_line';
			line.style.top = pos.y + 'px';
			line.style.left = '0px';
			line.id = 'line_' + tr.uniqueID;
			document.body.appendChild(line);
		}
		function RemovePageBreakLine(tr) {
			var line = document.getElementById('line_' + tr.uniqueID);
			if (line != null)
				document.body.removeChild(line);
			line = null;
		}
		Com_AddEventListener(document, "click", function(event) {
			if (toPageBreak) {
				event = event || window.event;
				toPageBreak = false;
				document.body.style.cursor = 'default';
				var target = event.target || event.srcElement;
				while(target) {
					if (target.tagName != null && (target.tagName == 'TR' ||target.tagName=="DIV")) {
						if (target.printTr == 'true') {
							var pos = MousePosition(event);
							var tables = target.getElementsByTagName('table');
							var mtable = null, msize = 0, m = 0;
							for (var n = 0; n < tables.length; n ++) {
								var tb = tables[n];
								var tbp = AbsPosition(tb);
								if (mtable == null) {
									mtable = tb;
									msize = Math.abs(pos.y - tbp.y);
									continue;
								}
								m = Math.abs(pos.y - tbp.y);
								if (m < msize) {
									msize = m;
									mtable = tb;
								}
							}
							if (mtable == null)
								break;
							target = mtable.rows[0];
						}
						if (target.tagName=='TR' && target.rowIndex == 0) {
							target = target.parentNode.parentNode;
						}
						if (target.className.indexOf('new_page') > -1) {
							RemovePageBreakLine(target);
							target.className = target.className.replace(/new_page/g, '');
						} else if(target.className.indexOf("page_line")==-1) {
							SetPageBreakLine(target);
							target.className = 'new_page ' + target.className;
						}
						break;
					} else {
						target = target.parentNode;
					}
				}
			}
		});
		function ZoomFontSize(size) {
			var root = document.getElementById('printTable'), i = 0;
			for (i = 0; i < root.childNodes.length; i ++) {
				SetZoomFontSize(root.childNodes[i], size);
			}
			var tag_fontsize;
			if(root.currentStyle){
			    tag_fontsize = root.currentStyle.fontSize;  
			}  
			else{  
			    tag_fontsize = getComputedStyle(root, null).fontSize;  
			} 
			root.style.fontSize = parseInt(tag_fontsize) + size + 'px';
		}
		function SetZoomFontSize(dom, size) {
			if (dom.nodeType == 1 && dom.tagName != 'OBJECT' && dom.tagName != 'SCRIPT' && dom.tagName != 'STYLE' && dom.tagName != 'HTML') {
				for (var i = 0; i < dom.childNodes.length; i ++) {
					SetZoomFontSize(dom.childNodes[i], size);
				}
				var tag_fontsize;
				if(dom.currentStyle){  
				    tag_fontsize = dom.currentStyle.fontSize;  
				}  
				else{  
				    tag_fontsize = getComputedStyle(dom, null).fontSize;  
				} 
				dom.style.fontSize = parseInt(tag_fontsize) + size + 'px';
			}
		}
		function ClearDomWidth(dom) {
			if (dom != null && dom.nodeType == 1 && dom.tagName != 'OBJECT' && dom.tagName != 'SCRIPT' && dom.tagName != 'STYLE' && dom.tagName != 'HTML') {
					/****
					var w = dom.getAttribute("width");
					if (w != '100%')
						dom.removeAttribute("width");
					w = dom.style.width;
					if (w != '100%')
						dom.style.removeAttribute("width");
					***/
					if (dom.style.whiteSpace == 'nowrap') {
						dom.style.whiteSpace = 'normal';
					}
					if (dom.style.display == 'inline') {
						dom.style.wordBreak  = 'break-all';
						dom.style.wordWrap  = 'break-word';
					}
				ClearDomsWidth(dom);
			}
		}
		function ClearDomsWidth(root) {
			for (var i = 0; i < root.childNodes.length; i ++) {
				ClearDomWidth(root.childNodes[i]);
			}
		}
		function printView() {
			try {
				//PageSetup_temp();
				//PageSetup_Null();
				document.getElementById('WebBrowser').ExecWB(7,1);
			   //PageSetup_Default();
			} catch (e) {
				alert('<bean:message bundle="km-carmng" key="button.printPreview.error" />');
			}
		}
		Com_AddEventListener(window, "load", function() {
			ClearDomWidth(document.getElementById("info_content"));
		});
		</script>
		<SCRIPT language=javascript>  
		var HKEY_Root,HKEY_Path,HKEY_Key;   
		HKEY_Root="HKEY_CURRENT_USER";   
		HKEY_Path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";   
		var head,foot,top,bottom,left,right;  
		  
		//取得页面打印设置的原参数数据  
		function PageSetup_temp() {    
		  var Wsh=new ActiveXObject("WScript.Shell");   
		  HKEY_Key="header";   
		//取得页眉默认值  
		  head = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
		  HKEY_Key="footer";   
		//取得页脚默认值  
		  foot = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
		  HKEY_Key="margin_bottom";   
		//取得下页边距  
		  bottom = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
		  HKEY_Key="margin_left";   
		//取得左页边距  
		  left = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
		  HKEY_Key="margin_right";   
		//取得右页边距  
		  right = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
		  HKEY_Key="margin_top";   
		//取得上页边距  
		  top = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
		  
		}  
		  
		//设置网页打印的页眉页脚和页边距  
		function PageSetup_Null()   
		{     
		  var Wsh=new ActiveXObject("WScript.Shell");   
		  HKEY_Key="header";   
		//设置页眉（为空）  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"");   
		  HKEY_Key="footer";   
		//设置页脚（为空）  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"");   
		  HKEY_Key="margin_bottom";   
		//设置下页边距（0）  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
		  HKEY_Key="margin_left";   
		//设置左页边距（0）  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
		  HKEY_Key="margin_right";   
		//设置右页边距（0）  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
		  HKEY_Key="margin_top";   
		//设置上页边距（8）  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
		
		}   
		//设置网页打印的页眉页脚和页边距为默认值   
		function  PageSetup_Default()   
		{     
		
		  var Wsh=new ActiveXObject("WScript.Shell");   
		  HKEY_Key="header";   
		  HKEY_Key="header";   
		//还原页眉  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,head);   
		  HKEY_Key="footer";   
		//还原页脚  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,foot);   
		  HKEY_Key="margin_bottom";   
		//还原下页边距  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,bottom);   
		  HKEY_Key="margin_left";   
		//还原左页边距  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,left);   
		  HKEY_Key="margin_right";   
		//还原右页边距  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,right);   
		  HKEY_Key="margin_top";   
		//还原上页边距  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,top);    
		}  
		  
		function printorder()  
		{  
			try {
		       /*  PageSetup_temp();//取得默认值  
		        PageSetup_Null();//设置页面  
		        WebBrowser.execwb(6,6);//打印页面  
		        PageSetup_Default();//还原页面设置   */
		        $("#optBarDiv").hide();
		        $(".lui_toolbar_popup_float").hide();
		        window.print();
		        $("#optBarDiv").show();
			} catch (e) {
				alert('<bean:message bundle="km-carmng" key="button.printPreview.error" />');
			}
		        //factory.execwb(6,6);  
		       // window.close();  
		}  
		</script>
		<style type="text/css">
			#title {
				font-size: 22px;
				color: #000;
			}
			.tr_label_title td {
				font-weight: 900;
				font-size: 16px;
				color: #000;
			}
			.page_line {
				background-color: red;
				height: 1px;
				border: none;
				width: 100%;
				position: absolute;
				overflow: hidden;
			}
			/*
			.td_normal,
			.tb_normal,
			.tb_normal td,
			.tr_normal_title,
			.td_normal_title {
				border: 1px #000 solid;
				color: #000;
			}
			*/
			
		@media print {
			#optBarDiv, #S_OperationBar {
				display: none;
			}
			.new_page {
				page-break-before : always;
			}
			.page_line {
				display: none;
			}
			body {
				font-size: 12px;
			}
			
			#printTable table, #printTable td {
				border: 1px #000 solid;
				color: #000;
				/*font-weight: 600;*/
			}
			#printTable .tb_noborder,
			#printTable table .tb_noborder,
			#printTable .tb_noborder td {
				border: none;
			}
			#printTable .tr_label_title {
				/*font-weight: 900;*/
			}
		}
		</style>
	</template:replace>
	<template:replace name="toolbar">
		<!-- <OBJECT ID='WebBrowser' NAME="WebBrowser" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2'></OBJECT> -->
		<ui:toolbar id="optBarDiv" layout="sys.ui.toolbar.float" count="3">
			<!-- 放大文字 -->
			<ui:button text="${lfn:message('km-carmng:button.zoom.in')}" 
				onclick="ZoomFontSize(5);">
			</ui:button>
			<!-- 缩小文字 -->
			<ui:button text="${lfn:message('km-carmng:button.zoom.out')}" 
				onclick="ZoomFontSize(-5);">
			</ui:button>			
			<!-- 分页 -->
			<ui:button text="${lfn:message('km-carmng:button.pageBreak')}" title="${lfn:message('km-carmng:button.pageBreak.title')}" 
				onclick="ShowToPageBreak(event);">
			</ui:button>
			<!-- 打印 -->
			<ui:button text="${lfn:message('km-carmng:button.print')}" 
				onclick="printorder();">
			</ui:button>
			<!-- 打印预览 -->
			<%-- <ui:button text="${lfn:message('km-carmng:button.printPreview')}" 
				onclick="printView();">
			</ui:button> --%>
			<!-- 打印设置 -->
			<ui:button text="${lfn:message('km-carmng:button.printConfig')}" 
				onclick="ShowPrintList();">
			</ui:button>
			<c:import url="/sys/common/exportButton.jsp" charEncoding="UTF-8">
				<c:param name="showHtml" value="false"></c:param>
			</c:import>
			<!-- 关闭 -->
			<ui:button text="${lfn:message('button.close')}" 
				onclick="window.close();">
			</ui:button>			
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<center>
		<div id="printTable" class="tb_normal" style="border: none;font-size: 12px; width: 95%">
		<p id="title" class="txttitle"><bean:message bundle="km-carmng" key="table.kmCarmngApplication"/></p>
		<div printTr="true" style="border: none;">
		
		<%-- 用车申请  --%>
		<% 
		for (int i = 0; i < showConfig.size(); i ++) {
			String cfg = (String) showConfig.get(i);
			if ("base".equals(cfg)) { 
		%>
		<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.fdMotorcadeId" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.fdMotorcadeName}" />
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.docSubject" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.docSubject}" /></td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson" />
						</td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.fdApplicationPersonName}" /></td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng"
							key="kmCarmngApplication.fdApplicationPersonPhone" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.fdApplicationPersonPhone}" /></td>
					</tr>
			
					<tr>
	                    <td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.fdApplicationDept" />
						</td>
						<td width=35%>
							<c:out value="${kmCarmngApplicationForm.fdApplicationDeptName}" />
						</td>
						<%--申请单编号--%>
						<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngApplication.fdNo" /></td>
						<td width="35%">
							<c:out value="${kmCarmngApplicationForm.fdNo}"></c:out>
						</td>
					</tr>
					<tr>
					    <td class="td_normal_title" width="15%">
					    	<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationPath" />
					    </td>
					    <td colspan="3">
								<div class="lui_carnming_rotue_tb">
								<c:set var="hasSysAttend" value="false"></c:set>
								<kmss:ifModuleExist path="/sys/attend">
									<c:set var="hasSysAttend" value="true"></c:set>
								</kmss:ifModuleExist>
								<!-- 行驶路线  -->
								<c:choose>
								 	<c:when test="${not empty kmCarmngApplicationForm.fdDeparture and not empty kmCarmngApplicationForm.fdDestination}">
								 		<table style="width:100%">
										<tr>
											<td class="td_title" width = "15%">
												<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDeparture" />
											</td>
											<td>
												<c:if test="${hasSysAttend == true }">
													<c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
														<c:param name="propertyName" value="fdDeparture"></c:param>
														<c:param name="propertyCoordinate" value="fdDepartureCoordinate"></c:param>
														<c:param name="propertyDetail" value="fdDepartureDetail"></c:param>
													</c:import>
												</c:if>
												<c:if test="${hasSysAttend == false }">
													<xform:text property="fdDeparture" />
												</c:if>
											</td>
										</tr>
										<tr>
											<td class="td_title" width = "15%">
												<bean:message bundle="km-carmng" key="kmCarmngApplication.fdDestination" />
											</td>
											<td>	
												<c:if test="${hasSysAttend == true }">
													<c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
														<c:param name="propertyName" value="fdDestination"></c:param>
														<c:param name="propertyCoordinate" value="fdDestinationCoordinate"></c:param>
														<c:param name="propertyDetail" value="fdDestinationDetail"></c:param>
													</c:import>
												</c:if>
												<c:if test="${hasSysAttend == false }">
													<xform:text property="fdDestination" />
												</c:if>
											</td>
										</tr>
										<c:forEach items="${kmCarmngApplicationForm.fdPathForms}"  var="kmCarmngPathForm" varStatus="vstatus">
										<tr>
										 <td></td>
										 <td>
										 	<c:if test="${hasSysAttend == true }">
										 		<c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
													<c:param name="propertyName" value="fdPathForms[${vstatus.index}].fdDestination"></c:param>
													<c:param name="propertyCoordinate" value="fdPathForms[${vstatus.index}].fdDestinationCoordinate"></c:param>
													<c:param name="propertyDetail" value="fdPathForms[${vstatus.index}].fdDestinationDetail"></c:param>
												</c:import>
											</c:if>
											<c:if test="${hasSysAttend == false }">
												<xform:text property="fdPathForms[${vstatus.index}].fdDestination" />
											</c:if>
										 </td>
										</tr>
										</c:forEach>
									</table>
								 	</c:when>
								 	<c:otherwise>
								 		<xform:text property="fdApplicationPath"  style="width:99%"/>
								 	</c:otherwise>
								</c:choose>
							</div>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseStartTime" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.fdStartTime}" /></td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngUserFeeInfo.fdUseEndTime" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.fdEndTime}" /></td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" />
						</td>
						<td width="85%"  colspan="3" style="word-break:break-all">
							<!-- 用车人 -->
							<c:if test="${ not empty kmCarmngApplicationForm.fdUserPersonNames }">
								<div style="padding-bottom: 8px">
									<img src="${LUI_ContextPath}/km/carmng/resource/images/inner_person.png" />
									<span style="vertical-align: top;">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdInnerPerson"/><c:out value="${kmCarmngApplicationForm.fdUserPersonNames }"></c:out>
									</span>
								</div>
							</c:if>
							<%-- 外部用车人  --%>
							<c:if test="${ not empty kmCarmngApplicationForm.fdOtherUsers }">
								<div>
									<img src="${LUI_ContextPath}/km/carmng/resource/images/other_person.png" />
									<span style="vertical-align: top;">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdOtherPerson"/><c:out value="${kmCarmngApplicationForm.fdOtherUsers }"></c:out>
									</span>
								</div>
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.fdUserNumber" /></td>
						<td width=35% colspan="3"><c:out
							value="${kmCarmngApplicationForm.fdUserNumber}" /></td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.fdApplicationReason" />
						</td>
						<td width=35% colspan="3"><kmss:showText
							value="${kmCarmngApplicationForm.fdApplicationReason}" /></td>
					</tr>
			
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.docCreatorId" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.docCreatorName}" /></td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.docCreateTime" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.docCreateTime}" /></td>
					</tr>
				</table>
		<%-- 调度信息 --%>
		<% } else if ("info".equals(cfg)) { %>
		<table class="tb_simple" width=100%>
					<tr>
					<td colspan="4">
						<div class="lui_carmng_dispatch_wrap checkIn_wrap">
							 <div class="lui_carmng_dispatch_content" id="carlistTB">
								<c:forEach items="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm}"  var="dispatchersInfoListForm" varStatus="vstatus">
									<div class="lui_carmng_dispatch_carCard" id="${dispatchersInfoListForm.fdCarInfoId}"> 
										<p class="car_plate"><xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoNo" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoNo}" /> </p>
										<ul>
											<li>
											<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoName" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoName}" /> 
											（<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdCarInfoSeatNumber" showStatus="view" value="${dispatchersInfoListForm.fdCarInfoSeatNumber}" /> 座）</li>
											<li>
												<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdMotorcadeName" showStatus="view" value="${dispatchersInfoListForm.fdMotorcadeName}" /> 
											</li>
											<li>
												<p class="driver">
													<xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdDriverName" value="${dispatchersInfoListForm.fdDriverName}" /> 
												</p>
												<p class="phone"><xform:text property="fdDispatchersInfoListForm[${vstatus.index}].fdRelationPhone" value="${dispatchersInfoListForm.fdRelationPhone}" />
												</p>
											</li>
										</ul>
										<kmss:auth requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}" requestMethod="GET">
										<c:if test="${dispatchersInfoListForm.fdFlag != '1'}">
											<a href="javascript:void(0)" class="btn_checkIn" onclick="Com_OpenWindow('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=add&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}','_self');">${lfn:message('km-carmng:kmCarmng.button5')}</a>
										</c:if>
										 </kmss:auth>
										 <kmss:auth requestURL="/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=viewRegister&fdDispatchInfoListId=${dispatchersInfoListForm.fdId}&fdAppId=${kmCarmngApplicationForm.fdId}" requestMethod="GET">
										<c:if test="${dispatchersInfoListForm.fdFlag == '1'}">
											<a href="javascript:void(0)" class="btn_checkIned" onclick="Com_OpenWindow('${LUI_ContextPath}/km/carmng/km_carmng_register_info/kmCarmngRegisterInfo.do?method=view&fdId=${dispatchersInfoListForm.fdRegisterId}','_blank');">回车信息</a>
										</c:if>
										</kmss:auth>
									</div>
								</c:forEach>
								
								<c:if test="${fn:length(kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm)  < 3 && fn:length(kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm) > 0}">
								 <div class="lui_carmng_dispatch_info">
									<ul>
										<li>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime"/> : <c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdStartTime}" /> 
										</li>
										<li>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime"/> : <c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdEndTime}" /> 
										</li>
										<li>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId"/> : <c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRegisterName}" />
										</li>
										<li>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator"/> : <c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreatorName}" />
										</li>
										<li>
										<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime"/> : <c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreateTime}" />
										</li>
									</ul>
								 </div>
							 	</c:if>
							 </div>
						  </div>
						  </td>
					</tr>
					</table>
					<c:if test="${fn:length(kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDispatchersInfoListForm) > 2}">
					<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime" /></td>
						<td width=35%>
							<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdStartTime}" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime" /></td>
						<td width=35%>
							<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdEndTime}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId" />
						</td>
						<td width=85% colspan="3">
							<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRegisterName}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator" /></td>
						<td width=35%>
							<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreatorName}" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime" />
						</td>
						<td width=35%>
							<c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreateTime}" />
						</td>
					</tr>
				</table>
				</c:if>
		
		<%-- 流程处理 --%>
		<% } else if ("note".equals(cfg)) { %>
		<table class="tb_normal" width=100% style="margin-top: 20px;">
			<tr class="tr_normal_title tr_label_title">
				<td colspan="4">
					<bean:message bundle="km-carmng" key="kmCarmng.config.note" />
				</td>
			</tr>
			<tr>
				<td colspan=4>
					<c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmCarmngApplicationForm" />
					</c:import>
				</td>
			</tr>
		</table>
		
		<%
		} // end if
		} // end for
		%>
		</div></div>
		</center>
		<script>
		function outputMHT() {
			seajs.use(['lui/export/export'],function(exp) {
				exp.exportMht({
					title:'${kmCarmngApplicationForm.docSubject}'
				});
			});
		}
		function outputPDF() {
			seajs.use(['lui/jquery','lui/export/export'],function($,exp) {
				exp.exportPdf(document.getElementById('printTable'),{
					title:'${kmCarmngApplicationForm.docSubject}'
				});
			});
		}
		</script>
	</template:replace>
</template:include>
