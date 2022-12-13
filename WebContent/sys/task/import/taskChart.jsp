<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script>
		var data_array;
		var map;
		var initSize = 1;
		var mapsW = 0;
		var mapsH = 500;
		//获取组织表的Ajax
		function GetOrgChartAjax(fdId,url,showSize){
			seajs.use(['lui/dialog','lui/util/env'], function(dialog,env){
				window.del_load = dialog.loading();
				
				$.ajax({
			    	type: "post",
			        url: url,
			        dataType: "json",
					async : true,
			        data: { fdId: fdId },
			        success: function (data) {
			            if (data != null && data.d != null) {
			                if (data.d != "") {
				                $("#task").html('');
				                $("#person").html('');
				                $("#weights").html('');
				                $("#main").html('');
				                $("#select_Arrow").html('');
			                    var html = "";
			                    data_array = data.d;
			                    //定义第一级组织ID
			                    var firsttaskID = "";
			                    //定义第一级组织Text
			                    var firsttaskText = "";
			                    for (var i = 0; i < data_array.length; i++) {
			                    	var record = data_array[i];
			                    	record.taskName=env.fn.formatText(record.taskName);
			                    }
			                    for (var i = 0; i < data_array.length; i++) {

			                        if (data_array[i].ParenttaskID == "" || data_array[i].ParenttaskID == undefined || data_array[i].ParenttaskID == null) {
			                            firsttaskID = data_array[i].taskID;
			                            firsttaskText = data_array[i].taskName;
			                            break;
			                        }
			                        else{
			                       
			                         var headNode= FindHeadNode(data_array);

			                         if( headNode!=null && typeof( headNode)!=undefined){
			       
			                             firsttaskID = headNode.taskID;
			                             firsttaskText = headNode.taskName;
			                             break;
			                            }
			                      }
			                    }
			                   
			                    taskhtml = setDiv(data_array, firsttaskID, firsttaskText);
			                    personhtml = setPersonDiv(data_array, firsttaskID, firsttaskText);
			                    weightshtml = setWeightsDiv(data_array, firsttaskID, firsttaskText);

			                    //查找出层级最多的组织链(页面展示的时候要用到下拉框中)
			                    var depthVal = 0;
			                    for (var i = 0; i < data_array.length; i++) {
			                        if (data_array[i].depth != "" && data_array[i].depth != undefined && data_array[i].depth != null) {
			                            if (data_array[i].depth > depthVal) {
			                                depthVal = data_array[i].depth;
			                            }
			                        }
			                    }

			                    //往下拉框中填值
			                    for (var depthv = 1; depthv <= depthVal; depthv++) {
			                        if (depthv <= 4) {
			                            $("#select_Arrow").append('<option value="' + depthv + '">' + depthv + '</option>');
			                        }
			                        if (depthv == depthVal) {
			                            $("#select_Arrow").append('<option value="' + depthv + '">' + '<bean:message bundle="sys-task" key = "sysTask.taskChart.expandAll"/>' + '</option>');
			                        }
			                    }

			                    //默认展开3级
			                    if (depthVal >= 3) {
			                        $("#select_Arrow").val("3");
			                    }else if (depthVal == 2) {
			                        $("#select_Arrow").val("2");
			                    }else{
			                    	$("#select_Arrow").val("1");
			                    }
			                    
			                    //设置画布的高度和宽度(需计算，宽度根据子节点计算，高度根据层级计算)
			                    mapsH = depthv * 136;
			                    var showLevel;
			                    if (depthVal >= 3) {
			                        showLevel=3;
			                    }else if (depthVal == 2) {
			                        showLevel=2;
			                    }else{
			                        showLevel=1;
			                    }

			                    //往organisation中加实际内容
			                    $("#task").append(taskhtml);
			                    $("#person").append(personhtml);
			                    $("#weights").append(weightshtml);
			                    
			                    try {
			                    	 $("#task").orgChart({ container: $("#main"), depth: depthVal, interactive: true, fade: true, speed: 'fast', showLevels: showLevel });
								} catch (e) {
									setTimeout(function(){
										 $("#task").orgChart({ container: $("#main"), depth: depthVal, interactive: true, fade: true, speed: 'fast', showLevels: showLevel });
									},100);
								}
			                   
			                    
			                    
			                    var w = document.body.clientWidth;
			                    var fdPageMaxWidth ="${fdPageMaxWidth}";
			                    var width = w*0.88;
			                    if(width > fdPageMaxWidth){
			                    	width = fdPageMaxWidth;
			                    }
			                    
			                    setWHnone();
			                    
			                    if(showSize){
			                    	initSize = showSize;
			                    	 $("#main").css("transform", "scale(" + showSize + ")");
			                    }
			                    if($("#lefttask").width() > width){
			                    	 $('#worldMap').animate({
					        		        scrollLeft: (($("#lefttask").width()*showSize))*0.15
					        		    }, 800);
			                    	 $("#main").css("transform-origin", "0 10%");
			                    }else{
			                    	 $("#main").css("transform-origin", "50% 10%");
			                    }
			                   
			                    $("#main").css("transition", "all 0.1s ease-in-out");
			                   

			        			seajs.use(['lui/dialog'], function(dialog){
				                    if(window.del_load!=null){
										window.del_load.hide();
									}
			        			});
			                }
			            }
			        },
			        error: function (err) {
			            return;
			        }
			    })
			});
			

		}

		function changeLevel(obj){
		    //查找出层级最多的组织链(页面展示的时候要用到下拉框中)
		    var depthValMax = 0;
		    for (var i = 0; i < data_array.length; i++) {
		        if (data_array[i].depth != "" && data_array[i].depth != undefined && data_array[i].depth != null) {
		            if (data_array[i].depth > depthValMax) {
		                depthValMax = data_array[i].depth;
		            }
		        }
		    }

		    var depthVal = obj.value;
		    var select_type = getShowType();
		    var mapsWl = 0;
		    if (depthVal > 0) {
		        setWH(depthVal, mapsWl);
		        var chartClass = "orgChart";
		        if(select_type == 'person'){
		        	 chartClass = "orgChart person_type";
		        }
		        if(select_type == 'weights'){
		        	 chartClass = "orgChart weights_type";
		        }
		        try {
		        	 $("#"+select_type).orgChart({ container: $("#main"),chartClass:chartClass, depth: depthValMax, interactive: true, fade: true, speed: 'fast', showLevels: depthVal });
				} catch (e) {
					setTimeout(function(){
						 $("#"+select_type).orgChart({ container: $("#main"),chartClass:chartClass, depth: depthValMax, interactive: true, fade: true, speed: 'fast', showLevels: depthVal });
					},100);
				}
		       
		        setWHnone();
		    }
			if(window.del_load!=null){
				window.del_load.hide(); 
			}
		}
		
		function getShowDepth(){
			return $('#select_Arrow').val();
		}
		
		function getShowType(){
			return $('#select_type').val();
		}

		function changeType(obj){
		    //查找出层级最多的组织链(页面展示的时候要用到下拉框中)
		    var depthValMax = 0;
		    for (var i = 0; i < data_array.length; i++) {
		        if (data_array[i].depth != "" && data_array[i].depth != undefined && data_array[i].depth != null) {
		            if (data_array[i].depth > depthValMax) {
		                depthValMax = data_array[i].depth;
		            }
		        }
		    }

		    var depthVal = getShowDepth();
		    var mapsWl = 0;
		    if (depthVal > 0) {
		        setWH(depthVal, mapsWl);
		        var chartClass = "orgChart";
		        if(obj.value == 'person'){
		        	 chartClass = "orgChart person_type";
		        }
		        if(obj.value == 'weights'){
		        	 chartClass = "orgChart weights_type";
		        }
		        $("#"+obj.value).orgChart({ container: $("#main"), chartClass:chartClass, depth: depthValMax, interactive: true, fade: true, speed: 'fast', showLevels: depthVal });
		       
		        setWHnone();
		    }
			if(window.del_load!=null){
				window.del_load.hide(); 
			}
		}

		//展示层级改变事件
		function selectChange(obj) {
			seajs.use(['lui/dialog'], function(dialog){
				window.del_load = dialog.loading();
				setTimeout(function(){changeLevel(obj)}, 100);
			});
		}

		function swapProcess(obj) {
			seajs.use(['lui/dialog'], function(dialog){
				window.del_load = dialog.loading();
				setTimeout(function(){changeType(obj)}, 100);
			});
		}

		//获取当前数据中顶级节点信息
		function FindHeadNode(dtArr){
		    var headNode = true;
		    var rtnArr;
		    for (var i = 0; i < dtArr.length; i++) {

		        for (var j = 0; j < dtArr.length; j++) {

		            if (dtArr[i].ParenttaskID == dtArr[j].taskID) {
		                headNode = false;
		            }
		        }
		        if (headNode) {
		            rtnArr = dtArr[i];
		            break;
		        }
		    }
		    return rtnArr;
		}


		//遍历绘制页面内容区域
		function setDiv(dt, NodeID, NodeText) {
		    //添加本级节点
		    var html = "";
		    html += "<li>";
		    //添加本级节点的展示信息
		    html += DrawDiv(dt, NodeID);
		    //判断本级节点的下一级，如果有内容，也要添加上去
		    var isHaveChild = false;
		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].ParenttaskID == NodeID) {
		            isHaveChild = true;
		            break;
		        }
		    }
		    if (isHaveChild == true) {
		        html += "<ul>";
		    }
		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].ParenttaskID == NodeID) {
		            html += setDiv(dt, dt[i].taskID, dt[i].taskName);
		        }
		    }
		    if (isHaveChild == true) {
		        html += "</ul>";
		    }
		    //本级节点结束
		    html += "</li>";
		    return html;
		}

		//遍历绘制页面内容区域
		function setPersonDiv(dt, NodeID, NodeText) {
		    //添加本级节点
		    var html = "";
		    html += "<li>";
		    //添加本级节点的展示信息
		    html += DrawPersonDiv(dt, NodeID);
		    //判断本级节点的下一级，如果有内容，也要添加上去
		    var isHaveChild = false;
		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].ParenttaskID == NodeID) {
		            isHaveChild = true;
		            break;
		        }
		    }
		    if (isHaveChild == true) {
		        html += "<ul>";
		    }
		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].ParenttaskID == NodeID) {
		            html += setPersonDiv(dt, dt[i].taskID, dt[i].taskName);
		        }
		    }
		    if (isHaveChild == true) {
		        html += "</ul>";
		    }
		    //本级节点结束
		    html += "</li>";
		    return html;
		}
		
		//遍历绘制页面内容区域
		function setWeightsDiv(dt, NodeID, NodeText) {
		    //添加本级节点
		    var html = "";
		    html += "<li>";
		    //添加本级节点的展示信息
		    html += DrawWeightsDiv(dt, NodeID);
		    //判断本级节点的下一级，如果有内容，也要添加上去
		    var isHaveChild = false;
		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].ParenttaskID == NodeID) {
		            isHaveChild = true;
		            break;
		        }
		    }
		    if (isHaveChild == true) {
		        html += "<ul>";
		    }
		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].ParenttaskID == NodeID) {
		            html += setWeightsDiv(dt, dt[i].taskID, dt[i].taskName);
		        }
		    }
		    if (isHaveChild == true) {
		        html += "</ul>";
		    }
		    //本级节点结束
		    html += "</li>";
		    return html;
		}
		
		//绘制单一的DIV
		function DrawDiv(dt, NodeID) {
		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].taskID == NodeID) {
		        	var selectedClassName = "";
		        	if(dt[i].taskID == "${param.fdId}"){
		        		selectedClassName = "selected"
		        	}
		            var h = '<div id="div_' + dt[i].taskID + '" class="taskDiv divShowD  '+selectedClassName+'"> ';
		            	h +='<div  data-info="'+ dt[i].dataInfo+'" onclick="openTask(\''+dt[i].taskID+'\');" onmouseover="showInfo(this,\''+dt[i].taskID+'\');" onmouseout="hideInfo(\''+dt[i].taskID+'\');">';
		            	
		            	h +='<div class="taskLeftArea">';
		            	var curUserId = Com_Parameter.CurrentUserId;
		            	if(dt[i].performId.indexOf(curUserId) > -1){
		            		h +='<div class="taskName" style="font-weight: bold;">';
			            	h += dt[i].taskName;
			            	h +='</div>';
			            	h +='<div class="taskPerson" style="font-weight: bold;">';
			            	h += '<bean:message bundle="sys-task" key = "sysTaskMain.principal"/>: '+HTMLEncode(dt[i].performName);
			            	h +='</div>';
		            	}else{
		            		h +='<div class="taskName">';
			            	h += dt[i].taskName;
			            	h +='</div>';
			            	h +='<div class="taskPerson">';
			            	h += '<bean:message bundle="sys-task" key = "sysTaskMain.principal"/>: '+HTMLEncode(dt[i].performName);
			            	h +='</div>';
		            	}
		            	h +='</div>';
		            	
		            	h +='<div class="taskRightArea">';
		            	h +='<div class="taskStatus">';
		            	h += "<img  src='${ KMSS_Parameter_ContextPath}sys/task/images/STATUS_"+dt[i].status+".png'/>";
		            	h +='</div>';
		            	h +='<div class="taskProgress">';
		            	h += dt[i].progress;
		            	h +='</div>';
		            	h +='</div>';
		            	h +='</div>';
		            	if (dt[i].ChildCount > 0) {
			            	h +="<div class='optExpand'>";
			            	h += "<img width='10px' height='10px' id='arrowImg_" + dt[i].taskID + "' src='${ KMSS_Parameter_ContextPath}sys/task/images/arrowOpen.png'/> ";
			            	h +='</div>';
		                }
		            	h +='</div>';
		            return h;
		          
		        }
		    }
		    return "";
		}
		
		//2.JS转义HTML
		function HTMLEncode(html) {
		    var temp = document.createElement("div");
		    (temp.textContent != null) ? (temp.textContent = html) : (temp.innerText = html);
		    var output = temp.innerHTML;
		    temp = null;
		    return output;
		}
		//3.JS反转义HTML
		function HTMLDecode(text) { 
		    var temp = document.createElement("div"); 
		    temp.innerHTML = text; 
		    var output = temp.innerText || temp.textContent; 
		    temp = null; 
		    return output; 
		} 
		

		//绘制单一的DIV
		function DrawPersonDiv(dt, NodeID) {

		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].taskID == NodeID) {
		        	var selectedClassName = "";
		        	if(dt[i].taskID == "${param.fdId}"){
		        		selectedClassName = "selected"
		        	}
		        	 var h = '<div id="div_' + dt[i].taskID + '" class="personDiv divShowD '+selectedClassName+'"> ';
		            	h +='<div data-info="'+ dt[i].dataInfo+'" onclick="openTask(\''+dt[i].taskID+'\');"  onmouseover="showInfo(this,\''+dt[i].taskID+'\');" onmouseout="hideInfo(\''+dt[i].taskID+'\');">';
		            	h +='<div class="taskLeftArea">';
		            	h +='<div class="taskHead">';
		            	h += "<img src='" + dt[i].headImgUrl + "' />";
		            	h +='</div>';
		            	if( dt[i].otherName){
			            	h +='<div class="taskPersonName">';
			            	h +='<span class="firstPersonName">';
			            	h += dt[i].firstName;
			            	h +='</span>';
			            	h +='<span class="otherPersonName">';
			            	h += dt[i].otherName;
			            	h +='</span>';
			            	h +='</div>';
		            	}else{
		            		h +='<div class="taskPersonName single">';
			            	h +='<span class="firstPersonName">';
			            	h += dt[i].firstName;
			            	h +='</span>';
			            	h +='</div>';
		            	}
		            	//h += dt[i].performName;
		            	
		            	h +='</div>';
		            	h +='<div class="taskRightArea">';
		            	h +='<div class="taskStatus">';
		            	h += "<img  src='${ KMSS_Parameter_ContextPath}sys/task/images/STATUS_"+dt[i].status+".png'/>";
		            	h +='</div>';
		            	h +='<div class="taskProgress">';
		            	h += dt[i].progress;
		            	h +='</div>';
		            	h +='</div>';
		            	h +='</div>';
		            	if (dt[i].ChildCount > 0) {
			            	h +='<div class="optExpand">';
			            	h += "<img width='10px' height='10px' id='arrowImg_" + dt[i].taskID + "'  src='${ KMSS_Parameter_ContextPath}sys/task/images/arrowOpen.png'/> ";
			            	h +='</div>';
		            	}
		            	h +='</div>';
		            return h;
		        }
		    }
		    return "";
		}
		
		//权重分解图
		//绘制单一的DIV
		function DrawWeightsDiv(dt, NodeID) {
		    for (var i = 0; i < dt.length; i++) {
		        if (dt[i].taskID == NodeID) {
		        	var selectedClassName = "";
		        	if(dt[i].taskID == "${param.fdId}"){
		        		selectedClassName = "selected"
		        	}
		            var h = '<div id="div_' + dt[i].taskID + '" class="weightsDiv divShowD  '+selectedClassName+'"> ';
		            	h +='<div  data-info="'+ dt[i].dataInfo+'" onclick="openTask(\''+dt[i].taskID+'\');" onmouseover="showInfo(this,\''+dt[i].taskID+'\');" onmouseout="hideInfo(\''+dt[i].taskID+'\');">';
		            	
		            	h +='<div class="taskLeftArea">';
		            	var curUserId = Com_Parameter.CurrentUserId;
		            	if(dt[i].performId.indexOf(curUserId) > -1){
		            		h +='<div class="taskName" style="font-weight: bold;">';
			            	h += dt[i].taskName;
			            	h +='</div>';
			            	if (dt[i].weight) {
			            		h +='<div class="taskPerson" style="font-weight: bold;">';
				            	h += '<bean:message bundle="sys-task" key = "sysTaskMain.fdWeights"/>: '+dt[i].weight;
				            	h +='</div>';
							}
		            	}else{
		            		h +='<div class="taskName">';
			            	h += dt[i].taskName;
			            	h +='</div>';
			            	if (dt[i].weight) {
			            		h +='<div class="taskPerson">';
				            	h += '<bean:message bundle="sys-task" key = "sysTaskMain.fdWeights"/>: '+dt[i].weight;
				            	h +='</div>';
			            	}
		            	}
		            	h +='</div>';
		            	
		            	h +='<div class="taskRightArea">';
		            	h +='<div class="taskStatus">';
		            	h += "<img  src='${ KMSS_Parameter_ContextPath}sys/task/images/STATUS_"+dt[i].status+".png'/>";
		            	h +='</div>';
		            	h +='<div class="taskProgress">';
		            	h += dt[i].progress;
		            	h +='</div>';
		            	h +='</div>';
		            	h +='</div>';
		            	if (dt[i].ChildCount > 0) {
			            	h +="<div class='optExpand'>";
			            	h += "<img width='10px' height='10px' id='arrowImg_" + dt[i].taskID + "' src='${ KMSS_Parameter_ContextPath}sys/task/images/arrowOpen.png'/> ";
			            	h +='</div>';
		                }
		            	h +='</div>';
		            return h;
		          
		        }
		    }
		    return "";
		}

		//重置高度宽度
		function setWH(depthVal, mapsWl) {
		    if (depthVal > 0) {
		        for (var i = 0; i < data_array.length; i++) {
		            if (data_array[i].depth < depthVal) {
		                if (data_array[i].ChildCount === 0) {
		                    mapsWl += 260;
		                }
		            }
		            else if (data_array[i].depth == depthVal) {
		                mapsWl += 260;
		            }
		        }
				if(lefttask) {
					lefttask.style.width = mapsWl.toString() + 'px';
				}
				if(leftperson) {
					leftperson.style.width = mapsWl.toString() + 'px';
				}
				if(leftweights) {
					leftweights.style.width = mapsWl.toString() + 'px';
				}
		    }
		    mapsW=mapsWl;
		}

		var hiddenChildNodeIDs = "";

		function setWHnone(id) {
		    //如果页面变窄，则用下面这个
		    hiddenChildNodeIDs = "";
		    $(".divShowD").each(function (e) {
		        var a = this;
		        if (a.parentElement != undefined && a.parentElement.parentElement != undefined && a.parentElement.parentElement.className.indexOf("hasChildren hiddenChildren") > -1 && a.id != undefined && a.id != null) {
		            hiddenChildNodeIDs += a.id.toString() + ",";
		        }
		    })

		    //如果点击的是把当前节点隐藏掉,则需要加上当前的节点
		    if (id != undefined && id != null) {
		        hiddenChildNodeIDs += id.toString();
		    }

		    //获得叶节点数
		    var showNodes = setWordWidth("");

		    //获得层级
		    showDepthVal = 0;
		    setWordHeight("");
		    //宽度变化、高度变化
			if(lefttask){
				lefttask.style.height = (showDepthVal * 136 * initSize + 20).toString() + 'px';
				lefttask.style.width = (260 * showNodes * initSize + 20).toString() + 'px';
			}
		    if(leftperson){
				leftperson.style.height = (showDepthVal * 136 * initSize + 20).toString() + 'px';
				leftperson.style.width = (260 * showNodes * initSize + 20).toString() + 'px';
			}
		    if(leftweights){
				leftweights.style.height = (showDepthVal * 136 * initSize + 20).toString() + 'px';
				leftweights.style.width = (260 * showNodes * initSize + 20).toString() + 'px';
			}
		}

		//重新计算页面宽度
		function setWordWidth(partentNodeID) {
		    var NodeCount = 0;
		    //判断本级节点,如果本级节点没有下级节点，或者本级节点的下级全隐藏了，则返回本级节点

		    if(partentNodeID==""){
		    var headNode= FindHeadNode(data_array);
		    if(headNode!=null && typeof( headNode)!=undefined){
		    		partentNodeID=headNode.ParenttaskID;
		       }
		     }
		    for (var i = 0; i < data_array.length; i++) {
		        //找到当前节点
		        if (data_array[i].ParenttaskID != undefined && data_array[i].ParenttaskID != null && data_array[i].ParenttaskID == partentNodeID) {
		            //如果当前子节点为0
		            if (data_array[i].ChildCount == 0) {
		                //如果当前节点没有隐藏
		                if (("," + hiddenChildNodeIDs + ",").indexOf(",div_" + data_array[i].taskID.toString() + ",") < 0) {
		                    NodeCount += 1;
		                }
		            }
		            //如果当前子节点不为0
		            else {
		                //如果当前子节点隐藏
		                if (("," + hiddenChildNodeIDs + ",").indexOf(",div_" + data_array[i].taskID.toString() + ",") > -1) {
		                    NodeCount += 1;
		                }
		                //如果当前子节点不隐藏
		                else {
		                    NodeCount += setWordWidth(data_array[i].taskID);
		                }
		            }
		        }
		    }
		    return NodeCount;
		}

		//页面显示的高度
		var showDepthVal = 0;

		//计算页面的显示的最高高度
		function setWordHeight(partentNodeID) {
		    if (partentNodeID == "") {
		        var headNode = FindHeadNode(data_array);
		        if (headNode != null && typeof(headNode) != undefined) {
		            partentNodeID = headNode.ParenttaskID;
		        }
		    }
		    //判断本级节点,如果本级节点没有下级节点，或者本级节点的下级全隐藏了，则返回本级节点
		    for (var i = 0; i < data_array.length; i++) {
		        //找到当前节点
		        if (data_array[i].ParenttaskID != undefined && data_array[i].ParenttaskID != null && data_array[i].ParenttaskID == partentNodeID) {
		            //如果当前子节点为0
		            if (data_array[i].ChildCount == 0) {
		                //如果当前节点没有隐藏
		                if (("," + hiddenChildNodeIDs + ",").indexOf(",div_" + data_array[i].taskID.toString() + ",") < 0) {
		                    //如果当前节点的层级大于已计算的层级
		                    if (data_array[i].depth > showDepthVal) {
		                        showDepthVal = data_array[i].depth;
		                    }
		                }
		            }
		            //如果当前子节点不为0
		            else {
		                //如果当前子节点隐藏
		                if (("," + hiddenChildNodeIDs + ",").indexOf(",div_" + data_array[i].taskID.toString() + ",") > -1) {
		                    if (data_array[i].depth > showDepthVal) {
		                        showDepthVal = data_array[i].depth;
		                    }
		                }
		                //如果当前子节点不隐藏
		                else {
		                    setWordHeight(data_array[i].taskID);
		                }
		            }
		        }
		    }
		}

		//放大
		function ShowBig() {
		    initSize = initSize + 0.1;
		    if (initSize > 1.6) {
		        initSize = 1.6;
		    }
		    $("#main").css("transition", "all 0.2s ease-in-out");
		    $("#main").css("transform", "scale(" + initSize + ")");
		    $("#main").css("transform-origin", "0 0");
		    if (initSize >= 1) {
		    	if(lefttask){
					lefttask.style.width = (mapsW * initSize).toString() + 'px';
				}
				if(leftperson) {
					leftperson.style.width = (mapsW * initSize).toString() + 'px';
				}
				if(leftweights){
					leftweights.style.width = (mapsW * initSize).toString() + 'px';
				}
		    }
		    setWHnone();
		}
		//缩小
		function ShowSmall() {
		    initSize = initSize - 0.1;
		    if (initSize < 0.4) {
		        initSize = 0.4;
		    }
		    $("#main").css("transition", "all 0.2s ease-in-out");
		    $("#main").css("transform", "scale(" + initSize + ")");
		    $("#main").css("transform-origin", "0 0");
		    if (initSize <= 1) {
		    	if(lefttask){
					lefttask.style.width = (mapsW * initSize).toString() + 'px';
				}
		        if(leftperson){
					leftperson.style.width = (mapsW * initSize).toString() + 'px';
				}
				if(leftperson) {
					leftweights.style.width = (mapsW * initSize).toString() + 'px';
				}
		    }
		    setWHnone();
		}


		function openTask(taskId){
			var url = Com_Parameter.ContextPath +'sys/task/sys_task_main/sysTaskMain.do?method=view&fdId='+taskId;
			if(window.authCheck) {
				window.authCheck(taskId, function(isOk){
					if(isOk) {
						if(window.openTaskUrl) {
							url = window.openTaskUrl + taskId;
						}
						Com_OpenWindow(url);
					}
				});
			} else {
				if(window.openTaskUrl) {
					url = window.openTaskUrl + taskId;
				}
				Com_OpenWindow(url);
			}
		}
		function ____formatText(str){
			if (str == null || str.length == 0)
				return "";
		 	return str.replace(/&/g, "&amp;")
						.replace(/</g, "&lt;")
						.replace(/>/g, "&gt;")
						.replace(/ /g, "&nbsp;")
						.replace(/\'/g,"&#39;")
						.replace(/\"/g, "&quot;")
						.replace(/\n/g, "<br>");
		}

		function hideInfo(id){
			if($('#'+id)){
				$('#'+id).remove();
			}
		}

		function showInfo(obj,id){
			var aa = $(obj).attr("data-info");
			var xx = aa.split("#");
			var str="";
			if(xx[0]){ // 任务名称
				str += '<bean:message bundle="sys-task" key = "sysTaskMain.task.name"/>：'+HTMLEncode(xx[0]);
			}
			if(xx[1]){ // 责任人
				str += '<br><bean:message bundle="sys-task" key = "sysTaskMain.principal"/>：'+HTMLEncode(xx[1]);
			}
			if(xx[2]){ // 进度
				str +='<br><bean:message bundle="sys-task" key = "sysTaskMain.progress"/>：'+xx[2];
			}
			if(xx[3]){ // 占父任务比重
				str +='；<bean:message bundle="sys-task" key = "sysTaskMain.parent.percentage"/>：'+xx[3];
			}
			if(xx[4]){ // 关注人次
				str +='<br><bean:message bundle="sys-task" key = "sysTaskMain.focus.members"/>：'+xx[4];
			}
			if(xx[5]){ // 反馈时间
				str +='<br><bean:message bundle="sys-task" key = "sysTaskMain.response.time"/>：'+xx[5];
			}
			var t = '<div>'+str+'</div>';
			
			var vo = $("<DIV id='"+id+"' class='detailInfo'>"); 
			var p = $(obj).position();
				vo.css("position","absolute");
				vo.css("z-index",1000);
				vo.html(t);
				$(obj).append(vo);
		}
		
	</script>		