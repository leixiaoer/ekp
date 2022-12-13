<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseInputTax" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseInputTax.fdCompany')}" escape="false">
            <c:out value="${fsscBaseInputTax.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseInputTax.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdItem.name" title="${lfn:message('fssc-base:fsscBaseInputTax.fdItem')}" escape="false">
            <c:out value="${fsscBaseInputTax.fdItem.fdName}" />
        </list:data-column>
        <list:data-column col="fdItem.id" escape="false">
            <c:out value="${fsscBaseInputTax.fdItem.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsInputTax.name" title="${lfn:message('fssc-base:fsscBaseInputTax.fdIsInputTax')}">
            <sunbor:enumsShow value="${fsscBaseInputTax.fdIsInputTax}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsInputTax">
            <c:out value="${fsscBaseInputTax.fdIsInputTax}" />
        </list:data-column>
        <list:data-column property="fdTaxRate" title="${lfn:message('fssc-base:fsscBaseInputTax.fdTaxRate')}" />
        <list:data-column col="fdAccount.name" title="${lfn:message('fssc-base:fsscBaseInputTax.fdAccount')}" escape="false">
            <c:out value="${fsscBaseInputTax.fdAccount.fdName}" />
        </list:data-column>
        <list:data-column col="fdAccount.id" escape="false">
            <c:out value="${fsscBaseInputTax.fdAccount.fdId}" />
        </list:data-column>
        <list:data-column col="docAlterTime" title="${lfn:message('fssc-base:fsscBaseInputTax.docAlterTime')}">
            <kmss:showDate value="${fsscBaseInputTax.docAlterTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_input_tax/fsscBaseInputTax.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseInputTax.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_input_tax/fsscBaseInputTax.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseInputTax.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
    <list:data-paging page="${queryPage}" />
</list:data>
