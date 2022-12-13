<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	
<template:include ref="default.simple">
	<template:replace name="head">
		<template:super />

	<script>
			Com_IncludeFile('echarts4.2.1.js','${LUI_ContextPath}/sys/ui/js/chart/echarts/','js',true);
	</script>
	
	<script type="text/javascript" src="<c:url value="/resource/js/jquery.js"/>?s_cache=${LUI_Cache}"></script>
	<script type="text/javascript" src="<c:url value="/sys/ui/js/analysis/transition.js"/>?s_cache=${LUI_Cache}"></script>
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/sys/lbpmmonitor/sys_lbpm_monitor_analysis/css/analysis.css"/>" media="screen" />
	
	</template:replace>
	<template:replace name="body">
	
	<list:criteria channel="channel_common_approve"  expand="false" multi="false">
			    <list:cri-criterion
			title="${lfn:message('sys-lbpmperson:lbpmperson.flow.order.module')}"
			key="fdModelName" multi="false" expand="true">
				<list:box-select>
					<list:item-select>
						<ui:source type="AjaxJson">
								{url:'/sys/lbpmperson/sys_lbpmperson_myprocess/SysLbpmPersonMyProcess.do?method=getModule'}
						</ui:source>
					</list:item-select>
				</list:box-select>
		</list:cri-criterion>
	</list:criteria>
  	
    <!-- 选项卡头部 Starts -->
    <div class="lui-flowMonitor-tabHead">
      <ul class="lui-flowMonitor-tabs">
        <li class="active">
        	<span class="txtlistpath">
				<a href="javascript:backUrl();"><bean:message key="sysLbpmMonitor.analysis.back" bundle="sys-lbpmmonitor" /> > <bean:message key="sysLbpmMonitor.analysis.dealMaxProcess" bundle="sys-lbpmmonitor" /></a>
			</span>
        </li>
      </ul>
    </div>
    <!-- 选项卡头部 Ends -->
    <!-- 选项卡内容 Starts -->
    <div class="lui-flowMonitor-tab-content lui-flowMonitor-tab-content-detail">
      <div class="lui-flowMonitor-tab-pane fade active in" >
        <ul class="lui-flowMonitor-statistics-board">
          <li>
            <div class="magnet">
              <div class="magnet-icon icon-color-1 icon-13"></div>
              <h4 class="magnet-title"><bean:message key="sysLbpmMonitor.analysis.tatalPeopleCount" bundle="sys-lbpmmonitor" /></h4>
              <p class="magnet-subhead" id="total_people_count"></p>
            </div>
          </li>
          <li>
            <div class="magnet">
              <div class="magnet-icon icon-color-2 icon-14"></div>
              <h4 class="magnet-title"><bean:message key="sysLbpmMonitor.analysis.TimeOutMaxProcessCount" bundle="sys-lbpmmonitor" /></h4>
              <p class="magnet-subhead" id="timout_process_count"></p>
            </div>
          </li>
          <li>
            <div class="magnet">
              <div class="magnet-icon icon-color-3 icon-15"></div>
              <h4 class="magnet-title"><bean:message key="sysLbpmMonitor.analysis.dealMaxProcess" bundle="sys-lbpmmonitor" /></h4>
              <p class="magnet-subhead" id="excutTimout_process_count"></p>
            </div>
          </li>
        </ul>
        <ul class="lui-flowMonitor-chartList">
          <li>
            <div class="chart-item"  id="timeOut_process" style="display: block; height: 420px; text-align: center; font-size: 36px;">
            </div>
          </li>
        </ul>
      </div>
    </div>

    <!-- 选项卡内容 Ends -->
	   <script type="text/javascript">
	   function backUrl(){
		   var url='<c:url value="/sys/lbpmmonitor/sys_lbpmmonitor_flow/SysLbpmMonitorFlow.do?method=getMonitorInfo" />';
		   window.location.href=encodeURI(url + "&s_path=${param.s_path}&s_css=default");
	   }
	   
	   setCookie("returnTab","tab-1");//保存选项卡值，返回的时候能跳到相关选项卡
	   seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($ ,dialog, topic) {
		    
		   var url = '<c:url value="/sys/lbpmmonitor/sys_lbpmmonitor_flow/SysLbpmMonitorFlow.do" />';
		   
		 
		 //待办最多的流程
			 var timeOutProcessItem = echarts.init(document.getElementById("timeOut_process"));
			  // 显示标题，图例和空的坐标轴
			 timeOutProcessItem.setOption({
			 	title: {
			 		text: '<bean:message key="sysLbpmMonitor.analysis.dealMaxProcess" bundle="sys-lbpmmonitor" />',
			 		x: 'left',
			 		textStyle:{
			 			color:'#333',
			 			fontSize:16
			 		},
			 		padding:[10,10,40,10]
			 	},
			 	tooltip : {
			 		trigger: 'axis',
			 		axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			 			type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			 		}
			 	},
			 	legend: {
			 		x: 'center',
			 		top:'7%',
			        data: ['<bean:message key="sysLbpmMonitor.analysis.ProcessRuning" bundle="sys-lbpmmonitor" />','<bean:message key="sysLbpmMonitor.analysis.ProcessCompleted" bundle="sys-lbpmmonitor" />']
			    },
			    grid: {
			    	left:10, 
			    	bottom:10,
			        containLabel: true
			    },
			 	toolbox: {
			 		show: true,
			 		feature: {
			 			dataView: {},
			            saveAsImage: {},
			        	restore: {}
			        }
			 	},
			 	yAxis : [
			 		{
			 			 type : 'value',
				 			axisLine:{
				 				symbol:['none', 'arrow'],
				 				symbolSize:[10, 12],
				 				symbolOffset:[0, 0],
				 				lineStyle:{
				 					color:'#C4C6CF'
				 				}
				 			},
					 		splitLine:{
					 			lineStyle:{
					 				color:'#EBECF0',
					 				width:0.9
					 			}
					 		}
			 		}
			 	],
			 	xAxis : {
			 		 type : 'category',
			         data :[],
			         axisLine:{
				 			symbol:['none', 'arrow'],
				 			symbolSize:[10, 12],
				 			symbolOffset:[0, 0],
			 				lineStyle:{
			 					color:'#C4C6CF'
			 				}
				 		},
				 		axisLabel:{
				 			fontFamily:'MicrosoftYaHei',
				 			color:'#000000',
				 			margin:15,
				 			rotate:45,
				 			formatter: function (value, index) {
				 				if(value!=null&&value.length>8){
				 					value=value.substring(0,8)+"...";
				 				}
				 			    return value;
				 			}
				 		}
			 	},
			 	series: [{
			 		 name:'<bean:message key="sysLbpmMonitor.analysis.dealTimeOutProcessNum" bundle="sys-lbpmmonitor" />',
			         type:'bar',
			         barWidth: 20,
			         data:[]
			 	}]
			 });
			 timeOutProcessItem.showLoading(); 
			
			 timeOutProcessItem.on('click', function (param) { 
				   
					// 指定图表的配置项和数据
			       var option = timeOutProcessItem.getOption();
					
					//获取自定义参数Id值
					var fdTempletModelId=option.series[param.seriesIndex].rawdata[param.dataIndex];
					var seriesIndex=param.seriesIndex;
					
					console.log("seriesIndex"+seriesIndex);
					
					var status='20';

					if(seriesIndex==0){//待审状态
						status='20';				
					}

					if(seriesIndex==1){//已结束状态
						status='30';
					}
					
					console.log("status"+status);
			       console.log("sdfsd"+fdTempletModelId);
			       console.log(param);
			       
			       dialog.iframe('/sys/lbpmmonitor/sys_lbpm_monitor_analysis/analysis_list.jsp?fdTempletModelId=' + fdTempletModelId+"&status="+status+"&excuteType=excuteTimeout",
				 			"流程清单", null, {
						width : 960,
						height : 400
					});
			       
			 });
			 
			 
			 postAction(url,"");
		   
			// 监听筛选控件
			topic.channel("channel_common_approve").subscribe('criteria.changed',
					criteriaChange);
			
			 function criteriaChange(data){
				 	
				    console.log(data);
				    
				    var modelName="";
				    if(data.criterions.length!=0){
				    	for(var i=0;i<data.criterions[0].value.length;i++){
					 		modelName+=data.criterions[0].value+";";
					 	}
				    }
				    
				    $("#total_people_count").html("0");
		 			$("#timout_process_count").html("0");
		 			$("#excutTimout_process_count").html("");
		 			
				    postAction(url,modelName);
			 }
			 
			 function postAction(url,modelName){
				 			var param = {
						 		method : "getTimeOutProcessList",
						 		fdModelName:modelName
						 	};
						 	
						 	var xData = [];
						 	var yData = [];
						 	 var zData=[];
						 	 
						 	var xActivatedData = [];
						 	var xCompletedData = [];
						 	
						    $.post(url, param, function(data,status){
						 		//每次接收一个数据

						 	//请求成功
						 	var datamap = data.data;
						 	
						 	for(var i=0;i<datamap.length;i++){
						 		if(i==0){
						 			$("#total_people_count").html(datamap[i].totalPeopleCount);
						 			$("#timout_process_count").html(datamap[i].totalProcessCount);
						 			$("#excutTimout_process_count").html(datamap[i].fdName);
						 		}
						 		xData.unshift(datamap[i].fdName);
						 		yData.unshift(parseInt(datamap[i].processCount));
						 		zData.unshift(datamap[i].fdTemplateModelId);
						 		xActivatedData.unshift(parseInt(datamap[i].activatedCount));
						 		xCompletedData.unshift(parseInt(datamap[i].completedCount));
						 	}
						 	
						 	timeOutProcessItem.hideLoading(); 
						 	
						 	timeOutProcessItem.setOption({        //加载数据图表
						 		 xAxis: {
						             data: xData
						         },
						         toolbox: {
						 			feature: {
						 				dataView: {readOnly: true,
						 					optionToContent: function(opt) {
						 						
						 						var DEFAULT_VERSION = 8.0;  
						 					    var ua = navigator.userAgent.toLowerCase();  
						 					    var isIE = ua.indexOf("msie")>-1;  
						 					    var safariVersion;  
						 					    if(isIE){  
						 					    	safariVersion =  ua.match(/msie ([\d.]+)/)[1];  
						 					    }  
						 					    if(safariVersion <= DEFAULT_VERSION ){  
						 					    	var div$One=$("#timeOut_process").children("div").get(0);
						 							 $(div$One).hide();
						 					    }; 
						 						    
						 						var axisData = opt.xAxis[0].data;
						 						var series = opt.series;
						 						
						 						var table = '<table class="lui_data_form_two" style="width:100%;text-align:center;background-color:#FFFFFF" border><tbody><tr>'
													 + '<td><bean:message key="sysLbpmMonitor.analysis.dealTimeOutTemplateRanking" bundle="sys-lbpmmonitor" /></td>';
													 
												for (var z = 0, l = series.length; z < l; z++) {
													table=table + '<td>' + series[z].name + '</td>';
						 						}
												
												table=table + '</tr>';
										
										
												for (var i = 0, l = axisData.length; i < l; i++) {
													table += '<tr>'
															 + '<td>' + axisData[i] + '</td>';
															 
														for (var j = 0, x = series.length; j < x; j++) {
															table=table + '<td>' +  (series[j].data[i]==null ? "":series[j].data[i]) + '</td>';
								 						}
														
														table=table+ '</tr>';
												}
										
						 						table += '</tbody></table>';
						 						
						 					    
						 						return table;
						 					}
						 				}
						 			}
						 		},
						         // 运行中 #4175FF     已结束 #FFD37D
						         series: [ 
						         {
						             name: '<bean:message key="sysLbpmMonitor.analysis.ProcessRuning" bundle="sys-lbpmmonitor" />',
						             color: ['#4175FF'],
						             type: 'bar',
						             stack: '<bean:message key="sysLbpmMonitor.analysis.ProcessTotal" bundle="sys-lbpmmonitor" />',
						             label: {
						                 normal: {
						                     show: true,
						                     position: 'insideRight',
						                     formatter: function (params) {
					                             if (params.value > 0) {
					                                 return params.value;
					                             } else {
					                                 return '';
					                             }
						                     }
						                 }
						             },
						             data: xActivatedData,
						             rawdata:zData
						         },
						         {
						             name: '<bean:message key="sysLbpmMonitor.analysis.ProcessCompleted" bundle="sys-lbpmmonitor" />',
						             type: 'bar',
						             color: ['#C2C2C2'],
						             stack: '<bean:message key="sysLbpmMonitor.analysis.ProcessTotal" bundle="sys-lbpmmonitor" />',
						             label: {
						                 normal: {
						                     show: true,
						                     position: 'insideRight',
						                     formatter: function (params) {
					                             if (params.value > 0) {
					                                 return params.value;
					                             } else {
					                                 return '';
					                             }
						                     }
						                 }
						             },
						             data: xCompletedData,
						             rawdata:zData
						         }]
						     });
						 },"json");
			 }
	   });
	   

	   </script>
	  
	</template:replace>
</template:include>
