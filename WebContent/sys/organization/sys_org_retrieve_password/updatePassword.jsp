<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.util.*,com.landray.kmss.sys.organization.model.SysOrgPerson"%>

<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<% 
	response.addHeader("X-UA-Compatible", "IE=8"); 
	String val = (String)request.getSession().getAttribute("RETRIEVE_PASSWORD_VALIDATION_PASS");
	SysOrgPerson person = (SysOrgPerson) request.getSession().getAttribute("RETRIEVE_PASSWORD_PERSON");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=ResourceUtil.getMessage("{sys-organization:sysOrgPerson.button.changePassword}")%></title>
<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="./retrievePassword.css">
<link rel="stylesheet" type="text/css" href="./updatePassword.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/sys/common/changePwd/js/pwdstrength.js"></script>

<script type="text/javascript">
		Com_IncludeFile("security.js");
		var passwordUndercapacity = '<bean:message bundle="sys-organization" key="sysOrgPerson.error.passwordUndercapacity" />';
		var pwdStructure1 = '<bean:message bundle="sys-organization" key="sysOrgPerson.error.pwdStructure1" />';
		var pwdStructure2 = '<bean:message bundle="sys-organization" key="sysOrgPerson.error.pwdStructure2" />';
		var pwdInput = '<bean:message bundle="sys-organization" key="sysOrgPerson.error.pwdInput" />';
		var newPwdCanNotSameOldPwd= '<bean:message bundle="sys-organization" key="sysOrgPerson.error.newPwdCanNotSameOldPwd" />';
		var newPwdCanNotSameLoginName= '<bean:message bundle="sys-organization" key="sysOrgPerson.error.newPwdCanNotSameLoginName" />';
		var noUserInSession= '<bean:message bundle="sys-organization" key="sysOrgRetrievePassword.error.noUserInSession" />';
		var url = "<%=request.getContextPath()%>" + "/sys/organization/sys_org_retrieve_password/validateUser.jsp";
		noUserInSession = "<a href=\"" + url + "\">"+noUserInSession+"</a>";

		<% 
			if(person == null || !"true".equals(val)){
		%>
				location.href = url;
		<% 
			}
		String kmssOrgPasswordlength = new com.landray.kmss.sys.profile.model.PasswordSecurityConfig().getKmssOrgPasswordlength();
		String kmssOrgPasswordstrength = new com.landray.kmss.sys.profile.model.PasswordSecurityConfig().getKmssOrgPasswordstrength();
		%>
		var pwdlen = <%=StringUtil.isNull(kmssOrgPasswordlength) ? "1" : kmssOrgPasswordlength%>;
		var pwdsth = <%=StringUtil.isNull(kmssOrgPasswordstrength) ? "0" : kmssOrgPasswordstrength%>;
				
		var isAdmin = "<%=UserUtil.getUser().getFdLoginName().equals("admin")%>";
		var loginName = "<%=UserUtil.getUser().getFdLoginName()%>";
		if(isAdmin=="true") {
			// ???????????????????????????????????????????????????????????????????????????????????????????????????????????????
			pwdlen = pwdlen < 8 ? 8 : pwdlen;
			pwdsth = pwdsth < 3 ? 3 : pwdsth;
		}
		
		$(function(){

			// ?????????????????????
			$("input[name=fdNewPassword]").focus(function() {
				var msg;
				if(pwdsth > 1) {
					msg = pwdlen + pwdStructure2.replace("#len#", pwdsth);
				}else{
					msg = pwdlen + pwdStructure1;
				}
				setPwdTip('newPwdTip', 'blueIcon', msg);
			});
			$("input[name=fdNewPassword]").blur(function() {
				var me = this;
				if(checkPwd($(me), "newPwdTip")){
					$(me).parent().removeClass("status_correct status_error");
					$(me).parent().addClass("status_correct");
					hidePwdTip('newPwdTip');
				} else {
					$(me).parent().addClass("status_error");
				}
				$(me).parent().removeClass("status_focus");
			});
			// ?????????????????????
			$("input[name=fdNewPassword]").keyup(function() {
				var value = $(this).val();
				if(value.length == 0) {
					setPwdIntensity(0);
					return false;
				}
				var intension = 0;
				if(value.length < pwdlen || pwdstrength(value) ==1){
					intension = 1;
				} else if(value.length == pwdlen && pwdstrength(value) >=2){
					intension = 2;
				} else if(value.length > pwdlen && pwdstrength(value) >=2){
					intension = 3;
				}
				setPwdIntensity(intension);
			});

			// ??????????????????
			$("input[name=fdConfirmPassword]").focus(function() {
				var msg;
				if(pwdsth > 1) {
					msg = pwdlen + pwdStructure2.replace("#len#", pwdsth);
				}else{
					msg = pwdlen + pwdStructure1;
				}
				setPwdTip('confirmPwdTip', 'blueIcon', msg);
			});
			$("input[name=fdConfirmPassword]").blur(function() {
				var me = this;

				// ??????????????????????????????
				if($("input[name=fdNewPassword]").val() != me.value){
					setPwdTip('confirmPwdTip', 'redIcon', "<bean:message bundle='sys-organization' key='sysOrgPerson.error.comparePwd' />");
					$(me).parent().addClass("status_error");
				} else {
					$(me).parent().removeClass("status_focus");
					$(me).parent().addClass("status_correct");
					hidePwdTip('confirmPwdTip');
				}
			});

			// ?????????????????????
			$("input").bind({
				focus : function() {
					$(this).parent().removeClass("status_correct status_error");
					$(this).parent().addClass("status_focus");
				}
			});

			// ????????????
			$("#change_password_form .btn_submit").click(function() {
				var form = $("#change_password_form");
				// ?????????
				var fdNewPassword = form.find("input[name=fdNewPassword]");
				if(!checkPwd(fdNewPassword, "newPwdTip")) {
					fdNewPassword.parent().addClass("status_error");
					return false;
				}
				// ???????????????
				var fdConfirmPassword = form.find("input[name=fdConfirmPassword]");
				if(fdNewPassword.val() != fdConfirmPassword.val()) {
					$("input[name=fdConfirmPassword]").parent().addClass("status_error");
					setPwdTip('confirmPwdTip', 'redIcon', "<bean:message bundle='sys-organization' key='sysOrgPerson.error.comparePwd' />");
					return false;
				}

				document.getElementsByName("fdNewPassword")[0].value = desEncrypt(document.getElementsByName("fdNewPassword")[0].value);
				document.getElementsByName("fdConfirmPassword")[0].value = desEncrypt(document.getElementsByName("fdConfirmPassword")[0].value);

				$.ajax({
					type : "POST",
					url : form.attr("action"),
					data : $("#change_password_form").serialize(),
					dataType : 'json',
					success : function(result) {
						if (result.success || result.msg == "<%=ResourceUtil.getMessage("{sys-organization:sysOrgPerson.chgMyPwd.success}")%>") {
							$("#change_password_form .error").html("");
							location.href = "<%=request.getContextPath()%>/sys/organization/sys_org_retrieve_password/retrievePasswordSuccess.jsp";
						} else {
							$("#change_password_form input[name=fdNewPassword]").parent().addClass("status_error");
							setPwdTip('newPwdTip', 'redIcon', result.msg);
							document.getElementsByName("fdNewPassword")[0].value = '';
							document.getElementsByName("fdConfirmPassword")[0].value = '';
						}
					},
					error : function(result) {
						if (result.responseJSON) {
							var pwdErrorType = result.responseJSON.msg;
							if ("1" == pwdErrorType) {
								$("#change_password_form input[name=fdNewPassword]").parent().addClass("status_error");
								setPwdTip('newPwdTip', 'redIcon', "<%=ResourceUtil.getMessage("{sys-organization:sysOrgPerson.error.noPassword}")%>");
							} else if ("3" == pwdErrorType) {
								$("#change_password_form input[name=fdNewPassword]").parent().addClass("status_error");
								setPwdTip('newPwdTip', 'redIcon', "<%=ResourceUtil.getMessage("{sys-organization:sysOrgPerson.error.same}")%>");
							} else if ("4" == pwdErrorType) {
								$("#change_password_form input[name=fdNewPassword]").parent().addClass("status_error");
								setPwdTip('newPwdTip', 'redIcon', newPwdCanNotSameLoginName);
							} else if ("5" == pwdErrorType) {
								$("#change_password_form input[name=fdNewPassword]").parent().addClass("status_error");
								setPwdTip('newPwdTip', 'redIcon', newPwdCanNotSameOldPwd);
							} else if ("10" == pwdErrorType) {
								$("#change_password_form input[name=fdNewPassword]").parent().addClass("status_error");
								setPwdTip('newPwdTip', 'redIcon', noUserInSession);
							}  else {
								pwdstrengthCheck($("input[name=fdNewPassword]"), "newPwdTip");
								$("input[name=fdNewPassword]").parent().addClass("status_error");
							}
							document.getElementsByName("fdNewPassword")[0].value = '';
							document.getElementsByName("fdConfirmPassword")[0].value = '';
						}
					}
				});
			});
		});

		// ???????????????????????????
		function pwdstrengthCheck(password, pwdTip) {
			var msg;
			if(pwdsth > 1) {
				msg = pwdlen + pwdStructure2.replace("#len#", pwdsth);
			}else{
				msg = pwdlen + pwdStructure1;
			}
			if(password.val().length < pwdlen){
				setPwdTip(pwdTip, 'redIcon', msg);
				return false;
			}
			
			if(pwdsth > 0 && pwdstrength(password.val()) < pwdsth){
				setPwdTip(pwdTip, 'redIcon', msg);
				return false;
			}

			return true;
		}

		// ???????????????
		function checkPwd(password, pwdTip) {
			// ??????????????????
			if(!password.val() || !$.trim(password.val())){
				setPwdTip(pwdTip, 'redIcon', pwdInput);
				return false;
			}
			
			if(!pwdstrengthCheck(password, pwdTip)){
				return false;
			}
			
			
			// ?????????????????????????????????
			if(loginName == password.val()) {
				password.parent().addClass("status_error");
				setPwdTip(pwdTip, 'redIcon', newPwdCanNotSameLoginName);
				return false;
			}
			
			return true;
		}

		// ????????????????????????
		function setPwdIntensity(intension) {
			$(".intension span").removeClass("status_warn");
			$.each($(".intension span"), function(i, n){
				if(i >= intension) {
					return;
				}
				$(n).addClass("status_warn");
			});
		}

		// ??????????????????
		function setPwdTip(className, icon, text) {
			$('.' + className + ' .icon span').removeClass().addClass(icon);
			$('.' + className + ' .textTip').html(text);
		}

		//??????????????????
		function hidePwdTip(className) {
			$('.' + className + ' .icon span').removeClass();
			$('.' + className + ' .textTip').html("");
		}
	</script>
	
