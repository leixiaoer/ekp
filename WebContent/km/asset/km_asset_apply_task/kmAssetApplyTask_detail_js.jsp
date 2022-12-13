<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>	

	<script>
	var trIndex = 0;
	var fdOrder = 0;
	
    function loadTaskDetail(manualLoad){
    	if(manualLoad === null || manualLoad === undefined){
    		manualLoad = true;
    	}
    	
		var url = "${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_task/kmAssetApplyTask.do?method=loadEnableAssetCard";
		var taskId = $("input[name='fdId']").val();
		var fdPurchaseTime = $("select[name='fdPurchaseTime']").val();
		var fdStartDate = $("input[name='fdStartDate']").val();
		var fdEndDate = $("input[name='fdEndDate']").val();
		var fdAssetCategory = $("input[name='fdAssetCategoryId']").val();
		var fdAssetAddress = $("select[name='fdAssetAddressId']").val();
		var fdAssignUser = $("select[name='fdAssignUser']").val();
		url = Com_SetUrlParameter(url,"fdPurchaseTime",fdPurchaseTime);
		url = Com_SetUrlParameter(url,"fdStartDate",fdStartDate);
		url = Com_SetUrlParameter(url,"fdEndDate",fdEndDate);
		url = Com_SetUrlParameter(url,"fdAssetCategory",fdAssetCategory);
		url = Com_SetUrlParameter(url,"fdAssetAddress",fdAssetAddress);
		url = Com_SetUrlParameter(url,"taskId",taskId);
		url = Com_SetUrlParameter(url,"fdAssignUser",fdAssignUser);
		var data = new KMSSData();
		data.SendToUrl(url,function(data) {
		var results = eval("(" + data.responseText + ")");
		seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic){
			if(results.length == 0){
				$("#detailTB >tbody> tr:first").nextAll().remove();//清除已有的记录
				trIndex = 0;
				fdOrder = 0;
				if(manualLoad){
					dialog.alert('<bean:message key="kmAssetApplyTask.alert" bundle="km-asset"/>');
				}
				return;
			}else{
				var len = $("#detailTB >tbody> tr").length;
				if(len>1){
					if(manualLoad){
						dialog.confirm('<bean:message key="kmAssetApplyTask.comfirm" bundle="km-asset"/>',function(value){
							if(value==false){
								return;
							}else{
								$("#detailTB >tbody> tr:first").nextAll().remove();//清除已有的记录 
								trIndex = 0;
								fdOrder = 0;
								bulidTrObj(results);
							}
						});
					}else{
						$("#detailTB >tbody> tr:first").nextAll().remove();//清除已有的记录 
						trIndex = 0;
						fdOrder = 0;
						bulidTrObj(results);
					}
				}else{
					$("#detailTB >tbody> tr:first").nextAll().remove();//清除已有的记录 
					trIndex = 0;
					fdOrder = 0;
					bulidTrObj(results);
				}
			}
		});
	},false); 
	}
	//链接至资产卡片
	function openUrl(fdId){
		window.open('<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=view&fdId='+fdId,"_blank");
	}
	
	function DocList_DeleteRow(i){
		var optTR = DocListFunc_GetParentByTagName("TR");
		var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
		var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
		optTB.deleteRow(rowIndex);
		refreshTbIndex("detailTB", rowIndex);
    }
	
	function refreshTbIndex(tbId, rowIndex){
		var optTB = document.getElementById(tbId);
		for(var j = rowIndex; j<optTB.rows.length; j++){
			optTB.rows[j].cells[0].innerHTML = j;
		}
	}
	
	function DocListFunc_GetParentByTagName(tagName, obj){
		if(obj==null){
			if(Com_Parameter.IE)
				obj = event.srcElement;
			else
				obj = Com_GetEventObject().target;
		}
		for(; obj!=null; obj = obj.parentNode)
			if(obj.tagName == tagName)
				return obj;
	}
	
	function bulidTrObj(results){
		for (var i = 0; i < results.length; i++) {
			trHTML = '<tr align="center">';
			trHTML += '<td>'+(fdOrder+1)+'</td>';
			//资产状态
			trHTML += '<td>';		
			trHTML += '<input type="hidden" name="fdTaskDetailForms['+ trIndex+'].fdTaskId" value="${kmAssetApplyTaskForm.fdId}"/>';
			trHTML += '<input type="hidden" name="fdTaskDetailForms['+ trIndex+ '].fdId" value="'+ results[i].fdDetailId+ '"/>';
			trHTML += '<input type="hidden" name="fdTaskDetailForms['+ trIndex+ '].fdAssetCardId" value="'+ results[i].fdCardId+ '"/>';
			trHTML += '<input type="hidden" name="fdTaskDetailForms['+ trIndex+ '].fdStatus" value="1"/>';
			trHTML += '<input type="hidden" class="hiddenPerson" name="fdTaskDetailForms['+ trIndex+ '].fdResponsiblePerson" value="'+ results[i].fdResponsiblePersonName+ '"/>';
		    trHTML += results[i].fdAssetStatus;
			trHTML += '</td>';
			//资产编号
			trHTML += '<td>';		
		    trHTML += results[i].fdCode;
			trHTML += '</td>';
			//资产名称
			trHTML += '<td>';
			trHTML += results[i].fdName;	
			trHTML += '<input type="hidden" name="fdTaskDetailForms['
				+ trIndex
				+ '].fdName" value="'
				+ results[i].fdName
				+ '"/>';
			trHTML += '</td>';
			//资产类别
			trHTML += '<td>';							
			trHTML += results[i].fdAssetCategoryName;										
			trHTML += '</td>';
			//规格型号			
			trHTML += '<td>';
			trHTML += results[i].fdCardStandard;											
			trHTML += '</td>';
			//责任人
			trHTML += '<td>';
			trHTML += results[i].fdResponsiblePersonName;				
			trHTML += '</td>';
			//操作
			trHTML += '<td align="center">';
			var fdCardIdValueStr = "'" + results[i].fdCardId + "'";
			trHTML += '<a style="color: #30abe4;" href="javascript:void(0);" onclick="openUrl('+fdCardIdValueStr+');"><bean:message bundle="km-asset" key="kmAssetCard.detail"/></a>';
			trHTML += '</td>';
			trHTML += '<td align="center">';
			trHTML +='<img src="${KMSS_Parameter_StylePath}icons/delete.gif" style="cursor:pointer" onclick="DocList_DeleteRow('+trIndex+')">';
			trHTML += '</td>';
			$("#detailTB").append(trHTML);
			trIndex++;
			fdOrder++;
		}
	}
	</script>