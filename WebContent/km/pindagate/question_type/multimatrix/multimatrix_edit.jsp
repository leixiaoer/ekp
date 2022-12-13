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
			<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.multimatrix"/></b>&nbsp;&nbsp;&nbsp;
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
	<tr>
		<td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.question"/><span class="txtstrong">*</span></td>
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
		<tr>
		<td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.option"/><span class="txtstrong">*</span></td>
	</tr>
	<tr>
		<td>
			<table id="selectitemlist" class="tb_normal" width=100%>
				<tr>
					<td><img src="${KMSS_Parameter_StylePath}icons/add.gif" onclick="addSelectItem();" style="cursor:hand"></td>
					<td><bean:message key="page.serial"/></td>
					<td width="245"><b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.option"/>&nbsp;&nbsp;&nbsp;&nbsp;</b><font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.IncreasedMulti"/></font></td>
					<td width="180"><b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.title"/></b></td>
				</tr>
				
			</table>
		</td>
	</tr>
	<tr><td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.questionSeting"/></td></tr>
	<tr>
		<td>
			<input type="checkbox" name="willAnswer" id="willAnswer" value="true" ><bean:message bundle="km-pindagate" key="kmPindagateQuestion.willAnswer"/><br>
			<div id="div_minSelectNumber">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.minSelectNumber"/><input type="text" name="eachMinSelectNumber" id="eachMinSelectNumber" value=""  class="inputSgl"><br>
			</div>
			<input type="checkbox" name="hlist" id="hlist" value="true"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.hlist"/>
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
	var statisticPic = "histogram";
	var subjectEditor = FCKeditorAPI.GetInstance('subject'); 
	if(validateIsNull(subjectEditor.GetXHTML(true))){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
		return;
	}
	var tipEditor = FCKeditorAPI.GetInstance('tip'); 
	var QuestionItemTextValues = new Array;
	var QuestionItemValues = new Array;
	var SelectItemTextValues = new Array;
	var SelectItemValues = new Array;
	try{
		var quetItemIsNotNull = true;
		var optionItemIsNotNull = true;
		var QuestionItemTexts = $('input:text[name="itemtext"]',$("#questionitemlist"));
		if(QuestionItemTexts.length < 1)
			quetItemIsNotNull = false;
		var QuestionItemImgs = $("input:text[name^='questionitemimg']",$("#questionitemlist"));
		var SelectItemTexts = $('input:text[name="itemtext"]',$("#selectitemlist"));
		if(SelectItemTexts.length < 1)
			optionItemIsNotNull = false;
		var SelectItemImgs = $("input:text[name^='selectitemimg']",$("#selectitemlist"));
		$(QuestionItemTexts).each(function(index){
			QuestionItemTextValues[index]=$(this).val();
			if(validateIsNull($(this).val()))
				quetItemIsNotNull = false;
		});
		$( QuestionItemImgs).each(function(index){
			QuestionItemValues[index]=[QuestionItemTextValues[index],$(this).val()];
		});
		$(SelectItemTexts).each(function(index){
			SelectItemTextValues[index]=$(this).val();
			if(validateIsNull($(this).val()))
				optionItemIsNotNull = false;
		});
		if(!quetItemIsNotNull){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.quetItem"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		if(!optionItemIsNotNull){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.option"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		$( SelectItemImgs).each(function(index){
			SelectItemValues[index]=[SelectItemTextValues[index],$(this).val()];
		});
	} catch (e) {
		alert(e.name + ": " + e.message);
	}
	if($('#willAnswer').attr("checked")==true){
		if(validateIsNull($("#eachMinSelectNumber").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.minSelectNumber"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
			return;
		}
		if(!validateIsNumber($("#eachMinSelectNumber").val())){
			alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.minSelectNumber"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.mustBeInteger"/>');
			return;
		}else{
			if(parseInt($("#eachMinSelectNumber").val()) > SelectItemValues.length){
				alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.minSelectNumber"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.lessThanOrEqual"/>');
				return;
			}
		}
	}
	 var selecttype={};
	var obj = window.dialogArguments;
	 if(obj != null ){
		 var selecttype = {"autoAddOther":$('#autoAddOther').attr("checked")==true,
				 "hlist":$('#hlist').attr("checked")==true,
				 "items":QuestionItemValues,
				 "eachMinSelectNumber":$("#eachMinSelectNumber").val(),
				 "options":SelectItemValues,
				 "otherText":$("#otherText").val(),
				 "otherTextSize":$("#otherTextSize").val(),
				 "statisticPic":statisticPic,
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
		$("#eachMinSelectNumber").val(selecttype.eachMinSelectNumber);
		if(selecttype.willAnswer){
			$("#willAnswer").attr("checked",true);
		}else{
			$("#willAnswer").removeAttr("checked");
			$('#div_minSelectNumber').hide();
		}
		if(selecttype.hlist){
			$("#hlist").attr("checked",true);
		}else{
			$("#hlist").removeAttr("checked");
		}
		var QuestionItems = selecttype.items;
		var SelectItems=selecttype.options;
		for(var key in QuestionItems ){
			addQuestionItem(QuestionItems[key][0],QuestionItems[key][1]);
		}
		for(var key in  SelectItems){
			addSelectItem( SelectItems[key][0], SelectItems[key][1]);
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
		    $("#eachMinSelectNumber").attr("value",1);
			addQuestionItem();
			addSelectItem();
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

	$("#willAnswer").click(function (){
		if(this.checked)
			$('#div_minSelectNumber').show();
		else
			$('#div_minSelectNumber').hide();
	});

	
});
var oFCKeditor;
var tFCKeditor;
function setImage(field){
	if($(field).val() !=null && $(field).val() != ""){
		$("img",$(field).parent()).attr("src",$(field).val());
		$("img",$(field).parent()).show();
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
		str+='<td><div style="position:relative" ><input type="text" style="width:100px;display:none" class="inputSgl" name="questionitemimg'+rowCount+'"  value="'+imgsrc+'"/><button id="question_upload_button'+rowCount+'" class="btnopt">';
		str+='<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.upload.browse"/></button>';
		str+='<div id="itemImgDiv'+rowCount+'"></div></div></td></tr>';
	 $("#questionitemlist").append(str);
	//if(imgsrc == null || imgsrc == "")
	 //	$('input[name="questionitemimg'+ rowCount+'"]').next().next().hide();
	 var imgArr = imgsrc.split(";");
	 var imgHtml="";
	 for(var i=0; i<imgArr.length; i++){
		if(imgArr[i] != ""){
			imgHtml += '<img src="'+imgArr[i]+'" border="1"  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" width="25px" hight="25px"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=10 height=10 onclick="deleteImg('+rowCount+','+i+','+1+')" title="删除此图片" >&nbsp;';
		}
	 }
	 $('input[name="questionitemimg'+ rowCount+'"]').next().next().html(imgHtml);
	 uploadImg('#question_upload_button'+rowCount,"questionitemimg"+rowCount);
	 
}

function addSelectItem(text,imgsrc){
	var rowCount = $('#selectitemlist tr').length;
	text = text==null?"":text;
	imgsrc = imgsrc==null?"":imgsrc;
	var str = '<tr><td>'
		str+='<img src="${KMSS_Parameter_StylePath}icons/delete.gif"  onclick="deleteQuestionItem(this);"/></td>';
		str+='<td>'+rowCount+'</td>';
		str+='<td><input type="text" style="width:245px;" class="inputSgl" name="itemtext" value="'+text+'"/></td>';
		str+='<td><div style="position:relative" ><input type="text" style="width:100px;display:none" class="inputSgl" name="selectitemimg'+rowCount+'"  value="'+imgsrc+'"/><button id="select_upload_button'+rowCount+'" class="btnopt">';
		str+='<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.upload.browse"/></button>';
		str+='<div id="selectImgDiv'+rowCount+'"></div></div></td></tr>';
	 $("#selectitemlist").append(str);
	//if(imgsrc == null || imgsrc == "")
	 //	$('input[name="selectitemimg'+ rowCount+'"]').next().next().hide();
	 var imgArr = imgsrc.split(";");
	 var imgHtml="";
	 for(var i=0; i<imgArr.length; i++){
		if(imgArr[i] != ""){
			imgHtml += '<img src="'+imgArr[i]+'" border="1"  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" width="25px" hight="25px"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=10 height=10 onclick="deleteImg('+rowCount+','+i+','+0+')" title="删除此图片" >&nbsp;';
		}
	 }
	 $('input[name="selectitemimg'+ rowCount+'"]').next().next().html(imgHtml);
	 uploadImg('#select_upload_button'+rowCount,"selectitemimg"+rowCount);
}

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
function  deleteImg(rowCount,k,flag){
	var imgValueId;
	if(flag){
		imgValueId = "questionitemimg"+rowCount;
	}else{
		imgValueId = "selectitemimg"+rowCount;
	}
	var imgUrl = $('input[name='+ imgValueId +']').val();
	var imgArr = imgUrl.split(";");
	var imgHtml="";
	var newUrl = "";
	var number = 0;
	for(var i=0; i<imgArr.length; i++){
		if(i!=k){
			if(imgArr[i] != ""){
				imgHtml += '<img src="'+imgArr[i]+'" border="1" onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();" width="25px" hight="25px"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=10 height=10 onclick="deleteImg('+rowCount+','+number+','+flag+')" title="删除此图片" >&nbsp;';			
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
//通过dom节点的操作删除指定选项行，也可以通过jquery进行操作
function deleteSelectItem(img){
	var table=img.parentNode.parentNode.parentNode;
	table.removeChild(img.parentNode.parentNode);
	var trsLength=$('#selectitemlist tr').length;
	var trs=$('#selectitemlist tr');
	//更新序号
	for(var i=1;i<trsLength;i++){
		trs[i].childNodes[1].firstChild.nodeValue=i;
		trs[i].childNodes[3].firstChild.name = "selectitemimg"+i;
		trs[i].childNodes[3].firstChild.nextSibling.id = "select_upload_button"+i;
		uploadImg('#select_upload_button'+i,"selectitemimg"+i);
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

//改变图片的大小
function resizeToSmail(_this){
  _this.style.width="300px"; 
  _this.style.height ="300px"; 
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