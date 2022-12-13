<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
<script>
    seajs.use(['theme!form']);
	Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js|dialog.js", null, "js");
</script>
	<html:form action="/geesun/base/geesun_base_pay/geesunBasePay.do">
	<div style="text-align: right;padding-right: 20px;">
	    <ui:button text="${ lfn:message('button.submit') }" order="1"  onclick="Com_Submit(document.geesunBasePayForm, 'save');">
		</ui:button>
		<ui:button text="${ lfn:message('button.close') }" order="2"  onclick="Com_CloseWindow()">
		</ui:button>
	</div>

	<p class="txttitle">${lfn:message('geesun-base:table.geesunBasePay')}</p>

	<center>
	<table class="tb_normal" width=95%>
		<tr>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdYwDate')}
            </td>
            <td width="35%">
                <%-- 业务日期--%>
                <div id="_xform_fdYwDate" _xform_type="datetime">
                    <xform:datetime property="fdYwDate" showStatus="edit" dateTimeType="date" style="width:95%;" />
                </div>
            </td>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdPayDate')}
            </td>
            <td width="35%">
                <%-- 付款日期--%>
                <div id="_xform_fdPayDate" _xform_type="datetime">
                    <xform:datetime property="fdPayDate" showStatus="edit" dateTimeType="date" style="width:95%;" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdPeriod')}
            </td>
            <td colspan="3">
                <%-- 期间--%>
                <kmss:period property="fdPeriod" periodTypeValue="1"/>
               <%--  <div id="_xform_fdPeriod" _xform_type="text">
                    <xform:text property="fdPeriod" showStatus="edit" style="width:95%;" />
                </div> --%>
            </td>
        </tr>
        <tr>
        	<td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdPayBank1')}
            </td>
            <td colspan="3">
                <%-- 付款银行--%>
                <html:hidden property="fdPayBank2" />
                <html:hidden property="fdPayBank1" value="43"/>
                <xform:text property="fdPayBank3" style="width:90%;" value="1002.28  中国银行深圳新沙支行172566" showStatus="readOnly"/>
                <a href="javascript:void(0);" onclick="selectPayBank();"><bean:message key="dialog.selectOther"/></a>
            </td>
            <%-- <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdPayBank2')}
            </td>
            <td width="35%">
                付款银行科目
                <div id="_xform_fdPayBank2" _xform_type="text">
                    <xform:text property="fdPayBank2" showStatus="edit" style="width:95%;" />
                </div>
            </td>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdPayBank3')}
            </td>
            <td width="35%">
                付款银行名称
                <div id="_xform_fdPayBank3" _xform_type="text">
                    <xform:text property="fdPayBank3" showStatus="edit" style="width:95%;" />
                </div>
            </td> --%>
        </tr>
        <tr>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdAccount')}
            </td>
            <td colspan="3">
                <%-- 科目代码--%>
                <html:hidden property="fdAccountCode" />
                <xform:text property="fdAccountName" style="width:90%;" showStatus="readOnly"/>
                <a href="javascript:void(0);" onclick="selectTAccount();"><bean:message key="dialog.selectOther"/></a>
                <%-- <xform:select property="fdAccountCode" htmlElementProperties="id='fdAccountCode'" showStatus="edit" required="true">
                	<xform:SQLDataSource sql="select FAccountID,FName from t_Account where FDelete=0 order by FNumber" dbConnect="项目库"/>
                </xform:select> --%>
            </td>
            <%-- <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdAccountName')}
            </td>
            <td width="35%">
                科目名称
                <div id="_xform_fdAccountName" _xform_type="text">
                    <xform:text property="fdAccountName" showStatus="edit" style="width:95%;" />
                </div>
            </td> --%>
        </tr>
        <tr>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdDemo')}
            </td>
            <td colspan="3" width="85.0%">
                <%-- 摘要--%>
                <div id="_xform_fdDemo" _xform_type="textarea">
                	<xform:textarea property="fdDemo" showStatus="edit" style="width:95%;"/>
                </div>
            </td>
        </tr>
        <tr>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdPayMoney')}
            </td>
            <td width="35%">
                <%-- 付款金额--%>
                <div id="_xform_fdPayMoney" _xform_type="text">
                    <xform:text property="fdPayMoney" showStatus="edit" validators=" number min(0)" style="width:95%;"/>
                </div>
            </td>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.fdRemark')}
            </td>
            <td width="35%">
                <%-- 备注--%>
                <div id="_xform_fdRemark" _xform_type="text">
                    <xform:text property="fdRemark" showStatus="edit" style="width:95%;"/>
                </div>
            </td>
        </tr>
        <tr>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.docCreator')}
            </td>
            <td width="35%">
                <%-- 创建人--%>
                <div id="_xform_docCreatorId" _xform_type="address">
                    <ui:person personId="${geesunBasePayForm.docCreatorId}" personName="${geesunBasePayForm.docCreatorName}" />
                </div>
            </td>
            <td class="td_normal_title" width="15%">
                ${lfn:message('geesun-base:geesunBasePay.docCreateTime')}
            </td>
            <td width="35%">
                <%-- 创建时间--%>
                <div id="_xform_docCreateTime" _xform_type="datetime">
                    <xform:datetime property="docCreateTime" showStatus="view" dateTimeType="datetime" style="width:95%;" />
                </div>
            </td>
        </tr>
	</table>
	</center>
	<html:hidden property="fdId" />
	<html:hidden property="fdReviewId" />
	<html:hidden property="method_GET" />
</html:form>
<script language="JavaScript">
			$KMSSValidation(document.forms['geesunBasePayForm']);
			function selectPayBank() {
				Dialog_List(false, 'fdPayBank1', 'fdPayBank3', ';', 'geesunBasePayService', null, 'geesunBasePayService&keyword=!{keyword}');
			}
			function selectTAccount() {
				Dialog_List(false, 'fdAccountCode', 'fdAccountName', ';', 'geesunBasePayService&flag=getTAccount', null, 'geesunBasePayService&flag=getTAccount&keyword=!{keyword}');
			}
</script>
	</template:replace>
</template:include>
