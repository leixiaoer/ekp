<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseSupplier" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseSupplier.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseSupplier.fdCode')}" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseSupplier.fdCompany')}" escape="false">
            <c:out value="${fsscBaseSupplier.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseSupplier.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseSupplier.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseSupplier.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseSupplier.fdIsAvailable}" />
        </list:data-column>
        <list:data-column property="fdTaxNo" title="${lfn:message('fssc-base:fsscBaseSupplier.fdTaxNo')}" />
        <list:data-column property="fdErpNo" title="${lfn:message('fssc-base:fsscBaseSupplier.fdErpNo')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseSupplier.docCreator')}" escape="false">
            <c:out value="${fsscBaseSupplier.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseSupplier.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseSupplier.docCreateTime')}">
            <kmss:showDate value="${fsscBaseSupplier.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--???????????? ??????-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_supplier/fsscBaseSupplier.do?method=add">
						<!-- ?????? -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseSupplier.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_supplier/fsscBaseSupplier.do?method=deleteall">
						<!-- ?????? -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseSupplier.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--???????????? ??????-->
		</list:data-column>
    </list:data-columns>
    <%-- ?????????????????? --%>
        <list:data-paging page="${queryPage}" />
</list:data>
