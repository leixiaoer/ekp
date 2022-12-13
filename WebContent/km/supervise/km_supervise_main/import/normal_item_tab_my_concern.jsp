<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
	for(var i=0; i < data.length; i++){
	{$
	<ul class="lui_sclp_item_tab">
      	<li class="lui_sclp_item_tab_left">
        	<p class="lui_sclpitl_item sclpitl_item_active lui_text_primary" onclick="changeStatus('myConcern','all',this)"><bean:message key="py.quanBu" bundle="km-supervise"/>({%data[i].allCount%})</p>
        	<p class="lui_sclpitl_item" onclick="changeStatus('myConcern','delay',this)"><bean:message key="enums.status.delay" bundle="km-supervise"/>({%data[i].delayCount%})</p>
        	<p class="lui_sclpitl_item" onclick="changeStatus('myConcern','soonDelay',this)"><bean:message key="enums.status.soon.delay" bundle="km-supervise"/>({%data[i].soonDelayCount%})</p>
        	<p class="lui_sclpitl_item" onclick="changeStatus('myConcern','concern',this)"><bean:message key="py.lingDaoGuanZhu" bundle="km-supervise"/>({%data[i].leadConcernCount%})</p>
      	</li>
        <li class="lui_sclp_item_tab_right">
        	<p><bean:message key="enums.status.stage" bundle="km-supervise"/>：</p>
        	<p class="lui_sclpitr_warning"><bean:message key="enums.status.delay" bundle="km-supervise"/></p>
        	<p class="lui_sclpitr_normal"><bean:message key="enums.status.normal" bundle="km-supervise"/></p>
        </li>
    </ul>
	$}
	}
}