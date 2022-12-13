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
	 var obj =top._question||opener._question;
	 var atturl = '<c:url value="/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=editAtt"/>';
	 //添加主文档ID
	 var kmPindagateMainFdId = "${JsParam.kmPindagateMainFdId}";
	 var isTemp = "${JsParam.isTemp}";
	 //判断是否为首次打开模态窗口，非首次打开时载入相关内容
	 if(obj!=null&&obj.value!=null&&obj.value!=""){
		var selecttype = eval("("+obj.value+")");
		$("[name='subject']").val(selecttype.subject);
		$("[name='tip']").val(selecttype.tip);
		$("#selectReasonText").val(selecttype.selectReasonText);
		if(selecttype.willAnswer){
			$("#willAnswer").prop("checked",true);
		}else{
			$("#willAnswer").prop("checked",false);
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
	}else{
	 	//首次打开则默认增加新行
		$("#willAnswer").prop("checked",true);
		addQuestionItem();
		atturl = Com_SetUrlParameter(atturl,"attachmentIds","");
	}
	if(isTemp!=""){
		atturl = Com_SetUrlParameter(atturl,"isTemp",isTemp);
	}
	document.getElementById("attFrame").src = atturl;
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
		$("input[name=statisticPic]").each(function(){
			   if($(this).prop("checked")==true){
				   statisticPic = $(this).val();
			   }    
			});
		var subjectText = RTF_GetContent('subject'); 
		subjectText = CKFilter.fireReplaceFilters(subjectText);
		if(validateIsNull(subjectText)){
			alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.subject'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.notNull'/>");
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
			var QuestionItemScores = $("input:text[name^='selectScore']",$("#questionitemlist"));
			$(QuestionItemTexts).each(function(index){
				QuestionItemTextValues[index]=$(this).val();
				if(validateIsNull($(this).val()))
					quetItemIsNotNull = false;
			});
			if(!quetItemIsNotNull){
				_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.quetItem'/><bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.notNull'/>");
				return;
			}
			var quesItemScoreNotNull = true;
			$( QuestionItemScores).each(function(index){
				QuestionItemValues[index]=[QuestionItemTextValues[index],$(this).val()];
				if(validateIsNull($(this).val()))
					quesItemScoreNotNull = false;
			});
			if(!quesItemScoreNotNull){
				_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.scoreValue"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
				return;
			}
			
		} catch (e) {
			alert(e.name + ": " + e.message);
		}
		//选择原因为空校验
		if($('#autoAddSelectReason').prop("checked")==true){
			if(validateIsNull($("#selectReasonText").val())){
				_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectReasonText"/><bean:message bundle="km-pindagate" key="kmPindagateQuestion.validate.notNull"/>');
				return;
			}
		}
		 var selecttype={};
		 var obj =top._question||opener._question;
		 if(obj != null ){
			  selecttype = {"items":QuestionItemValues,
					 "statisticPic":statisticPic,
					 "subject":subjectText,
					 "tip":tipText,
					 "willAnswer":$("#willAnswer").prop("checked")==true,
					 "autoAddSelectReason":$('#autoAddSelectReason').prop("checked")==true,
					 "selectReasonText":$("#selectReasonText").val(),
					 "showAverage":$('#showAverage').prop("checked")==true,
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
	//关闭窗口
	function _close(){
		if(window.$dialog){
			window.$dialog.hide();
		}else{//兼容旧UED
			window.close();
		}
	}
	/**
	* 增加问题
	*/
	function addQuestionItem(text,selectScore){
		var rowCount = $('#questionitemlist tr').length;
		var str = "<tr><td><img src=\"${KMSS_Parameter_StylePath}icons/delete.gif\"  onclick=\"deleteQuestionItem(this);\" style='cursor:pointer;' /></td><td>"+rowCount+"</td><td><input type=\"text\" style=\"width:245px;\" class=\"inputsgl\" name=\"itemtext\" value=\""
			+(text==null?"":text)+"\"/></td><td><input type=\"text\" style=\"width:100px;\" class=\"inputsgl\" name=\"selectScore"+rowCount+"\" onkeyup='checkDate(this)' value=\""+(selectScore==null?"":selectScore)+"\"/></td></tr>";
		 $("#questionitemlist").append(str);
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