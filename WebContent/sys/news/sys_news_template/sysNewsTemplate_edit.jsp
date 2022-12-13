<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%> <!-- #139894不能屏蔽这个文件，否则引入seajs失败 -->
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsWebOfficeUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%
	pageContext.setAttribute("_isJGEnabled", new Boolean(com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()));
	pageContext.setAttribute("_isWpsWebOfficeEnable", new Boolean(SysAttWpsWebOfficeUtil.isEnable()));
	pageContext.setAttribute("_isWpsCloudEnable",  new Boolean(SysAttWpsCloudUtil.isEnable()));
	 //WPS加载项
    pageContext.setAttribute("_isWpsWebOffice", new Boolean(SysAttWpsCloudUtil.isEnableWpsWebOffice()));
%>
<script src="./resource/weui_switch.js"></script>
<script language="JavaScript">
var _isWpsCloudEnable = "${_isWpsCloudEnable}";
var _isWpsWebOfficeEnable = "${_isWpsWebOfficeEnable}";

var _isWpsWebOffice = "${_isWpsWebOffice}";
var wpsFlag = false
Com_IncludeFile("dialog.js");

	Com_AddEventListener(window,"load",init);
	function init(){
		checkEditType("${sysNewsTemplateForm.fdContentType}", null);
	// 添加标签切换事件
	var table = document.getElementById("Label_Tabel");
	//增加切换事件防止金格切换报异常（由于切换会调用display方法，而金格对多浏览器的display方法不支持，故只能用缩小的方法）
	if(table != null && window.Doc_AddLabelSwitchEvent){
		if(_isWpsCloudEnable == "true" || _isWpsWebOfficeEnable == "true" || _isWpsWebOffice == "true"){
			Doc_AddLabelSwitchEvent(table, "showWps");
		}else{
			Doc_AddLabelSwitchEvent(table, "showRtfOrJg");
		}
	}
};

function showWps(tableName,index){
	var type=document.getElementsByName("fdContentType")[0];
	var trs = document.getElementById(tableName).rows;
	if("word" == type.value && trs[index].id =="tr_content"){
		$("#wordEdit").show();
		if(!wpsFlag){
			if(_isWpsCloudEnable == "true"){
				wps_cloud_editonline.load();
			}else if(_isWpsWebOfficeEnable == "true"){
				wps_editonline.load();
			}
			wpsFlag = true;
		}
	}else{
		$("#wordEdit").hide();
	//	$("#rtfWordEdit").height("580px");
	}
}

