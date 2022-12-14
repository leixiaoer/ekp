<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBasePayWay" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBasePayWay.fdName')}" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBasePayWay.fdCompany')}" escape="false">
            <c:out value="${fsscBasePayWay.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBasePayWay.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdAccount.name" title="${lfn:message('fssc-base:fsscBasePayWay.fdAccount')}" escape="false">
            <c:out value="${fsscBasePayWay.fdAccount.fdName}" />
        </list:data-column>
        <list:data-column col="fdAccount.id" escape="false">
            <c:out value="${fsscBasePayWay.fdAccount.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBasePayWay.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBasePayWay.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBasePayWay.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBasePayWay.docCreator')}" escape="false">
            <c:out value="${fsscBasePayWay.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBasePayWay.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBasePayWay.docCreateTime')}">
            <kmss:showDate value="${fsscBasePayWay.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--???????????? ??????-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_pay_way/fsscBasePayWay.do?method=add">
						<!-- ?????? -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBasePayWay.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_pay_way/fsscBasePayWay.do?method=deleteall">
						<!-- ?????? -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBasePayWay.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--???????????? ??????-->
		</list:data-column>
    </list:data-columns>
    <%-- ?????????????????? --%>
        <list:data-paging page="${queryPage}" />
</list:data>
