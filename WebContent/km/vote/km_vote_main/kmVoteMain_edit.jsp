<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<c:if test="${kmVoteMainForm.method_GET=='add'}">
	<script type="text/javascript">
	Com_AddEventListener(window,"load",AddInitRow);
	function AddInitRow() {
		// 初始添加3个候选项
		setTimeout(function() {
			for(var i=0; i<3; i++) {
				DocList_AddRow("TABLE_DocList");
			}
		}, 500);
	}
	</script>
</c:if>
<script>
Com_IncludeFile("doclist.js|dialog.js|calendar.js");
</script>
<script type="text/javascript">

function ID(id){
	return document.getElementById(id);
}

function getInputCount(){
	var obj = ID("TABLE_DocList");
	return obj.getElementsByTagName("input").length;
}

function deleteVoteItem() {
	var index = getInputCount()/3;
	//判断候选项不能少于2个
	if(index <= 2){
		alert('<bean:message bundle="km-vote" key="kmVoteMain.atLeast2Items" />');
		return;
	}
	DocList_DeleteRow();
}
//根据候选项的数量来更新最多可选项
function addOption(thisObj) {
	var index = getInputCount()/3;
	// 删除所有选项
	while(thisObj.length>0) {
		thisObj.remove(0);
	}
  	thisObj.options.add(new Option('<bean:message bundle="km-vote" key="kmVoteMain.unlimited" />',0));
	for(var i=1; i<=index; i++) {
		thisObj.options.add(new Option('<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />'+i+'<bean:message bundle="km-vote" key="kmVoteMain.item" />',i));
	}
}
// 显示最多可选项
function showMaxSelectNum() {
	if(document.getElementsByName("fdIsRadio")[0].checked) {
		ID("maxSelectNum").style.display = "none";
	} else {
		ID("maxSelectNum").style.display = "block";
	}
}
// 显示输入投票开始时间
function showEffectTime() {
	//var thisObj = ID("_fdIsEffectImmediately");
	var thisObj = document.getElementsByName("_fdIsEffectImmediately")[0];
	if(thisObj.checked == true) {
		ID("effect").style.display = "none";
		//thisObj.nextSibling.nodeValue='<bean:message bundle="km-vote" key="kmVoteMain.fdIsEffectImmediately" />';
	} else {
		//thisObj.nextSibling.nodeValue="";
		ID("effect").style.display = "block";
	}
}
// 显示以下人员
function showOtherViewer(thisObj) {
	//var thisObj = ID("_fdOtherViewFlag");
	var thisObj = document.getElementsByName("_fdOtherViewFlag")[0];
	if(thisObj.checked == true) {
		ID("otherViews").style.display = "block";
	} else {
		//ID("fdViewerIds").value="";
		//ID("fdViewerNames").value="";
		document.getElementsByName("fdViewerIds")[0].value="";
		document.getElementsByName("fdViewerNames")[0].value="";
		ID("otherViews").style.display = "none";
	}
}
function validateKmVoteMainData(thisObj) {
	var temp = validateKmVoteMainForm(thisObj);
	if (temp == true) {
		var msg = "";		
		var form = document.forms['kmVoteMainForm'];
		var _itemName = document.getElementsByName("itemName");
		if(_itemName != null) {
			// 候选项不能为空
			for(var i=0; i<_itemName.length; i++) {
				if(trim(_itemName[i].value) == "") {
					msg += '<bean:message bundle="km-vote" key="error.item.required" />' + '\r\n';
					break;
				}
			}
		}
		if(document.getElementsByName("fdIsRadio")[0].checked) {
			form.fdMaxSelectNum.value = "0";
		}
		var _fdExpireTime = form.fdExpireTime.value;
		// 截止时间不能大于当前时间
		if (compareVoteNowDateTime(_fdExpireTime)) {
			msg += '<bean:message bundle="km-vote" key="error.expireTime.not.less.now" />' + '\r\n';
		}
		if(form._fdIsEffectImmediately.checked == false) {
			if (form.fdEffectTime.value == "") {
				// 开始时间不能为空
				msg += '<bean:message bundle="km-vote" key="error.effectTime.required" />' + '\r\n';
			} else {
				var pMethod = "${JsParam.method}";
				var _fdEffectTime = form.fdEffectTime.value;
				var voteStatus = "${kmVoteMainForm.fdVoteStatus}";

				// 新建投票的时候，投票开始时间不能早于当前时间。
				if (pMethod == "add"){
					if (compareVoteNowDateTime(_fdEffectTime)) {
						msg += '<bean:message bundle="km-vote" key="error.effectTime.not.less.now" />' + '\r\n';
					}
				}

				// 在对还没开始的投票进行编辑的时候，投票开始时间不能早于当前时间。
				if (pMethod == "edit" && voteStatus == "1"){
					if (compareVoteNowDateTime(_fdEffectTime)) {
						msg += '<bean:message bundle="km-vote" key="error.effectTime.not.less.now" />' + '\r\n';
					}
				}
			
				// 开始时间不能大于截止时间
				if(compareVoteDateTime(_fdEffectTime, _fdExpireTime)){
					msg += '<bean:message bundle="km-vote" key="error.effectTime.not.larg.expireTime" />' + '\r\n';
				}
			}
		}
		if(form.fdVoterIds.value == ""){
			//ID("fdNotifyType").value="";
			document.getElementsByName("fdNotifyType")[0].value="";
		}
		if(form.fdIsRequired.value == "true"){
			// 通知方式不能为空
			if(form.fdNotifyType.value == "") {
				msg += '<bean:message bundle="km-vote" key="error.NotifyType.required" />' + '\r\n';
			}
		}
		// 以下人员不能为空
		if(form._fdOtherViewFlag.checked == true && form.fdViewerNames.value == "") {
			msg += '<bean:message bundle="km-vote" key="error.otherViews.required" />' + '\r\n';
		}
		if (msg != "") {
			alert(msg);
			return false;
		}
	}
	return temp;
}

