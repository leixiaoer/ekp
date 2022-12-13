<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no">
	<template:replace name="head">
		<link href="${LUI_ContextPath}/km/vote/resource/css/vote.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
    	</style>
		<script>
			Com_IncludeFile("doclist.js");
		</script>
		<script>
			DocList_Info = new Array();
			DocList_Info.push("TABLE_DocList_word","TABLE_DocList_image");
		</script>
		<script type="text/javascript">
			function ID(id){
				return document.getElementById(id);
			}
			Com_AddEventListener(window,"load",AddInitRow);
			function AddInitRow() {
				$("#hlist").click(function (){
					if(this.checked){
						$('#div_vlistColumnCount').show();
						$('#count').attr("validate","required digits");
					}else{
						$('#count').attr("validate","");
						$('#count').val("");
						$('#div_vlistColumnCount').hide();
						KMSSValidation_HideWarnHint($('#count'));
					}
				});
				
				var method = "${kmVoteMainForm.method_GET}";
				if(method == "add"){
					// 初始添加3个候选项
					setTimeout(function() {
						for(var i=0; i<2; i++) {
							//DocList_AddRow("TABLE_DocList");
							DocList_AddRow("TABLE_DocList_word");
							DocList_AddRow("TABLE_DocList_image");
						}
						var fdStyle = $("input[name='fdStyle']").val();
						var index = getInputCount(fdStyle);
						delIconOperation(index,fdStyle);
						addOption(document.getElementsByName("fdMaxSelectNum")[0]);
					}, 500);
				}else{
					var fdStyle = $("input[name='fdStyle']").val();					
					if(fdStyle == 1){
						//选择了文字投票
						$("#word_vote").show();						
						$("#image_vote").hide();
						//清除值
						$("#image_vote").find("input[type='text']").val("");
					}else{
						//选择了图片投票
						$("#word_vote").hide();
						//清除值
						$("#word_vote").find("input[type='text']").val("");
						$("#image_vote").show();
					}
					var fdVoteStatus = "${kmVoteMainForm.fdVoteStatus}";
					var fdMaxSelectNum = "${kmVoteMainForm.fdMaxSelectNum}";
					setTimeout(function() {
						addOption(document.getElementsByName("fdMaxSelectNum")[0]);
						if(fdMaxSelectNum>'0'){
							var seldom = document.getElementById("_fdMaxSelectNum_");
							seldom.options[fdMaxSelectNum].selected=true
						}
					}, 500);
				}
			}
			function getInputCount(style){
				//var obj = ID("TABLE_DocList");
				var opt = "TABLE_DocList_word";
				if(style == '1'){
					opt = "TABLE_DocList_word";
				}else if(style == '2'){
					opt = "TABLE_DocList_image";
				}
				var tbInfo = DocList_TableInfo[opt];
				return tbInfo.lastIndex - 1;
				
			}
			
			seajs.use(['lui/dialog','lui/jquery','km/vote/resource/js/dateUtil'], function(dialog,$,dateUtil) {
				var _validation='';
				LUI.ready( function() {
					_validation = $KMSSValidation();
					//编辑页面初始化长度提示显示
			    	checkNumberOfSubject(200,getNumberOfSubject());
			    	//长度校验
			    	$('input[name="docSubject"]').bind('keyup', function(event) {
			    		checkNumberOfSubject(200,getNumberOfSubject());
			    	});
			 
				});
				
		
				//标题限制
			    window.checkNumberOfSubject=function(maxN,len){
				    var isRule = true;
			        if (len <= maxN) {
			        	$("#tip1").html("${lfn:message('km-vote:kmVote.docSubject.canmore')}");
			         	var remainNum = Math.abs(parseInt((maxN - len) / 3));
			        }else{
			        	$("#tip1").html("${lfn:message('km-vote:kmVote.docSubject.nomore')}");
			        	var remainNum = Math.abs(parseInt((maxN - len) / 3))+1;
			        	isRule = false;
				        }
			    	$("#restrictNum").html(remainNum);
			    	$("#tip2").html("${lfn:message('km-vote:kmVote.docSubject.word')}");
			    	return isRule;
			    };
		
				//获取主题的长度 
		        window.getNumberOfSubject =function(){
		        	 var docSubject = document.getElementsByName("docSubject")[0].value;
		        	  len = (function(s) {
							var l = 0;
							var a = s.split("");
							for (var i = 0; i < a.length; i++) {
								if (a[i].charCodeAt(0) < 299) {
									l++;
								} else {
									l += 3;
								}
							}
							return l;
						})(docSubject);
					return len;
		           };
		
			       //提交表单
			    window.submitKmVotePostForm=function(method, fdCategoryId,status) {
				    var fdStyle = $("input[name='fdStyle']").val();
				    if(!validateKmVoteMainData()){
						return ;
					 }
			    	if(status!=null){
			    		document.getElementsByName("docStatus")[0].value = status;
			    	}
			    	if(fdStyle == 1){
				    	$("#image_vote").remove();
				    }else{
				    	$("#word_vote").remove();
					}
			    	var methodGet = "${kmVoteMainForm.method_GET}";
			    	if(methodGet=='edit'){
			    		$('input[name="fdIsRadio"]').attr("disabled",false);
			    		$('#_fdMaxSelectNum_').attr("disabled",false);
			    	}
					//提交表单校验
					Com_Submit(document.kmVoteMainForm, method,fdCategoryId);
				};

				function validateImage(){
					//校验图片是否为空
					var fdAttId = $("#image_vote").find("input[name*='fdAttId']");
					var len = 0;
					for(var i = 0 ; i < fdAttId.size() ; i++){
							var value = $.trim($(fdAttId[i]).val());
							if(value == ""){
									$("#option_"+i+"_tip").show();
									len++;
								}else{
									$("#option_"+i+"_tip").hide();
								}
						}
					if(len > 0){
						return false;
					}else{
						return true;
					}
				}
				
				window.validateKmVoteMainData=function(){
					var fdStyle = $("input[name='fdStyle']").val();
					if(fdStyle == "1"){
							//把图片投票选项设为不可用，以免被校验;把校验信息框隐藏，以免出现空框；
							$("#image_vote").find("input[class='inputsgl']").attr("disabled",true);
							$("#image_vote").find("div[class='validation-advice']").css("display","none");
						}else{
							//把文字投票选项设为不可用，以免被校验;把校验信息框隐藏，以免出现空框；
							$("#word_vote").find("input[class='inputsgl']").attr("disabled",true);
							$("#word_vote").find("div[class='validation-advice']").css("display","none");
							if(!validateImage()){
								//图片测试没法通过，把文字投票选项设为可用
								$("#word_vote").find("input[class='inputsgl']").attr("disabled",false);
								return false;
							}
						}
					
					if(!_validation.validate()){
						//当所有校验都无法通过时，会进行再编辑，所以要把选项再设为可用
						$("#word_vote").find("input[class='inputsgl']").attr("disabled",false);
						$("#image_vote").find("input[class='inputsgl']").attr("disabled",false);
						return false;
					}
					
					var msg = "";		
					var form = document.forms['kmVoteMainForm'];					
					if(document.getElementsByName("fdIsRadio")[0].checked) {
						form.fdMaxSelectNum.value = "0";
					}
					if(form.fdVoterIds==undefined||form.fdVoterIds.value == ""){
						//ID("fdNotifyType").value="";
						if(document.getElementsByName("fdNotifyType")[0]){
							document.getElementsByName("fdNotifyType")[0].value="";
						}
					}
					// 以下人员不能为空
					if(form._fdOtherViewFlag.checked == true && form.fdViewerNames.value == "") {
						msg += '<bean:message bundle="km-vote" key="error.otherViews.required" />' + '</br>';
					}
					if (msg != "") {
						dialog.alert(msg);
						return false;
					}
					return true;
				};

				//隐藏或显示删除图标
				window.delIconOperation = function(index,fdStyle){
					if(index <= 2){
						if(fdStyle == 1){							
							$("#word_vote .btn_del").hide();
						}else{
							$("#image_vote .btn_del").hide();
						}
					}else{
						if(fdStyle == 1){													
							$("#word_vote .btn_del").show();
						}else{
							$("#image_vote .btn_del").show();
							}
					}
				}
				
				//删除记录
				window.deleteVoteItem = function() {
					DocList_DeleteRow();					
					var fdStyle = $("input[name='fdStyle']").val();
					var index = getInputCount(fdStyle);				
					delIconOperation(index,fdStyle);
					
					//doclist.js的DocList_DeleteRow删除行操作只会更改name属性的序号，其他的必须自己手动更改
					if(fdStyle == 2){
						var image = $("#TABLE_DocList_image").find("tr[class='vote_tr']");
						for(var i = 0;i < image.length ;i++){
							//更改onchang里面的index
							var imageFile = $(image[i]).find("input[type='file']");
							var imageFileOnChange = imageFile.attr("onchange");
							imageFileOnChange = imageFileOnChange.replace(/([0-9]+)/,i);
							imageFile.attr("onchange",imageFileOnChange);		
							//更改所有id有index的属性				
							var imageTr = $(image[i]).find("[id]");
							for(var j = 0;j < imageTr.length ;j++){
									var obj = $(imageTr[j]);
									var objId = obj.attr("id");
									objId = objId.replace(/([0-9]+)/,i);
									obj.attr("id",objId);
								}								
							}
						}
					$("#_fdMaxSelectNum_ option:last").remove();
				};
				
				//添加记录
				window.AddVoteItem = function(){
					DocList_AddRow();
					//当选项多于两条的时候，显示删除按钮
					var fdStyle = $("input[name='fdStyle']").val();
					var index = getInputCount(fdStyle);
					delIconOperation(index,fdStyle);
					$("#_fdMaxSelectNum_").append('<option value=' + index + '><bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />'+ index +'<bean:message bundle="km-vote" key="kmVoteMain.item" /></option>');					
				};
				
				//候选记录初始化
				window.addOption = function(thisObj) {
					var index = getInputCount($("input[name='fdStyle']").val());
					// 删除所有选项
					while(thisObj.length>0) {
						thisObj.remove(0);
					}
				  	thisObj.options.add(new Option('<bean:message bundle="km-vote" key="kmVoteMain.unlimited" />',0));
					for(var i=1; i<=index; i++) {
						thisObj.options.add(new Option('<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />'+i+'<bean:message bundle="km-vote" key="kmVoteMain.item" />',i));
					}
				};

				var validation=$KMSSValidation();//校验框架
				//自定义校验器:校验召开时间不能晚于结束时间
				validation.addValidator('compareTime','<bean:message bundle="km-vote" key="error.effectTime.not.larg.expireTime" />',function(v, e, o){
					var result = true;
					var fdTime=$('[name="fdEffectTime"]');
					var fdEndTime=$('[name="fdExpireTime"]');
					//alert("1:"+fdTime.val());
					//alert("2:"+fdEndTime.val());
					if( fdTime.val() && fdEndTime.val() ){
						var start=dateUtil.parseDate(fdTime.val());
						var end=dateUtil.parseDate(fdEndTime.val());
						if(end.getTime() <= start.getTime()){
							result = false;
						}
					}
					return result;
				});
				
				//自定义校验器:正整数校验器
				validation.addValidator('minInteger','<span class="validation-advice-title"><bean:message bundle="km-vote" key="error.positive.min.integer" /></span>',function(v, e, o){
					var result = true;
					var fdMinOption=$('[name="fdMinOption"]');
					if(fdMinOption.val()){
					    if (!(/(^[1-9]\d*$)/.test(fdMinOption.val())))
					    {
							result = false;
					    }
					}		
					return result;
				});
				
				//自定义校验器:正整数校验器
				validation.addValidator('maxInteger','<span class="validation-advice-title"><bean:message bundle="km-vote" key="error.positive.max.integer" /></span>',function(v, e, o){
					var result = true;
					var fdMaxOption=$('[name="fdMaxOption"]');
					if(fdMaxOption.val()){
						if (!(/(^[1-9]\d*$)/.test(fdMaxOption.val())))
					    {
							result = false;
					    }
					}			
					return result;
				});
				
				//自定义校验器:最小可选项数必须小于投票选项行数
				validation.addValidator('compareRows','<span class="validation-advice-title"><bean:message bundle="km-vote" key="error.min.optional.less.rows" /></span>',function(v, e, o){
					var result = true;
					var fdMinOption=$('[name="fdMinOption"]');
					var rowCount = getInputCount($("input[name='fdStyle']").val());
					if( fdMinOption.val()){
						var min=parseInt(fdMinOption.val());
						if(min >= rowCount){
							result = false;
						}
					}
					return result;
				});
				
				//自定义校验器:最大可选项数必须大于或等于最小可选项数！
				validation.addValidator('compareSize','<span class="validation-advice-title"><bean:message bundle="km-vote" key="error.max.greater.than.min" /></span>',function(v, e, o){
					var result = true;
					var fdMinOption=$('[name="fdMinOption"]');
					var fdMaxOption=$('[name="fdMaxOption"]');
					if( fdMinOption.val() && fdMaxOption.val() ){
						var min=parseInt(fdMinOption.val());
						var max=parseInt(fdMaxOption.val());
						if(max<min){
							result = false;
						}
					}
					return result;
				});
				
			});
			function changeCate(){
				seajs.use(['sys/ui/js/dialog'], function(dialog) {
					dialog.simpleCategory('com.landray.kmss.km.vote.model.KmVoteCategory','fdCategoryId','',false,function(result){
						if(!result){
							return ;
						}
						document.getElementById("_fdCategoryName").innerHTML=result.name;
					});
				});
			}
			
			

			// 显示最多可选项
			function showMaxSelectNum() {
				if(document.getElementsByName("fdIsRadio")[0].checked) {
					ID("maxSelectNum").style.display = "none";
				} else {
					ID("maxSelectNum").style.display = "";
				}
			}
		
			// 显示输入投票开始时间
			function showEffectTime() {
				//var thisObj = ID("_fdIsEffectImmediately");
				var thisObj = document.getElementsByName("_fdIsEffectImmediately")[0];
				if(thisObj.checked == true) {
					ID("effect").style.display = "none";
					//thisObj.nextSibling.nodeValue='<bean:message bundle="km-vote" key="kmVoteMain.fdIsEffectImmediately" />';
				} else {
					//thisObj.nextSibling.nodeValue="";
					ID("effect").style.display = "block";
				}
			}
			// 显示以下人员
			function showOtherViewer(thisObj) {
				//var thisObj = ID("_fdOtherViewFlag");
				var thisObj = document.getElementsByName("_fdOtherViewFlag")[0];
				if(thisObj.checked == true) {
					ID("otherViews").style.display = "block";
				} else {
					//ID("fdViewerIds").value="";
					//ID("fdViewerNames").value="";
					document.getElementsByName("fdViewerIds")[0].value="";
					document.getElementsByName("fdViewerNames")[0].value="";
					ID("otherViews").style.display = "none";
				}
			}
			//modify by yirf 选择可投票者后触发，如果选择可投票者结果为空则不出现是否必需参加和通知方式，如果选择可投票者有人则出现是否必需参加和通知方式
			function showOtherInfo(rtnval){
				var fdVoterIds = document.getElementsByName("fdVoterIds")[0].value;
				if(fdVoterIds){
					ID("otherInfo").style.display = "";
				}else{
					//ID("fdVoterIds").value="";
					document.getElementsByName("fdVoterIds")[0].value="";
					//ID("fdVoterNames").value="";
					document.getElementsByName("fdVoterNames")[0].value="";
					ID("otherInfo").style.display = "none";
					//ID("fdNotifyType").value="";
					document.getElementsByName("fdNotifyType")[0].value="";
					var tbObj = ID("notifyType");
					var field = tbObj.getElementsByTagName("INPUT");
					for(var i=1; i<field.length; i++){
						field[i].checked =false;
					}
					//ID("fdNotifyType").value="";
					document.getElementsByName("fdNotifyType")[0].value="";
				}
			}
		
			function compareVoteDateTime(d1,d2) {
				return ((new Date(d1.replace(/-/g,"\/"))) >= (new Date(d2.replace(/-/g,"\/"))));
			}
		
			function compareVoteNowDateTime(d1) {
				return (new Date(d1.replace(/-/g,"\/"))) < (new Date());
			}
		
			window.onload = function(){
				if('${kmVoteMainForm.fdNotifyType}' == ""){
					var tbObj = ID("notifyType");
					var field = tbObj.getElementsByTagName("INPUT");
					for(var i=1; i<field.length; i++){
						field[i].checked =false;
					}
				}
			}
			
			/*
			*上传选项图片
			*/
			var imageExt = ['jpg','jpeg','gif','png','bmp'];
			var loading = null;
			function uploadOptionImage(index) {
				//兼容ie8不支持indexOf方法
				if (!Array.prototype.indexOf){  
			        Array.prototype.indexOf = function(elt /*, from*/){  
			        var len = this.length >>> 0;  
			        var from = Number(arguments[1]) || 0;  
			        from = (from < 0)  
			             ? Math.ceil(from)  
			             : Math.floor(from);  
			        if (from < 0)  
			          from += len;  
			        for (; from < len; from++)  
			        {  
			          if (from in this &&  
			              this[from] === elt)  
			            return from;  
			        }  
			        return -1;  
			      };  
			    } 
				
				var fileName = $("input[name='optionImageFiles["+index+"]']").val();
				var ext = fileName.substr(fileName.lastIndexOf(".") + 1).toLowerCase();
				if(imageExt.indexOf(ext) < 0) {
					return false;
				}
				//改变form的action,name.target,enctype
				var form = $("form[name='kmVoteMainForm']");
				form.attr("action","${LUI_ContextPath}/km/vote/km_vote_main_item/kmVoteMainItem.do?method=uploadOptionImage&index=" + index);				
				form.attr("name","kmVoteMainItemForm_" + index );
				form.attr("target","optionImageIframe");
				form.attr("enctype","multipart/form-data");
				form.submit();

				// 上传图片后清除没有图片的提示信息
				var options = $("#optionImage_"+index+"_div");
				options.style = "none";
			}
			/*
			*上传提示
			*/
			function uploadTip(type,info,index,downloadUrl) {
				seajs.use([ 'sys/ui/js/dialog' ], function(dialog) {
					if("success" == type) {
						var tmp = downloadUrl.lastIndexOf("=") + 1;
						tmp = downloadUrl.substr(tmp);
						$("#optionImage_" + index + "_id").val(tmp);						
						$("#optionImage_" + index + "_div").hide();
						$("#optionImage_" + index).show().attr("src",downloadUrl);
						$("#uploadTip_" + index).hide();
						$("#reuploadTip_"+index).show();
					} else{
						dialog.failure(info);
					}
					resetForm(index);
					if(loading != null) {
						loading.hide();
					}
				});
			}

			/*
			*重置form
			*/
			function resetForm(index) {
				var form = $("form[name='kmVoteMainItemForm_"+index+"']");
				form.attr("action","${LUI_ContextPath}/km/vote/km_vote_main/kmVoteMain.do");
				form.attr("name","kmVoteMainForm");
				form.removeAttr("target");
				form.removeAttr("enctype");
			}

			/*
			*	切换投票类型时，刷新多选的最多可选择项
			*/		
			function updateMaxSelect(){
				var index = getInputCount($("input[name='fdStyle']").val());//获取当前的选项数
				$("#_fdMaxSelectNum_ option:gt(0)").remove();//先把原本的信息删除
				//逐个添加option
				for(var i = 1;i <= index; i++){
					$("#_fdMaxSelectNum_").append('<option value=' + i + '><bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />'+ i +'<bean:message bundle="km-vote" key="kmVoteMain.item" /></option>');
					}				
				}
			
			/*
			*切换投票风格
			*/
			function changeStyle(value) {	
				$("input[name='fdStyle']").val(value);	//记录投票类型，1为文字投票，2为图片投票	
				var index = getInputCount(value);
				delIconOperation(index,value);	
				if("1" == value) {
					//选择了文字投票
					$("#word_vote").show();
					$("#word_vote_tabpanel").addClass("lui_vote_tabpanel_on");
					$("#image_vote").hide();
					$("#image_vote_tabpanel").removeClass("lui_vote_tabpanel_on");
					//切换的时候，也更新多选项的最多可选项
					updateMaxSelect();
				} else if("2" == value) {
					//选择了图片投票
					$("#word_vote").hide();
					$("#word_vote_tabpanel").removeClass("lui_vote_tabpanel_on");
					$("#image_vote").show();
					$("#image_vote_tabpanel").addClass("lui_vote_tabpanel_on");
					//切换的时候，也更新多选项的最多可选项
					updateMaxSelect();
				}
			}	

			
			
		</script>
		
		<c:if test="${empty kmVoteMainForm.fdCategoryId}">
			<script type="text/javascript">
			    window.changeCate();
			</script>
		</c:if>
		
	</template:replace>
	<template:replace name="title">
		<c:choose>
			<c:when test="${kmVoteMainForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('km-vote:button.launchedVote') } - ${ lfn:message('km-vote:module.km.vote') }"></c:out>
			</c:when>
			<c:when test="${kmVoteMainForm.method_GET == 'edit' }">
				<c:out value="${ lfn:message('km-vote:button.editVote') } - ${ lfn:message('km-vote:module.km.vote') }"></c:out>
			</c:when>
		</c:choose>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams
				moduleTitle="${ lfn:message('km-vote:module.km.vote') }"
				modulePath="/km/vote/" 
				modelName="com.landray.kmss.km.vote.model.KmVoteCategory" 
				autoFetch="false"
				target="_blank"
				categoryId="${kmVoteMainForm.fdCategoryId}" />
		</ui:combin>
	</template:replace>
	<template:replace name="content">
		<div class="lui_forum_table">
		<html:form action="/km/vote/km_vote_main/kmVoteMain.do" >
			<html:hidden property="docStatus" />
			<html:hidden property="fdId" />
			<html:hidden property="fdModelId" />
			<html:hidden property="fdModelName" />
			<input type="hidden" name="fdStyle" value="${kmVoteMainForm.fdStyle}"/>
			<table class="lui_sheet_c_table tb_simple" style="width:100%">
				
				<tr>
					<td width="15%" class="td_normal_title">
						${lfn:message('km-vote:kmVoteMain.docSubject')}
					</td>
					<td width="50%" colspan="3" class="validation-advice_useless">						
						 <xform:text isLoadDataDict="false" property="docSubject" subject="${lfn:message('km-vote:kmVoteMain.docSubject')}" validators="maxLength(200)" className="inputsgl" style="width: 640px;" required="true" />							
	                     <span class="tips">
                            <span id ="tip1"></span>
                            <a id="restrictNum">66</a>
                            <span id ="tip2"></span>
                        </span> 
					</td>
					
				</tr>
				<tr>
					<td width="15%" class="td_normal_title" >
						${lfn:message('km-vote:kmVoteMain.fdCategoryId')}
					</td>
					<td colspan="3">
						<html:hidden property="fdCategoryId" /> 
						<span id="_fdCategoryName"><bean:write	name="kmVoteMainForm" property="fdCategoryName" /></span>
						<c:if test="${kmVoteMainForm.method_GET=='add' || kmVoteMainForm.docStatus=='10'}">
							&nbsp;&nbsp;
							<a href="javascript:changeCate();" class="com_btn_link">
								<bean:message key="kmVoteMain.changeCate" bundle="km-vote" /> 
							</a>
						</c:if>
					</td>
				</tr>
				<%-- 所属场所 --%>
               	<%if(ISysAuthConstant.IS_AREA_ENABLED){ %>
					<tr>
						<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field_single.jsp" charEncoding="UTF-8">
			                <c:param name="id" value="${kmVoteMainForm.authAreaId}"/>
			            </c:import>
					</tr>
				<%} %>
				<!-- 详细说明 -->
				<tr>
					<td width="15%" class="td_normal_title" style="vertical-align: top;">
						<bean:message bundle="km-vote" key="kmVoteMain.fdDescription" />
					</td>
					<td width="85%" colspan="3">					
						<xform:textarea property="fdDescription" style="width: 640px;height: 80px;resize:none" htmlElementProperties="data-actor-expand='true'"
							 showStatus="edit" className="inputmul" validators="maxLength(1500)"></xform:textarea>	
					</td> 
				</tr>
				<tr>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="km-vote" key="kmVoteMain.fdStyle" />
					</td>
					<td width="85%" colspan="3">
					<c:choose>
						<c:when test="${kmVoteMainForm.fdVoteStatus!='0'}">
							<div class="lui_vote_tabpanel_switch">
								<div id="word_vote_tabpanel" class="lui_vote_tabpanel ${(kmVoteMainForm.fdStyle eq '1')?'lui_vote_tabpanel_on':''} " onclick="changeStyle('1');">
									<bean:message bundle="km-vote" key="kmVoteMain.wordVote" />
								</div>
								<div id="image_vote_tabpanel" class="lui_vote_tabpanel ${(kmVoteMainForm.fdStyle eq '2')?'lui_vote_tabpanel_on':''}" onclick="changeStyle('2');">
									<bean:message bundle="km-vote" key="kmVoteMain.imgVote" />
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div id="word_vote_tabpanel" class="lui_vote_tabpanel lui_vote_tabpanel_on">
								${(kmVoteMainForm.fdStyle eq '1')?lfn:message('km-vote:kmVoteMain.wordVote'):lfn:message('km-vote:kmVoteMain.imgVote')}
							</div>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title" style="padding-top:20px;"></td>
					<td  width="85%" >
						<c:set var="voteLength" value="${fn:length(kmVoteMainForm.fdVoteItems)}"/>
						<div id="word_vote" >
							<table id="TABLE_DocList_word" width="83%" tbdraggable="true">
								<tr type="optRow" class="vote_item">
									<td colspan="2"> 
										<bean:message bundle="km-vote" key="kmVoteRecord.fdMainItems" />：<span style="color:#808080;padding-left:5px;"><bean:message bundle="km-vote" key="kmVoteMain.itemDes" /></span>
									</td>
									<td></td><td></td><!--  加这空行是为了配合拖曳功能的colspan -->
								</tr>
								<tr KMSS_IsReferRow="1" class="vote_tr" style="display: none;">
									<td KMSS_IsRowIndex="1" class="td_vote_index"></td>
									<td class="vote_word_td">
										<input type="hidden" name="fdVoteItems[!{index}].fdId" value="${kmVoteMainItemForm.fdId}" />
										<input type="hidden" name="fdVoteItems[!{index}].fdVoteId" value="${kmVoteMainForm.fdId}" />																		
										<xform:text property="fdVoteItems[!{index}].fdName" value="${kmVoteMainItemForm.fdName}" validators="maxLength(300)" subject="${lfn:message('km-vote:kmVoteMain.fdVoteItem')}" style="width:97%" className="inputsgl" required="true"  />									
										<a href="javascript:void(0);" class="btn_del"  onclick="deleteVoteItem();" title="${lfn:message('doclist.delete')}">				
										</a>
									</td>	
								</tr>
								<c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
									<tr KMSS_IsContentRow="1" class="vote_tr">
										<td class="td_vote_index">${vstatus.index+1}</td>
										<td class="vote_word_td">
											<input type="hidden" name="fdVoteItems[${vstatus.index}].fdId" value="${kmVoteMainItemForm.fdId}" />
											<input type="hidden" name="fdVoteItems[${vstatus.index}].fdVoteId" value="${kmVoteMainForm.fdId}" />																					
											<xform:text property="fdVoteItems[${vstatus.index}].fdName" value="${kmVoteMainItemForm.fdName}" validators="maxLength(300)" subject="${lfn:message('km-vote:kmVoteMain.fdVoteItem')}" style="width:97%;"  className="inputsgl" required="true" />
											<c:if test="${not empty voteLength and voteLength > 2 }">
												<a href="javascript:void(0);" class="btn_del"   onclick="deleteVoteItem();" title="${lfn:message('doclist.delete')}" style="width: 2%;">
												</a>
											</c:if>											
										</td>
									</tr>
								</c:forEach>
								<tr type="optRow">
									<td>									
										<a href="javascript:void(0);" onclick="AddVoteItem();" title="${lfn:message('doclist.add')}" class="add_item">																							
											<bean:message bundle="km-vote" key="kmVoteMain.addItem" />
											<img src="${KMSS_Parameter_StylePath}/icons/icon_add.png" style="vertical-align:middle;margin-bottom:3px;" />
										</a>																			
									</td>
								</tr>
							</table>
						</div>
						<div id="image_vote" style="display:none;">
							<table id="TABLE_DocList_image" width="83%" tbdraggable="true">
								<tr type="optRow" class="vote_item">
									<td colspan="2"> 
										<bean:message bundle="km-vote" key="kmVoteRecord.fdMainItems" />：<span style="color:#808080;padding-left:5px;"><bean:message bundle="km-vote" key="kmVoteMain.itemDes" /></span>
									</td>
									<td></td><td></td><!--  加这空行是为了配合拖曳功能的colspan -->
								</tr>
								<tr KMSS_IsReferRow="1" style="display: none;" class="vote_tr">
									<td KMSS_IsRowIndex="1" class="td_vote_index"></td>
									<td class="vote_image_td">
										<input type="hidden" name="fdVoteItems[!{index}].fdId" value="${kmVoteMainItemForm.fdId}" />
										<input type="hidden" name="fdVoteItems[!{index}].fdVoteId" value="${kmVoteMainForm.fdId}" />
										<input type="hidden" id="optionImage_!{index}_id" name="fdVoteItems[!{index}].fdAttId" value="${kmVoteMainItemForm.fdAttId}"/>	
										<div class="vote_image_item">
											<div>
												<div class="lui_vote_btn_pic">
								                    <div class="lui_vote_btnL" id="optionImage_!{index}_div">				                      
						                                <div class="icon_btnPic">
						                                </div>	
						                                <div>				                                
							                                <p>
							                                  	<bean:message key='kmVote.upload.image' bundle='km-vote'/>
							                                </p>							                                	
							                             </div>				                                				                        
								                    </div>					                    
							                    </div>			                    
						                    	<img id="optionImage_!{index}"  class="optionImage" style="display:none;cursor: pointer;">			                    		
												<span id="reuploadTip_!{index}" class="reuploadTip" style="display:none;">
							                         <bean:message bundle='km-vote' key='kmVoteMain.reupload' />
							                     </span>
												<input accept=".jpg,.jpeg,.gif,.png,.bmp" name="optionImageFiles[!{index}]" type="file" class="file" onchange="uploadOptionImage('!{index}')"/>
											</div>
											<xform:text property="fdVoteItems[!{index}].fdName" value="${kmVoteMainItemForm.fdName}" validators="maxLength(300)" subject="${lfn:message('km-vote:kmVoteMain.fdVoteItem')}" style="width:87%;" className="inputsgl" required="true"  />
										</div>
										<div class="validation-advice" id="option_!{index}_tip" style="display:none;margin-bottom: 16px;">
											<table class="validation-table">
												<tbody>
													<tr>
														<td>
															<div class="lui_icon_s lui_icon_s_icon_validator"></div>
														</td>
														<td class="validation-advice-msg">
															<span id="_option_validate_tip" class="validation-advice-title" style="padding-right: 6px;"><bean:message bundle="km-vote" key="kmVoteMain.pic" /></span><bean:message bundle="km-vote" key="kmVoteMain.notNullDes" />
														</td>
													</tr>
												</tbody>
											</table>
										</div>		
										<a href="javascript:void(0);" class="btn_del" onclick="deleteVoteItem();" title="${lfn:message('doclist.delete')}">
										</a>						
									</td>
								</tr>
								<c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
									<tr KMSS_IsContentRow="1" class="vote_tr">
										<td class="td_vote_index">${vstatus.index+1}</td>
										<td class="vote_image_td">
											<input type="hidden" name="fdVoteItems[${vstatus.index}].fdId" value="${kmVoteMainItemForm.fdId}" />
											<input type="hidden" name="fdVoteItems[${vstatus.index}].fdVoteId" value="${kmVoteMainForm.fdId}" />
											<input type="hidden" id="optionImage_${vstatus.index}_id" name="fdVoteItems[${vstatus.index}].fdAttId" value="${kmVoteMainItemForm.fdAttId}"/>
											<div class="vote_image_item">
												<div>
													<div class="lui_vote_btn_pic">
									                    <div class="lui_vote_btnL" id="optionImage_${vstatus.index}_div">				                      
							                                <div class="icon_btnPic">							                              																										                                	
							                                </div>							                                			                        
									                    </div>					                    
								                    </div>								           
							               			<img id="optionImage_${vstatus.index}" <c:if test="${not empty kmVoteMainItemForm.fdAttId }"> src="${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?${LUI_Cache}&method=download&fdId=${kmVoteMainItemForm.fdAttId}" </c:if>
														 class="optionImage" style="cursor: default;vertical-align: top;"/>								                    														                  							                    													
													
													<div class="reuploadTip">				                                
						                                <span id="uploadTip_${vstatus.index}">
						                                  	${(kmVoteMainForm.fdStyle eq '1')?'上传图片':'重新上传'}
						                                </span>	
						                                <span id="reuploadTip_${vstatus.index}" style="display:none;">
						                                	<bean:message bundle='km-vote' key='kmVoteMain.reupload' />
						                                </span>						                                	
						                            </div>															
													<input accept=".jpg,.jpeg,.gif,.png,.bmp" name="optionImageFiles[${vstatus.index}]" type="file" class="file" onchange="uploadOptionImage(${vstatus.index});"/>
													<xform:text property="fdVoteItems[${vstatus.index}].fdName" value="${kmVoteMainItemForm.fdName}" validators="maxLength(300)" subject="${lfn:message('km-vote:kmVoteMain.fdVoteItem')}" style="width:87%;"  className="inputsgl" required="true" />														
												</div>
											</div>	
											<div class="validation-advice" id="option_${vstatus.index}_tip" style="display:none;margin-bottom: 16px;">
												<table class="validation-table">
													<tbody>
														<tr>
															<td>
																<div class="lui_icon_s lui_icon_s_icon_validator"></div>
															</td>
															<td class="validation-advice-msg">
																<span id="_option_validate_tip" class="validation-advice-title" style="padding-right: 6px;"><bean:message bundle="km-vote" key="kmVoteMain.pic" /></span><bean:message bundle="km-vote" key="kmVoteMain.notNullDes" />
															</td>
														</tr>
													</tbody>
												</table>
											</div>
											<c:if test="${not empty voteLength and voteLength > 2 }">	
												<a href="javascript:void(0);" class="btn_del" onclick="deleteVoteItem();" title="${lfn:message('doclist.delete')}">
												</a>
											</c:if>								
										</td>
									</tr>
								</c:forEach>
								<tr type="optRow">
									<td>
										<a href="javascript:void(0);" onclick="AddVoteItem();" title="${lfn:message('doclist.add')}" class="add_item">
											<bean:message bundle="km-vote" key="kmVoteMain.addItem" />
											<img src="${KMSS_Parameter_StylePath}/icons/icon_add.png" style="vertical-align:middle;margin-bottom:3px;" />												
										</a>																				
									</td>
								</tr>
							</table>				
						</div>
					</td>
				</tr>				
				<%--允许评论 --%>
				<tr>
					<td  class="td_normal_title" width="15%"> 
					</td>
					<td colspan="3" >
						<span>
							<xform:checkbox property="fdIsAllowSay" style="" showStatus="edit" >
								<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMain.fdIsAllowSay" />
							</xform:checkbox>&nbsp;&nbsp;
							<xform:checkbox property="fdDisplay" style="" showStatus="edit" htmlElementProperties='id="hlist"'>
								<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMain.fdDisplay" />
							</xform:checkbox>
						</span>
						<span id="div_vlistColumnCount"
							<c:if test="${kmVoteMainForm.fdDisplay !='true'}">
								style="display: none"
							</c:if>>
							<bean:message bundle="km-vote" key="kmVoteMain.fdCount"/>
							<xform:text property="fdCount"  value="" className="inputsgl" subject="${lfn:message('km-vote:kmVoteMain.fdCount')}" style="width:40px" htmlElementProperties="id='count'"></xform:text>
						</span>
					</td>
				</tr>
				<!-- 可投选项 -->
				<tr>
					<td class="td_normal_title" width="15%" style="vertical-align: top;">
						<bean:message bundle="km-vote" key="kmVoteMain.fdIsRadio" />
					</td>
					<td colspan="3">
						<span class="l" style="">
								<c:if test="${kmVoteMainForm.fdVoteStatus!='0'}">
									<label>
									<html:radio property="fdIsRadio" value="true" onclick="showMaxSelectNum();" >
										<bean:message bundle="km-vote" key="kmVoteMain.itemRadio" />
									</html:radio>
									</label>&nbsp;
									<label>
									<html:radio property="fdIsRadio" value="false" onclick="showMaxSelectNum();">
										<bean:message bundle="km-vote" key="kmVoteMain.itemCheckbox" />
									</html:radio>
									</label>
								</c:if>	
								<c:if test="${kmVoteMainForm.fdVoteStatus=='0'}">
									<label>
									<html:radio property="fdIsRadio" value="true" onclick="showMaxSelectNum();" disabled="true">
										<bean:message bundle="km-vote" key="kmVoteMain.itemRadio" />
									</html:radio>
									</label>&nbsp;
									<label>
									<html:radio property="fdIsRadio" value="false" onclick="showMaxSelectNum();" disabled="true">
										<bean:message bundle="km-vote" key="kmVoteMain.itemCheckbox" />
									</html:radio>
									</label>
								</c:if>	
								
						</span>
						<span class="flw10"></span>
						<span id="maxSelectNum" class="l"
							<c:if test="${kmVoteMainForm.fdIsRadio!='false'}">
								style="display: none"
							</c:if>
						>
							<!-- 最多可选项 -->
							<select name="fdMaxSelectNum" id="_fdMaxSelectNum_" style="display: none"  <c:if test="${kmVoteMainForm.fdVoteStatus=='0'}">
								disabled
							</c:if>>
								<option value="0"><bean:message bundle="km-vote" key="kmVoteMain.unlimited" /></option>
								<option value="${kmVoteMainForm.fdMaxSelectNum}"
									<c:if test="${kmVoteMainForm.fdMaxSelectNum!='0'}">
										selected="true"
									</c:if>
									>
									<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />${kmVoteMainForm.fdMaxSelectNum}<bean:message bundle="km-vote" key="kmVoteMain.item" />
								</option>
							</select>
							${lfn:message('km-vote:kmVoteMain.select.optional')}
							<xform:text isLoadDataDict="false" property="fdMinOption" validators="minInteger maxLength(3) compareRows compareSize" className="inputsgl" style="width: 80px;" />&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;
							<xform:text isLoadDataDict="false" property="fdMaxOption" validators="maxInteger maxLength(3) compareSize" className="inputsgl" style="width: 80px;" />
							${lfn:message('km-vote:error.select.messge')}
						</span>
					</td>
				</tr>
			
			    <!-- 投票开始时间 -->
				<tr>
					<td class="td_normal_title" width="15%" style="vertical-align: top;">
						<bean:message bundle="km-vote" key="kmVoteMain.fdExpireTime"/>
					</td>
					<td colspan="3">
						<div id="effect" class="l" >	
							<table style="width:100%;">
							  	<tr>
							  		<td>
										<!--<c:if test="${kmVoteMainForm.fdVoteStatus!='0'}">
											<xform:datetime property="fdEffectTime" dateTimeType="datetime" showStatus="edit"  validators="after compareTime"/>
										</c:if>
										<c:if test="${kmVoteMainForm.fdVoteStatus=='0'}">
											<span style="float:left;margin-top:6px;">
												<xform:datetime property="fdEffectTime" style="width:110px;display:inline-block;" dateTimeType="datetime" showStatus="readonly" />
											</span>
										</c:if>																			
										<span style="position: relative;top:-8px;"> — </span>
										--><xform:datetime property="fdExpireTime" dateTimeType="datetime" showStatus="edit" validators="after compareTime" />
									</td>
									<td>
									</td>
								</tr>							
								<tr>
									<td colspan="2" style="padding-top: 0px;">
										<span><bean:message bundle="km-vote" key="kmVoteMain.fdEffectTime.isNull.message"/></span>
									</td>
								</tr>
							</table>
						</div>						
					</td>
				</tr>
			<!-- 可投票者 -->
				<tr>
					<td class="td_normal_title" width=15% style="vertical-align: top;">
						<bean:message bundle="km-vote" key="kmVoteMain.fdVoters"/>
					</td>
					<td colspan="3">
					<c:choose>
						<c:when test="${kmVoteMainForm.method_GET == 'add' }">
							<xform:address isLoadDataDict="false" required="false" mulSelect="true" textarea="true" subject="${lfn:message('km-vote:kmVoteMain.fdVoters')}" 
							onValueChange="showOtherInfo" style="width: 650px;" propertyId="fdVoterIds" propertyName="fdVoterNames">
						</xform:address>
						</c:when>
						<c:when test="${kmVoteMainForm.method_GET == 'edit' }">
							<xform:address isLoadDataDict="false" required="false" mulSelect="true" textarea="true" subject="${lfn:message('km-vote:kmVoteMain.fdVoters')}" 
							showStatus="readOnly" style="width: 650px;" propertyId="fdVoterIds" propertyName="fdVoterNames">
						</xform:address>
						</c:when>
						</c:choose>						
						<span class="txtstrong" style=""><bean:message bundle="km-vote" key="kmVoteMain.voter.isNull.message"/></span>
					</td>
				</tr>
			<!-- 可查看投票结果 -->
				<tr>
					<td width="15%" class="td_normal_title" style="vertical-align: top;">
						<bean:message bundle="km-vote" key="kmVoteMain.canViewResult" />
					</td>
					<td width="85%" colspan="3">		
						<!-- 投票后结果可见 -->
						<xform:radio property="fdVoterViewFlag" style="">
							<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMain.fdVotersView" />
							<xform:simpleDataSource value="false" bundle="km-vote" textKey="kmVoteMain.fdCreatorView" />
						</xform:radio><br />
						<!-- 例外人员 -->
						<xform:checkbox property="fdOtherViewFlag" style="" showStatus="edit" onValueChange="showOtherViewer()">
							<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMian.otherViews" />
						</xform:checkbox><br />
						<!-- 地址本 -->
						<span id="otherViews"
							<c:if test="${empty kmVoteMainForm.fdViewerIds}">
								style="display: none"
							</c:if>
							>
							<xform:address isLoadDataDict="false" required="false" textarea="true" mulSelect="true" subject="${lfn:message('km-vote:kmVoteMian.otherViews')}" 
								 style="width: 650px;" propertyId="fdViewerIds" propertyName="fdViewerNames" orgType='ORG_TYPE_POSTORPERSON|ORG_TYPE_DEPT'>
							</xform:address>
						</span>
					</td>
				</tr>
				<!-- 通知方式 -->
				<tr id="otherInfo"
					<c:if test="${empty kmVoteMainForm.fdVoterIds}">
						style="display: none"
					</c:if>>
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-vote" key="kmVoteMain.fdNotifyType" />
					</td>
					<td width="35%" id="notifyType">
						<c:choose>
							<c:when test="${empty kmVoteMainForm.fdNotifyType}">
								<kmss:editNotifyType property="fdNotifyType" />
							</c:when>
							<c:otherwise>
								<kmss:editNotifyType property="fdNotifyType" value="${kmVoteMainForm.fdNotifyType}" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<!--发起投票，保存草稿-->
				<tr>
					<td></td>
					<td colspan="3">
						<c:if test="${kmVoteMainForm.method_GET=='add'}">
							<ui:button styleClass="com_bgcolor_d com_fontcolor_d com_bordercolor_d vote_button" text="${lfn:message('km-vote:button.launchedVote')}" order="2" onclick="submitKmVotePostForm('save', 'fdCategoryId',30);">
							</ui:button>
							<ui:button styleClass="com_bgcolor_l com_fontcolor_l com_bordercolor_l vote_button" text="${lfn:message('km-vote:button.saveVote')}" order="2" onclick="submitKmVotePostForm('saveDraft', 'fdCategoryId',10);">
							</ui:button>
							
						</c:if>
						<c:if test="${kmVoteMainForm.method_GET=='edit'}">
							<!-- 提交 -->
							<ui:button styleClass="com_bgcolor_d com_fontcolor_d com_bordercolor_d vote_button" text="${lfn:message('km-vote:button.updateVote')}" order="2" onclick="submitKmVotePostForm('update', 'fdCategoryId',30);">
							</ui:button>
							
							<!-- 暂存 --> 
						     <c:if test="${kmVoteMainForm.docStatus=='10'}">
								<ui:button styleClass="com_bgcolor_l com_fontcolor_l com_bordercolor_l vote_button" text="${lfn:message('km-vote:button.saveVote')}" order="2" onclick="submitKmVotePostForm('update', 'fdCategoryId',10);">
								</ui:button>
						 	</c:if>	
						</c:if>
					</td>
				</tr>
			</table>			
		<script language="JavaScript">
			$KMSSValidation(document.forms['kmVoteMainForm']);			
		</script>
		</html:form>
		<iframe name="optionImageIframe" width="0" height="0" 
			id="optionImageIframe" src="about:blank" frameborder="0" marginwidth="0">
		</iframe>
		</div>
	</template:replace>
</template:include>
