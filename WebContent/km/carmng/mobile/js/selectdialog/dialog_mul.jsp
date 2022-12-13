<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

	<div data-dojo-type="km/carmng/mobile/js/selectdialog/DialogHeader"
		data-dojo-props="detailUrl:'{categroy.detailUrl}',key:'{categroy.key}',title:'{categroy.title}',height:'4rem'"></div>
	<div data-dojo-type="mui/category/CategoryNavInfo" data-dojo-props="key:'{categroy.key}'"></div>
	<div id='_address_mul_view_{categroy.key}'
		data-dojo-type="dojox/mobile/ScrollableView"
		data-dojo-mixins="mui/category/_ViewScrollResizeMixin"
		data-dojo-props="scrollBar:false,threshold:100,key:'{categroy.key}'">
		<div id='_address_mul_search_{categroy.key}'
			data-dojo-type="km/carmng/mobile/js/selectdialog/DialogSearchBar" 
			data-dojo-props="orgType:{categroy.type},searchUrl:'{categroy.searchDataUrl}',key:'{categroy.key}',exceptValue:'{categroy.exceptValue}',height:'4rem'">
		</div>
		<ul data-dojo-type="km/carmng/mobile/js/selectdialog/DialogList"
			data-dojo-mixins="km/carmng/mobile/js/selectdialog/DialogItemListMixin"
			data-dojo-props="isMul:{categroy.isMul},key:'{categroy.key}',dataUrl:'{categroy.listDataUrl}',fieldParam:'{categroy.fieldParam}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}',selType:2,exceptValue:'{categroy.exceptValue}'">
		</ul>
	</div>
	<div data-dojo-type="km/carmng/mobile/js/selectdialog/DialogSelection" 
		 data-dojo-props="detailUrl:'{categroy.detailUrl}',
						 key:'{categroy.key}' ,
						 curIds:'{categroy.curIds}',
						 curNames:'{categroy.curNames}'" 
		 fixed="bottom">
	</div>
