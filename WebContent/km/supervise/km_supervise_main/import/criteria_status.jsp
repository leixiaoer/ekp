<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
{$
<div class="lui_supervise_criterions">
	<div class="lui_supervise_criterion_item">
		<div class="lui_supervise_criterion_title"><bean:message key="enums.status.stage" bundle="km-supervise"/>：</div>
        <div class="lui_supervise_criterion_selectBox">
             <ul>
                 <li class="lui_supervise_criterion_selectItem sclpitl_item_active lui_text_primary" onclick="planStatusChange('',this)">
                     <span ><bean:message key="py.status.all" bundle="km-supervise"/></span>
                 </li>
                 <li class="lui_supervise_criterion_selectItem" onclick="planStatusChange('0',this)">
                     <span><bean:message key="py.status.start.soon" bundle="km-supervise"/></span>
                 </li>
                 <li class="lui_supervise_criterion_selectItem" onclick="planStatusChange('1',this)">
                     <span><bean:message key="py.status.doing" bundle="km-supervise"/></span>
                 </li>
                 <li class="lui_supervise_criterion_selectItem" onclick="planStatusChange('2',this)">
                     <span><bean:message key="py.status.finish" bundle="km-supervise"/></span>
                 </li>
             </ul>
    	</div>
	</div>
</div>
$}
