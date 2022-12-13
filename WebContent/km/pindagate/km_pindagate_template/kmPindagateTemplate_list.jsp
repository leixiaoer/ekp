<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmPindagateTemplate" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-pindagate:kmPindagateTemplate.fdName') }" style="text-align:center;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width80" property="fdOrder" title="${ lfn:message('km-pindagate:kmPindagateTemplate.fdOrder') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="docCreator.fdName" title="${ lfn:message('km-pindagate:kmPindagateTemplate.docCreatorId') }">
		</list:data-column>
		<list:data-column headerClass="width140" property="docCreateTime" title="${ lfn:message('km-pindagate:kmPindagateTemplate.docCreateTime') }">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdIsAvailable" title="${ lfn:message('km-pindagate:kmPindagateMain.status') }" escape="false">
		    <c:if test="${kmPindagateTemplate.fdIsAvailable}">
				<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable.true" />
			</c:if>
			<c:if test="${!kmPindagateTemplate.fdIsAvailable}">
				<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable.false" />
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<c:if test="${kmPindagateTemplate.fdIsAvailable}">
					<kmss:auth
						requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=add&fdTemplateId=${kmPindagateTemplate.fdId}"
						requestMethod="GET">
						<a class="btn_txt" href="javascript:addDoc('${kmPindagateTemplate.fdId}')">${lfn:message('km-pindagate:kmPindagateMain.opt.create')}</a>
					</kmss:auth>
				  </c:if>
					<kmss:auth
						requestURL="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=edit&fdId=${kmPindagateTemplate.fdId}"
						requestMethod="GET">
						<a class="btn_txt" href="javascript:edit('${kmPindagateTemplate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth
						requestURL="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do?method=save"
						requestMethod="GET">
						<a class="btn_txt" href="javascript:deleteAll('${kmPindagateTemplate.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>