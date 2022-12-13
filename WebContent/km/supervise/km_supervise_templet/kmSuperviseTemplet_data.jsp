<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseTemplet" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column  property="fdName" title="${lfn:message('km-supervise:kmSuperviseTemplet.fdName')}" />
        <list:data-column headerClass="width30" property="fdOrder" title="${lfn:message('km-supervise:kmSuperviseTemplet.fdOrder')}" />
        <list:data-column col="fdIsAvailable" title="${lfn:message('km-supervise:kmSuperviseTemplet.fdIsAvailable')}">
            <sunbor:enumsShow value="${kmSuperviseTemplet.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('km-supervise:kmSuperviseTemplet.docCreator')}" escape="false">
            <c:out value="${kmSuperviseTemplet.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${kmSuperviseTemplet.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('km-supervise:kmSuperviseTemplet.docCreateTime')}">
            <kmss:showDate value="${kmSuperviseTemplet.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <!-- 其它操作 -->
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<!-- 编辑 -->
					<a class="btn_txt" href="javascript:edit('${kmSuperviseTemplet.fdId}')">${lfn:message('button.edit')}</a>
					<!-- 删除 -->
					<a class="btn_txt" href="javascript:deleteTemplet('${kmSuperviseTemplet.fdId}')">${lfn:message('button.delete')}</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
