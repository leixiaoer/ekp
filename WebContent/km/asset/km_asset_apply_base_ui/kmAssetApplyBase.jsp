<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple"  spa="true">
	<template:replace name="body">
	<script type="text/javascript">
			seajs.use(['theme!list']);	
	</script>
		<list:criteria id="applycriteria">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<list:cri-ref ref="criterion.sys.category" key="fdApplyTemplate"
				multi="false"
				title="${ lfn:message('km-asset:kmAssetApplyBase.nav.fdApplyTemplate')}"
				expand="false">
				<list:varParams
					modelName="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" />
			</list:cri-ref>
			<list:cri-criterion
				title="${ lfn:message('km-asset:kmAssetApply.my')}" key="mydoc"
				multi="false">
				<list:box-select>
					<list:item-select cfg-if="param['mydoc']!='create' && param['mydoc']!='approval' && param['mydoc']!='approved'">
						<ui:source type="Static">
							[{text:'${ lfn:message('km-asset:kmAssetApply.create.my') }', value:'create'},{text:'${ lfn:message('km-asset:kmAssetApply.approval.my') }',value:'approval'}, {text:'${ lfn:message('km-asset:kmAssetApply.approved.my') }', value: 'approved'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:tab-criterion title="" key="docStatus"> 
				<list:box-select>
					<list:item-select id="docStatus" cfg-enable="false" type="lui/criteria/select_panel!TabCriterionSelectDatas" cfg-if=" (param['mydoc']=='create'||param['mydoc']=='approved' ||param['mydoc']=='approval') && param['status']!='draft'">
						<ui:source type="Static">
							[
							{text:'${ lfn:message('status.draft')}',value:'10'},
							{text:'${ lfn:message('status.examine')}',value:'20'},
							{text:'${ lfn:message('status.refuse')}',value:'11'},
							{text:'${ lfn:message('status.publish')}',value:'30'}
							]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:tab-criterion>
			<list:cri-auto
				modelName="com.landray.kmss.km.asset.model.KmAssetApplyBase"
				property="fdNo;fdCreator;fdDept;fdCreateDate" />
		</list:criteria>

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
						<list:sort property="fdCreateDate"
							text="${ lfn:message('km-asset:kmAssetApplyBase.fdCreateDate')}"
							group="sort.list" value="down"></list:sort>
						<list:sort property="docPublishTime"
							text="${ lfn:message('km-asset:kmAssetApplyBase.docPublishTime')}"
							group="sort.list"></list:sort>
					</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">
				<list:paging layout="sys.ui.paging.top">
				</list:paging>
			</div>
			<div style="float: right">
				<div style="display: inline-block; vertical-align: middle;">
					<ui:toolbar id="Btntoolbar">
					<c:if test="${JsParam.addShow == 'true'}">
						<kmss:authShow roles="ROLE_KMASSETAPPLY_CREATE">
							<ui:button text="${lfn:message('button.add')}" onclick="addDoc()"
								order="2"></ui:button>
						</kmss:authShow>
					</c:if>
						<kmss:authShow roles="ROLE_KMASSET_TRANSPORT_EXPORT">
						<ui:button text="${lfn:message('button.export')}" id="export"
							onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.asset.model.KmAssetApplyBase')"
							order="2"></ui:button>
						</kmss:authShow>	
						<kmss:auth
							requestURL="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall&categoryId=${param.categoryId}&nodeType=${param.nodeType}&docStatus=${param.docStatus}&mydoc=${param.mydoc }">
							<ui:button id="del" text="${lfn:message('button.deleteall')}"
								order="3" onclick="delDoc()"></ui:button>
						</kmss:auth>
						<%-- 收藏 --%>
						<c:import url="/sys/bookmark/import/bookmark_bar_all.jsp"
							charEncoding="UTF-8">
							<c:param name="fdTitleProName" value="docSubject" />
							<c:param name="fdModelName"
								value="com.landray.kmss.km.asset.model.KmAssetApplyBase" />
						</c:import>
						<%-- 修改权限 --%>
						<c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
							<c:param name="modelName" value="com.landray.kmss.km.asset.model.KmAssetApplyBase" />
							<c:param name="authReaderNoteFlag" value="2" />
							<c:param name="categoryId" value="${param.categoryId}" />
							<c:param name="nodeType" value="${param.nodeType}" />
						</c:import>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<input type="hidden" name="fdTemplateId" value="" />
		<input type="hidden" name="fdTemplateName" value="" />
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview>
			<ui:source type="AjaxJson">
					{url:'/km/asset/km_asset_index/kmAssetIndex.do?method=list&fdTempKey=${JsParam.fdTempKey}'}
			</ui:source>
			<list:colTable
				url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.asset.model.KmAssetApplyStock"
				isDefault="true" layout="sys.ui.listview.columntable"
				rowHref="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=view4Base&fdId=!{fdId}&fdSubclassModelname=!{fdSubclassModelname}">
			<%-- <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.asset.model.KmAssetApplyStock" isDefault="true" layout="sys.ui.listview.columntable" rowHref="/km/asset/km_asset_apply_stock/KmAssetApplyStock.do?method=view&fdId=!{fdId}"> --%>
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<list:paging></list:paging>
		<%
			request.setAttribute("isAdmin", UserUtil.getKMSSUser().isAdmin());
		%>
		<script type="text/javascript">
			var SYS_SEARCH_MODEL_NAME = "com.landray.kmss.km.asset.model.KmAssetApplyBase";
			//由于分类放在筛选器中，该变量用来记录当前分类id
			var CATEID = "";
			var NODETYPE = "";

			seajs
					.use(
							[ 'lui/jquery', 'lui/util/str', 'lui/dialog',
									'lui/topic', 'lui/toolbar' ],
							function($, strutil, dialog, topic, toolbar) {

								// 监听新建更新等成功后刷新
								topic.subscribe('successReloadPage',
										function() {
											topic.publish('list.refresh');
										});

								//新建
								window.addDoc = function() {
									var tempId = "";
									dialog
											.category(
													'com.landray.kmss.km.asset.model.KmAssetApplyTemplate',
													'fdTemplateId',
													'fdTemplateName',
													false,
													function(rtn) {
														if (rtn != false
																&& rtn != null) {
															tempId = document
																	.getElementsByName("fdTemplateId")[0].value;
															addByApplyTemplate(tempId);
														}
													});
								};

								window.addByApplyTemplate = function(tempId) {
									if (tempId != null && tempId != '') {
										var data = new KMSSData();
										var url = Com_Parameter.ContextPath
												+ "km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="
												+ tempId;
										var results;
										data.SendToUrl(url, function(data) {
											results = data.responseText;

										}, false);
										document
												.getElementsByName("fdTemplateId")[0].value = "";
										document
												.getElementsByName("fdTemplateName")[0].value = "";
										window.open(Com_Parameter.ContextPath
												+ results, '_blank');
									}
								};
								window.clearAllValue = function() {

									this.location = "${LUI_ContextPath}/km/asset";
								};
								//删除
								window.delDoc = function(draft) {
									var values = [];
									$("input[name='List_Selected']:checked")
											.each(function() {
												values.push($(this).val());
											});
									if (values.length == 0) {
										dialog
												.alert('<bean:message key="page.noSelect"/>');
										return;
									}
									var url = '<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall"/>&categoryId=${param.categoryId}&nodeType=${param.nodeType}';
									
									if (draft == '0') {
										url = '<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall&status=10"/>';
									}
									dialog
											.confirm(
													'<bean:message key="page.comfirmDelete"/>',
													function(value) {
														if (value == true) {
															window.del_load = dialog
																	.loading();

															$
																	.ajax({
																		url : url,

																		type : 'POST',

																		data : $
																				.param(
																						{
																							"List_Selected" : values
																						},
																						true),

																		dataType : 'json',

																		error : function(
																				data) {
																			if (window.del_load != null) {
																				window.del_load
																						.hide();
																			}
																			dialog
																					.result(data.responseJSON);
																		},

																		success : delCallback

																	});
														}
													});
								};
								window.delCallback = function(data) {
									if (window.del_load != null) {
										window.del_load.hide();
										topic.publish("list.refresh");
									}
									dialog.result(data);
								};
		<%request.setAttribute("admin", UserUtil.getKMSSUser().isAdmin());%>
								//根据筛选器分类异步校验权限
		var AuthCache = {};
		window.showButtons = function(cateId,nodeType){
			 if(AuthCache[cateId]){
	             if(AuthCache[cateId].delBtn){
	            	 if(!LUI('del')){ 
		            	 var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.deleteall")}',click:'delDoc()'});
    					 LUI('Btntoolbar').addButton(delBtn);
	            	 }
	             }else{
	            	 if(LUI('del')){ 
	            	   LUI('Btntoolbar').removeButton(LUI('del'));
	            	   LUI('del').destroy();
	            	 }
		         }
	             //批量修改权限按钮
	             if(AuthCache[cateId].changeRightBatchBtn){
	            	 if(!LUI('docChangeRightBatch')){ 
		                 var changeRightBatchBtn = toolbar.buildButton({id:'docChangeRightBatch',order:'4',text:'${lfn:message("sys-right:right.button.changeRightBatch")}',click:'changeRightCheckSelect("'+cateId+'","'+nodeType+'")'});
    					 LUI('Btntoolbar').addButton(changeRightBatchBtn);
	            	 }
	             }else{
	            	 if(LUI('docChangeRightBatch')){ 
	            	   LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
	            	   LUI('docChangeRightBatch').destroy();
	            	 }
		         }
             }
             if(AuthCache[cateId]==null){
	                 var checkDelUrl = "/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall&categoryId="+cateId+"&nodeType="+nodeType;
					 var changeRightBatchUrl = "/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyBase&categoryId="+cateId+"&nodeType="+nodeType;
	                 var data = new Array();
	                 data.push(["delBtn",checkDelUrl]);
	                 data.push(["changeRightBatchBtn",changeRightBatchUrl]);
	                 $.ajax({
	       			  url: "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
	       			  dataType:"json",
	       			  type:"post",
	       			  data:{"data":LUI.stringify(data)},
	       			  async:false,
	       			  success: function(rtn){
		       			var btnInfo = {};
		       			if(rtn.length > 0){
	       				  for(var i=0;i<rtn.length;i++){
	                 		if(rtn[i]['delBtn'] == 'true'){
	                 		btnInfo.delBtn = true;
	                 		 if(!LUI('del')){ 
		                 		 var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.deleteall")}',click:'delDoc()'});
		    					 LUI('Btntoolbar').addButton(delBtn);
	                 		 }
	                       }
	                 		if(rtn[i]['changeRightBatchBtn'] == 'true'){
		                 		btnInfo.changeRightBatchBtn = true;
		                 		 if(!LUI('docChangeRightBatch')){ 
					                 var changeRightBatchBtn = toolbar.buildButton({id:'docChangeRightBatch',order:'4',text:'${lfn:message("sys-right:right.button.changeRightBatch")}',click:'changeRightCheckSelect("'+cateId+'","'+nodeType+'")'});
			    					 LUI('Btntoolbar').addButton(changeRightBatchBtn);
		                 		 }
		                     } 
	       				  }
		       			}else{
                    	   btnInfo.delBtn = false;
                    	  if(LUI('del')){ 
                    	    LUI('Btntoolbar').removeButton(LUI('del'));
                    	    LUI('del').destroy();
                    	  }
                    	  btnInfo.changeRightBatchBtn = false;
                    	  if(LUI('docChangeRightBatch')){ 
                    	    LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
                    	    LUI('docChangeRightBatch').destroy();
                    	  }
		                }
	                 	 AuthCache[cateId] = btnInfo;
	  		          }
                  });
               }
        };
        window.removeDelBtn = function(){
			if(LUI('del')){
        	    LUI('Btntoolbar').removeButton(LUI('del'));
        	    LUI('del').destroy();
        	   }
		};
		window.removeChangeRightBatchBtn = function(){
			if(LUI('docChangeRightBatch')){
         	    LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
         	    LUI('docChangeRightBatch').destroy();
         	   }
	    };
		
		<%
		   request.setAttribute("admin",UserUtil.getKMSSUser().isAdmin());
		%>
		
		//根据筛选器分类异步校验权限
		topic.subscribe('criteria.spa.changed',function(evt){
			if("${admin}"=="false"){
				 removeDelBtn();
				 removeChangeRightBatchBtn();
			}
			//removeShowNumberBtn();
			var hasTemp = false;    //筛选器中是否包含模板筛选项
			var docStatus = "";    //记录筛选器中状态筛选项的值
			//筛选器变化时清空分类和节点类型的值
			cateId = "";  
			nodeType = "";
			for(var i=0;i<evt['criterions'].length;i++){
			  //获取分类id和类型
         	  if(evt['criterions'][i].key=="fdApplyTemplate"){
             	 cateId= evt['criterions'][i].value[0];
                 nodeType = evt['criterions'][i].nodeType;
                 hasTemp = true;
         	  }
			}
			if(hasTemp){
				 //分类变化或者带有分类刷新
                showButtons(cateId,nodeType);
			}
			//筛选器全部清空的情况
			if(evt['criterions'].length==0){
				 showButtons("","");
			}
		});
							});
		</script>
	</template:replace>
</template:include>