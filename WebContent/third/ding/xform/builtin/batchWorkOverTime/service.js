Com_IncludeFile("common.js", Com_Parameter.ContextPath + "third/ding/xform/resource/js/","js",true);
Com_IncludeFile("dingTool.js", Com_Parameter.ContextPath + "third/ding/xform/resource/js/","js",true);
Com_IncludeFile("validatorUtil.js", Com_Parameter.ContextPath + "third/ding/xform/resource/js/","js",true);
Com_IncludeFile("common.css", Com_Parameter.ContextPath + "third/ding/xform/resource/css/","css",true);

var methodStatus;//当前页面类型：add/view/edit
seajs.use(["lui/jquery","lui/topic", "lui/util/str", "lui/util/env", "lui/dialog"],function($, topic, strUtil, env, dialog){
	//页面初始化
	function Ding_Init(){	 
		var status = DingCommonnGetStatus();
		//获取到后置为全局参数-后面会用到
		methodStatus = status;
		switch(status){
			case "add":
			case "edit":
				Ding_Init_Edit(status);
				break;
			case "view":
				Ding_Init_View();
				break;
		}
	}
	Com_AddEventListener(window, "load", Ding_Init);
});

//编辑页(add/edit)
function Ding_Init_Edit(status){
	initLabelWidth(status);
	//事件
	initChangeEvent();
	//校验器
	initCheckEvent();
}

/**
 * 校验器
 * @returns
 */
function initCheckEvent(){
	addBatchCompareWorkTimeValidation('compareWorkTime',"加班结束时间不能小于加班开始时间");
	addBatchRepeatWorkTimeValidation('repeatWorkTime',"加班记录重复，请重新选择");
	/*#155133-钉钉套件加班问题-开始*/
	//由于跨天加班的问题，在这里添加校验器。逻辑如下：
	//如果是跨天加班，那么钉钉接口无法返回加班时长（为0），且如果自行修改加班时长，那么提交到后台会出现两条数据且加班时长为空
	//为了限制这种跨天加班的情况，这里控制：1.如果加班时长为空则添加校验且不让编辑，2.如果判断是跨天（开始时间和结束时间不是同一天但是区间是在24小时内，则提示可能是跨天原因引起）
	addBatchOvertimeHoursValidation('overtimeHours',"加班时长异常，请重新填写加班时间。");
	/*#155133-钉钉套件加班问题-结束*/
}

function checkTrValue(tr){
	var fd_work_start_time =$(tr).find("[name*='fd_work_start_time']");
	if(fd_work_start_time && $(fd_work_start_time).val()){
		$(fd_work_start_time).focus();
	}
	var fd_work_end_time =$(tr).find("[name*='fd_work_end_time']");
	if(fd_work_end_time && $(fd_work_end_time).val()){
		$(fd_work_end_time).focus();
	}
}

/**
 * 初始化事件
 */
function initChangeEvent(){
	//添加行
	$(document).on('table-add-new','table[showStatisticRow]',function(e,argus){	
		//日期控件绑定校验器
		$("[name*='fd_work_start_time']").attr("validate","required __datetime compareWorkTime repeatWorkTime");
	    $("[name*='fd_work_end_time']").attr("validate","required __datetime compareWorkTime repeatWorkTime");
	    
	    /*#155133-钉钉套件加班问题-开始*/
	    //添加加班时长校验
	    $("[name*='fd_duration']").attr("validate","required overtimeHours");
	    /*#155133-钉钉套件加班问题-结束*/
	    
	    //加班人变更事件
	    $("[name*='fd_work_user.id']").on('change',function(){
	    	var userTd = $(this).parent(".inputselectsgl").parent("xformflag").parent(".xform_address").parent("td");
	    	var item = $(userTd).find("div .mf_container").find(".mf_list").find(".mf_item");
		    for (var i = 0; i < item.length; i++) {
				if(i>2){
					$(item[i]).css("display","none");
				}
			}
		    var userListSpan = $(userTd).find("div .mf_container").find(".userListSpan");
		    if(item.length>3 ){
		    	if(userListSpan.length==0){
		    		$(userTd).find("div .mf_container").find(".mf_list").after("<span class='userListSpan'>等<span class='userCountSpan'>"+item.length+"</span>人</span>")
		    	}
		    	$(userTd).find("div .mf_container").find(".userCountSpan").text(item.length);
		    	$("[name*='fd_work_user.id']").parent(".inputselectsgl").css("height","28px");
		    	$("[name*='fd_work_user.id']").parent(".inputselectsgl").css("width","230px");
		    }else{
		    	$(userTd).find("div .mf_container").find(".userListSpan").remove();
		    }
		    getWorkTimeDuration($(userTd).parent("tr"));
		    checkTrValue($(userTd).parent("tr"));
	    });
	    
	    //加班开始时间变更事件
	    $("[name*='fd_work_start_time']").on('change',function(){
	    	var tr = $(this).parents(".xform_datetime").parent("td").parent("tr");
	    	getWorkTimeDuration(tr);
	    	checkTrValue(tr);
	    });
	    
		//加班结束时间变更事件-必填
		$("[name*='fd_work_end_time']").on('change',function(){
			var tr = $(this).parents(".xform_datetime").parent("td").parent("tr");
	    	getWorkTimeDuration(tr);
	    	checkTrValue(tr);
		});
		
		//新增行--控制行数
		$(".opt_add_style").parent("span").on('click',function(){
			canShowAddBtn();
		});
		//批量删除-控制行数
		$(".opt_batchDel_style").parent("span").on('click',function(){
			canShowAddBtn();
		});
	});
	
	//删除--控制行数
	$(document).on('table-delete','table[id="TABLE_DL_fd_batch_work_table"]',function(e,argus){
		canShowAddBtn();
	});
}

