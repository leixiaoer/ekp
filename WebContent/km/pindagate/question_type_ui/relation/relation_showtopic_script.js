Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/relation/relation_showtopic_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");

/********************************************
 * 关联题型显示
 * 关系类型：  relationFlag(0:且关系、1：或关系，PS:可以为空)
 * 选项类型：  relationOpt(1：已选择、2：未选择）
 * 多选题一个或全部 relationSel：（1：其中一个、2：全部选项,PS:为空表示单选）
 * 是否提交表单数据标记  fdValEpSign（true:提交、false：不提交）
 ********************************************/
function showTopic(index,type){
	 var relationShow=$("input[id='fdRelationCheck']").val(),
	 	anserVal=$("input[name='fdItems["+index+"].fdAnswer']").val();
	if (relationShow) {
		relationShow=JSON.parse(relationShow);
		for ( var f in relationShow) {
			var singleVal=relationShow[f];
			single=JSON.parse(singleVal);
			var sign="",
				idIndex,
				valEpSign="",
				ids={},
				id;
			for ( var g in single) {
				if (single[g].relationFlag=="0"&&sign=="false") {
					continue;
				}
				if (single[g].sign=="false") {
					continue;
				}
				var optItem=single[g].relationItem;
				fdTypeVal=$("input[id='fdType"+single[g].showTopic+"']").val();
				anserVal = $("input[name='fdItems["+single[g].topic+"].fdAnswer']").val();
				
				
				//判断关系类型：  relationFlag(0:且关系、1：或关系，PS:可以为空)
				if (single[g].relationFlag||single[g].relationFlag=="") {
					var optItemSize = optItem.length;
					//或关系
					if (single[g].relationFlag=="1"||single[g].relationFlag=="") {
						if (sign=="true") {
							continue;
						}
						//选项类型：  relationOpt(1：已选择、2：未选择）或关系
						if (single[g].relationOpt=="1"||single[g].relationOpt==""||single[g].relationOpt==undefined) {
							if (single[g].relationSel=="1"||single[g].relationSel=="") {
								if (anserVal) {
									anserVal=anserVal.split(";");
								}
								for (var p = 0; p < anserVal.length; p++) {
									if (sign=="true") {
										continue;
									}
									if (optItem.indexOf(anserVal[p])>-1) {
										sign="true";
									}else{
										sign="false";
									}
								}
							}
							
							//多选题一个或全部 relationSel：（1：其中一个、2：全部选项,PS:为空表示单选）
							if (single[g].relationSel=="2") {
								var countAnser="0";
								for (var x = 0; x < anserVal.length; x++) {
									if (optItem.indexOf(anserVal[x])>-1) {
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
						}else if(single[g].relationOpt=="2"){
							if (anserVal) {
								anserVal=anserVal.split(";");
							}
							var sign2='';
							if (single[g].relationSel=="1") {
								for (var p = 0; p < anserVal.length; p++) {
									if (optItem.indexOf(anserVal[p])>-1) {
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
							if (single[g].relationSel=="2") {
								var countAnser="0";
								for (var x = 0; x < anserVal.length; x++) {
									if (optItem.indexOf(anserVal[x])>-1) {
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
					//判断关系类型：  relationFlag(0:且关系、1：或关系，PS:可以为空)
					}else if(single[g].relationFlag=="0"||single[g].relationFlag==""){
						//且关系
						if (sign=="false") {
							continue;
						}
						//选项类型：  relationOpt(1：已选择、2：未选择）
						if (single[g].relationOpt=="1"||single[g].relationOpt==""||single[g].relationOpt==undefined) {
							if (single[g].relationSel=="1"||single[g].relationSel=="") {
								if (anserVal) {
									anserVal=anserVal.split(";");
								}
								var sign2='';
								for (var p = 0; p < anserVal.length; p++) {
									if (optItem.indexOf(anserVal[p])>-1) {
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
							//多选题一个或全部 relationSel：（1：其中一个、2：全部选项,PS:为空表示单选）
							if (single[g].relationSel=="2") {
								var countAnser="0";
								for (var x = 0; x < anserVal.length; x++) {
									if (optItem.indexOf(anserVal[x])>-1) {
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
							if (single[g].relationSel=="1") {
								for (var x = 0; x < anserVal.length; x++) {
									if (sign=="false") {
										continue;
									}
									if (optItem.indexOf(anserVal[x])>-1) {
										sign="false";
									}else{
										sign="true";
									}
								}
								/*if (optItem.indexOf(anserVal)>-1) {
									sign="false";
								}else{
									sign="true";
								}*/
							}
							//多选题一个或全部 relationSel：（1：其中一个、2：全部选项,PS:为空表示单选）
							if (single[g].relationSel=="2") {
								var countAnser="0";
								for (var x = 0; x < anserVal.length; x++) {
									if (optItem.indexOf(anserVal[x])>-1) {
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
					if (single[g].relationSel=="1"||single[g].relationSel=="") {
						if (optItem.indexOf(anserVal)>-1) {
							sign="true";
						}else{
							sign="false";
						}
						for (var x = 0; x < anserVal.length; x++) {
							if (sign=="true") {
								continue;
							}
							if (anserVal[x]==";") {
								continue;
							}
							if (optItem.indexOf(anserVal[x])>-1) {
								sign="true";
							}else{
								sign="false";
							}
						}
					}
					if (single[g].relationSel=="2") {
						var countAnser="0";
						for (var x = 0; x < anserVal.length; x++) {
							if (optItem.indexOf(anserVal[x])>-1) {
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
				id='#'+fdTypeVal+single[g].showTopic;
				idIndex=single[g].showTopic;
				if (anserVal==""||anserVal==null) {
					id='#'+fdTypeVal+single[g].showTopic;
					$(id).css('display','none');
					sign="false";
					continue;
				}
			}
			
			var validateResult="";
			if (sign=="true") {
				$(id).css('display','block');
				$("input[name='fdItems["+idIndex+"].fdRelationHide']").val("");
				//增加必填校验
				validateResult = {canSave:false,
						message:Question_Type_Lang.Common.prePix + $('#serialNum'+idIndex).val()
						+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
				$("input[id='validateResult"+idIndex+"']").val(JSON.stringify(validateResult));
				$('input[id="hasAnswer'+idIndex+'"]').val("false");
			}else if(sign=="false"){
				$(id).css('display','none');
				$("input[name='fdItems["+idIndex+"].fdRelationHide']").val("1");
				//去除必填校验 validateResult5
				
				validateResult = {canSave:true,message:""};
				$("input[id='validateResult"+idIndex+"']").val(JSON.stringify(validateResult));
				$('[name="option'+idIndex+'"]').prop("checked",false);
				$("input[name='fdItems["+idIndex+"].fdAnswer']").val("");
				$("input[name='fdItems["+idIndex+"].fdAnswerTxt']").val("");
				//清楚文本域内容
				$("textarea[name='fdItems["+idIndex+"].fdAnswer']").val("");		
				$('input[id="hasAnswer'+idIndex+'"]').val("true");
			}			
			anserVal = $("input[name='fdItems["+idIndex+"].fdAnswer']").val();
			if (anserVal!=null&&anserVal!="") {
				validateResult = {canSave:true,message:""};
				$("input[id='validateResult"+idIndex+"']").val(JSON.stringify(validateResult));
				$('input[id="hasAnswer'+idIndex+'"]').val("true"); 
			}
		}
	}
	caculateProgress();
};