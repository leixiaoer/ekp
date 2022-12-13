<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<div data-dojo-type="km/carmng/mobile/js/selectdialog/DialogHeader"
		data-dojo-props="detailUrl:'{categroy.detailUrl}',key:'{categroy.key}',title:'{categroy.title}',height:'4rem'"></div>
	<div data-dojo-type="mui/category/CategoryNavInfo" data-dojo-props="key:'{categroy.key}'"></div>
	<div id='_dialog_sgl_view_{categroy.key}'
		data-dojo-type="dojox/mobile/ScrollableView"
		data-dojo-mixins="mui/category/_ViewScrollResizeMixin"
		data-dojo-props="scrollBar:false,threshold:100,key:'{categroy.key}'">
		<div id='_dialog_sgl_search_{categroy.key}'
			data-dojo-type="km/carmng/mobile/js/selectdialog/DialogSearchBar" 
			data-dojo-props="orgType:{categroy.type},key:'{categroy.key}',searchUrl:'{categroy.searchDataUrl}',exceptValue:'{categroy.exceptValue}',height:'4rem'">
		</div>
		<ul data-dojo-type="km/carmng/mobile/js/selectdialog/DialogList"
			data-dojo-mixins="km/carmng/mobile/js/selectdialog/DialogItemListMixin"
			data-dojo-props="isMul:{categroy.isMul},selType:2,key:'{categroy.key}',dataUrl:'{categroy.listDataUrl}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}',fieldParam:'{categroy.fieldParam}',exceptValue:'{categroy.exceptValue}'">
		</ul>
	</div>
