<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
{$
<div class="lui_supervise_topR">
	<ul class="lui_supervise_topR_wrap card_width">
	$}
		for(var i=0; i < data.length; i++){
		{$
		<li>
			<div class="lui_supervise_topR_card" onclick="javascript:toListView('/createReview',{cri:{'cri.q':'allCount:true'}})">
				<div class="lui_supervise_topR_card_wrap">
		        	<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].allCount%}</p>
		            <p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.total" bundle="km-supervise"/></p>
		        </div>
		    </div>
		</li>
		<li>
			<div class="lui_supervise_topR_card" onclick="javascript:toListView('/createReview',{cri:{'cri.q':'docStatus:20'}})">
				<div class="lui_supervise_topR_card_wrap">
		        	<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].examineCount%}</p>
		            <p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.examine" bundle="km-supervise"/></p>
		        </div>
		    </div>
		</li>
		<li>
			<div class="lui_supervise_topR_card" onclick="javascript:toListView('/ItemView',{cri:{'cri.q':'fdStatus:00'}})">
			    <div class="lui_supervise_topR_card_wrap">
			    	<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].soonStartCount%}</p>
			        <p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.soon.start" bundle="km-supervise"/></p>
			    </div>
			</div>
		</li>
		<li>
			<div class="lui_supervise_topR_card" onclick="javascript:toListView('/ItemView',{cri:{'cri.q':'fdStatus:10'}})">
		    	<div class="lui_supervise_topR_card_wrap">
		        	<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].normalCount%}</p>
		            <p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.normal" bundle="km-supervise"/></p>
		        </div>
		    </div>
		</li>
		<li>
			<div class="lui_supervise_topR_card" onclick="javascript:toListView('/ItemView',{cri:{'cri.q':'fdStatus:20'}})">
			    <div class="lui_supervise_topR_card_wrap">
		        	<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].soonDelayCount%}</p>
		            <p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.soon.delay" bundle="km-supervise"/></p>
		        </div>
		   	</div>
		</li>
		<li>
	    	<div class="lui_supervise_topR_card" onclick="javascript:toListView('/ItemView',{cri:{'cri.q':'fdStatus:30'}})">
		 		<div class="lui_supervise_topR_card_wrap">
		      		<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].delayCount%}</p>
		            <p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.delay" bundle="km-supervise"/></p>
		        </div>
		    </div>
		</li>
		<li>
	    	<div class="lui_supervise_topR_card" onclick="javascript:toListView('/ItemView',{cri:{'cri.q':'fdStatus:35'}})">
		 		<div class="lui_supervise_topR_card_wrap">
		      		<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].delayFinshCount%}</p>
		            <p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.delayFinsh" bundle="km-supervise"/></p>
		        </div>
		    </div>
		</li>
		<li>
        	<div class="lui_supervise_topR_card" onclick="javascript:toListView('/ItemView',{cri:{'cri.q':'fdStatus:38'}})">
            	<div class="lui_supervise_topR_card_wrap">
                	<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].normalFinshCount%}</p>
                	<p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.normalFinsh" bundle="km-supervise"/></p>
             	</div>
            </div>
    	</li>
        <li>
        	<div class="lui_supervise_topR_card" onclick="javascript:toListView('/ItemView',{cri:{'cri.q':'fdStatus:50'}})">
            	<div class="lui_supervise_topR_card_wrap">
               		<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].stopCount%}</p>
                	<p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.stop" bundle="km-supervise"/></p>
             	</div>
            </div>
        </li>
        <li>
        	<div class="lui_supervise_topR_card" onclick="javascript:toListView('/ItemView',{cri:{'cri.q':'fdStatus:60'}})">
            	<div class="lui_supervise_topR_card_wrap">
               		<p class="lui_supervise_topR_card_num lui_text_primary">{%data[i].changeCount%}</p>
                	<p class="lui_supervise_topR_card_desc"><bean:message key="enums.status.change" bundle="km-supervise"/></p>
             	</div>
            </div>
        </li>
        $}
		}
		{$
	</ul>
</div>
$}