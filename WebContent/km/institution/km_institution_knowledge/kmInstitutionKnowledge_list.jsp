<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">  
		<%-- 筛选器 --%>	
		<list:criteria id="criteria1">
			<%-- 搜索条件:文档标题--%>
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<%-- 搜索条件:与我相关 --%>	
			<list:cri-criterion title="${ lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.my') }" key="mydoc" multi="false" >
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-institution:kmInstitutionKnowledge.list.create') }', value:'create'},{text:'${ lfn:message('list.approval') }',value:'approval'}, {text:'${ lfn:message('list.approved') }', value: 'approved'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<%-- 搜索条件:状态 --%>	
			<list:cri-criterion title="${ lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docStatus') }" key="docStatus" >
				<list:box-select>
					<list:item-select cfg-defaultValue="30">
						<ui:source type="Static">
							[
							{text:'${ lfn:message('km-institution:kmInstitution.status.draft') }', value:'10'},{text:'${ lfn:message('km-institution:kmInstitution.status.examine') }',value:'20'}, {text:'${ lfn:message('km-institution:kmInstitution.status.refuse') }', value: '11'},
							{text:'${ lfn:message('km-institution:kmInstitution.status.discard') }', value:'00'},{text:'${ lfn:message('km-institution:kmInstitution.status.publish') }', value:'30'},{text:'${ lfn:message('km-institution:kmInstitution.status.abolishAndFiling') }', value:'50'}
							]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<%-- 其他搜索条件:文件编号、文件状态、文档作者、所属部门、发布时间 --%>
			<list:cri-auto modelName="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" 
				property="fdNumber;docCreator;docDept;docPublishTime;docProperties" />
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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count="6" >
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('km-institution:kmInstitutionKnowledge.docCreateTime') }" group="sort.list" value="down"></list:sort>
							<list:sort property="docPublishTime" text="${lfn:message('km-institution:kmInstitution.docPublishTime') }" group="sort.list" ></list:sort>
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
					<ui:toolbar count="5">
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
						<%-- 修改权限 --%>
						<c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
							<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
						</c:import>
						<%-- 分类转移 --%>
						<%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
						<% 
							if(com.landray.kmss.util.UserUtil.checkRole("ROLE_KMINSTITUTION_OPTALL")) {
								request.setAttribute("authType", "00");
							} 
						%>
						<c:import url="/sys/simplecategory/import/doc_cate_change_button.jsp" charEncoding="UTF-8">
							<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							<c:param name="docFkName" value="kmInstitutionTemplate" />
							<c:param name="cateModelName" value="com.landray.kmss.km.institution.model.KmInstitutionTemplate" />
							<%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
							<c:param name="authType" value="${authType}" />
						</c:import>
					</ui:toolbar>
				</div>
			</div>
		</div>	
				
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 <%--list页面--%>
		<list:listview id="listview" >
			<ui:source type="AjaxJson" >
				{url:'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&categoryId=${JsParam.categoryId}'}
			</ui:source>
			<%--列表视图--%>
			<list:colTable id="colTable" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="" ></list:col-auto>
			</list:colTable>
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
				
				//搜索条件改变时,失效按钮是否显示
				topic.subscribe('criteria.changed', function(evt){
					var showAbolish = false;
					if (evt['criterions'].length > 0) {
						for ( var i = 0; i < evt['criterions'].length; i++) {
							// 筛选条件切换成“失效”时，显示失效时间和连接
							var docStatus = evt['criterions'][i];
							if (docStatus.key == "docStatus" && docStatus.value.length == 1 && docStatus.value[0] == "50") {
								showAbolish = true;
								break;
							}
						}
					}
					if(showAbolish) {
						// 显示常规字段，另显示“失效时间”和“失效连接”
						LUI("colTable").columns[3].properties = "fdNumber;docStatus;docDept.fdName;docCreator;fdAbolishTime;fdAbolishLink";
					} else {
						// 显示常规字段，另显示“发布时间”
						LUI("colTable").columns[3].properties = "fdNumber;docStatus;docDept.fdName;docCreator;docPublishTime;";
					}
				});
				
				window.setCategory = function(cateId) {
					var url = "";
					if(Com_GetUrlParameter(window.location.href, "categoryId") != null) {
						url = Com_SetUrlParameter(window.location.href, "categoryId", cateId);
					} else {
						var temp = location.href.split("#");
						url = temp[0] + "?categoryId=" + cateId;
						if (temp.length > 1) {
							url += "#" + temp[1];
						}
					}
					window.location.href = url;
				};
				
				LUI.ready(function(){
					// 初始化左则菜单样式
		        	setTimeout('initMenuNav()', 300);
				});
				
				//根据地址获取key对应的筛选值
	            window.getValueByHash = function(key){
	                var hash = window.location.hash;
	                if(hash.indexOf(key)<0){
	                    return "";
	                 }
	            	var url = hash.split("cri.q=")[1];
	  			    var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
				    var r=url.match(reg);
					    if(r!=null){
					    	 return unescape(r[2]);
					    }
					    return "";
	                };
	                
	            // 左则样式
    			window.initMenuNav = function() {
    		 		var mydoc = getValueByHash("mydoc");
    		 		var cageId = "${param.categoryId}";
    		 		if(mydoc != "") {
    		 			resetMenuNavStyle($("#_" + mydoc));
    		 		} else if(cageId != "") {
    		 			var _a = $("#menu_template a[href*=" + cageId + "]");
    		 			$("[data-lui-type*=AccordionPanel] li").removeClass("lui_list_nav_selected");
    		 			_a.parents("div.lui_accordionpanel_slide_nav_c").addClass("lui_list_nav_selected");
    		 		} else {
    		 			resetMenuNavStyle($("#_allDoc"));
    		 		}
    		 	}
			});
		</script>
	</template:replace>
</template:include>