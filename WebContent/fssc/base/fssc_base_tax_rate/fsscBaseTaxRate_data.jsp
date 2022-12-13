<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseTaxRate" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseTaxRate.fdCompany')}" escape="false">
            <c:out value="${fsscBaseTaxRate.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseTaxRate.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column property="fdRate" title="${lfn:message('fssc-base:fsscBaseTaxRate.fdRate')}" />
        <list:data-column col="fdAccount.name" title="${lfn:message('fssc-base:fsscBaseTaxRate.fdAccount')}" escape="false">
            <c:out value="${fsscBaseTaxRate.fdAccount.fdName}" />
        </list:data-column>
        <list:data-column col="fdAccount.id" escape="false">
            <c:out value="${fsscBaseTaxRate.fdAccount.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseTaxRate.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseTaxRate.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseTaxRate.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseTaxRate.docCreator')}" escape="false">
            <c:out value="${fsscBaseTaxRate.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseTaxRate.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseTaxRate.docCreateTime')}">
            <kmss:showDate value="${fsscBaseTaxRate.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseTaxRate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_tax_rate/fsscBaseTaxRate.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseTaxRate.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
