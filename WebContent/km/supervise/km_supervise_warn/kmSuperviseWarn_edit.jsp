<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/edit_top.jsp" %>
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
    Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_warn/", 'js', true);
</script>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>

<html:form action="/km/supervise/km_supervise_warn/kmSuperviseWarn.do">
    <div id="optBarDiv">
        <c:choose>
            <c:when test="${kmSuperviseWarnForm.method_GET=='edit'}">
                <input type="button" value="${ lfn:message('button.update') }" onclick="Com_Submit(document.kmSuperviseWarnForm, 'update');">
            </c:when>
            <c:when test="${kmSuperviseWarnForm.method_GET=='add'}">
                <input type="button" value="${ lfn:message('button.save') }" onclick="Com_Submit(document.kmSuperviseWarnForm, 'save');">
            </c:when>
        </c:choose>
        <input type="button" value="${ lfn:message('button.close') }" onclick="Com_CloseWindow();">
    </div>
    <p class="txttitle">${ lfn:message('km-supervise:table.kmSuperviseWarn') }</p>
    <center>

        <div style="width:95%;">
            <div class="lui_paragraph_title">
                <span class="lui_icon_s lui_icon_s_icon_18"></span>${ lfn:message('km-supervise:table.kmSuperviseWarn') }
            </div>
            <table class="tb_normal" width="100%">
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('km-supervise:kmSuperviseWarn.fdKey')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdKey" _xform_type="text">
                            <xform:text property="fdKey" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('km-supervise:kmSuperviseWarn.fdFinishTime')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdFinishTime" _xform_type="text">
                            <xform:text property="fdFinishTime" showStatus="edit" style="width:95%;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('km-supervise:kmSuperviseWarn.fdNotifyPeople')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdNotifyPeople" _xform_type="radio">
                            <xform:radio property="fdNotifyPeople" showStatus="edit">
                                <xform:enumsDataSource enumsType="km_supervise_warn" />
                            </xform:radio>
                        </div>
                    </td>
                    <td class="td_normal_title" width="15%">
                        ${lfn:message('km-supervise:kmSuperviseWarn.fdNotifyType')}
                    </td>
                    <td width="35%">
                        <div id="_xform_fdNotifyType" _xform_type="text">
                            <xform:text property="fdNotifyType" showStatus="edit" style="width:95%;" />
                        </div>
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