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
<%@page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="java.util.Map"%>
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

ISysAppConfigService sysAppConfigService = (ISysAppConfigService) SpringBeanUtil.getBean("sysAppConfigService");
Map dataMap = sysAppConfigService.findByKey(
		"com.landray.kmss.third.esa.model.EsaConfig");
boolean esaEnable = false;
String ESASerSystemSq = "";

if ("true".equals(dataMap.get("kmss.integrate.esa.enabled"))) {
	esaEnable = true;
	request.setAttribute("lbpmNote_Id", request.getParameter("auditNoteFdId"));
	request.setAttribute("lbpmHandler_Id", request.getParameter("curHanderId"));
	
	ESASerSystemSq = (String)dataMap.get("kmss.esa.ESASerSystemSq");
	request.setAttribute("ESASerSystemSq", ESASerSystemSq);
}
request.setAttribute("esaEnable", esaEnable);

String signWidth = "70";
String width = (String)dataMap.get("kmss.esa.sign.width");
if(width!=null && !"".equals(width)){
	signWidth = width;
}
request.setAttribute("signWidth", signWidth);

String username = (String) session.getAttribute("PKI_VALIDATA_USERNAME");
username = username==null ? "":username;

%>
<kmss:ifModuleExist path="/km/signature/">
<kmss:authShow roles="ROLE_SIGNATURE_DEFAULT">
	<!-- 流程页签下展示已盖的签章 -->
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<div id="showSignature" style="display:none">
				<div class="lui-lbpm-titleNode">
					<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.show" />
				</div>
				<div class="lui-lbpm-detailNode" id="signaturePic">
					<ul id="signaturePicUL" class="clearfloat lui_sns_signatureList">
					</ul>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<tr id="showSignature" style="display:none;">
				<td class="td_normal_title" width="15%">
					<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.show" />
				</td>
				<td id="signaturePic" colspan="3" width="85%">
					<ul id="signaturePicUL" class="clearfloat lui_sns_signatureList">
					</ul>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
