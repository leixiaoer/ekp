Com_IncludeFile("data.js");	

	function MyFunc_SendToUrl(url,number){
		var http_request = null;
		if (window.XMLHttpRequest) {
			http_request = new XMLHttpRequest();
			if (http_request.overrideMimeType)
				http_request.overrideMimeType('text/xml');
		} else if (window.ActiveXObject) {
			try {
				http_request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					http_request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {}
			}
		}
		if (http_request==null)
			return false;
		http_request.onreadystatechange = function(){
			if (http_request.readyState == 4) {
				if (http_request.status == 200) {
					createXML(http_request,number);
				} else {
					return false;
				}
			}
		}
		http_request.open("GET", url, true);
		http_request.send(null);
		return true;
	}
	
	
	function requestxml(obj,type){
		var fdNumber = document.getElementsByName("fdNumber"+obj)[0] ;
		var fdAmount = document.getElementsByName("fdAmount"+obj)[0] ;
		var fdApplicationListingId = document.getElementsByName("fdApplicationListingId"+obj)[0] ;
		if(fdNumber.value.length>0){
			if(fdNumber.value.match("^[0-9]+$")==null){
				 alert(Data_GetResourceString("geesun-oitems:geesunOitems.msg.apply.isNOtNum"));
				 fdNumber.value = '1' ;
				 return false; 
			 }
			if(fdNumber.value <= 0){
				 fdNumber.value = '1' ;
			}
			if((fdNumber.value-fdAmount.value)>0){
				fdNumber.style.color="red";
			}
			if((fdNumber.value-fdAmount.value)<=0){
				fdNumber.style.color="";
			}
			var url = "geesunOitemsShoppingTrolley.do?method=addNumber" ;
			url = url+"&fdApplicationListingId=" + fdApplicationListingId.value + "&fdNumber="+fdNumber.value ;
			MyFunc_SendToUrl(url);
		}
	}

 	function   createXML(xmlHttp,number){   
		
  	}   
