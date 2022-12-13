<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="fsscBaseSpecialItem" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdDescription" title="${lfn:message('fssc-base:fsscBaseSpecialItem.fdDescription') }"/>
        <list:data-column property="fdCode" title="${lfn:message('fssc-base:fsscBaseSpecialItem.fdCode') }"/>
        <list:data-column col="fdCompany" title="${lfn:message('fssc-base:fsscBaseSpecialItem.fdCompany') }">
        	${fsscBaseSpecialItem.fdCompany.fdName}
        </list:data-column>
        <list:data-column col="docCreator" title="${lfn:message('fssc-base:fsscBaseSpecialItem.docCreator') }">
        	${fsscBaseSpecialItem.docCreator.fdName}
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('fssc-base:fsscBaseSpecialItem.docCreateTime') }">
        	${fsscBaseSpecialItem.docCreateTime}
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/fssc/base/fssc_base_special_item/fsscBaseSpecialItem.do?method=add">
						<!-- 编辑 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.edit('${fsscBaseSpecialItem.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/fssc/base/fssc_base_special_item/fsscBaseSpecialItem.do?method=deleteall">
						<!-- 删除 -->
						<a class="btn_txt" style="color:#2574ad" href="javascript:window.deleteDoc('${fsscBaseSpecialItem.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
