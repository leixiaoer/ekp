<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<template:include ref="default.list" spa="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="nav">
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }" />
			<ui:varParam name="button">
				[
					{
						"text": "",
						"href": "javascript:void(0);",
						"icon": "km_oitems"
					}
				]
			</ui:varParam>				
		</ui:combin>
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
			   <c:import url="/geesun/oitems/import/nav.jsp" charEncoding="UTF-8">
		       </c:import>
		       <ui:content title="${ lfn:message('geesun-oitems:geesunOitems.msg.application') }" expand="true" >
		       		<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
		  					{
								"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.my.all') }",
								"href": "/listAll",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_all"
							},
							{
								"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.my.submit') }",
								"href": "/listCreate",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_drafted"
							},
							{
								"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.my.approval') }",
								"href": "/listApproval",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_beapproval"
							},
							{
								"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.my.approved') }",
								"href": "/listApproved",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_approvaled"
							}
						]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>
				</ui:content>
		       <kmss:authShow roles="ROLE_GEESUNOITEMS_ADMIN;ROLE_GEESUNOITEMS_GOODS_ADMIN">
					<ui:content title="${ lfn:message('geesun-oitems:geesunOitems.msg.listing') }" expand="true">
						<ui:combin ref="menu.nav.simple">
			  				<ui:varParam name="source">
			  					<ui:source type="Static">
			  					[
			  					{
									"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.stock.manage1') }",
									"href": "/listAllListing",
									"router" : true,
									"icon": "lui_iconfont_navleft_oitems_stock"
								},
								{
									"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.stock.manage2') }",
									"href": "/showRecordList",
									"router" : true,
									"icon": "lui_iconfont_navleft_oitems_input"
								},
								{
									"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.stock.manage3') }",
									"href": "/showStockCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_oitems_query"
								}
								]
			  					</ui:source>
			  				</ui:varParam>
		  				</ui:combin>
					</ui:content>
				</kmss:authShow>
				<kmss:authShow roles="ROLE_GEESUNOITEMS_REPORTING_ADMIN;ROLE_GEESUNOITEMS_ADMIN">
					<ui:content title="${ lfn:message('geesun-oitems:geesunOitems.msg.report') }" expand="true">
						<ui:combin ref="menu.nav.simple">
			  				<ui:varParam name="source">
			  					<ui:source type="Static">
			  					[
			  					{
									"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.moon.reporting') }",
									"href": "/monthReport",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.receive.report') }",
									"href": "/receiveCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.reporting1') }",
									"href": "/inCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.reporting2') }",
									"href": "/outCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('geesun-oitems:geesunOitems.tree.reporting3') }",
									"href": "/toReceiveCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								}
								]
			  					</ui:source>
			  				</ui:varParam>
		  				</ui:combin>
					</ui:content>
				</kmss:authShow>
		        <ui:content title="${ lfn:message('list.otherOpt') }" toggle="true" expand="false" >
				<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  						[
			  				<kmss:authShow roles="ROLE_GEESUNOITEMS_BACKSTAGE_MANAGER">
			  					{
									"text" : "${ lfn:message('list.manager') }",
									"icon" : "lui_iconfont_navleft_com_background",
									"router" : true,
									"href" : "/management"
								}
		  					</kmss:authShow>
		  					]
	  					</ui:source>
	  				</ui:varParam>	
				</ui:combin>
				</ui:content>
			</ui:accordionpanel>
		</div>
	</template:replace>
	<template:replace name="content"> 
	<ui:tabpanel id="geesunOitemsPanel" layout="sys.ui.tabpanel.list"  cfg-router="true">
		<ui:content id="geesunOitemsContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.my.all') }" cfg-route="{path:'/listAll'}"> 
		<list:criteria id="applyCriteria">
		    <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
			</list:cri-ref>

			<list:cri-auto modelName="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication"  property="docNumber;docStatus"/>
			<list:cri-criterion title="${ lfn:message('geesun-oitems:geesunOitems.tree.application.type') }" key="fdType" multi="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('geesun-oitems:geesunOitems.tree.person.application') }', value:'2'},{text:'${ lfn:message('geesun-oitems:geesunOitems.tree.dept.application') }',value:'1'}]
						</ui:source>
						<ui:event event="selectedChanged" args="evt">
							var vals = evt.values;
							if (vals.length > 0 && vals[0] != null) {
								var val = vals[0].value;
								if (val == '2') {
									LUI('fdApplyPersonCriteria1').setEnable(true);
									LUI('fdApplyPersonCriteria2').setEnable(true);
									LUI('fdApplyDeptCriteria').setEnable(false);
								} else if (val == '1') {
								    LUI('fdApplyDeptCriteria').setEnable(true);
									LUI('fdApplyPersonCriteria1').setEnable(false);
									LUI('fdApplyPersonCriteria2').setEnable(false);
								} 
							}else{
							    LUI('fdApplyPersonCriteria1').setEnable(true);
							    LUI('fdApplyPersonCriteria2').setEnable(true);
								LUI('fdApplyDeptCriteria').setEnable(true);
							}
						</ui:event>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdApplicantsId') }" expand="false" key="fdApplyPerson">
				<list:box-title>
					<div style="line-height: 30px">${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdApplicantsId') }</div>
					<div class="person">
						<list:item-search width="50px" height="22px">
							<ui:event event="search.changed" args="evt">
								var se = this.parent.parent.selectBox.criterionSelectElement;
								var source = se.source;
								if(evt.searchText)
									evt.searchText = encodeURIComponent(evt.searchText);
								source.resolveUrl(evt);
								source.one('data', function(data) {
									if (data && data.length == 1) {
										if (se.multi)
											se.selectedValues.add(data[0].value);
										else
											se.selectedValues.set(data[0].value);
									}
								});
								source.get();
							</ui:event>
						</list:item-search>
					</div>
				</list:box-title>
				<list:box-select style="min-height:60px">
					<%
						String parentId = "";
						if (UserUtil.getUser() != null
								&& UserUtil.getUser().getFdParent() != null) {
							parentId = UserUtil.getUser().getFdParent().getFdId();
						} else if (UserUtil.getUser() != null
								&& UserUtil.getUser().getFdParentOrg() != null) {
							parentId = UserUtil.getUser().getFdParentOrg()
									.getFdId();
						}
						if (StringUtil.isNotNull(parentId)) {
							parentId = "&parentId=" + parentId;
						}
						pageContext.setAttribute("parentId", parentId);
					%>
					<list:item-select id="fdApplyPersonCriteria1" type="lui/criteria/select_panel!CriterionSelectDatas">
						<ui:source type="AjaxJson">
							{url: "/sys/organization/sys_org_element/sysOrgElementCriteria.do?method=criteria${parentId }&searchText=!{searchText}&orgType=8"}
						</ui:source>
					</list:item-select>
				</list:box-select>	
			</list:cri-criterion>
			<list:cri-criterion title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.creator.dept') }" expand="false" key="docDept">
				<list:box-title>
					<div class="criterion-title-popup-div">
					<ui:menu layout="sys.ui.menu.nav">
						<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.creator.dept') }">
							<ui:menu-source autoFetch="true" href="javascript:luiCriteriaTitlePopupItemClick('${criterionAttrs['channel']}', 'docDept', '!{value}');">
								<ui:source type="AjaxJson">
									{"url":"/sys/organization/sys_org_element/sysOrgElementCriteria.do?method=criteria&parentId=!{value}&orgType=3"}
								</ui:source>
							</ui:menu-source>
						</ui:menu-item>
					</ui:menu>
					</div>
				</list:box-title>
				<%
						String lookValue = "";
						if (UserUtil.getKMSSUser() != null
								&& UserUtil.getUser().getFdParent() != null
								&& UserUtil.getUser().getFdParent().getFdParent() != null) {
							lookValue = UserUtil.getUser().getFdParent().getFdParent().getFdId();
						}
						pageContext.setAttribute("lookValue", lookValue);
				%>
				<list:box-select>
					<list:item-select id="fdApplyPersonCriteria2" type="lui/criteria!CriterionHierarchyDatas" cfg-lookValue="${lookValue }">
						<ui:source type="AjaxJson">
							{url: "/sys/organization/sys_org_element/sysOrgElementCriteria.do?method=criteria&parentId=!{value}&orgType=3&__hierarchy=true"}
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			
			<list:cri-criterion title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdApplicants.deptId') }" expand="false" key="fdApplyDept">
				<list:box-title>
					<div class="criterion-title-popup-div">
					<ui:menu layout="sys.ui.menu.nav">
						<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdApplicants.deptId') }">
							<ui:menu-source autoFetch="true" href="javascript:luiCriteriaTitlePopupItemClick('${criterionAttrs['channel']}', 'fdApplyDept', '!{value}');">
								<ui:source type="AjaxJson">
									{"url":"/sys/organization/sys_org_element/sysOrgElementCriteria.do?method=criteria&parentId=!{value}&orgType=3"}
								</ui:source>
							</ui:menu-source>
						</ui:menu-item>
					</ui:menu>
					</div>
				</list:box-title>
				<%
						String lookValue = "";
						if (UserUtil.getKMSSUser() != null
								&& UserUtil.getUser().getFdParent() != null
								&& UserUtil.getUser().getFdParent().getFdParent() != null) {
							lookValue = UserUtil.getUser().getFdParent().getFdParent().getFdId();
						}
						pageContext.setAttribute("lookValue", lookValue);
				%>
				<list:box-select>
					<list:item-select id="fdApplyDeptCriteria" type="lui/criteria!CriterionHierarchyDatas" cfg-lookValue="${lookValue }">
						<ui:source type="AjaxJson">
							{url: "/sys/organization/sys_org_element/sysOrgElementCriteria.do?method=criteria&parentId=!{value}&orgType=3&__hierarchy=true"}
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-auto modelName="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication"  property="docCreateTime"/>
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
						<list:sort property="docCreateTime" text="${lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docCreateTime') }" group="sort.list" value="down"></list:sort>
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
						<kmss:authShow roles="ROLE_GEESUNOITEMS_BUDGER_CREATE_PERSON">
							<ui:button title="${lfn:message('geesun-oitems:geesunOitems.create.title.person')}" text="${lfn:message('geesun-oitems:geesunOitems.create.title.person')}" onclick="window.moduleAPI.geesunOitems.addDoc('person')" order="2"></ui:button>
						</kmss:authShow>
						<kmss:authShow roles="ROLE_GEESUNOITEMS_BUDGER_CREATE_DEPT">
							<ui:button title="${lfn:message('geesun-oitems:geesunOitems.create.title.dept')}" text="${lfn:message('geesun-oitems:geesunOitems.create.title.dept')}" onclick="window.moduleAPI.geesunOitems.addDoc('dept')" order="2"></ui:button>		
						</kmss:authShow>
						<kmss:authShow roles="ROLE_GEESUNOITEMS_TRANSPORT_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication')" order="2" ></ui:button>
						</kmss:authShow>				
						<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=deleteall" requestMethod="GET">							
							<ui:button text="${lfn:message('button.deleteall')}" onclick="window.moduleAPI.geesunOitems.delDoc()" order="4"></ui:button>
						</kmss:auth>
						
					</ui:toolbar>
				</div>
			</div>
		</div>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplicationIndex.do?method=list'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<!-- 测试隐藏 -->
				<%-- <list:col-html  title="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.docSubject') }" style="text-align:left">
				 {$ <span class="com_subject" >{%row['docSubject']%}</span> $}
				</list:col-html> --%>
				<list:col-auto ></list:col-auto>
			</list:colTable>
			<list:rowTable isDefault="false"
				rowHref="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=view&fdId=!{fdId}" name="rowtable" >
				<list:row-template ref="sys.ui.listview.rowtable">
				</list:row-template>
			</list:rowTable>
		</list:listview> 
	 	<list:paging></list:paging>	 
	 	</ui:content>
	 	</ui:tabpanel>
	</template:replace>
	<template:replace name="script">
   		<%-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 --%>
      	<script type="text/javascript">
      		seajs.use(['lui/framework/module'],function(Module){
      			Module.install('geesunOitems',{
					//模块变量
					$var : {},
 					//模块多语言
 					$lang : {
 						confirmFiled : '${lfn:message("page.comfirmDelete")}',
 						optSuccess : '${lfn:message("return.optSuccess")}',
 						optFailure : '${lfn:message("return.optFailure")}',
 						pageNoSelect : '${lfn:message("page.noSelect")}'
 					},
 					//搜索标识符
 					$search : 'com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication'
  				});
      		});
      	</script>
      	<script type="text/javascript" src="${LUI_ContextPath}/geesun/oitems/js/index.js"></script>
	</template:replace>
</template:include>
