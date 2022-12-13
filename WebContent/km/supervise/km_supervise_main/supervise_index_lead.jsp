<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!-- 督办审核页面 -->
<template:include ref="default.simple" bodyClass="lui_list_content_body">
	<template:replace name="head">
		<%@ include file="/sys/ui/jsp/jshead.jsp"%>
		<script src="${ LUI_ContextPath }/sys/ui/extend/template/module/simple.js?s_cache=${LUI_Cache}"></script>
	    <link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
	    <link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/overview.css?s_cache=${LUI_Cache}"/>
	</template:replace>
	<template:replace name="body">
       	<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
		<div class="lui_supervise_wrap lui_supervise_leader">
		    <!-- 督办-领导视角布局-上 starts -->
		    <div class="lui_supervise_top">
		      <!-- 督办-领导视角布局-上-左 starts -->
		      <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
		      <div class="lui_supervise_topL">
		        <div class="lui_supervise_topL_wrap">
		          <a href="javascript:void(0);" class="lui_supervise_topL_card" onclick="addDoc()">
		            <div class="lui_supervise_topL_card_wrap">
		              <div class="lui_supervise_topL_card_create"></div>
		              <p class="lui_supervise_topL_card_desc"><bean:message key="py.xinJianDuBan" bundle="km-supervise"/></p>
		            </div>
		          </a>
		         
		          <!-- <a href="javascript:void(0);" class="lui_supervise_topL_card">
		            <div class="lui_supervise_topL_card_wrap">
		              <div class="lui_supervise_topL_card_panel"></div>
		              <p class="lui_supervise_topL_card_desc">督办看板</p>
		            </div>
		          </a> -->
		        </div>
		      </div>
		      </kmss:authShow>
		      <ui:dataview>
				<ui:source type="AjaxJson">
					{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getLeaderTopCount"}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/supervise/km_supervise_main/import/index_leader_top_r.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
		      </ui:dataview>
		      <script type="text/javascript">
		      		function toListView(href,param){
		      			window.parent.newPageWithParam(href,param);
		      		}	 
		      </script>
		    </div>
		    
		     <div class="lui_supervise_center">
		     	<div class="lui_supervise_center_left">
        			<div class="lui_supervise_center_left_panel">
						<div class="lui_sclp_wrap">
			       			<div>
					          	<ui:tabpanel>
									<ui:content title="${lfn:message('km-supervise:py.WoFenGuande') }">
						              	<ui:iframe id="indexListFrame" src="${LUI_ContextPath }/km/supervise/km_supervise_main/import/index_list_frame.jsp?fdType=myManage"></ui:iframe>
									</ui:content>
								</ui:tabpanel>
								<ui:tabpanel>
									<ui:content title="${lfn:message('km-supervise:py.lingDaoGuanZhuDe') }">
						              	<ui:iframe id="indexListFrame2" src="${LUI_ContextPath }/km/supervise/km_supervise_main/import/index_list_frame.jsp?fdType=leadConcern"></ui:iframe>
									</ui:content>
									<ui:content title="${lfn:message('km-supervise:py.WoGuanZhuDe') }">
						              	<ui:iframe id="indexListFrame3" src="${LUI_ContextPath }/km/supervise/km_supervise_main/import/index_list_frame.jsp?fdType=myConcern"></ui:iframe>
									</ui:content>
								</ui:tabpanel>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="lui_supervise_center_right">
        			<div class="lui_supervise_center_right_panel">
          				<div class="lui_scrp_wrap">
            				<div>
						    	<div class="lui_scrp_item">
						        	<div class="lui_scrp_item_wrap">
						            	<div class="lui_scrp_item_tit">
						                	<p class="lui_scrp_item_tit_words"><bean:message key="py.duBanFenLeiTongJi" bundle="km-supervise"/></p>
						                </div>
						                <div class="lui_scrp_item_content">
						                	<div class="lui_scrp_item_content_wrap">
							                	<ui:chart width="408px" height="300px">
								  					<ui:source type="AjaxJson">
														{"url":"/km/supervise/km_supervise_main/kmSuperviseMain.do?method=overviewChart&type=template"}
								  					</ui:source>
												</ui:chart>
						                	</div>
						                </div>
						         	</div>
						         </div>
								<ui:dataview>
							     	<ui:source type="AjaxJson">
										{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getSysUnitCount"}
									</ui:source>
									<ui:render type="Template">
										<c:import url="/km/supervise/km_supervise_main/import/index_leader_unit_count.jsp" charEncoding="UTF-8"></c:import>
									</ui:render>
								 </ui:dataview>
			
								 <ui:dataview>
								 	<ui:source type="AjaxJson">
										{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getLeadCount"}
									</ui:source>
									<ui:render type="Template">
										<c:import url="/km/supervise/km_supervise_main/import/index_leader_lead_count.jsp" charEncoding="UTF-8"></c:import>
									</ui:render>
								</ui:dataview>            
							</div>
          				</div>
        			</div>
      			</div>
			</div>
    	</div>
    	<script>
		seajs.use(['lui/jquery','lui/dialog'],function($,dialog){
			var cateId= '';
			//新建督办
	    	window.addDoc = function() {
	    		dialog.categoryForNewFile(
	    				'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	    				'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}',false,null,null,cateId,null,null,true,null,{"fdType":"10"});
	    	}
			
		});
		</script>
	</template:replace>	
</template:include>