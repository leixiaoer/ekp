<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="x-ua-compatible" content="IE=5"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title><bean:message key="lbpmNode.processingNode.changeProcessor.title" bundle="sys-lbpmservice"/></title>
	</head>

<script type="text/javascript">
<%
	String KMSS_Parameter_Style = request.getParameter("s_css");
	if(KMSS_Parameter_Style==null || KMSS_Parameter_Style.equals("")){
		Cookie[] cookies = request.getCookies();
		if (cookies != null && cookies.length > 0)
			for (int i = 0; i < cookies.length; i++)
				if ("KMSS_Style".equals(cookies[i].getName())) {
					KMSS_Parameter_Style = cookies[i].getValue();
					break;
				}
	}
	if(KMSS_Parameter_Style==null || KMSS_Parameter_Style.equals(""))
		KMSS_Parameter_Style="default";
	pageContext.setAttribute("KMSS_Parameter_Style", KMSS_Parameter_Style);
	String KMSS_Parameter_ContextPath = request.getContextPath()+"/";
	pageContext.setAttribute("KMSS_Parameter_ContextPath", KMSS_Parameter_ContextPath);
	String KMSS_Parameter_ResPath = KMSS_Parameter_ContextPath+"resource/";
	pageContext.setAttribute("KMSS_Parameter_ResPath", KMSS_Parameter_ResPath);
	String KMSS_Parameter_StylePath = KMSS_Parameter_ResPath + "style/"+KMSS_Parameter_Style+"/";
	pageContext.setAttribute("KMSS_Parameter_StylePath", KMSS_Parameter_StylePath);
