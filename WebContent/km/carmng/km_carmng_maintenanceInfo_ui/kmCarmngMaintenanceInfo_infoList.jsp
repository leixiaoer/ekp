<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<div id="list_content"> 
			<list:listview>
				<ui:source type="AjaxJson">
					{"url":"/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfoIndex.do?method=list&fdCarId=${JsParam.fdCarId}&flag=true"}
				</ui:source>
				<list:colTable isDefault="true" layout="sys.ui.listview.listtable" onRowClick="maintenanceInfo('!{fdId}');" cfg-norecodeLayout="simple">
				    <list:col-serial></list:col-serial>
					<list:col-auto props="fdVehiclesInfo.fdNo;fdMaintenanceTime;fdMaintenanceFee;fdPersonName;fdRepairFee;docCreator.fdName;docCreateTime"></list:col-auto>
					<kmss:auth requestURL="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=edit" requestMethod="GET">
						<list:col-html title="${ lfn:message('km-carmng:km.carmng.operation') }" style="width:5%">
							{$
								<a class='com_btn_link' href="javascript:void(0)" onclick="deleteConfirm('{%row['fdId']%}');">
	                               ${lfn:message('button.delete')}</a>
							$}
						</list:col-html>
					</kmss:auth>	
				</list:colTable>
				<script>
					  seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($,dialog,topic) {
							window.del_load = dialog.loading();
							
							window.maintenanceInfo = function(fdId){
								dialog.iframe("/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=view&fdId="+fdId,"${lfn:message('km-carmng:table.kmCarmngMaintenanceInfo')}",null,{
									width : 988,
									height : 550
								});
	            			};
	            			//删除
	        	    		window.deleteConfirm = function(fdId){
	        			    	dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
	        						if(value==true){
	        							$.get('${LUI_ContextPath}/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=delete&fdId='+fdId,
	        									null,delCallback,'json');
	          					    }
	                	        });
	        			    };

	        			    window.delCallback = function(data) {
	        					if (data != null && data.status == true) {
	        						topic.publish("list.refresh");
	        						dialog.success('<bean:message key="return.optSuccess" />');
	        						} else {
	        						dialog.failure('<bean:message key="return.optFailure" />');
	        						}
	        				};
					   });
				</script>
				<ui:event topic="list.loaded">  
				  	if(window.del_load!=null){
			           window.del_load.hide();
			         }
					seajs.use(['lui/jquery'], function($) {
						try {
							if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
								window.frameElement.style.height = ($(document.body).height()+40) + "px";
							}
						}catch(e) {
						}
					});
				</ui:event>			
			</list:listview>
			<list:paging layout="sys.ui.paging.simple"></list:paging>
		</div>
	</template:replace>
</template:include>