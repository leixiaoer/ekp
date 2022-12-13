/********************************************
 * 关联题型显示
 * 关系类型：  flagRelation(0:且关系、1：或关系，PS:可以为空)
 * 选项类型：  opt(1：已选择、2：未选择）
 * 多选题一个或全部 multiseSel：（1：其中一个、2：全部选项,PS:为空表示单选）
 ********************************************/
function select_change(index) {
	var answerVal = "";
	$("[name=option" + index + "]:checked").each(function() {
		answerVal += ";" + this.value;
	});
	if(answerVal.length>0)
		answerVal = answerVal.substring(1);
	$("input[id='fdAnswer"+ index + "']").val(answerVal);
	for (var idx = 0 in window.questions) {
		var relationDef = window.questions[idx].fdRelationDef;
		if (!relationDef || relationDef.length < 1) {
			continue;
		}
		if (typeof (relationDef) != "object") {
			relationDef = JSON.parse(relationDef);
		}
		if (relationDef) {                
			var sign="",fdTypeVal="",id;
			for ( var g in relationDef) {
				if (relationDef[g].flagRelation=="0"&&sign=="false") {
					continue;
				}
				if (relationDef[g].sign=="false") {
					continue;
				}
				var optItem=relationDef[g].itemVals;
				fdTypeVal=$("input[id='fdType"+relationDef[g].currentTopic+"']").val();
				answerVal = $("input[id='fdAnswer"+ relationDef[g].topic + "']").val();
				
				
				//判断关系类型：  flagRelation(0:且关系、1：或关系，PS:可以为空)
				if (relationDef[g].flagRelation||relationDef[g].flagRelation=="") {
					var optItemSize = optItem.length;
					//或关系
					if (relationDef[g].flagRelation=="1"||relationDef[g].flagRelation=="") {
						if (sign=="true") {
							continue;
						}
						//选项类型：  opt(1：已选择、2：未选择）或关系
						if (relationDef[g].opt=="1"||relationDef[g].opt==""||relationDef[g].opt==undefined) {
							if (relationDef[g].multiseSel=="1"||relationDef[g].multiseSel=="") {
								if (answerVal) {
									answerVal=answerVal.split(";");
								}
								for (var p = 0; p < answerVal.length; p++) {
									if (sign=="true") {
										continue;
									}
									if (optItem.indexOf(answerVal[p])>-1) {
										sign="true";
									}else{
										sign="false";
									}
								}
							}
							
							//多选题一个或全部 multiseSel：（1：其中一个、2：全部选项,PS:为空表示单选）
							if (relationDef[g].multiseSel=="2") {
								var countAnser="0";
								for (var x = 0; x < answerVal.length; x++) {
									if (optItem.indexOf(answerVal[x])>-1) {
										sign="true";
										countAnser++;
									}
								}
								if (countAnser>=optItemSize) {
									sign="true";
								}else{
									sign="false";
								}
							}
							//未选择或关系
						}else if(relationDef[g].opt=="2"){
							if (answerVal) {
								answerVal=answerVal.split(";");
							}
							var sign2='';
							if (relationDef[g].multiseSel=="1") {
								for (var p = 0; p < answerVal.length; p++) {
									if (optItem.indexOf(answerVal[p])>-1) {
										sign="false";
										sign2="false";
									}else{
										sign="true";
									}
								}
							}
							if (sign2) {
								sign="false";
							}
							if (relationDef[g].multiseSel=="2") {
								var countAnser="0";
								for (var x = 0; x < answerVal.length; x++) {
									if (optItem.indexOf(answerVal[x])>-1) {
										sign="false";
										countAnser++;
									}
								}
								if (countAnser>=optItemSize) {
									sign="false";
								}else{
									sign="true";
								}
							}
						}
					//判断关系类型：  flagRelation(0:且关系、1：或关系，PS:可以为空)
					}else if(relationDef[g].flagRelation=="0"||relationDef[g].flagRelation==""){
						//且关系
						if (sign=="false") {
							continue;
						}
						//选项类型：  opt(1：已选择、2：未选择）
						if (relationDef[g].opt=="1"||relationDef[g].opt==""||relationDef[g].opt==undefined) {
							if (relationDef[g].multiseSel=="1"||relationDef[g].multiseSel=="") {
								if (answerVal) {
									answerVal=answerVal.split(";");
								}
								var sign2='';
								for (var p = 0; p < answerVal.length; p++) {
									if (optItem.indexOf(answerVal[p])>-1) {
										sign="true";
										sign2="true";
									}else{
										sign="false";
									}
								}
								if (sign2) {
									sign="true";
								}
								
							}
							//多选题一个或全部 multiseSel：（1：其中一个、2：全部选项,PS:为空表示单选）
							if (relationDef[g].multiseSel=="2") {
								var countAnser="0";
								for (var x = 0; x < answerVal.length; x++) {
									if (optItem.indexOf(answerVal[x])>-1) {
										sign="true";
										countAnser++;
									}
								}
								if (countAnser>=optItemSize) {
									sign="true";
								}else{
									sign="false";
								}
							}
						}else{
							if (relationDef[g].multiseSel=="1") {
								for (var x = 0; x < answerVal.length; x++) {
									if (sign=="false") {
										continue;
									}
									if (optItem.indexOf(answerVal[x])>-1) {
										sign="false";
									}else{
										sign="true";
									}
								}
							}
							//多选题一个或全部 multiseSel：（1：其中一个、2：全部选项,PS:为空表示单选）
							if (relationDef[g].multiseSel=="2") {
								var countAnser="0";
								for (var x = 0; x < answerVal.length; x++) {
									if (optItem.indexOf(answerVal[x])>-1) {
										sign="false";
										countAnser++;
									}
								}
								if (countAnser>=optItemSize) {
									sign="false";
								}else{
									sign="true";
								}
							}
							
						}
					}
				}else{
					if (relationDef[g].multiseSel=="1"||relationDef[g].multiseSel=="") {
						if (optItem.indexOf(answerVal)>-1) {
							sign="true";
						}else{
							sign="false";
						}
						for (var x = 0; x < answerVal.length; x++) {
							if (sign=="true") {
								continue;
							}
							if (answerVal[x]==";") {
								continue;
							}
							if (optItem.indexOf(answerVal[x])>-1) {
								sign="true";
							}else{
								sign="false";
							}
						}
					}
					if (relationDef[g].multiseSel=="2") {
						var countAnser="0";
						for (var x = 0; x < answerVal.length; x++) {
							if (optItem.indexOf(answerVal[x])>-1) {
								sign="true";
								countAnser++;
							}
						}
						if (countAnser>=optItemSize) {
							sign="true";
						}else{
							sign="false";
						}
					}
				}
				id='#'+fdTypeVal+relationDef[g].currentTopic;
				if (answerVal==""||answerVal==null) {
					id='#'+fdTypeVal+relationDef[g].currentTopic;
					$(id).css('display','none');
					sign="false";
					continue;
				}
			}
			if (sign=="true") {
				$(id).css('display','block');
			}else if(sign=="false"){
				$(id).css('display','none');
			}			
		}
	}
}
