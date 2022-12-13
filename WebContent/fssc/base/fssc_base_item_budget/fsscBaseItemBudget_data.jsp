<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseItemBudget" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>
		<list:data-column col="fdItems" title="${lfn:message('fssc-base:fsscBaseItemBudget.fdItems') }">
            <c:forEach items="${fsscBaseItemBudget.fdItems }" var="item">
            	${item.fdName};
            </c:forEach>
        </list:data-column>
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseItemBudget.fdCompany')}" escape="false">
            <c:out value="${fsscBaseItemBudget.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseItemBudget.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdOrgs" title="${lfn:message('fssc-base:fsscBaseItemBudget.fdOrgs') }">
            <c:forEach items="${fsscBaseItemBudget.fdOrgs }" var="item">
            	${item.fdName};
            </c:forEach>
        </list:data-column>
        <list:data-column col="fdCategory" title="${lfn:message('fssc-base:fsscBaseItemBudget.fdCategory') }">
            ${fsscBaseItemBudget.fdCategory.fdName }
        </list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_item_budget/fsscBaseItemBudget.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseItemBudget.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_item_budget/fsscBaseItemBudget.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseItemBudget.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