//获取加班时长
function getWorkTimeDuration(tr){
	var fd_work_user = $(tr).find("[name*='fd_work_user.id']").val();
	var fd_work_start_time = $(tr).find("[name*='fd_work_start_time']").val();
	var fd_work_end_time = $(tr).find("[name*='fd_work_end_time']").val();
	if(!fd_work_user || !fd_work_start_time || !fd_work_end_time){
		return;
	}	
	var startTime = new Date(fd_work_start_time);
	var endTime = new Date(fd_work_end_time);
	if(endTime.getTime() - startTime.getTime() <= 0){
		return;
	}
	/*#155133-钉钉套件加班问题（跨天后无计算出加班时长）-开始*/
	/*if(startTime.getDate() != endTime.getDate()){
		return;
	}*/
	var ms = endTime.getTime() - startTime.getTime();
	//获取相差小时数
	var hour = ms / 1000 / 60 / 60;
	//如果超过一天
	if (hour > '24') {
		return;
	}
	/*#155133-钉钉套件加班问题（跨天后无计算出加班时长）-结束*/
	$("[name*='fd_duration']").css("text-align","center");
	
    var url = Com_Parameter.ContextPath + "third/ding/thirdDingAttendance.do?method=getOvertimeDuration&ekpUserIds=" +fd_work_user+"&startTime="+fd_work_start_time+"&finishTime="+fd_work_end_time;
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        error: loadFailure,
        success: loadMonthReplacementInfoSuccess
    });

    function loadMonthReplacementInfoSuccess(data){
        if (data && data.errcode==0) {
        	if(data.isCanOvertime){
        		$(tr).find("[name*='fd_duration']").val(data.durationInHour);
        		$(tr).find("[name*='fd_extend_value']").val(data.durationData);
        	}else{
        		console.log("data:"+JSON.stringify(data));
        		$(tr).find("[name*='fd_duration']").val("");
        		$(tr).find("[name*='fd_extend_value']").val("");
            	networkFailure(data.errmsg);
        	}
        }else{
        	console.log("data:"+JSON.stringify(data));
        	$(tr).find("[name*='fd_duration']").val("");
        	$(tr).find("[name*='fd_extend_value']").val("");
        	networkFailure(data.errmsg);
        }
    }
    /**
     * ajax请求失败
     */
    function loadFailure(data) {
    	console.log("data:"+JSON.stringify(data));
    	$(tr).find("[name*='fd_duration']").val("");
    	$(tr).find("[name*='fd_extend_value']").val("");
    	networkFailure("网络异常，请稍后再试");
    }
}



function canShowAddBtn(){
	var fd_work_user = $("#TABLE_DL_fd_batch_work_table").find("[name*='fd_work_user.id']");
	if(fd_work_user.length>=20){
		$(".opt_add_style").parent("span").addClass("fd_change_date_tip");
	}else{
		$(".opt_add_style").parent("span").removeClass("fd_change_date_tip");
	}
}

//查看页
function Ding_Init_View(){
	$("[id*='fd_work_user.id']").addClass("viewUserName")
	var userId = $("[id*='fd_work_user.id']");
	if(userId.length>0){
		for (var a = 0; a < userId.length; a++) {
			var tr = $(userId[a]).parent(".xform_address").parent("td").parent("tr");
			if($(userId[a]).text()){
				var names = $(userId[a]).text().split(";");
				var showNames="";
				if(names.length>3){
					for (var i = 0; i < names.length; i++) {
						if(i<3){
							showNames+=names[i]+";";
						}
					}
					showNames = showNames.substring(0, showNames.lastIndexOf(';'))+" 等"+names.length+"人";
					console.log(showNames);
					$(tr).find(".xform_address").addClass("viewUserName");
					$(tr).find(".xform_address").after("<span class='viewUserName showUserName isShow'>"+showNames+"</span>");
					$(tr).find(".xform_address").css("display","none");
				}else{
					$(tr).find(".showUserName").css("display","none");
					$(tr).find(".xform_address").css("display","block");
					$(tr).find(".showUserName").removeClass("isShow");
				}
			}
		}
	}
	$(".viewUserName").on('click',function(){
    	var tr = $(this).parent("td").parent("tr");
    	var xformAddress = $(tr).find(".showUserName");
    	console.log(xformAddress);
    	if(xformAddress && xformAddress.length>0){
    		if(xformAddress.hasClass("isShow")){
    			$(tr).find(".showUserName").css("display","none");
    			$(tr).find(".xform_address").css("display","block");
    			$(tr).find(".showUserName").removeClass("isShow");
    		}else{
    			$(tr).find(".xform_address").css("display","none");	
    			$(tr).find(".showUserName").css("display","block");
    			$(tr).find(".showUserName").addClass("isShow");
    		}
    	}
    });
	
}

//左侧label所在td的宽度和主题label所在td宽度保持一致
function initLabelWidth(status){	
	var docSubjectLabelWidth = $("[name='docSubject']").parent("div").parent("td").prev("td").css('width');
	$('[name="extendDataFormInfo.value(fd_work_over_time_remark)"]').parent("xformflag").parent(".xform_textArea").parent("td").prev("td").css("width",docSubjectLabelWidth);
}