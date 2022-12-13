<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>
[ 
	{ 
		moveTo : "taskView", 
		<c:choose>
			<c:when test="${JsParam.fdStatus ne '3'}">
				text : "<bean:message bundle="km-asset" key="enumeration_km_asset_apply_task_detail_fd_status_1"/>",
			</c:when>
			<c:otherwise>
				text : "<bean:message bundle="km-asset" key="kmAssetApplyTask.noInventory"/>",
			</c:otherwise>
		</c:choose> 
		selected : true 
	},
	{ 
		moveTo : "taskEndView", 
		text : "<bean:message bundle="km-asset" key="kmAssetApplyTask.hasBeenInventroied"/>"
	},
	{   
		moveTo : "profitView", 
		text : "<bean:message bundle="km-asset" key="enumeration_km_asset_apply_task_detail_fd_status_2"/>"
	},
	{   
		moveTo : "PersonView", 
		text : "<bean:message bundle="km-asset" key="kmAssetApplyTask.kmAssignPersonnelIds"/>"
	}
]
