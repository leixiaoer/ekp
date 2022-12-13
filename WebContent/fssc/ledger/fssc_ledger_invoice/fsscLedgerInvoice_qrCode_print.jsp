<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="java.util.Date"%>
<template:include ref="default.print" sidebar="no">
<template:replace name="toolbar">
	<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="8"> 
			<ui:button  id="zoomIn" text="${ lfn:message('fssc-ledger:button.qrCode.in') }"   onclick="ZoomFontSize(2);">
		    </ui:button>
		    <ui:button id="zoomOut" text="${ lfn:message('fssc-ledger:button.qrCode.out') }"   onclick="ZoomFontSize(-2);">
	 	   	</ui:button>
	 	   	<c:import url="/sys/common/exportButton.jsp" charEncoding="UTF-8">
				<c:param name="showHtml" value="false"></c:param>
			</c:import>
	  		 <ui:button text="${ lfn:message('button.print') }"   onclick="printorder();">
		    </ui:button>
		    <ui:button text="${ lfn:message('button.close') }"   onclick="window.close();">
		    </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<script language="JavaScript">
seajs.use(['theme!form']);
seajs.use(['lui/jquery'],function($) {
	$(document).ready(function() {
		$(".tempTB").css({width:"1120px"});
	})
});
</script>

<script>
Com_IncludeFile("jquery.js|dialog.js|doclist.js");
</script>
<script>

var flag = 0;
function ZoomFontSize(size) {
	//当字体缩小到一定程度时，缩小字体按钮变灰不可点击
	if(flag>=0||flag==-2){
		flag = flag+size;
	}
	if(flag<0){
		$("#zoomOut").prop("disabled",true);
		$("#zoomOut").addClass("status_disabled");
	}else{
		$("#zoomOut").prop("disabled",false);
		$("#zoomOut").removeClass("status_disabled");
	} 
	var root = document.getElementById("printTable");
	var i = 0;
	for (i = 0; i < root.childNodes.length; i++) {
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
</script>
<script language=javascript>  
function printorder() {  
	try {
        //PageSetup_temp();//取得默认值  
        //PageSetup_Null();//设置页面  
        //WebBrowser.execwb(6,6);//打印页面  
        window.print();
        //PageSetup_Default();//还原页面设置  
	} catch (e) {
		alert("<bean:message key="button.printPreview.error" bundle="fssc-ledger"/>");
	}
}
</script>
<style>
	.clear {
		clear:both;
	}
	.container {
		float:left;
		width:30%;
		margin:0 10px 35px 0;
		padding:10px 0 10px 10px;
		border:1px solid #ccc;
	}
	.container .left {
		float:left;
		width:35%;
	}
	.container .right {
		float:left;
		width:60%;
		line-height:24px;
		text-align:left;
		padding-left:10px;
	}
	 .container .right p {
	 	word-break:break-all;
		word-wrap: break-word;
	} 
</style>
<OBJECT ID='WebBrowser' NAME="WebBrowser" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2'></OBJECT>

<center>
	<div id="printTable" style="border: none;padding-left:30px;">
		<c:forEach var="form" items="${forms}" varStatus="status">
		<c:choose>
		<c:when test="${status.index %3 !=0}">
			<div class="container even">
				<div class="left">
					<center>
					<div>
						<div class="detailQrCode">
					
						</div>
					</div>
					</center>
					<script type="text/javascript">
					$(document).ready(function(){
						seajs.use(['lui/qrcode'], function(qrcode) {
							var ele = $(".detailQrCode")[${status.index }];
							var url = Com_GetCurDnsHost()+'/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=view&fdId=${form.fdId }'
							qrcode.Qrcode({
								text :url,
								element : ele,
								render :  'canvas',
								width:120,
								height:120
							});
						});
					});
					</script>
				</div>
				<div class="right">
					 
				</div>
				<div class="clear"></div>
			</div>
			</c:when>
			<c:otherwise>
			<div class="container" style="clear: left;">
				<div class="left">
					<center>
					<div>
						<div class="detailQrCode">
					
						</div>
					</div>
					</center>
					<script type="text/javascript">
					$(document).ready(function(){
						seajs.use(['lui/qrcode'], function(qrcode) {
							var ele = $(".detailQrCode")[${status.index }];
							var url = Com_GetCurDnsHost()+'/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=view&fdId=${form.fdId }'
							qrcode.Qrcode({
								text :url,
								element : ele,
								render :  'canvas',
								width:120,
								height:120
							});
						});
					});
					</script>
				</div>
				<div class="right">
					
				</div>
				<div class="clear"></div>
			</div>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		<div style="display:block;clear:both;"></div>
	</div>
</center>
</template:replace>
		
</template:include>

