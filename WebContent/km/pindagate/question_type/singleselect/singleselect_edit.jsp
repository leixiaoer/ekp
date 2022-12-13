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
			<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.singleselect"/></b>&nbsp;&nbsp;&nbsp;
			<a href="#" onmousemove="showFigure(event,'images/caseDiagram.gif',10);" onmouseout="hide(this);"><font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.legend"/></font></a>
			<div align="right"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.showFigure"/>
			<input type="radio" name="statisticPic" value="histogram"  checked="true"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.histogram"/>
			<input type="radio" name="statisticPic" value="pie" /><bean:message bundle="km-pindagate" key="kmPindagateQuestion.pie"/></div>
		</td>
	</tr>
	<tr>
		<td bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><span class="txtstrong">*</span></td>
	</tr>
	<tr>
		<td>
			<textarea name="subject" id="subject" style="width:90%;height:150" ></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2"	width=100%>
			<iframe id="attFrame" onload="autoResize(this);"  src="" width=100% height=100% frameborder=0 scrolling=no>
			</iframe>
		</td>
		
	</tr>
	<tr>
		<td>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.tip"/>
		</td>
	</tr>
	<tr>
		<td><textarea name="tip" id="tip"  style="width:90%;height:150" ></textarea></td>
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
					<td width="180"><b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.title"/></b></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.questionSeting"/></td></tr>
	<tr>
		<td>
			<input type="checkbox" name="willAnswer" id="willAnswer" value="true" ><bean:message bundle="km-pindagate" key="kmPindagateQuestion.willAnswer"/><br>
			<input type="checkbox" name="hlist" id="hlist" value="true"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.hlist"/><br>
			<div id="div_vlistColumnCount">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message bundle="km-pindagate" key="kmPindagateQuestion.vlistColumnCount"/><input type="text" id="vlistColumnCount" name="vlistColumnCount" value="" class="inputSgl"></div>
			<input type="checkbox" name="autoAddOther" id="autoAddOther" value="true" ><bean:message bundle="km-pindagate" key="kmPindagateQuestion.autoAddOther"/><br>
			<div id="div_otherText">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message bundle="km-pindagate" key="kmPindagateQuestion.otherText"/><input type="text" id="otherText" name="otherText" value="" class="inputSgl">
				<%--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        <bean:message bundle="km-pindagate" key="kmPindagateQuestion.otherTextSize"/><input id="otherTextSize" name="otherTextSize" type="text" value="" class="inputSgl">
		     	<font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.unit"/></font>--%>
			</div>
			<input type="checkbox" name="autoAddSelectReason" id="autoAddSelectReason" value="true" ><bean:message bundle="km-pindagate" key="kmPindagateQuestion.autoAddSelectReason"/><br>
			<div id="div_selectReasonText">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectReasonText"/><input type="text" id="selectReasonText" name="selectReasonText" value="" class="inputSgl">
				<%--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        <bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectReasonTextSize"/><input id="selectReasonTextSize" name="selectReasonTextSize" type="text" value="" class="inputSgl">
		     	<font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.unit"/></font>--%>
			</div>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href=#" onclick="save();"><input type="button" value="<bean:message key="button.save"/>"></a>
			<a href=#" onclick="window.close();"><input type="button" value="<bean:message key="button.close"/>"></a>
		</td>
	</tr>
