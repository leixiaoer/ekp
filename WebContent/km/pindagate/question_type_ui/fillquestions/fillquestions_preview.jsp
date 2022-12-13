<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@include file="/km/pindagate/question_type_ui/common/common_preview_script.jsp"%>
<script>
var _dialog;
seajs.use(['lui/dialog'], function(dialog){
	_dialog=dialog;
});
var fillquestions_fdQuestionDef = null;
function autoResize(obj){
	obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
}
function fillquestions_init(index){
	var divId = "${JsParam.divId}";
	if($('#fdQuestionDef'+index).val() == null || $('#fdQuestionDef'+index).val() == "" || $('#fdQuestionDef'+index).val() == "delete")
		return;
	fillquestions_fdQuestionDef = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(fillquestions_getTableHTML(index));
}
function fillquestions_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=95% id="fillquestions_TB'+index+'">';
	tableHTML += '<tr class="options"><td><p name="tip" style="display:none;position:relative;color:red;">';
	tableHTML += '<a onclick="fillquestions_edit('+index+');" style="position:absolute;top: 0px;right: 50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
	tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;top: 0px;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
	tableHTML += fillquestions_getTitleHTML(index);
	//---
	var contnetHTML='</td></tr><tr><td>';
			//整数
			if (fillquestions_fdQuestionDef.questionsSel=="1") {
				if (fillquestions_fdQuestionDef.range==true) {
					contnetHTML+='<input type="number" name="integerDef'+index+'" id="integerDef'+index+'"> <span style="color:red;"id="msgWarn'+index+'"></span>';
				}else{
					contnetHTML+='<input type="number" name="integerDef'+index+'" id="integerDef'+index+'">';
				}
			}
			//小数
			if (fillquestions_fdQuestionDef.questionsSel=="2") {
				if (fillquestions_fdQuestionDef.range==true) {
					contnetHTML+='<input type="number" name="integerDef'+index+'" id="integerDef'+index+'"> <p style="color:red;"id="msgWarn'+index+'"></p>';
				}else{
					contnetHTML+='<input type="number" name="integerDef'+index+'" id="integerDef'+index+'">';
				}
			}
			//日期
			if (fillquestions_fdQuestionDef.questionsSel=="3") {
				if (fillquestions_fdQuestionDef.dataSel=="1") {//日期
					contnetHTML+='<input id="date'+index+'" type="date"/>';
				}
				if (fillquestions_fdQuestionDef.dataSel=="2") {//时间
					contnetHTML+='<input id="time'+index+'" type="time" />';
				}
				if (fillquestions_fdQuestionDef.dataSel=="3") {//日期时间
					contnetHTML+='<input id="dateTime'+index+'" type="datetime-local" />';
				}
			}
			
			//手机
			if (fillquestions_fdQuestionDef.questionsSel=="4") {
				contnetHTML+='<input type="text" id="iphone'+index+'" /> <p style="color:red;"id="msgWarn'+index+'"></p>';
			}
			//邮箱
			if (fillquestions_fdQuestionDef.questionsSel=="5") {
				contnetHTML+='<input type="text" id="email'+index+'" /> <p style="color:red;"id="msgWarn'+index+'"></p>';
			}
			//省市区
			if (fillquestions_fdQuestionDef.questionsSel=="6") {
				contnetHTML+='<select id="prov'+index+'" onchange="showCity(this,'+index+')"><option value="-1">=请选择省份=</option></select><select id="city'+index+'" onchange="showCountry(this,'+index+')"><option value="-1">=请选择城市=</option>'; 
				contnetHTML+='</select><select onchange="showRegion('+index+')" id="country'+index+'"><option value="-1">=请选择县区=</option></select>'; 
			}
			//身份证
			if (fillquestions_fdQuestionDef.questionsSel=="7") {
				contnetHTML+='<input type="text" id="id'+index+'"/> <p style="color:red;"id="msgWarn'+index+'"></p>';
			}
			//中文
			if (fillquestions_fdQuestionDef.questionsSel=="8") {
				if (fillquestions_fdQuestionDef.strDefVal==true) {
					contnetHTML+='<input type="text" name="chinesWord'+index+'" id="chinesWord'+index+'" onBlur="chinesWordWarn('+index+')" > <p style="color:red;"id="msgWarn'+index+'"></p>';
				}else{
					contnetHTML+='<input type="text" name="chinesWord'+index+'" id="chinesWord'+index+'">';
				}
			}
			//英文
			if (fillquestions_fdQuestionDef.questionsSel=="9") {
				if (fillquestions_fdQuestionDef.strDefVal==true) {
					contnetHTML+='<input type="text" name="english'+index+'" id="english'+index+'" onBlur="englishWarn('+index+')" > <p style="color:red;"id="msgWarn'+index+'"></p>';
				}else{
					contnetHTML+='<input type="text" name="english'+index+'" id="english'+index+'">';
				}
			}
			if (fillquestions_fdQuestionDef.questionsSel==null) {
				contnetHTML+='<input type="text" name="def'+index+'" onBlur="defMsg('+index+')"  id="def'+index+'">';
			}
			contnetHTML+='</td></td></tr>';
			tableHTML += contnetHTML;
	tableHTML += '<table>';
	return tableHTML;
}
function fillquestions_getTitleHTML(index,showIndex){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	showIndex = showIndex ||'${JsParam.showIndex}';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+showIndex+'、</div>';
	var title = fillquestions_fdQuestionDef.subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content" id="fdTitle'+index+'" name="fdTitle'+index+'" onclick="modifyTitleVal(this);">'+title+'</div>';
	if(fillquestions_fdQuestionDef.willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(fillquestions_fdQuestionDef.willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '[<bean:message bundle="km-pindagate" key="kmPindagateQuestion.flag.willAnswer"/>]</span>';
	}
	titleHTML += '</td></tr>';
	if(fillquestions_fdQuestionDef.attachmentIds != 'null' && fillquestions_fdQuestionDef.attachmentIds != ''){
		var atturl = "<c:url value='/km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+fillquestions_fdQuestionDef.attachmentIds+"'  />";
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(fillquestions_fdQuestionDef.tip != ''){
		var tip=fillquestions_fdQuestionDef.tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>'+'<div class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
/**
* 编辑
*/
function fillquestions_edit(index){
	var obj = document.getElementById('fdQuestionDef'+index);
	var url ="/km/pindagate/question_type_ui/fillquestions/fillquestions_edit.jsp";
	if(obj==null) obj="";
	top._question=obj;
	_dialog.iframe(url," ",function(obj){
		if(obj!=null&&obj.value != null && obj.value != ""){
			fillquestions_fdQuestionDef = eval("("+(obj.value)+")");
			var tableHTML = '<tr class="options"><td><p class="pi_txtRed" name="tip" style="display:none;position:relative;">';
			tableHTML += '<a onclick="fillquestions_edit('+index+');" style="position:absolute;right:50px;cursor: pointer;color:red;"><bean:message key="button.edit"/></a>';
			tableHTML += '<a onclick="deleteQuestion('+index+');" style="position:absolute;right: 0px;cursor: pointer;color:red;"><bean:message key="button.delete"/></a></p></td></tr>';
			tableHTML += fillquestions_getTitleHTML(index,index + 1);
			var textHeight = fillquestions_fdQuestionDef.inputHeight*16;//一行为16像素
			tableHTML += '</td></tr><tr><td  align="left" id="fillquestions'+index+'"><textarea style="width:500px;height:'+textHeight+'px"></textarea></td></tr>';
			$('#fillquestions_TB'+index).html(tableHTML);
			var title = fillquestions_fdQuestionDef.subject;
			title = title.replace("<p>", "");
			title = title.replace("</p>", "");
			//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');		
			$('span[name=fdTitle'+index+']').html(title);
			setFdQuestionDef(fillquestions_fdQuestionDef,index);//更新题型定义的值
		}
	},{"width":800,"height":500});
}
fillquestions_init('${JsParam.index}');
</script>
