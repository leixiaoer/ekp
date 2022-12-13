<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmSupplierMain" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-keydata-supplier:kmSupplierMain.fdName') }" style="text-align:center;min-width:160px">
		</list:data-column>
		<list:data-column headerClass="width140" property="fdCode" title="${ lfn:message('km-keydata-supplier:kmSupplierMain.fdCode') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdLegal" title="${ lfn:message('km-keydata-supplier:kmSupplierMain.fdLegal') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdRegMoney" title="${ lfn:message('km-keydata-supplier:kmSupplierMain.fdRegMoney') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdContactPerson" title="${ lfn:message('km-keydata-supplier:kmSupplierMain.fdContactPerson') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="docCreator.fdName" title="${ lfn:message('km-keydata-supplier:kmSupplierMain.docCreator') }">
		</list:data-column>
		<list:data-column headerClass="width100" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">		
					<kmss:auth requestURL="/km/keydata/supplier/km_supplier_main/kmSupplierMain.do?method=edit&fdId=${kmSupplierMain.fdId}">
						<a class="btn_txt" href="javascript:edit('${kmSupplierMain.fdId}')">${lfn:message('button.edit')}</a>
				    </kmss:auth>    
				    <c:if test="${kmSupplierMain.fdIsAvailable==true}">
						<kmss:auth requestURL="/km/keydata/supplier/km_supplier_main/kmSupplierMain.do?method=updateAvailable&fdId=${kmSupplierMain.fdId}">
							<a class="btn_txt" href="javascript:disableAll('${kmSupplierMain.fdId}')">${lfn:message('km-keydata-base:keydata.setInvalidated')}</a>
						</kmss:auth>
					</c:if>
					<c:if test="${kmSupplierMain.fdIsAvailable==false}">
						<kmss:auth requestURL="/km/keydata/supplier/km_supplier_main/kmSupplierMain.do?method=updateAvailable&fdId=${kmSupplierMain.fdId}">
							<a class="btn_txt" href="javascript:enableAll('${kmSupplierMain.fdId}')">${lfn:message('km-keydata-base:keydata.setValidated')}</a>
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