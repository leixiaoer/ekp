<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.ftsearch.config.LksField,
	java.util.List,
	java.util.ArrayList,
	java.util.Iterator,
	com.landray.kmss.sys.ftsearch.search.LksHit,
	java.util.Map,
	com.landray.kmss.util.ResourceUtil,
	com.landray.kmss.sys.config.dict.SysDataDict,
	com.landray.kmss.util.StringUtil,
	com.landray.kmss.sys.ftsearch.util.ResultModelName,
	com.landray.kmss.sys.ftsearch.search.AdvancedSearchIndex,
	com.sunbor.web.tag.Page,
	com.landray.kmss.sys.ftsearch.util.HtmlEscaper,
    java.util.regex.Matcher,
    java.util.regex.Pattern"
%>

<%@ include file="/resource/jsp/htmlhead.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--[if IE 6]>
<script src="js/DD_belatedPNG.js"></script>
<script>
    DD_belatedPNG.fix('div,a,span,h1'); /* EXAMPLE */
    /* string argument can be any CSS selector */
    /* using .png_bg example is unnecessary */
    /* change it to what suits you! */
</script>
<![endif]--> 

<script type="text/javascript">
//Com_IncludeFile("ftsearch.css", "style/common/ftsearch/");
//Com_IncludeFile("ftsearch_result.css", "style/"+Com_Parameter.Style+"/ftsearch/");
Com_IncludeFile("optbar.js|list.js");
Com_IncludeFile("attachment.js","${KMSS_Parameter_ContextPath}sys/attachment/js/","js",true);
Com_SetWindowTitle('<bean:message bundle="sys-ftsearch-db" key="search.moduleName" />');
Com_IncludeFile("treeview.js");
Com_IncludeFile("docutil.js|doclist.js|dialog.js|optbar.js|data.js"); 
//Com_IncludeFile("tag_search_main.css", "style/"+Com_Parameter.Style+"/tag/"); 
</script>
<script type="text/javascript" src="${KMSS_Parameter_ResPath}style/common/fileIcon/fileIcon.js"></script>
<%@ include file="/sys/ftsearch/autocomplete_include.jsp" %>
<link href="styles/public.css" rel="stylesheet" type="text/css" />
<style type="text/css">
div dl dt a em{font-style:normal;color:red;font-weight:bold;}
dd div.summ  em{font-style:normal;color:red;font-weight:bold;}
</style>
<script> 

	var sortType;
	var tagCubeOpen;
	var tagCubeLarge;
	var tagName="";
	var xml=""; 
	var isSearchByButton="false";
	var modelDivExpand;
	
	//????????????
	/*
	function $(id){
		return document.getElementById(id);
	}
	*/
	
	function getUrlParameter() {
		var UrlPara="";
		var modelName = document.getElementsByName("modelName")[0].value;
		var searchFields = document.getElementsByName("searchFields")[0].value;
		//if(queryString!=null && queryString!="")
		//	UrlPara += "&queryString=" + queryString; 
		if(modelName!=null && modelName!="")
			UrlPara += "&modelName=" + modelName; 
		if(searchFields!=null && searchFields!="")
			UrlPara += "&searchFields=" + searchFields; 
		//if(timeRange!=null && timeRange!="")
		//	UrlPara += "&timeRange=" + timeRange; 
		//if(sortType!=null && sortType!="")
		//	UrlPara += "&sortType=" + sortType; 
		if(tagCubeOpen!=null && tagCubeOpen!="")
			UrlPara += "&tagCubeOpen=" + tagCubeOpen; 
		if(tagCubeLarge!=null && tagCubeLarge!="")
			UrlPara += "&tagCubeLarge=" + tagCubeLarge; 
		if(modelDivExpand!=null && modelDivExpand!="")
			UrlPara += "&modelDivExpand=" + modelDivExpand;
		UrlPara += "&isSearchByButton=" + isSearchByButton;
		return UrlPara;
	
	}
	
	function readDoc(fdDocSubject,fdModelName,fdCategory,fdUrl,positionInPage) {

		document.getElementById("fdDocSubject").value=fdDocSubject;
		document.getElementById("fdModelName").value=fdModelName;
		document.getElementById("fdCategory").value=fdCategory;
		document.getElementById("fdUrl").value=fdUrl;
		//alert($("fdUrl").value);
		document.getElementById("fdModelId").value=Com_GetUrlParameter(fdUrl, "fdId");
		var queryString = Com_GetUrlParameter(window.location.href, "queryString");
		document.getElementById("fdSearchWord").value=queryString;
		var pageno = Com_GetUrlParameter(window.location.href, "pageno");
		var rowsize = Com_GetUrlParameter(window.location.href, "rowsize");
		if(pageno==null || pageno=="")
			pageno=1;
		if(rowsize==null || rowsize=="")
			rowsize=10;
		var position = parseInt(pageno-1)*parseInt(rowsize) + parseInt(positionInPage) + 1;
		document.getElementById("fdHitPosition").value=position;
		var sysFtsearchReadLogForm = document.getElementById("sysFtsearchReadLogForm");
		
		sysFtsearchReadLogForm.submit();
		
		return null;	
	}	
	
	//??????????????????
	function selectField(){
		var fields="";  
		if(document.getElementById("type_title").checked) {
			fields+="title;";
		}
		if((document.getElementById("type_content")).checked) {
			fields+="content;";
		}
		if(document.getElementById("type_attachment").checked) {
			fields+="attachment;";
		}
		if(document.getElementById("type_creator").checked) {
			fields+="creator;";
		}
		if(document.getElementById("type_tag").checked) {
			fields+="tag;";
		}
		if(fields!=""){
			fields=fields.substring(0,fields.length-1);
	 	}
		document.getElementsByName("searchFields")[0].value= fields;
	}
	
	//??????????????????????????????
	function checkQueryString(obj)
	{
	 if(obj.value==""){//???????????????
		alert("<bean:message bundle='sys-tag' key='sysTag.inputContent' />");
		obj.focus();
		return false;
	 }
	 if(obj.value.length > 100){
		 alert("<bean:message key='search.ftsearch.overlength' bundle='sys-ftsearch-db' />");
		 obj.focus();
		 return false;
	 }
	    return true;
	}
	
	
	// ?????????
	function searchByTime(){ 
		//var queryType=document.getElementsByName("queryType")[0].value;//???????????? 
		var timeRange="";
		var queryString=document.getElementsByName("queryString")[0];//????????????  
	 	if(!checkQueryString(queryString)){//???????????????????????? ??????????????????
		       return false;
	 	} 
	 	queryString=encodeURIComponent(queryString.value);//????????????
	 	//closeFlash("cube");//???????????????
		if(this.parameter=="day"){//????????? 
			timeRange='day';
		}
		else if(this.parameter=="week"){//????????? 
			timeRange='week';
		}
		else if(this.parameter=="month"){//????????? 
			timeRange='month';
		}
		else if(this.parameter=="year"){//????????? 
			timeRange='year';
		}
		var outmodel = selectOutModelInfo();
		var modelGroupChecked = document.getElementsByName("modelGroupChecked")[0].value;
		window.location.href="<c:url value='/sys/ftsearch/searchBuilder.do?method=search&queryString=' />"
			+queryString +"&type=1&timeRange="+timeRange+getUrlParameter()+"&outModel="+outmodel+"&modelGroupChecked="+modelGroupChecked;  
		
	}
	
	
	//?????????
	function searchByField(){ 
		//var queryType=document.getElementsByName("queryType")[0].value;//???????????? 
		var queryString=document.getElementsByName("queryString")[0];//????????????  
		var searchFields;
	 	if(!checkQueryString(queryString)){//???????????????????????? ??????????????????
		       return false;
	 	} 
	 	queryString=encodeURIComponent(queryString.value);//????????????
		if(this.parameter=="title"){//??????
			searchFields='title';
		}
		else if(this.parameter=="content"){//??????
			searchFields='content';
		}
		else if(this.parameter=="attachment"){//??????
			searchFields='attachment';
		}
		else if(this.parameter=="creator"){//??????
			searchFields='creator';
		}
		else if(this.parameter=="tag"){//??????
			searchFields='tag';
		}
		updateSelectedFields(searchFields,false);
		var outmodel = selectOutModelInfo();
		var modelGroupChecked = document.getElementsByName("modelGroupChecked")[0].value;
		document.getElementsByName("searchFields")[0].value=searchFields;
		window.location.href="<c:url value='/sys/ftsearch/searchBuilder.do?method=search&queryString=' />"+queryString +"&type=1"+getUrlParameter()+
		"&outModel="+outmodel+"&modelGroupChecked="+modelGroupChecked; 
		
	}
	
	
	//??????????????????
	
	function CommitSearch(queryStringPos){
		var outmodel = selectOutModelInfo();
		var modelGroupChecked = document.getElementsByName("modelGroupChecked")[0].value;
		if(queryStringPos==0 || queryStringPos==1) {
			isSearchByButton="true";
			var queryStringObj =document.getElementsByName("queryString")[queryStringPos];//???????????? 
		 	if(!checkQueryString(queryStringObj)){//???????????????????????? ??????????????????
			       return null;
		 	}
		 	var queryString = encodeURIComponent(queryStringObj.value);
		 	
		 	window.location.href="<c:url value='/sys/ftsearch/searchBuilder.do?method=search&queryString=' />"+queryString + getUrlParameter()+"&outModel="+outmodel+"&modelGroupChecked="+modelGroupChecked;  
		}
		else {
			var queryString=Com_GetUrlParameter(window.location.href, "queryString");
			if(queryString==null || queryString=="") 
				queryString = document.getElementsByName("queryString")[1].value;
			if(queryString==null || queryString=="") 
				queryString = document.getElementsByName("queryString")[0].value;
			if(queryString==null || queryString=="") 
				return null;
			else{
				queryString = encodeURIComponent(queryString);
				window.location.href="<c:url value='/sys/ftsearch/searchBuilder.do?method=search&queryString=' />"+queryString + getUrlParameter()+"&outModel="+outmodel+"&modelGroupChecked="+modelGroupChecked; 
			}
		}
	}

	function isIE(){ //ie?
			   if (window.navigator.userAgent.toLowerCase().indexOf("msie")>=1)
			    return true;
			   else
			    return false;
			}
	
	//?????????FLASH??????
	function Tag_GetFlashHtml(){ 
		var rand = getRand();
		var obj = "";
		if(isIE()){
			obj="<object id='TagApplication_SWFObjectName'";
		  	obj+="name='TagApplication_SWFObjectName' " ;
		  	obj+="classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'";
		  	obj+="width='100%' height='100%' >";
		  	obj+="<param name='movie' value='<c:url value='/sys/ftsearch/TagCubeApp.swf'/>" + "?rand=" + getRand() +"'/>";
		  	obj+="<param name='quality' value='high' />";
		  	obj+="<param name='wmode' value='opaque' /></object>";  
		  	return obj;  
		}else {
		obj="<object ";
	  	obj+="name='TagApplication_SWFObjectName' " ;
	  	obj+="classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'";
	  	obj+="width='100%' height='100%' >";
	  	obj+="<param name='movie' value='<c:url value='/sys/ftsearch/TagCubeApp.swf'/>" + "?rand=" + rand +"'/>";
	  	obj+="<param name='quality' value='high' />";
	  	obj+="<param name='wmode' value='opaque' />";
	  	obj+="<embed"; 
	  	obj+=" id=\"TagApplication_SWFObjectName\" ";
	  		obj+="	name=\"TagApplication_SWFObjectName\" ";
	  		obj+="		src=\"<c:url value='/sys/ftsearch/TagCubeApp.swf'/>" + "?rand=" + rand +"'/>\" ";
	  		obj+="		wmode=\"opaque\" ";
	  		obj+="		quality=\"high\"  ";
	  		obj+="		pluginspage=\"http://www.macromedia.com/go/getflashplayer\"  ";
	  		obj+="		type=\"application/x-shockwave-flash\"  ";
	  		obj+="		style=\"width: 100%; height: 100%\"> ";
	  		obj+="	</embed> ";
	  			obj+="  	</object>";  
		}
	  	return obj;  
	} 
	
	//?????????FLASH
	function TagCube_initComplete() {  
		//var length = document.getElementsByName('TagApplication_SWFObjectName').length;
		//alert(length);
		var flash = document.getElementById('TagApplication_SWFObjectName');//???????????? 	
		flash.TagCube_setBaseRadiusToAS(500,500);//????????????   
		flash.TagCube_setTagDataToAS(xml); 
	
	}
	
	//FLASH??????
	function TagCube_bigSize(){
		document.getElementById("cube").style.height ="80%";
		document.getElementById("cube").style.width ="86%";
		tagCubeLarge = true;
	}
	//FLASH??????
	function TagCube_smallSize(){ 
		    var newDivWidth = 300;
		    var  newDivHeight = 300;
		    document.getElementById("cube").style.width = newDivWidth + "px";
		    document.getElementById("cube").style.height = newDivHeight + "px"; 
		    var leftTree=document.getElementById("toolTreeDiv");
			var lfTrWh=0+"px";
			var lfTrHt=0+"px"; 
			lfTrWh=leftTree.offsetWidth;
			lfTrHt=leftTree.offsetHeight; 
			document.getElementById("cube").style.top = document.body.clientHeight/2 +lfTrHt+5;
			document.getElementById("cube").style.left = "6.8%";
			tagCubeLarge = false;
	} 
	
	//????????????????????????
	function docEle(id) {
		if(document.getElementById(id)!=null)
			return true;
	    return false;
	}

	function TagCube_close() {
		closeFlash("cube");
	}	
	
	//?????????
	function closeFlash(_id){ 
		 if(docEle(_id)){
			 document.body.removeChild(document.getElementById("cube"));
			 tagCubeOpen = false;
			 document.getElementById("type_title").disabled = false;
				document.getElementById("type_content").disabled = false;
				document.getElementById("type_attachment").disabled = false;
				document.getElementById("type_creator").disabled = false;
		} 
	} 
	
	//?????????
	function Tag_createNewDIV(){ 
			//var objFlash=Tag_GetFlashHtml();    
		    var newDiv = document.createElement("div");
		    newDiv.id = "cube";
		    newDiv.style.position = "absolute";
		    newDiv.style.zIndex = "9999";
		    if(tagCubeLarge) {
		    	newDiv.style.width = "80%";
		    	newDiv.style.height = "86%";
			}else {
			    var newDivWidth = 300;
			    var  newDivHeight = 300;
			    newDiv.style.width = newDivWidth + "px";
			    newDiv.style.height = newDivHeight + "px"; 
			}
		    var leftTree=document.getElementById("toolTreeDiv");
			var lfTrWh=0+"px";
			var lfTrHt=0+"px"; 
			lfTrWh=leftTree.offsetWidth;
			lfTrHt=leftTree.offsetHeight; 
		    newDiv.style.top =(document.body.scrollTop + document.body.clientHeight/2 +lfTrHt+5);
		    newDiv.style.left = "6.8%";
		    newDiv.style.background = "#EBF2F8";
		    newDiv.style.border = "1px solid #D3E8F2";
		    newDiv.style.padding = "5px";
		    newDiv.style.overflow = "auto"; 
		    document.body.appendChild(newDiv); 
		    newDiv.innerHTML = Tag_GetFlashHtml(); 
		    //TagCube_initComplete();
		    
	}
	
	//??????FLASH??????
	function TagCube_requestDataByID(_queryString) {
		Com_SetWindowTitle('<bean:message bundle="sys-tag" key="sysTag.tree.result" />');
		xml = "";
		var queryString=_queryString; 
		queryString=encodeURIComponent(queryString);//????????????
		var outmodel = selectOutModelInfo();
		var modelGroupChecked = document.getElementsByName("modelGroupChecked")[0].value;
		window.location.href="<c:url value='/sys/ftsearch/searchBuilder.do?method=search&queryString=' />"+queryString+getUrlParameter()+"&outModel="+outmodel+"&modelGroupChecked="+modelGroupChecked;  
		
	}
	
	//?????????
	function openFlash() { 
		 xml="";
		 var data = new KMSSData();
		 var queryString=document.getElementsByName("queryString")[0];//???????????? 
		 if(!checkQueryString(queryString)){//???????????????????????? ??????????????????
		       return false;
		 } 
		 var url="sysTagCubXMLService&queryString="+encodeURIComponent(queryString.value)+"&queryType=cube";
	
		 if(document.getElementById("cube")!=null){//??????????????????????????? 
			 document.body.removeChild(document.getElementById("cube"));
		 }
		 data.SendToBean(url,Tag_rtnData); 
		 tagCubeOpen = true; 
	} 
	
	function Tag_rtnData(rtnData){  
	
		if(rtnData.GetHashMapArray().length >= 1 ){ 
	     		var obj = rtnData.GetHashMapArray()[0]; 
	     		tagName=obj['tagName'];
	     		xml=obj['xml'];  
	     		Tag_createNewDIV(); 
	     }  
	}  
	
	//??????flash????????????xml
	function Tag_rtnData_a(rtnData){  
		if(rtnData.GetHashMapArray().length >= 1){ 
	     		var obj = rtnData.GetHashMapArray()[0]; 
	     		tagName=obj['tagName'];
	     		xml=obj['xml']; 
	     		//Tag_createNewDIV();
	     		
	   			if(!docEle("TagApplication_SWFObjectName")){
	   				Tag_createNewDIV();
	   	   	    }
	   			else {
	     			TagCube_initComplete();
	   			}
	   			
	     }  
	}  
	
	
	//??????flash??????????????????????????????
	function TagCube_AddDataByID(tagName,tagId) {
		addSearch(tagName);
	}
		
	//????????????
	function addSearch(tag){
		var queryString=document.getElementsByName('queryString')[0].value;
		var queryStrings= queryString.split(" ");
		var flag=false;
		for(var i=0;i<queryStrings.length;i++){
			if(queryStrings[i]==tag){
				flag=true;//??????????????????
			}
		}
		
		if(!flag){
			document.getElementsByName('queryString')[0].value=queryString+" "+tag;
			document.getElementsByName('searchFields')[0].value="tag";
			queryString=document.getElementsByName('queryString')[0].value;
			TagCube_requestDataByID(queryString);//????????????
			queryString=encodeURIComponent(queryString);//???????????? 
			var outmodel = selectOutModelInfo();
			var modelGroupChecked = document.getElementsByName("modelGroupChecked")[0].value;
			window.location.href="<c:url value='/sys/ftsearch/searchBuilder.do?method=search&queryString=' />"+queryString+ getUrlParameter()+"&outModel="+outmodel+"&modelGroupChecked="+modelGroupChecked ; 
				
		}
	}
	
	function generateTimeTree()
	{   
		//?????????
		LKSTree = new TreeView("LKSTree", "<bean:message key="search.ftsearch.time.range" bundle="sys-ftsearch-db" />", document.getElementById("timeTreeDiv"));
		var n1, n2, n3;
		n1 = LKSTree.treeRoot; 

		//?????????
		var treeNode_day = new TreeNode(
			"<bean:message key="search.ftsearch.time.day" bundle="sys-ftsearch-db" />","day",searchByTime,null,null,'CUBECHILD'
		);
		n1.AddChild(treeNode_day);
		var treeNode_week = new TreeNode(
			"<bean:message key="search.ftsearch.time.week" bundle="sys-ftsearch-db" />","week",searchByTime,null,null,'CUBECHILD'
		);
		n1.AddChild(treeNode_week);
		var treeNode_month = new TreeNode(
				"<bean:message key="search.ftsearch.time.month" bundle="sys-ftsearch-db" />","month",searchByTime,null,null,'CUBECHILD'
			);
		n1.AddChild(treeNode_month);
		var treeNode_year = new TreeNode(
				"<bean:message key="search.ftsearch.time.year" bundle="sys-ftsearch-db" />","year",searchByTime,null,null,'CUBECHILD'
			);
		n1.AddChild(treeNode_year);

		timeRange = Com_GetUrlParameter(window.location.href, "timeRange");
		if(timeRange=="day") 
			LKSTree.SetCurrentNode(treeNode_day);
		else if(timeRange=="week") 
			LKSTree.SetCurrentNode(treeNode_week);
		else if(timeRange=="month") 
			LKSTree.SetCurrentNode(treeNode_month);
		else if(timeRange=="year") 
			LKSTree.SetCurrentNode(treeNode_year);
		n1.isExpanded = true;
		n1.CheckFetchChildrenNode();	
		LKSTree.Show();
	}


	function generateFieldTree()
	{   
		LKSTree2 = new TreeView("LKSTree2", "<bean:message key="search.ftsearch.field.only" bundle="sys-ftsearch-db" />", document.getElementById("fieldTreeDiv"));
		var n1, n2, n3;
		n1 = LKSTree2.treeRoot; 

		var treeNode_title = new TreeNode(
			"<bean:message key="search.ftsearch.field.title" bundle="sys-ftsearch-db" />","title",searchByField,null,null,'CUBECHILD'
		);
		n1.AddChild(treeNode_title);
		
		var treeNode_content = new TreeNode(
				"<bean:message key="search.ftsearch.field.content" bundle="sys-ftsearch-db" />","content",searchByField,null,null,'CUBECHILD'
		);
		n1.AddChild(treeNode_content);
		
		var treeNode_attachment = new TreeNode(
				"<bean:message key="search.ftsearch.field.attachment" bundle="sys-ftsearch-db" />","attachment",searchByField,null,null,'CUBECHILD'
		);
		n1.AddChild(treeNode_attachment);
		
		var treeNode_creator = new TreeNode(
				"<bean:message key="search.ftsearch.field.creator" bundle="sys-ftsearch-db" />","creator",searchByField,null,null,'CUBECHILD'
		);
		n1.AddChild(treeNode_creator);
		
		var treeNode_tag = new TreeNode(
			"<bean:message key="search.ftsearch.field.tag" bundle="sys-ftsearch-db" />","tag",searchByField,null,null,'CUBECHILD'
		);
		n1.AddChild(treeNode_tag);

		var searchFields = Com_GetUrlParameter(window.location.href, "searchFields");
			if(searchFields=="title") 
				LKSTree2.SetCurrentNode(treeNode_title);
			else if(searchFields=="content") 
				LKSTree2.SetCurrentNode(treeNode_content);
			else if(searchFields=="attachment") 
				LKSTree2.SetCurrentNode(treeNode_attachment);
			else if(searchFields=="creator") 
				LKSTree2.SetCurrentNode(treeNode_creator);
			else if(searchFields=="tag") 
				LKSTree2.SetCurrentNode(treeNode_tag);
		n1.isExpanded = true;
		n1.CheckFetchChildrenNode();	
		LKSTree2.Show();
	}


	function generateToolTree()
	{   
		LKSTree3 = new TreeView("LKSTree3", "<bean:message key="search.ftsearch.tool" bundle="sys-ftsearch-db" />", document.getElementById("toolTreeDiv"));
		var n1, n2, n3;
		n1 = LKSTree3.treeRoot; 

		var treeNode_cube = new TreeNode(
			"<bean:message key="search.ftsearch.tag.cube" bundle="sys-ftsearch-db" />",null,openCube,null,null,'CUBECHILD'
		);
		n1.AddChild(treeNode_cube);
		n1.isExpanded = true;
		n1.CheckFetchChildrenNode();	
		LKSTree3.Show();
	}

	function openCube() {
		openFlash();//???????????????  
		updateSelectedFields("tag",true);
	}

	// ????????????????????????
	function updateSelectedFields(field,tagCube) {
		document.getElementById("type_title").checked = false;
		document.getElementById("type_content").checked = false;
		document.getElementById("type_attachment").checked = false;
		document.getElementById("type_creator").checked = false;
		document.getElementById("type_tag").checked = false;

		document.getElementById("type_"+field).checked = true;

		if(tagCube==true) {
			document.getElementById("type_title").disabled = true;
			document.getElementById("type_content").disabled = true;
			document.getElementById("type_attachment").disabled = true;
			document.getElementById("type_creator").disabled = true;
		}
	}

	//???????????????
	function getRand(){
		var Num=Math.floor(Math.random()*1000000);
		return Num;
	}
	
	//????????????
	function sortResult(sortType) {
		/*
		var queryString=document.getElementsByName("queryString")[0];//???????????? 
	 	if(!checkQueryString(queryString)){//???????????????????????? ??????????????????
		       return;
	 	} 
	 	
	 	queryString = encodeURIComponent(queryString.value);
		var old_queryString = Com_GetUrlParameter(window.location.href,"queryString");
		if(old_queryString==null || old_queryString=="")
			window.location.href="<c:url value='/sys/ftsearch/searchBuilder.do?method=search&queryString=' />"+queryString +getUrlParameter() +"&sortType=" + sortType; 
		else
			window.location.href = Com_SetUrlParameter(window.location.href,"sortType",sortType);
			*/
		var url = Com_SetUrlParameter(window.location.href,"pageno",1);
		window.location.href = Com_SetUrlParameter(url,"sortType",sortType);
			
	}

	// ??????????????????
	function search_on_result() {
		
		var queryString=document.getElementsByName("queryString")[1];
		if(!checkQueryString(queryString)){//???????????????????????? ??????????????????
		       return false;
		}
		var outmodel = selectOutModelInfo();
		var modelGroupChecked = document.getElementsByName("modelGroupChecked")[0].value;
		var old_queryString = Com_GetUrlParameter(window.location.href, "queryString");

		var str_old = old_queryString.split(' ');
		var str_new = queryString.value.split(' ');
		for(var i = 0 ; i < str_old.length ; i++){
			for(var j = 0 ; j < str_new.length ; j++){
				if(str_old[i]==str_new[j]){
					alert("<bean:message bundle="sys-ftsearch-db"  key="search.ftsearch.existError1" />" +str_new[j]+ "<bean:message bundle="sys-ftsearch-db"  key="search.ftsearch.existError2" />");
					return false;
				}
			}
		}
		queryString = old_queryString + "&" + queryString.value;
		var url = Com_SetUrlParameter(window.location.href,"pageno",1)+"&outModel="+outmodel+"&modelGroupChecked="+modelGroupChecked;
		window.location.href = Com_SetUrlParameter(url,"queryString",queryString);
	}

	// ????????????????????????????????????
	function searchWord(queryString) {
		queryString = encodeURIComponent(queryString);
		var UrlPara="";
		var modelName = document.getElementsByName("modelName")[0].value;
		var searchFields = document.getElementsByName("searchFields")[0].value;
		if(modelName!=null && modelName!="")
			UrlPara += "&modelName=" + modelName; 
		if(searchFields!=null && searchFields!="")
			UrlPara += "&searchFields=" + searchFields;
		if(modelDivExpand!=null && modelDivExpand!="")
			UrlPara += "&modelDivExpand=" + modelDivExpand;
		 
		//if(timeRange!=null && timeRange!="")
		//	UrlPara += "&timeRange=" + timeRange; 
		//if(sortType!=null && sortType!="")
		//	UrlPara += "&sortType=" + sortType; 
		//if(tagCubeOpen!=null && tagCubeOpen!="")
		//	UrlPara += "&tagCubeOpen=" + tagCubeOpen; 
		//if(tagCubeLarge!=null && tagCubeLarge!="")
		//	UrlPara += "&tagCubeLarge=" + tagCubeLarge; 
		//UrlPara += "&isSearchByButton=" + isSearchByButton;
		var outmodel = selectOutModelInfo();
		var modelGroupChecked = document.getElementsByName("modelGroupChecked")[0].value;
		window.location.href="<c:url value='/sys/ftsearch/searchBuilder.do?method=search&queryString=' />"+queryString + UrlPara+"&outModel="+outmodel+"&modelGroupChecked="+modelGroupChecked; 
	}
	
	// ????????????????????????
	function initSummary() {
		//alert(3232);
		var rowsize = Com_GetUrlParameter(window.location.href, "rowsize");
		if(rowsize==null || rowsize=="")
			rowsize = "10";
		var rows = parseInt(rowsize);
		for(var i=0; i<rows; i++ ) {
			var summary = document.getElementById("summary_"+i);
			if(summary==null)
				break;
			if(summary.offsetHeight > 48) {
				summary.style.height = 48; 
				summary.style.overflow ="hidden";
				summary.style.cursor ="default";
				summary.setAttribute("ondblclick",expand);
				//summary.attachEvent("onclick",expand); 
			}
		}
	}

	// ?????????????????????
	function expand() {
		var divObject = event.srcElement;
		document.selection.empty();
		//divObject.onselectstart= function() {return  false; };
		if(divObject.style.overflow =="visible" ) {
			divObject.style.overflow ="hidden";
			divObject.style.cursor ="default";
		}
		else if(divObject.style.overflow =="hidden" ) {
			divObject.style.overflow ="visible";
			divObject.style.cursor ="text";
		}
	}

	//??????????????????
	function selectOutSystemModel(system){
		var modelName="";  
		var flag=true;
		var checkbox_models = document.getElementsByName(system);
		//????????????
		for(var i=0;i<checkbox_models.length;i++){
			if( checkbox_models[i].checked){
				modelName+=checkbox_models[i].value+";"; 
			}
		}
		if(modelName!=""){
			modelName=modelName.substring(0,modelName.length-1);
		}
		if(system == 'checkbox_model'){
			document.getElementsByName("modelName")[0].value= modelName;
		}else{
			document.getElementById(system+'_systemName').value = modelName;
			var modelStr = "";
			var hiddenDiv = document.getElementById("hidden_div");
			var allUl = hiddenDiv.getElementsByTagName("ul");
			for(var i = 0 ; i < allUl.length;i++){
				if(allUl[i].getAttribute("name") == "multiSysmodel_select"){
					var inputModel = allUl[i].getElementsByTagName("input");
					for(var j=0,k=0; j<inputModel.length; j++) {
						if(inputModel[j].checked) {
							modelStr += inputModel[j].value+";";
						}
					}
				}	
			}
			if(modelStr!=""){
				modelStr=modelStr.substring(0,modelStr.length-1);
			}
			document.getElementsByName("multisSysModel")[0].value= modelStr;
		}
	}
	
	//????????????????????????
	function selectOutModelInfo(){
		return document.getElementsByName("multisSysModel")[0].value
	}

	//????????????
	function selectModel(element){
		var modelName="";  
		var flag=true;
		var entriesDesignCount=document.getElementsByName("entriesDesignCount")[0].value;
			//????????????
			for(var i=0;i<entriesDesignCount;i++){
				if( document.getElementsByName("element"+i)[0].checked){
					modelName+=document.getElementsByName("element"+i)[0].value+";"; 
				}
			}	 
		 	if(modelName!=""){
				modelName=modelName.substring(0,modelName.length-1);
		 	}
			document.getElementsByName("modelName")[0].value= modelName;
	}

	//????????????
	function selectAllModel(allModelObj,system) {
		var isChecked = allModelObj.checked;
		var check;
		if(isChecked)
			check = 'checked'; 
		else
			check = ''; 
		var checkbox_models = document.getElementsByName(system);
		for(var i=0; i<checkbox_models.length; i++) {
			checkbox_models[i].checked = check;
		}
		//selectModel();
		selectOutSystemModel(system);
	}

	// ??????????????????????????????
	function getAllSelectedModel() {
		var checkbox_models = document.getElementsByName("checkbox_model");
		var modelTitleString = new Array();
		for(var i=0,j=0; i<checkbox_models.length; i++) {
			if(checkbox_models[i].checked) {
				modelTitleString[j] = checkbox_models[i].parentNode.innerText||checkbox_models[i].parentNode.textContent;
				j++;
			}
		}
		return modelTitleString;
	}
	
	// ??????????????????????????????
	function getAllSelectedModel(name) {
		var checkbox_models = document.getElementsByName(name);
		var modelTitleString = new Array();
		for(var i=0,j=0; i<checkbox_models.length; i++) {
			if(checkbox_models[i].checked) {
				modelTitleString[j] = checkbox_models[i].parentNode.innerText||checkbox_models[i].parentNode.textContent;
				j++;
			}
		}
		return modelTitleString;
	}

	//?????????????????????
	function selectModelGroup(obj,model){
		
		var isChecked = obj.checked;
		var check;
		if(isChecked)
			check = 'checked';
		else
			check = '';
		
		var arrs=model.split("%");
		for(var i = 0 ; i < arrs.length ; i++){
			var modelInfo = new Array();
			if(arrs[i].indexOf(":")!= -1)	{
				  modelInfo = arrs[i].split(":");
			}
			else{
				modelInfo[0] = 'checkbox_model';
				modelInfo[1] = arrs[i];
			}
			var checkbox_models = document.getElementsByName(modelInfo[0]);
			for(var j=0; j<checkbox_models.length; j++) {
				 var start = checkbox_models[j].value.indexOf("@");
				 var checkValue;
				 if(start == -1){
					 checkValue=checkbox_models[j].value;
				 }else{
				    checkValue=checkbox_models[j].value.substring(start+1,checkbox_models[j].value.length);
				 }
				 if(checkValue == modelInfo[1]){
					checkbox_models[j].checked = check;
				 }
			 }
			selectOutSystemModel(modelInfo[0]);
		}
		modelGroupChecked();
		view_select_model();
	}

	function modelGroupChecked(){
		var modelGroupChecked = "";
		var modelGroups = document.getElementsByName("modelGroups");
		for(var i=0; i<modelGroups.length; i++) {
			if(modelGroups[i].checked){
				modelGroupChecked += modelGroups[i].value+";";
			}
		}
		document.getElementsByName("modelGroupChecked")[0].value= modelGroupChecked;
	}

	
	if(!isIE()){ //firefox innerText define
	   HTMLElement.prototype.__defineGetter__(     "innerText",
	    function(){
	     var anyString = "";
	     var childS = this.childNodes;
	     for(var i=0; i<childS.length; i++) {
	      if(childS[i].nodeType==1)
	       anyString += childS[i].tagName=="BR" ? '\n' : childS[i].textContent;
	      else if(childS[i].nodeType==3)
	       anyString += childS[i].nodeValue;
	     }
	     return anyString;
	    }
	   );
	   HTMLElement.prototype.__defineSetter__(     "innerText",
	    function(sText){
	     this.textContent=sText;
	    }
	   );
	}
			

	// ??????????????????????????????
	function view_select_model() {
		var selectLi = document.getElementById("selectLi");
		var model_view = document.getElementById("model_view");
		var model_select = document.getElementById("model_select");
		
		var hiddenDiv = document.getElementById("hidden_div");
		var allUl = hiddenDiv.getElementsByTagName("ul");
	
		if(selectLi.style.display=="none") {
			modelDivExpand = "true";
			selectLi.style.display = "";
			model_view.style.display = "none";
			model_select.style.display = "";
			
			for(var i = 0 ; i < allUl.length;i++){
				if(allUl[i].getAttribute("name") == "multiSysmodel_select"){
					allUl[i].style.display = "";
				}
				if(allUl[i].getAttribute("name") == "multiSysmodel_view"){
					allUl[i].style.display = "none";
				}
			}
		}
		else {
			modelDivExpand = "false";
			selectLi.style.display = "none";
			model_select.style.display = "none";
			
			var modelTitleString = getAllSelectedModel("checkbox_model");
			if(modelTitleString.length > 0 ) {
				var liObj;
				var labelObj;
				while(model_view.hasChildNodes()){
					model_view.removeChild(model_view.firstChild);
			    }	
			    	
				for(var i=0;i<modelTitleString.length;i++) {
					//liObj = $("<li/>");//li????????????  
					//labelObj = $("<label/>").text(modelTitleString[i]);
					//labelObj.innerText = modelTitleString[i];
					//labelObj.textContent = modelTitleString[i];
					//divObj = document.createElement("div");
					//divObj.text(modelTitleString[i]);
					//$('#test111').text("9877685");
					//liObj.append($("<div/>").text(modelTitleString[i]));
					//model_view.append(liObj);
					//$("#model_view").append(liObj);
					liObj = document.createElement("li");//li????????????  
					labelObj = document.createElement("label");
					$(labelObj).text(modelTitleString[i]);
					liObj.appendChild(labelObj);
					model_view.appendChild(liObj);
				}
				model_view.style.display = "";
			}
			
			for(var i = 0 ; i < allUl.length;i++){
			
				if(allUl[i].getAttribute("name") == "multiSysmodel_select"){
					allUl[i].style.display = "none";
					
					var inputModel = allUl[i].getElementsByTagName("input");
					var sysModelTitleString = new Array();
					for(var j=0,k=0; j<inputModel.length; j++) {
						if(inputModel[j].checked) {
							sysModelTitleString[k] = inputModel[j].parentNode.innerText||inputModel[j].parentNode.textContent;
							k++;
						}
					}
					if(sysModelTitleString.length > 0 ) {
						var sysliObj;
						var syslabelObj;
						while(allUl[i-1].hasChildNodes()){
							allUl[i-1].removeChild(allUl[i-1].firstChild);
					    }	
						for(var n=0;n<sysModelTitleString.length;n++) {
							sysliObj = document.createElement("li");//li????????????  
							syslabelObj = document.createElement("label");
							$(syslabelObj).text(sysModelTitleString[n]);
							sysliObj.appendChild(syslabelObj);
							allUl[i-1].appendChild(sysliObj);
						}
						allUl[i-1].style.display = "";
					}
				}
			}
		}
	//	selectLi.focus();
	}

	function pagingShow(){
		var spans = document.getElementById("pagingTools");
		if(spans!=null){
			var aTags = spans.getElementsByTagName("a");
			if(aTags!=null && aTags.length>0){
				var status = aTags[aTags.length-2].innerHTML.indexOf("...");
				if(status == 0){
					aTags[aTags.length-2].style.display = "none";
				}
			}
		}
	}


	window.onload = function initCube() {
		initSummary();
		tagCubeOpen=Com_GetUrlParameter(window.location.href, "tagCubeOpen");
		tagCubeLarge=Com_GetUrlParameter(window.location.href, "tagCubeLarge");
		modelDivExpand=Com_GetUrlParameter(window.location.href, "modelDivExpand");
		if(tagCubeOpen=="true") {
			openCube();
		}
		
		if(modelDivExpand=="true") {
			view_select_model();
		}

		pagingShow();
		
	}

	

	//????????????
	function advancedSearchs(){ 
		var queryString=encodeURIComponent(document.getElementsByName("queryString")[0].value);
		if(document.getElementsByName("modelName")[0]){
			Com_OpenWindow(getAppendUrl()+"&modelName="+document.getElementsByName("modelName")[0].value+"&queryString="+queryString,"_blank");
		}else{
			Com_OpenWindow(getAppendUrl()+"&queryString="+queryString,"_blank");
		}	 
	}

	function getAppendUrl(){
		var url = '<c:url value="/sys/ftsearch/sys_ftsearch_result/sysFtsearchAdvanced.do" />?method=sysFtsearchAdvanced';
	//	var docCategoryId = document.getElementsByName("categoryId")[0].value;
	//	if(docCategoryId != null && docCategoryId != ""){
	//		url = Com_SetUrlParameter(url, "categoryId", docCategoryId); 
	//	}
	//	alert(url);
		return url;
	}

