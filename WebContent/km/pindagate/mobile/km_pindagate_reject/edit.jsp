<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="java.util.List"%>

<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
		<style>
			#reject-title{
				background:#fff;
				padding:1rem;
				border-bottom:1px solid #eee;
			}
			
			#rejectReason{
				background:#fff;
			}
			#rejectReason textarea{
				padding:1rem 0 0 1rem;
			}
			#validateErr{
				display:none;
				color:red;
			}
		</style>
	</template:replace>

	<template:replace name="title">
		<c:out value=""></c:out>
	</template:replace>

	<template:replace name="content">
		<html:form action="/km/pindagate/km_pindagate_reject/kmPindagateRejectPerson.do">
			<html:hidden property="kmPindagateId" value="${param.pindageteId}"/>
			<html:hidden property="method_GET" />
			<html:hidden property="responseTime"/>
			<html:hidden property="personId" value="${KMSS_Parameter_CurrentUserId}"/>
			<div data-dojo-type="mui/view/DocScrollableView" id="scrollView">
				<div id="reject-title"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.writingReasons"/></div>
				<div id="rejectReason">
					<div data-dojo-type="mui/form/Textarea" data-dojo-props="required:true,name:'rejectReason',placeholder:'请输入不参加调查原因'"></div>
					<div id="validateErr">不能为空</div>
				</div>
				<ul id='TabBar' data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
					<li data-dojo-type="mui/tabbar/TabBarButton"  class="muiBtnSubmit muiPindagateSubmit" data-dojo-props="colSize:1" onclick='commitForm'>
						 确定不参与并提交原因
					</li>
				</ul>
			</div>
		</html:form>
		<script>
			require(["mui/form/ajax-form!kmPindagateRejectPersonForm"]);
			require(["mui/util",'dojo/ready'],function(util,ready){
				var pindagateTime = util.formatDate(new Date,Com_Parameter.DateTime_format);
				document.querySelector("input[name=responseTime]").value=pindagateTime;
					window.commitForm = function(){
						var date = new Date();
						var textarea = document.querySelector("textarea");
						var textareaErr = document.querySelector("#validateErr");
						if(textarea.value){
							textareaErr.style.display = "none";
							Com_Submit(document.kmPindagateRejectPersonForm,'save');
						}else{
							textareaErr.style.display = "block"
						}
					}
			})
			

		</script>
	</template:replace>
</template:include>


