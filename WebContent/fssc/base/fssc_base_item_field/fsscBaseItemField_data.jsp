<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseItemField" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseItemField.fdCompany')}" escape="false">
            <c:out value="${fsscBaseItemField.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseItemField.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdItems.name" title="${lfn:message('fssc-base:fsscBaseItemField.fdItems')}" escape="false">
           <c:forEach items="${fsscBaseItemField.fdItems}" var="fdItem" varStatus="status">
        		<c:if test="${status.index!=0}">;</c:if>
        		<c:out value="${fdItem.fdName}"></c:out>
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdFields.name" title="${lfn:message('fssc-base:fsscBaseItemField.fdFields')}">
            <c:set value="${ fn:split(fsscBaseItemField.fdFields, ';') }" var="array"></c:set>
        	<c:forEach items="${array}" var="fdField" varStatus="status">
        		<c:if test="${status.index!=0}">;</c:if>
        		<sunbor:enumsShow value="${fdField}" enumsType="fssc_base_item_field" />
        	</c:forEach>
        </list:data-column>
        <list:data-column col="fdFields">
            <c:out value="${fsscBaseItemField.fdFields}" />
        </list:data-column>
        <list:data-column property="fdFieldOne" title="${lfn:message('fssc-base:fsscBaseItemField.fdFieldOne')}" />
        <list:data-column property="fdFieldTwo" title="${lfn:message('fssc-base:fsscBaseItemField.fdFieldTwo')}" />
        <list:data-column property="fdFiledThree" title="${lfn:message('fssc-base:fsscBaseItemField.fdFiledThree')}" />
        <list:data-column property="fdFieldFour" title="${lfn:message('fssc-base:fsscBaseItemField.fdFieldFour')}" />
        <list:data-column property="fdFieldFive" title="${lfn:message('fssc-base:fsscBaseItemField.fdFieldFive')}" />
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_item_field/fsscBaseItemField.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseItemField.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_item_field/fsscBaseItemField.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseItemField.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
