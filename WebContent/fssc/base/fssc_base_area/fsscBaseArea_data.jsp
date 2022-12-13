<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseArea" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column property="fdArea" title="${lfn:message('fssc-base:fsscBaseArea.fdArea')}" />
        <list:data-column col="fdType.name" title="${lfn:message('fssc-base:fsscBaseArea.fdType')}">
            <sunbor:enumsShow value="${fsscBaseArea.fdType}" enumsType="fssc_base_area_type" />
        </list:data-column>
        <list:data-column col="fdType">
            <c:out value="${fsscBaseArea.fdType}" />
        </list:data-column>
        <list:data-column property="fdCity" title="${lfn:message('fssc-base:fsscBaseArea.fdCity')}" />
        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseArea.fdCompany')}" escape="false">
            <c:out value="${fsscBaseArea.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseArea.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseArea.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseArea.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseArea.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseArea.docCreator')}" escape="false">
            <c:out value="${fsscBaseArea.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseArea.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseArea.docCreateTime')}">
            <kmss:showDate value="${fsscBaseArea.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_area/fsscBaseArea.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseArea.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_area/fsscBaseArea.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseArea.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
