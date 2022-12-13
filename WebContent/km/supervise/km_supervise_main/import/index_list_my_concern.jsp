<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.length > 0){
	{$
		<ul class="lui_sclp_item_content">
	$}
	var length = data.length;
	if(data.length > 5){
		length = 5;
	}
	for(var i=0; i < length; i++){
		{$
		
			<li class="lui_sclp_item_content_item" >
				<a onclick="viewDoc('{%data[i].href%}')">
				<div class="lui_sclp_item_content_item_wrap">
					<div>
						<div class="lui_sclipici_tit">
							<h3>{%data[i].docSubject%}</h3>
		$}
						var isLeadConcern = data[i].isLeadConcern;
						if(isLeadConcern == true){
							{$
							<span class="lui_sclipici_tit_flag tit_flag_purple">领导关注</span>
							$}
						}
						var fdStatus = data[i].fdStatus;
						if(fdStatus == "20"){
							{$
							<span class="lui_sclipici_tit_flag tit_flag_orange">即将超期</span>
							$}
						}else if(fdStatus == "30"){
							{$
							<span class="lui_sclipici_tit_flag tit_flag_red">已超期</span>
							$}
						}
						{$
					    </div>
					    <ul class="lui_sclipici_content">
					    	<li>
                          		<div class="lui_sclipici_content_text">
                            		{%data[i].fdContent%}
                          		</div>
                        	</li>
                        	<li>
	                          	<div class="lui_sclipici_content_info">
	                            <div class="lui_sclipici_content_info_date" title="督办时间">{%data[i].fdStartTime%}~{%data[i].fdFinishTime%}</div>
	                            <div class="lui_sclipici_content_info_department" title="主办单位">{%data[i].fdUnitName%}</div>
	                            <div class="lui_sclipici_content_info_status" title="进行中的阶段">
	                    $}
	                    		var tasks = data[i].tasks;
	                    		for(var j = 0;j< tasks.length ;j++){
	                    			var isTaskDelay = tasks[j].isDelay;
	                    			if(isTaskDelay == true){
	                    				{$
	                    				<span class="lui_sclipicicis_warning">{%tasks[j].fdOrder%}</span>
	                    				$}
	                    			}else{
	                    				{$
	                    				<span class="lui_sclipicicis_normal">{%tasks[j].fdOrder%}</span>
	                    				$}
	                    			}
	                    		}
	    {$
	                            </div>
	                          	</div>
                        	</li>
                        	<li>
                          		<div class="lui_sclipici_content_people" title="关注领导">{%data[i].fdConcernNames%}</div>
                        	</li>
                        </ul>
                    </div>
        		</div>
        		</a>
        	</li>
		$}
	}
	{$
		</ul>
	$}
	if(data.length > 5){
	{$
		<a href="javascript:void(0);" onclick="showMore('/km/supervise/#j_path=%2FmyConcern&mydoc=concern')"   class="lui_sclp_item_more">
			<div class="lui_sclp_item_more_wrap sclpitl_item_active lui_text_primary">查看更多<i class="lui_arrow arrow_right"></i></div>
		</a>
	$}
	}
}else{
	{$
	<div class="lui_supervise_content_noData">
	<%@ include file="/resource/jsp/listview_norecord.jsp"%>
	</div>
	$}
}