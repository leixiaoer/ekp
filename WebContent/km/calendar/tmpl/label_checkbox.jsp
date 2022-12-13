<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
{$
	<span style="display:inline-block">
	<input type="checkbox"  name="label_checkbox" value="myEvent"  onclick="clickCheckbox(this)"/>
	${ lfn:message('km-calendar:kmCalendar.nav.title') }
	</span>
$}
for(var i=0;i<data.length;i++){
	{$
		<span style="display:inline-block">
		<input type="checkbox"  name="label_checkbox" value="{%data[i].fdId%}"  onclick="clickCheckbox(this)"/>
		{%data[i].fdName%}
		</span>
	$}
}
{$
	<span style="display:inline-block">
	<input type="checkbox"  name="label_checkbox" value="myGroupEvent"  onclick="clickCheckbox(this)"/>
	${ lfn:message('km-calendar:kmCalendarMain.group.header.title') }
	</span>
$}
{$
	<span style="display:inline-block">
	<input type="checkbox"  name="label_checkbox" value="myNote"  onclick="clickCheckbox(this)"/>
	${ lfn:message('km-calendar:module.km.calendar.tree.my.note') }
	</span>
$}
