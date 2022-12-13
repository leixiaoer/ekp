<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseStandard" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

		<list:data-column col="fdPerson.name" title="${lfn:message('fssc-base:fsscBaseStandard.fdPerson')}" escape="false">
            <c:out value="${fsscBaseStandard.fdPerson.fdName}" />
        </list:data-column>
        <list:data-column col="fdPerson.id" escape="false">
            <c:out value="${fsscBaseStandard.fdPerson.fdId}" />
        </list:data-column>
        <list:data-column col="fdLevel.name" title="${lfn:message('fssc-base:fsscBaseStandard.fdLevel')}" escape="false">
            <c:out value="${fsscBaseStandard.fdLevel.fdName}" />
        </list:data-column>
        <list:data-column col="fdLevel.id" escape="false">
            <c:out value="${fsscBaseStandard.fdLevel.fdId}" />
        </list:data-column>
        <list:data-column col="fdArea.name" title="${lfn:message('fssc-base:fsscBaseStandard.fdArea')}" escape="false">
            <c:out value="${fsscBaseStandard.fdArea.fdArea}" />
        </list:data-column>
        <list:data-column col="fdArea.id" escape="false">
            <c:out value="${fsscBaseStandard.fdArea.fdId}" />
        </list:data-column>
        <list:data-column col="fdVehicle.name" title="${lfn:message('fssc-base:fsscBaseStandard.fdVehicle')}" escape="false">
            <c:out value="${fsscBaseStandard.fdVehicle.fdName}" />
        </list:data-column>
        <list:data-column col="fdVehicle.id" escape="false">
            <c:out value="${fsscBaseStandard.fdVehicle.fdId}" />
        </list:data-column>
        <list:data-column col="fdBerth.name" title="${lfn:message('fssc-base:fsscBaseStandard.fdBerth')}" escape="false">
            <c:out value="${fsscBaseStandard.fdBerth.fdName}" />
        </list:data-column>
        <list:data-column col="fdBerth.id" escape="false">
            <c:out value="${fsscBaseStandard.fdBerth.fdId}" />
        </list:data-column>
        <list:data-column col="fdItem.name" title="${lfn:message('fssc-base:fsscBaseStandard.fdItem')}" escape="false">
            <c:out value="${fsscBaseStandard.fdItem.fdName}" />
        </list:data-column>
        <list:data-column col="fdItem.id" escape="false">
            <c:out value="${fsscBaseStandard.fdItem.fdId}" />
        </list:data-column>
        <list:data-column property="fdMoney" title="${lfn:message('fssc-base:fsscBaseStandard.fdMoney')}" />
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseStandard.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseStandard.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseStandard.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseStandard.docCreator')}" escape="false">
            <c:out value="${fsscBaseStandard.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseStandard.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseStandard.docCreateTime')}">
            <kmss:showDate value="${fsscBaseStandard.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_standard/fsscBaseStandard.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseStandard.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_standard/fsscBaseStandard.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseStandard.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
