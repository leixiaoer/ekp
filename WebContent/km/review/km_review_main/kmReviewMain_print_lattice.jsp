<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="java.util.Date"%>
<template:include ref="default.print" sidebar="no">
<template:replace name="head">
</template:replace>
<template:replace name="title">
	<c:out value="${kmReviewMainForm.docSubject }"></c:out>
</template:replace>
<template:replace name="toolbar">
	<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="9"> 
  		 <ui:button text="${ lfn:message('button.print') }"   onclick="printorder();">
	    </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<script language="JavaScript">
seajs.use(['theme!form']);
function outputPDF() {
	seajs.use(['lui/jquery','lui/export/export'],function($,exp) {
		$(".qrcodeArea").hide();
		$("#toolBarDiv").hide();
		exp.exportPdf($(".lui_form_content_td")[0],{callback:function() {
			$(".qrcodeArea").show();
			$("#toolBarDiv").show();
		}});
	});
}
</script>
<script>
Com_IncludeFile("jquery.js|dialog.js|doclist.js");
Com_IncludeFile("previewdesign.js",Com_Parameter.ContextPath+"sys/print/import/","js",true);
</script>
<script>
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

function ClearDomWidth(dom) {
	if (dom != null && dom.nodeType == 1 && dom.tagName != 'OBJECT' && dom.tagName != 'SCRIPT' && dom.tagName != 'STYLE' && dom.tagName != 'HTML') {
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

function expandXformTab(){
	var xformArea = $("#_xform_detail");
	if(xformArea.length>0){
		var tabs = $("#_xform_detail table.tb_label");
		if(tabs.length>0){
			for(var i=0; i<tabs.length; i++){
				var id = $(tabs[i]).prop("id");
				if(id==null || id=='') continue;
				$(tabs[i]).toggleClass("tb_normal");
				tabs[i].deleteRow(0);
				var tmpFun = function(idx,trObj){
					var trObj = $(trObj);
					//trObj.children("td").css({"padding":"0px","margin":"0px"});
					var tmpTitleTr = $("<tr class='tr_normal_title'>");
					var tempTd = $('<td align="left">');
					tempTd.html(trObj.attr("LKS_LabelName"));
					tempTd.appendTo(tmpTitleTr);
					trObj.before(tmpTitleTr);
				};
				var trArr = $("#"+id+" >tbody > tr[LKS_LabelName]");
				if(trArr.length<1){
					trArr = $("#"+id+" > tr[LKS_LabelName]");
				}
				trArr.each(tmpFun).show();
			}
		}
	}
}
function resetTableSize(){
	var tables = $(".sysDefineXform table[fd_type='standardTable']");
	for(var i = 0 ;i < tables.length;i++){
		var table = tables[i];
		//??????????????????
		$(table).css('width','100%');
		var tbWidth = $(table).width();
		//??????????????????
		for (var j = 0; j < table.rows.length; j++) {
			var cells = table.rows[j].cells;
			var cellsCount = cells.length;
			for(var k = 0;k < cellsCount;k++){
				var w = $(cells[k]).width();
				$(cells[k]).attr('cfg-width',w * 980/tbWidth);
			}
		}
		//????????????
		for (var j = 0; j < table.rows.length; j++) {
			var cells = table.rows[j].cells;
			var cellsCount = cells.length;
			for(var k = 0;k < cellsCount;k++){
				$(cells[k]).css('width',$(cells[k]).attr('cfg-width'));
			}
		}
	}
}
Com_AddEventListener(window, "load", function() {
	ClearDomWidth(document.getElementById("info_content"));
	expandXformTab();
	//??????????????????
	$('#_xform_detail a').css('text-decoration','none');
	$('a[id^=thirdCtripXformPlane_]').removeAttr('onclick');
	$('a[id^=thirdCtripXformHotel_]').removeAttr('onclick');
	resetTableSize();
	sysPreviewDesign.resetBoxWidth($('.sysDefineXform')[0]);
});

//?????????????????????????????????????????????window.previewImage??????
if(window.seajs){
	seajs.use(['lui/imageP/preview'], function(preview) {
		window.previewImage = preview;
	});
};
</script>
<SCRIPT language=javascript>  
var HKEY_Root,HKEY_Path,HKEY_Key;   
HKEY_Root="HKEY_CURRENT_USER";   
HKEY_Path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";   
var head,foot,top,bottom,left,right;  
  
//??????????????????????????????????????????  
function PageSetup_temp() {   
  var Wsh=new ActiveXObject("WScript.Shell");   
  HKEY_Key="header";   
//?????????????????????  
  head = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="footer";   
//?????????????????????
  foot = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="margin_bottom";   
//??????????????????  
  bottom = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="margin_left";   
//??????????????????  
  left = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="margin_right";   
//??????????????????  
  right = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
  HKEY_Key="margin_top";   
//??????????????????  
  top = Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key);   
	
}   

//?????????????????????????????????????????????  
function PageSetup_Null()   
{     
	if(window.ActiveXObject){
		 var Wsh=new ActiveXObject("WScript.Shell");   
		  HKEY_Key="header";   
		//????????????????????????  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"");   
		  HKEY_Key="footer";   
		//????????????????????????  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"");   
		  HKEY_Key="margin_bottom";   
		//?????????????????????0???  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
		  HKEY_Key="margin_left";   
		//?????????????????????0???  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
		  HKEY_Key="margin_right";   
		//?????????????????????0???  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0");   
		  HKEY_Key="margin_top";   
		//?????????????????????8???  
		  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,"0"); 
	}
}   
//?????????????????????????????????????????????????????????   
function  PageSetup_Default()   
{     
  var Wsh=new ActiveXObject("WScript.Shell");   
  HKEY_Key="header";   
  HKEY_Key="header";   
//????????????  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,head);   
  HKEY_Key="footer";   
//????????????  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,foot);   
  HKEY_Key="margin_bottom";   
//??????????????????  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,bottom);   
  HKEY_Key="margin_left";   
//??????????????????  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,left);   
  HKEY_Key="margin_right";   
//??????????????????  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,right);   
  HKEY_Key="margin_top";   
//??????????????????  
  Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key,top);    
}  
  
