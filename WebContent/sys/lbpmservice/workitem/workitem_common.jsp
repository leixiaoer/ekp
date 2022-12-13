<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.lbpmservice.taglib.MultiLangTextGroupTag"%>

<script language="JavaScript">
var _isLangSuportEnabled = <%=MultiLangTextGroupTag.isLangSuportEnabled()%> ;
var _userLang = "<%=MultiLangTextGroupTag.getUserLangKey()%>";

var defaultUsageContent='<bean:message bundle="sys-lbpmservice" key="lbpmProcess.handler.usageContent.default" />';
var defaultUsageContent_refuse = "";
var defaultUsageContent_commission = "";
var defaultUsageContent_communicate = "";
var defaultUsageContent_abandon = "";
var defaultUsageContent_superRefuse = "";
var defaultUsageContent_sign = "";
var defaultUsageContent_additionSign = "";
var defaultUsageContent_assign = "";
var defaultUsageContent_assignPass = "";
var defaultUsageContent_assignRefuse = "";
var defaultUsageContent_jump = "";
var defaultUsageContent_nodeSuspend = "";
var defaultUsageContent_nodeResume = "";

var isPassContentRequired = "false";
var isRefuseContentRequired = "true";
var isCommissionContentRequired = "false";
var isCommunicateContentRequired = "true";
var isAbandonContentRequired = "true";
var isSuperRefuseContentRequired = "true";
var isSignContentRequired = "true";
var isAdditionSignContentRequired = "false";
var isAssignContentRequired = "false";
var isAssignPassContentRequired = "false";
var isAssignRefuseContentRequired = "false";
var isJumpContentRequired = "false";
var isNodeSuspendContentRequired = "false";
var isNodeResumeContentRequired = "false";

