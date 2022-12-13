﻿﻿/*压缩类型：标准*/
/***********************************************
JS文件说明：
该文件提供了基于JQueryUI的日历。

作者：傅游翔
版本：3.0 2013-12
***********************************************/

Com_RegisterFile("calendar.js");
Com_IncludeFile("jquery.js|data.js");
Com_IncludeFile("jquery.ui.js", "js/jquery-ui/");

(function() {
	
	Com_AddEventListener(window, 'load', function() {
		//alert(Data_GetResourceString("date.format.datetime.2y").toLowerCase());
		
		if(!window.Calendar_Lang)
			window.Calendar_Lang = {
				format : {
					//date : window.seajs ? seajs.data.env.pattern.date : Data_GetResourceString("date.format.date.2y"),
					//time : window.seajs ? seajs.data.env.pattern.time : Data_GetResourceString("date.format.time"),
					//dataTime : window.seajs ? seajs.data.env.pattern.datetime : Data_GetResourceString("date.format.datetime.2y")
					date : Data_GetResourceString("date.format.date.2y")?Data_GetResourceString("date.format.date.2y").toLowerCase():Data_GetResourceString("date.format.date.2y"),
					time : Data_GetResourceString("date.format.time"),
					dataTime : Data_GetResourceString("date.format.datetime.2y")?Data_GetResourceString("date.format.datetime.2y").toLowerCase():Data_GetResourceString("date.format.datetime.2y")
				}
			};
	});
	
	/**
	* 日历选择
	* 兼容以前的模式，在跨浏览器时，需要显示传递 event.
	* @param event
	* @param fieldname
	* @param format
	* @param callback
	* @return
	*/
	function selectDate(event, fieldname, format, callback) {
		selectCalendar(event, fieldname, format, callback, 'dateState');
	}

	/**
	* 时间选择
	* 兼容以前的模式，在跨浏览器时，需要显示传递 event.
	* @param event
	* @param fieldname
	* @param format
	* @param callback
	* @return
	*/
	function selectTime(event, fieldname, format, callback) {
		selectCalendar(event, fieldname, format, callback, 'timeState');
	}

	/**
	* 日历时间
	* 兼容以前的模式，在跨浏览器时，需要显示传递 event.
	* @param event
	* @param fieldname
	* @param format
	* @param callback
	* @return
	*/
	function selectDateTime(event, fieldname, format, callback) {
		selectCalendar(event, fieldname, format, callback, 'dateAndTimeState');
	}
	
	/**
	 * 多选日期
	 * @param event
	 * @param fieldname
	 * @param format
	 * @param callback
	 * @returns
	 */
	function selectMulDate(event, fieldname, format, callback) {
		selectCalendar(event, fieldname, format, callback, 'mulDateState');
	}
	
	/**
	 * 获取排班数据
	 * @returns
	 */
	function getHPDay(cb){
		var url =  Com_Parameter.ContextPath+"sys/time/sys_time_area/sysTimeArea.do?method=getHPDay";
		$.ajax({
		   type: "GET",
		   url: url,
		   dataType: "json",
		   success: function(data){
			   cb(data);
		   }
		});
	}
	
	/**
	 * 插入排班状态标签
	 * @param tds
	 * @returns
	 */
	function injectHPSign(tds) {
		getHPDay(function(data) {
			
			var __REST_STRING__ = Data_GetResourceString('sys-time:calendar.data.list.rest');
			var __PACH_STRING__ = Data_GetResourceString('sys-time:calendar.data.list.pach');
			
			var titles = {
				'1': __REST_STRING__,
				'2': __PACH_STRING__
			};
			
			var _data = [], t, i, l = (data || []).length;
			
			for(i = 0; i < l; i++) {
				
				t = new Date(data[i].date.replace(/-/g, '/'));
				
				_data.push({
					year: t.getFullYear(),
					month: t.getMonth(),
					date: t.getDate(),
					type: data[i].type
				});
			}
			
			tds.each(function(_, td) {
				
				td = $(td);
				var year = td.attr('data-year');
				var month = td.attr('data-month');
				var date = td.attr('data-date');
				
				i = 0; l = (_data ||[]).length;
				for(i; i < l; i++) {
					t = _data[i];
					
					if(t.year == year && t.month == month && t.date == date) {
						td.append('<span class="ui-datepicker-sign" data-type="' + t.type + '"></span>');
						td.append('<span class="ui-datepicker-signlabel" style="display: none;">' + titles[t.type] + '</span>');
						
						break;
					}
				}
				
			});
			
		});
		
	}

	/**
	 * 时间选择器时间间隔处理函数
	 * @param step
	 * @returns
	 */
	function handleTimePickerMinuteStep(step) {
		$.datepicker.dpDiv.find('.ui_tpicker_minute_slider .ui-timepicker-select option').each(function(_, option){
			var value = parseInt($(this).val());
			if(value % step == 0) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	}
	
	/**
	* 通用日期时间选择对话框，通常外部不直接调用此函数
	* @param event - 事件
	* @param fieldname - 字段名
	* @param format - 格式化方式，仅对日期有效
	* @param callback - 回调函数
	* @param type - dateState | timeState | dateAndTimeState
	* @return
	*/
	function selectCalendar(event, fieldname, format, callback, type) {
		var eventObj = null;
		if (typeof(event) == 'string' || typeof(event.tagName) == 'string') { // only ie
			callback = format;
			format = fieldname;
			fieldname = event;
			event = Com_GetEventObject();
			eventObj = event.target || event.srcElement;
		} else if (fieldname) { // 正确调用方式
			event = Com_GetEventObject();
			eventObj = event.target || event.srcElement;
		}
		if (event.preventDefault) {
			event.preventDefault();
		}else {
			event.returnValue = false;
		}
		var objField = (typeof(fieldname) == 'string') ? 
				(window.DocList_GetRowField ? DocList_GetRowField(eventObj, fieldname) : document.getElementsByName(fieldname)[0]) 
				: fieldname;

		function cb (dateText) {
			if (callback) callback({FieldObject:objField});
			if (divIframe)
				divIframe.hide();
			jQuery(objField).datepicker('destroy');
			objField.focus();
			//修复#87923添加
			if (typeof(seajs) != 'undefined' && typeof( top['seajs'] ) != 'undefined' ) {
				seajs.use(['lui/topic'], function(topic) {
					topic.publish("CALENDAR_CB");
				});
			}
		}
		function showIframe() {
			if (!divIframe) {
				divIframe = $('<iframe style="position:absolute;display:none;border:none;background:transparent;"></iframe>').appendTo('body');
			}
			var offset = $.datepicker.dpDiv.offset();
			divIframe.css({top:offset.top, left:offset.left});
			divIframe.width($.datepicker.dpDiv.width() + 7);
			divIframe.height($.datepicker.dpDiv.height() + 5);
			divIframe.show();
			//修复#87923添加
			if (typeof(seajs) != 'undefined' && typeof( top['seajs'] ) != 'undefined' ) {
				seajs.use(['lui/topic'], function(topic) {
					topic.publish("CALENDAR_SHOW_IFRAME");
				});
			}
		}
		
		//周起始日
		var firstDayInWeek = isNaN(Com_Parameter['FirstDayInWeek']) ? 1 : Com_Parameter['FirstDayInWeek'];
		
		//时间间隔
		var calendarMinuteStep = isNaN(Com_Parameter['CalendarMinuteStep']) ? 1 : Com_Parameter['CalendarMinuteStep'];
		var specialMinuteStep = $(objField).attr('data-minute-step');
		if(specialMinuteStep && parseInt(specialMinuteStep) > 0) {
			calendarMinuteStep = parseInt(specialMinuteStep);
		}
		
		//是否显示排班
		var showScheduling = $(objField).attr('data-show-scheduling') == 'true'; 
		jQuery( objField )
				.timepicker('hide');
			jQuery( objField )
				.datepicker('hide');
		if (type == "dateState") {
			jQuery( objField )
				.datepicker({
					"onClose": cb,
					firstDay: firstDayInWeek, 
					yearRange:"c-70:c+50",
					dateFormat: window.Calendar_Lang.format.date,
					onUpdateDatepicker: function(year,month,dp_inst) {
						if(dp_inst && dp_inst.dpDiv && dp_inst.dpDiv.get(0) && showScheduling) {
							injectHPSign($(dp_inst.dpDiv.get(0)).find('td[data-handler=selectDay]'));
						}
					}
				}).datepicker('show');
			showIframe();
		}
		else if (type == "timeState") {
			jQuery( objField )
				.timepicker({
					"onClose": cb,
					stepMinute: calendarMinuteStep,
					controlType:"select",
					onUpdateDatepicker: function(year,month,dp_inst) {
					}
				}).timepicker('show');
			showIframe();
		}
		else if (type == "dateAndTimeState") {
			//添加默认时分
			var hour = $(objField).attr('data-init-hour'); 
			if(hour){
				hour = parseInt(hour);
			}
			var minute = $(objField).attr('data-init-minute'); 
			if(minute){
				minute = parseInt(minute);
			}
			jQuery( objField )
				.datetimepicker({
					"onClose": cb,
					controlType:"select",
					firstDay: firstDayInWeek, 
					yearRange:"c-50:c+50",
					dateFormat: window.Calendar_Lang.format.date,
					stepMinute: calendarMinuteStep,
					hour: hour||null,
					minute: minute||null,
					onUpdateDatepicker: function(year,month,dp_inst) {
						if(dp_inst && dp_inst.dpDiv && dp_inst.dpDiv.get(0) && showScheduling) {
							injectHPSign($(dp_inst.dpDiv.get(0)).find('td[data-handler=selectDay]'));
						}
					}
				})
				.datetimepicker('show');
			showIframe();
		}
		else if (type == "mulDateState") {
			jQuery( objField )
				.muldatepicker({
					"onClose": cb,
					controlType:"select",
					firstDay: firstDayInWeek, 
					yearRange:"c-50:c+50",
					dateFormat: window.Calendar_Lang.format.date,
					onUpdateDatepicker: function(year,month,dp_inst) {
						if(dp_inst && dp_inst.dpDiv && dp_inst.dpDiv.get(0) && showScheduling) {
							injectHPSign($(dp_inst.dpDiv.get(0)).find('td[data-handler=selectDay]'));
						}
					}
				}).muldatepicker('show');
			showIframe();
		}
	}
	var divIframe = false;
	
	window.selectDate = selectDate;
	window.selectTime = selectTime;
	window.selectDateTime = selectDateTime;
	window.selectMulDate = selectMulDate;
})();


// ******** 以下为 1.0代码 *************
 
//将字符串转化为日期对象，第一个参数为日期字符串，默认格式为“yyyy-MM-dd”，如果要自定义格式
//把格式做为第二个参数，格式中必须含有"yyyy"、"MM"、"dd"等字串
function formatDate(strdate){
	var arr = new Array;
	var arr1 = new Array;
	var arrsort=new Array(0,1,2);
	var arrtemp=new Array;
	var arrdate =new Array;
	var tt=new Date;
	arrdate[0]=tt.getFullYear();
	arrdate[1]=tt.getMonth()+1;
	arrdate[2]=tt.getDate();
	var strformat;
	var strtemp;
	var numtemp;
	var theDate;

	if(arguments[1]!=null){
		strformat=arguments[1];
	}else{
		strformat="yyyy-MM-dd";
	}
	strtemp=strformat.replace("yyyy","-");
	strtemp=strtemp.replace("MM","-");
	strtemp=strtemp.replace("dd","-");
	arr=strtemp.split("-");
	strtemp=strdate;
	for(var i=0;i<arr.length;i++)
		strtemp=strtemp.replace(arr[i],"-")
	arr=strtemp.split("-");
	for(i=0;i<arr.length;i++)
		if(arr[i]!="")
			arr1[arr1.length]=arr[i];
	arrtemp[0]=strformat.indexOf("yyyy");
	arrtemp[1]=strformat.indexOf("MM");
	arrtemp[2]=strformat.indexOf("dd");
	if(arrtemp[arrsort[0]]>arrtemp[arrsort[1]]){
		numtemp=arrsort[0];
		arrsort[0]=arrsort[1];
		arrsort[1]=numtemp;
	}
	if(arrtemp[arrsort[0]]>arrtemp[arrsort[2]]){
		numtemp=arrsort[0];
		arrsort[0]=arrsort[2];
		arrsort[2]=numtemp;
	}
	if(arrtemp[arrsort[1]]>arrtemp[arrsort[2]]){
		numtemp=arrsort[1];
		arrsort[1]=arrsort[2];
		arrsort[2]=numtemp;
	}
	var j;
	for(i=arrsort.length-1,j=arr1.length-1;j>-1;i--,j--){
		if(arrtemp[arrsort[i]] != -1)
			arrdate[arrsort[i]]=arr1[j];
	}
	if(strdate=="")
		theDate=new Date();
	else
		theDate=new Date(arrdate[0],arrdate[1]-1,arrdate[2]);
	return theDate;
}

//时间比较函数
function compareDate(endDate,beginDate,endTime,beginTime){
	//参数为字符串，后两个参数可以为空
	//返回值：0、相等；正数：结束时间大于开始时间；负数：结束时间小于开始时间
	var arrDate;
	//var strBDate,strEDate;
	var datBDate,datEDate;
	var datToday = new Date();

	//初始化开始日期，为空串则设为今天
	if(beginDate==""){
		datBDate = new Date(datToday.getFullYear(),datToday.getMonth(),datToday.getDate());
	}else{
		datBDate = Com_GetDate(beginDate);
		//arrDate=beginDate.split("-");
		//datBDate = new Date(arrDate[1] + "-" + arrDate[2] + "-" + arrDate[0]);
	}

	//初始化结束日期，为空串则设为今天
	if(endDate==""){
		datEDate = new Date(datToday.getFullYear(),datToday.getMonth(),datToday.getDate());
	}else{
		datEDate = Com_GetDate(endDate);
		//arrDate=endDate.split("-");
		//datEDate = new Date(arrDate[1] + "-" + arrDate[2] + "-" + arrDate[0]);
	}

	//初始化开始时间，为空则忽略
	if(beginTime!=null && beginTime!=""){
		arrDate=beginTime.split(":");
		datBDate.setHours(arrDate[0]);
		if(arrDate.length>1){
			datBDate.setMinutes(arrDate[1]);
		}
		if(arrDate.length>2){
			datBDate.setSeconds(arrDate[2]);
		}
	}
	//初始化开始时间，为空串则设为现在
	if(beginTime==""){
		datBDate.setHours(datToday.getHours());
		datBDate.setMinutes(datToday.getMinutes());
	}

	//初始化结束时间，为空则忽略
	if(endTime!=null && endTime!=""){
		arrDate=endTime.split(":");
		datEDate.setHours(arrDate[0]);
		if(arrDate.length>1)
			datEDate.setMinutes(arrDate[1]);
		if(arrDate.length>2)
			datEDate.setSeconds(arrDate[2]);
	}
	//初始化开始时间，为空串则设为现在
	if(endTime==""){
		datEDate.setHours(datToday.getHours());
		datEDate.setMinutes(datToday.getMinutes());
	}
	return (datEDate - datBDate);
}

//时间比较函数
function compareTime(endTime,beginTime){
	//参数为字符串
	//返回值：0、相等；正数：结束时间大于开始时间；负数：结束时间小于开始时间
	var arrDate;
	var datBTime,datETime;
	var datToday = new Date();
	datBTime = new Date();
	datETime = new Date();
	//初始化开始时间，为空则忽略
	if(beginTime!=null && beginTime!=""){
		arrDate=beginTime.split(":");
		datBTime.setHours(arrDate[0]);
		if(arrDate.length>1){
			datBTime.setMinutes(arrDate[1]);
		}
		if(arrDate.length>2){
			datBTime.setSeconds(arrDate[2]);
		}
	}
	//初始化开始时间，为空串则设为现在
	if(beginTime==""){
		datBTime.setHours(datToday.getHours());
		datBTime.setMinutes(datToday.getMinutes());
	}

	//初始化结束时间，为空则忽略
	if(endTime!=null && endTime!=""){
		arrDate=endTime.split(":");
		datETime.setHours(arrDate[0]);
		if(arrDate.length>1)
			datETime.setMinutes(arrDate[1]);
		if(arrDate.length>2)
			datETime.setSeconds(arrDate[2]);
	}
	//初始化开始时间，为空串则设为现在
	if(endTime==""){
		datETime.setHours(datToday.getHours());
		datETime.setMinutes(datToday.getMinutes());
	}
	return (datETime - datBTime);
}
//判断时间格式是否正确
function isValidTime(strTime){
	var n;
	if(strTime=="")
		return false;
	var re=/[^\d:]/g;
	if(re.test(strTime))
		return false;
	var arrTime = strTime.split(":");
	n = parseInt(arrTime[0],10);
	if(isNaN(n))
		return false;
	if(n>23 || n<0)
		return false;
	if(arrTime.length>1){
		n=parseInt(arrTime[1],10);
		if(isNaN(n))
			return false;
		if(n>59 || n<0)
			return false;
	}
	if(arrTime.length>2){
		n=parseInt(arrTime[2],10);
		if(isNaN(n))
			return false;
		if(n>59 || n<0)
			return false;
	}
	return true;
}

/*****************************************************************
功能：验证“date.format.date”模式的日期格式是否正确
参数：
	date：要验证的日期字符串，如：“2009-08-24”、“08/24/2009”	
*****************************************************************/
function chkDateFormat(dateStr)
{
	var reg = null;
	var lang = Data_GetResourceString("locale.language");
	if ("zh-CN" == lang || "zh-HK" == lang)
	{
		reg = /^\d{4}-\d{2}-\d{2}/;
	}
	if ("en-US" == lang){
		reg = /^\d{2}([/])\d{2}([/])\d{4}/;
	}
	else
	{
		reg = /^\d{4}-\d{2}-\d{2}/;
	}

	if(dateStr != null )
	{
		var valDate = dateStr.match(reg);
		if(valDate == null)
		{
			return false;
		}
		else
		{
		 	return true;
		}
    }
		return true;
}


/*****************************************************************
功能：将日期转换成相应日期模式的字符串
参数：
	format：要转换的日期模式，如"E MMM dd yyyy HH:mm:ss"
注意：参数format中，月份"M"必须大于2位，等于2位（“MM”）以数字的形式显示，
     如09；大于2位（“MMM”）以显示为英文月份，如August。
	
*****************************************************************/
Date.prototype.format = function(format)
{ 
	  //从默认资源文件获取周标签
	  var weekNamesStr = Data_GetResourceString("calendar.week.names");
	  var weekDay = new Array();
	  weekDay = weekNamesStr.split(",");
	  
	  // 从默认资源文件获取月标签
	  var monthNamesStr = Data_GetResourceString("calendar.month.names");
	  var monthName  = new Array();
	  monthName = monthNamesStr.split(",");
	  
	   // 从默认资源文件获取月简写标签
	  var shortMonthNamesStr = Data_GetResourceString("calendar.month.shortNames");
	  var shortMonthName  = new Array();
	  shortMonthName = shortMonthNamesStr.split(",");
	  
	  var o = {   
				  "M+" :  this.getMonth()+1,                  //month   
				  "d+" :  this.getDate(),                     //day   
				  "E+" :  weekDay[this.getDay()],           //week
				  "H+" :  this.getHours(),                    //hour   
			      "m+" :  this.getMinutes(),                  //minute   
			      "s+" :  this.getSeconds(),                  //second   
			      "q+" :  Math.floor((this.getMonth()+3)/3),  //quarter   
			      "S"  :  this.getMilliseconds()              // millisecond
  			  }   
   
	//用年替换"yyyy"
  if(/(y+)/.test(format)) 
  {   
  	     format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  }   
  
  for(var k in o) 
  {  
		if(new RegExp("("+ k +")").test(format)) 
		{ 
			if("E" != RegExp.$1.substr(0,1) && "M" != RegExp.$1.substr(0,1))
			{	
				format = format.replace(RegExp.$1, RegExp.$1.length==1? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
			}
	   }
  }

  for(var k in o) 
  {  
		if(new RegExp("("+ k +")").test(format)) 
		{ 
			//用星期替换“E”
			if ("E" == RegExp.$1.substr(0,1))
			{
				format = format.replace(RegExp.$1, o[k]); 
			}

			//替换月份
			if ("M" == RegExp.$1.substr(0,1))
			{
				//如果format中“M”位数为2，则用数字月份替换“M”，如08
				if (RegExp.$1.length == 2)
				{
					format = format.replace(RegExp.$1, ("00"+ o[k]).substr((""+ o[k]).length)); 
				}
				//如果format中“M”位数大于2，则用英文月份替换“M”，如Aug
				if (RegExp.$1.length == 3)
				{
					format = format.replace(RegExp.$1, shortMonthName[o[k]-1]); 
				}
				//如果format中“M”位数大于2，则用英文月份替换“M”，如Augest
				if (RegExp.$1.length == 4)
				{
					format = format.replace(RegExp.$1, monthName[o[k]-1]); 
				}
				
			}
		}   
  }
   
	return format;
}