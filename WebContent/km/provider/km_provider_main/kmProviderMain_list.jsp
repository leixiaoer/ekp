<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmProviderMain" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  col="fdName" title="${ lfn:message('km-provider:kmProviderMain.fdName') }" style="text-align:left;min-width:180px" escape="false">
		<span class="com_subject"><c:out value="${kmProviderMain.fdName}" /></span>
		</list:data-column>
		<list:data-column headerClass="width100" property="docCategory.fdName" title="${ lfn:message('km-provider:kmProviderMain.docCategory') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdBiao" title="${ lfn:message('km-provider:kmProviderMain.fdBiao') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdAddress" title="${ lfn:message('km-provider:kmProviderMain.fdAddress') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdLegal" title="${ lfn:message('km-provider:kmProviderMain.fdLegal') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdContactPerson" title="${ lfn:message('km-provider:kmProviderMain.fdContactPerson') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdPhoneNo" title="${ lfn:message('km-provider:kmProviderMain.fdPhoneNo') }">
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=edit&fdId=${kmProviderMain.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmProviderMain.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=delete&fdId=${kmProviderMain.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmProviderMain.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
					<c:if test="${kmProviderMain.fdIsvalidate==true}">
						<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall&categoryId=${param.categoryId}" requestMethod="GET">
						    <a class="btn_txt" href="javascript:invalidateAll('${kmProviderMain.fdId}')">${lfn:message('km-provider:kmProviderMain.btn.invalidate')}</a>
						</kmss:auth>
					</c:if>
					<c:if test="${kmProviderMain.fdIsvalidate==false}">
						<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=deleteall&categoryId=${param.categoryId}" requestMethod="GET">
						    <a class="btn_txt" href="javascript:validateAll('${kmProviderMain.fdId}')">${lfn:message('km-provider:kmProviderMain.btn.validate')}</a>
						</kmss:auth>
					</c:if>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>