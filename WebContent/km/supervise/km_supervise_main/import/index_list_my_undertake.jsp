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
	                    $}
	                    		var isDelayNotBack = data[i].isDelayNotBack;
	                    		if(isDelayNotBack == true){
                    				{$
	                    			<div class="lui_sclipici_content_info_date" title="反馈日">{%data[i].currentBackDay%}<span class="label_status label_status_defer_unfeedback">超期未反馈</span></div>
	                    			$}
	                    		}else{
		                    		var isBack = data[i].isBack;
		                    		if(isBack == true){
		                    			{$
		                    			<div class="lui_sclipici_content_info_date" title="反馈日">{%data[i].currentBackDay%}<sapn class="label_status label_status_normal">已反馈</span></div>
		                    			
		                    			$}
		                    			
		                    		}else if(isBack == false){
		                    			{$
		                    			<div class="lui_sclipici_content_info_date" title="下一个反馈日">{%data[i].currentBackDay%}<span class="label_status label_status_unfeedbacked ">未反馈</span></div>
		                    			
		                    			$}
		                    		} 
	                    		}
	                    {$
	                            <div class="lui_sclipici_content_info_status" title="承办阶段">
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
		<a href="javascript:void(0);" onclick="showMore('/km/supervise/#j_path=%2FmyUndertake&mydoc=undertake')"  class="lui_sclp_item_more" >
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