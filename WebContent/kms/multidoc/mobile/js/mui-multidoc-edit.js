define([
	"dojo/_base/declare",
	 "mui/dialog/Tip",
	 "mui/form/validate/Validation",
	 "mui/i18n/i18n!kms-multidoc:kmsMultidoc",
	 "dojo/topic", 
	 "dijit/registry",
	 "dojo/query",
	 "dojo/request",
	 "mui/util",
	], function(declare,Tip, Validation, lang,topic,registry,query,request,util) {

	
	
	
	return declare("kms.multidoc.edit", null,{
		validateUrl:'/kms/multidoc/kms_multidoc_knowledge/kmsMultidocKnowledge.do?method=checkAddSubject&fdId=!{fdId}&docSubject=!{docSubject}&cateId=!{cateId}',
		
		init: function(data){
			this.addValidation();
			var self = this
			window.knowledge_submit = function() {
				var fdId =  document.getElementsByName("fdId")[0].value;
				var docSubject = document.getElementsByName("docSubject")[0].value;
				var docCategoryId = document.getElementsByName("cateId")[0].value;
				var url = util.formatUrl(util.urlResolver(self.validateUrl, {"fdId" : fdId,"docSubject" : docSubject,"cateId": docCategoryId}));
				request.get(url, {
					 headers: {'Accept': 'application/json'},
		             handleAs: 'json'
				}).response.then(function(data) {
					if(!data || !data['text']){
						Tip.fail({"text" : lang['mui.return.failure']});
						return ;
					}
					var json = JSON.parse(data['text']);
					var fdIsExist = json['fdIsExist'];
					if(fdIsExist == true){
						Tip.fail({"text" : lang['kmsMultidoc.isExist']});
						return ;
					}
					Com_Submit(document.forms[0], 'save');
				}, function(data) {
					Tip.fail({"text" : lang['mui.return.failure']});
				});
			}
			window.changeAuthorType = function(value, e) {
					self.changeAuthorType(value, e);
			}
		},
		authorChange: function (formObj) {
			var authorType = document.getElementsByName("authorType")[0].value;
			if(authorType == "2") {
				document.getElementsByName("docAuthorId")[0].value = null;
				document.getElementsByName("docAuthorName")[0].value = null;
				$("#authorsArrary").remove();
			} else {
				document.getElementsByName("outerAuthor")[0].value = null;
			}
		},
		addValidation: function () {
			var vali = new Validation();
			var valifunc = function(v,e,o) {
				v = v.trim();
				if (v.indexOf("；")==-1 
						&& v.indexOf("，")==-1 
						&& v.indexOf(",")==-1
						&& v.indexOf(" ")==-1 
						&& v.indexOf("-")==-1 
						&& v.indexOf("_")==-1 ) {
					return true;
				}else {
					return false;
				}
			}
			vali.addValidator("checkName", lang['kmsMultidoc.validateOutAuthorFormat'], valifunc);
		},
		changeAuthorType: function(value, e) {
			document.getElementById("innerAuthor").style.display = "none";
			document.getElementById("outerAuthor").style.display = "none";
			if (value == 1) {
				query("#innerAuthor div[data-dojo-type='mui/form/Address']").every(function(item){
					var widgetObj =  registry.byId(item.id);
					widgetObj.set({
						required: true,
					});
				});
				query("#outerAuthor div[data-dojo-type='mui/form/Input']").every(function(item){
					var widgetObj =  registry.byId(item.id);
					widgetObj.set({
						required: false,
					});
				});
				document.getElementById("innerAuthor").style.display = "block";
				var fdOrgId = document.getElementsByName("fdDocAuthorList[0].fdOrgId");
				var fdAuthorFag = document.getElementsByName("fdDocAuthorList[0].fdAuthorFag");
				fdOrgId[0].setAttribute('validate', 'required');			
				fdAuthorFag[0].setAttribute('validate', 'required');
				
			}
			if (value == 2) {
				query("#outerAuthor div[data-dojo-type='mui/form/Input']").every(function(item){
					var widgetObj =  registry.byId(item.id);
					widgetObj.set({
						required: true,
					});
				});
				query("#innerAuthor div[data-dojo-type='mui/form/Address']").every(function(item){
					var widgetObj =  registry.byId(item.id);
					widgetObj.set({
						required: false,
					});
				});
				document.getElementById("outerAuthor").style.display = "block";
				var fdOrgId = document.getElementsByName("fdDocAuthorList[0].fdOrgId");
				var fdAuthorFag = document.getElementsByName("fdDocAuthorList[0].fdAuthorFag");
				fdOrgId[0].setAttribute('validate', '');			
				fdAuthorFag[0].setAttribute('validate', '');				
			}
		},
		/**
		*将部门和岗位修改为作者的部门和岗位
		*/
		changeAuthodInfo :function(value, e) {
			if(value) {
				var authorId = value;
				var authors=authorId.split(";");
				var limit = 15;
				if(authors.length>limit){
					Tip.fail({"text" : lang['kmsMultidoc.selectAuthor.DataVolume']});
				    var values = e.curIds.split(";");
				    var names = e.curNames.split(";");
				    var val = "";
				    var nam = "";
				    for(var i=0;i<limit;i++){
				    	val += values[i]+";";
				    	nam += names[i]+";";
				    }
				    var vl = val.length - 1 <=0?0:val.length - 1;
				    var nl = nam.length - 1 <=0?0:nam.length - 1;
				    val = val.substring(0,vl);
				    nam = nam.substring(0,nl);
					setTimeout(function(){
					 	e.set("value", val);
					 	e.set("curIds", val);
					 	//curNames时开始渲染;
					 	e.set("curNames", nam);
					},250) 
					document.getElementById("authorsArrary").innerHTML = document.getElementById("authorsArrary").innerHTML;
				}else{
					var htmlVL="";
					for(var i=0;i<authors.length;i++){
						htmlVL+="<tr><td><input class='fdOrgIds' type='hidden' name='fdDocAuthorList["+i+"].fdOrgId' value='"+authors[i]+"'><input type='hidden' class='fdAuthorFags' name='fdDocAuthorList["+i+"].fdAuthorFag' value='"+i+"'></td></tr>";
					}
					document.getElementById("authorsArrary").innerHTML = htmlVL;
				}
			}
		}
	});
});