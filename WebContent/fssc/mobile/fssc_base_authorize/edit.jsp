<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/edit_top.jsp" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
<%@ include file="/fssc/mobile/resource/jsp/mobile_include.jsp" %>
<%@ include file="/fssc/mobile/common/organization/organization_include.jsp" %>
<head>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <title></title>
    <link rel="stylesheet"  href="${LUI_ContextPath}/fssc/mobile/resource/css/swiper.min.css?s_cache=${LUI_Cache }">
	<link rel="stylesheet"  href="${LUI_ContextPath}/fssc/mobile/resource/css/layer.css?s_cache=${LUI_Cache }">
	<link rel="stylesheet"  href="${LUI_ContextPath}/fssc/mobile/resource/css/newApplicationForm.css?s_cache=${LUI_Cache }">
	<link rel="stylesheet" href="${LUI_ContextPath}/fssc/mobile/resource/css/city.css?s_cache=${LUI_Cache }" >
	<link rel="stylesheet" href="${LUI_ContextPath}/fssc/mobile/resource/css/home.css?s_cache=${LUI_Cache }">
	<link rel="stylesheet" href="${LUI_ContextPath}/fssc/mobile/resource/css/notSubmit.css?s_cache=${LUI_Cache }">

  <script>
    var formInitData = {
    		"LUI_ContextPath":"${LUI_ContextPath}" 
    };
   function submitForm(method){
    	var tips="${lfn:message('errors.required')}";
    	var fdDesc=$("input[name='fdDesc']").val();
    	if(!fdDesc){
    		jqtoast(tips.replace("{0}","${lfn:message('fssc-base:fsscBaseAuthorize.fdDesc')}"));
			return false;
    	}
    	var fdToOrgNames=$("input[name='fdToOrgNames']").val();
    	if(!fdToOrgNames){
    		jqtoast(tips.replace("{0}","${lfn:message('fssc-base:fsscBaseAuthorize.fdToOrg')}"));
			return false;
    	}
		Com_Submit(document.forms['fsscBaseAuthorizeForm'], method);
	}
    </script>
</head>
<body style="margin-top:-20px;">
<form action="${LUI_ContextPath }/fssc/mobile/fssc_mobile_authorize/fsscMobileAuthorize.do"  name="fsscBaseAuthorizeForm" method="post">
 <div class="ld-newApplicationForm">
        <div class="ld-newApplicationForm-info">
            <div>
                <span>${lfn:message("fssc-base:fsscBaseAuthorize.fdDesc")}</span>
                <div>
                     <input type="text"  name="fdDesc" value="${fsscBaseAuthorizeForm.fdDesc }" placeholder='${lfn:message("fssc-mobile:fssc.mobile.placeholder.input")}${lfn:message("fssc-base:fsscBaseAuthorize.fdDesc")}'  />
                     <span style="margin-left:2px;color:#d02300;">*</span>
                </div>
            </div>
            <div>
                <span>${lfn:message("fssc-base:fsscBaseAuthorize.fdAuthorizedBy")}</span>
                <div>
                     <input type="text" id="fdAuthorizedByName" name="fdAuthorizedByName" value="${fsscBaseAuthorizeForm.fdAuthorizedByName }" readonly="readonly" />
                     <input type="hidden" id="fdAuthorizedById" name="fdAuthorizedById"  value="${fsscBaseAuthorizeForm.fdAuthorizedById }" />
                </div>
            </div>
             <div>
                <span>${lfn:message("fssc-base:fsscBaseAuthorize.fdToOrg")}</span>
                <div class="ld-selectPersion">
                     <input type="text" placeholder='${lfn:message("fssc-mobile:fssc.mobile.placeholder.select")}${lfn:message("fssc-base:fsscBaseAuthorize.fdToOrg")}' name="fdToOrgNames"  onclick="selectOrgElement('fdToOrgIds','fdToOrgNames',null,'true','person');" value="${fsscBaseAuthorizeForm.fdToOrgNames }" readonly="readonly" >
                     <input name='fdToOrgIds' id="fdToOrgIds" value="${fsscBaseAuthorizeForm.fdToOrgIds }" hidden='true'/>
                     <span style="margin-left:2px;color:#d02300;">*</span>
                    <i></i>
                </div>
            </div>
   	</div>
   		<div class="ld-footer">
         <c:if test="${fsscBaseAuthorizeForm.method_GET=='add' }">
            <div class="ld-footer-blueBg" style="width:100%" onclick="submitForm('save');" >${ lfn:message('button.submit') }</div>
         </c:if>
         <c:if test="${fsscBaseAuthorizeForm.method_GET=='edit' }">
            <div class="ld-footer-blueBg" style="width:100%" onclick="submitForm('update');" >${ lfn:message('button.submit') }</div>
         </c:if>
       </div>
   </div>
</form>
</body>
<%@ include file="/resource/jsp/edit_down.jsp" %>
