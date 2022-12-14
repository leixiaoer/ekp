<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseLevel" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseLevel.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseLevel.fdCode')}" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseLevel.fdCompany')}" escape="false">
            <c:out value="${fsscBaseLevel.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseLevel.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseLevel.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseLevel.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseLevel.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseLevel.docCreator')}" escape="false">
            <c:out value="${fsscBaseLevel.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseLevel.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseLevel.docCreateTime')}">
            <kmss:showDate value="${fsscBaseLevel.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--???????????? ??????-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_level/fsscBaseLevel.do?method=add">
						<!-- ?????? -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseLevel.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_level/fsscBaseLevel.do?method=deleteall">
						<!-- ?????? -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseLevel.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--???????????? ??????-->
		</list:data-column>
    </list:data-columns>
    <%-- ?????????????????? --%>
        <list:data-paging page="${queryPage}" />
</list:data>
