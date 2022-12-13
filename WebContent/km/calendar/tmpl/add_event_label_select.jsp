<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
{$<select name="labelId" class="fixedSelect" style="width: 85px;">
		<option value="myEvent">
			${ lfn:message('km-calendar:kmCalendar.nav.title') }
		</option>
$}
for(var i=0;i<data.length;i++){
	{$
		<option value="{%data[i].fdId%}">{%data[i].fdName%}</option>
	$}
}
{$</select>$}