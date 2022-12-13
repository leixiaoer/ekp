<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="com.landray.kmss.sys.task.model.SysTaskConfig"%>
<%
	SysTaskConfig taskConfig = new SysTaskConfig();
	request.setAttribute("taskAssignorConfig", taskConfig.getTaskAssignorConfig());
%>
<template:include ref="mobile.edit" compatibleMode="true">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ sysTaskMainForm.method_GET == 'add' }">
				<c:out value="${ lfn:message('sys-task:tree.task.create') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${sysTaskMainForm.docSubject}"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	
	<template:replace name="head">
		<mui:min-file name="mui-task-edit.css"/>
	</template:replace>
	<template:replace name="content">
	<xform:config  orient="vertical"> 
		<html:form action="/sys/task/sys_task_main/sysTaskMain.do">
			<html:hidden property="fdId" />
			<html:hidden property="docStatus" />
			<html:hidden property="fdRootId" />
			<html:hidden property="docCreatorId" />
			<html:hidden property="docCreateTime"/>
			<html:hidden property="fdWorkId" />
			<html:hidden property="fdPhaseId" />
			<html:hidden property="fdModelId" /> 
			<html:hidden property="fdModelName" />
			<html:hidden property="fdKey" />
			<html:hidden property="fdStatus" />
			
			<div data-dojo-type="mui/view/DocScrollableView" id="scrollView" class="gray" data-dojo-mixins="mui/form/_ValidateMixin">
			
				<div class="muiImportBox">
					<%-- rtf --%>
					<div data-dojo-type="mui/form/Editor"
						 data-dojo-mixins="sys/task/mobile/resource/js/EditorMixin" 
						 data-dojo-props="docContent:'',orient:'vertical',name:'docContent',placeholder:'${lfn:message('sys-task:sysTaskMain.docContent')}',plugins:['face','image','${LUI_ContextPath}/sys/task/mobile/resource/js/RtfAttachmentPlugin.js']" 
						 class="muiEditor" >
					</div>
			
					<%-- 附件区域,嵌入rtf的操作栏中 --%>
					<div id='attachmentView' class="attachmentView">
						<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="sysTaskMainForm"></c:param>
							<c:param name="fdKey" value="attachment"></c:param>
						</c:import> 
					</div>
				</div>
				<div class="muiKKIMSource" ontouchstart="window.onViewSourceClick()">
					<i class="mui-msg mui"></i>${sysTaskMainForm.fdSourceSubject}
				</div>
				<%-- 任务类型 --%>
				<div class="muiTaskCategory">
					<table class="muiSimple" cellpadding="0" cellspacing="0">
						<tr>
							<td style="border-bottom: 0;border-top: 1px solid #d5d5d5">
								<xform:select property="fdCategoryId" mobile="true" 
									subject="${lfn:message('sys-task:sysTaskMain.fdCategoryId')}" 
									showStatus="edit" isLoadDataDict="false">
									<xform:beanDataSource serviceBean="sysTaskCategoryService" selectBlock="fdId,fdName" whereBlock="sysTaskCategory.fdIsAvailable = 1" orderBy="sysTaskCategory.fdOrder asc"/>
								</xform:select>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="muiHeader muiTaskHeader">
					<div
						data-dojo-type="mui/nav/MobileCfgNavBar" 
						data-dojo-mixins="sys/task/mobile/resource/js/NavBarMixin"
						data-dojo-props="defaultUrl:'/sys/task/mobile/edit_nav.jsp',height:'6rem',scrollDir:''"
						id="topNavBar" class="muiTaskNavBar">
					</div>
				</div>
			
				<%-- 时间 --%>
				<div id="dateView" data-dojo-type="dojox/mobile/View">
				
					<div data-dojo-type="mui/nav/MobileCfgNavBar" 
						data-dojo-props="defaultUrl:'/sys/task/mobile/edit_date_nav.jsp'"
						id="dateNavBar" class="sysTaskNavBar">
					</div>
					<div class="muiTaskDatetimeContainer">
						<xform:datetime property="fdPlanCompleteDate" dateTimeType="date" mobile="true" required="true" 
							htmlElementProperties="id='fdPlanCompleteDate'">
						</xform:datetime>
						<xform:datetime property="fdPlanCompleteTime" dateTimeType="time" mobile="true" required="true" 
							htmlElementProperties="id='fdPlanCompleteTime'">
						</xform:datetime>
						<div class="newMui muiTaskWeekContainer muiFormEleWrap showTitle">
							<div class="muiFormEleTip">
								<span class="muiFormEleTitle">星期</span>
							</div>
							<div class="muiTaskWeek"></div>
						</div>
					</div>
				</div>
				
				<%-- 人员 --%>
				<div id="personView" data-dojo-type="dojox/mobile/View">
					<ul class="muiSettingPeopleList">
						<%--负责人--%>
						<li>
							<xform:address propertyId="fdPerformId" propertyName="fdPerformName" 
								subject="${lfn:message('sys-task:sysTaskMainPerform.fdPerformId') }"
								orgType='ORG_TYPE_PERSON' mulSelect="true" mobile="true" required="true"></xform:address>
						</li>
						<%--指派人--%>
						<li>
							<c:choose>
								<c:when test="${taskAssignorConfig eq 'true'}">
									<xform:address propertyId="fdAppointId" propertyName="fdAppointName"
											subject="${lfn:message('sys-task:sysTaskMain.fdAppoint')}" 
											orgType='ORG_TYPE_PERSON' mobile="true"></xform:address>
								</c:when>
								<c:otherwise>
									<xform:address showStatus = "readOnly" propertyId="fdAppointId" propertyName="fdAppointName"
										subject="${lfn:message('sys-task:sysTaskMain.fdAppoint')}" 
										orgType='ORG_TYPE_PERSON' mobile="true"></xform:address>
								</c:otherwise>
							</c:choose>
						</li>
						<%--抄送人--%>
						<li>
							<xform:address propertyId="fdCcIds" propertyName="fdCcNames"
								subject="${lfn:message('sys-task:sysTaskMainCc.fdCcId')}"
								orgType='ORG_TYPE_ALL' mulSelect="true" mobile="true"></xform:address>
						</li>
					</ul>
				</div>
				
				
				<%-- 同步 --%>
				<div id="syncView" class="syncView" data-dojo-type="dojox/mobile/View">
					 <xform:radio property="syncDataToCalendarTime" showStatus="edit" mobile="true">
			       		<xform:enumsDataSource enumsType="sysTaskMain_syncDataToCalendarTime" />
					</xform:radio>
					<c:import url="/sys/agenda/mobile/general_edit.jsp"	charEncoding="UTF-8">
				    	<c:param name="formName" value="sysTaskMainForm" />
				    	<c:param name="fdKey" value="taskMainDoc" />
				    	<c:param name="fdPrefix" value="sysAgendaMain_general_edit" />
				    	<c:param name="fdModelName" value="com.landray.kmss.sys.task.model.SysTaskMain" />
				    	<%--可选字段 1.syncTimeProperty:同步时机字段； 2.noSyncTimeValues:当syncTimeProperty为此值时，隐藏同步机制 --%>
						<c:param name="syncTimeProperty" value="syncDataToCalendarTime" />
						<c:param name="noSyncTimeValues" value="noSync" />
				 	</c:import>
				</div>
				
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	<c:if test="${ sysTaskMainForm.method_GET == 'add' }">
					  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit " 
					  		data-dojo-props='colSize:2,href:"javascript:commitMethod(\"save\",\"false\");",transition:"slide"'>
					  		${lfn:message('sys-task:sysTaskFeedback.button.submit')}	
					  	</li>
				  	</c:if>
				  	<c:if test="${ sysTaskMainForm.method_GET == 'edit' }">
				  		<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit " 
					  		data-dojo-props='colSize:2,href:"javascript:commitMethod(\"update\",\"false\");",transition:"slide"'>
					  		${lfn:message('sys-task:mui.sysTaskMain.update')}	
					  	</li>
				  	</c:if>
				</ul>
			</div>
			
			
			<!-- 移动端先不考虑这些选项 -->
			<html:hidden property="isDivide" />
			<html:hidden property="fdResolveFlag" />
			<html:hidden property="fdProgressAuto" />
			<html:hidden property="fdProgress" />
			
			<html:hidden property="fdParentId"/>
			<c:choose> 
				<%--任务来源 --%>
				<c:when test="${not empty sysTaskMainForm.fdSourceSubject && not empty sysTaskMainForm.fdSourceUrl}">
					<html:hidden property="fdSourceSubject"/>
					<html:hidden property="fdSourceUrl"/>
				</c:when>
				<c:when test="${not empty sysTaskMainForm.fdSourceSubject && empty sysTaskMainForm.fdSourceUrl}">
					<html:hidden property="fdSourceSubject"/>
					<html:hidden property="fdSourceUrl"/>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${sysTaskMainForm.fdParentId != null}">
					<%--权重--%>
					<html:hidden property="fdWeights"/>
					<html:hidden property="fdOtherChildWeights" />
				</c:when>
			</c:choose>
			<%--通知方式 --%>
			<span style="display: none;">
				<kmss:editNotifyType property="fdNotifyType" />
			</span>
			<%--kk集成转任务 --%>
			<%@ include file="/sys/task/mobile/kk/edit_kkinfo.jsp"%>
		</html:form>
	</xform:config>
	</template:replace>
