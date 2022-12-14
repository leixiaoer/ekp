<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.web.filter.ResourceCacheFilter"%>
<%@ page import="com.landray.kmss.sys.ui.plugin.SysUiPluginUtil"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/ui.tld" prefix="ui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/template.tld" prefix="template"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/list.tld" prefix="list"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/kmss-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/kmss-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/sunbor.tld" prefix="sunbor"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
if(request.getAttribute("LUI_ContextPath")==null){
	String LUI_ContextPath = request.getContextPath();
	request.setAttribute("LUI_ContextPath", LUI_ContextPath);
	request.setAttribute("LUI_CurrentTheme",SysUiPluginUtil.getThemeById("default"));
	request.setAttribute("MUI_Cache",ResourceCacheFilter.mobileCache);
	request.setAttribute("LUI_Cache",ResourceCacheFilter.cache);
	request.setAttribute("KMSS_Parameter_Style", "default");
	request.setAttribute("KMSS_Parameter_ContextPath", LUI_ContextPath+"/");
	request.setAttribute("KMSS_Parameter_ResPath", LUI_ContextPath+"/resource/");
	request.setAttribute("KMSS_Parameter_StylePath", LUI_ContextPath+"/resource/style/default/");
	request.setAttribute("KMSS_Parameter_CurrentUserId", UserUtil.getKMSSUser(request).getUserId());
	request.setAttribute("KMSS_Parameter_Lang", UserUtil.getKMSSUser(request).getLocale().toString().toLowerCase().replace('_', '-'));
}
%>
<kmss:ifModuleExist path="/km/signature/">
<kmss:authShow roles="ROLE_SIGNATURE_DEFAULT">
	<!-- ????????????????????????????????? -->
	<div id="showSignature_${JsParam.controlId}" style="display:none" class="showSignature">
		<div class="titleNode showSignatureTitle">
			<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.show" />
		</div>
		<div class="detailNode" id="signaturePic_${JsParam.controlId}">
			<ul id="signaturePicUL_${JsParam.controlId}" class="clearfloat lui_sns_signatureList newAuditNote">
			</ul>
		</div>
	</div>
<script>
//????????????????????????????????????????????????
$(document).ready(function () {
	var newAuditNoteControlId = "${JsParam.controlId}";
	var signatureShowSelector = "#showSignature_" + newAuditNoteControlId;
	if (typeof(seajs) != 'undefined') {
		if(Com_Parameter.dingXForm != "true") {
			var html = '&nbsp;&nbsp;';
			html += '<a href="javascript:;" controlId="' + newAuditNoteControlId + '" class="com_btn_link" id="signature_' + newAuditNoteControlId + '" onclick="newAduitNoteSignature(this);">';
			html += '<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.name" />';
			html += '</a>';
			var idSelector = "#xform_auditNote_oper_" + newAuditNoteControlId;
			$(idSelector).append(html);
			
			var newAuditNoteWrapSelector = "#newAuditNoteWrap_" + newAuditNoteControlId;
			$(newAuditNoteWrapSelector).append($(signatureShowSelector));
		}
		$(signatureShowSelector).show();
	}else{//??????UED??????????????????????????????
		$("#signature_" + newAuditNoteControlId).hide();
	}
	if (typeof(lbpm) == 'undefined' ) {
		return;
	}
	if(typeof (lbpm.events) != "undefined" && lbpm.events.addListener){
		lbpm.events.addListener(lbpm.constant.EVENT_HANDLERTYPECHANGE, function(param){
			if(param!='' && param!=lbpm.constant.PROCESSORROLETYPE){
				$(signatureShowSelector).hide();
			}else{
				$(signatureShowSelector).show();
				
			}
		});
	}
	if(typeof (lbpm.constant) != "undefined" && lbpm.constant.ROLETYPE!='' 
		&& lbpm.constant.ROLETYPE!=lbpm.constant.PROCESSORROLETYPE){
		$(signatureShowSelector).hide();
	}
	
	if (typeof(seajs) != 'undefined' 
		&& typeof(lbpm) != 'undefined') {//??????UED??????????????????????????????
	setTimeout(function(){
		if (typeof fileIds === "undefined"){
			fileIds = [];
		}
		loadnewAuditAutoSignaturePic("${JsParam.controlId}");
	},500);
	
	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
		//??????
		window.newAduitNoteSignature = function(src) {
			var controlId = $(src).attr("controlId");
			var url = "/km/signature/km_signature_main/kmSignatureMain_showSig.jsp";
			dialog.iframe(url,'<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.name" />',function(rtn){
				if(rtn!=null){
					var file = {
						fdAttId:rtn.attId
		            };
					newAuditSignatureImgShow(file,controlId); 
                    $("#showSignature_" + controlId).show();
				}
			},{width:800,height:270});
		};
		
		window.newUIAduitNoteSignature = function(src) {
			var controlId = $(src).closest("xformflag").attr("flagId");
			var url = "/km/signature/km_signature_main_ui/dingSuit/kmSignatureMain_showSig.jsp";
			dialog.iframe(url,'<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.name" />',function(rtn){
				if(rtn!=null){
					var file = {
						fdAttId:rtn.attId
		            };
					newAuditSignatureImgShow(file,controlId); 
                    $("#showSignature_" + controlId).show();
				}
			},{width:480,height:270});
		}
	  });
  	}
	
	setTimeout(function(){
        var newItems = $("div[id^='newAuditNoteWrap']");
        for(var i=0; i<newItems.length; i++) {
                var display = newItems[i].style.display;
                if(display == 'none') {
                        continue;
                }
                var opers = $(newItems[i]).find("input[name^='newAuditNoteOprGroup']");
                if(opers.length == 0) {
                        continue;
                }
                //opers[0].click();
        }
	},500);
});

