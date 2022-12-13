﻿<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>


	<div id="allHeader" data-dojo-type="sys/unit/mobile/selectdialog/DialogHeader"
		data-dojo-props="headerUrl:'{categroy.headerUrl}',key:'{categroy.key}',title:'{categroy.title}',height:'4rem',channel:'all'">
	</div>
	<div id="groupHeader" data-dojo-type="sys/unit/mobile/selectdialog/DialogHeader"
		data-dojo-props="headerUrl:'{categroy.headerUrl}',key:'{categroy.key}',title:'{categroy.title}',height:'4rem',channel:'group'">
	</div>
	<div id="cateHeader" data-dojo-type="sys/unit/mobile/selectdialog/DialogHeader"
		data-dojo-props="headerUrl:'{categroy.headerUrl}',key:'{categroy.key}',title:'{categroy.title}',height:'4rem',channel:'cate'">
	</div>
	<div id='_address_mul_search_{categroy.key}'
		data-dojo-type="sys/unit/mobile/selectdialog/DialogSearchBar" 
		data-dojo-props="orgType:{categroy.type},searchUrl:'{categroy.searchDataUrl}',key:'{categroy.key}',exceptValue:'{categroy.exceptValue}',height:'4rem',channel:'all'">
	</div>
	<div id="defaultView_{categroy.key}" data-dojo-type="dojox/mobile/View" >
		<c:if test="${param.showGroup eq 'true'}">
			<div data-dojo-type="mui/header/Header" class="muiHeaderNav">
		        <div data-dojo-type="mui/nav/StaticNavBar" data-dojo-mixins="sys/unit/mobile/selectdialog/DialogNavBarMixin" data-dojo-props="key:'{categroy.key}'">
		        </div>
	        </div>
	      </c:if> 
         <div id="allUnitView_{categroy.key}" data-dojo-type="dojox/mobile/View" >
        		<div  
				data-dojo-type="dojox/mobile/ScrollableView"
				data-dojo-mixins="mui/category/AppBarsMixin"
				data-dojo-props="scrollBar:false,threshold:100,key:'{categroy.key}',channel:'all'">
	        		<ul data-dojo-type="sys/unit/mobile/selectdialog/DialogList"
					data-dojo-mixins="sys/unit/mobile/selectdialog/DialogItemListMixin"
					data-dojo-props="isMul:{categroy.isMul},key:'{categroy.key}',dataUrl:'{categroy.listDataUrl}',fieldParam:'{categroy.fieldParam}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}',selType:2,exceptValue:'{categroy.exceptValue}',channel:'all'">
				</ul>
	        </div>
        </div>
        <div id="unitGroupView_{categroy.key}" data-dojo-type="dojox/mobile/View" >
        		<div  
				data-dojo-type="dojox/mobile/ScrollableView"
				data-dojo-mixins="mui/category/AppBarsMixin"
				data-dojo-props="scrollBar:false,threshold:100,key:'{categroy.key}',channel:'group'">
	        		<ul data-dojo-type="sys/unit/mobile/selectdialog/DialogList"
					data-dojo-mixins="sys/unit/mobile/selectdialog/UnitGroupListMixin"
					data-dojo-props="isMul:{categroy.isMul},key:'{categroy.key}',allDataUrl:'{categroy.listDataUrl}',fieldParam:'{categroy.fieldParam}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}',selType:2,exceptValue:'{categroy.exceptValue}',channel:'group'">
				</ul>
	        </div>
       	</div>
       	<div id="unitCateView_{categroy.key}" data-dojo-type="dojox/mobile/View" >
        		<div  
				data-dojo-type="dojox/mobile/ScrollableView"
				data-dojo-mixins="mui/category/AppBarsMixin"
				data-dojo-props="scrollBar:false,threshold:100,key:'{categroy.key}',channel:'cate'">
	        		<ul data-dojo-type="sys/unit/mobile/selectdialog/DialogList"
					data-dojo-mixins="sys/unit/mobile/selectdialog/UnitCateListMixin"
					data-dojo-props="isMul:{categroy.isMul},key:'{categroy.key}',allDataUrl:'{categroy.listDataUrl}',fieldParam:'{categroy.fieldParam}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}',selType:3,exceptValue:'{categroy.exceptValue}',channel:'cate'">
				</ul>
	        </div>
       	</div>
	</div>
	<div  id="searchView_{categroy.key}"
				data-dojo-type="dojox/mobile/ScrollableView"
				data-dojo-mixins="mui/address/AddressViewScrollResizeMixin"
				data-dojo-props="scrollBar:false,threshold:100,key:'{categroy.key}',channel:'search'">
		       		<ul data-dojo-type="sys/unit/mobile/selectdialog/DialogList"
					data-dojo-mixins="sys/unit/mobile/selectdialog/DialogItemListMixin,sys/unit/mobile/selectdialog/DialogSearchListMixin"
					data-dojo-props="key:'{categroy.key}',searchUrl:'{categroy.searchDataUrl}',dataUrl:'{categroy.searchDataUrl}',fieldParam:'{categroy.fieldParam}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}',selType:3,exceptValue:'{categroy.exceptValue}',channel:'search',isMul:{categroy.isMul}">
				</ul>
       </div>

