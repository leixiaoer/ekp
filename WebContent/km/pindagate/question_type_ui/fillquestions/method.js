/*用于保存当前所选的省市区*/
var current = {
    prov: '',
    city: '',
    country: ''
};
 
/*自动加载省份列表*/
(function showProv() {
	var prov = document.getElementById("prov");
    var len = provice.length;
    if (prov) {
    	for (var i = 0; i < len; i++) {
    		var provOpt = document.createElement('option');
    		provOpt.innerText = provice[i]['name'];
    		provOpt.value = i;
    		prov.appendChild(provOpt);
    	}
	}
})();

/*根据所选的省份来显示城市列表*/
function showCity(obj,sign) {
	var prov = document.getElementById("prov");
	var city = document.getElementById("city");
	var country = document.getElementById("country");
	var val="";
	if (sign) {
		val = obj;
	}else{
		val = obj.options[obj.selectedIndex].value;
	}
	$("#country").val("-1");
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
            city.appendChild(cityOpt);
        }
    }
}
 
/*根据所选的城市来显示县区列表*/
function showCountry(obj,sign) {
	var prov = document.getElementById("prov");
	var city = document.getElementById("city");
	var country = document.getElementById("country");
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
            country.appendChild(countryOpt);
        }
    }
}

function showAddress(prov,city,country){
	showCity(prov,"show");
	showCountry(city,"show");
}
 
