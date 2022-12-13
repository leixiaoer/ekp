<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
<list:data-columns var="kmCarmngMotorcadeSet" list="${queryPage.list}">
		<list:data-column property="fdId" title="fdId">
		</list:data-column>
		<list:data-column property="fdName" title="${ lfn:message('km-carmng:kmCarmngMotorcadeSet.fdName') }">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('km-carmng:kmCarmngMotorcadeSet.fdOrder') }">
		</list:data-column>
		<list:data-column property="fdDispatchers.fdName" title="${ lfn:message('km-carmng:kmCarmngMotorcadeSet.fdDispatchersId') }">
		</list:data-column>
		<list:data-column property="fdRegister.fdName" title="${ lfn:message('km-carmng:kmCarmngMotorcadeSet.fdRegisterId') }">
		</list:data-column>
		<list:data-column property="docCreator.fdName" title="${ lfn:message('km-carmng:kmCarmngMotorcadeSet.docCreatorId') }">
		</list:data-column>
		<list:data-column property="docCreateTime" title="${ lfn:message('km-carmng:kmCarmngMotorcadeSet.docCreateTime') }">
		</list:data-column>	
		<list:data-column headerClass="width180" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!-- 操作列 -->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=edit&fdId=${kmCarmngMotorcadeSet.fdId}" requestMethod="GET">
						<a class="btn_txt" href="javascript:addDriver('${kmCarmngMotorcadeSet.fdId}')">${lfn:message('km-carmng:kmCarmngDispatchersInfo.driver.add')}</a>
						<a class="btn_txt" href="javascript:addCar('${kmCarmngMotorcadeSet.fdId}')">${lfn:message('km-carmng:kmCarmngDispatchersInfo.carInfo.add')}</a>
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${kmCarmngMotorcadeSet.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=delete&fdId=${kmCarmngMotorcadeSet.fdId}" requestMethod="POST">
						<!-- 删除 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmCarmngMotorcadeSet.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
					</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>		
	</list:data-columns>	
	
	<list:data-paging page="${ queryPage }"></list:data-paging>
</list:data>