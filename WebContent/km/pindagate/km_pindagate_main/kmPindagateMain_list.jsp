<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="head">
		<link rel="stylesheet" type="text/css"
			href="${ LUI_ContextPath}/km/pindagate/vote.css">
	</template:replace>
	<template:replace name="content">  
		 <%-- 筛选器 --%>	
		 <list:criteria id="participateCriteria">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('km-pindagate:kmPindagateMain.docSubject')}" ></list:cri-ref>
			<list:cri-criterion title="${lfn:message('km-pindagate:kmPindagateMain.myPindagate') }" key="join">
				<list:box-select><list:item-select>
					<ui:source type="Static">
						[{text:'${ lfn:message('km-pindagate:kmPindagate.tree.join.mine') }', value:'mine'}]
					</ui:source>
				</list:item-select></list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${lfn:message('km-pindagate:kmPindagateMain.status') }" key="docStatus">
				<list:box-select><list:item-select>
					<ui:source type="Static">
						[{text:'${ lfn:message('km-pindagate:kmPindagate.tree.status.indagating') }', value:'31'},{text:'${ lfn:message('km-pindagate:kmPindagate.tree.status.complete') }', value:'32'}]
					</ui:source>
				</list:item-select></list:box-select>
			</list:cri-criterion>
			<list:cri-auto modelName="com.landray.kmss.km.pindagate.model.KmPindagateMain" property="docCreator;docStartTime;docFinishedTime"/>
		</list:criteria>
		
		<%-- 工具栏 --%>
		<div class="lui_list_operation">
			<!-- 全选 -->
			<div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
			</div>
			<!-- 分割线 -->
			<div class="lui_list_operation_line"></div>
			<!-- 排序 -->
			<div class="lui_list_operation_sort_btn">
				<div class="lui_list_operation_order_text">
					${ lfn:message('list.orderType') }：
				</div>
				<div class="lui_list_operation_sort_toolbar">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
						<list:sortgroup>
							<list:sort property="docStatus" text="${lfn:message('km-pindagate:kmPindagateMain.docStatus') }" group="sort.list"></list:sort>
							<list:sort property="docFinishedTime" text="${lfn:message('km-pindagate:kmPindagateMain.docFinishedTime') }" group="sort.list"></list:sort>
							<list:sort property="docCreateTime" text="${lfn:message('km-pindagate:kmPindagateMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="toolbar">
						<c:import url="/km/pindagate/km_pindagate_main/kmPindagateMain_changeDocRightButton.jsp" charEncoding="UTF-8">
							<c:param
								name="modelName"
								value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
							<c:param 
								name="attributeList" 
								value="indagateParticipant,indagateResultReader,indagateResultNotifier"/>
							<c:param 
								name="attributelabelList" 
								value="km-pindagate:kmPindagateMain.partic.people,km-pindagate:kmPindagateMain.result.reader,km-pindagate:kmPindagateMain.over.notify.person"/>
						</c:import>
						<kmss:authShow roles="ROLE_KMPINDAGATE_CREATE">
							<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="5" ></ui:button>
						</kmss:authShow>
						<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=deleteall&status=${param.status}&categoryId=${param.categoryId}">
						<ui:button text="${lfn:message('button.deleteall')}" order="6" onclick="delDoc()"></ui:button>
					</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		
		<%--数据记录--%>		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 <%--list页面--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/pindagate/km_pindagate_main/kmPindagateData.do?method=listChildren&categoryId=${JsParam.categoryId}&treeNode=participate&nodeType=${JsParam.nodeType}'}
			</ui:source>
			<%--列表视图--%>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable"  
				rowHref="/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=add&pindageteId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="docSubject;docStatus;kmPindagateTemplate.fdName;docFinishedTime"></list:col-auto>
			</list:colTable>
		</list:listview>
		<list:paging></list:paging>	 
		<script type="text/javascript">
			var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.pindagate.model.KmPindagateMain";
			seajs.use(['lui/jquery', 'lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {

				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//新建
		 		window.addDoc = function() {
						dialog.categoryForNewFile(
								'com.landray.kmss.km.pindagate.model.KmPindagateTemplate',
								'/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=add&fdTemplateId=!{id}',false,null,null,'${JsParam.categoryId}',null,null,true);
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
							window._load = dialog.loading();
							$.post('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=deleteall"/>',
									$.param({"List_Selected":values,"categoryId":"${JsParam.categoryId}"},true),callback,'json');
						}
					});
				};
			 	window.callback = function(data){
					if(window._load!=null)
						window._load.hide();
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
<%@ include file="/km/pindagate/qrCode.jsp"%>