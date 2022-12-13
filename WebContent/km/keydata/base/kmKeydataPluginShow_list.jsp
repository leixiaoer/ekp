<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmKeydataPluginShow" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  headerClass="width100" col="fdName" title="${ lfn:message('km-keydata-base:kmKeydataPluginShow.fdName') }">
			<c:choose>
				<c:when test="${not empty kmKeydataPluginShow.fdMessageKey }">
					<c:out value="${ lfn:message(kmKeydataPluginShow.fdMessageKey) }"></c:out>
				</c:when>
				<c:otherwise>
					<c:out value="${kmKeydataPluginShow.fdName}"></c:out>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<list:data-column headerClass="width160" property="fdActionUrl" title="${ lfn:message('km-keydata-base:kmKeydataPluginShow.fdActionUrl') }">
		</list:data-column>
		<list:data-column headerClass="width80" col="fdIsShow" title="${ lfn:message('km-keydata-base:kmKeydataPluginShow.fdIsShow') }">
			<sunbor:enumsShow value="${kmKeydataPluginShow.fdIsShow}" enumsType="common_yesno" />
		</list:data-column>
		<!-- 其它操作 -->
		<list:data-column headerClass="width100" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">		
					<kmss:auth requestURL="/km/keydata/base/kmKeydataPluginShow.do?method=edit&fdId=${kmKeydataPluginShow.fdId}" requestMethod="GET">
						<a class="btn_txt" href="javascript:edit('${kmKeydataPluginShow.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<c:if test="${kmKeydataPluginShow.fdIsShow==false}">
						<kmss:auth requestURL="/km/keydata/base/kmKeydataPluginShow.do?method=showall">
							<a class="btn_txt" href="javascript:showall('${kmKeydataPluginShow.fdId}')">${lfn:message('km-keydata-base:keydata.plugin.enable')}</a>
						</kmss:auth>
					</c:if>
					<c:if test="${kmKeydataPluginShow.fdIsShow==true}">
						<kmss:auth requestURL="/km/keydata/base/kmKeydataPluginShow.do?method=disshowall">
							<a class="btn_txt" href="javascript:disshowall('${kmKeydataPluginShow.fdId}')">${lfn:message('km-keydata-base:keydata.plugin.disable')}</a>
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