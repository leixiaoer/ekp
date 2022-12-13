<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseExchangeRate" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column> 

        <list:data-column col="fdSourceCurrency.name" title="${lfn:message('fssc-base:fsscBaseExchangeRate.fdSourceCurrency')}" escape="false">
            <c:out value="${fsscBaseExchangeRate.fdSourceCurrency.fdName}" />
        </list:data-column>
        <list:data-column col="fdSourceCurrency.id" escape="false">
            <c:out value="${fsscBaseExchangeRate.fdSourceCurrency.fdId}" />
        </list:data-column>
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseExchangeRate.fdCompany')}" escape="false">
            <c:out value="${fsscBaseExchangeRate.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseExchangeRate.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdTargetCurrency.name" title="${lfn:message('fssc-base:fsscBaseExchangeRate.fdTargetCurrency')}" escape="false">
            <c:out value="${fsscBaseExchangeRate.fdTargetCurrency.fdName}" />
        </list:data-column>
        <list:data-column col="fdTargetCurrency.id" escape="false">
            <c:out value="${fsscBaseExchangeRate.fdTargetCurrency.fdId}" />
        </list:data-column>
        <list:data-column col="fdRate" title="${lfn:message('fssc-base:fsscBaseExchangeRate.fdRate')}" >
        	<%-- <kmss:showNumber value="${fsscBaseExchangeRate.fdRate }" pattern="0.0#####"></kmss:showNumber> --%>
        	<c:out value="${fsscBaseExchangeRate.fdRateStr}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseExchangeRate.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseExchangeRate.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <fssc:switchOn property="fdRateEnabled">
        <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseExchangeRate.fdType')}">
            <sunbor:enumsShow value="${fsscBaseExchangeRate.fdType}" enumsType="fssc_base_exchange_rate_type" />
        </list:data-column>
        </fssc:switchOn>
        <list:data-column col="fdType">
            <c:out value="${fsscBaseExchangeRate.fdType}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseExchangeRate.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseExchangeRate.docCreator')}" escape="false">
            <c:out value="${fsscBaseExchangeRate.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseExchangeRate.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseExchangeRate.docCreateTime')}">
            <kmss:showDate value="${fsscBaseExchangeRate.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_exchange_rate/fsscBaseExchangeRate.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseExchangeRate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_exchange_rate/fsscBaseExchangeRate.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseExchangeRate.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
