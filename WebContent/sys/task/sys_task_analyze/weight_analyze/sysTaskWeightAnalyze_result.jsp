<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<ui:chart-data gridMargin="80 110 80 40" text="${result.title.text}"  xAxisData="${result.xAxis[0].data}"  yAxisName="${result.yAxis[0].name}" y2AxisName="${result.yAxis[1].name}">
	
	<ui:chart-property name="title.x" value="center"></ui:chart-property>
	<ui:chart-property name="title.y" value="top"></ui:chart-property>
	
	<ui:chart-property name="toolbox" merge="false">
		{
			"show" : true,
			"y":"center",
			"right":30,
			"orient":"vertical",
	        "feature" : {
	           "dataZoom" : {"show" : true},
	           "magicType" : {"show": true, "type": ["line","bar"]},
	           "restore" : {"show": true},
	           "saveAsImage" : {"show": true},
	           "dataTableView":{
	           		"show":true,
	           		"title":"${lfn:message('sys-task:sysTaskAnalyze.stat.section.switch')}",
	           		"icon":"${LUI_ContextPath}/sys/task/sys_task_analyze/resource/images/switch.png"
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
		<c:set var="forY2" value="false" />
		<c:if test="${item.yAxisIndex==1}">
			<c:set var="forY2" value="true" />
		</c:if>
		<ui:chart-series name="${item.name}" type="${item.type}"  data="${item.data}" forY2="${forY2}">
		</ui:chart-series>
	</c:forEach>
	
</ui:chart-data>