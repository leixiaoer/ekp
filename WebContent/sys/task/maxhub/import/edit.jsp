<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.IDGenerator"%>
<%-- <%@ include file="/km/imeeting/import/time.jsp"%> --%>
<% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>
<template:include ref="maxhub.edit">

	<template:replace name="head">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/sys/task/maxhub/import/resource/css/edit.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="content">
		<form  action="${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do" id="sysTaskMainForm" name="sysTaskMainForm" method="post">
	<%-- 	<% 	
			String fdIds=IDGenerator.generateID(); 
			request.setAttribute("fdIds", fdIds);
		%> --%>
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
			<%--任务类型--%>
			<c:when test="${sysTaskMainForm.fdParentId != null}">
				<html:hidden property="fdCategoryId"/>
				<%--权重--%>
				<html:hidden property="fdWeights"/>
				<html:hidden property="fdOtherChildWeights" />
			</c:when>
			<c:otherwise>
				<html:hidden property="fdCategoryId"/>
			</c:otherwise>
		</c:choose>
		<%--通知方式 --%>
		<span style="display: none;">
			<kmss:editNotifyType property="fdNotifyType" />
		</span>
		<div class='addTaskContent' data-dojo-type="mui/form/_ValidateMixin" >
			<div class='addBoxTop'>
				<div class='qcode'>
					<div id="qcodeImg"></div>
					<p>扫一扫承接任务</p>
				</div>
				<div class='taskInfo'>
					<div>
						<div data-dojo-type='mhui/form/Input'
							data-dojo-mixins='sys/task/maxhub/import/resource/js/LabelMixin'
							data-dojo-props='extendText:"${param.fdName}",labelText:"${lfn:message('sys-task:sysTaskMain.task.name')} :",filedname:"docSubject",require:true,fdModelId:"${sysTaskMainForm.fdModelId}",taskName:"${param.taskName}"'
							id="digit_docSubject"
						></div>
						<div data-dojo-type='mhui/form/SelectorDate'
							data-dojo-props='labelText:"${lfn:message('sys-task:sysTaskMain.fdPlanCompleteTime')} :",options:[{text:"今天",value:"1"},{text:"明天",value:"2"},{text:"后天",value:"3"},{text:"一周",value:"4"},{text:"一个月",value:"5"}],nameGrop:{fdPlanCompleteDate:"",fdPlanCompleteTime:""}'
						></div>
						<div data-dojo-type='mhui/form/Input'
							data-dojo-mixins='sys/task/maxhub/import/resource/js/LabelMixin'
							data-dojo-props='labelText:"${lfn:message('sys-task:sysTaskMain.fdAppoint')} :",value:"${currentUser.userName}",disabled:"disabled", nameGrop:[{name:"fdAppointId",value:"${currentUser.userId}"},{name:"fdAppointName",value:"${currentUser.userName}"}]'
						></div>
					
						<div class='mhuiFormItem'>
							<span class='SelectorLabelText'>${lfn:message('sys-task:sysTaskMain.attachment')} :</span>
							<div class="addBtnAttempt">
								<c:import url="/sys/attachment/maxhub/import/edit.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="sysTaskMainForm" />
									 <c:param name="fdModelId" value="${ fdId}"/>
									<c:param name="fdModelName" value="com.landray.kmss.sys.task.model.SysTaskMain"/> 
									<c:param name="fdKey" value="attachment" />
									<c:param name="hiddenOpt" value="true" />
								</c:import>
								<div class="addAttchmentBtn" onclick="synFiles()"><div></div><div class="btnRow"></div></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="performSubject">${lfn:message('sys-task:sysTaskMain.portlet.selectCategory')}${lfn:message('sys-task:sysTaskMain.fdPerform')}<span>(必填)</span>:</div>
		    <div class='addBoxBottom'>
		    	 <div class="addBoxBottomName"></div>
				 <ul class="underTakerList"></ul> 		
		    </div>
		    <p class="addBoxRquire performSubject"></p>
		</div>
		<script>
		require(['dojo/dom', 'dojo/dom-construct', 'dojo/dom-class', 'dojo/dom-style', 'dojo/_base/array', 'dojo/html', 'dojo/on', 'dojo/promise/all',
		         'dojo/query', 'dojo/topic', 'dijit/registry', 'mhui/device/jssdk', 'mhui/dialog/Dialog', 'dojo/request',
		         'dojo/date/locale', 'dojo/date', 'mui/util', 'mui/qrcode/QRcode', 'dojo/ready','mhui/dialog/Dialog','dojo/_base/xhr','mhui/util','mui/dialog/Tip',"dojo/touch",
		         'mhui/device/jssdk'
		         ], 
			function(dom, domCtr, domClass, domStyle, array, html, on, promiseAll, query, topic, registry, jssdk, Dialog, request, 
					locale, date, util, QRcode, readye,dialog,xhr,mutil,tip,touch) {
			
			
						//附件调用函数
						window.synFiles = function() {
							topic.publish('attachmentObj_attachment_selectFile',{
								complete : function(){
									//注册附件信息
									topic.publish('attachmentObject_attachment_submit', {
										success: function() {
											
											
										}
									});
									//刷新附件查看区域
									//topic.publish('attachmentObject_tmpAttachment_refresh');
								}
							});
						};
					/***************************************************************************************/
					var PerformArray =  [
			                       {fdId:'${currentUser.userId}',fdName:'${currentUser.userName}',fdAvatar:'${LUI_ContextPath}/sys/organization/image.jsp?orgId=${currentUser.userId}&size=m&s_time=1533273775478'}
			                      ];
					var requestMode = 'save';
					//会议id				
					var fdModelId= mutil.getUrlParameter(window.location.href,'fdModelId');
					var fdModelName = mutil.getUrlParameter(window.location.href,'fdModelName');
					
					
					jssdk.setMeetingOptions({ meetingId : fdModelId });
					
					//taskInfo定义在TaskListItem
					var __taskInfo__=window.parent.taskInfo;
					//任务id
					var taskId = mutil.getUrlParameter(window.location.href,'fdId');
					if(!taskId){
						taskId = query("input[name=fdId]")[0].value;
					}else{
						//编辑页面
						query("input[name=docCreateTime]")[0].value=__taskInfo__.created;
						query("input[name=fdProgress]")[0].value=__taskInfo__.progress;
						var performs =__taskInfo__.performs.split('，');
						var performsid = __taskInfo__.performsid.split(',');
						requestMode = 'update';
						PerformArray=[];//清空
					    for(var i= 0;i<performs.length;i++){
					    	PerformArray.push({fdId:performsid[i],fdName:performs[i],fdAvatar:'${LUI_ContextPath}/sys/organization/image.jsp?orgId='+performsid[i]+'&size=m&s_time=1533273775478'});
						} 
					}
			
					var qcodeUrl =location.origin + dojoConfig.baseUrl+'/sys/task/sys_task_main/sysTaskMain.do?method=addPerform&fdId='+taskId;
					var getAttendPersons = null;//参加会议人员集合
					var performDialogObject = null;//选择负责人弹窗对象

					var PerformId=[];
					var PerformName=[];
					var PerformList = query(".underTakerList");
					var qcodeNode = dom.byId('qcodeImg');
					var addPerformBtn = null;//添加责任人按钮
				
					//生成二维码，通过扫码成为负责人
					gencode(qcodeNode,qcodeUrl);
					//生成默认责任人
					addPerform();
					//添加删除事件
					removePerform();
					//添加选择责人任事件
					selectPerform();
				
					//通过扫码变为的责任人
					var tiemr = setInterval(function(){
						getPerform()
					},2000); 
					
					//二维码生成函数
					function gencode(node, url){
						
						var obj = QRcode.make({
							url : url,
							width: 300,
							height: 300
						});	
						domCtr.place(obj.domNode, node); 
					}		
					//添加责任人
					function addPerform(){
						
						if(addPerformBtn){
							domCtr.place(addPerformBtn,query(".addBoxBottom")[0],'last');
						}
						//清除dom addBoxBottomName
						domCtr.empty(PerformList[0]);
						query(".addBoxBottomName")[0].innerHTML="";
						PerformId=[];//清空
						PerformName=[];
						//渲染dom
						array.forEach(PerformArray,function(item,index){
							var underTakerInfo = domCtr.create('li',{innerHTML:'<image/ src="'+item.fdAvatar+'"><div class="underTakerName">'+item.fdName+'</div>'},PerformList[0]);
							var underTakerCancel = domCtr.create('span',{className:"mui mui-fail underTakerCancel"},underTakerInfo);		
							var fdId = domCtr.create('input',{type:'hidden',value:item.fdId},underTakerInfo);
							PerformId.push(item.fdId);
							PerformName.push(item.fdName);
						})
						
						if(!addPerformBtn){
							addPerformBtn = domCtr.create('li',{innerHTML:'<div class="addUnderTakerBtn"><div class="lineh"></div><div class="lineV"></div></div>'});
							domCtr.place(addPerformBtn,PerformList[0],'last');
						}else{
							domCtr.place(addPerformBtn,PerformList[0],'last');
						}
						
						//添加负责人字段
						domCtr.create("input",{type:"hidden",name:"fdPerformId",value:PerformId.join(';')},query(".addBoxBottomName")[0]);
						domCtr.create("input",{type:"hidden",name:"fdPerformName",value:PerformName.join(';')},query(".addBoxBottomName")[0]);
						//如果只有一个人责任人去除删除按钮
						/* if(PerformArray.length<2){
							var aCancel = PerformList[0].querySelectorAll('li span');
							domStyle.set(aCancel[0],"display","none");
						} */
					}
					
					//删除负责人
					function removePerform(){
					    on(PerformList[0],'click',function(e){
					    	if(e.target.tagName.toUpperCase()=='SPAN'){ 
					    		var _temple_=PerformArray;
					    		var nextNode = e.target.nextElementSibling;
					    		for(var i = 0;i<_temple_.length;i++){
					    			if(_temple_[i].fdId==nextNode.value){
					    				_temple_.splice(i,1);
					    			}
					    		} 
					    	
					    		var oIndex = PerformId.indexOf(nextNode.value);
					    		PerformId.splice(oIndex,1);
					    		PerformName.splice(oIndex,1);
					    		query("input[name=fdPerformId]")[0].value=PerformId.join(";");
					    		query("input[name=fdPerformName]")[0].value=PerformName.join(";");
					    		PerformList[0].removeChild(e.target.parentNode);
					    		
					    		//
					    		/* if(PerformArray.length<2){
									var aCancel = PerformList[0].querySelectorAll('li span');
									domStyle.set(aCancel[0],"display","none");
								} */
					    		
					    	}
					    })
					}
					
					//获取扫码结果
					function getPerform(){
						var getUnderTakerUrl ='${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=getPerformByTaskId&fdId='+taskId;
						return  request.get(getUnderTakerUrl,{
							handAs:'json'
						}).then(function(response){
							var res = JSON.parse(response);
							
							if(res.length>0){
								
								var temp = [];
								for(var i = 0;i<res.length;i++){
									var flag = true;
									for(var j = 0;j<PerformArray.length;j++){
										if(res[i].fdId==PerformArray[j].fdId){
											flag = false;
											break;
										}
									}
									
									if(flag){
									
										temp.push(res[i]);
									}
								}
								if(temp.length>0){
									PerformArray = PerformArray.concat(temp);
									addPerform();
								}
							}
							
							
						});
					}
					;
					//获取参会人员
					function getAttendPerson(){
						tip.processing();
						var meetId= '<%=request.getParameter("fdModelId")%>';
						var attendPersonUrl =' ${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=mhuShowAttendPersons&fdId='+meetId;
						return  request(attendPersonUrl, {
							method: 'post',
							handleAs: 'json'
						}).then(function(res){
							if(res){
								tip.success();
								getAttendPersons =res;
							}
						},function(err){
							
						});
		
					}
					
					//选择责任人
					function selectPerform(){
							on(addPerformBtn,'click',function(){
								var dialogPerfomBox = domCtr.create("div",{class:'dialogPerfomBox'});
								var performDialogNode = domCtr.create("ul",{className:'underTakerNode'},dialogPerfomBox);
									var childNode = '';
									getAttendPerson().then(function(){
										array.forEach(getAttendPersons,function(item){
											 var flag = true;
											
											 for(var i = 0;i<PerformArray.length;i++){
												 if(item.attendId==PerformArray[i].fdId){
													 flag = false;
												 }
											 }
											 if(flag){
												 childNode +="<li><input type='checkbox'/ value=''><img src='"+item.imgUrl+"'/><span>"+item.attendName+"</span><input type='hidden' value="+item.attendId+"></li>"; 
											 }
										 });
										performDialogNode.innerHTML = childNode;
										if(childNode==''){
											domCtr.create("div",{className:"noPersonImage",innerHTML:"<div class='notperson'>暂无可选负责人</div>"},dialogPerfomBox);
										}
										performDialogObject = dialog.show({
											  width:"50%",
											  height:"70%",
											  title:"选择负责人",
											  content:dialogPerfomBox,
											  isTop:true,
											  buttons:[{text:'取消',className:'',onClick:performDialogCancel},{text:'确定',className:'',onClick:performDialogConfirm}]
										  });
									});
	
									
									//弹窗取消回调函数
									function performDialogCancel(){
										performDialogObject.hide();
									}
									//弹窗确定回调函数
									function performDialogConfirm(){
										//var checkBoxs = query(".underTakerNode input[type=checkbox]");
										var checkBoxs = performDialogNode.querySelectorAll("input[type=checkbox]");
										var checkedIndex = [];
										
										
										array.forEach(checkBoxs,function(item,index){
											if(item.checked){
												var parentNode =  item.parentNode;
												var img = query('img',parentNode)[0].src;
												
												var name = query('span',parentNode)[0].innerHTML;
												var id = query('input[type=hidden]',parentNode)[0].value;
												PerformArray.push({fdId:id,fdName:name,fdAvatar:img});	
											}
										});
										addPerform();
										performDialogObject.hide();
									}	
								});
					}
						
						

					
					 window.task_commit=function(){
						 var formObj = document.sysTaskMainForm;
						 var digitLabel = registry.byId("digit_docSubject");
						 if(digitLabel.validate){
							 var url = formObj.action+"?method=save&fdModelId="+fdModelId+"&fdModelName="+fdModelName+"&s_seq=1";
							 var performComment= query(".addBoxRquire")[0];
							 var performName = query(".addBoxBottomName input[name=fdPerformId]")[0];
							 if(performName.value){
								 if(requestMode=='update'){
									 url = formObj.action+'?method=update&fdId='+taskId+'&s_seq=1';
									 //query("input[name=docStatus]")[0].value=20;
								 }
								 return xhr.post({
									 url:url,
									 form:formObj,
									 load:function(res){
										 
									 }
							 	 }); 
							 }else{
								 performComment.innerHTML="请选择负责人";
								 return false;
							 }
							
						 }else{ 
							 digitLabel.validateRequire(digitLabel.inputNode);
							 return false;
						 }
						   
					 }
					
			}
		);
		
		</script>
		</form>
	</template:replace>
</template:include>
