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

	$(document).ready(function () {
		
	});
	
	$("#fillQues").change(function () {
		var flag=$("#fillQues").is(':checked');
		if (flag==true) {
			$("#allcheck").show();
		}else{
			$("#allcheck").hide();
		}
	});
	
	$("#range").change(function () {
		var flag=$("#range").is(':checked');
		if (flag==true) {
			var ran=$("#integerVal span")[0];
			$(ran).show();
		}else{
			var ran=$("#integerVal span")[0];
			$(ran).hide();
		}
	});
	//汉字
	$("#strDefVal").change(function () {
		var flag=$("#strDefVal").is(':checked');
		if (flag==true) {
			var ran=$("#stringVal span")[0];
			$(ran).show();
		}else{
			var ran=$("#stringVal span")[0];
			$(ran).hide();
		}
	});
	
	$("#defVal").change(function () {
		var flag=$("#defVal").is(':checked');
		if (flag==true) {
			var ran=$("#integerVal span")[1];
			$(ran).show();
		}else{
			var ran=$("#integerVal span")[1];
			$(ran).hide();
		}
	});
	
	$("#cityVal").change(function () {
		var flag=$("#cityVal").is(':checked');
		if (flag==true) {
			var ran=$("#cutyVal span")[0];
			$(ran).show();
		}else{
			var ran=$("#cutyVal span")[0];
			$(ran).hide();
		}
	})
	$("#defVal").change(function () {
		var flag=$("#defVal").is(':checked');
		if (flag==true) {
			$("#integerDef").show();
		}else{
			$("#integerDef").hide();
		}
	})

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
		 $("#questionsSel").val(selecttype.questionsSel);
		 $("#dataSel").val(selecttype.dataSel);
		 $("#range").val(selecttype.range);
		 $("#cityVal").val(selecttype.cityVal);
		 $("#defVal").val(selecttype.defVal);
		 $("#integerDef").val(selecttype.integerDef);
		 $("#min").val(selecttype.min);
		 $("#max").val(selecttype.max);
		 $("#strValDef").val(selecttype.strValDef);
		
		 var questionVal=selecttype.questionsSel;
		 if (questionVal=="6"&&selecttype.cityVal==true) {
			 showAddress(selecttype.prov,selecttype.city);
			 $("#prov").val(selecttype.prov);
			 $("#city").val(selecttype.city);
			 $("#country").val(selecttype.country);
		}
		if(selecttype.tip){
			$("#willProblem").prop("checked",true);
		}else{
			$("#willProblem").prop("checked",false);
		}
		if(selecttype.willAnswer){
			$("#willAnswer").prop("checked",true);
		}else{
			$("#willAnswer").prop("checked",false);
		}
		if(selecttype.fillQues){
			$("#fillQues").prop("checked",true);
			$("#allcheck").show();
		}else{
			$("#fillQues").prop("checked",false);
			$("#allcheck").hide();
		}
		if(selecttype.strDefVal){
			$("#strDefVal").prop("checked",true);
			var ran=$("#stringVal span")[0];
			$(ran).show();
		}else{
			$("#strDefVal").prop("checked",false);
			var ran=$("#stringVal span")[0];
			$(ran).hide();
		}
		if(selecttype.range){
			$("#range").prop("checked",true);
			var ran=$("#integerVal span")[0];
			$(ran).show();
		}else{
			$("#range").prop("checked",false);
			var ran=$("#integerVal span")[0];
			$(ran).hide();
		}
		if(selecttype.cityVal){
			$("#cityVal").prop("checked",true);
			var ran=$("#cutyVal span")[0];
			$(ran).show();
		}else{
			$("#cityVal").prop("checked",false);
			var ran=$("#cutyVal span")[0];
			$(ran).hide();
		}
		if(selecttype.defVal){
			$("#defVal").prop("checked",true);
			var ran=$("#integerVal span")[1];
			$(ran).show();
		}else{
			$("#defVal").prop("checked",false);
			var ran=$("#integerVal span")[1];
			$(ran).hide();
		}
		if(selecttype.tip){
			$("#willProblem").prop("checked",true);
		}else{
			$("#willProblem").prop("checked",false);
		}
		if(selecttype.willProblem){
			$("#willProblem").prop("checked",true);
			$('#willValue').show();
		}else{
			$("#willProblem").prop("checked",false);
			$('#willValue').hide();
		}
		checkShowHide(questionVal,"ready");
		//加载附件
		if(selecttype.attachmentIds&&selecttype.attachmentIds!="" && selecttype.attachmentIds!="null"){
			atturl = Com_SetUrlParameter(atturl,"attachmentIds",selecttype.attachmentIds);
			if(kmPindagateMainFdId!=""){
				atturl = Com_SetUrlParameter(atturl,"kmPindagateMainFdId",kmPindagateMainFdId);
			}
		}
	 }else{
			$("#willAnswer").prop("checked",true);
			atturl = Com_SetUrlParameter(atturl,"attachmentIds","");
	 }
	 if(isTemp!=""){
			atturl = Com_SetUrlParameter(atturl,"isTemp",isTemp);
	}
	document.getElementById("attFrame").src=atturl;
	 
 
	//转换与校验选项
	//1：整数、2：小数、3：日期、4：手机、5：邮箱、6：省市区、7：身份证号、8：汉字、9：英文
	function questionsSel(obj){
		var val=$("#"+obj.id+" option:selected");
		val=val.val();
		checkShowHide(val);
	}
	
	function checkShowHide(val,sign){
		var number1=["9","8"],
		number2=["1","2"];
		if (sign) {
			if (number1.indexOf(val)>-1) {
				$("#stringVal").show();
			}else{
				$("#stringVal").hide();
			}
		}else{
			if (number1.indexOf(val)>-1) {
				$("#stringVal").show();
				$("#strValDef").val("");
				$("#range").prop("checked",false);
				$("#defVal").prop("checked",false);
				var ran=$("#integerVal span")[0];
				$(ran).hide();
				$("#integerDef").hide();
			}else{
				$("#stringVal").hide();
				$("#strValDef").val("");
				$("#range").prop("checked",false);
				$("#defVal").prop("checked",false);
				var ran=$("#integerVal span")[0];
				$(ran).hide();
				$("#integerDef").hide();
			}
		}
		
		
		if (val=="3") 
			$("#dataVal").show();
		else
			$("#dataVal").hide();
		
		if (val=="6"){
			$("#cutyVal").show();
		}else{
			$("#cutyVal").hide();
		}
		
		if (sign) {
			if (number2.indexOf(val)>-1){
				$("#integerVal").show();
			}else{
				$("#integerVal").hide();
			}
		}else{
			if (number2.indexOf(val)>-1){
				$("#integerVal").show();
				$("#integerVal input").val("");
			}else{
				$("#integerVal").hide();
				$("#integerVal input").val("");
			}
		}
		
	}
	
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
		if(validateIsNull(subjectText)){
			_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.subject'/>  <bean:message bundle='km-pindagate' key='kmPindagateQuestion.validate.notNull'/>");
			return;
		}
		// 非法字符过滤
		subjectText = CKFilter.fireReplaceFilters(subjectText);
		var tipText = RTF_GetContent('tip'); 
		// 非法字符过滤
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
			//-------
			if($('#fillQues').prop("checked")==true){
				var selVal=$("#questionsSel").val(),
					number1=["9","8"],
					number2=["1","2"];
				var strFlag=$("#strDefVal").is(':checked');
				if (number1.indexOf(selVal)>-1) {
					var strVal=$("#strValDef").val();
					if (strFlag==true) {
						if (selVal=="9") {
							 var rex=/^[a-zA-Z\s]+$/;
							 if(!rex.test(strVal)){
								 _dialog.alert("${lfn:message('km-pindagate:kmPindagate.fillquestions.englishPush')}");
								 return;
							 }
						}
					
						if (selVal=="8") {
							 var rex=/^[\u4e00-\u9fa5]+$/gi;
							 if(!rex.test(strVal)){
								 _dialog.alert("${lfn:message('km-pindagate:kmPindagate.fillquestions.chinesePush')}");
								 return;
							 }
						}
					}
					
					$("#integerVal input").val("");
					$("#range").prop("checked",false);
					$("#defVal").prop("checked",false);
				}
				
				if (number2.indexOf(selVal)>-1){
					if (selVal=="1") {
						var flag=$("#range").is(':checked');
						var flagDef=$("#defVal").is(':checked');
						var rex=/^-?\d+$/;
						//var rex1=/^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
						var rex1=/^-?[1-9]\d*$/;
						if (flag==true) {
							var max=$("#max").val(),
								min=$("#min").val();
							if (max==""||max==null||min==""||min==null) {
								 _dialog.alert("${lfn:message('km-pindagate:kmPindagateQuestion.maxminnotnull')}");
								 return;
							}
							 if (parseFloat(min)>=parseFloat(max)) {
								 _dialog.alert("${lfn:message('km-pindagate:kmPindagate.fillquestions.minMoreMax')}");
								 return;
							}
							 
						}
						if (flagDef==true) {
							var intDef=$("#integerDef").val()
							if(!rex.test(intDef)){
								 _dialog.alert("${lfn:message('km-pindagate:kmPindagate.fillquestions.intPush')}");
								 return;
							 }
						}
						if (flag==true&&flagDef==true) {
							if (parseInt(intDef)>parseInt(max)||parseInt(intDef)<parseInt(min)) {
								_dialog.alert("${lfn:message('km-pindagate:kmPindagate.fillquestions.defNoMaxisMin')}");
								 return;
							}
						}
					}
					
					if (selVal=="2") {
						var flag=$("#range").is(':checked');
						var flagDef=$("#defVal").is(':checked');
						var rex=/^(([^0][0-9]{0,9999}|0)\.([0-9]{1,2}))$/;
						var rex1= /^[+-]?\d*\.?\d{0,2}$/;
						if (flag==true) {
							var max=$("#max").val(),
								min=$("#min").val();
							if (max==""||max==null||min==""||min==null) {
								_dialog.alert("${lfn:message('km-pindagate:kmPindagateQuestion.maxminnotnull')}");
								 return;
							}
							 if (parseFloat(min)>=parseFloat(max)) {
								 _dialog.alert("${lfn:message('km-pindagate:kmPindagate.fillquestions.minMoreMax')}");
								 return;
							}
							 
						}
						if (flagDef==true) {
							var intDef=$("#integerDef").val()
							if(!rex.test(intDef)){
								 _dialog.alert("${lfn:message('km-pindagate:kmPindagate.fillquestions.doubleTwoPlace')}");
								 return;
							 }
						}
						if (flag==true&&flagDef==true) {
							if (parseFloat(intDef)>parseFloat(max)||parseFloat(intDef)<parseFloat(min)) {
								_dialog.alert("${lfn:message('km-pindagate:kmPindagate.fillquestions.defNoMaxisMin')}");
								 return;
							}
						}
					}
					$("#strValDef").val("");
				}
				if (selVal=="6") {
					var cityFlag=$("#cityVal").is(':checked');
					if (cityFlag==true) {
						var provVal=$("#prov").val();
							cityVal=$("#city").val();
							countryVal=$("#country").val();
							if (provVal=="-1"||cityVal=="-1"||countryVal=="-1"){
								_dialog.alert("省市区默认值需选择！");
								return;								
							}			
					}
				}
			}else{
				$("#questionsSel").val("");
			}
			
		} catch (e) {
			_dialog.alert(e.name + ": " + e.message);
		}
		 var selecttype={};
		 var obj = top._question||opener._question;;//兼容旧UED
		 if(obj != null ){
			 selecttype = {
					 "statisticPic":statisticPic,
					 "fillType":"fillquestions",
					 "subject":subjectText,
					 "tip":tipText,
					 "min":$("#min").val(),
					 "max":$("#max").val(),
					 "questionsSel":$("#questionsSel").val(),
					 //省市区 start
					 "cityVal":$("#cityVal").prop("checked")==true,
					 "prov":$("#prov").val(),
					 "city":$("#city").val(),
					 "country":$("#country").val(),
					 "provTxt":$("#prov option:selected").text(),
					 "cityTxt":$("#city option:selected").text(),
					 "countryTxt":$("#country option:selected").text(),
					//省市区 end
					 "integerDef":$("#integerDef").val(),
					 "strValDef":$("#strValDef").val(),
					 "dataSel":$("#dataSel").val(),
					 "willAnswer":$("#willAnswer").prop("checked")==true,
					 "fillQues":$("#fillQues").prop("checked")==true,
					 "range":$("#range").prop("checked")==true,
					 "strDefVal":$("#strDefVal").prop("checked")==true,
					 "defVal":$("#defVal").prop("checked")==true,
					 "willProblem":$("#willProblem").prop("checked")==true,
			 		 "autoAddSelectReason":$('#autoAddSelectReason').prop("checked")==true,
					 "selectReasonText":$("#selectReasonText").val(),
					 "selectReasonTextSize":$("#selectReasonTextSize").val(),
					 "attachmentIds":"",
					 "checkMsg":"",
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
	
	function checkValueShow(){
		if (document.getElementById("willProblem").checked==true) {
			$("#willValue").show();
		}else{
			$("#willValue").hide();
		}
	}
</script>