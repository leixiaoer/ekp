<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<div class="oitemSelector_toolbar">
	<div class="oitemSelector_toolbar_btn" style="left: 1rem; display: none;" id="oitemSelectorPreBtn">
		<i class="mui mui-back"></i>
		<span><bean:message bundle="sys-mobile" key="mui.category.button.up" /></span>
	</div>
	<div class="oitemSelector_toolbar_btn" style="right: 1rem;" id="oitemSelectorCalBtn">
		<span><bean:message bundle="sys-mobile" key="mui.category.button.cancel" /></span>
	</div>
	<span id="oitemSelectorTitle"><bean:message bundle="sys-mobile" key="mui.category.pselect" /></span>	
</div>

<div id="oitemSelectorView_{categroy.key}" 
	data-dojo-type="dojox/mobile/ScrollableView"
	data-dojo-mixins="mui/category/_ViewScrollResizeMixin"
	data-dojo-props="scrollBar:false,threshold:100,key:'{categroy.key}'">
	
	<ul data-dojo-type="geesun/oitems/mobile/resource/js/OitemSelector" 
		data-dojo-props="isMul:true,key:'{categroy.key}'">
	</ul>
	
</div>

<div data-dojo-type="geesun/oitems/mobile/resource/js/OitemSelection" 
	data-dojo-props="key:'{categroy.key}',curIds:'{categroy.curIds}',curNames:'{categroy.curNames}'" fixed="bottom">
</div>
