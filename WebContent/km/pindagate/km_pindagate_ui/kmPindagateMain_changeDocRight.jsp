<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ page import="java.util.Set" %>
<%@ page import="com.landray.kmss.sys.config.dict.SysDataDict" %>
<%
	String modelName = request.getParameter("modelName");
	Set mSet =  SysDataDict.getInstance().getModel(modelName).getPropertyMap().keySet();
	String[] ms = new String[]{"authReaders","authEditors","authAttCopys","authAttDownloads","authAttPrints"};
	int cm=0;
	for(int i=0;i<ms.length;i++){
		if(mSet.contains(ms[i])){
			cm++;
		}
	}
	String paraAttributeList=request.getParameter("attributeList");
	if(StringUtil.isNotNull(paraAttributeList))
	{
		String arr[]=paraAttributeList.split(",");
		if(arr!=null && arr.length>0)
		{
			cm=cm+arr.length;
		}
	}
%>
	
<script type="text/javascript">
	Com_IncludeFile("dialog.js|jquery.js|data.js");
</script>

<script>
var kvd = ["authReader","authEditor","authAttCopy","authAttDownload","authAttPrint"];
var tsd =["<bean:message  bundle='sys-right' key='right.change.authReaderIds'/>",
		"<bean:message  bundle='sys-right' key='right.change.authEditorIds'/>",
		"<bean:message  bundle='sys-right' key='right.change.authAttCopyIds'/>",
		"<bean:message  bundle='sys-right' key='right.change.authAttDownloadIds'/>",
		"<bean:message  bundle='sys-right' key='right.change.authAttPrintIds'/>"
		];

function validateDocAuthForm(of){
	if(!validateEmpty()){
		return false;
	}
	return true;
}

function validateEmpty(){
	var oprType = document.getElementsByName("oprType");
	var oprValue = getOprValue();
	if(oprValue=="1"){
		if(!checkProperty("<bean:message  bundle='sys-right' key='right.change.doc'/>",kvd,tsd)){
			return false;
		}
		else if(!checkProperty("<bean:message  bundle='sys-right' key='right.change.doc'/>",att,attL))
		{
			return false;
		}
	}
	return true;
}

function getOprValue(){
	var oprType = document.getElementsByName("oprType");
	var oprValue = "";
	for(var i=0;i<oprType.length;i++){
		if(oprType[i].checked){
			oprValue = oprType[i].value;
		}
	}
	return oprValue;
}

function checkProperty(zt,pn,pt){
	for(var i=0;i<pn.length;i++){
		var ids = document.getElementsByName(pn[i]+"Ids")[0];
		var chk = document.getElementsByName(pn[i]+"Check")[0];
		if(ids && chk.checked){
			if(ids.value==""){
				var re = /\{0\}/gi;
				var msg ="<bean:message key="errors.required"/>";
				msg = msg.replace(re, pt[i]);
				alert(zt+" "+msg);
				return false;
			}
		}
	}
	return true;
}

function showElementInput(el){
	document.getElementById(el.name+"Input").style.display=el.checked?"":"none";
	var oprValue = getOprValue();
	if(document.getElementById(el.name+"NotFlag")){
		document.getElementById(el.name+"NotFlag").style.display=(oprValue=="1")?"none":"";
	}
	if(document.getElementById(el.name+"Empty")){
		document.getElementById(el.name+"Empty").style.display=(oprValue=="1")?"none":"";
	}
}

function swapNotFlag(el){
	document.getElementById(el.name+"Input").style.display=el.checked?"none":"";
}

