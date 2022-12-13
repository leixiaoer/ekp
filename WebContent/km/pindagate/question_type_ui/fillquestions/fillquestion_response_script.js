Response_RegisterJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/fillquestions/fillquestions_response_script.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type_ui/fillquestions/city.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type_ui/fillquestions/method_response.js");
Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type/question_type_lang.js");


/*******************************************
 * 填空题初始化
 *******************************************/
function fillquestions_init(index,divId){
	fdQuestionDef[index] = eval("("+($('#fdQuestionDef'+index).val())+")");
	$('#'+divId).append(fillquestions_getTableHTML(index));
	var msg='';
	var method_GET=$("input[name='method_GET']").val();
	//如果为必选题，则设置一个validateResult隐藏域，值为{canSave:true|false,message:""}格式
	if(fdQuestionDef[index].willAnswer){
		var validateResult;
		var relationHide=$("input[name='fdItems["+index+"].fdDraftRelHide']").val();
		if (relationHide=="1") {
			validateResult = {canSave:true,message:""};
			$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult))
			.appendTo($('#'+divId));
			$('<input type="hidden" name="hasAnswer" id="hasAnswer'+index+'">').val("true").appendTo($('#'+divId));
		}else{
			validateResult = {canSave:false,
					message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
					+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
			$('<input type="hidden" name="validateResult" id="validateResult'+index+'">').val(JSON.stringify(validateResult))
					.appendTo($('#'+divId));
			$('<input type="hidden" name="hasAnswer" id="hasAnswer'+index+'">').val("false").appendTo($('#'+divId));
		}
	}
	
	
	if (method_GET=="add") {
		//校验
		var prov = $('#prov'+index);
		var city = $('#city'+index);
		var country = $('#country'+index);
		var len = provice.length;
	    for (var i = 0; i < len; i++) {
	        var provOpt = document.createElement('option');
	        provOpt.innerText = provice[i]['name'];
	        provOpt.value = i;
	        prov.append(provOpt);
	    }
	    
	    //整数or小数
	    if (fdQuestionDef[index].questionsSel=="1"||fdQuestionDef[index].questionsSel=="2") {
	    	if (fdQuestionDef[index].defVal==true) {
	    		$('#integerDef'+index).val(fdQuestionDef[index].integerDef);
	    		$("input[name='fdItems["+index+"].fdAnswerTxt']").val(fdQuestionDef[index].integerDef);	
	    		$("input[name='fdItems["+index+"].fdAnswer']").val(fdQuestionDef[index].integerDef);	
	    		validateResult = {canSave:true,message:""};
	    		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	    		$('input[id="hasAnswer'+index+'"]').val(true);
			}
	    	
	    	$("input[id='integerDef"+index+"']").blur(function(){
	    		var key="input[id='integerDef"+index+"']";
	    		blurEvent(index,key);
	    	});
	    	
	    	msg="integerDef";
		}
	  //省市区
	    if (fdQuestionDef[index].questionsSel=="6") {
			if (fdQuestionDef[index].cityVal==true) {
				showAddress(fdQuestionDef[index].prov,fdQuestionDef[index].city,index);
				$("#prov"+index).val(fdQuestionDef[index].prov);
				$("#city"+index).val(fdQuestionDef[index].city);
				$("#country"+index).val(fdQuestionDef[index].country);
				//
				cityTxtVal=fdQuestionDef[index].provTxt+";"+fdQuestionDef[index].cityTxt+";"+fdQuestionDef[index].countryTxt;
				cityVal=fdQuestionDef[index].prov+";"+fdQuestionDef[index].city+";"+fdQuestionDef[index].country;
				$("input[name='fdItems["+index+"].fdAnswerTxt']").val(cityTxtVal);	
	    		$("input[name='fdItems["+index+"].fdAnswer']").val(cityVal);	
	    		validateResult = {canSave:true,message:""};
	    		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	    		$('input[id="hasAnswer'+index+'"]').val(true);
			}
		}
	    //中文
	    if (fdQuestionDef[index].questionsSel=="8") {
	    	if (fdQuestionDef[index].strDefVal==true) {
	    		$('#chinesWord'+index).val(fdQuestionDef[index].strDefVal);
	    		$("input[name='fdItems["+index+"].fdAnswerTxt']").val(fdQuestionDef[index].strDefVal);	
	    		$("input[name='fdItems["+index+"].fdAnswer']").val(fdQuestionDef[index].strDefVal);	
	    		validateResult = {canSave:true,message:""};
	    		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	    		$('input[id="hasAnswer'+index+'"]').val(true);
	    	}
	    	msg="chinesWord";
	    }
	    //英文
	    if (fdQuestionDef[index].questionsSel=="9") {
	    	if (fdQuestionDef[index].strDefVal==true) {
	    		$('#english'+index).val(fdQuestionDef[index].strValDef);
	    		$("input[name='fdItems["+index+"].fdAnswerTxt']").val(fdQuestionDef[index].strValDef);	
	    		$("input[name='fdItems["+index+"].fdAnswer']").val(fdQuestionDef[index].strValDef);	
	    		validateResult = {canSave:true,message:""};
	    		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	    		$('input[id="hasAnswer'+index+'"]').val(true);
	    	}
	    	msg="english";
	    }
	}
	
	if (method_GET=="edit") {
		//整数or小数
	    if (fdQuestionDef[index].questionsSel=="1"||fdQuestionDef[index].questionsSel=="2") {
	    	$("input[id='integerDef"+index+"']").blur(function(){
	    		var key="input[id='integerDef"+index+"']";
	    		blurEvent(index,key,"integerDef");
	    	});
	    	msg="integerDef";
	    }
	}
	
	
   
    //日期
	if (fdQuestionDef[index].questionsSel=="3") {
		if (fdQuestionDef[index].dataSel=="1") {//日期
			$("input[id='date"+index+"']").blur(function(){
	    		var key="input[id='date"+index+"']";
	    		blurEvent(index,key,"date");
	    	});
			msg="date";
		}
		if (fdQuestionDef[index].dataSel=="2") {//时间
			$("input[id='time"+index+"']").blur(function(){
	    		var key="input[id='time"+index+"']";
	    		blurEvent(index,key,"time");
	    	});
			msg="time";
		}
		if (fdQuestionDef[index].dataSel=="3") {//日期时间
			$("input[id='dateTime"+index+"']").blur(function(){
	    		var key="input[id='dateTime"+index+"']";
	    		blurEvent(index,key,"dateTime");
	    	});
			msg="dateTime";
		}
	}
	//手机
	if (fdQuestionDef[index].questionsSel=="4") {
		$("input[id='iphone"+index+"']").blur(function(){
    		var key="input[id='iphone"+index+"']";
    		blurEvent(index,key,"iphone");
    	});
		msg="iphone";
	}
	//邮箱
	if (fdQuestionDef[index].questionsSel=="5") {
		$("input[id='email"+index+"']").blur(function(){
    		var key="input[id='email"+index+"']";
    		blurEvent(index,key,"email");
    	});
		msg="email";
	}
	//省市区
	if (fdQuestionDef[index].questionsSel=="6") {
		$("select[id='country"+index+"']").blur(function(){
    		blurCity(index);
    	});
	}
	//身份证
	if (fdQuestionDef[index].questionsSel=="7") {
		$("input[id='id"+index+"']").blur(function(){
			var key="input[id='id"+index+"']";
    		blurEvent(index,key,"id");
    	});
		msg="id";
	}
    //中文
    if (fdQuestionDef[index].questionsSel=="8") {
    	if (fdQuestionDef[index].strDefVal==true) {
    		$('#chinesWord'+index).val(fdQuestionDef[index].strValDef);
    	}
    	
    	$("input[id='chinesWord"+index+"']").blur(function(){
			var key="input[id='chinesWord"+index+"']";
    		blurEvent(index,key,"chinesWord");
    	});
    	msg="chinesWord";
    }
    //英文
    if (fdQuestionDef[index].questionsSel=="9") {
    	if (fdQuestionDef[index].strDefVal==true) {
    		$('#english'+index).val(fdQuestionDef[index].strValDef);
    	}
    	
    	$("input[id='english"+index+"']").blur(function(){
			var key="input[id='english"+index+"']";
    		blurEvent(index,key,"english");
    	});
    	msg="english";
    }
    if (fdQuestionDef[index].questionsSel==null) {
    	$("input[id='def"+index+"']").blur(function(){
			var key="input[id='def"+index+"']";
    		blurEvent(index,key,"def");
    	});
    	msg="def";
	}
	
	msgValContinue(msg,index);
	if (fdQuestionDef[index].questionsSel=="6") {
		if (method_GET=="edit") {
			//省市区
			answer=$("input[name='fdItems["+index+"].fdAnswer']").val();	
			if (answer) {
				answer=answer.split(";");
				showAddress(answer[0],answer[1],index);
				$("#prov"+index).val(answer[0]);
				$("#city"+index).val(answer[1]);
				$("#country"+index).val(answer[2]);
				//
				cityTxtVal=fdQuestionDef[index].provTxt+";"+fdQuestionDef[index].cityTxt+";"+fdQuestionDef[index].countryTxt;
				cityVal=fdQuestionDef[index].prov+";"+fdQuestionDef[index].city+";"+fdQuestionDef[index].country;
				$("input[name='fdItems["+index+"].fdAnswerTxt']").val(cityTxtVal);	
				$("input[name='fdItems["+index+"].fdAnswer']").val(cityVal);	
				validateResult = {canSave:true,message:""};
				$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
				$('input[id="hasAnswer'+index+'"]').val(true);
			}else{
				showProv(index);
			}
		}
	}
	caculateProgress();//重新计算进度条
	
}
/*********************************************
 * 省市区数据获取
 **********************************************/
