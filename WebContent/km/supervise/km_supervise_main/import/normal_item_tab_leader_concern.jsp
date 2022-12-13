<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
	for(var i=0; i < data.length; i++){
	{$
	<ul class="lui_sclp_item_tab">
      	<li class="lui_sclp_item_tab_left">
        	<p class="lui_sclpitl_item sclpitl_item_active lui_text_primary" onclick="changeStatus('leadConcern','all',this)"><bean:message key="py.quanBu" bundle="km-supervise"/>({%data[i].allCount%})</p>
        	<p class="lui_sclpitl_item" onclick="changeStatus('leadConcern','delay',this)"><bean:message key="enums.status.delay" bundle="km-supervise"/>({%data[i].delayCount%})</p>
        	<p class="lui_sclpitl_item" onclick="changeStatus('leadConcern','soonDelay',this)"><bean:message key="enums.status.soon.delay" bundle="km-supervise"/>({%data[i].soonDelayCount%})</p>
      	</li>
    </ul>
	$}
	}
}