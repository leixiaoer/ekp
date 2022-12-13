<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseCostCenter" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseCostCenter.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseCostCenter.fdCode')}" />
        <list:data-column col="fdIsGroup.name" title="${lfn:message('fssc-base:fsscBaseCostCenter.fdIsGroup')}">
            <sunbor:enumsShow value="${fsscBaseCostCenter.fdIsGroup}" enumsType="fssc_base_cost_type" />
        </list:data-column>
        <list:data-column col="fdIsGroup">
            <c:out value="${fsscBaseCostCenter.fdIsGroup}" />
        </list:data-column>
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseCostCenter.fdCompany')}" escape="false">
            <c:out value="${fsscBaseCostCenter.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseCostCenter.fdCompany.fdId}" />
        </list:data-column>
        <%-- <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseCostCenter.fdType')}" escape="false">
            <c:out value="${fsscBaseCostCenter.fdType.fdName}" />
        </list:data-column>
        <list:data-column col="fdType.id" escape="false">
            <c:out value="${fsscBaseCostCenter.fdType.fdId}" />
        </list:data-column> --%>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseCostCenter.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseCostCenter.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseCostCenter.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseCostCenter.docCreator')}" escape="false">
            <c:out value="${fsscBaseCostCenter.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseCostCenter.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseCostCenter.docCreateTime')}">
            <kmss:showDate value="${fsscBaseCostCenter.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_cost_center/fsscBaseCostCenter.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseCostCenter.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_cost_center/fsscBaseCostCenter.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseCostCenter.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
