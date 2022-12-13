<%@ page language="java" pageEncoding="UTF-8"%>
<style type="text/css" >
	.btnopt{color: #fff; background-color: #47b5ea; height: 22px; line-height:12px; padding: 3px 5px; border:0px;letter-spacing: 1px; cursor: pointer;}
</style>
<script type="text/javascript" src='<c:url value="/km/pindagate/resource/ajaxupload.3.6.js"/>'></script>
<script type="text/javascript">
	Com_IncludeFile("jquery.js|json2.js");
	var _dialog;
	seajs.use(['lui/dialog'], function(dialog){
		_dialog=dialog;
	});
</script>
<%@include file="/km/pindagate/question_type_ui/common/common_edit_script.jsp"%>
<script type="text/javascript">
	/**
	* 模态窗口打开时载入初始内容
	*/
	 var obj = top._question||opener._question;
	 var atturl = '<c:url value="/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=editAtt"/>';
	 //添加主文档ID
	 var kmPindagateMainFdId = "${JsParam.kmPindagateMainFdId}";
	 var isTemp = "${JsParam.isTemp}";
	 //判断是否为首次打开模态窗口，非首次打开时载入相关内容
	 if(obj!=null&&obj.value!=null&&obj.value!=""){
		var selecttype = eval("("+obj.value+")");
		$("[name='subject']").val(selecttype.subject);
		$("[name='tip']").val(selecttype.tip);
		$("#vlistColumnCount").val(selecttype.vlistColumnCount);
		$("#otherText").val(selecttype.otherText);
		$("#otherTextSize").val(selecttype.otherTextSize);
		$("#selectReasonText").val(selecttype.selectReasonText);
		$("#selectReasonTextSize").val(selecttype.selectReasonTextSize);
		if(selecttype.willAnswer){
			$("#willAnswer").prop("checked",true);
		}else{
			$("#willAnswer").prop("checked",false);
		}
		if(selecttype.hlist){
			$("#hlist").prop("checked",true);
			$('#div_vlistColumnCount').show();
		}else{
			$("#hlist").prop("checked",false);
			$('#div_vlistColumnCount').hide();
		}
		if(selecttype.autoAddOther){
			$("#autoAddOther").prop("checked",true);
			$('#div_otherText').show();
		}else{
			$("#autoAddOther").prop("checked",false);
			$('#div_otherText').hide();
		}
		//配置选择原因选项
		if(selecttype.autoAddSelectReason){
			$("#autoAddSelectReason").prop("checked",true);
			$('#div_selectReasonText').show();
		}else{
			$("#autoAddSelectReason").prop("checked",false);
			$('#div_selectReasonText').hide();
		}
		$("input[name=statisticPic]").each(function(){
		   if($(this).val()==selecttype.statisticPic){
		    $(this).prop("checked",true);
		   }    
		});
		var QuestionItems = selecttype.items;
		for(var key in QuestionItems ){
			addQuestionItem(Com_HtmlEscape(QuestionItems[key][0]),QuestionItems[key][1]);
		}
		//加载附件
		if(selecttype.attachmentIds&&selecttype.attachmentIds!="" && selecttype.attachmentIds!="null"){
			atturl = Com_SetUrlParameter(atturl,"attachmentIds",selecttype.attachmentIds);
			if(kmPindagateMainFdId!=""){
				atturl = Com_SetUrlParameter(atturl,"kmPindagateMainFdId",kmPindagateMainFdId);
			}
		}
	}else{ //首次打开则默认增加新行
		$("#willAnswer").prop("checked",true);
		addQuestionItem();
		atturl = Com_SetUrlParameter(atturl,"attachmentIds","");
	}
	if(isTemp!=""){
		atturl = Com_SetUrlParameter(atturl,"isTemp",isTemp);
	}
	//加载附件iframe
	document.getElementById("attFrame").src = atturl;
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
	/**
	* 保存操作重新设置相关变量的值
	*/
	function save(){
		var statisticPic = "histogram";
		$("input[name='statisticPic']").each(function(){
			   if($(this).prop("checked")==true){
				   statisticPic = $(this).val();
			   }
		});
		var subjectText = RTF_GetContent('subject'); 
		subjectText = CKFilter.fireReplaceFilters(subjectText);
		if(validateIsNull(subjectText)){
			_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.subject'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.notNull'/>");
			return;
		}
		var tipText = RTF_GetContent('tip'); 
		tipText = CKFilter.fireReplaceFilters(tipText);
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
				_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.quetItem'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.notNull'/>");
				return;
			}
			$( QuestionItemImgs).each(function(index){
				QuestionItemValues[index]=[QuestionItemTextValues[index],$(this).val()];
			});
		} catch (e) {
			_dialog.alert(e.name + ": " + e.message);
		}
		if($('#hlist').prop("checked")==true){
			if(validateIsNull($("#vlistColumnCount").val())){
				_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.vlistColumnCount'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.notNull'/>");
				return;
			}
			if(!validateIsNumber($("#vlistColumnCount").val())){
				_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.vlistColumnCount'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.mustBeInteger'/>");
				return;
			}
		}
		if($('#autoAddOther').prop("checked")==true){
			if(validateIsNull($("#otherText").val())){
				_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.otherText"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
				return;
			}
		}
		//选择原因为空校验
		if($('#autoAddSelectReason').prop("checked")==true){
			if(validateIsNull($("#selectReasonText").val())){
				_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectReasonText"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
				return;
			}
		}
		 var selecttype={};
		 var obj = top._question||opener._question;;//兼容旧UED
		 if(obj != null ){
			 selecttype = {
					 "autoAddOther":$('#autoAddOther').prop("checked")==true,
					 "hlist":$('#hlist').prop("checked")==true,
					 "items":QuestionItemValues,
					 "otherText":$("#otherText").val(),
					 "otherTextSize":$("#otherTextSize").val(),
					 "statisticPic":statisticPic,
					 "subject":subjectText,
					 "tip":tipText,
					 "vlistColumnCount":$("#vlistColumnCount").val(),
					 "willAnswer":$("#willAnswer").prop("checked")==true,
			 		 "autoAddSelectReason":$('#autoAddSelectReason').prop("checked")==true,
					 "selectReasonText":$("#selectReasonText").val(),
					 "selectReasonTextSize":$("#selectReasonTextSize").val(),
					 "attachmentIds":$("#attachmentIds").val(),
					 "deletedAttachmentIds":$("#deletedAttachmentIds").val()
					 };
		}else{
			_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.error.canNotFindTarget'/>");
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
		if(window.$dialog){
			window.$dialog.hide(obj);
		}else{//兼容旧UED
			opener._closeDialog(obj);
			window.close();
		}
	}
	//关闭窗口
	function _close(){
		if(window.$dialog){
			window.$dialog.hide();
		}else{//兼容旧UED
			window.close();
		}
	}
	/**
	* 增加选项
	*/
	function addQuestionItem(text,imgsrc){
		var rowCount = $('#questionitemlist tr').length;
		text = text==null?"":text;
		imgsrc = imgsrc==null?"":imgsrc;
		var str = '<tr><td>';
			str+='<img src="${KMSS_Parameter_StylePath}icons/delete.gif"  onclick="deleteQuestionItem(this);" style="cursor:pointer;"/></td>';
			str+='<td>'+rowCount+'</td>';
			str+='<td><input type="text" style="width:245px;" class="inputsgl" name="itemtext" value="'+text+'"/></td>';
			str+='<td><div style="position:relative" ><input type="text" style="width:100px;display:none" class="inputsgl" name="questionitemimg'+rowCount+'" value="'+imgsrc+'"/>';
			str+='<div class="lui_toolbar_btn_def"><div class="lui_toolbar_btn_l"><div class="lui_toolbar_btn_r"><div class="lui_toolbar_btn_c"><span id="question_upload_button'+rowCount+'">&nbsp;<bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.upload.browse"/>&nbsp;</span></div></div></div></div>';
			str+='<div id="itemImgDiv'+rowCount+'"></div></div></td></tr>';
		 $("#questionitemlist").append(str);
		var imgArr = imgsrc.split(";");
		var imgHtml="";
		for(var i=0; i<imgArr.length; i++){
			if(imgArr[i] != ""){
				var _id="questionitemimg"+rowCount;
				imgHtml += '<img src="'+imgArr[i]+'" border="1"  onclick="previewTooltip(event, this.src)" style="cursor:pointer;"  width="25px" hight="25px"/><img src="${KMSS_Parameter_StylePath}icons/delete.gif" width=16 height=16 onclick="deleteImg(\''+_id+'\','+i+')" title="'+"<bean:message bundle='km-pindagate' key='kmPindagateQuestion.deletePic'/>"+'" style="cursor:pointer;">&nbsp;';
			}
		}
		$('input[name="questionitemimg'+ rowCount+'"]').next().next().html(imgHtml);
		 uploadImg('#question_upload_button'+rowCount,"questionitemimg"+rowCount);
	}
	/**
	* 通过dom节点的操作删除指定问题行，也可以通过jquery进行操作
	*/
	function deleteQuestionItem(img){
		var table=img.parentNode.parentNode.parentNode;
		table.removeChild(img.parentNode.parentNode);
		var trsLength=$('#questionitemlist tr').length;
		var trs=$('#questionitemlist tr');
		//更新序号
		for(var i=1;i<trsLength;i++){
			trs[i].childNodes[1].firstChild.nodeValue=i;
			trs[i].childNodes[3].firstChild.name = "questionitemimg"+i;
		}
	}
	/**
	* 获取RTF文本域内容
	*/
	function RTF_GetContent(prop){
		var instance=CKEDITOR.instances[prop];
	    if(instance){
	          return instance.getData();
	    }
	    return "";
	}
</script>