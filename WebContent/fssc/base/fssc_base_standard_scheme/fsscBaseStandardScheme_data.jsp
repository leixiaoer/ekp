<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseStandardScheme" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseStandardScheme.fdName')}" />
        <list:data-column col="fdDimension.name" title="${lfn:message('fssc-base:fsscBaseStandardScheme.fdDimension')}">
        	<c:set value="${ fn:split(fsscBaseStandardScheme.fdDimension, ';') }" var="array"></c:set>
        	<c:forEach items="${array}" var="fdDimension" varStatus="status">
        		<c:if test="${status.index!=0}">+</c:if>
        		<sunbor:enumsShow value="${fdDimension}" enumsType="fssc_base_standard_dimension" />
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdDimension">
            <c:out value="${fsscBaseStandardScheme.fdDimension}" />
        </list:data-column>
        <list:data-column col="fdItems.name" title="${lfn:message('fssc-base:fsscBaseStandardScheme.fdItems')}" escape="false">
           <c:forEach items="${fsscBaseStandardScheme.fdItems}" var="fdItem" varStatus="status">
        		<c:if test="${status.index!=0}">;</c:if>
        		<c:out value="${fdItem.fdName}"></c:out>
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseStandardScheme.fdType')}">
            <sunbor:enumsShow value="${fsscBaseStandardScheme.fdType}" enumsType="fssc_base_standard_type" />
        </list:data-column>
        <list:data-column col="fdType">
            <c:out value="${fsscBaseStandardScheme.fdType}" />
        </list:data-column>
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseStandardScheme.fdCompany')}" escape="false">
            <c:out value="${fsscBaseStandardScheme.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseStandardScheme.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseStandardScheme.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseStandardScheme.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseStandardScheme.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseStandardScheme.docCreator')}" escape="false">
            <c:out value="${fsscBaseStandardScheme.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseStandardScheme.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseStandardScheme.docCreateTime')}">
            <kmss:showDate value="${fsscBaseStandardScheme.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_standard_scheme/fsscBaseStandardScheme.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseStandardScheme.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_standard_scheme/fsscBaseStandardScheme.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseStandardScheme.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
