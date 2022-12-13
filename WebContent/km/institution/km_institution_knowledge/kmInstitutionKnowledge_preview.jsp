<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
<script type="text/javascript">
var fdId = "";
var hideDiv = null;
function showCreateDiv(id,obj) {
	fdId = id;
	var newDiv = document.getElementById("newDiv");
	var p = LUI.$(obj).position();
	LUI.$(newDiv).css('display','block');
	LUI.$(newDiv).css('left',p.left+LUI.$(obj).width());
	LUI.$(newDiv).css('top', p.top);
	LUI.$(newDiv).css('z-index', 1000);
	if(hideDiv){
		clearTimeout(hideDiv);
	}
}
function quickCreate(){
	seajs.use(['lui/dialog'], function(dialog) {
		dialog.simpleCategoryForNewFile(
				'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
				'/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=add&fdTemplateId=!{id}',false,null,null,fdId);
	});
}

function hideCreateDiv(){
	hideDiv =  setTimeout(function(){
		  document.getElementById("newDiv").style.display="none";
	 },2000);
}

function openUrl(url){

	parent.location = "${LUI_ContextPath}"+url;
	
}

window.pageResize=function(){
	if(parent.document.all("mainIframe")){
		parent.document.all("mainIframe").style.height=(document.body.offsetHeight+30)+'px';
	}
};

</script>
<div id="newDiv" style="display:none;position:absolute;">
<a href="javascript:;" onclick="quickCreate();"><img  src="../resource/images/tips.png">
</a>
</div>
	    <div class="lui_flow_overview">
			<div class="lui_flow_viewContent">
				<h1><bean:message bundle="km-institution" key="kmInstitutionKnowledge.preview" /></h1>
			    <ui:dataview>
					<ui:source type="AjaxJson">
					    {"url":"/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=preview"}
					</ui:source>
					<ui:render type="Template">
						<c:import url="/km/institution/resource/tmpl/overview.tmpl"></c:import>
					</ui:render>
					<ui:event event="load">
						window.pageResize();
					</ui:event>
				</ui:dataview>
			</div>
		</div>
	</template:replace> 
</template:include>
