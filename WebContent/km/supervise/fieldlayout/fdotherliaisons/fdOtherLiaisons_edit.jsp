<%-- 拟部门 --%>
<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
<%
	parse.addStyle("width", "control_width", "95%"); 
%>
<div id="_fdOtherLiaisons" valField="fdOtherLiaisonIds" xform_type="address">
 <xform:address 
        propertyId="fdOtherLiaisonIds"
        propertyName="fdOtherLiaisonNames"
        orgType="ORG_TYPE_PERSON"
        required="<%=required%>" 
        mulSelect="true"
        mobile="${param.mobile eq 'true'? 'true':'false'}"
        style="<%=parse.getStyle()%>"
        className="inputsgl"
        htmlElementProperties="id=_fdOtherLiaisonIds">
</xform:address>
</div>