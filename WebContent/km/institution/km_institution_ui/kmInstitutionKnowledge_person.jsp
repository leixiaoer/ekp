<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="person.home">
	<%-- 标签页标题 --%>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-institution:module.km.institution') }"></c:out>
	</template:replace>
	<%-- 右侧页面 --%>
	<template:replace name="content">  
	<list:criteria id="criteria1" expand="true">
		    <list:cri-criterion title="${lfn:message('km-institution:kmInstitution.tree.title.my')}" key="myInstitution" multi="false">
				<list:box-select>
					<list:item-select cfg-defaultValue="create" cfg-required="true">
						<ui:source type="Static">
						    [{text:'${lfn:message('km-institution:kmInstitution.tree.title.Create.my')}', value:'create'},
							 {text:'${lfn:message('km-institution:kmInstitution.tree.title.Approval.my')}', value:'approval'},
							 {text:'${lfn:message('km-institution:kmInstitution.tree.title.Approved.my')}', value:'approved'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${lfn:message('km-institution:kmInstitution.status')}" key="docStatus" > 
				<list:box-select>
					<list:item-select id="docStatus1" cfg-enable="true">
						<ui:source type="Static">
							  [{text:'${ lfn:message('status.draft') }',value:'10'},
								{text:'${ lfn:message('status.examine') }', value: '20'},
								{text:'${ lfn:message('status.refuse') }',value:'11'},
								{text:'${ lfn:message('status.discard') }',value:'00'},
								{text:'${ lfn:message('status.publish') }',value:'30'},
								{text:'${ lfn:message('km-institution:kmInstitution.status.abolishAndFiling') }', value:'50'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${lfn:message('km-institution:kmInstitution.status')}" key="docStatus" > 
				<list:box-select>
					<list:item-select id="docStatus2" cfg-enable="false">
								<ui:source type="Static">
									[{text:'${ lfn:message('status.examine') }', value: '20'},
									{text:'${ lfn:message('status.refuse') }',value:'11'},
									{text:'${ lfn:message('status.discard') }',value:'00'},
									{text:'${ lfn:message('status.publish') }',value:'30'},
									{text:'${ lfn:message('km-institution:kmInstitution.status.abolishAndFiling') }', value:'50'}]
								</ui:source>
				   </list:item-select>	
				</list:box-select>
			</list:cri-criterion>
			
		</list:criteria>
		<%-- 操作栏 --%>
		<div class="lui_list_operation">
			<table width="100%">
				<tr>
					<td style="width: 65px;">${ lfn:message('list.orderType') }：</td>
					<td>
						<%-- 提供按发布时间排序 --%>
						<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left"  count="4">
							<list:sortgroup>
								<list:sort property="docPublishTime" text="${lfn:message('km-institution:kmInstitution.docPublishTime') }" group="sort.list" value="down"></list:sort>
								<list:sort property="docCreateTime" text="${lfn:message('km-institution:kmInstitutionKnowledge.docCreateTime') }" group="sort.list"></list:sort>
								<list:sort property="fdNumber" text="${lfn:message('km-institution:kmInstitution.fdNumber') }" group="sort.list"></list:sort>
							</list:sortgroup>
						</ui:toolbar>
					</td>
					<td align="right">
						<ui:toolbar id="toolbar" count="3">
							<%-- 视图选择 --%>	
							<ui:togglegroup order="0">
								<ui:toggle icon="lui_icon_s_zaiyao" title="${ lfn:message('list.rowTable') }" 
									group="tg_1" text="${ lfn:message('list.rowTable') }" value="rowtable" selected="true"
									onclick="LUI('listview').switchType(this.value);">
								</ui:toggle>
								<ui:toggle icon="lui_icon_s_liebiao" title="${ lfn:message('list.columnTable') }" 
									value="columntable"	 group="tg_1" text="${ lfn:message('list.columnTable') }" 
									onclick="LUI('listview').switchType(this.value);">
								</ui:toggle>
							</ui:togglegroup>
							<%-- 收藏 --%>
							<c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
								<c:param name="fdTitleProName" value="docSubject" />
								<c:param name="fdModelName"	value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							</c:import>
							<%-- 新建--%>
							<kmss:authShow roles="ROLE_KMINSTITUTION_CREATE">
								<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>	
							</kmss:authShow>
							<%--删除--%>		
							<kmss:auth
								requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall&status=${param.status}&categoryId=${param.categoryId}"
								requestMethod="GET">								
								<ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="3"></ui:button>
							</kmss:auth>
							<%--失效--%>	
							<kmss:auth
								requestURL="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=abolishall&categoryId=${param.categoryId}"
								requestMethod="GET">
								<ui:button id="abolishAll" text="${lfn:message('km-institution:kmInstitution.button.abolishSingle')}" onclick="abolishDoc()" order="3"></ui:button>
							</kmss:auth>
							<%-- 修改权限 --%>
							<c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							</c:import>							
							<%-- 分类转移 --%>
							<c:import url="/sys/simplecategory/import/doc_cate_change_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
								<c:param name="docFkName" value="kmInstitutionTemplate" />
								<c:param name="cateModelName" value="com.landray.kmss.km.institution.model.KmInstitutionTemplate" />
							</c:import>
						</ui:toolbar>
					</td>
				</tr>
			</table>
		</div>	
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 <%--list页面--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&categoryId=${JsParam.categoryId}&type=person'}
			</ui:source>
			<%--列表视图--%>
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<%-- <list:col-html title="${ lfn:message('km-institution:kmInstitution.docSubject') }" style="text-align:left">
				{$ <span class="com_subject" >{%row['docSubject']%}</span> $}
				</list:col-html> --%>
				<list:col-auto props="fdNumber;docStatus;docDept.fdName;docCreator;docPublishTime" ></list:col-auto>
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
							<a class="textEllipsis com_subject" onclick="Com_OpenNewWindow(this)" data-href="${LUI_ContextPath}/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId={%row.fdId%}" target="_blank" data-lui-mark-id="{%row.rowId%}">{%row.row_docSubject%}</a>
						</dt>
						<dd class="lui_listview_rowtable_summary_content_box_foot_info">
							<span>${lfn:message('km-institution:kmInstitution.fdNumber') }：{%row['fdNumber']%}</span>
							<span>${lfn:message('sys-doc:sysDocBaseInfo.docCreator')}：{%row['docCreator']%}</span>
							<span>${lfn:message('sys-doc:sysDocBaseInfo.docDept') }：{%row['docDept.fdName']%}</span>
							<span>${lfn:message('sys-doc:sysDocBaseInfo.docPublishTime') }：{%row['docPublishTime']%}</span>
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
			seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {

				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//新建
				window.addDoc = function() {
						dialog.simpleCategoryForNewFile(
								'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
								'/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=add&fdTemplateId=!{id}',false,null,null,'${JsParam.categoryId}');
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
							$.post('<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall"/>',
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
					dialog.iframe("/km/institution/km_institution_ui/kmInstitutionKnowledge_setTime.jsp","选择失效时间",function(abolishTime){
						if(abolishTime!=null){
							window.abolish_load = dialog.loading();
							$.post('<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=abolishall"/>',
								$.param({"List_Selected":values,"fdAbolishTime":abolishTime},true),abolishCallback,'json');
							}
					},{width:550,height:350});
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

				//搜索条件改变
			topic.subscribe('criteria.changed',function(evt){
				//搜索条件改变时,隐藏失效按钮
				 if(LUI('abolishAll')){
					 LUI('abolishAll').setVisible(false);
				}
				if(evt['criterions'].length>0){
					 for(var i=0;i<evt['criterions'].length;i++){
						 //状态查询器变换
						 if(evt['criterions'][i].key=="myInstitution"&&evt['criterions'][i].value.length==1){
							 if(evt['criterions'][i].value[0]=="create"){
									LUI('docStatus1').setEnable(true);
  									LUI('docStatus2').setEnable(false);
						      }
							 else if(evt['criterions'][i].value[0]=="approved"){
									LUI('docStatus1').setEnable(false);
  									LUI('docStatus2').setEnable(true);
						      }
							 else{
									LUI('docStatus1').setEnable(false);
  									LUI('docStatus2').setEnable(false);
						      }
				    	 }
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
	</template:replace>
</template:include>
