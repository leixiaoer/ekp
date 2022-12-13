<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseAccount" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseAccount.fdName')}" />
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseAccount.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseAccount.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseAccount.fdIsAvailable}" />
        </list:data-column>
        <list:data-column property="fdBankName" title="${lfn:message('fssc-base:fsscBaseAccount.fdBankName')}" />
        <list:data-column property="fdBankAccount" title="${lfn:message('fssc-base:fsscBaseAccount.fdBankAccount')}" />
        <list:data-column col="fdPerson.name" title="${lfn:message('fssc-base:fsscBaseAccount.fdPerson')}" escape="false">
            <c:out value="${fsscBaseAccount.fdPerson.fdName}" />
        </list:data-column>
        <list:data-column col="fdPerson.id" escape="false">
            <c:out value="${fsscBaseAccount.fdPerson.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsDefault.name" title="${lfn:message('fssc-base:fsscBaseAccount.fdIsDefault')}">
            <sunbor:enumsShow value="${fsscBaseAccount.fdIsDefault}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsDefault">
            <c:out value="${fsscBaseAccount.fdIsDefault}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseAccount.docCreator')}" escape="false">
            <c:out value="${fsscBaseAccount.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseAccount.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseAccount.docCreateTime')}">
            <kmss:showDate value="${fsscBaseAccount.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_account/fsscBaseAccount.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseAccount.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_account/fsscBaseAccount.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseAccount.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
