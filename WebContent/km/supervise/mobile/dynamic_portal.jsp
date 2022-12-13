<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ul data-dojo-type="sys/mportal/mobile/card/JsonStoreCardList" 
   	data-dojo-mixins="km/supervise/mobile/resource/js/list/DynamicItemListMixin"
   	data-dojo-props="url:'/km/supervise/km_supervise_dynamic/kmSuperviseDynamic.do?method=data&type=dynamic&orderby=docCreateTime&ordertype=down&rowsize=${param.rowsize}',lazy:false">
</ul>