</table>
<DIV id="dHTMLToolTip" 
style="Z-INDEX: 1000; LEFT: 0px; VISIBILITY: hidden; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px">
</DIV>
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
		var QuestionItemImgs = $("input:text[name^='questionitemimg']",$("#questionitemlist"));
		$(QuestionItemTexts).each(function(index){
			QuestionItemTextValues[index]=$(this).val();
			if(validateIsNull($(this).val()))
				quetItemIsNotNull = false;
		});
		if(!quetItemIsNotNull){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.quetItem"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		$( QuestionItemImgs).each(function(index){
			QuestionItemValues[index]=[QuestionItemTextValues[index],$(this).val()];
		});
	} catch (e) {
		alert(e.name + ": " + e.message);
	}
	if($('#hlist').attr("checked")==true){
		if(validateIsNull($("#vlistColumnCount").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.vlistColumnCount"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		if(!validateIsNumber($("#vlistColumnCount").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.vlistColumnCount"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.mustBeInteger"/>');
			return;
		}
	}
	if($('#autoAddOther').attr("checked")==true){
		if(validateIsNull($("#otherText").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.otherText"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		/*
		if(validateIsNull($("#otherTextSize").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.otherTextSize"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		if(!validateIsNumber($("#otherTextSize").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.otherTextSize"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.mustBeInteger"/>');
			return;
		}
		*/
	}
	//选择原因为空校验
	if($('#autoAddSelectReason').attr("checked")==true){
		if(validateIsNull($("#selectReasonText").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectReasonText"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		/*
		if(validateIsNull($("#selectReasonTextSize").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectReasonTextSize"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		if(!validateIsNumber($("#selectReasonTextSize").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectReasonTextSize"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.mustBeInteger"/>');
			return;
		}
		*/
	}
	 var selecttype={};
	 var obj = window.dialogArguments;
	 if(obj != null ){
		 selecttype = {"autoAddOther":$('#autoAddOther').attr("checked")==true,
				 "hlist":$('#hlist').attr("checked")==true,
				 "items":QuestionItemValues,
				 "otherText":$("#otherText").val(),
				 "otherTextSize":$("#otherTextSize").val(),
				 "statisticPic":statisticPic,
				 "subject":subjectEditor.GetXHTML(true),
				 "tip":tipEditor.GetXHTML(true),
				 "vlistColumnCount":$("#vlistColumnCount").val(),
				 "willAnswer":$("#willAnswer").attr("checked")==true,
		 		 "autoAddSelectReason":$('#autoAddSelectReason').attr("checked")==true,
				 "selectReasonText":$("#selectReasonText").val(),
				 "selectReasonTextSize":$("#selectReasonTextSize").val(),
				 "attachmentIds":$("#attachmentIds").val(),
				 "deletedAttachmentIds":$("#deletedAttachmentIds").val()
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
		$("#vlistColumnCount").val(selecttype.vlistColumnCount);
		$("#otherText").val(selecttype.otherText);
		$("#otherTextSize").val(selecttype.otherTextSize);
		$("#selectReasonText").val(selecttype.selectReasonText);
		$("#selectReasonTextSize").val(selecttype.selectReasonTextSize);
		if(selecttype.willAnswer){
			$("#willAnswer").attr("checked",true);
		}else{
			$("#willAnswer").removeAttr("checked");
		}
		if(selecttype.hlist){
			$("#hlist").attr("checked",true);
		}else{
			$("#hlist").removeAttr("checked");
			$('#div_vlistColumnCount').hide();
		}
		if(selecttype.autoAddOther){
			$("#autoAddOther").attr("checked",true);
		}else{
			$("#autoAddOther").removeAttr("checked");
			$('#div_otherText').hide();
		}
		//配置选择原因选项
		if(selecttype.autoAddSelectReason){
			$("#autoAddSelectReason").attr("checked",true);
		}else{
			$("#autoAddSelectReason").removeAttr("checked");
			$('#div_selectReasonText').hide();
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
		if(kmPindagateMainFdId!=""){
			atturl = Com_SetUrlParameter(atturl,"kmPindagateMainFdId",kmPindagateMainFdId);
		}
	}else{ //首次打开则默认增加新行
		$("#willAnswer").attr("checked",true);
		addQuestionItem();
		atturl = Com_SetUrlParameter(atturl,"attachmentIds","");
	}
	
	if(isTemp!=""){
		atturl = Com_SetUrlParameter(atturl,"isTemp",isTemp);
	}
	//加载附件iframe
	document.getElementById("attFrame").src = atturl;
	oFCKeditor = new FCKeditor("subject"); 
	oFCKeditor.BasePath = "<%=request.getContextPath()%>/resource/fckeditor/";  
	oFCKeditor.Height = 230; 
	oFCKeditor.ToolbarSet = "Define";  
	oFCKeditor.Config['ToolbarStartExpanded'] = false ;
	
	oFCKeditor.ReplaceTextarea(); 
	var tFCKeditor = new FCKeditor("tip"); 
	tFCKeditor.BasePath = "<%=request.getContextPath()%>/resource/fckeditor/";  
	tFCKeditor.Height = 120; 
	tFCKeditor.ToolbarSet = "Define";  
	 tFCKeditor.Config['ToolbarStartExpanded'] = false ;
	tFCKeditor.ReplaceTextarea(); 

	$("#hlist").click(function (){
		if(this.checked)
			$('#div_vlistColumnCount').show();
		else
			$('#div_vlistColumnCount').hide();
	});
	$("#autoAddOther").click(function (){
		if(this.checked)
			$('#div_otherText').show();
		else
			$('#div_otherText').hide();
	});
	//配置选择原因选项
	$("#autoAddSelectReason").click(function (){
		if(this.checked)
			$('#div_selectReasonText').show();
		else
			$('#div_selectReasonText').hide();
	});
	
});
var oFCKeditor;
var tFCKeditor;
function setImage(field){
	if($(field).val() !=null && $(field).val() != ""){
		$("img",$(field).parent()).attr("src",$(field).val());
		$("img",$(field).parent()).showFigure();
	}
	else{
		$("img",$(field).parent()).hide();
	}
}

function addQuestionItem(text,imgsrc){
	var rowCount = $('#questionitemlist tr').length;
	text = text==null?"":text;
	imgsrc = imgsrc==null?"":imgsrc;
	var str = '<tr><td>'
		str+='<img src="${KMSS_Parameter_StylePath}icons/delete.gif"  onclick="deleteQuestionItem(this);"/></td>';
		str+='<td>'+rowCount+'</td>';
		str+='<td><input type="text" style="width:245px;" class="inputSgl" name="itemtext" value="'+text+'"/></td>';
		str+='<td><div style="position:relative" ><input type="text" style="width:100px;display:none" class="inputSgl" name="questionitemimg'+rowCount+'" value="'+imgsrc+'"/><span id="question_upload_button'+rowCount+'" class="btnopt">';
		str+='<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.upload.browse"/></span>';
		str+='<div id="itemImgDiv'+rowCount+'"></div></div></td></tr>';
	 $("#questionitemlist").append(str);
	//if(imgsrc == null || imgsrc == "")
	//	$('input[name="questionitemimg'+ rowCount+'"]').next().next().hide();

	var imgArr = imgsrc.split(";");
	var imgHtml="";
	for(var i=0; i<imgArr.length; i++){
		if(imgArr[i] != ""){
			imgHtml += '<img src="'+imgArr[i]+'" border="1"  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" width="25px" hight="25px"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=10 height=10 onclick="deleteImg('+rowCount+','+i+')" title="删除此图片" >&nbsp;';
		}
	}
	$('input[name="questionitemimg'+ rowCount+'"]').next().next().html(imgHtml);

	 uploadImg('#question_upload_button'+rowCount,"questionitemimg"+rowCount);
}
var imgValueId;//定义一个全局变量用于上传完图片时动态改变显示url
function uploadImg(divId,imgId){
	var button=$(divId), interval;
	var fileType = "all",fileNum = "more"; 
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
		var oldUrl = $('input[name='+ imgValueId+']').val();
		var newUrl;
		if(oldUrl != ""){
			newUrl = oldUrl+";"+url;
		}else{
			newUrl = url;
		}
		$('input[name='+ imgValueId+']').attr('value',newUrl);	
		//$('input[name='+ imgValueId+']').next().next().attr('src',url);
		//$('input[name='+ imgValueId+']').next().next().show();
		var imgArr = newUrl.split(";");
		var imgHtml="";
		for(var i=0; i<imgArr.length; i++){
			if(imgArr[i] != ""){
				imgHtml += '<img src="'+imgArr[i]+'" border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" width="25px" hight="25px"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=10 height=10 onclick="deleteImg('+imgValueId.replace("questionitemimg","")+','+i+')" title="删除此图片" >&nbsp;';
			}
		}
		$('input[name='+ imgValueId+']').next().next().html(imgHtml);
	}
	else{
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.upload.fail"/>'+err);
	}
}
function  deleteImg(rowCount,k){
	var imgValueId = "questionitemimg"+rowCount;
	var imgUrl = $('input[name='+ imgValueId +']').val();
	var imgArr = imgUrl.split(";");
	var imgHtml="";
	var newUrl = "";
	var number = 0;
	for(var i=0; i<imgArr.length; i++){
		if(i!=k){
			if(imgArr[i] != ""){
				imgHtml += '<img src="'+imgArr[i]+'" border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" width="25px" hight="25px"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=10 height=10 onclick="deleteImg('+rowCount+','+number+')" title="删除此图片" >&nbsp;';			
				newUrl +=  (imgArr[i] + ";");
				number++;
			}
		}
	}
	$('input[name='+ imgValueId+']').attr('value',newUrl);
	$('input[name='+ imgValueId+']').next().next().html(imgHtml);
	
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
		trs[i].childNodes[3].firstChild.name = "questionitemimg"+i;
		//trs[i].childNodes[3].firstChild.nextSibling.id = "question_upload_button"+i;
		//uploadImg('#question_upload_button'+i,"questionitemimg"+i);
	}
}
/**
* 显示图例
*/
function showFigure(event,_this,imgint) {
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

//改变图片的大小
function resizeToSmail(_this){
  _this.style.width="100px"; 
  _this.style.height ="100px"; 
}
function resizeToLarge(_this){
  _this.style.width="25px"; 
  _this.style.height ="25px"; 
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