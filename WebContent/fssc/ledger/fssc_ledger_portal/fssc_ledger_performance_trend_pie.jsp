<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
<% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>
<script type="text/javascript" src="${LUI_ContextPath}/resource/js/common.js"></script>
<script type="text/javascript">
            Com_IncludeFile("data.js");
            Com_IncludeFile("echarts.js", "${LUI_ContextPath}/sys/ui/js/chart/echarts/", 'js', true);
            Com_IncludeFile("landrayblue.js", "${LUI_ContextPath}/fssc/budget/resource/js/", 'js', true);
        </script>
		<script>
		window.onload = function(){
			changgeMap();
		}
		</script>
<html >
   <body style="height: 95%; margin: 0">
       <div id="container" style="height: 90%"></div>
       
       <script type="text/javascript">
       function changgeMap(){
    	   var data1 = new KMSSData();
			data1.UseCache = false;
			var rtn1 = data1.AddBeanData("fsscLedgerContractService&authCurrent=true&fdType=checkCost").GetHashMapArray();
			if(rtn1.length>0){
				var msgs = JSON.parse(rtn1[0]["keyValue"]);
				var legendData = JSON.parse(rtn1[0]["legendData"]);
				var deptPieData = JSON.parse(rtn1[0]["deptPieData"]);
				var dom = document.getElementById("container");
				var xAxis = JSON.parse(rtn1[0]["xAxis"]);
				var myChart = echarts.init(dom,"landrayblue");
				var app = {};
				option = null;
				option = {
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c} ({d}%)"
					    },
					    legend: {
					        type: 'scroll',
					        orient: 'vertical',
					        right: 10,
					        top: 20,
					        bottom: 20,
					        data: legendData
					    },
					    series : [
					        {
					            name: '部门',
					            type: 'pie',
					            radius : '55%',
					            center: ['40%', '50%'],
					            data: deptPieData,
					            itemStyle: {
					                emphasis: {
					                    shadowBlur: 10,
					                    shadowOffsetX: 0,
					                    shadowColor: 'rgba(0, 0, 0, 0.5)'
					                }
					            }
					        }
					    ]
					};

				if (option && typeof option === "object") {
				    myChart.setOption(option, true);
				}
			}
       }

       </script>
   </body>
   </html>