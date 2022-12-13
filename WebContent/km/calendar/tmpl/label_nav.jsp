<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
var __exceptLabelIds = exceptLabelIds || '';
var className = __exceptLabelIds.indexOf('myEvent') > -1 ? 'label_div_off' : 'label_div_on';
className += ' lui_calendar_color_event';
{$
<li style="cursor: pointer;">
	<a href="javascript:void(0);" onclick="clickLabel(this,'myEvent');">
		<div class="{%className%}"></div>
			${ lfn:message('km-calendar:kmCalendar.nav.title') }
	</a>
</li>
$}
for(var i=0;i<data.length;i++){
	className = __exceptLabelIds.indexOf(data[i].fdId) > -1 ? 'label_div_off' : 'label_div_on';
	{$
	<li style="cursor: pointer;">
		<a href="javascript:void(0);"  onclick="clickLabel(this,'{%data[i].fdId%}');" >
			<div style="background-color: {%data[i].fdColor%};" class="{%className%}"></div>
			{%data[i].fdName%}
		</a>
	</li>
	$}
}
className = __exceptLabelIds.indexOf('myGroupEvent') > -1 ? 'label_div_off' : 'label_div_on';
className += ' lui_calendar_color_groupEvent';
{$
<li style="cursor: pointer;">
	<a href="javascript:void(0);" onclick="clickLabel(this,'myGroupEvent');">
		<div class="{%className%}"></div>
			${ lfn:message('km-calendar:kmCalendarMain.group.header.title') }
	</a>
</li>
$}
className = __exceptLabelIds.indexOf('myNote') > -1 ? 'label_div_off' : 'label_div_on';
className += ' lui_calendar_color_note';
{$
<li style="cursor: pointer;">
  	<a href="javascript:void(0);"  onclick="clickLabel(this,'myNote');">
  		<div  class="{%className%}"></div>
  		${ lfn:message('km-calendar:module.km.calendar.tree.my.note') }
  	</a>
 </li>
 $}