//??????????????????
function newAuditSignatureImgShow(file,controlId){
	if (!file || !file.fdAttId){
		return ;
	}
	//????????????????????????html
	var newAuditNoteHtml = '<li id="'+file.fdAttId+'"><img width="100" height="75" src="${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId='+file.fdAttId+'"/>';
	newAuditNoteHtml += '<span id="'+file.fdAttId+'" controlId="' + controlId + '" class="btn_canncel_img" onclick="newAuditNoteDeletex(this);"></span></li>';
	//????????????????????????,??????????????????????????????,?????????????????????,?????????????????????????????????????????????????????????
	var signaturePicULSelector = "#signaturePicUL_" + controlId;
	var toProcessSignaturePicULSelector = "#signaturePicUL";
	var showSignature = "#showSignature";
	var newAuditNoteImageUl = $(signaturePicULSelector);
	var processImgs = $(toProcessSignaturePicULSelector).find("li");
	var alreadyExistInSameControl = false;
	var alreadyExistInOtherControl = false;
	var newAuditNoteImgs = $(signaturePicULSelector).find("li");
	for (var i = 0; i < newAuditNoteImgs.length; i++){
		if (file.fdAttId == $(newAuditNoteImgs[i]).attr("id")){
			//???????????????????????????
			alreadyExistInSameControl = true;
			break;
		}
	}
	
	var otherControlUl = $("[id*='signaturePicUL_'][id!='signaturePicUL_" + controlId + "']");
	otherControlUl.each(function(index,otherControlUlObj){
		var imgObj = $("li",$(otherControlUlObj));
		for (var i = 0; i < imgObj.length; i++){
			var fileId = $(imgObj[i]).attr("id");
			if (file.fdAttId == fileId){
				alreadyExistInOtherControl = true;
				break;
			}
		}
	});
	
	//?????????????????????
	var isOnlyExitInProcess = false;
	if (!alreadyExistInSameControl && !alreadyExistInOtherControl) {
		processImgs.each(function(index,obj){
			if (file.fdAttId == $(obj).attr("id")){ 
				isOnlyExitInProcess = true;
			}
		});
	}
	
	if((alreadyExistInOtherControl && !alreadyExistInSameControl) 
			|| isOnlyExitInProcess){
		//????????????????????????
		newAuditNoteImageUl.append(newAuditNoteHtml);
		return;
	}
	var flag = true;
	if(fileIds.length>0){
        for(var i = 0;i < fileIds.length;i++){
			if(fileIds[i].fdAttId == file.fdAttId){
				flag = false;
			}
        }
	}
    if(flag){
    	fileIds.push(file);
		var toProcessImgUl = $(toProcessSignaturePicULSelector);
		//?????????????????????html
		var toProcessHtml = '<li id="'+file.fdAttId+'"><img width="100" height="75" src="${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId='+file.fdAttId+'"/>';
		toProcessHtml += '<span id="'+file.fdAttId+'" class="btn_canncel_img" onclick="deletex(this);"></span></li>';
		if(newAuditNoteImageUl.length > 0){
			    $(showSignature).attr("style","display:'';");
				newAuditNoteImageUl.append(newAuditNoteHtml);
				toProcessImgUl.append(toProcessHtml);
		}
    }else{
		alert('<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.reupload" />');
    }
}

//????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
function loadnewAuditAutoSignaturePic(newAuditNoteControlId){
	var autoSignPicUrl = "${KMSS_Parameter_ContextPath}km/signature/km_signature_main/kmSignatureMain.do?method=confirmSignature";
	$.ajax({
	     type:"post",
	     url:autoSignPicUrl,
	     data:{"autoSignature":true},
	     async:true,
	     success:function(data){
			if (data.flag == '1') {
				var file = {fdAttId:data.attId };
				newAuditSignatureImgShow(file,newAuditNoteControlId);
            } else {
                $("#showSignature_" + newAuditNoteControlId).hide();
            }
		}
    });
}

//????????????
function newAuditNoteDeletex(obj){
	var message = '<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.confirm" />';
	var controlId = $(obj).attr("controlId");
	var otherControlUl = $("[id*='signaturePicUL_'][id!='signaturePicUL_" + controlId + "']:visible");
	var isExistInOther = false;
	otherControlUl.each(function(index,otherControlUlObj){
		var imgObj = $("li",$(otherControlUlObj));
		for (var i = 0; i < imgObj.length; i++){
			var fileId = $(imgObj[i]).attr("id");
			if (obj.id == fileId){
				if(confirm(message)){
		        	//??????????????????????????????
		        	var controlId = $(obj).attr("controlId");
		        	$("li[id='"+obj.id+"']",$("#signaturePicUL_" + controlId)).remove();
		        	isExistInOther = true;
				}
			}
		}
	});
	if (isExistInOther){
		return;
	}
	
	var tmpfileIds = [];
	//??????fileIds??????,?????????????????????id
    for(var i= 0;i<fileIds.length;i++){
        if(fileIds[i].fdAttId != obj.id){
        	tmpfileIds.push(fileIds[i]);
	    }
    }
    fileIds = tmpfileIds;
    if(confirm(message)){
    	//???????????????????????????
    	var controlId = $(obj).attr("controlId");
    	$("li[id='"+obj.id+"']",$("#signaturePicUL_" + controlId)).remove();
    	//?????????????????????
        $("li[id='"+obj.id+"']",$("#signaturePicUL")).remove();
	}
}
</script>
</kmss:authShow>
</kmss:ifModuleExist>