</head>
<body class="pg-retrieve--reset theme--www">





    <div class="content">
        <h3 class="headline"><span class="headline__content"><bean:message  bundle="sys-organization" key="sysOrgRetrievePassword.retrievePassword" /></span></h3>
        <ul class="steps-bar steps-bar--dark cf">
    <li class="step step--first step--pre" style="z-index:3">
        <span class="step__num">1.</span>
        <span><bean:message  bundle="sys-organization" key="sysOrgRetrievePassword.confirm.account" /></span>
        <span class="arrow__background"></span><span class="arrow__foreground"></span>
    </li>
    <li class="step step--pre" style="z-index:2">
        <span class="step__num">2.</span>
        <span><bean:message  bundle="sys-organization" key="sysOrgRetrievePassword.validation.type.select" /></span>
        <span class="arrow__background"></span><span class="arrow__foreground"></span>
    </li>
    <li class="step step--current" style="z-index:1">
        <span class="step__num">3.</span>
        <span><bean:message  bundle="sys-organization" key="sysOrgRetrievePassword.validate.update" /></span>
        <span class="arrow__background"></span><span class="arrow__foreground"></span>
    </li>
    <li class="step step--last step--post" style="z-index:0">
        <span class="step__num">4.</span>
        <span><bean:message  bundle="sys-organization" key="sysOrgRetrievePassword.complete" /></span>
        
    </li>
