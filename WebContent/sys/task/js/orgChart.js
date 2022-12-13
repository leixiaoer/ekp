Com_RegisterFile("orgChart.js");

var data_array;
var map;
var initSize = 0.6;
var mapsW = 0;
var mapsH = 500;

//获取组织表的Ajax
function GetOrgChartAjax(fdId,url){
	seajs.use(['lui/dialog'], function(dialog){
		window.del_load = dialog.loading();
	});
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
	                $("#main").html('');
	                $("#select_Arrow").html('');
                    var html = "";
                    data_array = $.parseJSON(data.d);
                    //定义第一级组织ID
                    var firsttaskID = "";
                    //定义第一级组织Text
                    var firsttaskText = "";
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
                            $("#select_Arrow").append('<option value="' + depthv + '">全部展开</option>');
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
                    mapsH = depthv * 156;
                    //worldMap.style.height = mapsH.toString() + 'px';
                    lefttask.style.height = mapsH.toString() + 'px';
                    leftperson.style.height = mapsH.toString() + 'px';

                    for (var i = 0; i < data_array.length; i++) {
                        if (data_array[i].ChildCount === 0) {
                            mapsW += 260;
                        }
                    }
                    lefttask.style.width = mapsW.toString() + 'px';
                    leftperson.style.width = mapsW.toString() + 'px';
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
                    $("#task").orgChart({ container: $("#main"), depth: depthVal, interactive: true, fade: true, speed: 'fast', showLevels: showLevel });
                    
                   // console.log($('body').width());
                    
                    var w = document.body.clientWidth;
                    var container = document.getElementById("worldMap");
                    
                    //container.style.width = w*0.8+'px';
                    
                    //initSize = parseFloat((w / mapsW).toFixed(1));
                    setWHnone();

                    $("#main").css("transition", "all 0.5s ease-in-out");
                    $("#main").css("transform", "scale(" + initSize + ")");
                    $("#main").css("transform-origin", "0 0");

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
    var mapsWl = 0;
    if (depthVal > 0) {
        setWH(depthVal, mapsWl);
        $("#task").orgChart({ container: $("#main"), depth: depthValMax, interactive: true, fade: true, speed: 'fast', showLevels: depthVal });
        setWHnone();
    }
	if(window.del_load!=null){
		window.del_load.hide(); 
	}
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

    var depthVal = 3;
    var mapsWl = 0;
    if (depthVal > 0) {
        setWH(depthVal, mapsWl);
        var chartClass = "orgChart";
        if(obj.value == 'person'){
        	 chartClass = "orgChart person_type";
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


//绘制单一的DIV
function DrawDiv(dt, NodeID) {

    for (var i = 0; i < dt.length; i++) {
        if (dt[i].taskID == NodeID) {
            var h = '<div id="div_' + dt[i].taskID + '" class="divShowD" style="width: 248px; height: 120px;"> '
                  + "     <table width='100%'>                                                                                                             "
                  + "         <tr>                                                                                                                         ";
            h += "             <td class='headrow-bradius' style='height: 33px; background-color: #47c2fe; width: 100%;'>                                                       ";
            h += "                 <table width='100%'>                                                                                                 "
                  + "                     <tr>                                                                                                             "
                  + "                         <td align='left' class='textEllipsis' style='width: 200px;height: 45px; vertical-align: middle;  padding-left: 10px; font-family: 微软雅黑; color: #fefefe;             "
                  + "                             font-size: 20px; text-align:left;'>                                                                                      ";
            h += '                                 <span title="' + dt[i].taskName + '" style="line-height:45px;cursor: pointer;"  onclick="openTask(\''+dt[i].taskID+'\');">' + dt[i].taskName + ' </span>';
            h += "                            </td>                                                                                                        "
                  + "                         <td style='width: 43px;  vertical-align: middle;'>                                                                                 "

            if (dt[i].ChildCount > 0) {
                h += "                            <img id='arrowImg_" + dt[i].taskID + "' src='../../../sys/organization/resource/image/arrowOpen.png' style=' cursor:pointer; '/>   ";
            }
            h += "                         </td>                                                                                                        "
                  + "                     </tr>                                                                                                            "
                  + "                 </table>                                                                                                             "
                  + "             </td>                                                                                                                    "
                  + "         </tr>                                                                                                                        "
                  + "         <tr>                                                                                                                     "
                  + '            <td style="height: 73px; width: 100%; vertical-align: middle;" data-info="'+ dt[i].dataInfo+'" onclick="openTask(\''+dt[i].taskID+'\');" onmouseover="showInfo(this,\''+dt[i].taskID+'\');" onmouseout="hideInfo(\''+dt[i].taskID+'\');"> '
                  + "                 <table width='100%'>                                                                                                 "
                  + "                     <tr>                                                                                                           "
                  + "                         <td rowspan='2' style='width: 64px;'>                                      "
                  + "                             <img src='" + dt[i].headImgUrl + "' height='44px' width='44px' style='border-radius:50%;' />    "
                  + "                         </td>    "
                  + "                         <td align='left'rowspan='2' >                            "
            	h += '                           <div style="text-align:left; width: 92px; height:30px; font-family:微软雅黑; font-size:20px; color:#333;overflow: hidden;text-overflow: ellipsis;word-break: keep-all; white-space: nowrap;" title="'+dt[i].attentionCount+'" > 关注: ' + dt[i].attentionCount +'</div>'
            h +=	"							 <div style='text-align:left; width: 92px; height:21px;  font-family:微软雅黑; font-size:20px; color:#333;overflow: hidden;text-overflow: ellipsis;word-break: keep-all; white-space: nowrap;' title='"+dt[i].status +"'>状态: " + dt[i].status + "</div>"
                  + "                         </td><td rowspan='2' style='width: 1px;vertical-align: middle;'><div style='width: 1px; height:37px; border-left:1px solid #E3E3E3;'><div></td>    "
                  + "                         <td align='left' style='text-align:left; width: 63px; padding-top: 3px;  padding-left: 20px; border-left-color: Black; font-family:微软雅黑; font-size:14px;color:#7885a4;'>"
            h += "                         </td>                                                                                                       "
                  + "                     </tr>                                                                                                            "
                  + "                     <tr>                                                                                                             "
                  + "                         <td align='left' style='text-align:middle; padding-left: 0px; padding-top: 10px; border-left-color: Black; font-family:微软雅黑; font-size:14px; color:#333;'>             "
            h += "                              <span style='font-family:微软雅黑; font-size:30px;font-weight:bold;color:#333;' >" + dt[i].progress + "</span>                                                                                                   "
            h += "                         </td>                                                                                                  "
                  + "                     </tr>                                                                                                            "
                  + "                 </table>                                                                                                             "
                  + "             </td>                                                                                                                    "
                  + "         </tr>                                                                                                                        "
                  + "     </table>                                                                                                                         "
                  + " </div>";
            return h;
        }
    }
    return "";
}

//绘制单一的DIV
function DrawPersonDiv(dt, NodeID) {

    for (var i = 0; i < dt.length; i++) {
        if (dt[i].taskID == NodeID) {
            var h = '<div id="div_' + dt[i].taskID + '" data-info="'+ dt[i].dataInfo+'" class="divShowD" style="width: 168px; height: 120px;" onmouseover="showInfo(this,\''+dt[i].taskID+'\');" onmouseout="hideInfo(\''+dt[i].taskID+'\');"> '
                  + "     <table width='100%'>                                                                                                             "
                  + "         <tr>                                                                                                                         ";
            h += "             <td class='headrow-bradius' style='height: 33px; background-color: #47c2fe; width: 100%;'>                                                       ";
            h += "                 <table width='100%'>                                                                                                 "
                  + "                     <tr>                                                                                                             "
                  + "                         <td align='left' class='textEllipsis' style='width: 120px;height: 45px; vertical-align: middle;  padding-left: 10px; font-family: 微软雅黑; color: #fefefe;             "
                  + "                             font-size: 20px;'>                                                                                      ";
            h += '                                 <span title="' + dt[i].performName + '" style="line-height:45px;cursor: pointer;"  onclick="openTask(\''+dt[i].taskID+'\');">' + dt[i].performName + ' </span>';
            h += "                            </td>                                                                                                        "
                  + "                         <td style='width: 43px;  vertical-align: middle;'>                                                                               "

            if (dt[i].ChildCount > 0) {
                h += "                            <img id='arrowImg_" + dt[i].taskID + "' src='../../../sys/organization/resource/image/arrowOpen.png' style=' cursor:pointer; '/>   ";
            }
            h += "                         </td>                                                                                                        "
                  + "                     </tr>                                                                                                            "
                  + "                 </table>                                                                                                             "
                  + "             </td>                                                                                                                    "
                  + "         </tr>                                                                                                                        "
                  + "         <tr>                                                                                                                     "
                  + '            <td style="height: 73px; width: 100%; vertical-align: middle;" onclick="openTask(\''+dt[i].taskID+'\');"> '
                  + "                 <table width='100%'>                                                                                              "
                  + "                     <tr>                                                                                                           "
                  + "                         <td rowspan='2' style='width: 64px;'>                                      "
                  + "                             <img src='" + dt[i].headImgUrl + "' height='64px' width='64px' style='border-radius:50%;' />    "
                  + "                         </td>    "
                  + "                         <td rowspan='2' style='width: 1px;vertical-align: middle;'><div style='width: 1px; height:37px; border-left:1px solid #E3E3E3;'><div></td>    "
                  + "                         <td align='left' style='text-align:left; width: 63px; padding-top: 3px;  padding-left: 20px; border-left-color: Black; font-family:微软雅黑; font-size:14px;color:#7885a4;'>"
            h += "                         </td>                                                                                                      "
                  + "                     </tr>                                                                                                            "
                  + "                     <tr>                                                                                                        "
                  + "                         <td align='left' style='text-align:center; vertical-align: middle;padding-left: 0px; border-left-color: Black; font-family:微软雅黑; font-size:14px; color:#333;'>             "
            h += "                              <span style='font-family:微软雅黑; font-size:30px;font-weight:bold;color:#333;' >" + dt[i].progress + "</span>                                                                                                   "
            h += "                         </td>                                                                                                  "
                  + "                     </tr>                                                                                                            "
                  + "                 </table>                                                                                                             "
                  + "             </td>                                                                                                                    "
                  + "         </tr>                                                                                                                        "
                  + "     </table>                                                                                                                         "
                  + " </div>";
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
      //  worldMap.style.width = mapsWl.toString() + 'px';
        lefttask.style.width = mapsWl.toString() + 'px';
        leftperson.style.width = mapsWl.toString() + 'px';
    }
    mapsW=mapsWl;
}

var hiddenChildNodeIDs = "";

function setWHnone(id) {
    //如果页面变宽，则用这个
    //worldMap.style.width = worldMap.scrollWidth + 'px';

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
    //高度变化
   // worldMap.style.height = (showDepthVal * 156 * initSize + 20).toString() + 'px';
    lefttask.style.height = (showDepthVal * 156 * initSize + 20).toString() + 'px';
    leftperson.style.height = (showDepthVal * 156 * initSize + 20).toString() + 'px';

    //宽度变化
    //worldMap.style.width = (260 * showNodes * initSize + 20).toString() + 'px';
    lefttask.style.width = (260 * showNodes * initSize + 20).toString() + 'px';
    leftperson.style.width = (260 * showNodes * initSize + 20).toString() + 'px';

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
    if (initSize > 1) {
        initSize = 1;
    }
    else if (initSize <= 1 && initSize > 0.6) { initSize = 1; }
    else if (initSize <= 0.6 && initSize > 0.5) { initSize = 0.6; }
    else if (initSize <= 0.5) { initSize = 0.5; }
    $("#main").css("transition", "all 0.5s ease-in-out");
    $("#main").css("transform", "scale(" + initSize + ")");
    $("#main").css("transform-origin", "0 0");
    if (initSize >= 1) {
      //  worldMap.style.width = (mapsW * initSize * 1.05).toString() + 'px';
        lefttask.style.width = (mapsW * initSize).toString() + 'px';
        leftperson.style.width = (mapsW * initSize).toString() + 'px';
       // worldMap.style.height = (mapsH * initSize).toString() + 'px';
    }
    setWHnone();
}
//缩小
function ShowSmall() {
    initSize = initSize - 0.1;
    if (initSize >= 1) {
        initSize = 1;
    }
    else if (initSize < 1 && initSize >= 0.6) { initSize = 0.6; }
    else if (initSize < 0.6 && initSize >= 0.5) { initSize = 0.5; }
    else if (initSize < 0.5) { initSize = 0.5; }
    $("#main").css("transition", "all 0.5s ease-in-out");
    $("#main").css("transform", "scale(" + initSize + ")");
    $("#main").css("transform-origin", "0 0");
    if (initSize >= 1) {
       // worldMap.style.width = (mapsW * initSize * 1.05).toString() + 'px';
        lefttask.style.width = (mapsW * initSize).toString() + 'px';
        leftperson.style.width = (mapsW * initSize).toString() + 'px';
       // worldMap.style.height = (mapsH * initSize).toString() + 'px';
    }
    setWHnone();
}


function openTask(taskId){
	var url = Com_Parameter.ContextPath +'sys/task/sys_task_main/sysTaskMain.do?method=view&fdId='+taskId
	Com_OpenWindow(url);
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
	
	//var nt = document.getElementById(id);
	//if(nt){
	//	nt.style.display="";
	//}else{
		var aa = $(obj).attr("data-info")
		var xx = aa.split("#");
		var str="";
		if(xx[0]){ // 任务名称
			str += '任务名称：'+____formatText(xx[0]);
		}
		if(xx[1]){ // 责任人
			str += '<br>责任人：'+xx[1];
		}
		if(xx[2]){ // 进度
			str +='<br>进度：'+xx[2];
		}
		if(xx[3]){ // 反馈时间
			str +='<br>反馈时间：'+xx[3];
		}
		var t = '<div style="width:250px;height:90px;padding:8px">'+str+'</div><div></div>';
		

		var vo = $("<DIV id='"+id+"'>");
		var p = $(obj).position();
			vo.css("position","absolute");
			vo.css("background-color","#dfdfdf");
			vo.css("border-radius","10px");
			vo.css("left",p.left+"px");
			console.log($(obj).height());
			vo.css("top",p.top-$(obj).height()-80+"px");
			vo.css("z-index",1000);
			vo.html(t);
			$('body').append(vo);
	//} 
}
