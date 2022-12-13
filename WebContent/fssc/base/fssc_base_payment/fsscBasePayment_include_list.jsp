<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<ui:content title="${lfn:message('fssc-base:message.include.payment.title') }">
	<ui:fixed elem=".lui_list_operation" />
    <!-- 列表 -->
    <list:listview id="listview">
        <ui:source type="AjaxJson">
            {url:'/fssc/base/fssc_base_payment/fsscBasePayment.do?method=data&fdModelId=${param.fdModelId }&fdModelName=${param.fdModelName }'}
        </ui:source>
        <!-- 列表视图 -->
        <list:colTable isDefault="false" rowHref="/fssc/base/fssc_base_payment/fsscBasePayment.do?method=view&fdId=!{fdId}" name="columntable">
            <list:col-serial/>
            <list:col-auto props="fdSubject;fdModelNumber;fdPaymentMoney;fdPaymentTime;fdStatus.name" /></list:colTable>
    </list:listview>
    <!-- 翻页 -->
    <list:paging />
</ui:content>