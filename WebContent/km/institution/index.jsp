<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.list" spa="true" spa-groups="[ ['docCategory','mydoc' ] ]">
	<%-- 标签页标题 --%>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-institution:module.km.institution') }"></c:out>
	</template:replace>
	<%-- 导航路径 --%>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams 
				id="simplecategoryId"
				moduleTitle="${ lfn:message('km-institution:module.km.institution') }" 
				modelName="com.landray.kmss.km.institution.model.KmInstitutionTemplate" 
				extkey="mydoc" />
		</ui:combin>
	</template:replace>
	<%-- 左侧导航栏 --%>
	<template:replace name="nav">
		<%-- 新建按钮 --%>
		<ui:combin ref="menu.nav.title">
			<ui:varParam name="title" value="${ lfn:message('km-institution:module.km.institution') }" />
			<ui:varParam name="operation">
				<ui:source type="Static">
					[ 
						{ text:"${ lfn:message('km-institution:kmInstitutionKnowledge.list.all') }","router" : true, href:"/allDoc", icon:'lui_iconfont_navleft_com_all' },
						{ text:"${ lfn:message('km-institution:kmInstitutionKnowledge.list.create') }","router" : true, href:'/create' ,icon:'lui_iconfont_navleft_com_my_drafted' },
						{ text:"${ lfn:message('list.approval') }","router" : true, href:'/approval', icon:'lui_iconfont_navleft_com_my_beapproval' },
						{ text:"${ lfn:message('list.approved') }","router" : true, href:'/approved', icon:'lui_iconfont_navleft_com_my_approvaled' }
					]
				</ui:source>
			</ui:varParam>				
		</ui:combin>
		
		<div id="menu_nav" class="lui_list_nav_frame">
			<ui:accordionpanel>
				<%-- 常用分类 --%>
			 	<ui:combin ref="menu.nav.favorite.category">
					<ui:varParams 
						modelName="com.landray.kmss.km.institution.model.KmInstitutionTemplate" />
				</ui:combin>
				<%-- 分类索引 --%>
				<ui:content id="menu_template" style="padding:0px;" title="${lfn:message('sys-category:menu.sysCategory.index') }">
					<ui:combin ref="menu.nav.simplecategory.flat.all">
						<ui:varParams 
							modelName="com.landray.kmss.km.institution.model.KmInstitutionTemplate" 
							spa="true"
							criProps="{'cri.q':'docStatus:30'}"
							 />
					</ui:combin>
					<ui:operation href="javascript:void(0);" 
						onclick="openPage('${LUI_ContextPath }/km/institution/km_institution_knowledge/kmInstitutionKnowledge_preview.jsp')"
						name="${lfn:message('sys-category:menu.sysCategory.overview') }" 
						target="_self" vertical="top" />
				</ui:content>
				<%-- 后台配置 --%>
				<kmss:authShow roles="ROLE_KMINSTITUTION_BACKSTAGE_MANAGER">
					<ui:content title="${ lfn:message('list.otherOpt') }" expand="false">
						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
				  					[
					  					{
						  					"text" : "${ lfn:message('list.manager') }",
						  					"icon" : "lui_iconfont_navleft_com_background",
											"router" : true,
											"href" : "/management"
						  				}
					  				]
	  							</ui:source>
							</ui:varParam>
						</ui:combin>
					</ui:content>
				</kmss:authShow>
			</ui:accordionpanel>
		</div>
	</template:replace>
	<%-- 右侧页面 --%>
	<template:replace name="content">  
		<style>
		.btn_txt {
			margin: 0px 2px;
			color: #2574ad;
			border-bottom: 1px solid transparent;
		}
		
		.btn_txt:hover {
			text-decoration: underline;
		}
		</style>
		<%-- 查询栏 --%>
		<list:criteria id="criteria1">
			<%-- 搜索条件:文档标题--%>
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<%-- 搜索条件:状态 --%>	
			<list:cri-criterion title="${ lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docStatus') }" key="docStatus" >
				<list:box-select>
					<list:item-select cfg-if="param['j_path']!='/management'">
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
		
		<%-- 操作栏 --%>
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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count="2" >
						<list:sortgroup>
							<list:sort property="fdIsTop;fdTopTime;docAlterTime" text="${lfn:message('km-institution:kmInstitutionKnowledge.order.new') }" group="sort.list" value="down"></list:sort>
							<list:sort property="docCreateTime" text="${lfn:message('km-institution:kmInstitutionKnowledge.docCreateTime') }" group="sort.list" ></list:sort>
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
					<ui:toolbar count="3">
						<%-- 视图选择 --%>	
						<ui:togglegroup order="0">
							<ui:toggle icon="lui_icon_s_zaiyao" title="${ lfn:message('list.rowTable') }" 
								group="tg_1" text="${ lfn:message('list.rowTable') }" value="rowtable" selected="true"
								onclick="hideExport(this.value);LUI('listview').switchType(this.value);">
							</ui:toggle>
							<ui:toggle icon="lui_icon_s_liebiao" title="${ lfn:message('list.columnTable') }" 
								value="columntable"	 group="tg_1" text="${ lfn:message('list.columnTable') }" 
								onclick="hideExport(this.value);LUI('listview').switchType(this.value);">
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
						<kmss:authShow roles="ROLE_KMINSTITUTION_TRANSPORT_EXPORT">
						<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.institution.model.KmInstitutionKnowledge')" order="2" ></ui:button>
						</kmss:authShow>
						<%-- ------置顶-----  --%>
						<kmss:authShow roles="ROLE_KMINSTITUTION_VIEWDISPLY">
							<ui:button id="setTop"  text="${lfn:message('km-institution:kmInstitutionKnowledge.button.setTop')}" onclick="setTop(true)"  order="4"></ui:button>	
							<ui:button id="unSetTop" text="${lfn:message('km-institution:kmInstitutionKnowledge.button.unSetTop')}" onclick="setTop(false)"  order="4"></ui:button>
						</kmss:authShow>
						<%--删除--%>		
						<ui:button text="${lfn:message('button.deleteall')}" onclick="window.moduleAPI.kmInstitution.delDoc()" order="3"
							cfg-map="{\"docStatus\":\"criteria('docStatus')\",\"docCategory\":\"criteria('docCategory')\"}"
						    cfg-auth="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall&status=!{docStatus}&categoryId=!{docCategory}">
						</ui:button>
						<%-- 修改权限 --%>
						<c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
							<c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							<c:param name="spa" value="true"/>
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
							<c:param name="spa" value="true"/>
						</c:import>
							
					</ui:toolbar>
				</div>
			</div>
		</div>	
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 <%--list页面--%>
		<list:listview id="listview" >
			<ui:source type="AjaxJson" >
				{url:'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren'}
			</ui:source>
			<%--列表视图--%>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.institution.model.KmInstitutionKnowledge" id="colTable" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<!-- 测试隐藏 -->
				<%-- <list:col-html title="${ lfn:message('km-institution:kmInstitution.docSubject') }" style="text-align:left">
				{$ <span class="com_subject" >%row['docSubject']%}</span> $}
				</list:col-html> --%>
				<list:col-auto props="" ></list:col-auto>
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
				$}
					if(row['status'] == "50") {
						{$ <span>${ lfn:message('km-institution:kmInstitution.fdAbolishTime') }：{%row['fdAbolishTime']%}</span>
						   <span>${ lfn:message('km-institution:kmInstitution.fdAbolishLink') }：{%row['fdAbolishLink']%}</span> $}
					} else {
						{$ <span>{%row['docPublishTime_row']%}</span> $}
					}
				{$		
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
		</script>	 
	</template:replace>
	<template:replace name="script">
		<!-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 -->
		<script type="text/javascript">
			seajs.use(['lui/framework/module'],function(Module){
				Module.install('kmInstitution',{
					//模块变量
					$var : {},
					//模块多语言
					$lang : {
						'approval' : '${ lfn:message("list.approval") }',
						'approved' : '${ lfn:message("list.approved") }',
						'create' : '${ lfn:message("km-institution:kmInstitutionKnowledge.list.create") }'
					},
					//搜索标识符
					$search : ''
				});
			});
		</script>
		<!-- 引入JS -->
		<script type="text/javascript" src="${LUI_ContextPath}/km/institution/resource/js/index.js"></script>
	</template:replace>
</template:include>
<script type="text/javascript">
	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/spa/Spa','lui/spa/const'], function($, dialog , topic, Spa, spaConst) {
		 window.setTop=function(isTop){
				var values = [];
				$("input[name='List_Selected']:checked").each(function(){
					values.push($(this).val());
				});
			    if(values.length==0){
				dialog.alert('<bean:message key="page.noSelect"/>');
				return;
			   }
			  var days=null;
				if(isTop){
				dialog.iframe("/km/institution/km_institution_ui/kmInstitutionKnowledge_topday.jsp","${lfn:message('km-institution:kmInstitutionKnowledge.kmDocKnowledge.fdTopTime')}",function (value){
                   days=value;
               	if(days==null){
						return;
					}else{
						window.del_load = dialog.loading();
						$.ajax({
							url: '<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=setTop"/>',
							type: 'POST',
							data:$.param({"List_Selected":values,"fdIsTop":isTop,"fdDays":days,categoryId:'${JsParam.categoryId}'},true),
							dataType: 'json',
							error: function(data){
								if(window.del_load!=null){
									window.del_load.hide(); 
								}
								dialog.failure('<bean:message key="return.optFailure" />');
							},
							success: topCallback
						});									
					}
						},{width:400,height : 200});
				}else{		
					    days=0;		
					    dialog.confirm('<bean:message bundle="km-institution" key="kmInstitutionKnowledge.setTop.confirmCancel"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.ajax({
								url: '<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=setTop"/>',
								type: 'POST',
								data:$.param({"List_Selected":values,"fdIsTop":isTop,"fdDays":days,categoryId:'${JsParam.categoryId}'},true),
								dataType: 'json',
								error: function(data){
									if(window.del_load!=null){
										window.del_load.hide(); 
									}
									dialog.failure('<bean:message key="return.optFailure" />');
								},
								success: topCallback
							});		
						}
					});					
				}
			};
			
			//置顶、取消置顶回调
			window.topCallback = function(data){
				if(window.del_load!=null)
					window.del_load.hide();
				if(data!=null && data.status==true){
					topic.publish("list.refresh");
					dialog.success('<bean:message key="return.optSuccess" />');
				}else{
					dialog.failure('<bean:message key="return.optFailure" />');
				}
			};
			
			var docCategory = '', nodeType = '', docStatus = '';
			topic.subscribe('criteria.spa.changed', function(evt) {
				
				// 获取分类Id
				docCategory = Spa.spa.getValue('docCategory') || '';
				
				// 记录状态筛选项是否清空
				var isEmptyStatus = true;
				
				for (var i = 0; i < evt['criterions'].length; i++) {
					// 获取流程状态值
					if (evt['criterions'][i].key=="docStatus") {
						isEmptyStatus = false;
						docStatus = evt['criterions'][i].value[0];
					}
				}
				
				// 清空的情况
				if (isEmptyStatus == true) {
					docStatus = "";
				}
				
				showTopButtons(docCategory, nodeType, docStatus);
			});
			
			function showTopButtons(docCategory, nodeType, docStatus){
				if(LUI('setTop') && LUI('unSetTop')) {
					LUI('setTop').setVisible(false);
					LUI('unSetTop').setVisible(false);
				}
				var checkSetTopUrl = "/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=setTop&status="+docStatus+"&categoryId="+docCategory+"&nodeType="+nodeType;
				var data = new Array();

				if (docStatus == '30') {
					 data.push(["setTopBtn",checkSetTopUrl]);
					 $.ajax({
		            	 url: Com_Parameter.ContextPath + "sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
		            	 dataType : 'json',
		      			 type : 'post',
		      			 data:{  data : LUI.stringify(data) },
		      			 async : false,
		      			 success : function(rtn){
		      				 if (rtn.length > 0) {
		      					 for (var i=0; i<rtn.length; i++) {
				      				 if (rtn[i]['setTopBtn'] == 'true') {
				      					if(LUI('setTop') && LUI('unSetTop')) {
				      						LUI('setTop').setVisible(true);
				      						LUI('unSetTop').setVisible(true);
				      					}
			      					 } else {
			      						if(LUI('setTop') && LUI('unSetTop')) {
				      						LUI('setTop').setVisible(false);
				      						LUI('unSetTop').setVisible(false);
			      						}
			      					}
				       			}
		      				 }
		      			 }
		             });
				 } else {
					 if(LUI('setTop') && LUI('unSetTop')) {
						LUI('setTop').setVisible(false);
						LUI('unSetTop').setVisible(false);
					 }
				 }
			 }
		});
</script>