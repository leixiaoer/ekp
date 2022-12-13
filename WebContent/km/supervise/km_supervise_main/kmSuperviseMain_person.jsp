<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="person.home">
	<template:replace name="title">${ lfn:message('km-supervise:lbpm.my') }</template:replace>
	<template:replace name="content">
		<c:set var="navTitle" value="${lfn:message('km-supervise:lbpm.my') }"></c:set>
		<c:if test="${not empty param.navTitle }">
			<c:set var="navTitle" value="${param.navTitle}"></c:set>
		</c:if>
		<ui:tabpanel layout="sys.ui.tabpanel.list">
			<ui:content title="${navTitle }">
				<list:criteria id="criteria1" expand="false">
				    <list:tab-criterion title="" key="mydoc" multi="false">
						<list:box-select>
							<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas" cfg-defaultValue="duty" cfg-required="true">
								<ui:source type="Static">
								   		 [{text:'${ lfn:message('km-supervise:py.WoFuZeDe') }',value:'duty'},
								   		 {text:'${ lfn:message('km-supervise:py.WoDuBanDe') }', value:'duban'},
			                             {text:'${ lfn:message('km-supervise:py.SuoYouDuBan') }',value:'manage'},
			                             {text:'${ lfn:message('km-supervise:py.ChaoSongWoDe') }',value:'copy'},
			                             {text:'${ lfn:message('km-supervise:py.WoGuanZhuDe') }', value:'concern'}]
								</ui:source>
							</list:item-select>
						</list:box-select>
					</list:tab-criterion>
					<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('km-supervise:kmSupervise.items') }"></list:cri-ref>
					<list:cri-criterion title="${ lfn:message('km-supervise:kmSuperviseMain.fdStatus') }" key="docStatus" > 
						<list:box-select>
							<list:item-select cfg-enable="true">
								<ui:source type="Static">
									[{text:'${ lfn:message('km-supervise:enums.doc_status.20')}', value:'20'},
									{text:'${ lfn:message('km-supervise:enums.doc_status.30')}',value:'30'},
									{text:'${ lfn:message('km-supervise:enums.doc_status.40')}',value:'40'},
									{text:'${ lfn:message('km-supervise:enums.doc_status.50')}',value:'50'}]
								</ui:source>
							</list:item-select>
						</list:box-select>
					</list:cri-criterion>
				</list:criteria>
				<!-- 操作 -->
		           <div class="lui_list_operation">
		
		               <div style='color: #979797;float: left;padding-top:1px;'>
		                   ${ lfn:message('list.orderType') }：
		               </div>
		               <div style="float:left">
		                   <div style="display: inline-block;vertical-align: middle;">
		                       <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
		                       		<list:sortgroup>
			                            <list:sort property="docCreateTime" text="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime')}" group="sort.list" value="down"/>
			                            <list:sort property="fdFinishTime" text="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}" group="sort.list" />
			                            <list:sort property="fdStatus" text="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}" group="sort.list" />
		                            </list:sortgroup>
		                       </ui:toolbar>
		                   </div>
		               </div>
		               <div style="float:left;">
		                   <list:paging layout="sys.ui.paging.top" />
		               </div>
		               <div style="float:right">
		                   <div style="display: inline-block;vertical-align: middle;">
		                       <ui:toolbar count="3">
		                            <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
		                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
		                            </kmss:authShow>
		                            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall">
		                                <c:set var="canDelete" value="true" />
		                            </kmss:auth>
		                            <!---->
		                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
		                       </ui:toolbar>
		                   </div>
		               </div>
		           </div>
		           <ui:fixed elem=".lui_list_operation" />
		           	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
		           <!-- 列表 -->
		           <list:listview id="listview">
		               <ui:source type="AjaxJson">
		                   {url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data'}
		               </ui:source>
		               <!-- 列表视图 -->
		               <list:colTable isDefault="false" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
		                   <list:col-checkbox />
		                   <list:col-serial/>
		                   <list:col-auto props="docSubject;docCreator.name;docCreateTime;fdFinishTime;docStatus;nodeName;handlerName" /></list:colTable>
		           </list:listview>
		           <!-- 翻页 -->
		           <list:paging />
			</ui:content>
		</ui:tabpanel>
		
	<script>	
	seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($,dialog,topic) {

			// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				topic.publish('list.refresh');
			});
		
			//新建
	 		window.addDoc = function() {
					dialog.categoryForNewFile(
							'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
							'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&i.docTemplate=!{id}',false,null,null,'${JsParam.categoryId}',null,null,true,null,{"fdType":"10"});
		 	};
		 	//删除
	 		window.deleteAll = function(){
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
						$.post('<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall"/>',
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

	});
	</script>
	</template:replace>
</template:include>