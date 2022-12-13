<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script language="JavaScript">
(function(){
	var path="/sys/lbpmservice/operation/handler/";
	lbpm.globals.includeFile(path+"operation_handler_assign.js");
	lbpm.globals.includeFile(path+"operation_handler_assignpass.js");
	lbpm.globals.includeFile(path+"operation_handler_assigncancel.js");
	lbpm.globals.includeFile(path+"operation_handler_assignrefuse.js");
})();

//定义常量
(function(constant){
	constant.opt.Assignee='<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.handlerOperationType.people" />'; //人员;
	constant.opt.AssigneeIsNull='<bean:message bundle="sys-lbpmservice" key="lbpmNode.validate.toOtherHandlerIds.assign.isNull" />';
	constant.opt.AssignCheckObj='<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle.check.assign.obj" />';
	constant.opt.AssignNeedSelectCanceler='<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.assign.NeedSelectCanceler" />';
	constant.opt.AssignMustSignYourSuggestion='<bean:message bundle="sys-lbpmservice" key="lbpmNode.mustSignYourSuggestion" />';
	constant.opt.AssignAllowMulti='<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.operationsTDTitle_Scope.allow.muti" />';
})(lbpm.constant);

function getCurrAssignRelationInfo() {
	var relationInfoObj = getAssignRelationInfoByWorkitemId(lbpm.nowProcessorInfoObj.id);
	return relationInfoObj;
};

function getAssignRelationInfoByWorkitemId(id) {
	var relationInfoObj = getAssignRelationInfo();
	if(relationInfoObj==null) return [];
	var rtn = [];
	for ( var i = 0; i < relationInfoObj.length; i++) {
		if (relationInfoObj[i].srcId == id) {
			rtn.push(relationInfoObj[i]);
		}
	}
	return rtn;
};

function getAssignRelationInfo() {
	var relationInfoXML=lbpm.globals.getOperationParameterJson("relations",true);
	if(relationInfoXML==null) return null;
	var relationInfoObj = WorkFlow_LoadXMLData(relationInfoXML);
	return relationInfoObj;
};
</script>

