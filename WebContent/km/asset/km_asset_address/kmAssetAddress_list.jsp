<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmAssetAddress" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdAddress" title="${ lfn:message('km-asset:kmAssetAddress.fdAddress') }" style="text-align:left;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdAssetAddressCate.fdName" title="${ lfn:message('km-asset:kmAssetAddress.fdAssetAddressCate') }">
		</list:data-column>
		<list:data-column headerClass="width60" col="fdIsvalidate" title="${ lfn:message('km-asset:kmAssetAddress.fdIsvalidate') }" escape="false">
		   <sunbor:enumsShow value="${kmAssetAddress.fdIsvalidate}" enumsType="common_yesno" />
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/asset/km_asset_address/kmAssetAddress.do?method=edit&fdId=${kmAssetAddress.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmAssetAddress.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/asset/km_asset_address/kmAssetAddress.do?method=delete&fdId=${kmAssetAddress.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmAssetAddress.fdId}')">删除</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>