function blurCity(index){
	var anserTxt='',
		anser='';
	var prov=$("#prov"+index+" option:selected");
	var city=$("#city"+index+" option:selected");
	var country=$("#country"+index+" option:selected");
	anserTxt=anserTxt+prov.text()+";";
	anserTxt=anserTxt+city.text()+";";
	anserTxt=anserTxt+country.text();
	//number
	anser=anser+prov.val()+";";
	anser=anser+city.val()+";";
	anser=anser+country.val();
	
	
	if(anser == null || anser == ""){
		validateResult = {canSave:false,
				message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
				+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
		hasAnwser="false";
	}else{
		validateResult = {canSave:true,message:""};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
		$("input[name='fdItems["+index+"].fdAnswerTxt']").val(anserTxt);
		$("input[name='fdItems["+index+"].fdAnswer']").val(anser);
		hasAnwser="true";
	}
	$('input[id="hasAnswer'+index+'"]').val(hasAnwser);
	caculateProgress();//重新计算进度条
}

function msgValContinue(msgValId,index){
	//设置一个hasAnswer隐藏域，值为true(已答)|false(未答)
	var answer = $("input[name='fdItems["+index+"].fdDraftAnswer']").val();
	if(answer!=null&&answer != ""){
		$("input[id='"+msgValId+""+index+"']").val(answer);	
		$("input[name='fdItems["+index+"].fdAnswerTxt']").val(answer);	
		$("input[name='fdItems["+index+"].fdAnswer']").val(answer);	
		validateResult = {canSave:true,message:""};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
		$('input[id="hasAnswer'+index+'"]').val(true);
	}	
}
function blurEvent(index,key,msgValId){
	var hasAnwser="true",
		val=$(key).val();
	if(val == null || val == ""){
		validateResult = {canSave:false,
				message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
				+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
		hasAnwser="false";
		$("input[name='fdItems["+index+"].fdAnswerTxt']").val("");
		$("input[name='fdItems["+index+"].fdAnswer']").val("");
	}else{
		if (fdQuestionDef[index].questionsSel=="1") {
			checkNumberWarn(index);
		}else if(fdQuestionDef[index].questionsSel=="2"){
			checkDoubleWarn(index);
		}else if(fdQuestionDef[index].questionsSel=="4"){
			checkIphone(index);
		}else if(fdQuestionDef[index].questionsSel=="5"){
			checkEmail(index);
		}else if(fdQuestionDef[index].questionsSel=="7"){
			checkId(index);
		}else if(fdQuestionDef[index].questionsSel=="8"){
			 chinesWordWarn(index);
		}else if(fdQuestionDef[index].questionsSel=="9"){
			englishWarn(index);
		}else{
			validateResult = {canSave:true,message:""};
			$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
			$("input[name='fdItems["+index+"].fdAnswerTxt']").val(val);
			$("input[name='fdItems["+index+"].fdAnswer']").val(val);
			hasAnwser="true";
		}
	}
	$('input[id="hasAnswer'+index+'"]').val(hasAnwser);
	caculateProgress();//重新计算进度条
	
	
}

function validateFalse(index,msg){
	validateResult = {canSave:false,
			message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()+Question_Type_Lang.Common.questionItem
			+msg};
	$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	$('#hasAnswer'+index+'').val("false");
}

function validateTrue(index,val){
	validateResult = {canSave:true,message:""};
	$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	$('#hasAnswer'+index+'').val("true");
	

	$("input[name='fdItems["+index+"].fdAnswerTxt']").val(val);
	$("input[name='fdItems["+index+"].fdAnswer']").val(val);
}

/*********************************************
 * 校验数字整数
 **********************************************/
function checkNumberWarn(index){
	var intVal=$('#integerDef'+index).val();
	var rex=/^-?\d+$/;
	if(!rex.test(intVal)){
		msg="只能输入整数,请重新输入!";
		$('#msgWarn'+index).html(msg);
		validateFalse(index,msg);
		return;
	}else{
		$('#msgWarn'+index).html('');
		validateTrue(index,intVal);
	}
	if (fdQuestionDef[index].range==true) {
		max=fdQuestionDef[index].max;
		min=fdQuestionDef[index].min;
		if (parseInt(intVal)>parseInt(max)||parseInt(intVal)<parseInt(min)) {
			msg="数字: "+intVal+' 不能大于: '+max+" 小于: "+min;
			$('#msgWarn'+index).html(msg);
			validateFalse(index,msg);
		}else{
			$('#msgWarn'+index).html('');
			validateTrue(index,intVal);
		}
	}
}
/*********************************************
 * 校验数字小数
 **********************************************/
function checkDoubleWarn(index){
	var intVal=$('#integerDef'+index).val()
	var rex=/^(([^0][0-9]{0,9999}|0)\.([0-9]{1,2}))$/;
	if(!rex.test(intVal)){
		msg="只能输入最多保留两位小数,请重新输入!";
		$('#msgWarn'+index).html(msg);
		validateFalse(index,msg);
		 return;
	 }else{
		 $('#msgWarn'+index).html('');
		validateTrue(index,intVal);
	 }
	if (fdQuestionDef[index].range==true) {
		max=fdQuestionDef[index].max;
		min=fdQuestionDef[index].min;
		if (parseFloat(intVal)>parseFloat(max)||parseFloat(intVal)<parseFloat(min)) {
			msg="数字: "+intVal+' 不能大于: '+max+" 小于: "+min;
			$('#msgWarn'+index).html(msg);
			validateFalse(index,msg);
			return;
		}else{
			$('#msgWarn'+index).html('');
			validateTrue(index,intVal);
		}
	}
}
/*********************************************
 * 校验手机号
 **********************************************/
function checkIphone(index){
	var intVal=$('#iphone'+index).val();
	var rex= /^[1][3,4,5,7,8,9][0-9]{9}$/;
	 if(!rex.test(intVal)){
		 msg="手机号码有误,请重新输入!";
		 $('#msgWarn'+index).html(msg);
		validateFalse(index,msg);
		 return;
	 }else{
		$('#msgWarn'+index).html('');
		validateTrue(index,intVal);
	}
}
/*********************************************
 * 校验邮箱
 **********************************************/
function checkEmail(index){
	var intVal=$('#email'+index).val();
	var rex= /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
	if(!rex.test(intVal)){
		msg="邮箱有误,请重新输入!";
		$('#msgWarn'+index).html(msg);
		validateFalse(index,msg);
		return;
	}else{
		$('#msgWarn'+index).html('');
		validateTrue(index,intVal);
	}
}
/*********************************************
 * 校验身份证
 **********************************************/
function checkId(index){
	var intVal=$('#id'+index).val();
	//var rex= /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
/*	var rex= /^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|31)|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}([0-9]|x|X)$/;
	if(!rex.test(intVal)){
		msg="身份证号有误,请重新输入!";
		$('#msgWarn'+index).html(msg);
		validateFalse(index,msg);
		return;
	}else{
		$('#msgWarn'+index).html('');
		validateTrue(index,intVal);
	}
	*/
	msg=testid(intVal);
	if (msg) {
		$('#msgWarn'+index).html(msg);
	}else{
		validateTrue(index,intVal);//问题单104887：需要添加，不然有填写号码也会报不能为空 linjw
		$('#msgWarn'+index).html('');
	}
}

function testid(id) {
	   // 1 "验证通过!", 0 //校验不通过 // id为身份证号码
	    var format = /^(([1][1-5])|([2][1-3])|([3][1-7])|([4][1-6])|([5][0-4])|([6][1-5])|([7][1])|([8][1-2]))\d{4}(([1][9]\d{2})|([2]\d{3}))(([0][1-9])|([1][0-2]))(([0][1-9])|([1-2][0-9])|([3][0-1]))\d{3}[0-9xX]$/;
	    //号码规则校验
	    if(!format.test(id)){
	      return '身份证号码不合规';
	    }
	    //区位码校验
	    //出生年月日校验  前正则限制起始年份为1900;
	    var year = id.substr(6,4),//身份证年
	      month = id.substr(10,2),//身份证月
	      date = id.substr(12,2),//身份证日
	      time = Date.parse(month+'-'+date+'-'+year),//身份证日期时间戳date
	      now_time = Date.parse(new Date()),//当前时间戳
	      dates = (new Date(year,month,0)).getDate();//身份证当月天数
	    if(time>now_time||date>dates){
	      return '出生日期不合规';
	    }
	    //校验码判断
	    var c = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2);  //系数
	    var b = new Array('1','0','X','9','8','7','6','5','4','3','2'); //校验码对照表
	    var id_array = id.split("");
	    var sum = 0;
	    for(var k=0;k<17;k++){
	      sum+=parseInt(id_array[k])*parseInt(c[k]);
	    }
	    if(id_array[17].toUpperCase() != b[sum%11].toUpperCase()){
	      return '身份证校验码不合规';
	    }
	    //return '校验通过';
	}
/*********************************************
 * 校验中文
 **********************************************/
function chinesWordWarn(index){
	var intVal=$('#chinesWord'+index).val();
	var rex=/^[\u4e00-\u9fa5]+$/gi;
	if(!rex.test(intVal)){
		msg="只能输入中文,请重新输入!";
		$('#msgWarn'+index).html(msg);
		validateFalse(index,msg);
		return;
	}else{
		$('#msgWarn'+index).html('');
		validateTrue(index,intVal);
	}
}
/*********************************************
 * 校验英文
 **********************************************/
function englishWarn(index){
	var intVal=$('#english'+index).val();
	var rex=/^[a-zA-Z\s]+$/;
	if(!rex.test(intVal)){
		msg="只能输入英文,请重新输入!";
		$('#msgWarn'+index).html(msg);
		validateFalse(index,msg);
		return;
	}else{
		$('#msgWarn'+index).html('');
		validateTrue(index,intVal);
	}
}
function defMsg(index){
	val=$("#def"+index).val();
	if (fdQuestionDef[index].willAnswer==true) {
		validateResult = {canSave:true,message:""};
		$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
		$('#hasAnswer'+index+'').val("true");

		$("input[name='fdItems["+index+"].fdAnswerTxt']").val(val);
		$("input[name='fdItems["+index+"].fdAnswer']").val(val);
	}else{
		$("input[name='fdItems["+index+"].fdAnswerTxt']").val(val);
		$("input[name='fdItems["+index+"].fdAnswer']").val(val);
		$('#hasAnswer'+index+'').val("true");
	}
}


/*********************************************
 * 问答题表格
 **********************************************/
function fillquestions_getTableHTML(index){
	var tableHTML = '<table class="options_tb" width=90% id="fillquestions_TB'+index+'">';
	tableHTML += fillquestions_getTitleHTML(index);
	var textHeight = fdQuestionDef[index].inputHeight*16;//一行为16像素
	//------------
	
	var contnetHTML='';
	//整数
	if (fdQuestionDef[index].questionsSel=="1") {
		if (fdQuestionDef[index].range==true) {
			contnetHTML+='<input type="number" name="integerDef'+index+'" id="integerDef'+index+'"> <p style="color:red;"id="msgWarn'+index+'"></p>';
		}else{
			contnetHTML+='<input type="number" name="integerDef'+index+'" id="integerDef'+index+'"> <p style="color:red;"id="msgWarn'+index+'"></p>';
		}
	}
	//小数
	if (fdQuestionDef[index].questionsSel=="2") {
		if (fdQuestionDef[index].range==true) {
			contnetHTML+='<input type="number" step="0.01" name="integerDef'+index+'" id="integerDef'+index+'"> <p style="color:red;"id="msgWarn'+index+'"></p>';
		}else{
			contnetHTML+='<input type="number" step="0.01" name="integerDef'+index+'" id="integerDef'+index+'"> <p style="color:red;"id="msgWarn'+index+'"></p>';
		}
	}
	//日期
	if (fdQuestionDef[index].questionsSel=="3") {
		var str='';
		str+='<script id="data_js" src="'+Com_Parameter.ContextPath+'resource/js/data.js"></script>',
		str+='<script id="xml_js" src="'+Com_Parameter.ContextPath+'resource/js/xml.js"></script>';
		str+='<script id="address_js" src="'+Com_Parameter.ContextPath+'resource/js/address.js"></script>';
		str+='<script id="jquery_ui_js" src="'+Com_Parameter.ContextPath+'resource/js/jquery-ui/jquery.ui.js"></script>';
		
		if (fdQuestionDef[index].dataSel=="1") {//日期
			str+='<div class="inputselectsgl" onclick="selectDate(\'date'+index+'\')" style="width:25%;;min-height:20px;">';
			str+='<div class="input">';
			str+='<input type="text" id="date'+index+'" name="date'+index+'" value="" validate="">';
		}
		if (fdQuestionDef[index].dataSel=="2") {//时间
			str+='<div class="inputselectsgl" onclick="selectTime(\'time'+index+'\')" style="width:25%;;min-height:20px;">';
			str+='<div class="input">';
			str+='<input type="text" id="time'+index+'" name="time'+index+'" value="" validate="" class="" __validate_serial="_validate_2">';
		}
		if (fdQuestionDef[index].dataSel=="3") {//日期时间
			str+='<div class="inputselectsgl" onclick="selectDateTime(\'dateTime'+index+'\')" style="width:25%;;min-height:20px;">';
			str+='<div class="input">';
			str+='<input type="text" id="dateTime'+index+'" name="dateTime'+index+'" value="" validate="" subject="调查开始时间">';
		}
		str+='</div>';
		//inputtime
		if (fdQuestionDef[index].dataSel=="2") {
			str+='<div class="inputtime">';
		}else{
			str+='<div class="inputdatetime">';
		}
		str+='</div>';
		str+='</div>';
		contnetHTML+=str;
	}
	
	//手机
	if (fdQuestionDef[index].questionsSel=="4") {
		contnetHTML+='<input type="text" id="iphone'+index+'" /> <p style="color:red;"id="msgWarn'+index+'"></p>';
	}
	//邮箱
	if (fdQuestionDef[index].questionsSel=="5") {
		contnetHTML+='<input type="text" id="email'+index+'" /> <p style="color:red;"id="msgWarn'+index+'"></p>';
	}
	//省市区
	if (fdQuestionDef[index].questionsSel=="6") {
		contnetHTML+='<select id="prov'+index+'" onchange="showCity(this,'+index+')"><option value="-1">=请选择省份=</option></select><select id="city'+index+'" onchange="showCountry(this,'+index+')"><option value="-1">=请选择城市=</option>'; 
		contnetHTML+='</select><select onchange="showRegion('+index+')" id="country'+index+'"><option value="-1">=请选择县区=</option></select>'; 
	}
	//身份证
	if (fdQuestionDef[index].questionsSel=="7") {
		contnetHTML+='<input type="text" id="id'+index+'"/> <p style="color:red;"id="msgWarn'+index+'"></p>';
	}
	//中文
	if (fdQuestionDef[index].questionsSel=="8") {
		if (fdQuestionDef[index].strDefVal==true) {
			contnetHTML+='<input type="text" name="chinesWord'+index+'" id="chinesWord'+index+'" onBlur="chinesWordWarn('+index+')" > <p style="color:red;"id="msgWarn'+index+'"></p>';
		}else{
			contnetHTML+='<input type="text" name="chinesWord'+index+'" id="chinesWord'+index+'">';
		}
	}
	//英文
	if (fdQuestionDef[index].questionsSel=="9") {
		if (fdQuestionDef[index].strDefVal==true) {
			contnetHTML+='<input type="text" name="english'+index+'" id="english'+index+'" onBlur="englishWarn('+index+')" > <p style="color:red;"id="msgWarn'+index+'"></p>';
		}else{
			contnetHTML+='<input type="text" name="english'+index+'" id="english'+index+'">';
		}
	}
	if (fdQuestionDef[index].questionsSel==null) {
		contnetHTML+='<input type="text" name="def'+index+'" onBlur="defMsg('+index+')"  id="def'+index+'">';
	}
	tableHTML += '</td></tr><tr><td align="left">'+contnetHTML+'</td></tr>';
	tableHTML += '<table>';
	return tableHTML;
}
/****************************************
 * 题头
 ***************************************/
function fillquestions_getTitleHTML(index){
	var serialNum = $('#serialNum'+index).val();
	var titleHTML = '<tr><td>';
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_no">'+serialNum+'、</div>';
	if(fdQuestionDef[index].willAnswer)
		titleHTML += '<span class="pi_txtRequire">*</span>';
	var title = fdQuestionDef[index].subject;
	title=title.replace(/<p>/g,"").replace(/<\/p>/g,"<br>").replace(/\n/g,"").replace(/(<br>)+$/g,"");//格式化标题
	//title = title.replace(/<img(?:.|\s)*?>/g, '');
	//title = title.replace(/<img/g, '<img  onMouseOver="showTooltip(event, this.src)" onMouseOut="hideTooltip();"');
	titleHTML += '<div class="pi_txtTitle pi_txtTitle_content">'+title+'</div>';
	titleHTML += '<span class="pi_txtStrong"> ['+$('#quesTypeName'+index).val()+']</span>';
	if(fdQuestionDef[index].willAnswer == true){
		titleHTML += '<span class="pi_txtStrong"> ';
		titleHTML += '['+Question_Type_Lang.Common.willAnswer+']</span>';
	}
	titleHTML += '</td></tr>';
	if(fdQuestionDef[index].attachmentIds != 'null' && fdQuestionDef[index].attachmentIds != ''){//为修复ie8某些版本下stringify缺陷，增加!='null'判断
		var atturl = Com_Parameter.ContextPath+"km/pindagate/km_pindagate_question/kmPindagateQuestion.do?method=viewAtt&attachmentIds="+
					  fdQuestionDef[index].attachmentIds;
		titleHTML += '<tr><td>';
		titleHTML += '<iframe id="attFrame" onload="autoResize(this)" src="';
		titleHTML += atturl;
		titleHTML +='" width=100% height=0 frameborder=0 scrolling=no>';
		titleHTML +='</iframe>';
		titleHTML += '</td></tr>';
	}
	if(fdQuestionDef[index].tip != ''){
		var tip=fdQuestionDef[index].tip;
		titleHTML += '<tr><td><div class="pi_subjectExplain">';
		titleHTML += Question_Type_Lang.Common.titleDescription+'<div class="pi_subjectExplain_content">'+tip+'</div>';
		titleHTML += '</div></td></tr>';
	}
	return titleHTML;
}
var maxLen=1000000;

/****************************************
 * 长度校验
 **************************************/
function checkLin(inputValue){
	if(inputValue.replace(/[^\x00-\xff]/g,"***").length>maxLen){
		alert(Question_Type_Lang.Essay.moreAlert.replace("%maxLen%",maxLen));
		return inputValue.substring(0, maxLen);
	}
	return inputValue;
}