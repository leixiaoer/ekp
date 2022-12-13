<%@ page language="java" pageEncoding="UTF-8"%>
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
	$(document).ready(function(){
		var obj = top._question||opener._question;//兼容旧版UED
		 var atturl = '<c:url value="/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=editAtt"/>';
		//添加主文档ID
		 var kmPindagateMainFdId = "${JsParam.kmPindagateMainFdId}";
		 var isTemp = "${JsParam.isTemp}";
		//初始化问题内容
		if(obj.value!=null&&obj.value!=""){
			var selecttype = eval("("+obj.value+")");
			$("[name='subject']").text(selecttype.subject);
			$("[name='tip']").text(selecttype.tip);
			$("#vlistColumnCount").val(selecttype.vlistColumnCount);
			$("#textHeight").val(selecttype.inputHeight);
			if(selecttype.willAnswer){
				$("#willAnswer").prop("checked",true);
			}else{
				$("#willAnswer").prop("checked",false);
			}
			if(selecttype.hlist){
				$("#hlist").prop("checked",true);
			}else{
				$("#hlist").prop("checked",false);
			}
			var selecttype = eval("("+obj.value+")");
			//加载附件
			if(selecttype.attachmentIds&&selecttype.attachmentIds!="" && selecttype.attachmentIds!="null"){
				atturl = Com_SetUrlParameter(atturl,"attachmentIds",selecttype.attachmentIds);
				if(kmPindagateMainFdId!=""){
					atturl = Com_SetUrlParameter(atturl,"kmPindagateMainFdId",kmPindagateMainFdId);
				}
			}
		}
		else{
			$("#willAnswer").prop("checked",true);
			atturl = Com_SetUrlParameter(atturl,"attachmentIds","");
		}
		if(isTemp!=""){
			atturl = Com_SetUrlParameter(atturl,"isTemp",isTemp);
		}
		document.getElementById("attFrame").src=atturl;
		//构造RTF域
		//var subject=document.getElementById("subject");
		//CKEDITOR.replace(subject, {"toolbar":"subject","toolbarStartupExpanded":false,"toolbarCanCollapse":true,"height":"120px"});
		//var tip=document.getElementById("tip");
		//CKEDITOR.replace(tip, {"toolbar":"tip","toolbarStartupExpanded":false,"toolbarCanCollapse":true,"height":"120px"});
	});
	/**
	* 保存操作重新设置相关变量的值
	*/
	function save(){
		var subjectContent=RTF_GetContent("subject");
		var tip=RTF_GetContent("tip");
		// 非法字符过滤
		subjectContent = CKFilter.fireReplaceFilters(subjectContent);
		tip = CKFilter.fireReplaceFilters(tip);
		if(subjectContent==""||subjectContent==null){
			_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.subject'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.notNull'/>");
			return;
		}
		if($("#textHeight").val()==""||$("#textHeight").val()==null){
			_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.textarea.height'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.notNull'/>");
			return;
		}
		if(isNaN($("#textHeight").val())){
			_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.textarea.height'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.mustBeInteger'/>");
			return;
		}
		 var obj =top._question||opener._question;
		 if(obj != null ){
			var selecttype = {
				"inputHeight":$("#textHeight").val(),
				"subject":subjectContent,
				 "tip":tip,
				 "vlistColumnCount":$("#vlistColumnCount").val(),
				 "willAnswer":$("#willAnswer").prop("checked")==true,
				 "attachmentIds":"",
				 "deletedAttachmentIds":""
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
	function _close(){
		if(window.$dialog){
			window.$dialog.hide();
		}else{//兼容旧UED
			window.close();
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