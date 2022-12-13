<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCustomerMain" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-keydata-customer:kmCustomerMain.fdName') }" style="text-align:center;min-width:160px">
		</list:data-column>
		<list:data-column headerClass="width140" property="fdCode" title="${ lfn:message('km-keydata-customer:kmCustomerMain.fdCode') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdBrief" title="${ lfn:message('km-keydata-customer:kmCustomerMain.fdBrief') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdEnglishName" title="${ lfn:message('km-keydata-customer:kmCustomerMain.fdEnglishName') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="docCreator.fdName" title="${ lfn:message('km-keydata-customer:kmCustomerMain.docCreator') }">
		</list:data-column>
		<list:data-column headerClass="width100" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">		
					<kmss:auth requestURL="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=edit&fdId=${kmCustomerMain.fdId}">
						<a class="btn_txt" href="javascript:edit('${kmCustomerMain.fdId}')">${lfn:message('button.edit')}</a>
				    </kmss:auth>    
				    <c:if test="${kmCustomerMain.fdIsAvailable==true}">
						<kmss:auth requestURL="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=updateAvailable&fdId=${kmCustomerMain.fdId}">
							<a class="btn_txt" href="javascript:disableAll('${kmCustomerMain.fdId}')">${lfn:message('km-keydata-base:keydata.setInvalidated')}</a>
						</kmss:auth>
					</c:if>
					<c:if test="${kmCustomerMain.fdIsAvailable==false}">
						<kmss:auth requestURL="/km/keydata/customer/km_customer_main/kmCustomerMain.do?method=updateAvailable&fdId=${kmCustomerMain.fdId}">
							<a class="btn_txt" href="javascript:enableAll('${kmCustomerMain.fdId}')">${lfn:message('km-keydata-base:keydata.setValidated')}</a>
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