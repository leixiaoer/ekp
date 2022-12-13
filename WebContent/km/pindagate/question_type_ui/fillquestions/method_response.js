/*用于保存当前所选的省市区*/
var current = {
    prov: '',
    city: '',
    country: ''
};
 
/*自动加载省份列表*/
function showProv(index) {
	var prov = document.getElementById("prov"+index);
    var len = provice.length;
    if (prov) {
    	for (var i = 0; i < len; i++) {
    		var provOpt = document.createElement('option');
    		provOpt.innerText = provice[i]['name'];
    		provOpt.value = i;
    		prov.appendChild(provOpt);
    	}
	}
}



/*根据所选的省份来显示城市列表*/
function showCity(obj,index,sign) {
	//清除内容
	closeMsg(index);
	showProv(index);
	var prov = $('#prov'+index);
	var city = $('#city'+index).html("<option value='-1'>=请选择城市=</option>");
	var country = $('#country'+index).html("<option value='-1'>=请选择县区=</option>");
	var val="";
	if (sign) {
		val = obj;
	}else{
		val = obj.options[obj.selectedIndex].value;
	}
	$("#country"+index).val("-1");
    if (val != current.prov) {
        current.prov = val;
    }
    if (val != null) {
    	city.length = 1;
        var cityLen = provice[val]["city"].length;
        for (var j = 0; j < cityLen; j++) {
            var cityOpt = document.createElement('option');
            cityOpt.innerText = provice[val]["city"][j].name;
            cityOpt.value = j;
            city.append(cityOpt);
        }
    }
}
 
/*根据所选的城市来显示县区列表*/
function showCountry(obj,index,sign) {
	//清除内容
	closeMsg(index);
	var prov = $('#prov'+index);
	var city = $('#city'+index);
	var country = $('#country'+index).html("<option value='-1'>=请选择县区=</option>");
	var val;
	if (sign) {
		val = obj;
	}else{
		val = obj.options[obj.selectedIndex].value;
	}
    current.city = val;
    if (val != null) {
        country.length = 1; //清空之前的内容只留第一个默认选项
        var countryLen = provice[current.prov]["city"][val].districtAndCounty.length;
        if (countryLen == 0) {
            return;
        }
        for (var n = 0; n < countryLen; n++) {
            var countryOpt = document.createElement('option');
            countryOpt.innerText = provice[current.prov]["city"][val].districtAndCounty[n];
            countryOpt.value = n;
            country.append(countryOpt);
        }
    }
}

function showRegion(index){
	var anser='';
	var prov=$("#prov"+index+" option:selected");
	var city=$("#city"+index+" option:selected");
	var country=$("#country"+index+" option:selected");
	anser=anser+prov.text()+";";
	anser=anser+city.text()+";";
	anser=anser+country.text();
	validateResult = {canSave:true,message:""};
	$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	$("input[name='fdItems["+index+"].fdAnswerTxt']").val(anser);
	$("input[name='fdItems["+index+"].fdAnswer']").val(anser);
	$('input[id="hasAnswer'+index+'"]').val("true");
	caculateProgress();//重新计算进度条
}
function closeMsg(index){
	$("input[name='fdItems["+index+"].fdAnswerTxt']").val("");
	$("input[name='fdItems["+index+"].fdAnswer']").val("");
	validateResult = {canSave:false,
			message:Question_Type_Lang.Common.prePix + $('#serialNum'+index).val()
			+Question_Type_Lang.Common.questionItem+Question_Type_Lang.Common.notNull};
	$('input[id="validateResult'+index+'"]').val(JSON.stringify(validateResult));
	$('input[id="hasAnswer'+index+'"]').val("false");
}

function showAddress(prov,city,index){
	showCity(prov,index,"show");
	showCountry(city,index,"show");
}
 
