/**
 * 矩阵单选题统计
 */
(function(window){
	var singlematrix={};
	
	//绘制矩阵单选题
	singlematrix.init=function(questionJson){
		
		var index=questionJson.index;
		var div=$("<div id='questions"+index+"' class='pi_question' style='margin-top: -15px;' />");
		var innerDIV=$("<div style='text-align: left'  id='content"+index+"'></div>");
		innerDIV.appendTo(div);
		div.appendTo($("#dataAnalysis"));
		div.prepend(getTableHTML(questionJson));
		$('#content'+index).append(getDataAnalysisHTML(questionJson));
		
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
		if(questionJson.fdQuestionDef.autoAddSelectReason){
			var selectReasonDiv = '<div class="pi_otherInfo"><a href="javascript:void(0);" onclick="viewSelectReasonAnswer(\''+questionJson.questionId+'\');" style="cursor: pointer;">'+Data_GetResourceString("km-pindagate:kmPindagateResponse.view")+'“';
			selectReasonDiv += questionJson.fdQuestionDef.selectReasonText;
			selectReasonDiv += '”</a></div>';
			div.append(selectReasonDiv);
		}
	};
	
	//生成题目信息HTML
	function getTableHTML(questionJson){
		var index=questionJson.index;
		var tableHTML = '<table class="options_tb" width=90% id="singleSelect_TB'+index+'">';
		tableHTML += getTitleHTML(questionJson);
		tableHTML += getProgressHTML(questionJson);
		tableHTML += '</table>';
		return tableHTML;
	}
	
	//题头
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
	
	//生成进度条HTML
	function getProgressHTML(questionJson){
		var index=questionJson.index;
		var progressHTML = '<tr><td>';
		progressHTML += '<table class="pi_progress"><tr><td>'+Data_GetResourceString("km-pindagate:kmPindagateQuestionRes.involved")+'</td><td><div id="participate'+index+'"></div></td><td><div id="participateTxt'+index+'"></td></tr></div>';
		progressHTML += '<table class="pi_progress"><tr><td>'+Data_GetResourceString("km-pindagate:kmPindagateQuestionRes.notInvolved")+'</td><td><div id="notInvolved'+index+'"></div></td><td><div id="notInvolvedTxt'+index+'"></td></tr></div>';
		progressHTML += '</td></tr>';
		return progressHTML;
	}
	
	function getDataAnalysisHTML(questionJson){
		var dataAnalysisHTML = '<table class="tb_normal" style="margin:5px 20px;">';
		dataAnalysisHTML += '<tr>';
		dataAnalysisHTML += '<td align="center"></td>';
		for(var key in questionJson.fdQuestionDef.options){
			dataAnalysisHTML += '<td align="center">'+questionJson.fdQuestionDef.options[key][0]+'</td>';
		}
		dataAnalysisHTML += '</tr>';
		for(var key in questionJson.fdQuestionDef.items){
			dataAnalysisHTML += '<tr>';
			dataAnalysisHTML += '<td align="center">'+questionJson.fdQuestionDef.items[key][0]+'</td>';
			var total = 0;
			for(var i=0;i<questionJson.fdStatistic.items.length;i++){
				total += parseInt(questionJson.fdStatistic.items[i][parseInt(key)+1]);
			}
			for(var i=0;i<questionJson.fdStatistic.items.length;i++){
				var percentage = parseInt(questionJson.fdStatistic.items[i][parseInt(key)+1])*100/total;
				if(percentage)
					percentage = percentage.toFixed(2);
				else
					percentage = 0;
				dataAnalysisHTML += '<td align="center">'+percentage+'%<br>（'+questionJson.fdStatistic.items[i][parseInt(key)+1]+'）</td>';
			}
			dataAnalysisHTML += '</tr>';
		}
		dataAnalysisHTML += '</table>';
		return dataAnalysisHTML;
	}
	
	
	window.singlematrix=singlematrix;
	
})(window);