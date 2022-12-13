<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<script type="text/javascript" src="${KMSS_Parameter_ResPath}js/util.js"></script>
<script type="text/javascript" src="${KMSS_Parameter_ResPath}js/jquery.js"></script>
<script>
//提交
function sysFtsearchConfig_Com_Submit(){
	var num = $("input[name=clearSpan]").val();
	valid = true;
	if($.isNumeric(num)) {
		num = parseInt(num);
		if(num <= 0 ) {
			valid = false;
		}
	} else {
		valid = false;
	}
	if(!valid){
		alert("<bean:message key='sys_ftsearch_config_clear_search_log_clear_valid' bundle='sys-ftsearch-expand'/>");
		return false;
	}else{
    	Com_Submit(document.sysFtsearchConfigExpandForm, 'update');
    	return true; 
	}
}
</script>

<html:form action="/sys/ftsearch/expand/sys_ftsearch_config/sysFtsearchConfig.do">
<div id="optBarDiv">
        <input type=button value="<bean:message key="button.update"/>"
            onclick="return sysFtsearchConfig_Com_Submit();">
</div>
<p class="txttitle"><bean:message bundle="sys-ftsearch-expand" key="sys_ftsearch_config_switch"/></p>
<center>
<table class="tb_normal" width=95%> 
    <tr>
        <td class="td_normal_title" width=20%>
            <bean:message  bundle="sys-ftsearch-expand" key="sys_ftsearch_config_text_phrase_config"/>
        </td>
        <td colspan=3>
        	<xform:radio property="textPhraseOpen">
				<xform:enumsDataSource enumsType="common_yesno_number" />
			</xform:radio>
        </td>
    </tr>
    <tr>
        <td class="td_normal_title" width=20%>
            <bean:message  bundle="sys-ftsearch-expand" key="sys_ftsearch_config_auto_complete_config"/>
        </td>
        <td colspan=3>
        	<xform:radio property="autoCompleteOpen">
				<xform:enumsDataSource enumsType="common_yesno_number" />
			</xform:radio>
        </td>
    </tr>
    <tr>
        <td class="td_normal_title" width=20%>
            <bean:message  bundle="sys-ftsearch-expand" key="sys_ftsearch_config_clear_search_log_clear"/>
        </td>
        <td colspan=3>
        	<xform:text property="clearSpan" style="width:50px"/>
            <bean:message  bundle="sys-ftsearch-expand" key="sys_ftsearch_config_clear_search_log_clear_unit"/>
        	<xform:select property="clearSpanUnit" showPleaseSelect="false">
				<xform:enumsDataSource enumsType="ftsearch_clear_time_span" />
			</xform:select>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<bean:message  bundle="sys-ftsearch-expand" key="sys_ftsearch_config_clear_search_log_clear_default"/>
        </td>
    </tr>
    <tr>
        <td class="td_normal_title" width=20%>
            <bean:message  bundle="sys-ftsearch-expand" key="sys_ftsearch_config_sum_search_field_score"/>
        </td>
        <td colspan=3>
        	<xform:radio property="sumSearchFieldScore">
				<xform:enumsDataSource enumsType="common_yesno_number" />
			</xform:radio>
        </td>
    </tr>
</table>
</center> 

<%@ include file="/resource/jsp/view_down.jsp"%>
</html:form>