function compareVoteDateTime(d1,d2) {
	return ((new Date(d1.replace(/-/g,"\/"))) >= (new Date(d2.replace(/-/g,"\/"))));
}

function compareVoteNowDateTime(d1) {
	return (new Date(d1.replace(/-/g,"\/"))) < (new Date());
}

//modify by yirf 选择可投票者后触发，如果选择可投票者结果为空则不出现是否必需参加和通知方式，如果选择可投票者有人则出现是否必需参加和通知方式
function showOtherInfo(rtnval){
	if(rtnval==null){
		return;
	}else{
		rtnval.AddHashMap({id:"",name:"<bean:message key="page.firstOption"/>"});
		var mapArray = rtnval.GetHashMapArray();
		if(mapArray.length>1){
			ID("otherInfo").style.display = "";
			showNotifyRequired();
		}else{
			//ID("fdVoterIds").value="";
			document.getElementsByName("fdVoterIds")[0].value="";
			//ID("fdVoterNames").value="";
			document.getElementsByName("fdVoterNames")[0].value="";
			ID("otherInfo").style.display = "none";
			//ID("fdNotifyType").value="";
			document.getElementsByName("fdNotifyType")[0].value="";
			//ID("fdIsRequired").value = false;
			document.getElementsByName("fdIsRequired")[0].value="";
			//ID("_fdIsRequired").checked = false;
			document.getElementsByName("_fdIsRequired")[0].value="";
			var tbObj = ID("notifyType");
			var field = tbObj.getElementsByTagName("INPUT");
			for(var i=1; i<field.length; i++){
				field[i].checked =false;
			}
			//ID("fdNotifyType").value="";
			document.getElementsByName("fdNotifyType")[0].value="";
			showNotifyRequired();
		}
	}
}
function showNotifyRequired(){
	//var thisObj = ID("_fdIsRequired");
	var thisObj = document.getElementsByName("_fdIsRequired")[0];
	if(thisObj.checked == true) {
		ID("notifyRequired").style.display = "";
	} else {
		ID("notifyRequired").style.display = "none";
	}	
}
window.onload = function(){
	if(${kmVoteMainForm.fdNotifyType == ""}){
		var tbObj = ID("notifyType");
		var field = tbObj.getElementsByTagName("INPUT");
		for(var i=1; i<field.length; i++){
			field[i].checked =false;
		}
	}
}
function voteSubmit(method, status){
	if(status!=null){
		document.getElementsByName("docStatus")[0].value = status;
	}
	Com_Submit(document.kmVoteMainForm, method);
}

