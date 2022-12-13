<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseLevel" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdOrder" title="${lfn:message('km-supervise:kmSuperviseLevel.fdOrder')}" />
        <list:data-column property="fdName" title="${lfn:message('km-supervise:kmSuperviseLevel.fdName')}" />
        <list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-supervise:kmSuperviseLevel.fdIsAvailable') }" escape="false">
		    <c:if test="${kmSuperviseLevel.fdIsAvailable}">
				<bean:message bundle="km-supervise" key="kmSuperviseLevel.fdIsAvailable.yes" />
			</c:if>
			<c:if test="${!kmSuperviseLevel.fdIsAvailable}">
				<bean:message bundle="km-supervise" key="kmSuperviseLevel.fdIsAvailable.no" />
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width80" property="docCreator.fdName" title="${ lfn:message('km-supervise:kmSuperviseLevel.docCreator') }">
		</list:data-column>
		<list:data-column headerClass="width120" property="docCreateTime" title="${ lfn:message('km-supervise:kmSuperviseLevel.docCreateTime') }">
		</list:data-column>
		<!-- 其它操作 -->
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<!-- 编辑 -->
					<a class="btn_txt" href="javascript:edit('${kmSuperviseLevel.fdId}')">${lfn:message('button.edit')}</a>
					<!-- 删除 -->
					<a class="btn_txt" href="javascript:deleteLevel('${kmSuperviseLevel.fdId}')">${lfn:message('button.delete')}</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
