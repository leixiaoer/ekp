<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.list" spa="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
	</template:replace>
	<template:replace name="nav">
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('km-carmng:module.km.carmng') }" />
			<ui:varParam name="button">
				[
					{
						"text": "",
						"href": "javascript:void(0)'",
						"icon": "km_carmng"
					}
				]
			</ui:varParam>
		</ui:combin>
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
				<ui:content title="${ lfn:message('km-carmng:table.kmCarmngApplication') }">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
		  					<kmss:authShow roles="ROLE_KMCARMNG_CALENDAR">
		  					{
								"text": "${ lfn:message('km-carmng:kmCarmng.calendar') }",
								"href": "/useCarCalendar",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_calendar"
							},
							</kmss:authShow>
		  					{
								"text": "${ lfn:message('km-carmng:kmCarmng.use.all') }",
								"href": "/listAll",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_all"
							},
							{
								"text": "${ lfn:message('km-carmng:kmCarmng.tree.my.submit') }",
								"href": "/listCreate",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_drafted"
							},
							{
								"text": "${ lfn:message('km-carmng:kmCarmng.tree.my.approval') }",
								"href": "/listApproval",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_beapproval"
							},
							{
								"text": "${ lfn:message('km-carmng:kmCarmng.tree.my.approved') }",
								"href": "/listApproved",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_my_approvaled"
							}
							<kmss:authShow roles="ROLE_KMCARMNG_USECARQUERY">,
							{
								"text": "${ lfn:message('km-carmng:kmCarmng.tree.dispatcher3') }",
								"href": "/listUse",
								"router" : true,
								"icon": "lui_iconfont_navleft_com_query"
							}
							</kmss:authShow>
							]
		  					</ui:source>
		  				</ui:varParam>
	  				</ui:combin>
				</ui:content>
				<kmss:authShow roles="ROLE_KMCARMNG_CARMANAGE">
					<ui:content title="${ lfn:message('km-carmng:kmCarmng.tree.car.information') }">
						<ui:combin ref="menu.nav.simple">
			  				<ui:varParam name="source">
			  					<ui:source type="Static">
			  					[
			  					{
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.car.information3') }",
									"href": "/infringeInfo",
									"router" : true,
									"icon": "lui_iconfont_navleft_carmng_illegal"
								},
								{
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.car.information4') }",
									"href": "/insuranceInfo",
									"router" : true,
									"icon": "lui_iconfont_navleft_carmng_Insurance"
								},
								{
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.car.information5') }",
									"href": "/maintenanceInfo",
									"router" : true,
									"icon": "lui_iconfont_navleft_carmng_maintain"
								}
								]
			  					</ui:source>
			  				</ui:varParam>
		  				</ui:combin>
					</ui:content>
				</kmss:authShow>
				<kmss:authShow roles="ROLE_KMCARMNG_MOTORCADE_ATTEMPER;ROLE_KMCARMNG_ATTEMPER;ROLE_KMCARMNG_EVALUATION">
					<ui:content title="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher') }" expand="true">
						<ui:combin ref="menu.nav.simple">
			  				<ui:varParam name="source">
			  					<ui:source type="Static">
			  					[
			  					{
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.dispatcher4') }",
									"href": "/rescalendar",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_calendar"
								}
								<kmss:authShow roles="ROLE_KMCARMNG_MOTORCADE_ATTEMPER;ROLE_KMCARMNG_ATTEMPER">
								,{
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.dispatcher1') }",
									"href": "/listByDispatchers",
									"router" : true,
									"icon": "lui_iconfont_navleft_carmng_dispatch"
								},
								{
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.dispatcher2') }",
									"href": "/dispatchersInfo",
									"router" : true,
									"icon": "lui_iconfont_navleft_carmng_dispatchinfo"
								}
								</kmss:authShow>
								<kmss:authShow roles="ROLE_KMCARMNG_EVALUATION">
								,{
									"text": "${ lfn:message('km-carmng:table.kmCarmngEvaluation') }",
									"href": "/evaluation",
									"router" : true,
									"icon": "lui_iconfont_navleft_carmng_satisfaction"
								}
								</kmss:authShow>
								]
			  					</ui:source>
			  				</ui:varParam>
		  				</ui:combin>
					</ui:content>
				</kmss:authShow>
				<kmss:authShow roles="ROLE_KMCARMNG_CHARGESTAT">
					<ui:content title="${ lfn:message('km-carmng:kmCarmng.tree.fee.count') }" expand="true">
						<ui:combin ref="menu.nav.simple">
			  				<ui:varParam name="source">
			  					<ui:source type="Static">
			  					[
			  					<%-- {
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.fee.count1') }",
									"href": "/UserFeeInfoCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								}, --%>
								{
									"text": "${lfn:message('km-carmng:kmCarmng.excel.exportCarUseExcel') }",
									"href": "/CarUseCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${lfn:message('km-carmng:kmCarmng.excel.exportCarUseExcel.dept') }",
									"href": "/DeptCarCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${lfn:message('km-carmng:kmCarmng.excel.exportCarUseExcel.person') }",
									"href": "/PersonCarCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${lfn:message('km-carmng:kmCarmng.excel.exportQueryDriverExcel') }",
									"href": "/DriverCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${lfn:message('km-carmng:kmCarmng.excel.exportQueryCarFeeExcel') }",
									"href": "/CarFeeCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.fee.count2') }",
									"href": "/MaintenanceInfoCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								},
								{
									"text": "${ lfn:message('km-carmng:kmCarmng.tree.fee.count3') }",
									"href": "/InfringeInfoCount",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_statistics"
								}
								]
			  					</ui:source>
			  				</ui:varParam>
		  				</ui:combin>
					</ui:content>
				</kmss:authShow>
				<kmss:authShow roles="ROLE_KMCARMNG_BACKSTAGE_MANAGER">
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
		<!-- 筛选器 -->
		<ui:tabpanel id="kmCarmngPanel" layout="sys.ui.tabpanel.list"  cfg-router="true">
		<ui:content id="kmCarmngContent" title="${ lfn:message('km-carmng:kmCarmng.use.all') }" cfg-route="{path:'/listAll'}"> 
		<list:criteria id="criteria1">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${ lfn:message('km-carmng:kmCarmngApplication.docSubject')}">
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.km.carmng.model.KmCarmngApplication" property="fdNo"/>
			<list:cri-criterion title="${ lfn:message('km-carmng:kmCarmng.use.status')}" key="docStatus"> 
				<list:box-select>
					<list:item-select >
						<ui:source type="Static">
							[{text:'${ lfn:message('km-carmng:kmCarmng.tree.draft')}', value:'10'},
							{text:'${ lfn:message('km-carmng:kmCarmng.tree.wait')}',value:'20'},
							{text:'${ lfn:message('km-carmng:kmCarmng.tree.refuse')}',value:'11'},
							{text:'${ lfn:message('km-carmng:kmCarmng.tree.discard')}',value:'00'},
							{text:'${ lfn:message('km-carmng:kmCarmng.tree.publish')}',value:'30'},
							{text:'${ lfn:message('km-carmng:kmCarmng.tree.publish2')}',value:'31'},
							{text:'${ lfn:message('km-carmng:kmCarmng.tree.publish3')}',value:'32'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-auto modelName="com.landray.kmss.km.carmng.model.KmCarmngApplication" 
				property="fdApplicationPerson;fdApplicationDept;docCreateTime;fdStartTime;fdEndTime" />
		</list:criteria>
		<%@ include file="/km/carmng/km_carmng_ui/kmCarmngApplication_listview.jsp" %>
		</ui:content>
		</ui:tabpanel>
	</template:replace> 
	<template:replace name="script">
   		<%-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 --%>
      	<script type="text/javascript">
      		seajs.use(['lui/framework/module'],function(Module){
      			Module.install('kmCarmng',{
					//模块变量
					$var : {},
 					//模块多语言
 					$lang : {},
 					//搜索标识符
 					$search : 'com.landray.kmss.km.carmng.model.KmCarmngApplication'
  				});
      		});
      	</script>
      	<script type="text/javascript" src="${LUI_ContextPath}/km/carmng/resource/js/index.js"></script>
	</template:replace>
</template:include>
