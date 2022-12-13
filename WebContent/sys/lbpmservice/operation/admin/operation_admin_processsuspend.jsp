<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
( function(operations) {
	operations['admin_processSuspend'] = {
			click:OperationClick,
			check:OperationCheck,
			setOperationParam:setOperationParam
	};	
	//特权人操作： 流程暂停
	function OperationClick(operationName){
		//增加选择节点通知方式 add by wubing date:2015-05-06
		lbpm.globals.setAdminNodeNotifyType(lbpm.nowNodeId);
	};
	//“ 流程暂停”操作的检查
	function OperationCheck(){	
		return true;
	};	
	//" 流程暂停"操作的获取参数
	function setOperationParam(){};
})(lbpm.operations);