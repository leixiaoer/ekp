<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseItemAccount" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseItemAccount.fdCompany')}" escape="false">
            <c:out value="${fsscBaseItemAccount.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseItemAccount.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdExpenseItem.name" title="${lfn:message('fssc-base:fsscBaseItemAccount.fdExpenseItem')}" escape="false">
            <c:out value="${fsscBaseItemAccount.fdExpenseItem.fdName}" />
        </list:data-column>
        <list:data-column col="fdExpenseItem.id" escape="false">
            <c:out value="${fsscBaseItemAccount.fdExpenseItem.fdId}" />
        </list:data-column>
        <list:data-column col="fdAmortize.name" title="${lfn:message('fssc-base:fsscBaseItemAccount.fdAmortize')}" escape="false">
            <c:out value="${fsscBaseItemAccount.fdAmortize.fdName}" />
        </list:data-column>
        <list:data-column col="fdAmortize.id" escape="false">
            <c:out value="${fsscBaseItemAccount.fdAmortize.fdId}" />
        </list:data-column>
        <list:data-column col="fdAccruals.name" title="${lfn:message('fssc-base:fsscBaseItemAccount.fdAccruals')}" escape="false">
            <c:out value="${fsscBaseItemAccount.fdAccruals.fdName}" />
        </list:data-column>
        <list:data-column col="fdAccruals.id" escape="false">
            <c:out value="${fsscBaseItemAccount.fdAccruals.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseItemAccount.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseItemAccount.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseItemAccount.fdIsAvailable}" />
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_item_account/fsscBaseItemAccount.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseItemAccount.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_item_account/fsscBaseItemAccount.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseItemAccount.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
