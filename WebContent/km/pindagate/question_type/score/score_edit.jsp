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
			<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.score"/></b>&nbsp;&nbsp;&nbsp;
			<a href="#" onmousemove="show(event,'images/caseDiagram.gif',10);" onmouseout="hide(this);"><font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.legend"/></font></a>
			<div align="right"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.showFigure"/>
			<input type="radio" name="statisticPic" value="histogram"  checked="true"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.histogram"/>
			<input type="radio" name="statisticPic" value="pie" /><bean:message bundle="km-pindagate" key="kmPindagateQuestion.pie"/></div>
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
	<tr>
		<td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.quetItem"/><span class="txtstrong">*</span></td>
	</tr>
	<tr>
		<td>
			<table id="questionitemlist" class="tb_normal" width=100%>
				<tr>
					<td><img src="${KMSS_Parameter_StylePath}icons/add.gif" onclick="addQuestionItem();" style="cursor:hand"></td>
					<td><bean:message key="page.serial"/></td>
					<td width="245"><b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.quetItem"/>&nbsp;&nbsp;&nbsp;&nbsp;</b><font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.IncreasedMulti"/></font></td>
					<td width="180"><b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.scoreValue"/></b></td>
				</tr>
				
			</table>
		</td>
	</tr>
	<tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.questionSeting"/></td></tr>
	<tr>
		<td>
			<input type="checkbox" name="willAnswer" id="willAnswer" value="true" ><bean:message bundle="km-pindagate" key="kmPindagateQuestion.willAnswer"/><br>
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
<script type="text/javascript">
//保存操作重新设置相关变量的值
function save(){
	var statisticPic = "histogram";
	$(":radio[@name=statisticPic]").each(function(){
		   if($(this).attr("checked")==true){
			   statisticPic = $(this).val();
		   }    
		});
	var subjectEditor = FCKeditorAPI.GetInstance('subject');  
	if(validateIsNull(subjectEditor.GetXHTML(true))){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
		return;
	}
	var tipEditor = FCKeditorAPI.GetInstance('tip'); 
	var QuestionItemTextValues = new Array;
	var QuestionItemValues = new Array;
	try{
		var quetItemIsNotNull = true;
		var QuestionItemTexts = $('input:text[name="itemtext"]',$("#questionitemlist"));
		if(QuestionItemTexts.length < 1)
			quetItemIsNotNull = false;
		var QuestionItemScores = $("input:text[name^='selectScore']",$("#questionitemlist"));
		$(QuestionItemTexts).each(function(index){
			QuestionItemTextValues[index]=$(this).val();
			if(validateIsNull($(this).val()))
				quetItemIsNotNull = false;
		});
		if(!quetItemIsNotNull){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.quetItem"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		$( QuestionItemScores).each(function(index){
			QuestionItemValues[index]=[QuestionItemTextValues[index],$(this).val()];
		});
	} catch (e) {
		alert(e.name + ": " + e.message);
	}
	 var selecttype={};
	var obj = window.dialogArguments;
	 if(obj != null ){
		  selecttype = {"items":QuestionItemValues,
				 "statisticPic":statisticPic,
				 "subject":subjectEditor.GetXHTML(true),
				 "tip":tipEditor.GetXHTML(true),
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
//模态窗口打开时载入初始内容
$(document).ready(function(){ 
	 var obj = window.dialogArguments;
	 var atturl = '<c:url value="/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=editAtt"/>';
	 //添加主文档ID
	 var kmPindagateMainFdId = "${JsParam.kmPindagateMainFdId}";
	 var isTemp = "${JsParam.isTemp}";
	 //判断是否为首次打开模态窗口，非首次打开时载入相关内容
	 if(obj!=null&&obj.value!=null&&obj.value!=""){
		var selecttype = eval("("+obj.value+")");
		$("#subject").text(selecttype.subject);
		$("#tip").text(selecttype.tip);
		if(selecttype.willAnswer){
			$("#willAnswer").attr("checked",true);
		}else{
			$("#willAnswer").removeAttr("checked");
		}
		$(":radio[@name=statisticPic]").each(function(){
		   if($(this).val()==selecttype.statisticPic){
		    $(this).attr("checked",true);
		   }    
		});
		var QuestionItems = selecttype.items;
		for(var key in QuestionItems ){
			addQuestionItem(QuestionItems[key][0],QuestionItems[key][1]);
		}
		if(selecttype.attachmentIds){
			atturl = Com_SetUrlParameter(atturl,"attachmentIds",selecttype.attachmentIds);
		}
		//加载附件iframe
		if(kmPindagateMainFdId!=""){
			atturl = Com_SetUrlParameter(atturl,"kmPindagateMainFdId",kmPindagateMainFdId);
		}
	}else{
	 	//首次打开则默认增加新行
		$("#willAnswer").attr("checked",true);
		addQuestionItem();
		atturl = Com_SetUrlParameter(atturl,"attachmentIds","");
	}
	
	if(isTemp!=""){
		atturl = Com_SetUrlParameter(atturl,"isTemp",isTemp);
	}
	document.getElementById("attFrame").src = atturl;
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
var oFCKeditor;
var tFCKeditor;

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
function addQuestionItem(text,selectScore){
	var rowCount = $('#questionitemlist tr').length;
	var str = "<tr><td><img src=\"${KMSS_Parameter_StylePath}icons/delete.gif\"  onclick=\"deleteQuestionItem(this);\"/></td><td>"+rowCount+"</td><td><input type=\"text\" style=\"width:245px;\" class=\"inputSgl\" name=\"itemtext\" value=\""
		+(text==null?"":text)+"\"/></td><td><input type=\"text\" style=\"width:100px;\" class=\"inputSgl\" name=\"selectScore"+rowCount+"\" onkeyup='checkDate(this)' value=\""+(selectScore==null?"":selectScore)+"\"/></td></tr>";
	 $("#questionitemlist").append(str);
}

//通过dom节点的操作删除指定问题行，也可以通过jquery进行操作
function deleteQuestionItem(img){
	var table=img.parentNode.parentNode.parentNode;
	table.removeChild(img.parentNode.parentNode);
	var trsLength=$('#questionitemlist tr').length;
	var trs=$('#questionitemlist tr');
	//更新序号
	for(var i=1;i<trsLength;i++){
		trs[i].childNodes[1].firstChild.nodeValue=i;
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
function checkDate(obj){	
	var str_tmp;
	var str_val="";
	for (var i=0;i<obj.value.length;i++){
		str_tmp=obj.value.substring(i,i+1);	
	 if ( (str_tmp>="0" && str_tmp<="9") || (str_tmp=="." && str_val.indexOf(".")==-1))
			str_val+=str_tmp
	}
	if (obj.value!=str_val) obj.value=str_val;
}
</script>
<%@ include file="/resource/jsp/edit_down.jsp"%>