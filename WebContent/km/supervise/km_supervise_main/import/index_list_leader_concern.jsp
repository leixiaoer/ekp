<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.length > 0){
	{$
		<ul class="lui_sclp_item_content">
	$}
	var length = data.length;
	for(var i=0; i < length; i++){
		{$
		
			<li class="lui_sclp_item_content_item" >
				<a onclick="viewDoc('{%data[i].href%}')">
				<div class="lui_sclp_item_content_item_wrap">
					<div>
						<div class="lui_sclipici_tit">
							<h3>{%data[i].docSubject%}</h3>
		$}
						var fdStatus = data[i].fdStatus;
						if(fdStatus == '30'){
							{$
							<span class="lui_sclipici_tit_flag tit_flag_red">已超期</span>
							$}
						}else if(fdStatus == '20'){
							{$
							<span class="lui_sclipici_tit_flag tit_flag_red">即将超期</span>
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
}else{
	{$
	<div class="lui_supervise_content_noData">
	<%@ include file="/resource/jsp/listview_norecord.jsp"%>
	</div>
	$}
}