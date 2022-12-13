<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<link rel="stylesheet" 
	  type="text/css" 
	  href="${LUI_ContextPath}/km/pindagate/vote.css">
<template:include ref="default.dialog">
	<template:replace name="content" >
		<div id="showtip" style="display:none;position:absolute; top:100px; right:80px;z-index: 999"></div>
		<br/>
		<script type="text/javascript">
			seajs.use(['lui/jquery','lui/dialog'], function($,dialog){
				$(document).ready(function () {
					var timer = setInterval(function() {
						var dialogR = $dialog;
						if (!dialogR) {
							return;
						} else {
							clearInterval(timer);
						}
						var titleJson = $dialog.content.params.titleJson;
						titleJson=JSON.parse(titleJson);
						$("#fdName").html(titleJson["fdName"]);
						$("#fdTypeText").html("["+titleJson["fdTypeText"]+"]");
					}, 100);
				}); 
			});
	</script>
		<div class="lui_pindagate_related_wrap">
			<input type="hidden" name="subjectRelationDef">
			<input type="hidden" name="subjectRelationIndex">
			<input type="hidden" name="subjectRelationJt">
			<input type="hidden" name="subjectItems">
			<input type="hidden" name="fdTypeRelation">
			<input type="hidden" name="subjectRelation">
			<input type="hidden" name="fdId">
			<!-- 当前题目 -->
     		<div class="related_head">
     			<div class="related_head_l">
		          <em>${lfn:message('km-pindagate:kmPindagate.relation.title') }</em><span id="fdName"></span><i class="pindagate_type" id="fdTypeText"></i>
			    </div>
			    <div class="related_head_r">
			      <ui:button text="${lfn:message('km-pindagate:kmPindagate.relation.addItem') }" onclick="addRelationItem();" ></ui:button>
		        </div>
			</div>
			<!-- 题目关联 -->
     		<div  class="related_content">
     			<table id="multiselectList" class="related_table">
				</table>
				<div id="flagTd" style="display: none;" class="related_desc">
					<p>${lfn:message('km-pindagate:kmPindagate.relation.relationship') }</p>
					<ul>
						<li>
							<label class="related_radio"> 
								<input type="radio" name="flagRelation" value="0" checked>
								${lfn:message('km-pindagate:kmPindagate.relation.andRelationship') }
								<em class="related_tip">${lfn:message('km-pindagate:kmPindagate.relation.allRelationship') }</em>
							</label>
						</li>
						<li>
							<label class="related_radio"> 
								<input type="radio" name="flagRelation" value="1">
								${lfn:message('km-pindagate:kmPindagate.relation.orRelationship') }
								<em class="related_tip">${lfn:message('km-pindagate:kmPindagate.relation.andOneRelationship') }</em>
							</label>
						</li>
					</ul>
				</div>
			</div>
			<!-- 底部操作按钮 -->
	       <div class="related_content_footer">
       		<ui:button text="${lfn:message('button.save') }" onclick="save();" ></ui:button>&nbsp;
			<ui:button text="${lfn:message('km-pindagate:kmPindagate.relation.allEmpty') }" onclick="allEmpty();" styleClass="lui_toolbar_btn_gray" ></ui:button>&nbsp;
			<ui:button text="${lfn:message('button.close') }" onclick="_close();"  styleClass="lui_toolbar_btn_gray"></ui:button>
	       </div>
		</div>
		<DIV id="dHTMLToolTip"  style="Z-INDEX: 1000; LEFT: 0px; VISIBILITY: hidden; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px"></DIV>
		<%--防止IE下出现水平滚动条--%>
		<style type="text/css">body {overflow-x:hidden;}</style>
		<%--JS --%>
	</template:replace>
</template:include>
<%@include file="/km/pindagate/question_type_ui/relation/subjectRelation_edit_script.jsp"%>