<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="net.sf.json.*"%>
<%@ page import="com.landray.kmss.km.supervise.util.ChartResult"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<ui:chart-data gridMargin="80 110 80 40" text="${result.title.text}" xAxisData="${result.xAxis[0].data}" yAxisName="${result.yAxis[0].name}">
	<ui:chart-property name="toolbox" merge="false">
		{
			"show" : true,
	        "feature" : {
	           "restore" : {"show": true}, // 显示刷新
	           "saveAsImage" : {"show": true}, // 显示保存图片
	           "myDataTableView" : {"show": false} // 不显示列表视图
	        }
		}
	</ui:chart-property>
	<%
		// 因为这里有许多细节扩展，所以没法使用已经封装好的标签
		ChartResult result = (ChartResult)request.getAttribute("result");
		String seriesType = (String)result.getSeriesData().get(0).get("type");
		
	%>
<%if(!"bar".equals(seriesType)){%>
	<%
		// 因为这里有许多细节扩展，所以没法使用已经封装好的标签
		/* ChartResult result = (ChartResult)request.getAttribute("result");
		String seriesType = (String)result.getSeriesData().get(0).get("type"); */
		Object seriesRadius = result.getSeriesData().get(0).get("radius");
		List<Long> dataList = (List<Long>)result.getSeriesData().get(0).get("data");
		String nameList = (String)result.getxAxis().get(0).get("data");
		JSONArray seriesData = new JSONArray();
		JSONArray seriesNameData = new JSONArray();
		JSONObject selectSeriesNameData = new JSONObject();
		String[] _nameList = nameList.split(",");
		for(int i=0;i<dataList.size();i++){
			long count = dataList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("value", count);
			obj.put("name", _nameList[i]);
			seriesData.add(obj);
			seriesNameData.add(_nameList[i]);
			if(i < 5){
				selectSeriesNameData.put(_nameList[i],true);
			}else{
				selectSeriesNameData.put(_nameList[i],false);
			}
		}
		
	%>
	<ui:chart-property name="series" merge="false">
		[
	        {
	            "type" : "<%=seriesType%>",
	            <%if(seriesRadius != null){%>
	            "radius" : <%=seriesRadius%>,
	            <%}%>
	            <%if("bar".equals(seriesType)){%>
	            "name" : "${ lfn:message('hr-staff:hrStaffPersonReport.page.staffNum') }",
	            itemStyle: {
	                normal: {
		                color: function(){
		                	var colors = [
							    "#ff7f50", "#87cefa", "#da70d6", "#32cd32", "#6495ed",
							    "#ff69b4", "#ba55d3", "#cd5c5c", "#ffa500", "#40e0d0",
							    "#1e90ff", "#ff6347", "#7b68ee", "#00fa9a", "#ffd700",
							    "#6699FF", "#ff6666", "#3cb371", "#b8860b", "#30e0e0"
							];
							var index = Math.floor(Math.random() * 20);
		                	return colors[index];
		                },
	                    label: {
	                        show: true,
	                        position: 'top',
	                        formatter: '{c}'
	                    }
	                }
	            },
	            <%}else if("pie".equals(seriesType)){%>
	            	"name" : "督办分类",
		            itemStyle: {
		                normal: {
			                color: function(params){
			                	var colors = [
								    "#8859FB","#FEB163","#4285F4","#36AEEF",
								    "#FF9500","#5AC8FA","#4C7BFD","#FF3B30","#4CD964",
								    "#FFCC00","#8280FF","#5856D6","#0097FF","#FD71A4"
								];
			                	return colors[params.dataIndex];
			                }
		                }
		            },
	            <%}%>
	            
	            "data" : <%=seriesData%>
	        }
	    ]
	</ui:chart-property>
	<ui:chart-property name="yAxis" merge="false">
		[
	        {
	            type : 'value'
	        }
	    ]
	</ui:chart-property>
	<%if("pie".equals(seriesType)){%>
	<ui:chart-property name="legend" merge="false">
		{
			"type": 'scroll',
	        "x" : "center",
		    "y" : "bottom",
		    "orient" : "horizontal",
	        "data" : <%=seriesNameData%>,
	        "selected":<%=selectSeriesNameData%>
	    }
	</ui:chart-property>
	<%}%>
<%}else{%>
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

<%}%>
</ui:chart-data>