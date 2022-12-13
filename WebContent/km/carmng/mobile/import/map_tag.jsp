<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/attend/map.tld" prefix="map"%>

<map:location 
	propertyName="${param.propertyName }"
	nameValue="${param.nameValue }"
	propertyCoordinate="${param.propertyCoordinate }"
	coordinateValue="${param.coordinateValue }"
	propertyDetail="${param.propertyDetail }"
	detailValue="${param.detailValue }"
	mobile="${param.mobile }">
</map:location>