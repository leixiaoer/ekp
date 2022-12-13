<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&categoryId=${JsParam.categoryId}'}
			</ui:source>
			  <!-- 列表视图 -->	
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/vote/km_vote_main/kmVoteMain.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial> 
				<list:col-html   title="${ lfn:message('km-vote:kmVoteMain.docSubject') }" style="text-align:left;">
				{$ <span class="com_subject">{%row['docSubject']%}</span> $}
				</list:col-html>
				<list:col-auto props="fdVoteCategory;fdVoteNum;docCreator;fdEffectTime;fdExpireTime;fdVoteStatus"></list:col-auto>
			</list:colTable>
		</list:listview> 
		<list:paging></list:paging>