var _tmp =["authAttDownloadCheck","authAttPrintCheck","authAttCopyCheck"];
var _tmpFlag =["authAttNodownload","authAttNoprint","authAttNocopy"];
function oprOnclickFunc(el){
	for(var i=0;i<_tmp.length;i++){
		if(!document.getElementById(_tmp[i])){
			continue;
		}
		if(document.getElementById(_tmp[i]+"Input").style.display=="none"){
			continue;
		}
		if(el.value=="1"){
			document.getElementById(_tmp[i]+"NotFlag").style.display="none";
			document.getElementById(_tmp[i]+"Empty").style.display="none";
			document.getElementById(_tmpFlag[i]).checked=false;
			document.getElementById(_tmpFlag[i]+"Input").style.display="";
		}else{
			document.getElementById(_tmp[i]+"NotFlag").style.display="";
			document.getElementById(_tmp[i]+"Empty").style.display="";
			if(document.getElementById(_tmpFlag[i]).checked){
				document.getElementById(_tmpFlag[i]+"Input").style.display="none";
			}else{
				document.getElementById(_tmpFlag[i]+"Input").style.display="";
			}
		}

	}
	if(el.value=="1"){
		if(document.getElementById("authReaderNoteFlagEmpty")){
			document.getElementById("authReaderNoteFlagEmpty").style.display="none";
		}
	}else{
		if(document.getElementById("authReaderNoteFlagEmpty")){
			document.getElementById("authReaderNoteFlagEmpty").style.display="";
		}
	}
}

	//属性名[]，属性标签名[]，url后接续的keyValue值
	var att,attL,urlV;

	$(function(){
		var attributeList='${JsParam.attributeList}';
		var attributeLabelList='${JsParam.attributelabelList}';
		var warnMessage="",trMessage="";
		att=attributeList.split(",");
		attL=attributeLabelList.split(",");
		for(var i=0;i<att.length;i++)
		{
			attL[i]=Data_GetResourceString(attL[i]);
			if(att[i].indexOf("Participant")!=-1)
			{
				warnMessage=Data_GetResourceString("km-pindagate:kmPindagate.msg.warnParticipantMessage");
				trMessage="<div class='com_help'>"+warnMessage+"</div>";
			}
			else if(att[i].indexOf("ResultNotifier")!=-1)
			{
				warnMessage=Data_GetResourceString("km-pindagate:kmPindagate.msg.warnResultNotifierMessage");
				trMessage="<div class='com_help'>"+warnMessage+"</div>";
			}
			
			var tr="<tr id='"+att[i]+"Zone'><td width=90%>"
				+"<input type='checkbox' name='"+att[i]+"Check' value='true' onclick='showElementInput(this)'/>"
				+attL[i]+"<br>"
				+"<input type='hidden' id='"+att[i]+"Ids'  name='"+att[i]+"Ids'/>"
				+"<div id='"+att[i]+"CheckInput' style='display:none'>"
					+"<div class='inputselectmul' style='width:90%;' onclick=\"Dialog_Address(true, '"+att[i]+"Ids','"+att[i]+"Names', ';',null);\">"
						+ "<input type='hidden'  name='"+att[i]+"Ids'/>"
						+ "<div class='textarea'><textarea name='"+att[i]+"Names' readonly></textarea></div>"
						+ "<div class='orgelement'></div>"
					+"</div>"
				+trMessage
				+"</div>"
				+"</td></tr>"; 
				
			$(tr).appendTo($("#tableBody"));
			trMessage="";
		}
		
		});
	
	
	//ajax 提交到网上调查模块
	Com_Parameter.event["submit"][Com_Parameter.event["submit"].length] = function(){
			getData();
			$.ajax({
				url:Com_Parameter.ContextPath+"km/pindagate/km_pindagate_main/kmPindagateMain.do?method=changeDocPersonRight",
				type:"POST",
				data:urlV,
				async:false,
				success:ajaxSuccess,
				error:ajaxError
				});
			return true;
		};

		function getData()
		{
			urlV="fdIds="+$("input[name='fdIds']").val()+"&oprType="+getOprValue();
			var strCheck="";
			for(var i=0;i<att.length;i++)
			{
				var check=document.getElementsByName(att[i]+'Check')[0].checked;
				if(check==true)
				{
					var ids=$('#'+att[i]+'Ids').val();
					var names=$('#'+att[i]+'Names').val();
					urlV=urlV+"&"+att[i]+"Ids="+ids+"&"+att[i]+"Names="+names;
					strCheck=strCheck+att[i]+",";
				}
			}
			urlV=urlV+"&checks="+strCheck;
		}

		function ajaxSuccess()
		{
			return true;
		}

		function ajaxError(event,xhr,options,exc)
		{
			alert('error:'+exc);
			return false;
		}