%>
var lbpm = new Object();
lbpm.globals = new Object();
var Com_Parameter = {
	ContextPath:"${KMSS_Parameter_ContextPath}",
	ResPath:"${KMSS_Parameter_ResPath}",
	Style:"${KMSS_Parameter_Style}",
	JsFileList:new Array,
	StylePath:"${KMSS_Parameter_StylePath}",
	CurrentUserId:"${KMSS_Parameter_CurrentUserId}"
}; 
</script>
<script type="text/javascript" src="${KMSS_Parameter_ResPath}js/common.js"></script>
<script src="<c:url value="/sys/lbpm/flowchart/js/workflow.js"/>"></script>
<script type="text/javascript">
Com_IncludeFile("dialog.js");
	var dialogObject=window.dialogArguments?window.dialogArguments:opener.Com_Parameter.Dialog;
	//??????????????????window??????#??????????????????#?????????2011???10???28??? 
	var win = dialogObject.win;
	// ?????????????????????????????????iframe?????????win
	var lbpm = win.lbpm;
	var nodeId = '${JsParam.nodeId}';
	var handlerIdentity = '${JsParam.handlerIdentity}';
	function WorkFlow_PassValue(topframe){
		if(nodeId != null && nodeId != ''){
			if(topframe.contentWindow.document.getElementsByName("nodeId")[0] != null){
				topframe.contentWindow.document.getElementsByName("nodeId")[0].value=nodeId;
			}
		}
		if(handlerIdentity != null && handlerIdentity != ''){
			if(topframe.contentWindow.document.getElementsByName("handlerIdentity")[0] != null){
				topframe.contentWindow.document.getElementsByName("handlerIdentity")[0].value=handlerIdentity;
			}
		}
		topframe.contentWindow.FormFieldList = dialogObject.FormFieldList;
	}

	function WorkFlow_InitialWindow(topframe,switchFlag){
		var throughtNodes = dialogObject.throughtNodes;
		var win = dialogObject.win;
		//?????????????????????id??? ??????N1,N2,N5??? @?????????????????? @?????????2011???10???28??? 
		var isPassType = win.lbpm.currentOperationType == null || (win.lbpm.operations[win.lbpm.currentOperationType] && win.lbpm.operations[win.lbpm.currentOperationType].isPassType);	
			var throughNodesStr = win.lbpm.globals.getIdsByNodes(throughtNodes);
			
			if(switchFlag=="all"){
				throughNodesStr = win.lbpm.globals.getIdsByNodes(WorkFlow_GetAllNodeArray(win));
			}
			var workflowNodeTB = topframe.contentWindow.document.getElementById("workflowNodeTB");
			var currentNode = win.lbpm.globals.getNodeObj(nodeId);
			var mustNodes="";
			if(currentNode.mustModifyHandlerNodeIds){
				mustNodes=currentNode.mustModifyHandlerNodeIds;
			}
			var nextNodeArray = WorkFlow_GetAllNodeArray(win);
			
			for(var i = 0; i < nextNodeArray.length; i++){
				
				if(switchFlag!="all"){
					if(!(lbpm.globals.judgeIsNecessaryAlert(nextNodeArray[i]))) continue ;
				}

				var nextNodeId = nextNodeArray[i].id;
				if(lbpm_checkModifyNodeAuthorization(currentNode, nextNodeArray[i].id,throughNodesStr) && nextNodeArray[i].XMLNODENAME!="embeddedSubFlowNode"){
					var handlerIdentity = (function() {
						if (nextNodeArray[i].optHandlerCalType == null || nextNodeArray[i].optHandlerCalType == '2') {
							var rolesSelectObj = win.document.getElementsByName("rolesSelectObj")[0];
						 	if(rolesSelectObj != null && rolesSelectObj.selectedIndex > -1){
						 		return rolesSelectObj.options[rolesSelectObj.selectedIndex].value;
						 	}
							return win.document.getElementsByName("sysWfBusinessForm.fdIdentityId")[0].value;
						}
						var handlerIdentityIdsObj = win.document.getElementById("sysWfBusinessForm.fdHandlerRoleInfoIds");
				 		var rolesIdsArray = handlerIdentityIdsObj.value.split(";");
				 		return rolesIdsArray[0];
					})();
					var tr = topframe.contentWindow.document.createElement("tr");
					var td1 = topframe.contentWindow.document.createElement("td");
					var langNodeName = topframe.contentWindow.WorkFlow_getLangLabel(nextNodeArray[i].name,nextNodeArray[i]["langs"],"nodeName");
					//??????????????????*????????? ?????? ????????? #?????? 2017???5???9???
					langNodeName=Com_HtmlEscape(langNodeName);
					if((mustNodes+";").indexOf(nextNodeArray[i].id+";")>=0 && isPassType){
						//td1.innerHTML = "<center><span class='txtstrong'>*</span>&nbsp;&nbsp;" + nextNodeArray[i].id + "." + langNodeName + "</center>";
						td1.innerHTML = "<span class='txtstrong'>*</span>&nbsp;&nbsp;" + nextNodeArray[i].id + "." + langNodeName + "";
					}
					else{
						//td1.innerHTML = "<center>" + nextNodeArray[i].id + "." + langNodeName + "</center>"; //j
						td1.innerHTML = "" + nextNodeArray[i].id + "." + langNodeName + "";
					}
					//td1.style.cssText="td_normal_title"
					tr.appendChild(td1);
					var handlerIds, handlerNames, isFormulaType = (nextNodeArray[i].handlerSelectType == 'formula'), isMatrixType = (nextNodeArray[i].handlerSelectType == 'matrix'), isRuleType = (nextNodeArray[i].handlerSelectType == 'rule');
					handlerIds = (nextNodeArray[i].handlerIds == null) ? "" : nextNodeArray[i].handlerIds;
					handlerNames = (nextNodeArray[i].handlerNames == null) ? "" : nextNodeArray[i].handlerNames;
					// ?????????????????????????????????????????????id
					if(isMatrixType){
					      var dataNextNodeHandler;
					      var nextNodeHandlerNames4View="";
					      var nextNodeHandlerIds4View="";
					      dataNextNodeHandler=lbpm.globals.matrixNextNodeHandlerNameAndId(handlerIds,true,lbpm.globals.checkNodeType(lbpm.constant.NODETYPE_SEND,nextNodeArray[i]),null,nextNodeArray[i].id);
					      for(var j=0;j<dataNextNodeHandler.length;j++){
					          if(nextNodeHandlerNames4View==""){
					            nextNodeHandlerNames4View=dataNextNodeHandler[j].name;
					          }else{
					            nextNodeHandlerNames4View+=";"+dataNextNodeHandler[j].name;
					          }
					          if(nextNodeHandlerIds4View==""){
					        	  nextNodeHandlerIds4View=dataNextNodeHandler[j].id;
						          }else{
						        	  nextNodeHandlerIds4View+=";"+dataNextNodeHandler[j].id;
						          }
					        }
						handlerNames = (nextNodeHandlerNames4View == "") ? "" : nextNodeHandlerNames4View.replace(/;/g, ';');
						handlerIds =   (nextNodeHandlerIds4View == "") ? "" : nextNodeHandlerIds4View;
					}
					var html = '<input flowcontent="true" type="hidden" name="handlerIds_' + nextNodeId + '" value="' + Com_HtmlEscape(handlerIds) + '" ' + (isFormulaType ? 'isFormula="true"' : 'isFormula="false" ') + (isMatrixType ? 'isMatrix="true"' : 'isMatrix="false"') + (isRuleType ? 'isRule="true"' : 'isRule="false"') + '>';   
					//???????????????????????????
					if ((mustNodes+";").indexOf(nextNodeArray[i].id+";")>=0 && isPassType){
						html += '<input flowcontent="true" subject=' + Com_HtmlEscape(nextNodeArray[i].id) + '.' + Com_HtmlEscape(nextNodeArray[i].name) + ' type="text" name="handlerNames_' + nextNodeId + '" value="' + Com_HtmlEscape(handlerNames) + '" readonly class="inputSgl" style="width:95%;" validate="required"><br>';
					}else{
						html += '<input flowcontent="true" type="text" name="handlerNames_' + nextNodeId + '" value="' + Com_HtmlEscape(handlerNames) + '" readonly class="inputSgl" style="width:95%;"><br>';
					}
					var optHandlerIds = nextNodeArray[i].optHandlerIds==null?"":nextNodeArray[i].optHandlerIds;
					var optHandlerSelectType = nextNodeArray[i].optHandlerSelectType == null?"org":nextNodeArray[i].optHandlerSelectType;
					var defaultOptionBean = "lbpmOptHandlerTreeService&optHandlerIds=" + encodeURIComponent(optHandlerIds) 
						+ "&currentIds=" + ((isFormulaType || isMatrixType || isRuleType) ? "" : encodeURIComponent(handlerIds)) 
						+ "&handlerIdentity=" + handlerIdentity
						+ "&optHandlerSelectType=" + optHandlerSelectType
						+ "&fdModelName=" + win.lbpm.modelName
						+ "&fdModelId=" + win.lbpm.modelId
						+ "&nodeId=" + nextNodeId;
					//??????????????? add by limh 2010???11???4???
					var searchBean = defaultOptionBean + "&keyword=!{keyword}";
					var hrefObj = "<a class=\"com_btn_link\" style=\"margin-left: 8px;\" href=\"javascript:void(0);\"";
					if (win.lbpm.constant.NODETYPE_SEND,nextNodeArray[i].nodeDescType=="shareReviewNodeDesc") {
						// ????????????????????????????????????
						hrefObj+=" onclick=\"WorkFlow_ClearValueForFurtureHandler('"+nextNodeId+"','false');Dialog_AddressList(false, 'handlerIds_" + nextNodeId + "','handlerNames_" + nextNodeId + "', ';', '"+defaultOptionBean+"', function(rtv){lbpm.globals.setFurtureHandlerInfoes(rtv,'false','false');}, '"+searchBean+"', null, null, '<bean:message key='lbpmNode.processingNode.changeProcessor.select' bundle='sys-lbpmservice'/>');\"";
					} else {
						hrefObj+=" onclick=\"WorkFlow_ClearValueForFurtureHandler('"+nextNodeId+"','false');Dialog_AddressList(true, 'handlerIds_" + nextNodeId + "','handlerNames_" + nextNodeId + "', ';', '"+defaultOptionBean+"', function(rtv){lbpm.globals.setFurtureHandlerInfoes(rtv,'false','false');}, '"+searchBean+"', null, null, '<bean:message key='lbpmNode.processingNode.changeProcessor.select' bundle='sys-lbpmservice'/>');\"";
					}
					
					//??????????????????????????????????????????,??????hrefObj?????????
					if(optHandlerSelectType == 'dept' || optHandlerSelectType == 'mechanism'){
						hrefObj = "<a class=\"com_btn_link\" style=\"margin-left: 8px;\" href=\"javascript:void(0);\"";
						var deptLimit;
						if(optHandlerSelectType == 'dept'){
							deptLimit = 'myDept';
						}else{
							deptLimit = 'myOrg';
						}
						var currentOrgIdsObj = win.document.getElementById("sysWfBusinessForm.fdHandlerRoleInfoIds");
						var reg = /;/g;
						var ids = currentOrgIdsObj ? currentOrgIdsObj.value.split(reg) : [];
						var exceptValue="";
						for(var j=0; j<ids.length; j++){
							if(j == ids.length-1){
								exceptValue += "'" + ids[j] + "'";
							}else{
								exceptValue += "'" + ids[j] + "',";
							}
						}
						var selectType = ORG_TYPE_POSTORPERSON;
						if (win.lbpm.constant.NODETYPE_SEND,nextNodeArray[i].nodeDescType=="shareReviewNodeDesc") {
							// ????????????????????????????????????
							hrefObj+=" onclick=\"WorkFlow_ClearValueForFurtureHandler('"+nextNodeId+"','false');Dialog_Address(false,'handlerIds_" + nextNodeId + "','handlerNames_" + nextNodeId + "', ';', "+selectType+",function(rtv){lbpm.globals.setFurtureHandlerInfoes(rtv,'false');}, null, null, true, null, null, ["+exceptValue+"], '"+deptLimit+"');\"";
						} else {
							hrefObj+=" onclick=\"WorkFlow_ClearValueForFurtureHandler('"+nextNodeId+"','false');Dialog_Address(true,'handlerIds_" + nextNodeId + "','handlerNames_" + nextNodeId + "', ';', "+selectType+",function(rtv){lbpm.globals.setFurtureHandlerInfoes(rtv,'false');}, null, null, true, null, null, ["+exceptValue+"], '"+deptLimit+"');\"";
						}
					}
					
					hrefObj+=">" + '<bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.changeProcessor.select.alternative" /></a>';
					if(nextNodeArray[i].useOptHandlerOnly == "true"){
						html += hrefObj;
					}else{ 
						var selectType = win.lbpm.constant.ADDRESS_SELECT_POSTPERSONROLE;
						if (win.lbpm.globals.checkNodeType(win.lbpm.constant.NODETYPE_SEND,nextNodeArray[i])) {
							selectType = win.lbpm.constant.ADDRESS_SELECT_ALLROLE;
						}
						if (win.lbpm.constant.NODETYPE_SEND,nextNodeArray[i].nodeDescType=="shareReviewNodeDesc") {
							// ????????????????????????????????????
							selectType = "ORG_TYPE_PERSON";
							html += '<a class="com_btn_link" style="margin-left: 8px;" href="#" onclick="WorkFlow_ClearValueForFurtureHandler(\''+nextNodeId+'\',\'false\');Dialog_Address(false, \'handlerIds_' + nextNodeId + '\',\'handlerNames_' + nextNodeId + '\', \';\', '+selectType;
							html += ',function(rtv){lbpm.globals.setFurtureHandlerInfoes(rtv,\'false\',\'false\');});"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.changeProcessor.select.organization" /></a>';
							var hrefObj_formula = "";
							if ((nextNodeArray[i].optHandlerIds && nextNodeArray[i].optHandlerIds.replace(/^\s+|\s+$/g, '') != "")  || optHandlerSelectType == 'dept' || optHandlerSelectType == 'mechanism'){
								html += hrefObj;
							}
							/* var hrefObj_formula = "<a class=\"com_btn_link\" style=\"margin-left: 8px;\" href=\"javascript:void(0)\"";
							hrefObj_formula +=" onclick=\"WorkFlow_ClearValueForFurtureHandler('"+nextNodeId+"','true');lbpm.globals.setHandlerFormulaDialog_('handlerIds_" + nextNodeId + "', 'handlerNames_" + nextNodeId + "', '${JsParam.fdModelName}',function(rtv){lbpm.globals.setFurtureHandlerInfoes(rtv,'true','false');},true);\"";
							hrefObj_formula+=">" + "<bean:message bundle='sys-lbpmservice' key='lbpmSupport.selectFormList'/></a>"; */
							html += hrefObj_formula;
						} else {
							html += '<a class="com_btn_link" style="margin-left: 8px;" href="#" onclick="WorkFlow_ClearValueForFurtureHandler(\''+nextNodeId+'\',\'false\');Dialog_Address(true, \'handlerIds_' + nextNodeId + '\',\'handlerNames_' + nextNodeId + '\', \';\', '+selectType;
							html += ',function(rtv){lbpm.globals.setFurtureHandlerInfoes(rtv,\'false\',\'false\');});"><bean:message bundle="sys-lbpmservice" key="lbpmNode.processingNode.changeProcessor.select.organization" /></a>';
							if ((nextNodeArray[i].optHandlerIds && nextNodeArray[i].optHandlerIds.replace(/^\s+|\s+$/g, '') != "") || optHandlerSelectType == 'dept' || optHandlerSelectType == 'mechanism'){
								html += hrefObj;
							}
							var hrefObj_formula = "";
							/* var hrefObj_formula = "<a class=\"com_btn_link\" style=\"margin-left: 8px;\" href=\"javascript:void(0)\"";
							hrefObj_formula +=" onclick=\"WorkFlow_ClearValueForFurtureHandler('"+nextNodeId+"','true');lbpm.globals.setHandlerFormulaDialog_('handlerIds_" + nextNodeId + "', 'handlerNames_" + nextNodeId + "', '${JsParam.fdModelName}',function(rtv){lbpm.globals.setFurtureHandlerInfoes(rtv,'true','false');});\"";
							hrefObj_formula+=">" + "<bean:message bundle='sys-lbpmservice' key='lbpmSupport.selectFormList'/></a>"; */
							html += hrefObj_formula;
						}
						
					}
					
					var td2 = topframe.contentWindow.document.createElement("td");
					td2.innerHTML = html;
					tr.appendChild(td2);
					var td3 = topframe.contentWindow.document.createElement("td");
					var langNodeDesc = topframe.contentWindow.WorkFlow_getLangLabel(nextNodeArray[i].description,nextNodeArray[i]["langs"],"nodeDesc");

					var nodeDesc=langNodeDesc == null?"":langNodeDesc;
					var re=/\[url=([^\]]+)\]([^\[]*)\[\/url\]/ig;
					nodeDesc = nodeDesc.replace(re,function($0,$1,$2){
						if($2){
							return '<span><a href='+$1+' target=_blank>'+$2+'</a></span>';
						}
						else{
							//??????????????????????????? ????????????????????????
							return '<span><a href='+$1+' target=_blank>'+$1+'</a></span>';
						}
					});
					nodeDesc=nodeDesc.replace(/\r\n/ig,"<br/>").replace(/\n/ig,"<br/>").replace(/<pre>|<\/pre>/ig,"");
					if(nodeDesc.indexOf("<a href=") != -1 && nodeDesc.indexOf("script") != -1){
						nodeDesc=nodeDesc.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
					}
					td3.innerHTML =nodeDesc;
					tr.appendChild(td3);
					workflowNodeTB.appendChild(tr);
				}
			} 

	}

	function lbpm_checkModifyNodeAuthorization(nodeObj, allowModifyNodeId,throughNodesStr){
		var index, nodeIds;
		throughNodesStr+=",";
		//?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
		if(throughNodesStr.indexOf(allowModifyNodeId+",") == -1){
			
			return false;
		}
		if(nodeObj.canModifyHandlerNodeIds != null && nodeObj.canModifyHandlerNodeIds != ""){
			nodeIds = nodeObj.canModifyHandlerNodeIds + ";";
			index = nodeIds.indexOf(allowModifyNodeId + ";");
			if(index != -1){
				return true;
			}
		}
		if(nodeObj.mustModifyHandlerNodeIds != null && nodeObj.mustModifyHandlerNodeIds != ""){
			nodeIds = nodeObj.mustModifyHandlerNodeIds + ";";
			index = nodeIds.indexOf(allowModifyNodeId + ";");
			if(index != -1){
				return true;
			}
		}
	
		return false;
	}
	
	function WorkFlow_GetAllNodeArray(win){
		var rtnNodeArray = new Array();
		(win.$).each(win.lbpm.nodes, function(index, node) {
			if(!win.lbpm.globals.checkNodeType(win.lbpm.constant.NODETYPE_START,node) && !win.lbpm.globals.checkNodeType(win.lbpm.constant.NODETYPE_END,node) && !win.lbpm.globals.checkNodeType(win.lbpm.constant.NODETYPE_MANUALBRANCH,node)){
				rtnNodeArray.push(node);
			}
		});
		rtnNodeArray.sort(win.lbpm.globals.getNodeSorter());
		return rtnNodeArray;
	};

	function _switchLoadFrame(topFrame,switchFlag){
		var url = "<c:url value="/sys/lbpmservice/workitem/sysLbpmMain_changeProcessor_edit.jsp"/>";
		if(switchFlag=="all"){
			url+="?switchFlag=all";
		}
		topFrame.src=url;

	}

</script>
<frameset framespacing=1 bordercolor=#003048 frameborder=1 rows="*">
	<frame frameborder="0" noresize scrolling="yes" id="topFrame"
		src="<c:url value="/sys/lbpmservice/workitem/sysLbpmMain_changeProcessor_edit.jsp"/>" onload="WorkFlow_PassValue(this);">
</frameset>
</html>

