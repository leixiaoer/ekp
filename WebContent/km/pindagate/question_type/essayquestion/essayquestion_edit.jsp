<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("jquery.js|json2.js");
</script>
<script type="text/javascript" src='<c:url value="/km/pindagate/resource/ajaxupload.3.6.js"/>'></script>
<script type="text/javascript" src="${KMSS_Parameter_ResPath}fckeditor/fckeditor.js"></script>
<script type="text/javascript">
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight;	
}
</script>
<div id="a1" style="display:none;position:absolute; top:100px; right:80px;"></div>
<center>
<table class="tb_normal" width=90%>
	<tr>
		<td>
			<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.essayquestion"/></b>&nbsp;&nbsp;&nbsp;
			<a href="#" onmousemove="show(event,'images/caseDiagram.gif',10);" onmouseout="hide(this);"><font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.legend"/></font></a>
		</td>
	</tr>
	<tr>
		<td bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><span class="txtstrong">*</span>
		</td>
	</tr>
	<tr>
		<td>
			<textarea name="subject" id="subject" style="width:90%;height:60" ></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2"	width=100%>
			<iframe id="attFrame" onload="autoResize(this);"  src="" width=100% height=100% frameborder=0 scrolling=no>
			</iframe>
		</td>
		
	</tr>
	<tr>
		<td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.tip"/></td>
	</tr>
	<tr>
		<td><textarea name="tip" id="tip"  style="width:90%;height:60" cols="80" rows="4"></textarea></td>
	</tr>
	<tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.questionSeting"/></td></tr>
	<tr>
		<td>
			<input type="checkbox" name="willAnswer" id="willAnswer" value="true" ><bean:message bundle="km-pindagate" key="kmPindagateQuestion.willAnswer"/><br>
	        <bean:message bundle="km-pindagate" key="kmPindagateQuestion.textarea.height"/><input id="textHeight" name="textHeight" type="text" value="5" class="inputSgl">
	        <font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.unit.line"/></font>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href=#" onclick="save();"><input type="button" value="<bean:message key="button.save"/>"></a>
			<a href=#" onclick="window.close();"><input type="button" value="<bean:message key="button.close"/>"></a>
		</td>
	</tr>
</table>
</center>
<DIV id="dHTMLToolTip" 
style="Z-INDEX: 1000; LEFT: 0px; VISIBILITY: hidden; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px">
</DIV>
<script type="text/javascript">
//保存操作重新设置相关变量的值
function save(){
	var subjectEditor = FCKeditorAPI.GetInstance('subject'); 
	if(validateIsNull(subjectEditor.GetXHTML(true))){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
		return;
	}
	if(validateIsNull($("#textHeight").val())){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.textarea.height"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
		return;
	}
	if(!validateIsNumber($("#textHeight").val())){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.textarea.height"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.mustBeInteger"/>');
		return;
	}
	var tipEditor = FCKeditorAPI.GetInstance('tip'); 
	var selecttype={};
	var obj = window.dialogArguments; 
	 if(obj != null ){
		selecttype = {
				 "inputHeight":$("#textHeight").val(),
				 "subject":subjectEditor.GetXHTML(true),
				 "tip":tipEditor.GetXHTML(true),
				 "vlistColumnCount":$("#vlistColumnCount").val(),
				 "willAnswer":$("#willAnswer").attr("checked")==true,
				 "attachmentIds":"",
				 "deletedAttachmentIds":""
				 };
		
	 }else{
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.error.canNotFindTarget"/>');
	 }
	//附件提交
		var attObj = document.getElementById("attFrame").contentWindow.attachmentObject_questionAtt;
		afterAttSubmit(obj,selecttype);
}

