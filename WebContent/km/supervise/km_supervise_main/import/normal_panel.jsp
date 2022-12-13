<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

if(data.length > 0){
	for(var i=0; i < data.length; i++){
	{$
	<div class="lui_supervise_leftC">
	  <div class="lui_supervise_leftC_panel">
	    <ul class="lui_supervise_leftC_panel_wrap">
	      <li class="lui_supervise_leftC_panel_item " onclick="loadData('myCharge',this)">
	        <div>
	          <h3 class="lui_slpi_tit lui_text_primary">我负责的({%data[i].myChargeCount%})</h3>
	          <ul class="lui_slpi_content">
	            <li class="lui_slpi_content_item">
	              <div>
	                <p class="lui_slpi_content_item_num">{%data[i].myChargeSoonDelayCount%}</p>
	                <p class="lui_slpi_content_item_desc">即将超期</p>
	              </div>
	            </li>
	            <li class="lui_slpi_content_item">
	              <div>
	                <p class="lui_slpi_content_item_num">{%data[i].myChargeDelayCount%}</p>
	                <p class="lui_slpi_content_item_desc">已超期</p>
	              </div>
	            </li>
	          </ul>
	        </div>
	      </li>
	      <li class="lui_supervise_leftC_panel_item" onclick="loadData('myUndertake',this)">
	        <div>
	          <h3 class="lui_slpi_tit">我承办的({%data[i].myUndertakeCount%})</h3>
	          <ul class="lui_slpi_content">
	            <li class="lui_slpi_content_item">
	              <div>
	                <p class="lui_slpi_content_item_num">{%data[i].myUndertakeSoonBackCount%}</p>
	                <p class="lui_slpi_content_item_desc">即将反馈</p>
	              </div>
	            </li>
	            <li class="lui_slpi_content_item">
	              <div>
	                <p class="lui_slpi_content_item_num">{%data[i].myUndertakeDelayBackCount%}</p>
	                <p class="lui_slpi_content_item_desc">超期未反馈</p>
	              </div>
	            </li>
	          </ul>
	        </div>
	      </li>
	      <li class="lui_supervise_leftC_panel_item" onclick="loadData('leadConcern',this)">
	        <div>
	          <h3 class="lui_slpi_tit">领导关注的({%data[i].leadConcernCount%})</h3>
	          <ul class="lui_slpi_content">
	            <li class="lui_slpi_content_item">
	              <div>
	                <p class="lui_slpi_content_item_num">{%data[i].leadConcernSoonDelayCount%}</p>
	                <p class="lui_slpi_content_item_desc">即将超期</p>
	              </div>
	            </li>
	            <li class="lui_slpi_content_item">
	              <div>
	                <p class="lui_slpi_content_item_num">{%data[i].leadConcernDelayCount%}</p>
	                <p class="lui_slpi_content_item_desc">已超期</p>
	              </div>
	            </li>
	          </ul>
	        </div>
	      </li>
	      <li class="lui_supervise_leftC_panel_item" onclick="loadData('myConcern',this)">
	        <div>
	          <h3 class="lui_slpi_tit">我关注的({%data[i].myConcernCount%})</h3>
	          <ul class="lui_slpi_content">
	            <li class="lui_slpi_content_item">
	              <div>
	                <p class="lui_slpi_content_item_num">{%data[i].myConcernSoonDelayCount%}</p>
	                <p class="lui_slpi_content_item_desc">即将超期</p>
	              </div>
	            </li>
	            <li class="lui_slpi_content_item">
	              <div>
	                <p class="lui_slpi_content_item_num">{%data[i].myConcernDelayCount%}</p>
	                <p class="lui_slpi_content_item_desc">已超期</p>
	              </div>
	            </li>
	          </ul>
	        </div>
	      </li>
	    </ul>
	  </div>
	</div>
	
	$}
	}
}