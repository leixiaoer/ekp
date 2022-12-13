<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseAccountsCom" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdCode')}" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdCompany')}" escape="false">
            <c:out value="${fsscBaseAccountsCom.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseAccountsCom.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdParent')}" escape="false">
            <c:out value="${fsscBaseAccountsCom.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="fdParent.id" escape="false">
            <c:out value="${fsscBaseAccountsCom.fdParent.fdId}" />
        </list:data-column>
        <list:data-column col="fdCostItem.name" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdCostItem')}">
            <c:set value="${ fn:split(fsscBaseAccountsCom.fdCostItem, ';') }" var="array"></c:set>
        	<c:forEach items="${array}" var="fdCostItem" varStatus="status">
        		<c:if test="${status.index!=0}">;</c:if>
        		<sunbor:enumsShow value="${fdCostItem}" enumsType="fssc_base_cost_item" />
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdCostItem">
            <c:out value="${fsscBaseAccountsCom.fdCostItem}" />
        </list:data-column>
        <list:data-column col="fdStatus.name" title="${lfn:message('fssc-base:fsscBaseAccountsCom.fdStatus')}">
            <sunbor:enumsShow value="${fsscBaseAccountsCom.fdStatus}" enumsType="fssc_base_doc_status" />
        </list:data-column>
        <list:data-column col="fdStatus">
            <c:out value="${fsscBaseAccountsCom.fdStatus}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseAccountsCom.docCreator')}" escape="false">
            <c:out value="${fsscBaseAccountsCom.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseAccountsCom.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseAccountsCom.docCreateTime')}">
            <kmss:showDate value="${fsscBaseAccountsCom.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_accounts_com/fsscBaseAccountsCom.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseAccountsCom.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
