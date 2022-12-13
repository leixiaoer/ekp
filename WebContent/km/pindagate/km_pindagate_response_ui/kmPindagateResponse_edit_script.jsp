<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
	Com_IncludeFile("jquery.js|json2.js|data.js");
	
	//避免加载过程中点击按钮
	$(function(){
		$('#buttonArea').hide();
		Com_AddEventListener(window,"load", function() {
			$('#buttonArea').show();
		});
	});
	
	var _dialog;
	seajs.use(['lui/dialog'], function(dialog) {
		_dialog=dialog;
	});
	
	//二维码
	LUI.ready(function(){
		seajs.use('lui/qrcode',function(qrcode){
			//出现多个二维码图标
			//qrcode.QrcodeToTop();
		});
	});
	
	var validation = $KMSSValidation();//校验框架

	var page_click_num = 1;
	var page_total_num = 0;
	var page_click_currNo = 1;

	var _ResponseJsFileList = new Array();
	//表单提交
	function commitMethod(method, status) {
		/* if (page_click_num < page_total_num && status != '10') {
			_dialog
					.alert("<bean:message key='kmPindagateResponse.error.canNotCommit' bundle='km-pindagate' />");
			return false;
		} */
		var pid = '${kmPindagateMainForm.fdId}';
		var isFinishUrl = "${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do?method=getDocStatus&fdId="
			+ pid;
		
		var url = "${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=checkIfCanRes&pid="
				+ pid;
		var checkUrl='${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=checkRepeatSubmit&&pindageteId='+ pid;; 
		$.post(isFinishUrl,function(data){
			if(data){
				if(Number(data)==32){
					_dialog.alert("<bean:message key='kmPindagateResponse.pindagate.finish' bundle='km-pindagate' />");	
				}else{
					$.post(
							url,
							function(data) {
								if (data.indexOf("true") > -1) {
									if (method=="save") {
										$.post(
												checkUrl,
												function(data) {
													if (data.indexOf("true") > -1) {
														$("input[name='docStatus']").val(status);
														submitForm(method);
													} else {
														_dialog
																.alert(
																		"<bean:message key='kmPindagateMain.tip.hasResponseFasle' bundle='km-pindagate' />");
														return false;
													}
											}); 
									}else{
										$("input[name='docStatus']").val(status);
										submitForm(method);
									}
								} else {
									_dialog
											.alert(
													"<bean:message key='kmPindagateMain.tip.hasResponse' bundle='km-pindagate' />");
									return false;
								}
						});  
				}
			}
			
		})
				 
	}


	//计算进度值，修改进度条
	function caculateProgress() {
		var allQuestions = $('.pi_question');
		var size = 0;
		var hasAnwserSize = 0;
		for(var i =0;i<allQuestions.length;i++) {
			if('none'==allQuestions[i].style.display) {
				continue;
			};
			size++;
			if('true' == $(allQuestions[i]).find(":input[name='hasAnswer']").val()) {
				hasAnwserSize++;
			}
		}
		$(".pindagate_progress_number").html(
				parseInt((hasAnwserSize / size) * 100) + "%");
		$(".pindagate_progress_complete").height(hasAnwserSize / size * 180);
		$(".pindagate_progress_uncomplete").height(
				(1 - hasAnwserSize / size) * 180);
	}
	function submitForm(method) {
		var canSave = true;
		var messages = "";
		if ($("input[name='docStatus']").val() == "10") {
			Com_Submit(document.forms[0], method);
			return;
		}
		$('input[name="validateResult"]').each(function() {
			validateResult = eval('(' + (this.value) + ')');
			if (!validateResult.canSave) {
				canSave = false;
				messages += validateResult.message + "\r\n";
			}
		});
		if (canSave)
			Com_Submit(document.forms[0], method);
		else
			_dialog.alert(messages);
	}
	//提示信息
	function showMaskLayer(divDialog, divDialogContent, dialogContent,
			isDispaly) {
		if (isDispaly)
			$("#" + divDialog).css({
				display : "block"
			});
		else
			$("#" + divDialog).css({
				display : "none"
			});
		$("#" + divDialogContent).html(dialogContent);
	}
	//注册题目使用js
	function Response_RegisterJsFile(fileName) {
		if (Com_ArrayGetIndex(_ResponseJsFileList, fileName) == -1)
			_ResponseJsFileList[_ResponseJsFileList.length] = fileName;
	}
	//引入题目使用js
	function Response_IncludeJsFile(fileName) {
		if (Com_ArrayGetIndex(_ResponseJsFileList, fileName) == -1) {
			_ResponseJsFileList[_ResponseJsFileList.length] = fileName;
			document.writeln("<script src="+fileName+"><\/script>");
		}
	}
	//对于题目中附件高度处理
	function autoResize(obj) {
		obj.height = obj.contentWindow.document.body.scrollHeight + 20;
	}
	//改变图片的大小
	function resizeToSmail(_this) {
		_this.style.width = "300px";
		_this.style.height = "300px";
	}
	function resizeToLarge(_this) {
		_this.style.width = "14px";
		_this.style.height = "14px";
	}