function printorder()  
{  
	try {
        //PageSetup_temp();//???????????????  
        PageSetup_Null();//????????????  
        //WebBrowser.execwb(6,6);//????????????  
        window.print();
        //PageSetup_Default();//??????????????????  
	} catch (e) {
		console.log(e)
		alert("<bean:message key="button.printPreview.error" bundle="km-review"/>");
	}
        //factory.execwb(6,6);  
       // window.close();  
}  
</script>
<style type="text/css">
	.tr_label_title{
		margin: 28px 0px 10px 0px;
		border-left: 3px solid #46b1fc
	}
	
	.tr_label_title .title{
		font-weight: 900;
		font-size: 16px;
		color: #000;
		text-align:left;
		margin-left: 8px;
	}
	.page_line {
		background-color: red;
		height: 1px;
		border: none;
		width: 100%;
		position: absolute;
		overflow: hidden;
	}
	a:hover{color:#333;text-decoration: none;}
	#printTable{width:980px;margin-bottom:20px;}
	
	/*--- ????????????????????????????????? ---*/
	.print_title_header{padding-top:20px; padding-bottom: 10px;border-bottom: 1px solid #dbdbdb;}
	.print_txttitle,.print_txttitle#title{ font-size: 18px; color:#333; padding:8px 0; text-align: center;}
	.printDate{ text-align: right; color:#808080;}
	td div.xform_inputText{display:inline-block !important;}
	td div.xform_Calculation{display:inline-block !important;word-break : break-all;word-wrap : break-word;}
@media print {
	#toolBarDiv{
		display: none !important;
	}
	.new_page {
		page-break-before : always;
	}
	.page_line {
		display: none;
	}
	
	#printTable .tb_noborder,
	#printTable table .tb_noborder,
	#printTable .tb_noborder td {
		border: none;
	}
	#printTable .tr_label_title {
		/*font-weight: 900;*/
	}
	#printTable{width:100%;margin-bottom:0px;}
	
	/*- ???????????? ?????? -*/
	.print_title_header{border-bottom: 1px solid #000}
	.print_txttitle,.print_txttitle#title{ font-size: 20px; font-weight: normal; color:#000;}
	.printDate{color:#000;}
}
</style>

<form name="kmReviewMainForm" method="post" action="<c:url value="/km/review/km_review_main/kmReviewMain.do"/>">
<center>

<div class="print_title_header" id="subjectDiv">
	<p class="lui_form_subject"><bean:write name="kmReviewMainForm" property="docSubject" /></p>
</div>

<%-- ???????????? --%>

<div id="infoDiv">
	<c:if test="${kmReviewMainForm.fdUseForm == 'false'}">
		<table id="info_content" class="tb_normal" width=100% >
			<tr>
				<td colspan="4">
					${kmReviewMainForm.docContent}
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-review" key="kmReviewMain.attachment" />
				</td>
				<td colspan=3>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdMulti" value="true" />
						<c:param name="formBeanName" value="kmReviewMainForm" />
						<c:param name="fdKey" value="fdAttachment" />
					</c:import>
				</td>
			</tr>
		</table>
	</c:if>
	<c:if test="${kmReviewMainForm.fdUseForm == 'true' || empty kmReviewMainForm.fdUseForm}">
		<table id="info_content" width=100% >
			<tr>
				<td id="_xform_detail">
					<%-- ?????? --%>
					<c:import url="/sys/xform/include/sysForm_view.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmReviewMainForm" />
						<c:param name="fdKey" value="reviewMainDoc" />
						<c:param name="messageKey" value="km-review:kmReviewDocumentLableName.reviewContent" />
						<c:param name="useTab" value="false" />
						<c:param name="isPrint" value="true" />
					</c:import>
				</td>
			</tr>
		</table>
	 </c:if>
</div>
</div></div>
<script>
$(document).ready(function() {
	$(".tempTB").css({
		'width':'90%',
		'min-width':980,
		'max-width':1200,
		'margin': '0px auto'
	});
});
</script>
</center>
</form>
</template:replace>
		
</template:include>