</ul>


        <div class="form__wrapper" style="padding-top: 15px; padding-bottom:0;">
            <form class="form__content" id="change_password_form" method="POST" action="<%=request.getContextPath()%>/sys/organization/sys_org_retrieve_password/sysOrgRetrievePassword.do?method=saveNewPwd" style="width:900px;" onsubmit="return false;">
                <div class="retrieve__title" style="margin-top: -10px;">
                    <h2 class="title" ><font size="4"><bean:message  bundle="sys-organization" key="sysOrgRetrievePassword.update.password.tip" /></font></h2>
                </div>
                <br>
                <div class="lui_changepwd_panel">
                <div class="content" style="margin-top:-10px;padding-bottom:0;margin-bottom:0;">
                <table>
					<tr>	
                        <td class="td_title">
                            <span class="title"><%=ResourceUtil.getMessage("{sys-organization:sysOrgPerson.newPassword}")%></span>
                        </td>
                        <td class="td_input">
                            <div class="input"><input type="password" name="fdNewPassword" /><i class="icon_cancel"></i><i class="icon_correct"></i></div>
                        </td>
                        <td class="td_tips">
                            <div class="pwdTip newPwdTip">
                                <span class="icon"><span></span></span>
                                <span class="textTip"><i class="status status_r"></i></span>
                            </div>
                        </td>
					</tr>
                    <tr>
                        <td class="td_title">
                            <span class="title"><%=ResourceUtil.getMessage("{sys-organization:sysOrgPerson.pwdIntensity}")%></span>
                        </td>
                        <td class="td_input">
                            <div class="intension">
                                <span class="status"></span>
                                <span class="status"></span>
                                <span class="status"></span>
                            </div>
                        </td>
                        <td class="td_tips">
                        </td>
                    </tr>
					<tr>
                        <td class="td_title">
                            <span class="title"><%=ResourceUtil.getMessage("{sys-organization:sysOrgPerson.confirmPassword}")%></span>
                        </td>
                        <td class="td_input">
                            <div class="input"><input type="password" name="fdConfirmPassword" /><i class="icon_cancel"></i><i class="icon_correct"></i></div>
                        </td>
                        <td class="td_tips">
                            <div class="pwdTip confirmPwdTip">
                                <span class="icon"><span></span></span>
                                <span class="textTip"></span>
                            </div>
                        </td>
					</tr>
				</table>
				<div class="btnW" id="btn_submit"><a class="btn_submit"><%=ResourceUtil.getMessage("{button.submit}")%></a></div>
				</div>
				</div>
               
            </form>
        </div>
    </div>

</body>
</html>
