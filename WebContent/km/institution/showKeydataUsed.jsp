<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
	
		<div class="lui_list_operation">
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar count="3">
						<%-- 新建--%>
						<kmss:authShow roles="ROLE_KMINSTITUTION_CREATE">
							<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>	
						</kmss:authShow>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 <%--list页面--%>
		<list:listview id="listview" >
			<ui:source type="AjaxJson" >
				{url:'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=showKeydataUsed&keydataId=${JsParam.keydataId}'}
			</ui:source>
			<%--列表视图--%>
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-html title="${ lfn:message('km-institution:kmInstitution.docSubject') }" style="text-align:left">
				{$ <span class="com_subject" >{%row['docSubject']%}</span> $}
				</list:col-html>
				<list:col-auto props="fdNumber;docStatus;docDept.fdName;docAuthor;docPublishTime" ></list:col-auto>
			</list:colTable>
			<%--摘要视图--%>
			<list:rowTable isDefault="false" id="rowView"
				rowHref="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=!{fdId}" name="rowtable" >
				<list:row-template>
				{$
				
				 <div class="clearfloat lui_listview_rowtable_summary_content_box">
					<dl>
						<dt>
							<input type="checkbox" data-lui-mark="table.content.checkbox" value="{%row.fdId%}" name="List_Selected"/>
							<span class="lui_listview_rowtable_summary_content_serial">{%row.index%}</span>
						</dt>	
					</dl>
					<dl>
						<dt>
							<a class="textEllipsis com_subject" title="{%row.docSubject%}" onclick="Com_OpenNewWindow(this)" data-href="${LUI_ContextPath}/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId={%row.fdId%}" target="_blank" data-lui-mark-id="{%row.rowId%}">{%row.docSubject%}</a>
						</dt>
						<dd class="lui_listview_rowtable_summary_content_box_foot_info">
							<span>${lfn:message('km-institution:kmInstitution.fdNumber') }：{%row['fdNumber']%}</span>
							<span>${lfn:message('sys-doc:sysDocBaseInfo.docCreator')}：{%row['docAuthor']%}</span>
							<span>${lfn:message('sys-doc:sysDocBaseInfo.docDept') }：{%row['docDept.fdName']%}</span>
							<span>{%row['docPublishTime_row']%}</span>
							<span>{%row['fdTagNames']%}</span>
						</dd>
					</dl>
				</div>	
				$}
				</list:row-template>
			</list:rowTable>
		</list:listview> 
	 	<list:paging></list:paging>	 
	 	<script type="text/javascript">
	 		var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.institution.model.KmInstitutionKnowledge";
			seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {

				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});

				//新建
				window.addDoc = function() {
						dialog.simpleCategoryForNewFile(
								'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
								'/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=add&fdTemplateId=!{id}&keydataId=${JsParam.keydataId}&keydataType=${JsParam.keydataType}',false,null,null,'${JsParam.categoryId}');
				};
				//删除
				window.delDoc = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall"/>&categoryId=${JsParam.categoryId}',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null)
						window.del_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message key="return.optSuccess" />');
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				};
				//失效
				window.abolishDoc = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
					});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.iframe("/km/institution/km_institution_ui/kmInstitutionKnowledge_setTime.jsp","${lfn:message('km-institution:kmInstitutionKnowledge.setTimeDialog')}",function(abolishTime){
						if(abolishTime!=null){
							window.abolish_load = dialog.loading();
							$.post('<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=abolishall"/>',
								$.param({"List_Selected":values,"fdAbolishTime":abolishTime},true),abolishCallback,'json');
							}
					},{width:550,height:360});
				};
				//失效执行后回调函数
				window.abolishCallback = function(data){
					if(window.abolish_load!=null)
						window.abolish_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message key="return.optSuccess" />');
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				};


				LUI.ready(function(){
					//按钮对象存在则先隐藏，避免加载时没权限，按钮对象不存在
					if(LUI('abolishAll')){
					 LUI('abolishAll').setVisible(false);
					}
				});
				
				//搜索条件改变时,失效按钮是否显示
				topic.subscribe('criteria.changed',function(evt){
					if(LUI('abolishAll')){
						 LUI('abolishAll').setVisible(false);
					}
					if(evt['criterions'].length>0){
						 for(var i=0;i<evt['criterions'].length;i++){
							 //发布状态下才显示按钮
							 if(evt['criterions'][i].key=="docStatus"&&evt['criterions'][i].value.length==1){
									 if(evt['criterions'][i].value[0]=="30"){
									 LUI('abolishAll').setVisible(true);
								}
							}
						}
					}
				});

				
				
			});
		</script>	 
