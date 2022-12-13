<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/edit_top.jsp" %>
<% response.addHeader("X-UA-Compatible", "IE=edge"); %>
<script src="./resource/weui_switch.js"></script>
<style type="text/css">
    
    	.lui_paragraph_title{
    		font-size: 15px;
    		color: #15a4fa;
        	padding: 15px 0px 5px 0px;
    	}
    	.lui_paragraph_title span{
    		display: inline-block;
    		margin: -2px 5px 0px 0px;
    	}
    
</style>
<script type="text/javascript">
    var formInitData = {

    };
    Com_IncludeFile("security.js");
    Com_IncludeFile("domain.js");
    Com_IncludeFile("form.js");
    Com_IncludeFile("config_edit.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_urgency/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/km/supervise/km_supervise_urgency/kmSuperviseUrgency.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${kmSuperviseUrgencyForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.kmSuperviseUrgencyForm, 'update');" />
            </c:when>
            <c:when test="${kmSuperviseUrgencyForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.kmSuperviseUrgencyForm, 'save');" />
			    <input type="button" value="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.kmSuperviseUrgencyForm, 'saveadd');" />
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow();" />
    </div>
    <p class="txttitle">${ lfn:message('km-supervise:table.kmSuperviseUrgency') }</p>
    <center>

        <div style="width:95%;">
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('km-supervise:kmSuperviseUrgency.fdName')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdName" _xform_type="text">
                            <xform:text property="fdName" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('km-supervise:kmSuperviseUrgency.fdOrder')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdOrder" _xform_type="text">
                            <xform:text property="fdOrder" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                	<td class="td_normal_title" width="15%">
                        ${lfn:message('km-supervise:kmSuperviseUrgency.fdIsAvailable')}
                    </td>
                    <td colspan="3">
	                    <html:hidden property="fdIsAvailable" /> 
							<label class="weui_switch">
								<span class="weui_switch_bd">
									<input type="checkbox" ${'true' eq kmSuperviseUrgencyForm.fdIsAvailable ? 'checked' : '' } />
									<span></span>
									<small></small>
								</span>
								<span id="fdIsAvailableText"></span>
							</label>
							<script type="text/javascript">
								function setText(status) {
									if(status) {
										$("#fdIsAvailableText").text('<bean:message key="kmSuperviseUrgency.fdIsAvailable.yes" bundle="km-supervise" />');
									} else {
										$("#fdIsAvailableText").text('<bean:message key="kmSuperviseUrgency.fdIsAvailable.no" bundle="km-supervise" />');
									}
								}
								$(".weui_switch :checkbox").on("click", function() {
									var status = $(this).is(':checked');
									$("input[name=fdIsAvailable]").val(status);
									setText(status);
								});
								setText('${kmSuperviseUrgencyForm.fdIsAvailable}');
							</script>
	                 </td>
                </tr>
            </table>
        </div>
    </center>
    <html:hidden property="fdId" />
    <html:hidden property="method_GET" />
    <script>
        $KMSSValidation();
    </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp" %>