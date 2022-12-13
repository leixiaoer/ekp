<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseVehicle" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="fdCompany.name" title="${lfn:message('fssc-base:fsscBaseVehicle.fdCompany')}" escape="false">
            <c:out value="${fsscBaseVehicle.fdCompany.fdName}" />
        </list:data-column>
        <list:data-column col="fdCompany.id" escape="false">
            <c:out value="${fsscBaseVehicle.fdCompany.fdId}" />
        </list:data-column>
        <list:data-column property="fdName" title="${lfn:message('fssc-base:fsscBaseVehicle.fdName')}" />
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseVehicle.fdCode')}" />
        <list:data-column col="fdLevel.name" title="${lfn:message('fssc-base:fsscBaseVehicle.fdLevel')}">
            <sunbor:enumsShow value="${fsscBaseVehicle.fdLevel}" enumsType="fssc_base_berth_level" />
        </list:data-column>
        <list:data-column col="fdLevel">
            <c:out value="${fsscBaseVehicle.fdLevel}" />
        </list:data-column>
        <list:data-column col="fdIsAvailable.name" title="${lfn:message('fssc-base:fsscBaseVehicle.fdIsAvailable')}">
            <sunbor:enumsShow value="${fsscBaseVehicle.fdIsAvailable}" enumsType="common_yesno" />
        </list:data-column>
        <list:data-column col="fdIsAvailable">
            <c:out value="${fsscBaseVehicle.fdIsAvailable}" />
        </list:data-column>
        <list:data-column col="docCreator.name" title="${lfn:message('fssc-base:fsscBaseVehicle.docCreator')}" escape="false">
            <c:out value="${fsscBaseVehicle.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${fsscBaseVehicle.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseVehicle.docCreateTime')}">
            <kmss:showDate value="${fsscBaseVehicle.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_vehicle/fsscBaseVehicle.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseVehicle.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_vehicle/fsscBaseVehicle.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseVehicle.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
