/*******************************************************************************
 * 统计使用js
 ******************************************************************************/
define(function(require, exports, module) {
	var topic = require('lui/topic');
	var dialog = require('lui/dialog');
	var lang = require('lang!sys-task');
	
	 //chart数据加载完事件
	 var EVENT_CHARTDATA_LOADED = "chart.data.loaded";
	 
	 //list数据加载完事件
	 var EVENT_LISTDATA_LOADED = "list.data.loaded";

	 //chart绘制完成事件
	 var EVENT_CHART_LOADED = "chart.loaded";
	 
	 //chart转换后的列表点击事件
	 var EVENT_LIST_CLICK = "list.click";
	 
	 //chart和列表切换事件
	 var EVENT_CHART_SWITCH = "chart.switch";
	 
	 var stat = {
			 /******************************************
			 * 入口函数：执行查询
			 *****************************************/
			 exportExcel:function(){
				var url = Com_SetUrlParameter(location.href, "method", "exportExcel");
				var data = this._getConditionData();
				var formObj = $('#__exportFrom');
				if(formObj.length <=0){
					formObj = $("<form id='__exportFrom' method='POST' target='_self'></form>");
					$(document.body).append(formObj);
				}
				formObj.attr("action", url);
				formObj.html('');
				for (var key in data) {
					$("<input type='hidden'/>").attr("name",key).val(data[key]).appendTo(formObj);
				}
				formObj.submit();
					
		 	},
			 
			statExecutor:function(type){
				if(!type){
					type='chart';
				}
		 		var self = this;
				if(window.statValidation!=null){
					if(!statValidation.validate())
						return ;
				}
				var url = Com_SetUrlParameter(location.href, "method", "statChart");
				
				//加载图标数据
				LUI('sysTaskStatChart').replaceDataSource({
					"type":"AjaxJson",
					"commitType":"post",
					"params":this._getConditionData(),
					"url":url
				});
				$("#div_chartArea").show();
				
				//加载list数据
				var _self = this;
				topic.subscribe("chart.loaded",function(rtnData){ //报表图形绘制完后执行
					
					var xxx;
					var url=Com_SetUrlParameter(location.href, "method", "getOriginalData");
					$.post(url, $.param(_self._getConditionData(), true), function(contextData) {
						if(contextData!=null){
							xxx = contextData;
						}
					}, 'json');
					
					var statusJson;
					var url=Com_SetUrlParameter(location.href, "method", "getStatusTypeData");
					$.post(url, $.param(_self._getConditionData(), true), function(statusData) {
						if(statusData!=null){
							statusJson = statusData;
						}
					}, 'json');
					
					var xData = rtnData.contextData.xAxis[0];
					var allParam = self._getConditionData();
					rtnData.chart.on("click", function(param) {
						var key = xData.data[param.dataIndex];
						var fdId = allParam['fdId'];
						var extParamValue = xxx[key];
						var statusType = statusJson[param.seriesIndex];
						if (allParam.fdAnalyzeType == "2") {
							if (param.seriesIndex != statusJson.total) {
								statusType = statusType.fdId;
							}
						}
						if (allParam.fdAnalyzeType == "4") {
							if (param.seriesIndex != "0") {
								statusType = statusType.fdId;
							}
						}
						var detailSrc = Com_GetCurDnsHost() + Com_Parameter.ContextPath+"/sys/task/sys_task_ui/sysTaskMain_analyze_list.jsp?method=listByDept&fdId="+fdId+"&orgName="+encodeURIComponent(key)+"&statusType="+statusType;
						detailSrc += "&extParam="+extParamValue;
						$("#div_detail").show();
						$("#iframe_Detail").attr("src", detailSrc);
						$("#iframe_Detail").load(function(){
							$('html, body').animate({
					            scrollTop: $("#div_detail").offset().top
					        }, 1500);
							setTimeout("$('html, body').stop();",1000);
						});
					});
				},null);
				
				//显示图标还是列表
				if(type=='chart'){
					$("#div_listSection").hide();
				}else{
					$("#div_listSection").show();
					$("#div_chartSection").hide();
				}
				
	 		},
	 		//excel导出
	 		exportExcel:function(){
				var url = Com_SetUrlParameter(location.href, "method", "exportExcel");
				var data = this._getConditionData();
				var formObj = $('#__exportFrom');
				if(formObj.length <=0){
					formObj = $("<form id='__exportFrom' method='POST' target='_self'></form>");
					$(document.body).append(formObj);
				}
				formObj.attr("action", url);
				formObj.html('');
				for (var key in data) {
					$("<input type='hidden'/>").attr("name",key).val(data[key]).appendTo(formObj);
				}
				formObj.submit();
	 		},
	 		//条件参数
	 		_getConditionData:function(){
	 			var data = {};
				$("#div_condtionSection").find(":input").each( function() {
					var thisObj = $(this);
					var name = thisObj.attr("name");
					if (name != null && name != '') {
						if (thisObj.is(":radio")) {
							if (thisObj.is(":checked")) {
								data[name] = thisObj.val();
							}
						} else if (thisObj.is(":checkbox")) {
							if (thisObj.is(":checked")) {
								var oldVal = data[name];
								if (oldVal == null) {
									data[name] = thisObj.val();
								} else {
									data[name] = oldVal + ";" + thisObj.val();
								}
							}
						} else {
							data[name] = thisObj.val();
						}
					}
				});
				return data;
	 		},
	 		statSwitchStaues:false,
	 		 /******************************************
			  * 显示图表
			  *****************************************/
	 		showChart:function(chartDiv,contextData){
	 			
	 		},
	 		 /******************************************
			  * 显示列表
			  *****************************************/
	 		showList:function(listDiv,result){
	 			alert();
	 			var fileds=result.fileds,datas=result.datas;
	 			var _self = this; 
	 			listDiv.html('');
	 			var content = "<span>" + lang['sysTaskAnalyze.chart.noData'] + "</span>";
	 			if(datas!=null && datas.length>0){
	 				content = $('<table class="tab_listData"></table>');
	 				var titleTr = $('<tr class="tab_title"/>');
	 				$('<th>' + lang['sysTaskAnalyze.chart.serial'] + '</th>').appendTo(titleTr);
	 				for(var key in fileds){
	 					var field = fileds[key];
	 					$('<th>'+field+'</th>').appendTo(titleTr);
	 				}
	 				titleTr.appendTo(content);
	 				for ( var i = 0; i < datas.length; i++) {
	 					var tempData = datas[i];
						var dataTr = $('<tr class="tab_data" index="'+i+'"/>');
						$('<td>'+(i+1)+'</td>').appendTo(dataTr);
						for(var key in fileds){
							field = fileds[key];
							$('<td></td>').text(tempData[key]).appendTo(dataTr);
						}
						dataTr.click(function(domObj){
							var thisObj = $(this);
							topic.publish(EVENT_LIST_CLICK,{target:thisObj,data:datas[thisObj.attr("index")]});
						});
						dataTr.appendTo(content);
					}
	 			}
	 			if($("#div_listSection").length>0){
		 			listDiv.append(content).append($("<div class='div_close com_btn_link'>"+lang['sysTaskAnalyze.chart.return']+"</div>").click(function(){
		 				_self.switchChart("0");
		 			}));
	 			}else{
	 				listDiv.append(content);
	 			}
	 		},
	 		/******************************************
			  * 图标和列表切换
			  *****************************************/
	 		switchChart:function(isTable){
	 			if(isTable=="1"){//当前状态显示图标
	 				$("#div_chartSection").hide();
	 				$("#div_listSection").show();
	 			}else{
	 				$("#div_listSection").hide();
	 				$("#div_chartSection").show();
	 			}
	 			topic.publish(EVENT_CHART_SWITCH);
	 		},
	 		 /******************************************
			  * 显示列表详情
			  *****************************************/
	 		listDetail:function(){
	 			var url = Com_SetUrlParameter(location.href, "method", "statListDetail");
	 			$.post(url, $.param(this._getConditionData(), true), function(result) {
					if(result!=null){
						var fileds=result.fileds,datas=result.datas;
			 			var _self = this; 
			 			$('#div_list').html('');
			 			var content = "<span>" + lang['sysTaskAnalyze.chart.noData'] + "</span>";
			 			if(datas!=null && datas.length>0){
			 				content = $('<table class="tab_listData"></table>');
			 				var titleTr = $('<tr class="tab_title"/>');
			 				$('<th>' + lang['sysTaskAnalyze.chart.serial'] + '</th>').appendTo(titleTr);
			 				for(var key in fileds){
			 					var field = fileds[key];
			 					$('<th>'+field+'</th>').appendTo(titleTr);
			 				}
			 				titleTr.appendTo(content);
			 				for ( var i = 0; i < datas.length; i++) {
			 					var tempData = datas[i];
								var dataTr = $('<tr class="tab_data" index="'+i+'"/>');
								$('<td>'+(i+1)+'</td>').appendTo(dataTr);
								for(var key in fileds){
									field = fileds[key];
									$('<td>'+tempData[key]+'</td>').appendTo(dataTr);
								}
								dataTr.click(function(){
									var thisObj=$(this);
									if(datas[thisObj.attr("index")].url){
										window.open(Com_GetCurDnsHost() + Com_Parameter.ContextPath+datas[thisObj.attr("index")].url,"_blank");
									}
								});
								dataTr.appendTo(content);
							}
			 			}
			 			$("#div_chartArea").show();
			 			$('#div_list').append(content).append($("<div class='div_close com_btn_link'>"+lang['sysTaskAnalyze.chart.return']+"</div>").click(function(){
			 				var url = Com_SetUrlParameter(location.href, "listDetail", "");
			 				url = Com_SetUrlParameter(url, "type", "list");
			 				window.open(url,"_self");
			 			}));
			 			if(datas!=null && datas.length>0){
			 				var page = {
					 				"currentPage" : result.page.pageno,
									"pageSize" : result.page.rowsize,
									"totalSize" : result.page.totalrows
								};
					 			topic.publish("list.changed", {"page":page});
			 			}
					}
				}, 'json');
	 		},
	 		expandDiv:function(thisObj,sectionId){
	 			var expObj = $("#" + sectionId);
	 			var isShow = expObj.attr("isShow");
	 			if( isShow==null || isShow=="1"){
	 				isShow = "1";
	 			}else{
	 				isShow = "0";
	 			}
	 			var iconSpan = $(thisObj).find("span");
	 			iconSpan.removeAttr("class");
	 			if(isShow=="1"){//当前状态显示图标
	 				expObj.attr("isShow","0");
	 				expObj.hide();
	 				iconSpan.addClass("div_icon_coll");
	 			}else{
	 				expObj.attr("isShow","1");
	 				expObj.show();
	 				iconSpan.addClass("div_icon_exp");
	 			}
	 			
	 		}
	 };
	 /*****************************************
	  *  对外使用
	 *****************************************/
	 module.exports = stat;
});