</script>

<p class="txttitle"><bean:message bundle="sys-right" key="right.change.title.doc"/><bean:message key="button.edit"/></p>

<html:form action="/sys/right/rightDocChange.do" method="post" onsubmit="return validateDocAuthForm(this);">
<div id="optBarDiv">
	<input type=button value="<bean:message key="button.save"/>" onclick="Com_Submit(document.docAuthForm,'docRightUpdate','fdIds');">
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
<center>
<table class="tb_normal" width=95% id="tableBody">
	<tr>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="sys-right" key="right.change.opr"/>
		</td>
		<td width=90%>
			<sunbor:enums property="oprType" enumsType="sys_right_add_or_reset" elementType="radio" htmlElementProperties="onclick='oprOnclickFunc(this);'"/>
		</td>
	</tr>	
	<tr>
		<td class="td_normal_title" colspan="2">
			<bean:message  bundle="sys-right" key="right.change.updateOption"/>
		</td>
	</tr>
<% if(mSet.contains("authReaders")){ %>
	<tr id="authReaderZone">
		<td class="td_normal_title" rowspan="<%=cm %>>" width=10%>
			<bean:message  bundle="sys-right" key="right.change.doc"/>
		</td>
		<td width=90%>
			<input type="checkbox" name="authReaderCheck" value="true" onclick="showElementInput(this)">&nbsp;<bean:message  bundle="sys-right" key="right.change.authReaderIds"/><br>
			<%-- <html:hidden property="authReaderIds" /> --%>
			<div id="authReaderCheckInput" style="display:none">
				<%-- <html:text property="authReaderNames" readonly="true" styleClass="inputmul" style="width:90%" />
				<a href="#" onclick="Dialog_Address(true, 'authReaderIds','authReaderNames', ';',null);">
					<bean:message key="dialog.selectOrg"/>
				</a> --%>
				<xform:address propertyId="authReaderIds"  propertyName="authReaderNames" mulSelect="true" textarea="true"
					style="width:90%;" showStatus="edit"></xform:address>

				<html:hidden property="authReaderNoteFlag" value="${HtmlParam.authReaderNoteFlag}"/>
				<c:if test="${empty param.authReaderNoteFlag or param.authReaderNoteFlag=='1'}">
					<div id="authReaderNoteFlagEmpty" style="display:none">
						<bean:message bundle="sys-right" key="right.read.authReaders.note" />
					</div>
				</c:if>
				<c:if test="${param.authReaderNoteFlag=='2'}">
					<div id="authReaderNoteFlagEmpty" style="display:none">
						<bean:message bundle="sys-right" key="right.read.authReaders.note1" />
					</div>
				</c:if>
			<div>
		</td>
	</tr>
	<%}%>
	<% if(mSet.contains("authEditors")){ %>
	<tr id="authEditorZone">
		<td width=90%>
			<input type="checkbox" name="authEditorCheck" value="true" onclick="showElementInput(this)">
			<bean:message  bundle="sys-right" key="right.change.authEditorIds"/><br>
			<%-- <html:hidden property="authEditorIds" /> --%>
			<div id="authEditorCheckInput" style="display:none">
			<%-- <html:text property="authEditorNames" readonly="true" styleClass="inputmul" style="width:90%" />
			<a href="#" onclick="Dialog_Address(true, 'authEditorIds','authEditorNames', ';',null);">
				<bean:message key="dialog.selectOrg"/>
			</a> --%>	
				<xform:address propertyId="authEditorIds"  propertyName="authEditorNames" mulSelect="true" textarea="true"
						style="width:90%;" showStatus="edit"></xform:address>
			<div>
		</td>
	</tr>
	<%}%>
	<% if(mSet.contains("authAttDownloads")){ %>
	<tr id="authAttDownloadZone">
		<td width=90%>
			<input type="checkbox" name="authAttDownloadCheck" value="true" onclick="showElementInput(this)">
			<bean:message  bundle="sys-right" key="right.change.authAttDownloadIds"/>
			<div id="authAttDownloadCheckInput" style="display:none">
			
			<div id="authAttDownloadCheckNotFlag" style="display:none">
			<input type="checkbox" name="authAttNodownload" value="true" onclick="swapNotFlag(this)">
			<bean:message key="right.att.authAttNodownload" bundle="sys-right"/>
			</div>

			<div id="authAttNodownloadInput">
				<%-- <html:hidden property="authAttDownloadIds" />
				<html:text property="authAttDownloadNames" readonly="true" styleClass="inputmul" style="width:90%" />
				<a href="#" onclick="Dialog_Address(true, 'authAttDownloadIds','authAttDownloadNames', ';',null);">
					<bean:message key="dialog.selectOrg"/>
				</a> --%>
				<xform:address propertyId="authAttDownloadIds"  propertyName="authAttDownloadNames" mulSelect="true" textarea="true"
					style="width:90%;" showStatus="edit"></xform:address>
			<div>
			<div id="authAttDownloadCheckEmpty" style="display:none">												
			<bean:message key="right.att.authAttDownloads.note" bundle="sys-right"/>
			<div>

			</div>		
		</td>
	</tr>
	<%}%>
	<% if(mSet.contains("authAttPrints")){ %>
	<tr id="authAttPrintZone">
		<td width=90%>
			<input type="checkbox" name="authAttPrintCheck" value="true" onclick="showElementInput(this)">
			<bean:message  bundle="sys-right" key="right.change.authAttPrintIds"/>
			<div id="authAttPrintCheckInput" style="display:none">
			
			<div id="authAttPrintCheckNotFlag" style="display:none">
			<input type="checkbox" name="authAttNoprint" value="true" onclick="swapNotFlag(this)">
			<bean:message key="right.att.authAttNoprint" bundle="sys-right"/>
			</div>

			<div id="authAttNoprintInput">
				<%-- <html:hidden property="authAttPrintIds" />
				<html:text property="authAttPrintNames" readonly="true" styleClass="inputmul" style="width:90%" />
				<a href="#" onclick="Dialog_Address(true, 'authAttPrintIds','authAttPrintNames', ';',null);">
					<bean:message key="dialog.selectOrg"/>
				</a> --%>
				<xform:address propertyId="authAttPrintIds"  propertyName="authAttPrintNames" mulSelect="true" textarea="true"
					style="width:90%;" showStatus="edit"></xform:address>
			<div>
			<div id="authAttPrintCheckEmpty" style="display:none">															
			<bean:message key="right.att.authAttPrints.note" bundle="sys-right"/>
			<div>

			</div>	
		</td>
	</tr>
	<%}%>
	<% if(mSet.contains("authAttCopys")){ %>
	<tr id="authAttCopyZone">
		<td width=90%>
			<input type="checkbox" name="authAttCopyCheck" value="true" onclick="showElementInput(this)">
			<bean:message  bundle="sys-right" key="right.change.authAttCopyIds"/>
			<div id="authAttCopyCheckInput" style="display:none">
			
			<div id="authAttCopyCheckNotFlag" style="display:none">
			<input type="checkbox" name="authAttNocopy" value="true" onclick="swapNotFlag(this)">
			<bean:message key="right.att.authAttNocopy" bundle="sys-right"/>
			</div>

			<div id="authAttNocopyInput">

				<%-- <html:hidden property="authAttCopyIds" />
				<html:text property="authAttCopyNames" readonly="true" styleClass="inputmul" style="width:90%" />
				<a href="#" onclick="Dialog_Address(true, 'authAttCopyIds','authAttCopyNames', ';',null);">
					<bean:message key="dialog.selectOrg"/>
				</a> --%>
				<xform:address propertyId="authAttCopyIds"  propertyName="authAttCopyNames" mulSelect="true" textarea="true"
					style="width:90%;" showStatus="edit"></xform:address>
			<div>
			<div id="authAttCopyCheckEmpty" style="display:none">															
			<bean:message key="right.att.authAttCopys.note" bundle="sys-right"/>
			<div>

			</div>	
		</td>

	</tr>	
	<%}%>
	
</table>
</center>
<html:hidden property="fdIds" value="${HtmlParam.fdIds}"/>
<html:hidden property="modelName" value="${HtmlParam.modelName}"/>
<html:hidden property="method_GET"/>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>