function showRtfOrJg(tableName,index){
	var trs = document.getElementById(tableName).rows;
	var type=document.getElementsByName("fdContentType")[0];
	if(trs[index].id =="tr_content"){
		if("word" == type.value){
			$("#rtfWordEdit").height("580px");
			//不能把display设为none,block，金格在多浏览器下不支持
			$("#wordEdit").css({ 
				width:'90%',
				height:'550px'
			});	
			//由于编辑页面少了rtf和word的切换选项，高度有变化，故需要调整
			/* if("${param.method}" == "edit"){
				$("#wordEdit").css({top:'165px'});
			} */
			$("#JGWebOffice_editonline").height("550px");
			document.getElementById("JGWebOffice_editonline").setAttribute("height", "550px");
			var obj = document.getElementById("JGWebOffice_editonline");
			setTimeout(function(){
				if(obj&&Attachment_ObjectInfo['editonline']&&!jg_attachmentObject_editonline.hasLoad){
					jg_attachmentObject_editonline.load();
					jg_attachmentObject_editonline.show();
					jg_attachmentObject_editonline.ocxObj.Active(true);
				}
			},1000);
			chromeHideJG_2015(1);
		} else {
			$("#wordEdit").css({
				width:'0px',
				height:'0px'
			});
			chromeHideJG_2015(0);
		}
	}else{
		$("#wordEdit").css({
			width:'0px',
			height:'0px'
		});
		chromeHideJG_2015(0);
	}
}
	Com_Parameter.event["submit"].push(function() {
		var type=document.getElementsByName("fdContentType")[0];
		if ("word" == type.value) {
			if ("${pageScope._isJGEnabled}" == "true") {
				var obj = document.getElementById("JGWebOffice_editonline");
				// 保存附件
				if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
					jg_attachmentObject_editonline.ocxObj.Active(true);
			        jg_attachmentObject_editonline._submit();
			        return true;
		    	 }
				// 保存附件为html
				//if(!JG_WebSaveAsHtml()){return false;}
			}
		}
		return true;
	});
	function checkEditType(value, obj){
		var type=document.getElementsByName("fdContentType")[0];
		type.value = "rtf";
		var _rtfEdit = document.getElementById('rtfEdit');
		var _wordEdit = document.getElementById('wordEdit');
		var _attEdit = document.getElementById('attEdit');
		if (_rtfEdit == null || _wordEdit == null || _attEdit==null) {
			return ;
		}
		if("word" == value){
			type.value = "word";
			_rtfEdit.style.display = "none";
			_attEdit.style.display = "none";
			if(_isWpsWebOffice == "true"){
				$("#rtfWordEdit").height("100px");
			}
			if(_isWpsCloudEnable == "true" || _isWpsWebOfficeEnable == "true" || _isWpsWebOffice == "true"){
				$("#wordEdit").show();
				if(!wpsFlag){
					if(_isWpsCloudEnable == "true"){
						wps_cloud_editonline.load();
					}else if(_isWpsWebOfficeEnable == "true"){
						wps_editonline.load();
					}
				}
			}else{
				$("#rtfWordEdit").height("580px");
				//不能把display设为none,block，金格在多浏览器下不支持
				$("#wordEdit").css({ 
					width:'90%',
					height:'550px'
				});
				var obj = document.getElementById("JGWebOffice_editonline");
				setTimeout(function(){
					if(obj&&Attachment_ObjectInfo['editonline']&&!jg_attachmentObject_editonline.hasLoad){
						jg_attachmentObject_editonline.load();
						jg_attachmentObject_editonline.show();
						jg_attachmentObject_editonline.ocxObj.Active(true);
					}
				},1000);
				chromeHideJG_2015(1);
			}
		} else if("att" ==value){
			type.value = "att";
			_attEdit.style.display = "block";
			_rtfEdit.style.display = "none";
			//|| _isWpsWebOffice == "true" 去除 add by caooyng  dd
			if(_isWpsCloudEnable == "true" || _isWpsWebOfficeEnable == "true" ){
				$("#wordEdit").hide();
			}else{
				$("#wordEdit").css({
					width:'0px',
					height:'0px'
				});
				chromeHideJG_2015(0);
			}
			$("#rtfWordEdit").removeAttr("style");
		}
		else {
			_attEdit.style.display = "none";
			_rtfEdit.style.display = "block";
			if(_isWpsCloudEnable == "true" || _isWpsWebOfficeEnable == "true" || _isWpsWebOffice == "true"){
				$("#wordEdit").hide();
				$("#attEdit").hide();
				$("#rtfWordEdit").height("580px");
			}else{
				$("#wordEdit").css({
					width:'0px',
					height:'0px'
				});
				chromeHideJG_2015(0);
			}
		}
	}
