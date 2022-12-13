<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="communicateUrl" value="${KMSS_Parameter_ContextPath}km/vote/km_vote_main/kmVoteMain.do?method=add&modelName=${JsParam.fdModelName}&modelId=${JsParam.fdModelId}" />
<kmss:authShow roles="ROLE_KMVOTEMAIN_CREATE">
	<ui:button parentId="toolbar" text="${lfn:message('km-vote:kmVoteMain.mechanism.create') }" 
		onclick="Com_OpenWindow('${communicateUrl}','_blank');" order="3">
	</ui:button>
</kmss:authShow>
<c:set var="order" value="${empty param.order ? '10' : param.order}"/>
<c:set var="disable" value="${empty param.disable ? 'false' : param.disable}"/>
<ui:content title="${lfn:message('km-vote:kmVoteMain.mechanism.tab')}" cfg-order="${order}" cfg-disable="${disable}">
	<list:listview id="listview">
		<ui:source type="AjaxJson">
			{url:'/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&modelName=${JsParam.fdModelName}&modelId=${JsParam.fdModelId}'}
		</ui:source>
		<!-- 列表视图 -->	
		<list:colTable isDefault="false" layout="sys.ui.listview.columntable" cfg-norecodeLayout="simple"
			rowHref="/km/vote/km_vote_main/kmVoteMain.do?method=view&fdId=!{fdId}"  name="columntable">
			<list:col-serial></list:col-serial> 
			<list:col-html   title="${ lfn:message('km-vote:kmVoteMain.docSubject') }" style="text-align:left;">
				{$ <span class="com_subject">{%row['docSubject']%}</span> $}
			</list:col-html>
			<list:col-auto props="fdVoteCategory;fdVoteNum;docCreator;fdEffectTime;fdExpireTime;fdVoteStatus"></list:col-auto>
		</list:colTable>
	</list:listview> 
	<list:paging></list:paging>
</ui:content>


