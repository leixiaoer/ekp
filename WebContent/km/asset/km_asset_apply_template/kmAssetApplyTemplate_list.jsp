<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmAssetApplyTemplate" list="${queryPage.list }" custom="false" >
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-asset:kmAssetApplyTemplate.fdName') }" style="text-align:left;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-asset:kmAssetApplyTemplate.fdOrder') }">
		</list:data-column>
		<list:data-column headerClass="width80" property="docCreator.fdName" title="${ lfn:message('km-asset:kmAssetApplyTemplate.docCreator') }">
		</list:data-column>
		<list:data-column headerClass="width120" property="docCreateTime" title="${ lfn:message('km-asset:kmAssetApplyTemplate.docCreateTime') }">
		</list:data-column>
			<list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-asset:kmAssetApplyBase.status') }" escape="false">
		    <c:if test="${kmAssetApplyTemplate.fdIsAvailable}">
				<bean:message bundle="km-asset" key="kmAssetApplyBase.fdIsAvailable.true" />
			</c:if>
			<c:if test="${!kmAssetApplyTemplate.fdIsAvailable}">
				<bean:message bundle="km-asset" key="kmAssetApplyBase.fdIsAvailable.false" />
			</c:if>
		</list:data-column>
		
		<list:data-column headerClass="width160" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					  <c:if test="${kmAssetApplyTemplate.fdIsAvailable}">
					<c:if test="${'KmAssetApplyDealDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_deal/kmAssetApplyDeal.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_deal/kmAssetApplyDeal.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyRentDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_rent/kmAssetApplyRent.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_rent/kmAssetApplyRent.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyBuyDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_buy/kmAssetApplyBuy.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_buy/kmAssetApplyBuy.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyStockDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyInDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_in/kmAssetApplyIn.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_in/kmAssetApplyIn.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyGetDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_get/kmAssetApplyGet.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_get/kmAssetApplyGet.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyDivertDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_divert/kmAssetApplyDivert.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_divert/kmAssetApplyDivert.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyRepairDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyReturnDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyChangeDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_change/kmAssetApplyChange.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_change/kmAssetApplyChange.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyTaskDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_task/kmAssetApplyTask.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					<c:if test="${'KmAssetApplyInventoryDoc' eq  kmAssetApplyTemplate.fdTempKey}">
						<kmss:auth requestURL="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
							<!-- 编辑 -->
							<a class="btn_txt" href="javascript:void(0)" onclick="Com_OpenWindow('<c:url value="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do" />?method=add&fdTemplateId=${kmAssetApplyTemplate.fdId}','_blank');">
								${lfn:message('km-asset:kmAssetApplyBase.create')}
							</a>
						</kmss:auth>
					</c:if>
					</c:if>
					<kmss:auth requestURL="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=edit&fdId=${kmAssetApplyTemplate.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmAssetApplyTemplate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=delete&fdId=${kmAssetApplyTemplate.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmAssetApplyTemplate.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>