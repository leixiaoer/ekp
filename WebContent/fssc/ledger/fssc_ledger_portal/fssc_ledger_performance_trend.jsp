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
				console.log(rtn1[0]["legendData"])
				var legendData = JSON.parse(rtn1[0]["legendData"]);
				var dom = document.getElementById("container");
				var xAxis = JSON.parse(rtn1[0]["xAxis"]);
				var myChart = echarts.init(dom,"landrayblue");
				var app = {};
				option = null;
				option = {
					    tooltip: {
					        trigger: 'axis'
					    },
					    legend: {
					    	orient: 'horizontal',
					        right: 25,
					        top: 20,
					        bottom: 20,
					        data: legendData
					    },
					    grid: {
					        left: '3%',
					        right: '4%',
					        bottom: '3%',
					        containLabel: true
					    },
					    toolbox: {
					    	 show : true,                                 //是否显示工具栏组件
					    	    orient:"vertical",                        //工具栏 icon 的布局朝向'horizontal' 'vertical'
					    	    itemSize:15,                                 //工具栏 icon 的大小
					    	    itemGap:10,                                  //工具栏 icon 每项之间的间隔
					    	    showTitle:true,                             //是否在鼠标 hover 的时候显示每个工具 icon 的标题
					    	    feature : {
					    	        mark : {                                 // '辅助线开关'
					    	            show: true
					    	        },
					    	        magicType: {                            //动态类型切换
					    	            show: true,
					    	            title:"切换",                       //各个类型的标题文本，可以分别配置。
					    	            type: ['line', 'bar', 'tiled'],              //启用的动态类型，包括'line'（切换为折线图）, 'bar'（切换为柱状图）, 'stack'（切换为堆叠模式）, 'tiled'（切换为平铺模式）
					    	        },
					    	        restore : {                             //配置项还原。
					    	            show: true,                         //是否显示该工具。
					    	            title:"还原",
					    	        },
					    	        saveAsImage : {                         //保存为图片。
					    	            show: true,                         //是否显示该工具。
					    	            type:"png",                         //保存的图片格式。支持 'png' 和 'jpeg'。
					    	            name:"pic1",                        //保存的文件名称，默认使用 title.text 作为名称
					    	            backgroundColor:"#ffffff",        //保存的图片背景色，默认使用 backgroundColor，如果backgroundColor不存在的话会取白色
					    	            title:"保存为图片",
					    	            pixelRatio:1                        //保存图片的分辨率比例，默认跟容器相同大小，如果需要保存更高分辨率的，可以设置为大于 1 的值，例如 2
					    	        }
					    	    },
					    	    zlevel:0,                                   //所属图形的Canvas分层，zlevel 大的 Canvas 会放在 zlevel 小的 Canvas 的上面
					    	    z:2,                                         //所属组件的z分层，z值小的图形会被z值大的图形覆盖
					    	    left:"right",                              //组件离容器左侧的距离,'left', 'center', 'right','20%'
					    	    top:"top",                                   //组件离容器上侧的距离,'top', 'middle', 'bottom','20%'
					    	    right:"auto",                               //组件离容器右侧的距离,'20%'
					    	    bottom:"auto",                              //组件离容器下侧的距离,'20%'
					    	    width:"auto",                               //图例宽度
					    	    height:"auto",                              //图例高度
					    },
					    xAxis: {
					        type: 'category',
					        boundaryGap: false,
					        data: xAxis
					    },
					    yAxis: {
					        type: 'value'
					    },
					    series: msgs
					};

				if (option && typeof option === "object") {
				    myChart.setOption(option, true);
				}
			}
       }

       </script>
   </body>
   </html>