<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="net.sf.json.*"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<ui:chart-data gridMargin="80 110 80 40" text="${result.title.text}" xAxisData="${result.xAxis[0].data}" yAxisName="${result.yAxis[0].name}">
	
	<ui:chart-property name="title.x" value="center"></ui:chart-property>
	<ui:chart-property name="title.y" value="top"></ui:chart-property>
	<ui:chart-property name="toolbox" merge="false">
		{
			"show" : true,
			"y":"center",
			"orient":"vertical",
	        "feature" : {
	           "dataZoom" : {"show" : true},
	           "magicType" : {"show": true, "type": ["line","bar"]},
	           "restore" : {"show": true},
	           "saveAsImage" : {"show": true},
	           "dataTableView":{
	           		"show":true,
	           		"title":"${lfn:message('km-supervise:kmSupervise.stat.section.switch')}",
	           		"icon":"${LUI_ContextPath}/km/supervise/resource/images/switch.png"
	           }
	        }
		}
	</ui:chart-property>
	<ui:chart-property name="toolbox.feature.dataTableView.onclick" isScript="true" merge="true">
		function(){
			stat.switchChart("1");
		}
	</ui:chart-property>

	<c:forEach var="item" items="${result.seriesData}">
		<ui:chart-series name="${item.name}" type="${item.type}" data="${item.data}"></ui:chart-series>
	</c:forEach>

</ui:chart-data>