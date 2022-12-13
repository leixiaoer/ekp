<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseCompanyGroup" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseCompanyGroup.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseCompanyGroup.fdCode')}" />
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseCompanyGroup.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseCompanyGroup.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseCompanyGroup.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseCompanyGroup.fdParent')}" escape="false">
            <c:out value="${fsscBaseCompanyGroup.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseCompanyGroup.docCreator')}" escape="false">
            <c:out value="${fsscBaseCompanyGroup.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseCompanyGroup.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseCompanyGroup.docCreateTime')}">
            <kmss:showDate value="${fsscBaseCompanyGroup.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_company_group/fsscBaseCompanyGroup.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseCompanyGroup.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_company_group/fsscBaseCompanyGroup.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseCompanyGroup.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
