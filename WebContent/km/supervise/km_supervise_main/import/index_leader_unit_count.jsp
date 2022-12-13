<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
{$
<div class="lui_scrp_item">
   <div class="lui_scrp_item_wrap">
	   <div class="lui_scrp_item_tit">
	     <p class="lui_scrp_item_tit_words"><bean:message key="py.zhuBanDanWeiShuLiangTongJi" bundle="km-supervise"/></p>
	   </div>
       <div class="lui_scrp_item_content">
           <div class="lui_scrp_item_content_wrap">
             <ul class="lui_scrp_item_content_bar">
$}
   	for(var i=0; i < data.length; i++){
		var percentage = data[i].percentage;
       		{$
             	<li>
                	<div class="lui_scrpicb_inner">
                    	<p class="lui_scrpicb_inner_desc">
                        	<p class="lui_scrpicb_inner_desc_words">{%data[i].fdName%}：{%data[i].count%}</p>
                        </p>
                        <span class="lui_supervise_progress_leader">
                        	<span class="lui_supervise_bar">
                            	<div class="lui_supervise_inner_bar com_bgcolor_d" style="width:{%percentage%}"></div>
                            </span>
                        </span>
                   </div>
				</li>
          	$}
	}
                        
{$
        </ul>
      </div>
    </div>
  </div>
</div>
$}