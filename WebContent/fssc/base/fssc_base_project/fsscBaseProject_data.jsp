<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseProject" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseProject.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseProject.fdCode')}" />
        <list:data-column col="fdParent.name" title="${lfn:message('fssc-base:fsscBaseProject.fdParent')}" escape="false">
            <c:out value="${fsscBaseProject.fdParent.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseProject.fdCompany')}" escape="false">
            <c:out value="${fsscBaseProject.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseProject.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseProject.fdType')}">
            <sunbor:enumsShow value="${fsscBaseProject.fdType}" enumsType="fssc_base_project_type" />
        </list:data-column>
        <list:data-column col="fdType">
            <c:out value="${fsscBaseProject.fdType}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseProject.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseProject.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseProject.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseProject.docCreator')}" escape="false">
            <c:out value="${fsscBaseProject.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseProject.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseProject.docCreateTime')}">
            <kmss:showDate value="${fsscBaseProject.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--???????????? ??????-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_project/fsscBaseProject.do?method=add">
						<!-- ?????? -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseProject.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_project/fsscBaseProject.do?method=deleteall">
						<!-- ?????? -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseProject.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--???????????? ??????-->
		</list:data-column>
    </list:data-columns>
    <%-- ?????????????????? --%>
        <list:data-paging page="${queryPage}" />
</list:data>
