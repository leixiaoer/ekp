<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.pindagate.util.*" language="java"%>
<%@ page import="com.landray.kmss.util.KmssMessageWriter,com.landray.kmss.util.KmssReturnPage" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  width="980px"  sidebar="no" showQrcode="false">
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/pindagate/vote.css">
	</template:replace>
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value=""></c:out>
	</template:replace>
	
	<%--编辑内容--%>
	<template:replace name="content"> 
		<style type="text/css" >a:HOVER {text-decoration: underline;}</style>
		<script type="text/javascript">
			Com_Parameter.CloseInfo="<bean:message key='message.closeWindow'/>";
			Com_IncludeFile("docutil.js|jquery.js|json2.js|ajaxupload.3.6.js", null, "js");
			Com_IncludeFile("kmPindagateQuestion_preview.js",'${LUI_ContextPath}/km/pindagate/km_pindagate_question_ui/',"js",true);
		</script>
		<% if(request.getAttribute("KMSS_RETURNPAGE")==null){ %>
			<logic:messagesPresent>
				<table align=center><tr><td>
					<font class="txtstrong"><bean:message key="errors.header.vali"/></font>
					<bean:message key="errors.header.correct"/>
					<html:messages id="error">
						<br><img src='${KMSS_Parameter_StylePath}msg/dot.gif'>&nbsp;&nbsp;<bean:write name="error"/>
					</html:messages>
				</td></tr></table>
				<hr />
			</logic:messagesPresent>
		<%}else{
			KmssMessageWriter msgWriter = new KmssMessageWriter(request, (KmssReturnPage)request.getAttribute("KMSS_RETURNPAGE"));
		%>
		<script>
			Com_IncludeFile("msg.js", "style/"+Com_Parameter.Style+"/msg/");
			function showMoreErrInfo(index, srcImg){
				var obj = document.getElementById("moreErrInfo"+index);
				if(obj!=null){
					if(obj.style.display=="none"){
						obj.style.display="block";
						srcImg.src = Com_Parameter.StylePath + "msg/minus.gif";
					}else{
						obj.style.display="none";
						srcImg.src = Com_Parameter.StylePath + "msg/plus.gif";
					}
				}
			}
		</script>
		<table align=center>
			<tr>
				<td><%= msgWriter.DrawTitle() %><br style="font-size:10px"><%= msgWriter.DrawMessages() %></td>
			</tr>
		</table>
		<%}%>
		<input type="hidden" id="questions" />
		
		<div class='lui_form_title_frame'>
			<%--调查题目--%>
			<div class='lui_form_subject' ><c:out value="${param.docSubject}"></c:out> </div>
		</div>
		<div class='lui_form_content_frame' style="margin:0px 10px;min-height: 600px;">
			<%--Page--%>
			<div class="page">
				<div class="left">
					<bean:message key="page.the"/><font class="com_number" name="currentPage">1</font><bean:message key="page.page"/>
					<bean:message key="page.total"/><font class="com_number" name="totalPage">1</font><bean:message key="page.page"/>
				</div>
				<div style="float: right;">
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.pre')}" onclick="changePage('prev');" id="prev1"></ui:button>&nbsp;
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.next')}" onclick="changePage('next');" id="next1"></ui:button>
				</div>
				<div style="clear: both;"></div>
			</div>
			<div class="pi_container">
				<div class="pi_box">
					<div class="pi_content" id="Div_Preview_Questions" ></div>
				</div>
			</div>
			<%--Page--%>
			<div class="page pageborder">
				<div class="left">
					<bean:message key="page.the"/><font class="com_number" name="currentPage">1</font><bean:message key="page.page"/>
					<bean:message key="page.total"/><font class="com_number" name="totalPage">1</font><bean:message key="page.page"/>
				</div>
				<div style="float: right;">
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.pre')}" onclick="changePage('prev');" id="prev2"></ui:button>&nbsp;
					<ui:button text="${lfn:message('km-pindagate:kmPindagateMain.page.next')}" onclick="changePage('next');" id="next2"></ui:button>
				</div>
				<div style="clear: both;"></div>
			</div>
			<c:if test="${param.param == 'edit'}">
			<%--提交按钮--%>
			<div style="width:100%;text-align: center;">
				<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion_preview.save')}" order="5" onclick="save();"></ui:button>
			</div>
			</c:if>
		</div>
		<script type="text/javascript">
			var _dialog;
			seajs.use(['lui/dialog'], function(dialog) {
				_dialog=dialog;
			});
			var serialNum = 0;
			LUI.ready(function (){
				var obj = top._questions||opener._questions;
				$('#questions').val(eval("("+obj.value+")"));
				window.questions = eval("("+obj.value+")");
				preview_init(eval("("+obj.value+")"));
			});
			function preview_init(questions){
				var flag = false;
				var k = -1;
				for(var index = 0 in questions){
					if(questions[index].fdSplit == "true"){
						if(index == questions.length-1){
							questions[index].fdQuestionDef = "delete";
						}
						if(flag){
							flag = false;
							k = index;
						}else{
							questions[index].fdQuestionDef = "delete";
						}
					}else{
						if(questions[index].fdQuestionDef != "delete"){
							flag = true;
						}
					}
				}
				if(!flag && k!=-1){
					questions[k].fdQuestionDef = "delete";
				}
				$('#questions').val(JSON.stringify(questions));
				serialNum = 0;
				
				if(questions != null && questions != "")
					$('#questions').val(JSON.stringify(questions));
				$('#Div_Preview_Questions').html("");
				var showIndex = 0;
				for(var index = 0 in questions){
					var questionTypes = eval("("+questions[index].questionTypes+")");
					var questionType = "";
					for(var key = 0 in questionTypes){
						if(questions[index].fdType == questionTypes[key].quesTypeId)
							questionType = questionTypes[key];
					}
					var divId = questions[index].fdType+index;
					var loadHTML = '<div name="div_'+questions[index].fdType+'">';
					loadHTML += '<input type="hidden" id="fdQuestionDef'+index+'" >';
					loadHTML += '<input type="hidden" id="fdType'+index+'" >';
					loadHTML += '<input type="hidden" id="fdSplit'+index+'" >';
					loadHTML += '<input type="hidden" id="serialNum'+index+'" >';
					loadHTML += '<input type="hidden" id="fdOrder'+index+'" >';
					loadHTML += '<input type="hidden" id="fdTitle'+index+'" >';
					loadHTML += '<input type="hidden" id="fdSubjectImg'+index+'" >';
					loadHTML += '<input type="hidden" id="quesTypeId'+index+'" >';
					loadHTML += '<input type="hidden" id="quesTypeName'+index+'" >';
					loadHTML += '<input type="hidden" id="editUrl'+index+'" >';
					loadHTML += '<input type="hidden" id="fdAnswer'+index+'" >';
					loadHTML += '<div id="'+divId+'" class="pi_question"';
					if("${JsParam.param}"=='edit'){
						loadHTML += ' onMouseOver="div_onMouseOver(this);" onMouseOut="div_onMouseOut(this);"';
					}
					loadHTML += '></div></div>';
					$('#Div_Preview_Questions').append(loadHTML);
					setInputVal(index,questions[index],questionType);//设置每道题目的题型定义等信息
					if(questions[index].fdSplit != "true" && questions[index].fdQuestionDef != "delete"){
						showIndex ++;
						$('#'+divId).load('<c:url value = "/'+questionType.previewUrl+'?&showIndex='+showIndex+'&index='+index+'&divId='+divId+'" />',function(){
							changePage("current");
						});
					}
				}
				if (questions.length == 0) {
					$("#prev1,#prev2,#next1,#next2").css("display","none");
				}
			}
			function setInputVal(index,questionObj,questionType){
				$('#fdQuestionDef'+index).val(questionObj.fdQuestionDef);
				$('#fdType'+index).val(questionObj.fdType);
				$('#fdSplit'+index).val(questionObj.fdSplit);
				if(questionObj.fdSplit != "true")
					$('#serialNum'+index).val(++serialNum);
				$('#fdOrder'+index).val(questionObj.fdOrder);
				try{		
					var obj = eval("("+questionObj.fdQuestionDef+")");
					$('#fdTitle'+index).val(obj.subject);
					$('#fdSubjectImg'+index).val(obj.subjectImg);
				}catch(e){}
				$('#quesTypeId'+index).val(questionType.quesTypeId);
				$('#quesTypeName'+index).val(questionType.quesTypeName);
				$('#editUrl'+index).val(questionType.editUrl);
				$('#fdAnswer'+index).val("");
			}
			function div_onMouseOver(_this){  
				_this.style.borderWidth = "1px";
				_this.style.borderColor	= "#CA0C00";
				_this.style.borderStyle	= "solid";
				var tipDiv = $('p[name="tip"]',$(_this));
				tipDiv.show();
			}
			function div_onMouseOut(_this){
				_this.style.border = "1px solid #EDEDED";
				_this.style.borderWidth = "1px 0px 0px";
				var tipDiv = $('p[name="tip"]',$(_this));
				tipDiv.hide();
			}
			function modifyTitleVal(_this){
				return 0;
				var span = $(_this);
				var input = $('<input type="text" class="pi_txtTitle"/>');
				span.click(function(){return false});
				input.click(function(){return false});
				var spanVal = span.html();
				span.html('');
				input.css('width','600px').css('background','transparent').val(spanVal).appendTo(span);
				input.trigger('focus').trigger('select');
				input.blur(function(){
					span.html(input.val());
					var fdTitleId = span.attr("id");
					var index = fdTitleId.replace("fdTitle","");
					var questions = eval("("+($('#questions').val())+")");
					var questionDefObj = eval("("+(questions[index].fdQuestionDef)+")");
					questionDefObj.subject = input.val();//重新设置题型定义里面subject的值;
					questions[index].fdTitle = input.val();//重新设置题目的值
					questions[index].fdQuestionDef = JSON.stringify(questionDefObj);
					$('#fdQuestionDef'+index).val(JSON.stringify(questionDefObj));
					$('#questions').val(JSON.stringify(questions));
				});
			}
			/**
			 * 换页
			 * 	   _method : prev(上一页)、next(下一页)、current(当前页)
			 */
			function changePage(_method){
				if($('#questions').val() == null || $('#questions').val() == '')
					return;
				var questions = eval("("+($('#questions').val())+")");
				var currentPage = $('font[name="currentPage"]').html();
				var totalPage = $('font[name="totalPage"]').html();
				if(_method == "prev")
					currentPage = parseInt(currentPage)-1;
				else if(_method == "next")
					currentPage = parseInt(currentPage)+1;
				else
					currentPage = parseInt(currentPage);
				if(currentPage == 1){
					LUI("prev1").setDisabled(true);
					LUI("prev2").setDisabled(true);
				}else{
					LUI("prev1").setDisabled(false);
					LUI("prev2").setDisabled(false);
				}
				if(currentPage == 0){
					_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateResponse.alreadyTheFirstPage'/>");
					return;
				}
				if(currentPage > parseInt(totalPage)){
					_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateResponse.alreadyTheEndPage'/>");
					return;
				}
				var divID = "";
				totalPage = 1;
				for(var index in questions){
					divID = questions[index].fdType+index;
					if(questions[index].fdSplit == "true" ){
						if(questions[index].fdQuestionDef != "delete"){
						totalPage++;
						}
						$('#'+divID).hide();
						continue;
					}
					if(totalPage == currentPage){
						$('#'+divID).show();
					}else{
						$('#'+divID).hide();
					}
				}
				if (currentPage == parseInt(totalPage)) {
					LUI("next1").setDisabled(true);
					LUI("next2").setDisabled(true);
				}else{
					LUI("next1").setDisabled(false);
					LUI("next2").setDisabled(false);
				}
				if (totalPage == 1) {
					$("#prev1,#prev2,#next1,#next2").css("display","none");
				}
				$('font[name="currentPage"]').html(currentPage);
				$('font[name="totalPage"]').html(totalPage);
			}
			/**
			 * 删除
			 */
			function deleteQuestion(index){
				var questions = eval("("+($('#questions').val())+")");
				questions[index].fdQuestionDef = "delete";
				$('#questions').val(JSON.stringify(questions));
				preview_init(questions);
			}
			/**
			 * 题目编辑之后重新设置题型定义的值
			 */
			function setFdQuestionDef(fdQuestionDef,index){
				var questions = eval("("+($('#questions').val())+")");
				questions[index].fdQuestionDef = JSON.stringify(fdQuestionDef);
				var subject = fdQuestionDef.subject.replace(/&nbsp;/g," ");
		        subject = subject.replace(/<style[^>]*>[^<]*<\/style>/ig, "");
		        subject = Com_HtmlEscape(subject);
		        fdTitle = $("<div></div>").append(subject).text();
				questions[index].fdTitle = fdTitle;
				$('#questions').val(JSON.stringify(questions));
			}
			//保存操作重新设置相关变量的值
			function save(){
				var obj = top._questions||opener._questions;
				var questions = document.getElementById("questions");
				 obj.value = questions.value;
				 if(window.$dialog){
					$dialog.hide(obj);
				}else{
					opener._closeDialog(obj);
					window.close();
				}
			}
			function arrayDel(arr,n) {  	
				  if(n<0)  
				    return arr;
				  else
				    return arr.slice(0,n).concat(arr.slice(n+1,arr.length));	    
			}
			function getContextPath(){
				return "${KMSS_Parameter_ContextPath}";
			} 
			function hideTooltip(){
				var divObj=$("#dHTMLToolTip");
				divObj.css({"top":1,"left":1});
				divObj.hide();
				//var divObj = document.getElementById("dHTMLToolTip");
				//divObj.style.visibility="hidden";
				//divObj.style.left = 1;
				//divObj.style.top = 1;
				return false;
			}
			function showTooltip(e, tipContent){
				//var divObj = document.getElementById("dHTMLToolTip");
				//divObj.style.top=document.body.scrollTop+event.clientY+15;
				//divObj.innerHTML='<img src="'+tipContent+'">';
				//if ((e.x + divObj.clientWidth) > (document.body.clientWidth + document.body.scrollLeft)){
				//	divObj.style.left = (document.body.clientWidth + document.body.scrollLeft) - divObj.clientWidth-10;
				//}else{
				//	divObj.style.left=document.body.scrollLeft+event.clientX;
				//}//
				//divObj.style.visibility="visible";

				e = e || window.event; 
				var divObj=$("#dHTMLToolTip");
				divObj.html('<img src="' + tipContent + '">');
				var target=e.target||e.srcElement;
				var x=target.offsetLeft,y=target.offsetTop;
				target=target.offsetParent;
				while(target){
					x+=target.offsetLeft;
					y+=target.offsetTop;
					target=target.offsetParent;
				}
				divObj.css({"top":(y+14)/2,"left":x+14}).show();
				
				return true;	
			}
			</script>
			<div id="dHTMLToolTip"  style="Z-INDEX: 1000; LEFT: 0px; display:none; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px">
			</div>
	</template:replace>
	
</template:include>