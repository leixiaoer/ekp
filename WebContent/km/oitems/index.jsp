<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<template:include ref="default.list" spa="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="nav">
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('km-oitems:kmOitems.tree.modelName') }" />
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
			   <c:import url="/km/oitems/import/nav.jsp" charEncoding="UTF-8">
		       </c:import>
		       <ui:content title="${ lfn:message('km-oitems:kmOitems.msg.application') }" expand="true" >
		       		<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
		  					{
								"text": "${ lfn:message('km-oitems:kmOitems.tree.my.all') }",
								"href": "/listAll",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_all"
							},
							{
								"text": "${ lfn:message('km-oitems:kmOitems.tree.my.submit') }",
								"href": "/listCreate",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_drafted"
							},
							{
								"text": "${ lfn:message('km-oitems:kmOitems.tree.my.approval') }",
								"href": "/listApproval",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_beapproval"
							},
							{
								"text": "${ lfn:message('km-oitems:kmOitems.tree.my.approved') }",
								"href": "/listApproved",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_approvaled"
							}
						]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>
				</ui:content>
		       <kmss:authShow roles="ROLE_KMOITEMS_ADMIN;ROLE_KMOITEMS_GOODS_ADMIN">
					<ui:content title="${ lfn:message('km-oitems:kmOitems.msg.listing') }" expand="true">
						<ui:combin ref="menu.nav.simple">
			  				<ui:varParam name="source">
			  					<ui:source type="Static">
			  					[
			  					{
									"text": "${ lfn:message('km-oitems:kmOitems.tree.stock.manage1') }",
									"href": "/listAllListing",
									"router" : true,
									"icon": "lui_iconfont_navleft_oitems_stock"
								},
								{
									"text": "${ lfn:message('km-oitems:kmOitems.tree.stock.manage2') }",
									"href": "/showRecordList",
									"router" : true,
									"icon": "lui_iconfont_navleft_oitems_input"
								},
								{
									"text": "${ lfn:message('km-oitems:kmOitems.tree.stock.manage3') }",
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
				<kmss:authShow roles="ROLE_KMOITEMS_REPORTING_ADMIN;ROLE_KMOITEMS_ADMIN">
					<ui:content title="${ lfn:message('km-oitems:kmOitems.msg.report') }" expand="true">
						<ui:combin ref="menu.nav.simple">
			  				<ui:varParam name="source">
			  					<ui:source type="Static">
			  					[
			  					{
									"text": "${ lfn:message('km-oitems:kmOitems.tree.moon.reporting') }",
									"href": "/monthReport",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('km-oitems:kmOitems.tree.receive.report') }",
									"href": "/receiveCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('km-oitems:kmOitems.tree.reporting1') }",
									"href": "/inCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('km-oitems:kmOitems.tree.reporting2') }",
									"href": "/outCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('km-oitems:kmOitems.tree.reporting3') }",
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
				<kmss:authShow roles="ROLE_KMOITEMS_BACKSTAGE_MANAGER">
			        <ui:content title="${ lfn:message('list.otherOpt') }" toggle="true" expand="false" >
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
	<template:replace name="content"> 
	<ui:tabpanel id="kmOitemsPanel" layout="sys.ui.tabpanel.list"  cfg-router="true">
		<ui:content id="kmOitemsContent" title="${ lfn:message('km-oitems:kmOitems.tree.my.all') }" cfg-route="{path:'/listAll'}"> 
		<list:criteria id="applyCriteria">
		    <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
			</list:cri-ref>

			<list:cri-auto modelName="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication"  property="docNumber;docStatus"/>
			<list:cri-criterion title="${ lfn:message('km-oitems:kmOitems.tree.application.type') }" key="fdType" multi="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-oitems:kmOitems.tree.person.application') }', value:'2'},{text:'${ lfn:message('km-oitems:kmOitems.tree.dept.application') }',value:'1'}]
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
			<list:cri-criterion title="${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdApplicantsId') }" expand="false" key="fdApplyPerson">
				<list:box-title>
					<div style="line-height: 30px">${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdApplicantsId') }</div>
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
						<%-- 此处的搜索条件是申请人，对应的orgType=8，但是需要搜索离职人员，因此在“人员”类型基础上，增加“不管是否有效”和“不管是否业务相关”，即：3848（8|768|3072） --%>
						<ui:source type="AjaxJson">
							{url: "/sys/organization/sys_org_element/sysOrgElementCriteria.do?method=criteria${parentId }&searchText=!{searchText}&orgType=3848"}
						</ui:source>
					</list:item-select>
				</list:box-select>	
			</list:cri-criterion>
			<list:cri-criterion title="${ lfn:message('km-oitems:kmOitemsBudgerApplication.creator.dept') }" expand="false" key="docDept">
				<list:box-title>
					<div class="criterion-title-popup-div">
					<ui:menu layout="sys.ui.menu.nav">
						<ui:menu-item text="${ lfn:message('km-oitems:kmOitemsBudgerApplication.creator.dept') }">
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
			
			<list:cri-criterion title="${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdApplicants.deptId') }" expand="false" key="fdApplyDept">
				<list:box-title>
					<div class="criterion-title-popup-div">
					<ui:menu layout="sys.ui.menu.nav">
						<ui:menu-item text="${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdApplicants.deptId') }">
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
			<list:cri-auto modelName="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication"  property="docCreateTime"/>
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
						<list:sort property="docCreateTime" text="${lfn:message('km-oitems:kmOitemsBudgerApplication.docCreateTime') }" group="sort.list" value="down"></list:sort>
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
						<kmss:authShow roles="ROLE_KMOITEMS_BUDGER_CREATE_PERSON">
							<ui:button title="${lfn:message('km-oitems:kmOitems.create.title.person')}" text="${lfn:message('km-oitems:kmOitems.create.title.person')}" onclick="window.moduleAPI.kmOitems.addDoc('person')" order="2"></ui:button>
						</kmss:authShow>
						<kmss:authShow roles="ROLE_KMOITEMS_BUDGER_CREATE_DEPT">
							<ui:button title="${lfn:message('km-oitems:kmOitems.create.title.dept')}" text="${lfn:message('km-oitems:kmOitems.create.title.dept')}" onclick="window.moduleAPI.kmOitems.addDoc('dept')" order="2"></ui:button>		
						</kmss:authShow>
						<kmss:authShow roles="ROLE_KMOITEMS_TRANSPORT_EXPORT">
							<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication')" order="2" ></ui:button>
						</kmss:authShow>				
						<kmss:auth requestURL="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=deleteall" requestMethod="GET">							
							<ui:button text="${lfn:message('button.deleteall')}" onclick="window.moduleAPI.kmOitems.delDoc()" order="4"></ui:button>
						</kmss:auth>
						
					</ui:toolbar>
				</div>
			</div>
		</div>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplicationIndex.do?method=list'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<!-- 测试隐藏 -->
				<%-- <list:col-html  title="${ lfn:message('km-oitems:kmOitemsBudgerApplication.docSubject') }" style="text-align:left">
				 {$ <span class="com_subject" >{%row['docSubject']%}</span> $}
				</list:col-html> --%>
				<list:col-auto ></list:col-auto>
			</list:colTable>
			<list:rowTable isDefault="false"
				rowHref="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=view&fdId=!{fdId}" name="rowtable" >
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
      			Module.install('kmOitems',{
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
 					$search : 'com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication'
  				});
      		});
      	</script>
      	<script type="text/javascript" src="${LUI_ContextPath}/km/oitems/js/index.js"></script>
	</template:replace>
</template:include>