</script>
<script>
	var dialogContent = "<img src='${KMSS_Parameter_StylePath}icons/loading.gif' border='0'><bean:message bundle='km-pindagate' key='kmPindagateResponse.loading'/>";
	showMaskLayer('dialog','dialog_content',dialogContent);
</script>
<script type="text/javascript">
	/**
	 * 题型定义数组（每个题型的题型定义的属性名跟questiontype包下面各个题型的QuestionType类里面的属性相对应）
	 * 例如：单选题的fdQuestionDef.willAnswer 对应 SingleSelectType类里面的willAnswer属性
	 */
	var fdQuestionDef = new Array();
	LUI.ready(function (){
		changePage();
		readPage();
		showMaskLayer('dialog','dialog_content','',false);
		showCountDown();
		var dialogContent = "<img src='${KMSS_Parameter_ContextPath}km/pindagate/images/alerts.gif' height='14px' width='14px' border='0'>&nbsp;";
		if("${canResponse}" == "false"||"${isReject}"=="true"){
			var finishTime = "${finishTime}";
			var isPindagateFinish = "${isPindagateFinish}";
			if("${isReject}"=="true"){
				dialogContent+="你已拒绝参与此调查";
				$("#dialog_content").css({color:"red"});
			}else if(isPindagateFinish=="1"){
				dialogContent = "";
			}else if(finishTime == "")
				dialogContent += "<bean:message bundle='km-pindagate' key='kmPindagateResponse.notInvolvedAuth'/>";
			else
				dialogContent += "<bean:message bundle='km-pindagate' key='kmPindagateResponse.hasBeenInvolved1'/>"+finishTime+"<bean:message bundle='km-pindagate' key='kmPindagateResponse.hasBeenInvolved2'/>";
			$("#dialog_content").css({color:"red"});
			showMaskLayer('dialog','dialog_content',dialogContent,true);
		}
	});
	//倒计时
	<% 
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
	
		String __currentTime = formatter.format(currentTime); //将日期时间格式化 
		request.setAttribute("currentTime",__currentTime); //将要调用的值传到页面request.setAttribute（“参数”，值）；
		
		request.setAttribute("currentTimeLong",currentTime.getTime());
	%>
	var currentTimeString = '${currentTime}',//String类型
		currentTime = '${currentTimeLong}',//Long类型
		docFinishedTimeString = '${kmPindagateMainForm.docFinishedTime}';//String类型
		docFinishedTime = null,//Long类型
		Timer = null;//定时器 
	function showCountDown(){
		LUI('finishButton').setVisible(false);
		if(!docFinishedTimeString){
			//调查时间不限制
			var _text = "${ lfn:message('km-pindagate:kmPindagateMain.docFinishedTime') }:${ lfn:message('km-pindagate:kmPindagateMain.null.not.limit.time') }";
			$('.docFinishedTime').text(_text);
			return ;
		}else{
			docFinishedTime = Com_GetDate(docFinishedTimeString.replace(/\-/g,'/')).getTime();//Long类型
		 	if(docFinishedTime<=currentTime){
				var _text = "${lfn:message('km-pindagate:kmPindagateResponse.pindagate.hasFinished')}";
				_text = _text.replace(/%docFinishedTime%/g,docFinishedTimeString);
				$('.docFinishedTime').text(_text);
				LUI('finishButton').setVisible(true);
				LUI('finishButton').setDisabled(true);
				if(LUI('submitButton')){
					LUI('submitButton').setVisible(false);
				}
				var _tips="${lfn:message('km-pindagate:kmPindagateResponse.pindagate.finish')}";
				$('#docFinishedTips').text(_tips);
				return ;
			}else{
				Timer = setInterval(_setInterval,1000);
			}
		}
	}
		
	function _setInterval(){
		var duration = docFinishedTime - currentTime;
		if(duration >= 1000){
			var day=parseInt( duration/(24*60*60*1000) ),
				hour=parseInt( duration % (24*60*60*1000) /(60*60*1000) ),
				minute=parseInt (duration % (60*60*1000) / (60*1000) ),
				second=parseInt (duration % (60*1000) / 1000 ); 
			var _text =  "<img style='margin-bottom:-2px;' src='${LUI_ContextPath}/km/pindagate/resource/images/countdown.png'>"
				_text += "${lfn:message('km-pindagate:kmPindagateResponse.pindagate.beforeFinish')}";
			_text = _text.replace(/%day%/g,day).replace(/%hour%/g,hour).replace(/%minute%/g,minute).replace(/%second%/g,second);
			$('.docFinishedTime').html(_text);
			docFinishedTime = docFinishedTime - 1000;
		}else{
			window.clearInterval(Timer);
			Timer = null;
			var _text = "${lfn:message('km-pindagate:kmPindagateResponse.pindagate.hasFinished')}";
			_text = _text.replace(/%docFinishedTime%/g,docFinishedTimeString);
			
			var _tips="${lfn:message('km-pindagate:kmPindagateResponse.pindagate.finish')}";
			$('#docFinishedTips').text(_tips);
			
			$('.docFinishedTime').text(_text);
			LUI('finishButton').setVisible(true);
			LUI('finishButton').setDisabled(true);
			if(LUI('submitButton')){
				LUI('submitButton').setVisible(false);
			}
		}
	}	
	
	function Dictionary(){
		this.data = new Array();
		this.put = function(key,value){
		 this.data[key] = value;
		};
		this.get = function(key){
		 return this.data[key];
		};
		this.remove = function(key){
		 this.data[key] = null;
		};
		this.isEmpty = function(){
		 return this.data.length == 0;
		};
		 this.size = function(){
		  return this.data.length;
		 };
	}
	//存储题目是否被初始化信息
	var pagesInit= new Dictionary();
	/**
	* 换页
	* 	   _method : prev(上一页)、next(下一页)、current(当前页)
	*/
	function changePage(_method,_this){
		var currentPage = $('font[name="currentPage"]').html();
		var totalPage = $('font[name="totalPage"]').html();
		if(_method == "prev"){
			currentPage = parseInt(currentPage)-1;
		}
		else if(_method == "next"){
			currentPage = parseInt(currentPage)+1;
			if(parseInt(currentPage)>page_click_currNo){
				page_click_num=page_click_num+1;
				page_click_currNo=parseInt(currentPage);
			}
		}
		else{
			currentPage = parseInt(currentPage);
		}
		if(currentPage == 1){
			LUI("prev1").setDisabled(true);
			LUI("prev2").setDisabled(true);
		}else{
			LUI("prev1").setDisabled(false);
			LUI("prev2").setDisabled(false);
		}
		if(currentPage == 0){
			_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateResponse.alreadyTheFirstPage"/>');
			return;
		}
		if(currentPage > parseInt(totalPage)){
			_dialog.alert('<bean:message bundle="km-pindagate" key="kmPindagateResponse.alreadyTheEndPage"/>');
			return;
		}
		var divID = "";
		totalPage = 1;
		var index = 0;
		
		var finishedTime = Com_GetDate(docFinishedTimeString.replace(/\-/g,'/')).getTime();//Long类型
		$('input[name="fdSplit"]').each(function(){
			divID = "questions" + index;
			if (this.value == "true") {
				totalPage++;
				$('#' + divID).hide();
			} else {
				if (totalPage == currentPage) {
					var type = $('#fdType' + index).val();
					var funType = '';
					if (type != '') {
						if ('singlematrix' == type) {
							funType = 'singleMatrix_init';
						} else if ('multimatrix' == type) {
							funType = 'multiMatrix_init';
						} else {
							funType = type + '_init';
						}
						if (pagesInit.get(index) != true) {
							eval(funType + '(\'' + index + '\',\''+ type + index + '\');');
							pagesInit.put(index, true);
						}
					}
					$('#' + divID).show();
					$(window).scrollTop(10);
					if('${canResponse}'!='true'){
						$(':input',$('#' + divID)).attr('disabled','disabled');
					}
					if("${isReject}"=="true"){
						$(':input',$('#' + divID)).attr('disabled','disabled');
					}
					
					if(docFinishedTimeString && finishedTime<=currentTime){
						$(':input',$('#' + divID)).attr('disabled','disabled');	
						$('.pindagate_progress').hide();
						if('${canResponse}'!='true'){
							$('#docFinishedTips').hide();
						}
					}
				}else{
					$('#' + divID).hide();
				}
			}
			index++;
		});
		if (currentPage == parseInt(totalPage)) {
			LUI("next1").setDisabled(true);
			LUI("next2").setDisabled(true);
		}else{
			LUI("next1").setDisabled(false);
			LUI("next2").setDisabled(false);
		}
		if (totalPage == 1) {
			$("#prev1,#prev2,#next1,#next2").css("display","none");
		}
		$('font[name="currentPage"]').html(currentPage);
		$('font[name="totalPage"]').html(totalPage);
		page_total_num=totalPage;
		
	}
	
	function readPage(){
		var index = 0;
		$('input[name="fdSplit"]').each(function(){
			var divID = "questions" + index;
			if (this.value == "true") {
				$('#' + divID).hide();
			} else {
				var type = $('#fdType' + index).val();
				var funType = '';
				if (type != '') {
					if ('singlematrix' == type) {
						funType = 'singleMatrix_init';
					} else if ('multimatrix' == type) {
						funType = 'multiMatrix_init';
					} else {
						funType = type + '_init';
					}
					if (pagesInit.get(index) != true) {
						eval(funType + '(\'' + index + '\',\''+ type + index + '\');');
						pagesInit.put(index, true);
					}
				}
			}
			index++;
		});
	}
	function hideTooltip() {
		var divObj=$("#dHTMLToolTip");
		divObj.css({"top":1,"left":1});
		divObj.hide();
		//var divObj = document.getElementById("dHTMLToolTip");
		//divObj.style.visibility = "hidden";
		//divObj.style.left = 1;
		//divObj.style.top = 1;
		return false;
	}
	function showTooltip(e, tipContent) {
		e = e || window.event; 
		var divObj=$("#dHTMLToolTip");
		divObj.html('<img src="' + tipContent + '">');
		var target=e.target||e.srcElement;
		var x=target.offsetLeft,y=target.offsetTop;
		target=target.offsetParent;
		while(target){
			x+=target.offsetLeft;
			y+=target.offsetTop;
			target=target.offsetParent;
		}
		divObj.css({"top":(y+14)/2,"left":x+14}).show();
		//var divObj = document.getElementById("dHTMLToolTip");
		//divObj.style.top = document.body.scrollTop + event.clientY + 15;
		//divObj.innerHTML = '<img src="' + tipContent + '">';
		//if ((e.x + divObj.clientWidth) > (document.body.clientWidth + document.body.scrollLeft)) {
		//	divObj.style.left = (document.body.clientWidth + document.body.scrollLeft) - divObj.clientWidth - 10;
		//} else {
		//	divObj.style.left = document.body.scrollLeft + event.clientX;
		//}
		//divObj.style.visibility = "visible";
		return true;
	}
	function previewTooltip(e,tipContent){
		var datas = {
				data : [{value : tipContent}],
				value : tipContent,
				valueType:'url'
		};
		seajs.use([ 'lui/imageP/preview' ],function(preview) {
			preview({
				data : datas
			});
		});
	}
	//更新统计数据
	function viewResult(){
	 _dialog.confirm('<bean:message bundle="km-pindagate" key="kmPindagateResponse.button.updateAndViewResult.confirm" />',function(isOk){
		if(isOk){
			Com_OpenWindow('${LUI_ContextPath}/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateMainForm.fdId}&flag=updateStatisticResult');
			}	
		});
	}
</script>