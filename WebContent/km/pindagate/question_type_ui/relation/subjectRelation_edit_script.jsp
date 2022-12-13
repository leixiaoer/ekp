<%@ page language="java" pageEncoding="UTF-8"%>
<style type="text/css">
.btnopt {
	color: #fff;
	background-color: #47b5ea;
	height: 22px;
	line-height: 12px;
	padding: 3px 5px;
	border: 0px;
	letter-spacing: 1px;
	cursor: pointer;
}
span.relationFont {
    cursor: pointer;
    color: blue;
}
.related_head_l {
    width: 50%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
</style>
<script type="text/javascript"
	src='<c:url value="/km/pindagate/resource/ajaxupload.3.6.js"/>'></script>
<script type="text/javascript"
	src="${LUI_ContextPath}/resource/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	Com_IncludeFile("jquery.js|json2.js");

	
	function selectMaxPoints(id){
		
		var CutOption = function( selectObj, length ) {
			this.selectObj = selectObj 
			this.length = length;
			this.computeLength = function(  scrLenght,  text){
				var len = scrLenght
				for(var i=0;i<scrLenght;i++){
					var   c = text.charCodeAt(i)
					if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {
					       len++;
				     }
				}
				return len;
			}
		}
		CutOption.prototype.init = function() {
			this.options = this.selectObj.getElementsByTagName('option')
			for(var i=0;i<this.options.length;i++){
				var text = this.options[i].firstChild.nodeValue
				var  len = this.computeLength(this.length,text)
				if(text.length <= this.length) {
					continue;
				}else{
					this.options[i].innerHTML = text.substring(0, len)+ '...'
					this.options[i].title = text
				}
			}
		}

		var obj = document.getElementById(id);
		var len = Math.floor(parseFloat( getComputedStyle( obj, false ).width )/16); // ——传入字体大小
		var optionClass = new CutOption(obj, len);
		optionClass.init();	
	}
	var _dialog;
	seajs.use(['lui/jquery','lui/dialog'], function($,dialog){
		_dialog=dialog;
		$(document).ready(function () {
			
			var timer = setInterval(function() {
				var dialogR = $dialog;
				if (!dialogR) {
					return;
				} else {
					clearInterval(timer);
				}
				var questionDefs = $dialog.content.params.questionDefs,
					index = $dialog.content.params.index,
					jt = $dialog.content.params.jt;
					subjectRelationRel = $dialog.content.params.subjectRelation;
					typeJson = $dialog.content.params.typeJson;
					fdIds = $dialog.content.params.fdId;
				$("input[name='subjectRelationDef']").val(JSON.stringify(questionDefs));
				$("input[name='subjectRelationIndex']").val(index);
				$("input[name='subjectRelationJt']").val(jt);
				$("input[name='fdTypeRelation']").val(JSON.stringify(typeJson));
				$("input[name='subjectRelation']").val(JSON.stringify(subjectRelationRel));
				$("input[name='fdId']").val(fdIds);
				var subjet={},
					items={};
				for (var i = 0; i < index; i++) {
					var jsonStr=JSON.parse(questionDefs);
					var title=jsonStr[i];
					if (title) {
						jsonStr=JSON.parse(title);
						subjet[i]=jsonStr.subject;
						items[i]=jsonStr.items;
					}
				}
				var stringItems = JSON.stringify(items);
				 $("input[name='subjectItems']").val(stringItems);
				if (subjectRelationRel) {
					subjectRelationRel=JSON.parse(subjectRelationRel);
					typeJson=JSON.parse(typeJson);
					for ( var f in subjectRelationRel) {
						if (subjectRelationRel[f].sign=="false") {
							continue;
						}
						var count=parseInt(f)+parseInt("1");
						var id = "mySelect"+f
						var html='<tr id="subRelation'+f+'"> <td class="related_td_title"><bean:message bundle="km-pindagate" key="kmPindagate.relation.relatedTopics"/><sapn id="count'+f+'">'+count+'</span>：</td>';
						html+='<td class="related_td_content"><select class="related_title_select" id="'+id+'" name="'+f+'" onchange="changeItems(this)" >';
						html+='<option value="-1"><bean:message bundle="km-pindagate" key="kmPindagate.relation.choiceRelatedTopics"/></option>';
						for (var q = 0; q < index; q++) {
							if (subjet[q]) {
								var titleTi=null;
								if (typeJson[q]=="1") {
									titleTi="[<bean:message bundle='km-pindagate' key='kmPindagateQuestion.type.multiselect'/>]";
								}
								if (typeJson[q]=="2") {
									titleTi="[<bean:message bundle='km-pindagate' key='kmPindagateQuestion.type.singleselect'/>]";
								}
								html+='<option value="'+q+'">'+subjet[q]+' '+titleTi+'</option>'
							}
						}
						html+='</select>';
						if (subjectRelationRel[f].multiseSel=="") {
							html+='<dl class="related_list_dl" id="choiceTopic'+f+'"> <dt><bean:message bundle="km-pindagate" key="kmPindagate.relation.upperSelection"/></dt></dl>';
						}else{
							html+='<dl class="related_list_dl" id="choiceTopic'+f+'"> <dt><bean:message bundle="km-pindagate" key="kmPindagate.relation.topTitle"/><select id="optSelect'+f+'"><option value="1"><bean:message bundle="km-pindagate" key="kmPindagate.relation.byChoice"/></option><option value="2"><bean:message bundle="km-pindagate" key="kmPindagate.relation.noChoice"/></option></select><bean:message bundle="km-pindagate" key="kmPindagate.relation.nextOption"/></dt></dl>';
						}
						html+='<ul class="related_list_ul" id="itemsList'+f+'"></ul>';
						html+='<dl id="topicRelation'+f+'"></dl>';
						html+=' <td class="related_td_opt"><i class="related_icon related_icon_del lui_text_primary" onclick="delRelation(this,'+f+')" ><bean:message key="button.delete"/></i></td></tr>';
						
						
						 $("#multiselectList").append(html);
						 $('#mySelect'+f).find('option[value="'+subjectRelationRel[f].topic+'"]').attr('selected','selected');
						 $('#optSelect'+f).find('option[value="'+subjectRelationRel[f].opt+'"]').attr('selected','selected');
						 var htmlText="",
						 	topicNub=subjectRelationRel[f].topic,
						 	topicVal=items[topicNub];
							for (var c = 0; c < topicVal.length; c++) {
								htmlText = htmlText+'<li><label class="related_radio"><input type="checkbox" name="item'+f+'" value="'+c+'"/>'+topicVal[c][0]+"</label></li>";
							}
						 $("#itemsList"+f+"").html(htmlText);
						 var inputCount = $('input[name="item'+f+'"]');
						 var itemfolVal={};
						 var itemCheck=$("input[name='item"+f+"']");
							for (var g = 0; g < itemCheck.length; g++) {
								if (itemCheck[g]) {
									itemfolVal[g]=itemCheck[g].nextSibling.nodeValue;
								}
							}
							
						 for (var z =0;z<inputCount.length;z++) {
							 for ( var b in subjectRelationRel[f].itemKeyVal) {
								 if (subjectRelationRel[f].itemKeyVal[b]==itemfolVal[z]) {
									 inputCount[z].checked = true;
								}
							}
							 /* for (var x =0;x<subjectRelationRel[f].itemVals.length;x++) {
								 if (subjectRelationRel[f].itemVals[x]===inputCount[z].value) {
									 inputCount[z].checked = true;
						         }
							 } */
						 }  
						 
						 var  topicHtml="";
						if (subjectRelationRel[f].multiseSel!=""&&subjectRelationRel[f].multiseSel!=null) {
							 topicHtml=topicHtml+'<label class="related_radio"><select id="multiselectTopic'+f+'"><option value="1"><bean:message bundle="km-pindagate" key="kmPindagate.relation.oneOfThem"/></option><option value="2"><bean:message bundle="km-pindagate" key="kmPindagate.relation.allOptions"/></option></select><bean:message bundle="km-pindagate" key="kmPindagate.relation.titleShow"/></label>';
						}
						if (subjectRelationRel[f].multiseSel=="") {
							topicHtml=topicHtml+'<label class="related_radio"><bean:message bundle="km-pindagate" key="kmPindagate.relation.anyOne"/></label>';
						}
						$("#topicRelation"+f+"").html(topicHtml);
						if (subjectRelationRel[f].multiseSel!=""&&subjectRelationRel[f].multiseSel!=null) {
							 $('#multiselectTopic'+f).find('option[value="'+subjectRelationRel[f].multiseSel+'"]').attr('selected','selected');
						}
						selectMaxPoints(id);
					}
					var rowCount = $('#multiselectList tr').length;
					if (parseInt(rowCount)>=2) {
						$("#flagTd").show();
						$("input[name=flagRelation]:eq("+subjectRelationRel[f].flagRelation+")").attr("checked", 'checked'); 
					}else{
						$("#flagTd").hide();
					}
				}
			}, 100);
		}); 
	});
</script>
<%@include
	file="/km/pindagate/question_type_ui/common/common_edit_script.jsp"%>
<script type="text/javascript">
	/** 
	
	* 模态窗口打开时载入初始内容
	*/
	function checkValueShow(){
		if (document.getElementById("willProblem").checked==true) {
			$("#willValue").css("display","contents");
		}else{
			$("#willValue").css("display","none");
		}
	}
	
	/**
	* 保存操作重新设置相关变量的值
	*/
	function save(){
		var statisticPic = "histogram";
		try{
			var rowCount = $('#multiselectList tr').length,
				relationSubject={};
			for (var i = 0; i < rowCount; i++) {
				//关联题目
				var options=$("#mySelect"+i+" option:selected"), 
				optionsVal=options.val();
				if (optionsVal=="-1") {
					_dialog.alert("${lfn:message('km-pindagate:kmPindagate.relation.titlePrompt')}".replace('%number%',(i+1)));
					return;
				}
				tbInfo = window.parent.DocList_TableInfo['TABLE_DocList'];
				tbCount=0;
				for(var b = 2; b<tbInfo.lastIndex; b++){
					if (tbCount==optionsVal) {
						fields = $(tbInfo.DOMElement.rows[b]).find(".fdId");
						for(var j=0; j<fields.length; j++){
							if (fields[j].value) {
								var fieldsVal= fields[j].value;
							}
						}
					}
					tbCount++;
				}
				
				//以选择or未选择
				var optSelect=$("#optSelect"+i+" option:selected"), 
				optSelectVal=optSelect.val();
				
				//关联选项
				var itemVal=[],
					itemKeyVal={};
				$("input[name='item"+i+"']:checked").each(function(i){
					var itemsVal=$(this).val();
					itemVal.push(itemsVal);
				});
				var itemCheck=$("input[name='item"+i+"']");
				for (var g = 0; g < itemCheck.length; g++) {
					if (itemCheck[g].checked) {
						itemKeyVal[g]=itemCheck[g].nextSibling.nodeValue;
					}
				}
				
				if (itemVal=="") {
					_dialog.alert("${lfn:message('km-pindagate:kmPindagate.relation.itemPrompt')}".replace('%number%',(i+1)));
					return;
				}
				
				//题目显示
				var multiselectTopic=$("#multiselectTopic"+i+" option:selected"), 
				multiseSelVal=multiselectTopic.val();
				if (!multiseSelVal) {
					multiseSelVal="";
				}
				var flagRelation="";
				if (rowCount>=2) {
					flagRelation = $("input[name='flagRelation']:checked").val();
				}
				var currentTopic=$("input[name='subjectRelationIndex']").val();
				relationSubject[i]={fdId:fieldsVal,currentTopic:currentTopic,topic:optionsVal,itemVals:itemVal,opt:optSelectVal,multiseSel:multiseSelVal,flagRelation:flagRelation,itemKeyVal:itemKeyVal,sign:"true"};
			}
			
			var encoded = JSON.stringify(relationSubject); 
			window.parent.subjectRelation=encoded;
			if(window.$dialog){
				window.$dialog.hide();
			}else{//兼容旧UED
				opener._closeDialog();
				window.close();
			}
		}catch (e) {
			_dialog.alert(e.name + ": " + e.message);
		}
	}
	
	//清空
	function allEmpty(){
		$("#multiselectList").html("");
		$("#flagTd").html("");
	}
	//关闭窗口
	function _close(){
		if(window.$dialog){
			window.$dialog.hide();
		}else{//兼容旧UED
			window.close();
		}
	}
	
	function addRelationItem() {
		var defJson=$("input[name='subjectRelationDef']").val(),
			defIndex=$("input[name='subjectRelationIndex']").val(),
			defJt=$("input[name='subjectRelationJt']").val();
		
		
		var subjet={},
			items={};
		for (var i = 0; i < defIndex; i++) {
			var jsonStr=JSON.parse(defJson);
			jsonStr=JSON.parse(jsonStr);
			var title=jsonStr[i];
			if (title) {
				jsonStr=JSON.parse(title);
				subjet[i]=jsonStr.subject;
				items[i]=jsonStr.items;
			}
		}
		var rowCount = $('#multiselectList tr').length;
		 var stringItems = JSON.stringify(items);
		 var count=0;
		 for ( var j in items) {
			count++
		}
		 //已超过可关联题目数量
		 if (rowCount>count-1) {
			 _dialog.alert("${lfn:message('km-pindagate:kmPindagate.relation.overQuantity')}");
			 return;
		}
		if (parseInt(rowCount)>=1) {
			$("#flagTd").show();
		}else{
			$("#flagTd").hide();
		}
		 $("input[name='subjectItems']").val(stringItems);
		 var itemsRow = parseInt(rowCount);
		 var fdType = $("input[name='fdTypeRelation']").val(),
			titleTi=null,
			jsonType=JSON.parse(fdType);
			jsonType=JSON.parse(jsonType),
		 	count=parseInt(rowCount)+parseInt("1");
			var  id =  "mySelect"+rowCount
		var html='<tr id="subRelation'+rowCount+'"> <td class="related_td_title"><bean:message bundle="km-pindagate" key="kmPindagate.relation.relatedTopics"/><sapn id="count'+count+'">'+count+'</span>：</td>';
			html+='<td class="related_td_content"><select class="related_title_select" id="'+id+'" name="'+itemsRow+'" onchange="changeItems(this)" >';
			html+='<option value="-1"><bean:message bundle="km-pindagate" key="kmPindagate.relation.choiceRelatedTopics"/></option>';
			for (var q = 0; q < defIndex; q++) {
				if (subjet[q]) {
					if (jsonType[q]=="1") {
						titleTi="[<bean:message bundle='km-pindagate' key='kmPindagateQuestion.type.multiselect'/>]";
					}
					if (jsonType[q]=="2") {
						titleTi="[<bean:message bundle='km-pindagate' key='kmPindagateQuestion.type.singleselect'/>]";
					}
					html+='<option value="'+q+'">'+subjet[q]+' '+titleTi+'</option>'
				}
			}
		html+='</select>';
		
		html+='<dl class="related_list_dl" id="choiceTopic'+rowCount+'"> </dl>';
		html+='<ul  class="related_list_ul" id="itemsList'+rowCount+'"></ul>';
		html+='<dl class="related_list_dl" id="topicRelation'+rowCount+'"></dl>';
		html+=' <td class="related_td_opt"><i class="related_icon related_icon_del lui_text_primary" onclick="delRelation(this,'+rowCount+')" ><bean:message key="button.delete"/></i></td></tr>';
		
		 $("#multiselectList").append(html);
		 selectMaxPoints(id);
		 
	}

	function changeItems(data) {
		var subjectIndex=$("input[name='subjectRelationIndex']").val(),
			itemsRow = parseInt(data.name);
		$("#itemsList"+itemsRow+"").html("");
		var htmlText="",
			dataKey="#"+data.id,
			options=$(dataKey+" option:selected"), 
			index=options.val(),
			items = $("input[name='subjectItems']").val(),
			showStr="",
			itemsJson=JSON.parse(items);
		for (var u = 0; u < subjectIndex; u++) {
			var dataKey1="#mySelect"+u;
			if (dataKey==dataKey1) {
				continue;
			}
			var currentStr=$(dataKey1+" option:selected"),
			currentCount=currentStr.val();
			if (currentStr) {
				if (currentCount==index) {
					$(dataKey+" option:first").prop("selected", 'selected');
					$("#itemsList"+itemsRow+"").html("");
					$("#choiceTopic"+itemsRow+"").html("");
					$("#topicRelation"+itemsRow+"").html("");
					$("#multiselectTopic"+itemsRow+"").html("");
					showStr="false";
					if (currentCount!="-1"&&index!="-1") {
						_dialog.alert("${lfn:message('km-pindagate:kmPindagate.relation.nonRepeatable')}");
					}
					break;
				}
			}
			
		}
		
		if (showStr!="false") {
			var  topicHtml="",
				choiceTopic="",
				fdType = $("input[name='fdTypeRelation']").val(),
				jsonType=JSON.parse(fdType);
				jsonType=JSON.parse(jsonType);
				
			for ( var f in jsonType) {
				if (f==index) {
					if (jsonType[f]) {
						if (jsonType[f]=="1") {
							choiceTopic=choiceTopic+'<dt><bean:message bundle="km-pindagate" key="kmPindagate.relation.topTitle"/><select id="optSelect'+itemsRow+'"><option value="1"><bean:message bundle="km-pindagate" key="kmPindagate.relation.byChoice"/></option><option value="2"><bean:message bundle="km-pindagate" key="kmPindagate.relation.noChoice"/></option></select><bean:message bundle="km-pindagate" key="kmPindagate.relation.nextOption"/></dt>'
						}
						if (jsonType[f]=="2") {
							choiceTopic=choiceTopic+'<dt><bean:message bundle="km-pindagate" key="kmPindagate.relation.upperSelection"/></dt>'
						}
					}
				}
			}
			
			$("#choiceTopic"+itemsRow+"").html(choiceTopic);
			
			for ( var u in itemsJson) {
				if (u==index) {
					for (var i = 0; i < itemsJson[u].length; i++) {
						htmlText = htmlText+'<li><label class="related_radio"><input type="checkbox" name="item'+itemsRow+'" value="'+i+'"/>'+itemsJson[u][i][0]+"</label></li>";
					}
				}
			}
			$("#itemsList"+itemsRow+"").html(htmlText);
			
			for ( var g in jsonType) {
				if (g==index) {
					if (jsonType[g]) {
						if (jsonType[g]=="1") {
							topicHtml=topicHtml+'<label class="related_radio"><select id="multiselectTopic'+itemsRow+'"><option value="1"><bean:message bundle="km-pindagate" key="kmPindagate.relation.oneOfThem"/></option><option value="2"><bean:message bundle="km-pindagate" key="kmPindagate.relation.allOptions"/></option></select><bean:message bundle="km-pindagate" key="kmPindagate.relation.titleShow"/></label>';
						}
						if (jsonType[g]=="2") {
							topicHtml=topicHtml+'<label class="related_radio"><bean:message bundle="km-pindagate" key="kmPindagate.relation.anyOne"/></label>';
						}
					}
				}
			}
			$("#topicRelation"+itemsRow+"").html(topicHtml);
		}
		
	}
	
	function delRelation(img,index) {
		var rowCount = $('#multiselectList tr').length;
		if (parseInt(rowCount)<=parseInt("2")) {
			$("#flagTd").hide();
		}
		var table=img.parentNode.parentNode.parentNode;
		table.removeChild(img.parentNode.parentNode);
		var trsLength=$('#multiselectList tr').length;
		var trs=$('#multiselectList tr');
		//更新序号
		for(var i=0;i<trsLength;i++){
			var tr = trs.eq(i),
				serialTd = tr.children().eq(0),
				subRelation =  trs.eq(i),
				itemsList = $('[id^="itemsList"]',tr[0]),
				topicRelation = $('[id^="topicRelation"]',tr[0]),
				mySelect = $('[id^="mySelect"]',tr[0]),
				optSelect = $('[id^="optSelect"]',tr[0]),
				item = $('[name^="item"]',tr[0]),
				count = $('[id^="count"]',tr[0]),
				choiceTopic = $('[id^="choiceTopic"]',tr[0]),
				multiselectTopic = $('[id^="multiselectTopic"]',tr[0]);
			subRelation.attr('id','subRelation'+i);
			itemsList.attr('id','itemsList'+i);
			topicRelation.attr('id','topicRelation'+i);
			mySelect.attr('id','mySelect'+i);
			mySelect.attr('name',i);
			optSelect.attr('id','optSelect'+i);
			item.attr('name','item'+i);
			multiselectTopic.attr('id','multiselectTopic'+i);
			count.attr('id','count'+i);
			choiceTopic.attr('id','choiceTopic'+i);
			var nb=parseInt(i)+parseInt("1");
			$('#count'+i).html(nb);
		}
		
	}
	var  randerFdName = function(timer,el){
		var text = el.text()
		if(text !=null && text !=""){
			el.attr("title",el.text())
			window.clearInterval(timer)
		}
	}
	var  timer = setInterval(function(){
		var  el = $(".related_head_l").find('#fdName')
		randerFdName(timer,el);
	},100)
	
</script>