<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
var errorInteger = "<kmss:message key="errors.integer" />";
var errorRange = "<kmss:message key="errors.range" />";
var fieldMessages = "<bean:message bundle="sys-quartz" key="sysQuartzJob.cronExpression.fields"/>".split(",");
var isShowHelp = false;
var re_Number = /[^\d]/gi;

function showUseCache(){
	var fdUseCaches = document.getElementsByName("fdUseCache");
	var use="";
	for(var i=0;i<fdUseCaches.length;i++){
		if(fdUseCaches[i].checked){
			use = fdUseCaches[i].value;
		}
	}
	if(use=="true"){
		document.getElementById("TB_MainTable").style.display="";
	}else{
		document.getElementById("TB_MainTable").style.display="none";
	}
}

function changeInputType(value){
	if(value=="0"){
		//切换到常用编辑模式，解释CronExpression
		parseCronExpression();
	}else{
		//切换到CronExpression编辑模式，构造CronExpression，若构造失败，不切换编辑模式
		if(!buildCronExpression()){
			document.getElementsByName("fdInputType")[0].checked = true;
			return;
		}
	}
	//根据kmss_inputtype显示/隐藏相关行
	var tbObj = document.getElementById("TB_MainTable");
	for(var i=0; i<tbObj.rows.length; i++){
		var att = tbObj.rows[i].getAttribute("kmss_inputtype");
		if(att==null)
			continue;
		tbObj.rows[i].style.display = att==value?"table-row":"none";
	}
	//对隐藏的行进行调整
	if(value=="0"){
		refreshInpuType0();
	}else{
		refreshInpuType1();
	}
}

function refreshInpuType0(){
	var frequencyField = document.getElementsByName("fdFrequency")[0];
	var trObj = document.getElementById("TR_FrequencySetting");
	if(frequencyField.selectedIndex<1){
		//频率没有设置，隐藏设置栏
		trObj.style.display = "none";
		return;
	}
	trObj.style.display = "table-row";
	//调整设置项的显示
	var displayArr; //年,月,日,星期,时,分,秒,间隔
	switch(frequencyField.options[frequencyField.selectedIndex].value){
	case "once":
		displayArr = new Array("", "", "", "none", "", "", "", "none");
	break;
	case "year":
		displayArr = new Array("none", "", "", "none", "", "", "", "none");
	break;
	case "month":
		displayArr = new Array("none", "none", "", "none", "", "", "", "none");
	break;
	case "week":
		displayArr = new Array("none", "none", "none", "", "", "", "", "none");
	break;
	case "day":
		displayArr = new Array("none", "none", "none", "none", "", "", "", "none");
	break;
	case "hour":
		displayArr = new Array("none", "none", "none", "none", "none", "", "", "none");
	break;
	case "every":
		displayArr = new Array("none", "none", "none", "none", "none", "none", "", "");
	}
	var spanArr = trObj.cells[1].getElementsByTagName("SPAN");
	for(var i=0; i<spanArr.length; i++)
		spanArr[i].style.display = displayArr[i];
}
function refreshInpuType1(){
	//调整帮助栏的显示
	//var trObj = document.getElementById("TR_CronExpressionHelp");
	//trObj.style.display = isShowHelp?"block":"none";
	if(isShowHelp)
		$("#TR_CronExpressionHelp").show();
	else
		$("#TR_CronExpressionHelp").hide();
}

//构造CronExpression，并写入fdCronExpression中，返回false则表示构造失败
function buildCronExpression(){
	var frequencyField = document.getElementsByName("fdFrequency")[0];
	var expressionField = document.getElementsByName("fdCronExpression")[0];
	//若没有选择频率，不处理
	if(frequencyField.selectedIndex<1)
		return true;
	//获取所有设置项的信息
	var year = document.getElementsByName("fdYear")[0].value;
	var month = document.getElementsByName("fdMonth")[0].value;
	var day = document.getElementsByName("fdDay")[0].value;
	var week = document.getElementsByName("fdWeek")[0].options[document.getElementsByName("fdWeek")[0].selectedIndex].value;
	var hour = document.getElementsByName("fdHour")[0].value;
	var minute = document.getElementsByName("fdMinute")[0].value;
	var second = document.getElementsByName("fdSecond")[0].value;
	var every = document.getElementsByName("fdEvery")[0].options[document.getElementsByName("fdEvery")[0].selectedIndex].value;
	var frequency = frequencyField.options[frequencyField.selectedIndex].value;
	//根据频率调整参数
	switch(frequency){
	case "every":
		minute = "0/"+every;
	case "hour":
		hour = "*";
	case "day":
		day = "*";
	case "week":
	case "month":
		month = "*";
	case "year":
		year = "";
	break;
	}
	//构造CronExpression
	try{
		var expression = formatCronExpressionField(second, fieldMessages[0], 0, 59)+" ";
		if(frequency=="every")
			expression += minute+" ";
		else
			expression += formatCronExpressionField(minute, fieldMessages[1], 0, 59)+" ";
		expression += formatCronExpressionField(hour, fieldMessages[2], 0, 23)+" ";
		if(frequency=="week"){
			expression += "? ";
			expression += formatCronExpressionField(month, fieldMessages[4], 1, 12)+" ";
			expression += week;
		}else{
			expression += formatCronExpressionField(day, fieldMessages[3], 1, 31)+" ";
			expression += formatCronExpressionField(month, fieldMessages[4], 1, 12)+" ";
			expression += "?";
		}
		if(year!="")
			expression += " "+formatCronExpressionField(year, fieldMessages[6], 1970, 2099);
	}catch(e){
		//构造过程校验出错，返回false，e==""表示是formatCronExpressionField函数抛出的错误
		if(e=="")
			return false;
		throw e;
	}
	expressionField.value = expression;
	return true;
}

