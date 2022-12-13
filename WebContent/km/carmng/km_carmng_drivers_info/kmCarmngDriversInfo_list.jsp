<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
<list:data-columns var="kmCarmngDriversInfo" list="${queryPage.list}">
		<list:data-column property="fdId" title="fdId">
		</list:data-column>
		<list:data-column property="fdName" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdName') }">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdOrder') }">
		</list:data-column>
		<list:data-column property="fdMotorcade.fdName" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdMotorcadeId') }">
		</list:data-column>
		<list:data-column property="fdDriverNumber" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdDriverNumber') }">
		</list:data-column>
		<list:data-column col="fdAnnualAuditingTime" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdAnnualAuditingTime') }">
			<kmss:showDate value="${kmCarmngDriversInfo.fdAnnualAuditingTime}" type="date" />
		</list:data-column>
		<list:data-column property="fdCredentialsType" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdCredentialsType') }">
		</list:data-column>
		<list:data-column col="fdCredentialsTime" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdCredentialsTime') }">
			<kmss:showDate value="${kmCarmngDriversInfo.fdCredentialsTime}" type="date" />
		</list:data-column>	
		<list:data-column col="fdValidTime" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdValidTime') }">
			<kmss:showDate value="${kmCarmngDriversInfo.fdValidTime}" type="date" />
		</list:data-column>	
		<list:data-column property="fdAnnualExamFrequency" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdAnnualExamFrequency') }">
		</list:data-column>
		<list:data-column property="fdRelationPhone" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdRelationPhone') }">
		</list:data-column>
		<!-- 其它操作 -->
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do?method=edit&fdId=${kmCarmngDriversInfo.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmCarmngDriversInfo.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do?method=delete&fdId=${kmCarmngDriversInfo.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmCarmngDriversInfo.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
		<list:data-column headerClass="width140" col="operations2" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do?method=edit&motorcadeId=${kmCarmngDriversInfo.fdMotorcade.fdId}&fdId=${kmCarmngDriversInfo.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmCarmngDriversInfo.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do?method=delete&motorcadeId=${kmCarmngDriversInfo.fdMotorcade.fdId}&fdId=${kmCarmngDriversInfo.fdId}" requestMethod="POST">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmCarmngDriversInfo.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>	
	
	<list:data-paging page="${ queryPage }"></list:data-paging>
</list:data>