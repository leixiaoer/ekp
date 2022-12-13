<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="item" list="${queryPage.list }">		
		<list:data-column col="fdId"  escape="false">
			${item[0].fdId}
		</list:data-column>
        <list:data-column col="fdDocStatus"  escape="false">
            ${item[0].docStatus}
        </list:data-column>
		<list:data-column  col="docSubject" title="标题" escape="false">
			${item[0].docSubject}
		</list:data-column>
		<list:data-column col="from" escape="false" title="来自">
			${fromJson[item[2]]}
		</list:data-column>
		<list:data-column col="status" escape="false" title="状态">
			<c:if test='${item[1] == "1" }'>
				${lfn:message('sys-follow:sysFollowRelatedDoc.fdStatus.yes')}
			</c:if>
			<c:if test='${item[1] == "0" }'>
				${lfn:message('sys-follow:sysFollowRelatedDoc.fdStatus.no')}
			</c:if>
		</list:data-column>
		<list:data-column col="docCreateTime" escape="false" title="订阅时间">
			<kmss:showDate value="${item[0].docCreateTime }" type="date"></kmss:showDate>
		</list:data-column>
		<list:data-column col="href" escape="false">
			/sys/follow/sys_follow_doc/sysFollowDoc.do?method=view&fdId=${item[0].fdId}
		</list:data-column>
	</list:data-columns>
	<list:data-paging page="${queryPage }">
	</list:data-paging>
</list:data>