<script>
//流程页签初始化时将签章按钮插入其他按钮后
$(document).ready(function () {
	if (typeof(seajs) != 'undefined') {
		var isRight = "${param.approveModel eq 'right'}";
		if(isRight == "true"){
			var html = '<div class="lui-lbpm-opinion-signature lui-lbpm-opinion-btn" title="<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.name" />" onclick="signature();">';
			html += ' <i></i>';
			html += '</div>';
			//$(".lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-more").before(html);
			var btnLen= $('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').length;
			//如果超过3个按钮，则按三个按钮计算，并把当前按钮放置到更多中
			if(btnLen-1 >= 3){
				//转移最后一个到更多中
				$(".lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-more").find(".lui-lbpm-opinion-moreList").eq(0).find("ul").append("<li>"+$('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').eq(btnLen-2).prop("outerHTML")  + "</li>");
				$('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').eq(btnLen-2).remove();
				
				html = "<li>" + html + "</li>";
				$(".lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-more").find(".lui-lbpm-opinion-moreList").eq(0).find("ul").append(html);
				$('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').css({
			        'width':100/3+'%'
			    });
				$('.lui-lbpm-opinion-moreList .lui-lbpm-opinion-btn').css({
			        'width':'100%'
			    });
				$('.lui-lbpm-opinion-more').css({
					'display':'inline-block'
				})
			}else{
				//$(".lui-lbpm-opinion-otherFnc").append(html);
				$(".lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-more").before(html)
				$('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').css({
			        'width':100/btnLen+'%'
			    });
			}
		}else{
			var func = "/km/signature/km_signature_main/kmSignatureMain_showSig.jsp";
			var html = '&nbsp;&nbsp;';
			html += '<a href="javascript:;" class="com_btn_link" id="signature" onclick="signature();">';
			html += '<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.name" />';
			html += '</a>';
			$("#optionButtons").append(html);
		}
		
	}else{//非新UED模块屏蔽流程签章功能
		document.getElementById("showSignature").style.display = "none";
	}
	if(lbpm && lbpm.events && lbpm.events.addListener){
		lbpm.events.addListener(lbpm.constant.EVENT_HANDLERTYPECHANGE, function(param){
			if(param!='' && param!=lbpm.constant.PROCESSORROLETYPE){
				$("#showSignature").hide();
			}else{
		 		// #60715 起草节点隐藏审批意见框
		 		var showSignature = document.getElementById("showSignature");
		 		if(lbpm.nowNodeId == "N2" && Lbpm_SettingInfo.isDraftNodeDisplayOpinion == "true") {
		 			if(lbpm.constant.DOCSTATUS != "11" && Lbpm_SettingInfo.isNewPageAndDraftsManRecallPage == "true") {
		 				lbpm.globals.hiddenObject(showSignature, true);
		 			}
		 			if(lbpm.constant.DOCSTATUS == "11" && Lbpm_SettingInfo.isRejectPage == "true") {
		 				lbpm.globals.hiddenObject(showSignature, true);
		 			}		
		 		} else {
		 			if(fileIds.length > 0){
		 				$("#showSignature").show();
		 			}else{
		 				$("#showSignature").hide();
		 			}
		 		}
			}
		});
	}
	if(lbpm && lbpm.constant && lbpm.constant.ROLETYPE!='' && lbpm.constant.ROLETYPE!=lbpm.constant.PROCESSORROLETYPE){
		$("#showSignature").hide();
	}
	if (typeof(seajs) != 'undefined') {//非新UED模块屏蔽流程签章功能
		if(lbpm && lbpm.allMyProcessorInfoObj && lbpm.allMyProcessorInfoObj.length>0 && !lbpm.hideDescriptionOnDraftNode){
			loadAutoSignaturePic();
		}
		if(lbpm && lbpm.approveType == "right" && fileIds.length == 0){
			$("#showSignature").hide();
		}
	}
});
if (typeof(seajs) != 'undefined') {//非新UED模块屏蔽流程签章功能
	var fileIds = [];
	//loadAutoSignaturePic();
	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
		//新建
		window.signature = function() {
			var url = "/km/signature/km_signature_main/kmSignatureMain_showSig.jsp";
			dialog.iframe(url,'<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.name" />',function(rtn){
				if(rtn!=null){
					var file = {
						fdAttId:rtn.attId
		            };
					signatureImgShow(file); 
				}
			},{width:800,height:270});
		};
	});
	
    //签章图片显示
	function signatureImgShow(file){
		if (!file || !file.fdAttId){
			return ;
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
			var imageUl = $("#signaturePicUL");
			var html = '<li id="'+file.fdAttId+'"><img width="100" height="75" src="${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId='+file.fdAttId+'"/>';
			html += '<span id="'+file.fdAttId+'" class="btn_canncel_img" onclick="deletex(this);"></span></li>';
			if(imageUl.length > 0){
				if(imageUl[0].innerHTML==""){
					imageUl.html(html);
				}else{
					imageUl.append(html);
				}
			}else{
				var rowhtml = '<kmss:ifModuleExist path="/km/signature/">';
				rowhtml += '<tr id="showSignature"><td class="td_normal_title" width="15%"><bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.sigPic" /></td>';
				rowhtml += '<td colspan="3" width="85%" id="signaturePic"><ul id="signaturePicUL" class="clearfloat lui_sns_signatureList">'+html+'</ul></td></tr>';
				rowhtml += '</kmss:ifModuleExist>';
				$("#descriptionRow").after(rowhtml);
			}
			$("#showSignature").show();
        }else{
			alert('<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.reupload" />');
        }
	}
	
    //加载自动签名：加载默认个人签名的并且开启免密签名，流程新建的是自动加载出来不需要弹框选择
	function loadAutoSignaturePic(){
		var autoSignPicUrl = "${KMSS_Parameter_ContextPath}km/signature/km_signature_main/kmSignatureMain.do?method=confirmSignature";
		$.ajax({
		     type:"post",
		     url:autoSignPicUrl,
		     data:{"autoSignature":true},
		     async:true,
		     success:function(data){
				if (data.flag == '1') {
					var file = {fdAttId:data.attId };
					signatureImgShow(file);
	            };
			}
	    });
	}
	
	//删除附件
	function deletex(obj){
		//debugger;
		var tmpfileIds = [];
        for(var i= 0;i<fileIds.length;i++){
	        if(fileIds[i].fdAttId != obj.id){
	        	tmpfileIds.push(fileIds[i]);
		    }
        }
        fileIds = tmpfileIds;
        if(confirm('<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.confirm" />')){
	        $("li[id='"+obj.id+"']").remove();
		}
        if(fileIds.length == 0 && lbpm && lbpm.approveType == "right"){
    		$("#showSignature").hide();
    	}
	}

	//监听流程提交事件，绑定签章信息, #67801 修改为confirm事件，公文套红签章提交时有可能取消，导致签名重复
	Com_Parameter.event["confirm"].push(function(){     //流程提交生成附件信息
		var flag = false;
		//#60715 起草节点隐藏审批意见框
		if(lbpm.nowNodeId == "N2" && Lbpm_SettingInfo.isDraftNodeDisplayOpinion == "true"){
			if(lbpm.constant.DOCSTATUS != "11" && Lbpm_SettingInfo.isNewPageAndDraftsManRecallPage == "true"){
				fileIds.length = 0;
			}else if(lbpm.constant.DOCSTATUS == "11" && Lbpm_SettingInfo.isRejectPage == "true"){
				fileIds.length = 0;
			}else{
				
			}
		}else{
			
		} 
		if(fileIds.length>0){
			var fdAttIds = "";
			for(var i= 0;i<fileIds.length;i++){
				if(i != fileIds.length-1){
					fdAttIds += fileIds[i].fdAttId + ";";
				}else{
					fdAttIds += fileIds[i].fdAttId;
				}
			}
			var fdKey = "${JsParam.auditNoteFdId}" + "_qz";
			var fdModelId = "${JsParam.modelId}";
			var fdModelName = "${JsParam.modelName}";
			var checkUrl = "${KMSS_Parameter_ContextPath}km/signature/km_signature_main/kmSignatureMain.do?method=submitSignature";
			$.ajax({
			     type:"post",
			     url:checkUrl,
			     data:{"fdAttIds":fdAttIds,"fdKey":fdKey,"fdModelId":fdModelId,"fdModelName":fdModelName},
			     async:false,
			     success:function(data){
			    	 flag = data.flag;
				}
		    });
		}else{
			flag = true;
		}
		return flag;
	});
}
</script>
</kmss:authShow>
</kmss:ifModuleExist>

