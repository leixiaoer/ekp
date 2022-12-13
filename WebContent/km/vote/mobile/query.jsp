<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div data-dojo-type="mui/query/QueryList" data-dojo-props="topHeight:!{topHeight}">
	<div data-dojo-type="mui/query/QueryListItem" 
		data-dojo-mixins="mui/simplecategory/SimpleCategoryDialogMixin" 
		data-dojo-props="label:'<bean:message key="portlet.cate" />',icon:'mui mui-Csort',
			modelName:'com.landray.kmss.km.vote.model.KmVoteCategory',
			redirectURL:'/km/vote/mobile/index.jsp?moduleName=!{curNames}&filter=1',
			filterURL:'/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&categoryId=!{curIds}&orderby=docCreateTime&ordertype=down'">
	</div>
	<div data-dojo-type="mui/query/QueryListItem"
		data-dojo-mixins="mui/search/SearchBarDialogMixin" 
		data-dojo-props="label:'<bean:message key="button.search" />',icon:'mui mui-search', modelName:'com.landray.kmss.km.vote.model.KmVoteMain'">
	</div>
</div>