</script>
</head>
<body>
<% Page queryPage = (Page)request.getAttribute("queryPage");
   List fieldList = (ArrayList)request.getAttribute("fieldList");
%>

<form id="sysFtsearchReadLogForm" name="sysFtsearchReadLogForm"  action="<c:url value="/sys/ftsearch/expand/sys_ftsearch_read_log/sysFtsearchReadLog.do?method=save" />" method="post" target="_blank">
<input id="fdDocSubject" name="fdDocSubject" type="hidden">
<input id="fdModelName" name="fdModelName" type="hidden">
<input id="fdCategory" name="fdCategory" type="hidden">
<input id="fdUrl" name="fdUrl" type="hidden">
<input id="fdSearchWord" name="fdSearchWord" type="hidden">
<input id="fdHitPosition" name="fdHitPosition" type="hidden">
<input id="fdModelId" name="fdModelId" type="hidden">
</form>

<%--????????????--%>
<input type='hidden'  name ='entriesDesignCount'  value='${entriesDesignCount}' />
<input type="hidden" name="modelName" value="${param.modelName}" />
<input type="hidden" name="searchFields" value="${param.searchFields}" />
<input type='hidden'  name ='entriesDesignCount'  value='${entriesDesignCount}' />
<input type="hidden" name="multisSysModel" value='${multisSysModel}'/>
<input type="hidden" name="modelGroup" value="${modelGroup}" />
<input type="hidden" name="modelGroupChecked" value="${modelGroupChecked}" />