<c:if test="${esaEnable == true}">
	<object classid="clsid:5A41B8F3-2BE5-4000-8ABF-E6E269C20218" id="aztManageKey" width="0" height="0"></object>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<div id="showSignature2" style="display:none">
				<div class="lui-lbpm-titleNode">
					<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.show" />
				</div>
				<div class="lui-lbpm-detailNode" id="signaturePic">
					<div id="signSealkeyPrivate_${JsParam.auditNoteFdId}" style="position:relative;min-width:120px;max-width:150px; height:80px;float:left;">&nbsp;
						<object style="z-index:1000;position:absolute;width:100%;height:100%;" id="aztWebSignSealkeyPrivate" classid="clsid:07121F49-A0DC-4EBD-A2A2-A0A71DC6FDB9"></object>
					</div>
					<div id="signSealkeyPublic_${JsParam.auditNoteFdId}" style="position:relative;min-width:120px;max-width:150px; height:100px;float:left;">&nbsp;
						<object style="z-index:1000;position:absolute;width:100%;height:100%;" id="aztWebSignSealkeyPublic" classid="clsid:07121F49-A0DC-4EBD-A2A2-A0A71DC6FDB9"></object>
					</div>
					<ul id="signaturePicUL" class="clearfloat lui_sns_signatureList">
					</ul>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<!-- 流程页签下展示已盖的签章 -->
			<tr id="showSignature2" style="display:none;">
				<td class="td_normal_title" width="15%">
					<bean:message bundle="sys-lbpmservice" key="lbpm.process.signature.show" />
				</td>
				<td id="signaturePic" colspan="3" width="85%">
					<div id="signSealkeyPrivate_${JsParam.auditNoteFdId}" style="position:relative;min-width:120px;max-width:150px; height:80px;float:left;">&nbsp;
						<object style="z-index:1000;position:absolute;width:100%;height:100%;" id="aztWebSignSealkeyPrivate" classid="clsid:07121F49-A0DC-4EBD-A2A2-A0A71DC6FDB9"></object>
					</div>
					<div id="signSealkeyPublic_${JsParam.auditNoteFdId}" style="position:relative;min-width:120px;max-width:150px; height:100px;float:left;">&nbsp;
						<object style="z-index:1000;position:absolute;width:100%;height:100%;" id="aztWebSignSealkeyPublic" classid="clsid:07121F49-A0DC-4EBD-A2A2-A0A71DC6FDB9"></object>
					</div>
					<ul id="signaturePicUL" class="clearfloat lui_sns_signatureList">
					</ul>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
