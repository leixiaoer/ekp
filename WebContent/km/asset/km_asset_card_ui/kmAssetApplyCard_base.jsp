<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body"> 
	
	<form name="printForm" action="<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />" method="post" style="display: none;" target="_blank">
		<input type="hidden" name="checkIdValues" />
		<input type="hidden" name="fdNum" />
		<input type="hidden" name="fdColumns" />
		<input type="hidden" name="fdModelName" />
		<input type="hidden" name="mycard" />
		<input type="hidden" name="except" />
		<input type="hidden" name="addShow" />
		<input type="hidden" name="fdAssetStatus" />
	</form>
	
	<!-- 批量修改卡片信息 -->
	<form name="batchEditForm" action="<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=addBatchEdit" method="post" style="display: none;" target="_blank">
		<input type="hidden" name="batchEditFdIds" />
	</form>
	
	<script type="text/javascript">
		seajs.use(['theme!list']);	
	</script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/asset/resource/css/gridview.css"></link>
		<list:criteria id="cardcriteria">
			<list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${ lfn:message('km-asset:kmAssetCard.fdName') }">
			</list:cri-ref>
			<list:cri-ref ref="criterion.sys.simpleCategory" key="fdAssetCategory" multi="false" title="${ lfn:message('km-asset:kmAssetCard.fdAssetCategory') }" expand="false">
			  <list:varParams modelName="com.landray.kmss.km.asset.model.KmAssetCategory"/>
			</list:cri-ref>
			
			<c:choose>
				<c:when test="${param.mode eq 'myCard' }">
					<list:cri-auto modelName="com.landray.kmss.km.asset.model.KmAssetCard" property="fdCode;docDept"/>
				</c:when>
				<c:otherwise>
					<list:cri-auto modelName="com.landray.kmss.km.asset.model.KmAssetCard" property="fdCode;fdResponsiblePerson;docDept"/>
				</c:otherwise>
			</c:choose>
			
		<list:tab-criterion
				title="" key="fdAssetStatus"
				multi="false">
				<list:box-select>
					<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas" cfg-if="param['fdAssetStatus']!='5'">
						<ui:source type="Static">
							[
							{text:'${ lfn:message('km-asset:fdAssetStatus.enums.status1') }', value:'1'},
							{text:'${ lfn:message('km-asset:fdAssetStatus.enums.status2') }',value:'2'}, 
							{text:'${ lfn:message('km-asset:fdAssetStatus.enums.status3') }', value: '3'},
							{text:'${ lfn:message('km-asset:fdAssetStatus.enums.status4') }', value: '4'},
							{text:'${ lfn:message('km-asset:fdAssetStatus.enums.status5') }', value: '5'}
							]
						</ui:source>
					</list:item-select>
				</list:box-select>
		</list:tab-criterion>
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
				 	    <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
				 	    <list:sortgroup>
					    	<list:sort property="fdCode" text="${ lfn:message('km-asset:kmAssetCard.fdCode') }" group="sort.list" value="up"></list:sort>
					    	<list:sort property="fdName" text="${ lfn:message('km-asset:kmAssetCard.fdName') }" group="sort.list"></list:sort>
					    	<list:sort property="fdAssetStatus" text="${ lfn:message('km-asset:kmAssetCard.fdAssetStatus') }" group="sort.list"></list:sort>
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
					<ui:toolbar id="Btntoolbar">
						<c:if test="${param.mode != 'myCard' }">
						   <ui:togglegroup order="0">
					            <ui:toggle icon="lui_icon_s_tuwen" title="${lfn:message('list.gridTable') }" group="tg_1" value="gridtable" selected="true"
									 text="${lfn:message('list.gridTable') }" onclick="LUI('cardListView').switchType(this.value);">
								</ui:toggle>
								<ui:toggle icon="lui_icon_s_liebiao"  title="${ lfn:message('list.columnTable') }"  group="tg_1" value="columntable"
								   text="${ lfn:message('list.columnTable') }" onclick="LUI('cardListView').switchType(this.value);">
								</ui:toggle>
							</ui:togglegroup>
			   			</c:if>
					    <kmss:authShow 	roles="ROLE_KMASSETCARD_CREATE">
						 <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" id="add"></ui:button>
						</kmss:authShow>
						<kmss:auth requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=deleteall">
						  <ui:button id="del" text="${lfn:message('button.deleteall')}" order="3" onclick="delDoc();"></ui:button>
						</kmss:auth>
						<kmss:authShow roles="ROLE_KMASSETCARD_CREATE">
						    <ui:button  text="${lfn:message('button.import')}" order="3" onclick="importResult();"></ui:button>
						</kmss:authShow>
						<%-- 修改权限 --%>
						<c:import url="/sys/right/import/cchange_doc_right_button.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.asset.model.KmAssetCard" />
								<c:param name="authReaderNoteFlag" value="1" />
						</c:import>		
						<kmss:auth requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=exportResult">
						    <ui:button id="exportresult" text="${lfn:message('button.export')}" order="3" onclick="exportResult();"></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/asset/km_asset_card/kmAssetCard.do?method=addBatchEdit">
						    <ui:button id="addbatch" text="${lfn:message('km-asset:kmAssetCard.batchEdit')}" order="3" onclick="addBatchEdit();"></ui:button>
						</kmss:auth>					
					</ui:toolbar> 					
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="cardListView">
			<ui:source type="AjaxJson">
				<c:choose>
					<c:when test="${param.mode eq 'myCard' }">
						{url:'/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&categoryId=${JsParam.categoryId}&nodeType=${JsParam.nodeType}&q.fdResponsiblePerson=${param.fdResponsiblePerson }'}
					</c:when>
					<c:otherwise>
						{url:'/km/asset/km_asset_card_index/kmAssetCardIndex.do?method=list&categoryId=${JsParam.categoryId}&nodeType=${JsParam.nodeType}'}
					</c:otherwise>
				</c:choose>
			</ui:source>
			<list:colTable isDefault="false" name="columntable" layout="sys.ui.listview.columntable" rowHref="/km/asset/km_asset_card/kmAssetCard.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<c:choose>
					<c:when test="${param.mode eq 'myCard' }">
						<list:col-column property="fdCode"></list:col-column>
						<list:col-column property="assetName"></list:col-column>
						<list:col-column property="fdStandard"></list:col-column>
						<list:col-column property="docDept.fdName"></list:col-column>
						<list:col-column property="fdAssetCategory.fdName"></list:col-column>
						<list:col-column property="fdAssetStatus"></list:col-column>
					</c:when>
					<c:otherwise>
						<list:col-auto></list:col-auto>
					</c:otherwise>
				</c:choose>
			</list:colTable>
			<%-- 视图列表 --%>
			
			<c:if test="${param.mode != 'myCard' }">
			
			<list:gridTable isDefault="false" name="gridtable" columnNum="4">
				<list:row-template>
				{$
				  <div class="assetcard_gridtable_content" onclick="openCard('{%grid['fdId']%}')">
					<div class="assetcard_gridtable_content_container">
						<a class="assetcard_gridtable_content_image" href="javascript:;" data-lui-mark-id="{%grid.rowId%}">
							<img src="{%grid['fdImageUrl']%}" $}if(grid['assetName']){ {$ alt="{% grid['assetName']%}" $} } {$>
						</a>
						<h1 class="clearfloat ">$}
							{$<input type="checkbox" data-lui-mark="table.content.checkbox" value="{%grid['fdId']%}" name="List_Selected">$}
							if(grid['assetName']){
								{$<a href="javascript:;" class="assetcard_gridtable_content_docSubject com_subject"
										title="{%grid['assetName']%}" data-lui-mark-id="{%grid.rowId%}">
								$}
								{$ {%str.textEllipsis(grid['assetName'],45)%} $}
								{$</a>$}
							}
						{$</h1>
						<div class="txtBox clearfloat">$}
						if(grid['fdAssetCategory.fdName']){
							{$<div class="txtBox_label">
								<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory" />：
							</div>
							<div class="txtBox_text textEllipsis" title="{%grid['fdAssetCategory.fdName']%}">
								<span>{%grid['fdAssetCategory.fdName']%}</span>
							</div>$}
						}
						{$</div>$}
						if(grid['fdResponsiblePerson.fdName']){
						  {$<div class="txtBox clearfloat">
							<div class="txtBox_label">
								<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson" />：
							</div>
							<div class="txtBox_text">
								<span>{%grid['fdResponsiblePerson.fdName']%}</span>
							</div>
						  </div>$}
						}
						if(grid['fdCode']){
						  {$<div class="txtBox clearfloat">
							<div class="txtBox_label">
								<bean:message bundle="km-asset" key="kmAssetCard.fdCode" />：
							</div>
							<div class="txtBox_text textEllipsis" title="{%grid['fdCode']%}">
								<span>{%grid['fdCode']%}</span>
							</div>
						  </div>$}
						}
						if(grid['fdAssetStatus']){
						  {$<div class="txtBox clearfloat">
							<div class="txtBox_label">
								<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus" />：
							</div>
							<div class="txtBox_text">
								<span>{%grid['fdAssetStatus']%}</span>
							</div>
						  </div>$}
						}
						{$
					</div>
				</div>	
				$}
				</list:row-template>
			</list:gridTable>
			
			</c:if>
		</list:listview>
		<br>
	 	<list:paging></list:paging>
	 	<% 
	    request.setAttribute("isAdmin",UserUtil.getKMSSUser().isAdmin());
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
							data:$.param({"List_Selected":values,"categoryId":cateId},true),
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
					document.batchEditForm.batchEditFdIds.value = selectedIds.substring(0, selectedIds.length-1);
				}else{
					document.batchEditForm.batchEditFdIds.value = selectedIds;
				}
			    $("form[name='batchEditForm']").submit();
			}
			function serializeParams(params) {
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
				var str = array.join('&');
				return str;
			}
			 function getUrlParam(url,name) {  
			     var pattern = new RegExp("[#&]"+name+"\=([^&]+)", "g");  
			     var matcher = pattern.exec(url);  
			     var items = null;  
			     if(null != matcher){  
			             try{  
			                    items = decodeURIComponent(decodeURIComponent(matcher[1]));  
			             }catch(e){  
			                     try{  
			                             items = decodeURIComponent(matcher[1]);  
			                     }catch(e){  
			                             items = matcher[1];  
			                     }  
			             }  
			     }  
			     return items;  
			}  
			window.exportResult=function (){ 
	 			var values = [];
				$("input[name='List_Selected']:checked").each(function(){
					values.push($(this).val());
				});
				
				if(values.length == 0){
					var url = '<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=exportResult';
					var criterions = LUI('cardcriteria')._buildCriteriaSelectedValues();
					
					var urlParam = serializeParams(criterions);
					if (urlParam) {
						if (url.indexOf('?') > 0) {
							url += "&" + urlParam;
						} else {
							url += "?" + urlParam;
						}
					}
					
					//导出个人资产
					if('${param.mode}' == 'myCard') {
						url += '&q.fdResponsiblePerson=${param.fdResponsiblePerson }';
					}
					
					url +='&fdNum=5000&fdColumns=fdName;fdCode;fdAssetCategory;fdNo;fdStandard;fdMeasure;fdFirstValue;fdFirstUnit;fdProvider;fdCanUseYears;docDeptCode;docDept;fdAssetAddress;fdResponsiblePerson;fdBuyer;fdBuyDate;fdInDeptNo;fdInDeptDate;fdWarranty;fdAssetStatus;fdFirstUsedDate;fdExplanation;fdContent'
					   +'&fdModelName=com.landray.kmss.km.asset.model.KmAssetCard';
					 if("/kmAssetCard_my"==getUrlParam(window.location.href,"j_path")){
						url +="&mycard=responsible&except=fdAssetStatus:5&addShow=true";
					}
					if("/kmAsset_abandom/abandomCard"==getUrlParam(window.location.href,"j_path")){
								url +="&fdAssetStatus=5";
							}
					if("/kmAsset_bank"==getUrlParam(window.location.href,"j_path")){
						url +="&except=fdAssetStatus:5&addShow=true";
					}
					window.location.href = url; 
				} else {
					document.printForm.checkIdValues.value = values.join(";");
					document.printForm.fdNum.value = '999999999';
					document.printForm.fdColumns.value = 'fdName;fdCode;fdAssetCategory;fdNo;fdStandard;fdMeasure;fdFirstValue;fdFirstUnit;fdProvider;fdCanUseYears;docDeptCode;docDept;fdAssetAddress;fdResponsiblePerson;fdBuyer;fdBuyDate;fdInDeptNo;fdInDeptDate;fdWarranty;fdAssetStatus;fdFirstUsedDate;fdExplanation;fdContent';
					document.printForm.fdModelName.value = 'com.landray.kmss.km.asset.model.KmAssetCard';
					if("/kmAssetCard_my"==getUrlParam(window.location.href,"j_path")){
						document.printForm.mycard.value = 'responsible';
						document.printForm.except.value = 'fdAssetStatus:5';
						document.printForm.addShow.value = 'true';
					}
					if("/kmAsset_abandom/abandomCard"==getUrlParam(window.location.href,"j_path")){
						document.printForm.fdAssetStatus.value = '5';	
					}
					if("/kmAsset_bank"==getUrlParam(window.location.href,"j_path")){
						document.printForm.except.value = 'fdAssetStatus:5';
						document.printForm.addShow.value = 'true';
					}
					Com_SubmitNoEnabled(document.printForm, 'exportResult');
					
				}
			};

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
		                 var checkDelUrl = "/km/asset/km_asset_card/kmAssetCard.do?method=deleteall&categoryId="+cateId+"&nodeType="+nodeType;
						 var changeRightBatchUrl = "/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetCard&categoryId="+cateId+"&nodeType="+nodeType;
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
             	  if(evt['criterions'][i].key=="fdAssetCategory"){
                 	 cateId= evt['criterions'][i].value[0];
	                 nodeType = evt['criterions'][i].nodeType;
	                 hasTemp = true;
             	  }
				}
				if(hasTemp){
					 //分类变化或者带有分类刷新
	                showButtons(cateId,nodeType);
				}else{
					showButtons("","");
				}
			});
			
		});
	 	</script>
	</template:replace>
</template:include>