</template:include>
<script type="text/javascript">

require(["mui/form/ajax-form!sysTaskMainForm"]);
require(['dojo/ready','mui/util','dojo/date/locale','dojo/date','dojo/query','dojo/topic','dijit/registry','mui/dialog/Tip','dojo/dom-style','dojo/window',"mui/device/adapter","dojo/dom-class","mui/form/ajax-form"],
		function(ready,util,locale,dateClz,query,topic,registry,Tip,domStyle,win,adapter,domClass,ajaxForm){
	//KK转任务
	var fdSourceType = "${sysTaskMainForm.fdSourceType}";
	var methodGet = "${sysTaskMainForm.method_GET}";
	
	//校验对象
	var validorObj=null;

	ready(function(){
		validorObj=registry.byId('scrollView');
		//初始化星期
		_setWeek();
		//调整页面高度
		resziePage();
		//KK转任务
		initKKIM();
	});

	//提交
	window.commitMethod=function(commitType, saveDraft){
		if(validorObj.validate() && validateTime()){
			var formObj = document.sysTaskMainForm;
			var docStatus = document.getElementsByName("docStatus")[0];
			if(saveDraft=="true"){
				docStatus.value="10";
			}else{
				docStatus.value="20";
			}
			
			 if('save'==commitType){
				Com_Submit(formObj, commitType,'fdId');
		    }else{
		    	Com_Submit(formObj, commitType); 
		    } 
		}
	};
	
	function validateTime(){
		var dateStr=query('[name="fdPlanCompleteDate"]')[0].value+' '+query('[name="fdPlanCompleteTime"]')[0].value;
		var date=locale.parse(dateStr,
			{
				selector : 'time',
				timePattern : "${ lfn:message('date.format.datetime') }"
			});
		if(dateClz.compare(date,new Date()) <= 0){
			Tip.fail({text: '<bean:message key="sys-task:sysTaskMain.min" argKey0="sys-task:sysTaskMain.fdPlanCompleteTime" argKey1="sys-task:sysTaskMain.fdCurrentTime" />',width:win.getBox().w * 0.5});
			return false;
		}
		return true;
	}
	
	//设置星期
	function _setWeek(){
		var dateStr=query('[name="fdPlanCompleteDate"]')[0].value+' '+query('[name="fdPlanCompleteTime"]')[0].value;
		var date=locale.parse(dateStr,
			{
				selector : 'time',
				timePattern : "${ lfn:message('date.format.datetime') }"
			});
		query('.muiTaskWeek')[0].innerHTML=calendarNameArray[date.getDay()];
	}
	
	//设置日期
	var calendarNameArray='${lfn:message("calendar.week.names")}'.split(',');//calendar.week.shortNames=日,一,二,三,四,五,六
	function _setDate(datetype){
		var date=new Date();
		switch(datetype){
			case 1:date.setDate(date.getDate());break;
			case 2:date.setDate(date.getDate()+1);break;
			case 3:date.setDate(date.getDate()+2);break;
			case 4:date.setDate(date.getDate()+7);break;
			case 5:date.setMonth(date.getMonth()+1);break;
		}
		registry.byId('fdPlanCompleteDate').set("value",locale.format(date,{
			selector : 'time',
			timePattern : "${ lfn:message('date.format.date') }"
		}));
		registry.byId('fdPlanCompleteTime').set("value",locale.format(date,{
			selector : 'time',
			timePattern : "${ lfn:message('date.format.time') }"
		}));
		_setWeek();
	}
	
	topic.subscribe('/mui/navitem/_selected',function(srcObj){
		//切换navitem联动修改日期
		if(srcObj.datetype){
			_setDate(srcObj.datetype)
		}
	});
	
	//日期改变联动修改周几
	topic.subscribe('/mui/form/datetime/change',function(){
		var dateStr=query('[name="fdPlanCompleteDate"]')[0].value+' '+query('[name="fdPlanCompleteTime"]')[0].value;
		_setWeek();
	});
	
	//重新调整页面高度
	function resziePage(){
		var scrollView=registry.byId('scrollView').domNode,
			dateView=registry.byId('dateView').domNode,
			personView=registry.byId('personView').domNode,
			syncView=registry.byId('syncView').domNode,
			minHeight=scrollView.offsetHeight - dateView.offsetTop;
		domStyle.set(dateView,'min-height',minHeight+'px');
		domStyle.set(personView,'min-height',minHeight+'px');
		domStyle.set(syncView,'min-height',minHeight+'px');
	}
	
	//特殊处理:当校验不通过的元素有负责人时，切换navitem
	topic.subscribe('/mui/validate/afterValidate',function(widget,errors){
		if(errors.length>0){
			var error=errors[0];
			if(error.key && error.key=='fdPerformId'){
				var topNavBar=registry.byId('topNavBar'),
					items=topNavBar.getChildren(),
					personItem=null;
				for(var i in items){
					if(items[i].moveTo && items[i].moveTo=='personView'){
						personItem=items[i];
						break;
					}
				}
				if(personItem){
					personItem.transitionTo('personView');
					personItem.setSelected();
				}
			}
		}
	});
	//kkim转任务时兼容
	function initKKIM(){
		if(fdSourceType=='KK_IM' && methodGet=='add'){
			var editorNode = query('.muiImportBox .muiEditor')[0];
			var contentObj = registry.byNode(editorNode);
			contentObj.__textNode.innerHTML = '${sysTaskMainForm.docContent}';
			domClass.add(contentObj.domNode,"showTitle");
			//附件初始化
			var atts = eval('${fdKkInfoJson.attachment}');
			var fdId = "${sysTaskMainForm.fdId}";
			console.log('atts:' +JSON.stringify(atts));
			if(atts && atts.length>0){
				for(var i =0;i < atts.length;i++){
					var record = atts[i];
					if(record.type==1 || record.type==2){
						//图片或文件
						var tmpPrefix = fdId +"_" + i;
						var fileName = record.type==1 ? (tmpPrefix +".png"):(record.name || tmpPrefix);
						var filepath = "sdcard://kkDownloadIM/" + fileName;
						var options = {
							url:record.res,
							path:filepath
						};
						var attNode = query('.attachmentView .muiFormUploadWrap')[0];
						var attObj = registry.byNode(attNode);
						if(i%2==1){
							setTimeout(function(){
								_uploadFile(options,attObj);
							},1000);
						}else{
							_uploadFile(options,attObj);
						}
					}
					if(record.type==3){
						window.kkIMSourceIndex = record.res;
						contentObj.__textNode.innerHTML = '';
						domStyle.set(query('.muiKKIMSource')[0],'display','block');
					}
				}
			}
			ajaxForm.ajaxForm("[name='sysTaskMainForm']", {
				success:function(result){
					Tip.success({
						text: "${lfn:message('sys-mobile:mui.return.success') }", 
						callback: function(){
							sendKkNotify();
						}, 
						cover: true
					});
				},
				error:function(result){
				}
			});
		}
	};
	
	function _uploadFile(options,attObj){
		adapter.downloadByUrl(options,function(result){
			console.log('下载kk转任务附件成功:' + JSON.stringify(result));
			adapter.uploadFileByApp({
				path : result.path,
				options:attObj
			},function(res){
				domStyle.set(query('.attachmentView')[0],'display','block');
				console.log('kk转任务附件初始化成功!');
				//记录当前附件对象信息
				window.kkImFile = {};
				window.kkImFile.name=res.name;
				window.kkImFile.size=res.size;
			},function(err){
				Tip.fail({text: '<bean:message key="sys-task:sysTaskMain.kkim.att.fail" />'});
			});
			
		},function(error){
			console.error('下载kk转任务附件失败:' + error);
		});
	};
	//发送kk消息
	function sendKkNotify(contentObj){
		var editorNode = query('.muiImportBox .muiEditor')[0];
		var contentObj = registry.byNode(editorNode);
		var fdId = query('input[name="fdId"]')[0].value;
		var subject = query('input[name="docSubject"]')[0].value;
		var fdPerformName = query('input[name="fdPerformName"]')[0].value;
		var fdPlanCompleteDate = query('input[name="fdPlanCompleteDate"]')[0].value;
		var fdPlanCompleteTime = query('input[name="fdPlanCompleteTime"]')[0].value;
		var fdKkSessionType = query('input[name="fdSessionType"]')[0].value;
		var fdKkTypeId = query('input[name="fdTypeId"]')[0].value;
		//分享消息
		var atts = eval('${fdKkInfoJson.attachment}');
		var attachmentType= '',attachmentUrl='',attachmentName='',attachmentSize='';
		if(atts && atts.length>0){
			for(var i =0;i < atts.length;i++){
				var record = atts[i];
				if(record.type==1 || record.type==2){
					attachmentType = record.type;
					attachmentUrl = record.res;
					attachmentName = record.type==2 ? record.name:attachmentName;
					if(window.kkImFile.size){
						attachmentSize = window.kkImFile.size;
					}
					break;
				}
			}
		}
		var recieverType = '';
		if(fdKkSessionType=='0'){
			recieverType = 'user';
		}
		if(fdKkSessionType=='1'){
			recieverType = 'group';
		}
		if(fdKkSessionType=='2'){
			recieverType = 'discuss';
		}
		var url = "/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId="+fdId;
		var split = String.fromCharCode(0);
		var summary = '<bean:message key="sys-task:sysTaskMain.kkim.fdExecutor" />:{fdAppointName}' + split+ '<bean:message key="sys-task:sysTaskMain.fdPlanCompleteTime" />:{fdPlanDatetime}';
		summary = summary.replace('{fdAppointName}',fdPerformName).replace('{fdPlanDatetime}',fdPlanCompleteDate+" " + fdPlanCompleteTime);

		var content = contentObj._format() || ' ';
		var textNode = __textNode = query('div.muiEditorTextarea',this.textContainerNode)[0];
		content = textNode.innerText;
		content = content.replace(/<br>/ig,'\n').replace(/<[^>]+>/g,"");
		var context = {
			dest:'kk',
			recieverType : recieverType,
			type:'biz',
			content:content,
			url : url,
			showChooseView:'false',
			attachmentType:attachmentType,
			attachmentUrl:attachmentUrl,
			attachmentName:attachmentName,
			attachmentSize:attachmentSize,
			recieverList:fdKkTypeId,
			title:'<bean:message key="sys-task:module.sys.task.hr" />',
			bizType:1,
			summary:summary
		};
		console.log(context);
		adapter.shareTo(context,function(){
			adapter.goBack();
		},function(){
			adapter.goBack();
		});
	};
	window.onViewSourceClick =function(){
		var fdKkSessionType = query('input[name="fdSessionType"]')[0].value;
		var fdKkTypeId = query('input[name="fdTypeId"]')[0].value;
		var fdSessionId = "${sysTaskMainForm.fdSessionId}";
		var sourceIndex = window.kkIMSourceIndex;
		var options = {
				sessionID:fdSessionId,
				msgIndexs:sourceIndex
		};
		console.log(JSON.stringify(options));
		adapter.genSessionChatMsgUrl(options,function(res){
			console.log(res.url);
			adapter.open(res.url,'_blank');
		},function(err){
			console.log('genSessionChatMsgUrl fail');
		});
	}
	
});	


</script>