<style>
ul, li { list-style: none; }
.btn_canncel_img{
	display:inline-block;
	width:20px;
	height:20px;
    background:url(${KMSS_Parameter_ContextPath}sys/lbpmservice/signature/images/closeDiv.png) no-repeat 50%;
    background-size: 20px; 
    display:block;
    cursor:pointer;
}

.clearfloat { zoom: 1; }
.clearfloat:after { display: block; clear: both; visibility: hidden; line-height: 0px; content: 'clear'; }

.lui_sns_signatureList{ }
.lui_sns_signatureList li{ float:left; padding-top:3px; margin-right:15px; margin-bottom:8px; position:relative;}
.lui_sns_signatureList li img{ width:100px; height:75px;}
.lui_sns_signatureList .btn_canncel_img{ position:absolute; right:-8px; top:-5px;}
</style>
<script>
//流程页签初始化时将签章按钮插入其他按钮后
$(document).ready(function () {
	var nodePublicSign = "${requestScope[param.formName].sysWfBusinessForm.fdNodeAdditionalInfo.publicSign}";
	var nodePrivateSign = "${requestScope[param.formName].sysWfBusinessForm.fdNodeAdditionalInfo.privateSign}";
	if (typeof(seajs) != 'undefined') {
		//var func = "/km/signature/km_signature_main/kmSignatureMain_showSig.jsp";
		var html = '&nbsp;&nbsp;';
		if(nodePrivateSign!="" && nodePrivateSign=="true"){
			html += '<a href="javascript:;" class="com_btn_link" id="signaturePrivate" onclick="keySignPrivateSeal();">';
			html += '个人签名';
			html += '</a>';
		}
		if(nodePublicSign!="" && nodePublicSign=="true"){
			html += '&nbsp;&nbsp;<a href="javascript:;" class="com_btn_link" id="signaturePublic" onclick="keySignpublicSeal();">';
			html += '加盖公章';
			html += '</a>';
		}
		$("#optionButtons").append(html);
		
		
		//keySignPrivateSeal();
		
	}else{//非新UED模块屏蔽流程签章功能
		document.getElementById("showSignature2").style.display = "none";
	}
});
if (typeof(seajs) != 'undefined') {//非新UED模块屏蔽流程签章功能
	var fileIds = [];
	var signature_flag = true;
	var ESASerSystemSq_value="<%=ESASerSystemSq%>";
	var signWidth_value = "<%=signWidth%>";
	
	var login_name = "<%=UserUtil.getUser().getFdLoginName()%>";
	var username = "<%=username%>";
	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
		//设置服务授权
		function ESASerSystemSq(){
			if(username==null || username==""){
				alert("获取电子签章信息失败，请使用电子证书登录！");
				return false;
			}
			//if(signature_flag){
				var nRit=document.getElementById("aztManageKey").ESASerSystemSq(ESASerSystemSq_value); 
				if(nRit>0){
					alert("电子签字服务授权失败");
					return false;
				}else{
					signature_flag = false;
				}
			//}
			return true;
		}
		
		//加盖公章
		window.keySignpublicSeal = function() {
			if(!ESASerSystemSq()){
				alert("获取电子签章信息失败");
				return false;
			}
			var aztWebSignSealkeyPublic = document.getElementById("aztWebSignSealkeyPublic");
			aztWebSignSealkeyPublic.ESASetDataisEncrypt(1);//设置返回数据是否加密(1加密，否则不加密)
			aztWebSignSealkeyPublic.ESASetPositionTay("signSealkeyPublic_${JsParam.auditNoteFdId}",1);//设置印章签章ID为ONE的标签上，2标识印章中心点在标签0,0位置
			var base64s = new Base64();
			//签章传入保护数据，移动端必填对应PC也填入。base64的数据
			aztWebSignSealkeyPublic.ESASetSignData(1,base64s.encode("${JsParam.modelId}"));
			aztWebSignSealkeyPublic.ESASignSeal(1,2,"10001","");
			aztWebSignSealkeyPublic.style.top="0px";
			aztWebSignSealkeyPublic.style.left="300px";
			
			$("#showSignature2").show();
			document.getElementById("showSignature2").style.display = "";
		};
		//个人签名
		window.keySignPrivateSeal = function() {
			if(!ESASerSystemSq()){
				alert("获取电子签章信息失败");
				return false;
			}
			var aztWebSignSealkeyPrivate = document.getElementById("aztWebSignSealkeyPrivate");
			aztWebSignSealkeyPrivate.ESASetDataisEncrypt(1);//设置返回数据是否加密(1加密，否则不加密)
			aztWebSignSealkeyPrivate.ESASetPositionTay("signSealkeyPrivate_${JsParam.auditNoteFdId}",1);//设置印章签章ID为ONE的标签上，2标识印章中心点在标签0,0位置
			//alert("aztWebSignSealkeyPrivate.ESASetPositionTay");
			var base64s = new Base64();
			aztWebSignSealkeyPrivate.ESASetSignData(1,base64s.encode("${JsParam.modelId}"));
			aztWebSignSealkeyPrivate.ESASignSeal(2,2,"10001","");
			//alert("aztWebSignSealkeyPrivate.ESASignSeal");
			aztWebSignSealkeyPrivate.ESASetIMGSize(signWidth_value,0);
			aztWebSignSealkeyPrivate.style.top="0px";
			aztWebSignSealkeyPrivate.style.left="0px";
			//alert("aztWebSignSealkeyPrivate.style.left");
	        //------------判断当前电子证书和登录人是否一直-------------------------
	        /*if(ESASignatureFlag){
	        	var data = aztWebSignSealkeyPrivate.ESAGetSealInformaiton("",1,1);	//获取签章的所有信息，除图片外
		        //创建文档对象  
		        var parser=new DOMParser();  
		        var xmlDoc=parser.parseFromString(data,"text/xml");  
		       
		        //提取数据  
		        var SignatureName = xmlDoc.getElementsByTagName('SignatureName');
		        if(login_name!=SignatureName[0].textContent){
		        	alert("电子签字获取信息："+SignatureName[0].textContent+";与当前登录人信息不匹配，请检查重新签字");
		        	return false;
		        }
	        }
		    aztWebSignSealkeyPrivate.ESADelEvent(function(pos){});
		    */
	      	//------------判断当前电子证书和登录人是否一直-------------------------
			$("#showSignature2").show();
			document.getElementById("showSignature2").style.display = "";
		};
	});

	
	//监听流程提交事件，绑定签章信息
	Com_Parameter.event["submit"].push(function(){     //流程提交生成附件信息
		
		var nodePublicSign = "${requestScope[param.formName].sysWfBusinessForm.fdNodeAdditionalInfo.publicSign}";
		var nodePrivateSign = "${requestScope[param.formName].sysWfBusinessForm.fdNodeAdditionalInfo.privateSign}";
		
		if((nodePublicSign!="" && nodePublicSign=="true")|| (nodePrivateSign!="" && nodePrivateSign=="true")){
			
		}else{
			//alert("无需签章");
			return true;
		}
		
		var aztWebSignSealkeyPrivate= document.getElementById("aztWebSignSealkeyPrivate");
		var aztWebSignSealkeyPublic= document.getElementById("aztWebSignSealkeyPublic");
		/* if(ESASignatureFlag && (privategndata==null || privategndata=="")){
			alert("电子签章失败，必须进行电子签章才可以提交流程审批！");
			return false;
		} */
		var fdModelId = "${JsParam.modelId}";
		var fdModelName = "${JsParam.modelName}";
		var lbpmNote_Id = "${JsParam.auditNoteFdId}";
		var checkUrl = "${KMSS_Parameter_ContextPath}third/esa/third_esa_signature_lbpm_info/esaSignatureLbpmInfo.do?method=ajaxSave";
		
		var personStaffType= 1;
		var _StaffType = true;
		//获取员工类型民警必须签章。
		if(personStaffType!=null && personStaffType != 1){
			_StaffType = false;
		}

		try{
			
			if(aztWebSignSealkeyPrivate || aztWebSignSealkeyPublic){
				privategndata=aztWebSignSealkeyPrivate.ESASaveSignData();  //保存个人签章数据;
				publicgndata=aztWebSignSealkeyPublic.ESASaveSignData();  //保存公章信息数据;
				if(privategndata!=null && privategndata!=""){
					//alert(privategndata);
					$.ajax({
					     type:"post",
					     url:checkUrl,
					     data:{"privategndata":privategndata,"publicgndata":publicgndata,"fdModelId":fdModelId,"lbpmNote_Id":lbpmNote_Id,"fdModelName":fdModelName},
					     async:false,
					     success:function(data){
					    	 //alert(data);
						}
				    });
				}
			}
		}catch(e){
			console.log(e);
			alert("获取签章数据失败,"+e);
			return false;
		}
		

		
		//alert("提交保存动作");
		return true;
	});
	
	function Base64() {
		 
		// private property
		_keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	 
		// public method for encoding
		this.encode = function (input) {
			var output = "";
			var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
			var i = 0;
			input = _utf8_encode(input);
			while (i < input.length) {
				chr1 = input.charCodeAt(i++);
				chr2 = input.charCodeAt(i++);
				chr3 = input.charCodeAt(i++);
				enc1 = chr1 >> 2;
				enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
				enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
				enc4 = chr3 & 63;
				if (isNaN(chr2)) {
					enc3 = enc4 = 64;
				} else if (isNaN(chr3)) {
					enc4 = 64;
				}
				output = output +
				_keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
				_keyStr.charAt(enc3) + _keyStr.charAt(enc4);
			}
			return output;
		}
	 
		// public method for decoding
		this.decode = function (input) {
			var output = "";
			var chr1, chr2, chr3;
			var enc1, enc2, enc3, enc4;
			var i = 0;
			input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
			while (i < input.length) {
				enc1 = _keyStr.indexOf(input.charAt(i++));
				enc2 = _keyStr.indexOf(input.charAt(i++));
				enc3 = _keyStr.indexOf(input.charAt(i++));
				enc4 = _keyStr.indexOf(input.charAt(i++));
				chr1 = (enc1 << 2) | (enc2 >> 4);
				chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
				chr3 = ((enc3 & 3) << 6) | enc4;
				output = output + String.fromCharCode(chr1);
				if (enc3 != 64) {
					output = output + String.fromCharCode(chr2);
				}
				if (enc4 != 64) {
					output = output + String.fromCharCode(chr3);
				}
			}
			output = _utf8_decode(output);
			return output;
		}
	 
		// private method for UTF-8 encoding
		_utf8_encode = function (string) {
			string = string.replace(/\r\n/g,"\n");
			var utftext = "";
			for (var n = 0; n < string.length; n++) {
				var c = string.charCodeAt(n);
				if (c < 128) {
					utftext += String.fromCharCode(c);
				} else if((c > 127) && (c < 2048)) {
					utftext += String.fromCharCode((c >> 6) | 192);
					utftext += String.fromCharCode((c & 63) | 128);
				} else {
					utftext += String.fromCharCode((c >> 12) | 224);
					utftext += String.fromCharCode(((c >> 6) & 63) | 128);
					utftext += String.fromCharCode((c & 63) | 128);
				}
	 
			}
			return utftext;
		}
	 
		// private method for UTF-8 decoding
		_utf8_decode = function (utftext) {
			var string = "";
			var i = 0;
			var c = c1 = c2 = 0;
			while ( i < utftext.length ) {
				c = utftext.charCodeAt(i);
				if (c < 128) {
					string += String.fromCharCode(c);
					i++;
				} else if((c > 191) && (c < 224)) {
					c2 = utftext.charCodeAt(i+1);
					string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
					i += 2;
				} else {
					c2 = utftext.charCodeAt(i+1);
					c3 = utftext.charCodeAt(i+2);
					string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
					i += 3;
				}
			}
			return string;
		}
	}
	
}
</script>

</c:if>