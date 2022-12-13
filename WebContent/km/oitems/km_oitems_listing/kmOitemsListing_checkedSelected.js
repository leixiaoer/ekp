	function MyFunc_SendToUrl(url,fdApplicationId){
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
					createXML(http_request,fdApplicationId);
				} else {
					return false;
				}
			}
		}
		http_request.open("GET", url, true);
		http_request.send(null);
		return true;
	}
	
	
	function requestxml(obj,fdApplicationId){
		if(fdApplicationId == null || fdApplicationId == null || fdApplicationId == undefined){
			return;
		}
		var url = "../km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=addOitems" ;
		url = url+"&fdOitemsId="+obj.value+"&fdChecked="+obj.checked+"&fdApplicationId="+fdApplicationId ;
		MyFunc_SendToUrl(url,fdApplicationId);
			
	}

 	function createXML(xmlHttp,fdApplicationId){  
 		var href = "../km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=list&orderby=fdNo&fdApplicationId="+fdApplicationId;
 		window.parent.frames[2].location.href=href;
  	}   