<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/asset/resource/css/gridview.css"></link>
	</template:replace>
	<template:replace name="content">
		<form name="printForm" action="<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />" method="post" style="display: none;" target="_blank">
			<input type="hidden" name="checkIdValues" />
			<input type="hidden" name="fdNum" />
			<input type="hidden" name="fdColumns" />
			<input type="hidden" name="fdModelName" />
		</form>
		<!-- 批量打印form提交 -->
		<form name="batchPrintForm" action="<c:url value="/km/asset/km_asset_card/kmAssetCard.do?method=addBatchPrint" />" method="post" style="display: none;" target="_blank">
			<input type="hidden" name="batchPrintFdIds" />
		</form>
		
		<!-- 批量修改卡片信息 -->
		<form name="batchEditForm" action="<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=addBatchEdit" method="post" style="display: none;" target="_blank">
			<input type="hidden" name="batchEditFdIds" />
		</form>
		
		<list:criteria id="cardcriteria">
			<list:cri-ref key="fdName" ref="criterion.sys.docSubject"
				title="${ lfn:message('km-asset:kmAssetCard.fdName') }">
			</list:cri-ref>
			<%-- <list:cri-ref ref="criterion.sys.simpleCategory" key="fdAssetCategory" multi="false" title="${ lfn:message('km-asset:kmAssetCard.fdAssetCategory') }" expand="true">
			  <list:varParams modelName="com.landray.kmss.km.asset.model.KmAssetCategory"/>
			</list:cri-ref> --%>
			<list:cri-auto
				modelName="com.landray.kmss.km.asset.model.KmAssetCard"
				property="fdAssetStatus;fdCode;fdResponsiblePerson;docDept" />
			<list:cri-criterion
				title="${lfn:message('km-asset:kmAssetCard.criteria.other')}"
				key="mycard" multi="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-asset:kmAssetCard.page.my') }', value:'responsible'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
		</list:criteria>

		<div class="lui_list_operation">
			<div style='color: #979797; float: left; padding-top: 1px;'>${ lfn:message('list.orderType') }：
			</div>
			<div style="float: left">
				<div style="display: inline-block; vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
					<list:sortgroup>
						<list:sort property="fdCode"
							text="${ lfn:message('km-asset:kmAssetCard.fdCode') }"
							group="sort.list" value="up"></list:sort>
						<list:sort property="fdName"
							text="${ lfn:message('km-asset:kmAssetCard.fdName') }"
							group="sort.list"></list:sort>
						<list:sort property="fdAssetStatus"
							text="${ lfn:message('km-asset:kmAssetCard.fdAssetStatus') }"
							group="sort.list"></list:sort>
					</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
			</div>
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<div style="float: right">
				<div style="display: inline-block; vertical-align: middle;">
					<ui:toolbar id="Btntoolbar">
						<ui:togglegroup order="0">
							<ui:toggle icon="lui_icon_s_tuwen"
								title="${lfn:message('list.gridTable') }" group="tg_1"
								value="gridtable" selected="true"
								text="${lfn:message('list.gridTable') }"
								onclick="LUI('cardListView').switchType(this.value);">
							</ui:toggle>
							<ui:toggle icon="lui_icon_s_liebiao"
								title="${ lfn:message('list.columnTable') }" group="tg_1"
								value="columntable" text="${ lfn:message('list.columnTable') }"
								onclick="LUI('cardListView').switchType(this.value);">
							</ui:toggle>
						</ui:togglegroup>
						<kmss:authShow roles="ROLE_KMASSETCARD_CREATE">
							<ui:button text="${lfn:message('button.add')}" onclick="addDoc()"
								order="2"></ui:button>
						</kmss:authShow>
						<kmss:auth
							requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=deleteall">
							<ui:button id="del" text="${lfn:message('button.deleteall')}"
								order="3" onclick="delDoc();"></ui:button>
						</kmss:auth>
						<%-- 修改权限 --%>
						<c:import url="/sys/right/import/cchange_doc_right_button.jsp"
							charEncoding="UTF-8">
							<c:param name="modelName"
								value="com.landray.kmss.km.asset.model.KmAssetCard" />
						</c:import>
						<kmss:authShow roles="ROLE_KMASSETCARD_CREATE">
							<ui:button text="${lfn:message('button.import')}" order="5"
								onclick="importResult();"></ui:button>
						</kmss:authShow>
						<kmss:auth
							requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=exportResult">
							<ui:button id="exportresult"
								text="${lfn:message('button.export')}" order="7"
								onclick="exportResult();"></ui:button>
						</kmss:auth>
						<kmss:authShow roles="ROLE_KMASSET_BACKSTAGE_MANAGER">
							<ui:button id="addBatchPrint"
								text="${lfn:message('km-asset:kmAssetCard.batchPrint')}" order="8"
								onclick="addBatchPrint();"></ui:button>
						</kmss:authShow>
						<kmss:auth
							requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=addBatchEdit">
							<ui:button id="addbatch"
								text="${lfn:message('km-asset:kmAssetCard.batchEdit')}"
								order="9" onclick="addBatchEdit();"></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="cardListView">
			<ui:source type="AjaxJson">
						{url:'/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&q.fdAssetCategory=${JsParam.categoryId}'}
			</ui:source>
			<list:colTable isDefault="false" name="columntable"
				layout="sys.ui.listview.columntable"
				rowHref="/km/asset/km_asset_card/kmAssetCard.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto
					props="fdIsLocked;fdCode;fdName;fdStandard;docDept.fdName;fdResponsiblePerson.fdName;fdAssetAddress.fdAddress;fdAssetCategory.fdName;fdAssetStatus"></list:col-auto>
			</list:colTable>
			<%-- 视图列表 --%>
			<list:gridTable isDefault="false" name="gridtable" columnNum="4">
				<list:row-template>
				{$
				  <div class="assetcard_gridtable_content"
						onclick="openCard('{%grid['fdId']%}')">
						<div class="assetcard_gridtable_content_container">
							<a class="assetcard_gridtable_content_image" href="javascript:;"
								data-lui-mark-id="{%grid.rowId%}"> <img
								src="{%grid['fdImageUrl']%}"
								$}if(grid['assetName']){ {$ alt="{% grid['assetName']%}"$} } {$>
							</a>
							<h1 class="clearfloat ">
								$} {$<input type="checkbox"
									data-lui-mark="table.content.checkbox" value="{%grid['fdId']%}"
									name="List_Selected">$} if(grid['assetName']){ {$<a
									href="javascript:;"
									class="assetcard_gridtable_content_docSubject com_subject"
									title="{%grid['assetName']%}" data-lui-mark-id="{%grid.rowId%}">
									$} {$ {%str.textEllipsis(grid['assetName'],45)%} $} {$</a>$} } {$
							</h1>
							<div class="txtBox clearfloat">
								$} if(grid['fdAssetCategory.fdName']){ {$
								<div class="txtBox_label">资产分类：</div>
								<div class="txtBox_text textEllipsis"
									title="{%grid['fdAssetCategory.fdName']%}">
									<span>{%grid['fdAssetCategory.fdName']%}</span>
								</div>
								$} } {$
							</div>
							$} if(grid['fdResponsiblePerson.fdName']){ {$
							<div class="txtBox clearfloat">
								<div class="txtBox_label">责任人：</div>
								<div class="txtBox_text">
									<span>{%grid['fdResponsiblePerson.fdName']%}</span>
								</div>
							</div>
							$} } if(grid['fdCode']){ {$
							<div class="txtBox clearfloat">
								<div class="txtBox_label">编码：</div>
								<div class="txtBox_text textEllipsis" title="{%grid['fdCode']%}">
									<span>{%grid['fdCode']%}</span>
								</div>
							</div>
							$} } if(grid['fdAssetStatus']){ {$
							<div class="txtBox clearfloat">
								<div class="txtBox_label">状态：</div>
								<div class="txtBox_text">
									<span>{%grid['fdAssetStatus']%}</span>
								</div>
							</div>
							$} } {$
						</div>
					</div>	
				$}
				</list:row-template>
			</list:gridTable>
		</list:listview>
		<br>
		<list:paging></list:paging>
		<%
			request.setAttribute("isAdmin", UserUtil.getKMSSUser().isAdmin());
		%>
		<script type="text/javascript">
	 	var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.asset.model.KmAssetCard";

	 	//用于新建的全局变量,每次筛选器分类改变都更新该值
	 	var cateId = "${JsParam.categoryId}";
	 	
	 	seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/toolbar'], function($, strutil, dialog , topic,toolbar) {
	 		// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				topic.publish('list.refresh');
			});
			window.openCard = function(fdId){
				window.open('<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=view&fdId='+fdId,"_blank");
			};
			 
		 	//新建
		 	window.addDoc = function() {
						dialog.simpleCategoryForNewFile(
								'com.landray.kmss.km.asset.model.KmAssetCategory',
								'/km/asset/km_asset_card/kmAssetCard.do?method=add&fdTemplateId=!{id}',false,null,null,cateId);
				};
		 	
		 	window.clearAllValue = function() {
		 		
			 	this.location = "${LUI_ContextPath}/km/asset";
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
				var url  = '<c:url value="/km/asset/km_asset_card/kmAssetCard.do?method=deleteall"/>';
				dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
					if(value==true){
						window.del_load = dialog.loading();

						$.ajax({
							url: url,
							type: 'POST',
							data:$.param({"List_Selected":values},true),
							dataType: 'json',
							error: function(data){
								if(window.del_load!=null){
									window.del_load.hide(); 
								}
								dialog.result(data.responseJSON);
							},
							success: delCallback
							});
					}
				});
			};
			window.delCallback = function(data){
				if(window.del_load!=null){
					window.del_load.hide(); 
					topic.publish("list.refresh");
				}
				dialog.result(data);
			};

			window.importResult	 = function(){
				Com_OpenWindow('<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=importExcel');
			};
			window.addBatchEditIds = "";
			window.addBatchEdit	 = function(){
				var isSelected=false;
				var selectedIds="";
				var obj = document.getElementsByName("List_Selected");
				for(var i=0; i<obj.length; i++)
				{
					if(obj[i].checked)
					{
						selectedIds=selectedIds+obj[i].value;
						if(i!=obj.length-1)
						{
							selectedIds=selectedIds+",";
						}
						isSelected=true;
					}
				}
				if(isSelected==false)
				{
					dialog.alert('<bean:message key="page.noSelect"/>');
					return false;
				}
				addBatchEditIds = selectedIds;
				if(selectedIds.charAt(selectedIds.length-1)==','){
					//window.open('<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=addBatchEdit&fdIds='+selectedIds.substring(0, selectedIds.length-1));
					document.batchEditForm.batchEditFdIds.value = selectedIds.substring(0, selectedIds.length-1);
				}else{
					//window.open('<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=addBatchEdit&fdIds='+selectedIds);
					document.batchEditForm.batchEditFdIds.value = selectedIds;
				}
				document.batchEditForm.batchEditFdIds.value = selectedIds;
			    $("form[name='batchEditForm']").submit();
			}
			function serializeParams(params,categoryId) {
				var array = [];
				for (var i = 0; i < params.length; i++) {
					var p = params[i];
					if (p.nodeType) {
						array.push('nodeType=' + p.nodeType);
					}
					for (var j = 0; j < p.value.length; j++) {
						array.push("q." + encodeURIComponent(p.key) + '='
								+ encodeURIComponent(p.value[j]));
					}
					if (p.op) {
						array.push(encodeURIComponent(p.key) + '-op='
								+ encodeURIComponent(p.op));
					}
					for (var k in p) {
						if (k == 'key' || k == 'op' || k == 'value' || k == 'nodeType') {
							continue;
						}
						array.push(encodeURIComponent(p.key + '-' + k) + "="
								+ encodeURIComponent(p[k] || ""));
					}
				}
				array.push("q.fdAssetCategory="+categoryId);
				var str = array.join('&');
				return str;
			}
	
			//批量打印
			window.addBatchPrint = function(){
				var isSelected=false;
				var selectedIds="";
				var obj = document.getElementsByName("List_Selected");
				for(var i=0; i<obj.length; i++) {
					if(obj[i].checked) {
						selectedIds=selectedIds+obj[i].value;
						if(i!=obj.length-1) {
							selectedIds=selectedIds+",";
						}
						isSelected=true;
					}
				}
				if(isSelected==false) {
					dialog.alert('<bean:message key="page.noSelect"/>');
					return false;
				}
				document.batchPrintForm.batchPrintFdIds.value = selectedIds;
			    $("form[name='batchPrintForm']").submit();
				//Com_OpenWindow('<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=addBatchPrint&fdIds='+selectedIds);
			}
			
			window.exportResult=function (){ 
				var values = [];
				$("input[name='List_Selected']:checked").each(function(){
						values.push($(this).val());
				});
				if(values.length == 0){
					var criterions = LUI('cardcriteria')._buildCriteriaSelectedValues();
					var categoryId = '${JsParam.categoryId}';
					var urlParam = serializeParams(criterions,categoryId);
					if (urlParam) {
						if (url.indexOf('?') > 0) {
							url += "&" + urlParam;
						} else {
							url += "?" + urlParam;
						}
					}
					url +='&fdNum=5000&fdColumns=fdName;fdCode;fdAssetCategory;fdNo;fdStandard;fdMeasure;fdFirstValue;fdFirstUnit;fdProvider;fdCanUseYears;docDeptCode;docDept;fdAssetAddress;fdResponsiblePerson;fdBuyer;fdBuyDate;fdInDeptNo;fdInDeptDate;fdWarranty;fdAssetStatus;fdFirstUsedDate;fdExplanation;fdContent'
						   +'&fdModelName=com.landray.kmss.km.asset.model.KmAssetCard';
					Com_OpenNewWindow(url);
					//window.location.href = url;
				}else{
					document.printForm.checkIdValues.value = values.join(";");
					document.printForm.fdNum.value = '999999999';
					document.printForm.fdColumns.value = 'fdName;fdCode;fdAssetCategory;fdNo;fdStandard;fdMeasure;fdFirstValue;fdFirstUnit;fdProvider;fdCanUseYears;docDeptCode;docDept;fdAssetAddress;fdResponsiblePerson;fdBuyer;fdBuyDate;fdInDeptNo;fdInDeptDate;fdWarranty;fdAssetStatus;fdFirstUsedDate;fdExplanation;fdContent';
					document.printForm.fdModelName.value = 'com.landray.kmss.km.asset.model.KmAssetCard';
					Com_SubmitNoEnabled(document.printForm, 'exportResult');
				}
			}


			var AuthCache = {};
			//根据筛选器分类异步校验权限
			topic.subscribe('criteria.changed',function(evt){
				var cateId = "";
				var nodeType = "";
				for(var i=0;i<evt['criterions'].length;i++){
	             	if(evt['criterions'][i].key=="fdAssetCategory"){
	             		cateId = evt['criterions'][i].value[0];
	             		break;
	             	}
	             }
	             if(cateId!=""){
				 if(AuthCache[cateId]){
		             if(AuthCache[cateId].delBtn){
			             if(!LUI('del')){ 
			            	 var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.delete")}',click:'delDoc()'});
	    					 LUI('Btntoolbar').addButton(delBtn);
			             }
		             }else{
		            	 if(LUI('del')){
		            	   LUI('Btntoolbar').removeButton(LUI('del'));
		            	   LUI('del').destroy();
		            	 }
			         }
		             if(AuthCache[cateId].chgRightBtn){
			             if(!LUI('changeRightBatch')){ 
			            	 var chgRightBtn = toolbar.buildButton({id:'changeRightBatch',order:'2',text:'${ lfn:message('sys-right:right.button.changeRightBatch')}',click:'changeRightCheckSelect()'});
	    					 LUI('Btntoolbar').addButton(chgRightBtn);
			             }
		             }else{
		            	 if(LUI('changeRightBatch')){
		            	   LUI('Btntoolbar').removeButton(LUI('changeRightBatch'));
		            	   LUI('changeRightBatch').destroy();
		            	 }
			         }
	             }
	             if(AuthCache[cateId]==null){
	            	    var checkDelUrl = "/km/asset/km_asset_card/kmAssetCard.do?method=deleteall&categoryId="+cateId;
	            	    var checkChgRightUrl = "/sys/right/rightDocChange.do?method=docRightEdit&modelName=com.landray.kmss.km.asset.model.KmAssetCard&categoryId="+cateId;
		                 var data = new Array();
		                 data.push(["delBtn",checkDelUrl]);
		                 data.push(["chgRightBtn",checkChgRightUrl]);
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
				                 		 var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.delete")}',click:'delDoc()'});
				    					 LUI('Btntoolbar').addButton(delBtn);
			                 		}
			                       }
			                 		if(rtn[i]['chgRightBtn'] == 'true'){
				                 		 btnInfo.chgRightBtn = true;
				                 		if(!LUI('changeRightBatch')){
					                 		 var chgRightBtn = toolbar.buildButton({id:'changeRightBatch',order:'2',text:'${ lfn:message('sys-right:right.button.changeRightBatch')}',click:'changeRightCheckSelect()'});
					    					 LUI('Btntoolbar').addButton(chgRightBtn);
				                 		}
				                       }
			       				}
			       			  }else{
		                    	   btnInfo.delBtn = false;
		                    	   if(LUI('del')){
		                    	    LUI('Btntoolbar').removeButton(LUI('del'));
		                    	    LUI('del').destroy();
		                    	   }
		                    	   btnInfo.chgRightBtn = false;
		                    	   if(LUI('changeRightBatch')){
		                    	    LUI('Btntoolbar').removeButton(LUI('changeRightBatch'));
		                    	    LUI('changeRightBatch').destroy();
		                    	   }
			                  }
		                 	 AuthCache[cateId] = btnInfo;
		  		            }
	                  })
	             }
	           }
			});
	 	});
	 	
	 	</script>
	</template:replace>
</template:include>