<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<%-- 右侧页面 --%>
	<template:replace name="body">
		<%-- 查询栏 --%>
		<div style="margin-top:10px">
			<list:criteria id="criteria1">
				<%-- 搜索条件:文档标题--%>
				<list:cri-ref key="fdName" ref="criterion.sys.docSubject">
				</list:cri-ref>
			</list:criteria>
        </div>
		<%--list页面--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/review/km_review_template/kmReviewTemplateSearch.do?method=listChildren'}
			</ui:source>
			<%--摘要视图--%>
			<list:rowTable isDefault="false" rowHref="/km/review/km_review_template/kmReviewTemplate.do?method=view&fdId=!{fdId}" name="rowtable">
				<list:row-template>
				{$
				 <div class="clearfloat lui_listview_rowtable_summary_content_box" kmss_fdId="{%row.fdId%}">
					<dl>
						<dt><span class="lui_listview_rowtable_summary_content_serial">{%row.index%}</span></dt>
					</dl>
					<dl>
						<dt>
							<a class="textEllipsis com_subject" title="{%row.fdName%}" onclick="Com_OpenNewWindow(this)" data-href="${LUI_ContextPath}/km/review/km_review_template/kmReviewTemplate.do?method=view&fdId={%row.fdId%}" target="_blank" data-lui-mark-id="{%row.rowId%}">{%row.fdName%}</a>
						</dt>
						<dd class="lui_listview_rowtable_summary_content_box_foot_info">
							<span>${lfn:message('km-review:kmReviewTemplate.creategory.path') }：{%row['creategoryFullName']%}</span>
							<span>${lfn:message('sys-doc:sysDocBaseInfo.docCreator') }：{%row['docCreator']%}</span>
							<span>${lfn:message('km-review:kmReviewTemplate.docCreateTime') }：{%row['docCreateTime']%}</span>
						</dd>
					</dl>
					</div>	
				$}
				</list:row-template>
			</list:rowTable>
			<ui:event topic="list.loaded">
				$(".criteria-extra").remove();
				$(".lui_listview_rowtable_summary_content_box").last().css("border-bottom","2px solid #ccc");
			</ui:event>
		</list:listview>
		<br>
		
		<list:paging></list:paging>
	</template:replace>
</template:include>
