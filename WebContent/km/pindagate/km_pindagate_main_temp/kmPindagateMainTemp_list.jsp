<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmPindagateTemplate" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="docSubject" title="${ lfn:message('km-pindagate:kmPindagateMainTemp.docSubject') }" style="text-align:center;min-width:180px">
		</list:data-column>
		<list:data-column headerClass="width140" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=edit&fdId=${kmPindagateTemplate.fdId}" requestMethod="GET">
						<a class="btn_txt" href="javascript:edit('${kmPindagateTemplate.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=delete&fdId=${kmPindagateTemplate.fdId}" requestMethod="GET">
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