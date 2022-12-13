<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBasePayBank" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBasePayBank.fdCompany')}" escape="false">
            <c:out value="${fsscBasePayBank.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBasePayBank.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column property="fdAccountName" title="${lfn:message('fssc-base:fsscBasePayBank.fdAccountName')}" />
        <list:data-column property="fdBankName" title="${lfn:message('fssc-base:fsscBasePayBank.fdBankName')}" />
        <list:data-column property="fdBankAccount" title="${lfn:message('fssc-base:fsscBasePayBank.fdBankAccount')}" />
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBasePayBank.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBasePayBank.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBasePayBank.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBasePayBank.docCreator')}" escape="false">
            <c:out value="${fsscBasePayBank.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBasePayBank.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBasePayBank.docCreateTime')}">
            <kmss:showDate value="${fsscBasePayBank.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_pay_bank/fsscBasePayBank.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBasePayBank.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_pay_bank/fsscBasePayBank.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBasePayBank.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