//整理域的信息，若校验出错，抛出""
function formatCronExpressionField(value, fieldMsg, minValue, maxValue){
	if(value=="*")
		return value;
	if(value=="")
		return minValue;
	value = parseInt(value, 10);
	if(isNaN(value)){
		alert(errorInteger.replace(/\{0\}/, fieldMsg));
		throw "";
	}
	if(value<minValue || value>maxValue){
		var msg = errorRange.replace(/\{0\}/, fieldMsg);
		msg = msg.replace(/\{1\}/, minValue);
		msg = msg.replace(/\{2\}/, maxValue);
		alert(msg);
		throw "";
	}
	if(value<minValue || value>maxValue)
		return value;
	return value;
}

//解释CronExpression，并将值写入到相关的设置项中
function parseCronExpression(){
	var expressionField = document.getElementsByName("fdCronExpression")[0];
	var expression;
	expression = expressionField.value.split(/\s+/gi);
	var data = new Array();
	var frequency = null;
	try{
		switch(expression.length){
		case 7:
			//判断年
			if(!checkCronExpressionField("year", expression[6], data, frequency))
				frequency = "once";
		case 6:
			//判断月
			if(!checkCronExpressionField("month", expression[4], data, frequency) && frequency==null)
				frequency = "year";
			//判断星期
			if(expression[5]!="?"){
				if(expression[3]!="?" || frequency!=null)
					throw "";
				if(expression[5]!="*"){
					if(re_Number.test(expression[5]))
						throw "";
					data.week = expression[5];
					frequency = "week";
				}
			}else{
			//判断日期
				if(!checkCronExpressionField("day", expression[3], data, frequency) && frequency==null)
					frequency = "month";
			}
			//判断小时
			if(!checkCronExpressionField("hour", expression[2], data, frequency) && frequency==null){
				if(data.week==null)
					frequency = "day";
				else
					frequency = "week";
			}
			//判断分
			if(expression[1]=="*")
				throw "";
			if(re_Number.test(expression[1])){
				if(frequency!=null)
					throw "";
				var tmpArr = expression[1].split("/");
				if(tmpArr.length!=2 || re_Number.test(tmpArr[0]) || re_Number.test(tmpArr[1]))
					throw "";
				data.every = tmpArr[1];
				frequency = "every";
			}else{
				if(frequency==null)
					frequency = "hour";
				data.minute = expression[1];
			}
			//判断秒
			if(checkCronExpressionField("second", expression[0], data, frequency))
				throw "";
		}
	}catch(e){
		if(e=="")
			frequency = null;
		else
			throw e;
	}
	if(frequency==null)
		data = new Array();
	else
		data.frequency = frequency;
	setCronExpressionField(data);
}

/*
校验CronExpression的域（年、月、时、秒），并把值写到data中。
返回：true（该字段未限定）false（该字段已经限定）
抛出：""，该域无法解释
*/
function checkCronExpressionField(fieldName, fieldValue, data, frequency){
	if(fieldValue=="*" || fieldValue==""){
		//若前面频率已经确定，但当前字段却没有限定，不满足常用的模式，抛出无法解释
		if(frequency!=null)
			throw "";
		return true;
	}
	if(re_Number.test(fieldValue))
		throw "";
	data[fieldName] = fieldValue;
	return false;
}

//将数据写入设置数据项中
function setCronExpressionField(data){
	document.getElementsByName("fdYear")[0].value = data.year==null?"":data.year;
	document.getElementsByName("fdMonth")[0].value = data.month==null?"":data.month;
	document.getElementsByName("fdDay")[0].value = data.day==null?"":data.day;
	setSelectFieldValue(document.getElementsByName("fdWeek")[0], data.week);
	document.getElementsByName("fdHour")[0].value = data.hour==null?0:data.hour;
	document.getElementsByName("fdMinute")[0].value = data.minute==null?0:data.minute;
	document.getElementsByName("fdSecond")[0].value = data.second==null?0:data.second;
	setSelectFieldValue(document.getElementsByName("fdEvery")[0], data.every);
	setSelectFieldValue(document.getElementsByName("fdFrequency")[0], data.frequency);
}

//设置下拉框的信息
function setSelectFieldValue(fieldObj, value){
	fieldObj.selectedIndex = 0;
	if(value==null)
		return;
	for(var i=0; i<fieldObj.options.length; i++){
		if(fieldObj.options[i].value == value){
			fieldObj.selectedIndex = i;
			return;
		}
	}
}

window.onload = function(){
	changeInputType("0");
	showUseCache();
}

function submitForm(){
	var field = document.getElementsByName("fdInputType")[0];
	if(field.checked){
		if(document.getElementsByName("fdFrequency")[0].selectedIndex<1){
			alert("<kmss:message key="errors.required" argKey0="sys-quartz:sysQuartzJob.cronExpression.frequency" />");
			return;
		}
	 	if(!buildCronExpression())
			return;
	}
	field = document.getElementsByName("fdCronExpression")[0];
	if(field.value==""){
		alert("<bean:message key="errors.required" arg0="CronExpression" />");
		return;
	}

	field = document.getElementsByName("fdSubject")[0];
	if(field.value==""){
		alert("${lfn:message('sys-quartz:sysQuartzJob.fdSubject') }");
		return;
	}

	field = document.getElementsByName("fdRunType")[0];
	if(field.value==""){
		alert("${lfn:message('sys-quartz:sysQuartzJob.fdRunType') }");
		return;
	}

	Com_Submit(document.ticCacheSyncJobForm, 'update');
}
function onRunTypeChange(){
	document.getElementsByName("fdRunServer")[0].style.display = document.getElementsByName("fdRunType")[0].value == "2"?"":"none";
}
</script>
