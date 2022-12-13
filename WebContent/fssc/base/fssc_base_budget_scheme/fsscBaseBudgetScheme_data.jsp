<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseBudgetScheme" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdName')}" />
        <list:data-column col="fdDimension.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdDimension')}">
        	<c:set value="${ fn:split(fsscBaseBudgetScheme.fdDimension, ';') }" var="array"></c:set>
        	<c:forEach items="${array}" var="fdDimension" varStatus="status">
        		<c:if test="${status.index!=0}">+</c:if>
        		<sunbor:enumsShow value="${fdDimension}" enumsType="fssc_base_budget_dimension" />
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdDimension">
            <c:out value="${fsscBaseBudgetScheme.fdDimension}" />
        </list:data-column>
        <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdType')}">
            <sunbor:enumsShow value="${fsscBaseBudgetScheme.fdType}" enumsType="fssc_base_dimension_type" />
        </list:data-column>
        <list:data-column col="fdType">
            <c:out value="${fsscBaseBudgetScheme.fdType}" />
        </list:data-column>
       <%--  <list:data-column col="fdTarget.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdTarget')}">
            <sunbor:enumsShow value="${fsscBaseBudgetScheme.fdTarget}" enumsType="fssc_base_dimension_target" />
        </list:data-column>
        <list:data-column col="fdTarget">
            <c:out value="${fsscBaseBudgetScheme.fdTarget}" />
        </list:data-column> --%>
        <list:data-column col="fdPeriod.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdPeriod')}">
            <c:set value="${ fn:split(fsscBaseBudgetScheme.fdPeriod, ';') }" var="array"></c:set>
        	<c:forEach items="${array}" var="fdPeriod" varStatus="status">
        		<c:if test="${status.index!=0}">;</c:if>
        		<sunbor:enumsShow value="${fdPeriod}" enumsType="fssc_base_budget_period" />
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdPeriod">
            <c:out value="${fsscBaseBudgetScheme.fdPeriod}" />
        </list:data-column>
        <list:data-column col="fdCode" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdCode')}">
            <c:out value="${fsscBaseBudgetScheme.fdCode}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseBudgetScheme.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseBudgetScheme.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.docCreator')}" escape="false">
            <c:out value="${fsscBaseBudgetScheme.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseBudgetScheme.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseBudgetScheme.docCreateTime')}">
            <kmss:showDate value="${fsscBaseBudgetScheme.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_budget_scheme/fsscBaseBudgetScheme.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseBudgetScheme.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_budget_scheme/fsscBaseBudgetScheme.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseBudgetScheme.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
