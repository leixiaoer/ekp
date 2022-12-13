<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no" showQrcode="false">
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${questionTitle}-更多信息-${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${LUI_ContextPath}/km/pindagate/vote.css">	
	</template:replace>
	<template:replace name="content">
		<script>
			var _topic;
			seajs.use(['lui/topic'], function(topic) {
				_topic=topic;
			});
			LUI.ready(function(){
				var isCheck = "${JsParam.isCheck}";
				if(isCheck!=null && "true" == isCheck)
					document.getElementsByName("showComplete")[0].checked = true;
				else
					document.getElementsByName("showComplete")[0].checked = false;
			});
			//待实现
			function showComplete(element){
				var source = LUI('listview').source,
					url = source.url;
				url = Com_SetUrlParameter(url,'isCheck',element.checked ? true : false);
				url = Com_SetUrlParameter(url,'isShowComplete',element.checked ? true : false);
				source.url=url;
				source.get();
			}
		</script>
		<div style="word-break:break-all;word-wrap:break-word;">
			<div class="pi_container" style="margin-top: 20px;margin-left: 10px;">
				<p class="txttitle">更多信息</p>
				<div class="pi_box">
					<div class="pi_content" id="Div_Answer_Detailed" style="padding-left: 5px;">
						<p style="border-bottom: 1px solid #EBF1F7;width: 98%;padding-bottom: 12px;padding-top: 20px;text-align: right;padding-right: 10px;">
							<input type="checkbox" name="showComplete" onclick="showComplete(this)">仅显示其他或原因
						</p>
					</div>
					
				</div>
				<table width="98%">
					<tr>
						<td>
							<div class="pi_txtTitle pi_txtTitle_no">题目：</div>
							<div class="pi_txtTitle pi_txtTitle_contnt">${questionTitle}</div>
							<c:if test="${fdQuestionDef['willAnswer'] == 'true'}">
								<span class="pi_txtRequire">*</span>
							</c:if>
							<span class="pi_txtStrong"> [${fdTypeName}]</span>
							<c:if test="${fdQuestionDef['willAnswer'] == 'true'}">
								<span class="pi_txtStrong">[${lfn:message('km-pindagate:kmPindagateQuestion.flag.willAnswer')}]</span>
							</c:if>
						</td>
					</tr>
					<c:if test="${fdQuestionDef['tip'] != ''}">
					<tr>
						<td>
							<div class="pi_subjectExplain" style="margin-bottom: 0px;">
							<div class="pi_subjectExplain_content">
							<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>
							${fdQuestionDef['tip']}
							</div>
							</div>
						</td>
					</tr>
					</c:if>
				</table>
			</div>
			<%--list页面--%>
			<list:listview id="listview">
				<ui:source type="AjaxJson">
					{url:'/km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=data&otherText=${JsParam.otherText}&type=${JsParam.type}&fdType=${fdType}&isShow=${isShow}&questionId=${JsParam.questionId}'}
				</ui:source>
				<list:rowTable isDefault="false" id="rowView" name="rowtable" >
					<list:row-template>
					{$
						<dl class="lui_listview_rowtable_summary_content_box">
							<dd>
								<span class="pi_txtTitle">回答：{%row.dContent%}</span>
							</dd>
							<dd class="lui_listview_rowtable_summary_content_box_foot_info">
								<span>调查者：{%row['dName']%}</span>
								<span>调查时间：{%row['fdCreateTime']%}</span>
								<span>所属部门：{%row['dept']%}</span>
							</dd>
						</dl>
					$}
					</list:row-template>
				</list:rowTable>
			</list:listview>
			<list:paging></list:paging>	 
		</div>
	</template:replace>
</template:include>