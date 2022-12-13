<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseAccounts" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseAccounts.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseAccounts.fdCode')}" />
        <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseAccounts.fdParent')}" escape="false">
            <c:out value="${fsscBaseAccounts.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="fdParent.id" escape="false">
            <c:out value="${fsscBaseAccounts.fdParent.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseAccounts.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseAccounts.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseAccounts.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseAccounts.docCreator')}" escape="false">
            <c:out value="${fsscBaseAccounts.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseAccounts.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseAccounts.docCreateTime')}">
            <kmss:showDate value="${fsscBaseAccounts.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseAccounts.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_accounts/fsscBaseAccounts.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseAccounts.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