function afterAttSubmit(obj,selecttype){
	document.getElementById("attFrame").contentWindow.attachmentObject_questionAtt.updateInput();
	selecttype.attachmentIds = document.getElementById("attFrame").contentWindow.document.getElementsByName("attachmentForms.questionAtt.attachmentIds")[0].value;
	selecttype.deletedAttachmentIds =document.getElementById("attFrame").contentWindow.document.getElementsByName("attachmentForms.questionAtt.deletedAttachmentIds")[0].value;
	var encoded = JSON.stringify(selecttype); 
	obj.value=encoded;
	window.close();
}
var oFCKeditor;
var tFCKeditor;
//模态窗口打开时载入初始内容
$(document).ready(function(){ 
	 var obj = window.dialogArguments;
	 var atturl = '<c:url value="/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=editAtt"/>';
	 //添加主文档ID
	 var kmPindagateMainFdId = "${JsParam.kmPindagateMainFdId}";
	 var isTemp = "${JsParam.isTemp}";
	 if(obj.value!=null&&obj.value!=""){
		var selecttype = eval("("+obj.value+")");
		$("#subject").text(selecttype.subject);
		$("#tip").text(selecttype.tip);
		$("#vlistColumnCount").val(selecttype.vlistColumnCount);
		$("#textHeight").val(selecttype.inputHeight);
			if(selecttype.willAnswer){
				$("#willAnswer").attr("checked",true);
			}else{
			$("#willAnswer").removeAttr("checked");
			}
			if(selecttype.hlist){
				$("#hlist").attr("checked",true);
			}else{
				$("#hlist").removeAttr("checked");
			}

		var selecttype = eval("("+window.dialogArguments.value+")");
		if(selecttype.attachmentIds){
			atturl = Com_SetUrlParameter(atturl,"attachmentIds",selecttype.attachmentIds);
		}
		//加载附件iframe
		if(kmPindagateMainFdId!=""){
			atturl = Com_SetUrlParameter(atturl,"kmPindagateMainFdId",kmPindagateMainFdId);
		}	
	}
	 else
	 {
		 $("#willAnswer").attr("checked",true);
		 atturl = Com_SetUrlParameter(atturl,"attachmentIds","");
	 }
	
	if(isTemp!=""){
		atturl = Com_SetUrlParameter(atturl,"isTemp",isTemp);
	}
	document.getElementById("attFrame").src=atturl;
	oFCKeditor = new FCKeditor("subject"); 
	oFCKeditor.BasePath = "<%=request.getContextPath()%>/resource/fckeditor/";  
	oFCKeditor.Height = 160; 
	oFCKeditor.ToolbarSet = "Define";  
	 oFCKeditor.Config['ToolbarStartExpanded'] = false ;
	oFCKeditor.ReplaceTextarea(); 
	var tFCKeditor = new FCKeditor("tip"); 
	tFCKeditor.BasePath = "<%=request.getContextPath()%>/resource/fckeditor/";  
	tFCKeditor.Height = 120; 
	tFCKeditor.ToolbarSet = "Define";  
	 tFCKeditor.Config['ToolbarStartExpanded'] = false ;
	tFCKeditor.ReplaceTextarea(); 

	
});

var imgValueId;//定义一个全局变量用于上传完图片时动态改变显示url
function uploadImg(divId,imgId){
	var button=$(divId), interval;
	var fileType = "all",fileNum = "one"; 
	new AjaxUpload(button,{
		action: '${KMSS_Parameter_ResPath}fckeditor/editor/filemanager/upload/simpleuploader?Type=Image', 
		name: 'NewFile',
		onSubmit : function(file, ext){
			imgValueId=imgId;
			button.text('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.uploading"/>');
			if(fileNum == 'one')
			this.disable();
			interval = window.setInterval(function(){
				var text = button.text();
				if (text.length < 13){
					button.text(text + '.');	
				} else {
					button.text('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.uploading"/>');
				}
			}, 200);
		},
		onComplete: function(file, response){
			button.text('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.upload.browse"/>');
			window.clearInterval(interval);
			this.enable();
		
		}
	});
}

function OnUploadCompleted(retval,url,newName,err){
	if(retval == 0){
		//更新url和图片显示值
		$('input[name='+ imgValueId+']').attr('value',url);	
		$('input[name='+ imgValueId+']').next().next().attr('src',url);
		$('input[name='+ imgValueId+']').next().next().show();
	}
	else{
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.upload.fail"/>'+err);
	}
}
function show(event,_this,imgint) {
	event = event || window.event;
  var t1="<table cellspacing='1' cellpadding='10' style='border-color:#066666;background-color:#FFFFFF;font-size:12px;border-style:solid;border-width:thin;text-align:center;'><tr><td><img src='" + _this   + "' ></td></tr></table>";
  var objA = document.getElementById("a1");
  objA.innerHTML = t1;
  with(objA.style) {
  	top = document.body.scrollTop + event.clientY + 10 + "px";
  	if (imgint > 0) {
  		left = document.body.scrollLeft + event.clientX + 10 + "px";
  	} else {
  		left = document.body.scrollLeft + event.clientX - objA.offsetWidth - 10 + "px";
  	}
  	display = "block";
  }
}
function hide(_this) {
	document.getElementById("a1").innerHTML = "";
	document.getElementById("a1").style.display = "none";
}
//校验是否为空
function validateIsNull(val){
	val = val.replace(/(\s*$)/g, "");
	if(val == null || val == "")
		return true;
	else
		return false;
}
//校验是否为真整数
function validateIsNumber(val){
	var re = /^[1-9]\d*$/;
    if (!re.test(val))
		return false;
	else
		return true;
}
function hideTooltip()
{
	var divObj = document.getElementById("dHTMLToolTip");
	divObj.style.visibility="hidden"
	divObj.style.left = 1;
	divObj.style.top = 1;
	return false
}
function showTooltip(e, tipContent)
{
	//window.clearTimeout(tipTimer);
	var divObj = document.getElementById("dHTMLToolTip");
	
	divObj.style.top=document.body.scrollTop+event.clientY+15
	divObj.innerHTML='<img src="'+tipContent+'">';
	
	if ((e.x + divObj.clientWidth) > (document.body.clientWidth + document.body.scrollLeft)){
		divObj.style.left = (document.body.clientWidth + document.body.scrollLeft) - divObj.clientWidth-10;
	}else{
		divObj.style.left=document.body.scrollLeft+event.clientX
	}
	divObj.style.visibility="visible"
	//tipTimer=window.setTimeout("hideTooltip('"+divId+"')", displaytime);
	return true;	
}
</script>
<%@ include file="/resource/jsp/edit_down.jsp"%>