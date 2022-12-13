<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no" showQrcode="false">
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="-${ lfn:message('km-pindagate:kmPindagateQuestion.moreinfo') }-${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
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
				var fdType = "${fdType}";
				if (fdType!="formfilled") {
					if(isCheck!=null && "true" == isCheck)
						document.getElementsByName("showComplete")[0].checked = true;
					else
						document.getElementsByName("showComplete")[0].checked = false;
				}
				seajs.use(['lui/jquery',], function($) {
					$(document).attr("title", $(".questionTitle").text() + $(document).attr("title"));
				});
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
				<p class="txttitle">${ lfn:message('km-pindagate:kmPindagateQuestion.moreinfo') }</p>
				<div class="pi_box">
					<div class="pi_content" id="Div_Answer_Detailed" style="padding-left: 5px;">
						<p style="border-bottom: 1px solid #EBF1F7;width: 98%;padding-bottom: 12px;padding-top: 20px;text-align: right;padding-right: 10px;">
							<c:if test="${param.type eq 'selectReason' || param.type eq 'other'}">
								<input type="checkbox" name="showComplete" onclick="showComplete(this)">${ lfn:message('km-pindagate:kmPindagateQuestion.otherAndreason') }
							</c:if>
						</p>
					</div>
					
				</div>
				<table width="98%">
					<tr>
						<td>
							<div class="pi_txtTitle pi_txtTitle_msg">${ lfn:message('km-pindagate:kmPindagateQuestion.question') }: </div>
							<div class="pi_txtTitle pi_txtTitle_content"><span class="questionTitle">${questionTitle}</span>
							<c:if test="${fdQuestionDef['willAnswer'] == 'true'}">
								<span class="pi_txtRequire">*</span>
							</c:if>
							</div>
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
							<bean:message bundle="km-pindagate" key="kmPindagateQuestion.preview.titleDescription"/>${fdQuestionDef['tip']}
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
								<div class="pi_txtTitle">${lfn:message('km-pindagate:kmPindagateQuestion.answer')}: {%row.dContent%}</div>
							</dd>
							<dd class="lui_listview_rowtable_summary_content_box_foot_info">
								<span>${lfn:message('km-pindagate:kmPindagateQuestion.investigator')}: {%row['dName']%}</span>
								<span>${lfn:message('km-pindagate:kmPindagateQuestion.investigation.time')}: {%row['fdCreateTime']%}</span>
								<span>${lfn:message('km-pindagate:kmPindagateResponse.resultsDetail.fdDeptName')}: {%row['dept']%}</span>
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