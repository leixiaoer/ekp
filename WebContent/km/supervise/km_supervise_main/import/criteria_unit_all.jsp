<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.length > 0){
{$
<div class="lui_supervise_criterions">
	<div class="lui_supervise_criterion_item">
        <div class="lui_supervise_criterion_title"><bean:message key="py.criteria.unit" bundle="km-supervise"/>：</div>
        <div class="lui_supervise_criterion_selectBox">
        	<ul>
            	<li class="lui_supervise_criterion_selectItem sclpitl_item_active lui_text_primary" onclick="allUnitChange('',this)">
                	<span><bean:message key="py.criteria.unit.all" bundle="km-supervise"/></span>
                </li>
$}
	for(var i = 0; i < data.length; i++){
		var value = data[i].value;
		{$
				<li class="lui_supervise_criterion_selectItem" onclick="allUnitChange('{%value%}',this)">
	                <span>{% data[i].text %}</span>
	            </li>
		$}
	}
{$
			</ul>
		</div>
	</div>
</div>
$}
}

