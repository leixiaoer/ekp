/**
 *矩阵填空题统计
 */
(function(window){
	var matrixfilled={};
	
	matrixfilled.init=function(questionJson){
		var index=questionJson.index;
		var div=$("<div id='questions"+index+"' class='pi_question' style='margin-top: -15px;' />");
		div.appendTo($("#viewResult"));
		div.prepend(getTableHTML(questionJson));
		//画“参与”、“跳过”进度条
		var totalNum = 10;
		if($('#fdParticipantNum').val() != null && $('#fdParticipantNum').val() != "")
			totalNum = parseInt($('#fdParticipantNum').val());
		var participateNumber = questionJson.fdStatistic.participateNumber;
		var notInvolvedNumber = questionJson.fdStatistic.notInvolvedNumber;
		var participate = {to: participateNumber*100/totalNum,nd:2};
		var pantNum = $("#fdParticipantNum").val();
		if(participateNumber ==0 && notInvolvedNumber == 0){
			notInvolvedNumber = pantNum;
		}
		var o1 = new html5jp.progress("participate"+index, participate,"#5AB536");
		o1.draw();
		var notInvolved = {to: notInvolvedNumber*100/totalNum,nd:2};
		var o2 = new html5jp.progress("notInvolved"+index, notInvolved,"#F28822");
		o2.draw();
		$('#participateTxt'+index).html("（"+participateNumber+" / "+pantNum+"）");
		$('#notInvolvedTxt'+index).html("（"+notInvolvedNumber+" / "+pantNum+"）");
		var otherDiv = '<div class="pi_otherInfo">'+Data_GetResourceString("km-pindagate:kmPindagateResponse.allInfo")+':“';
		otherDiv += '<a href="javascript:void(0);" onclick="matrixfilled_viewOtherAnswer(\''+questionJson.questionId+'\');" style="cursor: pointer;">'+Data_GetResourceString("km-pindagate:kmPindagateResponse.view")+'</a>”</div>';
		div.append(otherDiv);
	};
	
	function getTableHTML(questionJson){
		var index=questionJson.index;
		var tableHTML = '<table class="options_tb" width=90% id="singleSelect_TB'+index+'">';
		tableHTML += getTitleHTML(questionJson);
		tableHTML += getProgressHTML(questionJson);
		tableHTML += '</table>';
		return tableHTML;
	}
	function getTitleHTML(questionJson){
		var serialNum = questionJson.serialNum;
		var titleHTML = '<tr><td>';
		titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
		var title = questionJson.fdQuestionDef.subject;
		title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
		title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
		titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
		if(questionJson.fdQuestionDef.willAnswer)
			titleHTML += '<span class="pi_txtRequire">*</span>';
		titleHTML += '<span class="pi_txtStrong"> ['+questionJson.quesTypeName+']</span>';
		titleHTML += '</td></tr>';
		if(questionJson.fdQuestionDef.tip != ''){
			var tip=questionJson.fdQuestionDef.tip;
			titleHTML += '<tr><td><div class="pi_subjectExplain">';
			titleHTML += Data_GetResourceString("km-pindagate:kmPindagateQuestion.preview.titleDescription")+'<span>'+tip+'</span>';
			titleHTML += '</div></td></tr>';
		}
		return titleHTML;
	}
	function getProgressHTML(questionJson){
		var index=questionJson.index;
		var progressHTML = '<tr><td>';
		progressHTML += '<table class="pi_progress"><tr><td>'+Data_GetResourceString("km-pindagate:kmPindagateQuestionRes.involved")+'</td><td><div id="participate'+index+'"></div></td><td><div id="participateTxt'+index+'"></td></tr></div>';
		progressHTML += '<table class="pi_progress"><tr><td>'+Data_GetResourceString("km-pindagate:kmPindagateQuestionRes.notInvolved")+'</td><td><div id="notInvolved'+index+'"></div></td><td><div id="notInvolvedTxt'+index+'"></td></tr></div>';
		progressHTML += '</td></tr>';
		return progressHTML;
	}
	
	// 全部信息:“查看”
	window.matrixfilled_viewOtherAnswer=function(questionId){
		var url=Com_Parameter.ContextPath+"km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=list&questionId="+questionId;
		Com_OpenWindow(url);
	};
	
	window.matrixfilled=matrixfilled;
	
})(window);