<div id="search_wrapper">
	<div id="search_head">
	<div class="box c" style="margin-left:170px">
		<a href="#" class="logo" title=""></a>
		<ul class="search_box">
		<li class="range">
				<a href="#" class="title" title=""><span><em>
				<bean:message key="search.ftsearch.current.hot.search" bundle="sys-ftsearch-db" />
				</em></span></a>
				
			
			<c:if test="${hotwordList!=null}">
			<div style="width:450px">
			
			<c:forEach items="${hotwordList}" var="hotword"  varStatus="status">
				     <a href="#" onclick="searchWord('${hotword}')">
					     ${hotword}
				     </a>				
				</c:forEach>
			
			</div>
			
				
			</c:if>
			
			</li>
			<li class="search">
			<input type="text" class="input_search" name="queryString" value="${queryString}" style="height:33px;width:440px;"
				id="q5" onkeydown="if (event.keyCode == 13 && this.value !='') CommitSearch(0);">
			<script>
	   			$(function() {
				     $("#q5").autocomplete({
				         source: function(request, response) {
				             $.ajax({
				                 url: "${KMSS_Parameter_ContextPath}sys/ftsearch/expand/sys_ftsearch_chinese_legend/sysFtsearchChineseLegend.do?method=searchTip&q="+encodeURI($("#q5").val()),
				                 dataType: "json",
				                 data: request,
				                 success: function(data) {
				                     response(data);
				                 }
				             });
				         }
				     });
				 });
			</script><!-- -->
			<a style="height:33px;cursor:pointer;" class="btn_search" onclick="CommitSearch(0);" title="<bean:message key="search.ftsearch.button.search" bundle="sys-ftsearch-db" />">
			<span><bean:message key="search.ftsearch.button.search" bundle="sys-ftsearch-db" /></span>
			</a>
			</li>
			<li>
				<c:if test="${not empty modelGroupList}">
					<c:forEach items="${modelGroupList}" var="element" varStatus="status">
						<label for="">
							<input id='${element.fdId }' type="checkbox" value="${element.fdCategoryName}" name="modelGroups"
							onclick="selectModelGroup(this,'${element.fdCategoryModel}')" 
								<c:if test="${fn:contains(modelGroupChecked, element.fdCategoryName)}">
									checked
								</c:if>
							>${element.fdCategoryName}
						</label>
					</c:forEach>	
				</c:if>
			</li>	
			<li>
			<label for="">
			<input id='type_title'
					type="checkbox" name="search_field" onclick="selectField()"
					<% if(fieldList==null || fieldList.contains("title")) { %>
							checked
					<% } %>
					 ><bean:message key="search.ftsearch.field.title" bundle="sys-ftsearch-db" />
			</label>
			
			<label for="">
			<input id='type_content'
					type="checkbox" name="search_field" onclick="selectField()"
					<% if(fieldList==null || fieldList.contains("content")) { %>
							checked
					<% } %>><bean:message key="search.ftsearch.field.content" bundle="sys-ftsearch-db" />
			</label>
			<label for=""> 
			<input id='type_attachment'
					type="checkbox" name="search_field" onclick="selectField()"
					<% if(fieldList==null || fieldList.contains("attachment")) { %>
							checked
					<% } %>><bean:message key="search.ftsearch.field.attachment" bundle="sys-ftsearch-db" />
			</label>
			<label for="">
			<input id='type_creator'
					type="checkbox" name="search_field" onclick="selectField()"
					<% if(fieldList==null || fieldList.contains("creator")) { %>
							checked
					<% } %>><bean:message key="search.ftsearch.field.creator" bundle="sys-ftsearch-db" />
			</label>
			<label for="">
			<input id='type_tag'
					type="checkbox" name="search_field" onclick="selectField()"
					<% if(fieldList==null || fieldList.contains("tag")) { %>
							checked
					<% } %>><bean:message key="search.ftsearch.field.tag" bundle="sys-ftsearch-db" />
			</label>
			</li>
		</ul>
	</div></div><!-- search_head end -->

	<div id="search_main" class="c">
		<div class="search_left">
			<div id=timeTreeDiv></div>
			<div id=fieldTreeDiv></div>
			<div id=toolTreeDiv></div>

			<dl class="dl_b">
				<dt><bean:message key="search.ftsearch.relate.word" bundle="sys-ftsearch-db" /></dt>
						<c:if test="${relevantwordList!=null}">
							<c:forEach items="${relevantwordList}" var="relevantWord"  varStatus="status">
							     <dd>
										<a  href="#" onclick="searchWord('${relevantWord}')">${relevantWord}</a>
								</dd>	 				
							</c:forEach>
						</c:if>

			</dl>

			<script>generateTimeTree();generateFieldTree();generateToolTree();</script>
		</div><!-- end search_left -->
		
	<c:if test="${queryPage==null || param.queryString==null}">
				<div class="search_con" style="height: 500px; background:url(styles/images/bg_split.gif) repeat-y; border-bottom:1px solid #efefef;">
					
				</div>
	</c:if>

	<c:if test="${not empty queryPage && queryPage!=null}">
		<% if (queryPage.getTotalrows()==0){ %>	
			<c:if test="${ not empty mapSet['queryString']}" >
				<div class="search_con" style="height: 500px">
					<ul class="search_none">
					
						<li><h3><bean:message bundle="sys-ftsearch-db" key="sysFtsearchDb.sorry"/><span style="color: red">${param.queryString}</span><bean:message bundle="sys-ftsearch-db" key="sysFtsearchDb.about" />
						</h3></li>
						<li><bean:message bundle="sys-ftsearch-db" key="sysFtsearchDb.advice" /></li>
						<li><bean:message bundle="sys-ftsearch-db" key="sysFtsearchDb.checkWrong" /></li>
						<li><bean:message bundle="sys-ftsearch-db" key="sysFtsearchDb.deleteSome" /></li>
					</ul>
				</div>
			</c:if>
		<% }
		else  
		{ %>
		
		<div class="search_con">
			<div class="search_main" style="min-height:500px; overflow:visible">
				<div class="search_result c">
					<ul class="btn_box" style="width:304px";>
						
						<li><a href="#" onclick="sortResult('time');"
						<c:if test="${param.sortType==null || param.sortType=='score'}">
						class="btn_a" 
						</c:if>
						<c:if test="${param.sortType=='time'}">
						class="btn_a_selected"
						
						</c:if>
						title=""><span><em><bean:message bundle="sys-ftsearch-db" key="search.ftsearch.sort.by.time" /></em></span></a></li>
						<li><a href="#" onclick="sortResult('score');"
						<c:if test="${param.sortType==null || param.sortType=='score'}">
						class="btn_a_selected" 
						
						</c:if>
						<c:if test="${param.sortType=='time'}">
						class="btn_a"
						</c:if>
						title=""><span><em><bean:message bundle="sys-ftsearch-db" key="search.ftsearch.sort.by.score" /></em></span></a></li>
					</ul>
					<p><bean:message bundle="sys-ftsearch-db" key="search.ftsearch.probably" />&nbsp;
						<%=queryPage.getTotalrows()%>&nbsp;<bean:message bundle="sys-ftsearch-db" key="search.ftsearch.itemResult" />
					</p>
				</div><!-- end search_result -->	

				
				<div class="search_list">
					<%--?????????????????????--%>
					<%--?????? ?????? ????????? ????????????--%>
					<%for(int i=0;i<queryPage.getList().size();i++){
						LksHit lksHit = (LksHit)queryPage.getList().get(i);
						Map lksFieldsMap = lksHit.getLksFieldsMap();
						LksField link = (LksField)lksFieldsMap.get("linkStr");
						LksField title = (LksField)lksFieldsMap.get("title");
						LksField subject = (LksField)lksFieldsMap.get("subject");
						LksField content = (LksField)lksFieldsMap.get("content");
						LksField fileName = (LksField)lksFieldsMap.get("fileName");
					//	LksField fullText = (LksField)lksFieldsMap.get("fullText");
						LksField ekpDigest = (LksField)lksFieldsMap.get("ekpDigest");//??????????????????
						LksField juniorSummary = (LksField)lksFieldsMap.get("juniorSummary");
						LksField docKey = (LksField)lksFieldsMap.get("docKey");
						LksField mimeType = (LksField)lksFieldsMap.get("mimeType");
						//?????????????????????
						LksField xmlContent = (LksField)lksFieldsMap.get("xmlcontent");
					
					
						String docInfo="";
						if(docKey != null){
							docInfo = docKey.getValue();
						}
						String linkArgu=null;
						if(docInfo.lastIndexOf("_")>-1)
							linkArgu=docInfo.substring(docInfo.lastIndexOf("_")+1);
						LksField keyword = (LksField)lksFieldsMap.get("keyword");
						LksField modelName = (LksField)lksFieldsMap.get("modelName");
						LksField category= (LksField)lksFieldsMap.get("category");
						LksField creator = (LksField)lksFieldsMap.get("creator");
						LksField createTime = (LksField)lksFieldsMap.get("createTime");  
						String linkUrl= "";
						if(link != null){
							linkUrl = link.getValue();
						}
						String mainDocLink = linkUrl;
						if(fileName!=null && StringUtil.isNotNull(linkArgu)){
							linkUrl+="&s_ftAttId=" + linkArgu;
						}
						request.setAttribute("mimeType",mimeType==null?"":mimeType.getValue()); 
						request.setAttribute("linkUrl",linkUrl); 
						request.setAttribute("mainDocLink",mainDocLink); 
						if(modelName != null){
						request.setAttribute("ResultModelName",ResultModelName.getModelName(modelName.getValue()));  
						}
						String fdDocSubject= "";
						String fdModelName= "";
						String fdCategory= "";
						String fdUrl= "";
						String fdSummary = "";
						String fdFileName = "";
						
						if(subject!=null) {
							fdDocSubject = subject.getValue();
						} else if(title!=null) {
							fdDocSubject = title.getValue();
						}else if(fileName!=null) {
							fdDocSubject = fileName.getValue();
						}
						if(modelName!=null) {
							fdModelName=modelName.getValue();
						}
						if(category!=null) {
							fdCategory=category.getValue();
						}
						if(link!=null) {
							fdUrl=linkUrl;
						}
						
						if(fileName!=null) {
							fdFileName=fileName.getValue();
						}
						
						if(content!=null) {
							fdSummary +=content.getValue();
						}
						if(xmlContent!=null){
							fdSummary += xmlContent.getValue();
						}
					//	if(fullText!=null) {
					//		fdSummary +=fullText.getValue();
					//	}
						if(ekpDigest!=null) {
							fdSummary +=ekpDigest.getValue();
						}
						
						
						String regEx_html="<[^>]+>"; //??????HTML????????????????????????
						Pattern p_html=Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE); 
				        Matcher m_html=p_html.matcher(fdDocSubject); 
				        fdDocSubject=m_html.replaceAll(""); //??????html?????? 
				        m_html=p_html.matcher(fdCategory); 
				        fdCategory=m_html.replaceAll("");
				        
				        m_html=p_html.matcher(fdModelName); 
				        fdModelName=m_html.replaceAll("");
				        
				        m_html=p_html.matcher(fdUrl); 
				        fdUrl=m_html.replaceAll("");
				        
				        m_html=p_html.matcher(mainDocLink); 
				        mainDocLink=m_html.replaceAll("");
				        
				     //   m_html=p_html.matcher(fdSummary); 
				      //  fdSummary=m_html.replaceAll("");
				        
				        //fdSummary = HtmlEscaper.escapeHTML(fdSummary);
				        //fdDocSubject = HtmlEscaper.escapeHTML2(fdDocSubject);
				        String fdTempTitle = HtmlEscaper.escapeHTML2(fdDocSubject);
				        //fdCategory = HtmlEscaper.escapeHTML(fdCategory);
				        // fdModelName = HtmlEscaper.escapeHTML(fdModelName);
				        //fdUrl = HtmlEscaper.escapeHTML(fdUrl);
					%> 
					<dl class="dl_c">
					<dt>
					<%if(fileName!=null){%>
			        	<script>
			        		document.write('<img src="${KMSS_Parameter_ResPath}style/common/fileIcon/'+GetIconNameByFileName('<%=fileName.getValue()%>')+'" height="16" width="16" border="0" />');
			        	</script>
		        	<%}%>
			        	<a href="#" onclick="readDoc('<%=fdTempTitle %>','<%=fdModelName %>','<%=fdCategory %>','<%=fdUrl %>','<%=i %>');" class="a_title"  >
			        	<%=subject!=null?subject.getValue():title!=null?title.getValue():fileName!=null?fileName.getValue():""%>
			        	</a>
		        	<%if(fileName!=null && link!=null){%>
		        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        	<a href="#" onclick="readDoc('<%=fdTempTitle %>','<%=fdModelName %>','<%=fdCategory %>','<%=mainDocLink %>','<%=i %>');" class="a_view">
		        	<bean:message bundle="sys-ftsearch-db" key="search.ftsearch.viewMainDoc" /></a>
		        	<%}%>
					</dt>
						<dd>
							<div id="summary_<%=i%>" class="summ">
								<%=fdSummary%>
							</div>
						</dd>
						<dd class="dd2">
							<bean:message bundle="sys-ftsearch-db" key="search.search.modelNames" />${ResultModelName}<span>|</span>
							<bean:message bundle="sys-ftsearch-db" key="search.search.creators" />
							<%if(creator!=null && request.getAttribute("escaperStr").equals(creator.getValue()))
							{ 
								out.println("<strong class = 'lksHit'>"+creator.getValue()+"</strong>");
							}else if(creator!=null)
							{ 
								out.println(creator.getValue());
							}%> 
							<span>|</span>
							<bean:message bundle="sys-ftsearch-db" key="search.search.createDates" /><%if(createTime!=null){	out.println(createTime.getValue());} %> 
						</dd>
					</dl>
					<%} %>
					
				</div><!-- end search_list -->
				
			</div>
			

			<div class="page">
				<!-- ?????? -->
				<span id="pagingTools">
				<sunbor:page name="queryPage" pagenoText="pagenoText2" pageListSize="10" pageListSplit="">
					<sunbor:leftPaging><b><bean:message key="page.thePrev"/></b></sunbor:leftPaging>
					{11}
					<sunbor:rightPaging><b><bean:message key="page.theNext"/></b></sunbor:rightPaging>
				</sunbor:page>
				</span>
			</div>

			<div class="search_bottom" style="padding-left:50px; width:735px;height:33px">
				<input type="text" class="input_search" name="queryString" value="${queryString}" style="height:33px;width:435px;"
					id="q6" onkeydown="if (event.keyCode == 13 && this.value !='') CommitSearch(1);">
				<script>
	   			$(function() {
				     $("#q6").autocomplete({
				         source: function(request, response) {
				             $.ajax({
				                 url: "${KMSS_Parameter_ContextPath}sys/ftsearch/expand/sys_ftsearch_chinese_legend/sysFtsearchChineseLegend.do?method=searchTip&q="+encodeURI($("#q6").val()),
				                 dataType: "json",
				                 data: request,
				                 success: function(data) {
				                     response(data);
				                 }
				             });
				         }
				     });
				 });
			</script>
				<a style="height:33px;cursor:pointer;" class="btn_search" onclick="CommitSearch(1);" title="<bean:message key="search.ftsearch.button.search" bundle="sys-ftsearch-db" />">
					<span><bean:message key="search.ftsearch.button.search" bundle="sys-ftsearch-db" /></span>
				</a>
				
				<a style="cursor:pointer;" href="#" class="btn_b" title="<bean:message key="search.ftsearch.search.on.result" bundle="sys-ftsearch-db" />" onclick="search_on_result();"><span><em><bean:message key="search.ftsearch.search.on.result" bundle="sys-ftsearch-db" /></em></span></a>
			</div>
			
		</div><!-- end search_con -->
		<%} %>
		</c:if>
		
		<div class="clear"></div>

		<div class="search_range" style="margin-left:180px">
			<p><a style="cursor:pointer;" onclick="view_select_model();" id="_strHref" title="">
					<bean:message key="search.ftsearch.search.range" bundle="sys-ftsearch-db" /></a></p>
			<ul id="hidden_div" class="ul1">
				<li id="selectLi" style="display:none" class="li_opt">
					<label for="">
						<c:if test="${empty sysNameList || sysNameList==null}">
							<input type="checkbox" onclick="selectAllModel(this,'checkbox_model');" name="" />
							<bean:message key="search.ftsearch.select.all" bundle="sys-ftsearch-db" />
						</c:if>
					</label>
					<a style="cursor:pointer;" class="btn_c" onclick="CommitSearch(2);"><span><em>
							<bean:message key="search.ftsearch.confirm" bundle="sys-ftsearch-db" /></em></span></a>
				</li>
				<!-- ?????????  2013-4-25 ?????????????????? -->
				<li class="li_range">
					<h3>
						<c:if test="${empty sysNameList || sysNameList==null}">
							<bean:message key="search.ftsearch.search.range2" bundle="sys-ftsearch-db" />
						</c:if>
						<c:if test="${not empty sysNameList && sysNameList!=null}">
							<input type="checkbox" onclick="selectAllModel(this,'checkbox_model');" name="" /> EKP???
						</c:if>		
					</h3>
					<ul id="model_view" name="model_view" class="ul2">
						<c:forEach items="${entriesDesign}" var="element" varStatus="status">
							<c:if test="${element['flag']==true}">
									<li>
										<label for="">
											${element['title']}
										</label>
									 </li>
							</c:if> 
						</c:forEach>
					</ul>
					<ul id="model_select" name="model_select" class="ul2" style="display:none">
						<c:forEach items="${entriesDesign}" var="element" varStatus="status">
									<li>
										<label for="">
											<input id='element${status.index}' type="checkbox" name="checkbox_model"
											<c:if test="${element['flag']==true}">
											checked
											</c:if> 
											 onclick="selectOutSystemModel('checkbox_model')"  value='${element['modelName']}'>${element['title']}</label>
									 </li>
						</c:forEach>		
					</ul>
					<div class="clear"></div>
				</li>
					<c:forEach items="${otherSysDesign}" var="sysDesigns" varStatus="status">
					<li class="li_range c">
						<h3>
							<c:forEach items="${sysNameList}" var="sysNames" varStatus="status2">
								<c:if test="${status.index==status2.index}">
									<input type="checkbox" onclick="selectAllModel(this,'${sysNames }');" name="sysModel" />
											${sysNames }???
									<input type="hidden" id="${sysNames}_systemName" value="" name = 'systemName'>		
								</c:if> 
							</c:forEach>
						</h3>
						<ul name="multiSysmodel_view" class="ul2">
							<c:forEach items="${sysDesigns}" var="sysDesign" varStatus="status">
								<c:if test="${sysDesign['flag']==true}">
										<li>
											<label for="">
												${sysDesign['title']}
											</label>
										 </li>
								</c:if> 
							</c:forEach>
						</ul>
						<ul name="multiSysmodel_select"  style="display:none" class="ul2" >
							<c:forEach items="${sysDesigns}" var="sysDesign" varStatus="status">
										<li>
											<label for="">
												<input id="${sysDesign['system'] }${status.index}" onclick="selectOutSystemModel('${sysDesign['system']}')" type="checkbox" name="${sysDesign['system'] }"
												<c:if test="${sysDesign['flag']==true}">
												checked
												</c:if> 
												 value='${sysDesign['modelName']}'>${sysDesign['title']}</label>
										 </li>
							</c:forEach>		
						</ul>
						
						<div class="clear"></div>
					</li>
				</c:forEach>
						
								</ul>
								<div class="clear"></div>
							</li>
			</ul>
		</div>
	</div><!-- search_main end -->
	
	<%@ include file="/resource/jsp/footer.jsp"%>

</div>
</body>
</html>