var data = new KMSSData();
data.AddBeanData("lbpmUsageContentService");
data = data.GetHashMapArray();
if(data.length>0){
	if(data[0].defaultUsageContent!=null){
		defaultUsageContent = unescape(data[0].defaultUsageContent);
	}
	if(data[0].defaultUsageContent_refuse!=null){
		defaultUsageContent_refuse = unescape(data[0].defaultUsageContent_refuse);
	}
	if(data[0].defaultUsageContent_commission!=null){
		defaultUsageContent_commission = unescape(data[0].defaultUsageContent_commission);
	}
	if(data[0].defaultUsageContent_communicate!=null){
		defaultUsageContent_communicate = unescape(data[0].defaultUsageContent_communicate);
	}
	if(data[0].defaultUsageContent_abandon!=null){
		defaultUsageContent_abandon = unescape(data[0].defaultUsageContent_abandon);
	}
	if(data[0].defaultUsageContent_superRefuse!=null){
		defaultUsageContent_superRefuse = unescape(data[0].defaultUsageContent_superRefuse);
	}
	if(data[0].defaultUsageContent_sign!=null){
		defaultUsageContent_sign = unescape(data[0].defaultUsageContent_sign);
	}
	if(data[0].defaultUsageContent_additionSign!=null){
		defaultUsageContent_additionSign = unescape(data[0].defaultUsageContent_additionSign);
	}
	if(data[0].defaultUsageContent_assign!=null){
		defaultUsageContent_assign = unescape(data[0].defaultUsageContent_assign);
	}
	if(data[0].defaultUsageContent_assignPass!=null){
		defaultUsageContent_assignPass = unescape(data[0].defaultUsageContent_assignPass);
	}
	if(data[0].defaultUsageContent_assignRefuse!=null){
		defaultUsageContent_assignRefuse = unescape(data[0].defaultUsageContent_assignRefuse);
	}
	if(data[0].defaultUsageContent_jump!=null){
		defaultUsageContent_jump = unescape(data[0].defaultUsageContent_jump);
	}
	if(data[0].defaultUsageContent_nodeSuspend!=null){
		defaultUsageContent_nodeSuspend = unescape(data[0].defaultUsageContent_nodeSuspend);
	}
	if(data[0].defaultUsageContent_nodeResume!=null){
		defaultUsageContent_nodeResume = unescape(data[0].defaultUsageContent_nodeResume);
	}
	if(data[0].isPassContentRequired!=null){
		isPassContentRequired = data[0].isPassContentRequired;
	}
	if(data[0].isRefuseContentRequired!=null){
		isRefuseContentRequired = data[0].isRefuseContentRequired;
	}
	if(data[0].isCommissionContentRequired!=null){
		isCommissionContentRequired = data[0].isCommissionContentRequired;
	}
	if(data[0].isCommunicateContentRequired!=null){
		isCommunicateContentRequired = data[0].isCommunicateContentRequired;
	}
	if(data[0].isAbandonContentRequired!=null){
		isAbandonContentRequired = data[0].isAbandonContentRequired;
	}
	if(data[0].isSuperRefuseContentRequired!=null){
		isSuperRefuseContentRequired = data[0].isSuperRefuseContentRequired;
	}
	if(data[0].isSignContentRequired!=null){
		isSignContentRequired = data[0].isSignContentRequired;
	}
	if(data[0].isAdditionSignContentRequired!=null){
		isAdditionSignContentRequired = data[0].isAdditionSignContentRequired;
	}
	if(data[0].isAssignContentRequired!=null){
		isAssignContentRequired = data[0].isAssignContentRequired;
	}
	if(data[0].isAssignPassContentRequired!=null){
		isAssignPassContentRequired = data[0].isAssignPassContentRequired;
	}
	if(data[0].isAssignRefuseContentRequired!=null){
		isAssignRefuseContentRequired = data[0].isAssignRefuseContentRequired;
	}
	if(data[0].isJumpContentRequired!=null){
		isJumpContentRequired = data[0].isJumpContentRequired;
	}
	if(data[0].isNodeSuspendContentRequired!=null){
		isNodeSuspendContentRequired = data[0].isNodeSuspendContentRequired;
	}
	if(data[0].isNodeResumeContentRequired!=null){
		isNodeResumeContentRequired = data[0].isNodeResumeContentRequired;
	}
	
}
//定义常量
(function(constant){
	constant.COMMONHANDLERISFORMULA='<bean:message bundle="sys-lbpmservice" key="lbpmSupport.HandlerIsFormula"/>';
	constant.COMMONHANDLERISMATRIX='<bean:message bundle="sys-lbpmservice" key="lbpmSupport.HandlerIsMatrix"/>';
	constant.COMMONHANDLERISRULE='<bean:message bundle="sys-lbpmservice" key="lbpmSupport.HandlerIsRule"/>';
	constant.COMMONSELECTADDRESS='<bean:message bundle="sys-lbpmservice" key="lbpmSupport.selectAddress"/>';
	constant.COMMONSELECTFORMLIST='<bean:message bundle="sys-lbpmservice" key="lbpmSupport.selectFormList"/>';
	constant.COMMONSELECTALTERNATIVE='<bean:message bundle="sys-lbpmservice" key="lbpmSupport.selectOptList"/>';
	constant.COMMONLABELFORMULASHOW='<bean:message bundle="sys-lbpmservice" key="label.formula.show"/>';
	constant.COMMONCHANGEPROCESSORSELECT='<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.changeProcessor.select"/>';
	constant.COMMONNODEHANDLERORGEMPTY='<kmss:message bundle="sys-lbpmservice" key="lbpmNode.nodeHandler.orgEmpty"/>';
	constant.COMMONPAGEFIRSTOPTION='<bean:message key="page.firstOption" />';
	constant.COMMONHANDLERUSAGECONTENTDEFAULT=new Array();
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_pass"] = defaultUsageContent;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_refuse"] = defaultUsageContent_refuse;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_commission"] = defaultUsageContent_commission;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_communicate"] = defaultUsageContent_communicate;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_abandon"] = defaultUsageContent_abandon;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_superRefuse"] = defaultUsageContent_superRefuse;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_sign"] = defaultUsageContent_sign;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_additionSign"] = defaultUsageContent_additionSign;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_assign"] = defaultUsageContent_assign;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_assignPass"] = defaultUsageContent_assignPass;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_assignRefuse"] = defaultUsageContent_assignRefuse;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_jump"] = defaultUsageContent_jump;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_nodeSuspend"] = defaultUsageContent_nodeSuspend;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT["handler_nodeResume"] = defaultUsageContent_nodeResume;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED=new Array();
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_pass"] = isPassContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_refuse"] = isRefuseContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_commission"] = isCommissionContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_communicate"] = isCommunicateContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_cancelCommunicate"] = isCommunicateContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_abandon"] = isAbandonContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_superRefuse"] = isSuperRefuseContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_sign"] = isSignContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_additionSign"] = isAdditionSignContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_assign"] = isAssignContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_assignPass"] = isAssignPassContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_assignRefuse"] = isAssignRefuseContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_jump"] = isJumpContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_nodeSuspend"] = isNodeSuspendContentRequired;
	constant.COMMONHANDLERUSAGECONTENTDEFAULT_ISREQUIRED["handler_nodeResume"] = isNodeResumeContentRequired;
	constant.COMMONUSAGECONTENTNOTNULL='<bean:message bundle="sys-lbpmservice" key="lbpmProcess.handler.usageContent.notNull" />';
	constant.COMMONUSAGES='<bean:message bundle="sys-lbpmservice" key="lbpmNode.createDraft.commonUsages" />';
	constant.FUTURENODESTIP = '<bean:message bundle="sys-lbpmservice" key="lbpmNode.futureNodes.tip"/>';
})(lbpm.workitem.constant);
lbpm.globals.includeFile("/sys/lbpmservice/workitem/workitem_common_modifyflow.js");
lbpm.globals.includeFile("/sys/lbpmservice/workitem/workitem_common.js");
if (window.require) {
	lbpm.globals.includeFile("/sys/lbpmservice/mobile/workitem/workitem_common_load.js");
	lbpm.globals.includeFile("/sys/lbpmservice/mobile/workitem/workitem_common_usage.js");
} else {
	lbpm.globals.includeFile("/sys/lbpmservice/workitem/workitem_common_loadworkitemparam.js");
	lbpm.globals.includeFile("/sys/lbpmservice/workitem/workitem_common_usage.js");
}
lbpm.globals.includeFile("/sys/lbpmservice/workitem/workitem_common_generatenextroute.js");
</script>