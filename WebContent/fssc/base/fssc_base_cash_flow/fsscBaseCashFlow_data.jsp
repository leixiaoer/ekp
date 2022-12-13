<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseCashFlow" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseCashFlow.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseCashFlow.fdCode')}" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseCashFlow.fdCompany')}" escape="false">
            <c:out value="${fsscBaseCashFlow.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseCashFlow.fdCompany.fdId}" />
        </list:data-column>
         <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseCashFlow.fdParent')}" escape="false">
            <c:out value="${fsscBaseCashFlow.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseCashFlow.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseCashFlow.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseCashFlow.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseCashFlow.docCreator')}" escape="false">
            <c:out value="${fsscBaseCashFlow.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseCashFlow.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseCashFlow.docCreateTime')}">
            <kmss:showDate value="${fsscBaseCashFlow.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_cash_flow/fsscBaseCashFlow.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseCashFlow.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_cash_flow/fsscBaseCashFlow.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseCashFlow.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
