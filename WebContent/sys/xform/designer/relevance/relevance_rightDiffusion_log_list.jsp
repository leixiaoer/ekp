<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="detailInfo" list="${detailInfo}">
		<%--ID--%>
		<list:data-column property="fdId"></list:data-column>
		<list:data-column property="actionUrl"></list:data-column>
		<list:data-column property="fdMainId"></list:data-column>
		<%--主文档标题--%>
		<list:data-column col="mainSubject" title="${ lfn:message('sys-xform:sysFormRelevance.rightExtentionLog_subject') }" style="text-align:center" escape="false">
			<span class="com_subject"><c:out value="${detailInfo.mainSubject}" /></span>
		</list:data-column>
		<%--关联文档标题--%>
		<list:data-column col="docSubject" title="${ lfn:message('sys-xform:sysFormRelevance.rightExtentionLog_mainDocSubject') }" style="text-align:center" escape="false">
			<span class="com_subject"><c:out value="${detailInfo.docSubject}" /></span>
		</list:data-column>
		<%--被扩散人--%>
		<list:data-column col="docCreator" title="${ lfn:message('sys-xform:sysFormRelevance.rightExtentionLog_diffusionOfAuthority') }" style="text-align:center" escape="false">
			<span class="com_subject"><c:out value="${detailInfo.docCreator}" /></span>
		</list:data-column>
		<%--扩散人--%>
		<list:data-column col="authOpener" title="${ lfn:message('sys-xform:sysFormRelevance.rightExtentionLog_authorizedPerson') }" style="text-align:center" escape="false">
			<span class="com_subject"><c:out value="${detailInfo.authOpener}" /></span>
		</list:data-column>
		<%--扩散日期--%>
		<list:data-column col="docCreateTime" title="${ lfn:message('sys-xform:sysFormRelevance.rightExtentionLog_authorizationDate') }" style="text-align:center" escape="false">
			<span class="com_subject"><c:out value="${detailInfo.docCreateTime}" /></span>
		</list:data-column>
		<!-- 其它操作 -->
		<list:data-column headerClass="width100" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<!-- 删除 -->
					<a class="btn_txt" href="javascript:delDoc('${detailInfo.fdId}')">${lfn:message('button.delete')}</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
