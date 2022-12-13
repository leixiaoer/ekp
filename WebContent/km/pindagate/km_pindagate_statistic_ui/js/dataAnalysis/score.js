/**
 * 评分题统计
 */
(function(window){
	var score={};
	
	score.init=function(questionJson){
		
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

		if(participateNumber == 0)participateNumber = 1;
		//各选项百分比
		for(var j = 1;j<questionJson.fdStatistic.options.length;j++){
			var proportion = parseInt(questionJson.fdStatistic.items[j]);
			var percentage = {to: proportion*100/participateNumber};
			var o3 = new html5jp.progress("dataAnalysis"+index+j, percentage,"#0B7ACF");
			o3.draw();
			$('#dataAnalysisTxt'+index+j).html("（"+proportion+"）");
		}
		if(questionJson.fdQuestionDef.autoAddSelectReason){
			var selectReasonDiv = '<div class="pi_otherInfo"><a href="javascript:void(0);" onclick="viewSelectReasonAnswer(\''+questionJson.questionId+'\');" style="cursor: pointer;">'+Data_GetResourceString("km-pindagate:kmPindagateResponse.view")+'“';
			selectReasonDiv += questionJson.fdQuestionDef.selectReasonText;
			selectReasonDiv += '”</a></div>';
			div.append(selectReasonDiv);
		}
	};
	
	
	/**
	 * 根据题目序号返回一个单选题表单
	 */
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
		progressHTML += '<table  class="pi_progress"><tr><td>'+Data_GetResourceString("km-pindagate:kmPindagateQuestionRes.involved")+'</td><td><div id="participate'+index+'"></div></td><td><div id="participateTxt'+index+'"></td></tr></div>';
		progressHTML += '<table  class="pi_progress"><tr><td>'+Data_GetResourceString("km-pindagate:kmPindagateQuestionRes.notInvolved")+'</td><td><div id="notInvolved'+index+'"></div></td><td><div id="notInvolvedTxt'+index+'"></td></tr></div>';
		if(questionJson.fdQuestionDef.showAverage){
			var participateNumber =questionJson.fdStatistic.participateNumber,
			sItems=questionJson.fdStatistic.items,qItems=questionJson.fdQuestionDef.items,sum=0,average=0;
			if(participateNumber!=0)
			   for(var i=1,j=0;i<sItems.length,j<qItems.length;i++,j++){
				  sum +=sItems[i] * qItems[j].slice(-1)[0];
			   }
			average =parseFloat(sum/participateNumber).toFixed(1);
		    progressHTML += '<table  class="pi_progress"><tr><td>'+Data_GetResourceString("km-pindagate:kmPindagateQuestionRes.average")+'</td><td><div id="average'+index+'"></div></td><td>&nbsp'+ average+'</td></tr></div>';
	    }
		progressHTML += '</td></tr>';
		return progressHTML;
	}
	
	function getDataAnalysisHTML(questionJson){
		var index=questionJson.index;
		var dataAnalysisHTML = '<table class="pi_progress">';
		for(var i = 1;i<questionJson.fdStatistic.options.length;i++){
			dataAnalysisHTML += '<tr><td>'+questionJson.fdStatistic.options[i]+'</td><td><div id="dataAnalysis'+index+i+'"></div></td><td><div id="dataAnalysisTxt'+index+i+'"></div></td></tr>';
		}
		dataAnalysisHTML += '</table>';
		return dataAnalysisHTML;
	}
	
	window.score=score;
	
})(window);