</script>
<html:form action="/km/vote/km_vote_main/kmVoteMain.do" onsubmit="return validateKmVoteMainData(this);">
<div id="optBarDiv">
   <c:if test="${kmVoteMainForm.method_GET=='edit'}">
	     <!-- 暂存 -->
	     <c:if test="${kmVoteMainForm.docStatus=='10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="voteSubmit('update','10');">
		 </c:if>
		<!-- 提交 -->
		<input type=button value="<bean:message key="button.update"/>"
			onclick="voteSubmit('update','30');">
	</c:if>
	<c:if test="${kmVoteMainForm.method_GET=='add'}">
	    <!-- 暂存 -->
		<input type=button value="<bean:message key="button.savedraft"/>"
			onclick="voteSubmit('save','10');">
		<!-- 保存 -->
		<input type=button value="<bean:message key="button.submit"/>"
			onclick="voteSubmit('save','30');">
	</c:if>
	<!-- 关闭 -->
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-vote" key="button.launchedVote" /></p>

<center>
<table id="TABLE_NEWVOTE" class="tb_normal" width="95%">
    <html:hidden property="docStatus" />
	<html:hidden property="fdId" />
	<tr>
		<!-- 投票主题 -->
		<td class="td_normal_title" width="15%">
			<bean:message bundle="km-vote" key="kmVoteMain.docSubject" />
		</td>
		<td width="85%" colspan="3">
			<html:text property="docSubject" style="width: 90%" />
			<span class="txtstrong">*</span>
		</td>
	</tr>
	<tr>
		<!-- 所属分类 -->
		<td class="td_normal_title" width="15%">
			<bean:message bundle="km-vote" key="kmVoteMain.fdCategoryId" />
		</td>
		<td width="35%">
			<xform:select property="fdCategoryId" showPleaseSelect="true" showStatus="edit" required="true">
				<xform:beanDataSource serviceBean="kmVoteCategoryService" whereBlock="kmVoteCategory.fdIsAvailable = 1" orderBy="kmVoteCategory.fdOrder" />
			</xform:select>
		</td>
		<td class="td_normal_title" width="15%">
		</td>
		<td width="35%">
		</td>
	</tr>
	<tr>
		<!-- 详细说明 -->
		<td class="td_normal_title" width="15%">
			<bean:message bundle="km-vote" key="kmVoteMain.fdDescription" />
		</td>
		<td width="85%" colspan="3">
			<html:textarea property="fdDescription" style="width: 95%" />
		</td>
	</tr>
	<tr>
		<!-- 候选项 -->
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-vote" key="kmVoteMain.fdVoteItem" />
		</td>
		<td colspan="3">
			<table id="TABLE_DocList" class="tb_normal" width="100%">
				<c:if test="${kmVoteMainForm.method_GET=='add'}">
					<tr>
						<td width="3%" class="td_normal_title"></td>
						<td>
							<a href="#" onclick="DocList_AddRow();">
								<img src="${KMSS_Parameter_StylePath}icons/add.gif" />
								<bean:message bundle="km-vote" key="kmVoteMain.fdAddVoteItem" />
							</a>
						</td>
					</tr>
				</c:if>
				<tr KMSS_IsReferRow="1" style="display: none">
					<td KMSS_IsRowIndex="1" class="td_normal_title"></td>
					<td>
						<input type="hidden" name="fdVoteItems[!{index}].fdId" value="${kmVoteMainItemForm.fdId}" />
						<input type="hidden" name="fdVoteItems[!{index}].fdVoteId" value="${kmVoteMainForm.fdId}" />
						<input id="itemName" name="fdVoteItems[!{index}].fdName" class="inputsgl" style="width: 70%" />
						<span class="txtstrong">*</span>
						<a href="#" onclick="deleteVoteItem();"><img src="${KMSS_Parameter_StylePath}icons/delete.gif" /></a>
						<a href="#" onclick="DocList_MoveRow(-1);"><img src="${KMSS_Parameter_StylePath}icons/up.gif"/></a>
						<a href="#" onclick="DocList_MoveRow(1);"><img src="${KMSS_Parameter_StylePath}icons/down.gif"/></a>
					</td>
				</tr>
				<c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
					<tr KMSS_IsContentRow="1">
						<td width="3%" class="td_normal_title">${vstatus.index+1}</td>
						<td>
							<input type="hidden" name="fdVoteItems[${vstatus.index}].fdId" value="${kmVoteMainItemForm.fdId}" />
							<input type="hidden" name="fdVoteItems[${vstatus.index}].fdVoteId" value="${kmVoteMainForm.fdId}" />
							<input id="itemName" name="fdVoteItems[${vstatus.index}].fdName" value="${kmVoteMainItemForm.fdName}" class="inputsgl" style="width: 70%" />
							<span class="txtstrong">*</span>
							<c:if test="${kmVoteMainForm.method_GET=='add'}">
								<a href="#" onclick="DocList_DeleteRow();"><img src="${KMSS_Parameter_StylePath}icons/delete.gif" /></a>
							</c:if>
							<a href="#" onclick="DocList_MoveRow(-1);"><img src="${KMSS_Parameter_StylePath}icons/up.gif"/></a>
							<a href="#" onclick="DocList_MoveRow(1);"><img src="${KMSS_Parameter_StylePath}icons/down.gif"/></a>
							
						</td>
					</tr>
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<!-- 可投选项 -->
		<td class="td_normal_title" width="15%">
			<bean:message bundle="km-vote" key="kmVoteMain.fdIsRadio" />
		</td>
		<td width="85%" colspan="3">
			<span class="l">			
					<html:radio property="fdIsRadio" value="true" onclick="showMaxSelectNum();">
						<bean:message bundle="km-vote" key="kmVoteMain.itemRadio" />
					</html:radio>
					<html:radio property="fdIsRadio" value="false" onclick="showMaxSelectNum();">
						<bean:message bundle="km-vote" key="kmVoteMain.itemCheckbox" />
					</html:radio>
			</span>
			<span class="flw10"></span>
			<span id="maxSelectNum" class="l"
				<c:if test="${kmVoteMainForm.fdIsRadio!='false'}">
					style="display: none"
				</c:if>
				>
				<!-- 最多可选项 -->
				<select name="fdMaxSelectNum" onbeforeactivate="addOption(this);">
					<option value="0"><bean:message bundle="km-vote" key="kmVoteMain.unlimited" /></option>
					<option value="${kmVoteMainForm.fdMaxSelectNum}"
						<c:if test="${kmVoteMainForm.fdMaxSelectNum!='0'}">
							selected="true"
						</c:if>
						>
						<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />${kmVoteMainForm.fdMaxSelectNum}<bean:message bundle="km-vote" key="kmVoteMain.item" />
					</option>
				</select>
			</span>
			<span class="txtstrong">*</span>
		</td>
	</tr> 
	<tr><%--允许评论 --%>
		<td  class="td_normal_title" width="15%"> 
			<bean:message bundle="km-vote" key="kmVoteMain.fdIsAllowSay"/>
		</td>
		<td colspan="3">
			<sunbor:enums property="fdIsAllowSay" enumsType="common_yesno" elementType="radio"/>
		</td>  
	</tr> 
	<tr>
		<!-- 投票开始时间 -->
		<td class="td_normal_title" width="15%">
			<bean:message bundle="km-vote" key="kmVoteMain.fdEffectTime"/>
		</td>
		<td width="35%">
			<!-- 提交后投票开始 -->
			<span class="l">
				<c:if test="${kmVoteMainForm.fdVoteStatus!='0'}">
					<xform:checkbox property="fdIsEffectImmediately" showStatus="edit" onValueChange="showEffectTime()">
						<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMain.fdIsEffectImmediately" />
					</xform:checkbox>
				</c:if>
				<c:if test="${kmVoteMainForm.fdVoteStatus=='0'}">
					<xform:checkbox property="fdIsEffectImmediately" showStatus="readonly" onValueChange="showEffectTime()">
						<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMain.fdIsEffectImmediately" />
					</xform:checkbox>
				</c:if>
			</span>
			<span class="flw10"></span>
			<span id="effect" class="l"
				<c:if test="${kmVoteMainForm.fdIsEffectImmediately=='true'}">
					style="display: none"
				</c:if>
				>
				<c:if test="${kmVoteMainForm.fdVoteStatus!='0'}">
					<xform:datetime property="fdEffectTime" dateTimeType="datetime" showStatus="edit" />
				</c:if>
				<c:if test="${kmVoteMainForm.fdVoteStatus=='0'}">
					<xform:datetime property="fdEffectTime" dateTimeType="datetime" showStatus="readonly" />
				</c:if>
				<span class="txtstrong">*</span>
			</span>
		</td>
		<!-- 投票结束时间 -->
		<td class="td_normal_title" width="15%">
			<bean:message bundle="km-vote" key="kmVoteMain.fdExpireTime"/>
		</td>
		<td width="35%">
			<xform:datetime property="fdExpireTime" dateTimeType="datetime" showStatus="edit" />
		</td>
	</tr>
	<tr>
		<!-- 可投票者 -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteMain.fdVoters"/>
		</td>
		<td width="85%" colspan="3">
			<html:hidden property="fdVoterIds" />
			<html:textarea property="fdVoterNames" style="width:95%" readonly="true" />
			<c:if test="${kmVoteMainForm.fdVoteStatus!='0'}">
				<a href="#" onclick="Dialog_Address(true, 'fdVoterIds','fdVoterNames', ';', ORG_TYPE_PERSON|ORG_TYPE_ORGORDEPT,showOtherInfo);">
					<bean:message key="dialog.selectOrg" />
				</a>	
			</c:if>
			<br>
			<span class="txtstrong"><bean:message bundle="km-vote" key="kmVoteMain.voter.isNull.message"/></span>
		</td>
	</tr>
	<tr id="otherInfo"
		<c:if test="${empty kmVoteMainForm.fdVoterIds}">
			style="display: none"
		</c:if>
	>
		<!-- 是否必需参加 -->
		<td class="td_normal_title" width="15%">
			<bean:message  bundle="km-vote" key="kmVoteMain.fdIsRequired"/>
		</td>
		<td width="35%">
			<c:if test="${kmVoteMainForm.fdVoteStatus!='0'}">
				<xform:checkbox property="fdIsRequired" showStatus="edit" onValueChange="showNotifyRequired()">
					<xform:simpleDataSource value="true" textKey="message.yes" />
				</xform:checkbox>
			</c:if>
			<c:if test="${kmVoteMainForm.fdVoteStatus=='0'}">
				<xform:checkbox property="fdIsRequired" showStatus="readonly">
					<xform:simpleDataSource value="true" textKey="message.yes" />
				</xform:checkbox>
			</c:if>
		</td>
		<!-- 代办方式 -->
		<td class="td_normal_title" width="15%">
			<bean:message bundle="km-vote" key="kmVoteMain.fdNotifyType" />
		</td>
		<td width="35%" id="notifyType">
				<c:if test="${kmVoteMainForm.fdVoteStatus!='0'}">
					<kmss:editNotifyType property="fdNotifyType" />
				</c:if>
				<c:if test="${kmVoteMainForm.fdVoteStatus=='0'}">
					<kmss:showNotifyType value="${kmVoteMainForm.fdNotifyType}" />
					<html:hidden property="fdNotifyType" />
				</c:if>
				<span class="txtstrong" id="notifyRequired"
					<c:if test="${kmVoteMainForm.fdIsRequired == false}">
						style="display: none"
					</c:if>
				>*</span>
		</td>
	</tr>
	<tr>
		<!-- 可查看投票结果 -->
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-vote" key="kmVoteMain.canViewResult" />
		</td>
		<td width="85%" colspan="3">
			<!-- 可投票者 -->
			<xform:checkbox property="fdVoterViewFlag" showStatus="edit">
				<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMain.fdVoters" />
			</xform:checkbox><br />
			<!-- 以下人员 -->
			<xform:checkbox property="fdOtherViewFlag" showStatus="edit" onValueChange="showOtherViewer()">
				<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMian.otherViews" />
			</xform:checkbox>
			<span id="otherViews"
				<c:if test="${empty kmVoteMainForm.fdViewerIds}">
					style="display: none"
				</c:if>
				>
				<html:hidden property="fdViewerIds" />
				<html:textarea property="fdViewerNames" readonly="true" style="width: 95%" />
				<a href="#" onclick="Dialog_Address(true, 'fdViewerIds','fdViewerNames', ';', ORG_TYPE_PERSON|ORG_TYPE_ORGORDEPT);">
					<bean:message key="dialog.selectOrg" /><span class="txtstrong">*</span>
				</a>
			</span>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<html:javascript formName="kmVoteMainForm" cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>