</script>
<html:form action="/sys/news/sys_news_template/sysNewsTemplate.do"
	onsubmit="return validateSysNewsTemplateForm(this);">

	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_button.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="sysNewsTemplateForm" />
		</c:import>

	<p class="txttitle"><bean:message key="news.category.set" bundle="sys-news" /></p>

	<center>
		<table id="Label_Tabel" width=95%>
			<!-- 模板信息 -->
			<c:import url="/sys/simplecategory/include/sysCategoryMain_edit.jsp"
				charEncoding="UTF-8">
				<c:param name="formName" value="sysNewsTemplateForm" />
				<c:param name="requestURL" value="/sys/news/sys_news_template/sysNewsTemplate.do?method=add" />
				<c:param name="fdModelName" value="${param.fdModelName}" />
				<c:param name="fdKey" value="newsMainDoc" />
			</c:import>
			<!-- 基本信息 -->
			<tr id="tr_content"
				LKS_LabelName="<bean:message bundle='sys-news' key='news.template.baseInfo'/>">
				<td>
				<table id="base_info" class="tb_normal" width=100%>
					<%-- 编辑方式 --%>
					<html:hidden property="fdContentType" />
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-news" key="sysNewsMain.fdContentType" />
						</td>
						<td width="35%">
							<xform:radio property="fdEditType" showStatus="edit" value="${sysNewsTemplateForm.fdContentType}" onValueChange="checkEditType">
								<xform:enumsDataSource enumsType="sysNewsMain_fdContentType" />
							</xform:radio>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="sys-news" key="sysNewsMain.comment" />
						</td>
						<td width="35%">
							<html:hidden property="fdCanComment" /> 
							<label class="weui_switch">
								<span class="weui_switch_bd">
									<input type="checkbox" ${'true' eq sysNewsTemplateForm.fdCanComment ? 'checked' : '' } />
									<span></span>
									<small></small>
								</span>
								<span id="fdCanCommentText"></span>
							</label>
							<script type="text/javascript">
								function setText(status) {
									if(status) {
										$("#fdCanCommentText").text('<bean:message bundle="sys-news" key="sysNewsMain.fdCanComment.yes" />');
									} else {
										$("#fdCanCommentText").text('<bean:message bundle="sys-news" key="sysNewsMain.fdCanComment.no" />');
									}
								}
								$(".weui_switch :checkbox").on("click", function() {
									var status = $(this).is(':checked');
									$("input[name=fdCanComment]").val(status);
									setText(status);
								});
								setText(${sysNewsTemplateForm.fdCanComment});
							</script>
						</td>
					</tr>
					<kmss:ifModuleExist path="/elec/yqqs">
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="sys-news" key="sysNewsTemplate.fdSignEnable"/>
							</td>
							<td colspan="3">
								<html:hidden property="fdSignEnable" /> 
								<label class="weui_switch">
									<span class="weui_switch_bd">
										<input type="checkbox" ${'true' eq sysNewsTemplateForm.fdSignEnable ? 'checked' : '' } />
										<span></span>
										<small></small>
									</span>
									<span id="fdSignEnableText"></span>
								</label>
								<script type="text/javascript">
									$(".weui_switch :checkbox").on("click", function() {
										var status = $(this).is(':checked');
										$("input[name=fdSignEnable]").val(status);
									});
								</script>
								<bean:message bundle="sys-news" key="sysNewsTemplate.fdSignEnable.tip"/>
							</td>
						</tr>
					</kmss:ifModuleExist>
					<!-- 文档内容 -->
					<tr>
						<td class="td_normal_title" colspan="4" align="center"><bean:message
							bundle="sys-news" key="sysNewsTemplate.docContent" /></td>
					</tr>
					<tr>
						<td colspan="4">
							<div id="rtfWordEdit">
								<div id="rtfEdit" 
									<c:if test="${sysNewsTemplateForm.fdContentType!='rtf'}">style="display:none"</c:if>>
									<kmss:editor property="docContent" toolbarSet="Default" height="500" />
								</div>
								
								<c:choose>
									<c:when test="${_isWpsCloudEnable eq true}">
										<div id="wordEdit">
										<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline" />
											<c:param name="load" value="false" />
											<c:param name="bindSubmit" value="false"/>	
											<c:param name="fdModelId" value="${sysNewsTemplateForm.fdId}" />
											<c:param name="fdModelName" value="com.landray.kmss.sys.news.model.SysNewsTemplate" />
											<c:param name="fdTemplateKey" value="editonline" />
											<c:param name="formBeanName" value="sysNewsTemplateForm" />
										</c:import>
										</div>
									</c:when>
									<c:when test="${_isWpsWebOfficeEnable eq true}">
										<div id="wordEdit">
										<c:import url="/sys/attachment/sys_att_main/wps/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline" />
											<c:param name="load" value="false" />
											<c:param name="bindSubmit" value="false"/>	
											<c:param name="fdModelId" value="${sysNewsTemplateForm.fdId}" />
											<c:param name="fdModelName" value="com.landray.kmss.sys.news.model.SysNewsTemplate" />
											<c:param name="fdTemplateKey" value="editonline" />
											<c:param name="formBeanName" value="sysNewsTemplateForm" />
										</c:import>
										</div>
									</c:when>
									<c:when test="${pageScope._isWpsWebOffice == 'true'}">
									<div id="wordEdit">
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="editonline" />
											<c:param name="fdMulti" value="false" />
											<c:param name="fdModelId" value="${sysNewsTemplateForm.fdId}" />
											<c:param name="fdModelName" value="com.landray.kmss.sys.news.model.SysNewsTemplate" />
											<c:param name="bindSubmit" value="false"/>
										    <c:param name="isTemplate" value="true"/>
											<c:param name="fdTemplateKey" value="editonline" />
											<c:param name="templateBeanName" value="sysNewsTemplateForm" />
											<c:param name="showDelete" value="false" />
											<c:param name="wpsExtAppModel" value="sysNews" />
											<c:param name="canRead" value="false" />
											<c:param name="addToPreview" value="false" />
											<c:param  name="hideTips"  value="true"/>
											<c:param  name="hideReplace"  value="false"/>
											<c:param  name="canChangeName"  value="true"/>
											<c:param name="canEdit" value="true" />
										    <c:param name="canPrint" value="false" />
											<c:param  name="filenameWidth"  value="250"/>
										</c:import>
										</div>
									</c:when>
									<c:otherwise>
										<div id="wordEdit" style="position:absolute;height: 10px;width: 30px;overflow:hidden;">
											<%@ include file="/sys/attachment/sys_att_main/jg/sysAttMain_CheckJgSupport.jsp"%>
											<c:if test="${supportJg eq 'supported'}">
												<!-- 把高度宽度设为0，让它一开始不显示 -->
												<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
													<c:param name="fdKey" value="editonline" />
													<c:param name="fdAttType" value="office" />
													<c:param name="load" value="false"></c:param>
													<c:param name="fdModelId" value="${sysNewsTemplateForm.fdId}" />
													<c:param name="fdModelName" value="com.landray.kmss.sys.news.model.SysNewsTemplate" />
													<c:param name="bindSubmit" value="false"/>
													<c:param name="isTemplate" value="true"/>
												</c:import>	
											</c:if>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
								<!-- 正文上传 -->
								<div id="attEdit" style="border: 1px solid #d5d5d5; height:110px;display:none">
									<div class="lui_form_subhead">
										正文上传
									</div>
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="newsMain" />
										<c:param name="uploadAfterSelect" value="true" />
										<c:param name="fdMulti" value="false" />
										<c:param name="fdImgHtmlProperty" />
										<c:param name="fdModelId" value="${sysNewsMainForm.fdId }" />
										<c:param name="fdModelName" value="com.landray.kmss.sys.news.model.SysNewsMain" />
										<c:param name="wpsExtAppModel" value="sysnews" />
										
									</c:import>
							</div>
						</td>
					</tr>
					<!-- 关键字 
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="sys-news" key="sysNews.docKeyword" /></td>
						<td width=83%><html:hidden property="docKeywordIds" /> <html:text
							property="docKeywordNames" style="width:50%;" /></td>
					</tr>-->
						<!-- 标签机制 -->
					<c:import url="/sys/tag/include/sysTagTemplate_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="sysNewsTemplateForm" />
						<c:param name="fdKey" value="newsMainDoc" /> 
					</c:import>
					<!-- 标签机制 -->
					<!-- 新闻重要度 -->
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="sys-news" key="sysNewsMain.fdImportance" /></td>
						<td colspan=3>
							<sunbor:enums property="fdImportance" enumsType="sysNewsMain_fdImportance" elementType="radio" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<!-- 相关新闻 -->
			<tr
				LKS_LabelName="<bean:message bundle='sys-news' key='news.template.relation.news'/>">
				<c:set var="mainModelForm" value="${sysNewsTemplateForm}"
					scope="request" />
				<c:set
					var="currModelName"
					value="com.landray.kmss.sys.news.model.SysNewsMain"
					scope="request" />
				<td><%@ include
					file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
			</tr>
			<!-- 以下代码为嵌入流程模板标签的代码 -->
			<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
				charEncoding="UTF-8">
				<c:param name="formName" value="sysNewsTemplateForm" />
				<c:param name="fdKey" value="newsMainDoc" />
			</c:import>
			<!-- 以上代码为嵌入流程模板标签的代码 -->
				<%-- 以下代码为嵌入默认权限模板标签的代码 --%>
		   <tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />"><td>
			 <table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="sysNewsTemplateForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.sys.news.model.SysNewsTemplate" />
				</c:import>
			 </table>
		    </td></tr>
		<%-- 以上代码为嵌入默认权限模板标签的代码 --%>
			<!-- 规则机制 -->
			<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="sysNewsTemplateForm" />
				<c:param name="fdKey" value="newsMainDoc" />
				<c:param name="templateModelName" value="com.landray.kmss.sys.news.model.SysNewsTemplate"></c:param>
			</c:import>
		</table>
	</center>
	<html:hidden property="fdId" />
	<html:hidden property="method_GET" />
</html:form>
<html:javascript formName="sysNewsTemplateForm" cdata="false"
	dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>