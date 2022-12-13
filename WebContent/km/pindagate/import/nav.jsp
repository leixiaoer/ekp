<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="key" value="${param.key}"/>
<c:set var="criteria" value="${param.criteria}"/>
<%--参与调查--%>
<ui:content title="${ lfn:message('km-pindagate:kmPindagate.tree.participate') }" expand="${param.key != 'participate'?'false':'true' }">
	<ui:combin ref="menu.nav.simple">
		  	<ui:varParam name="source">
		  			<ui:source type="Static">
		  					[{
		  						"text" : "${ lfn:message('km-pindagate:kmPindagate.tree.all') }",
		  						"href" :  "/joinAll",
		  						"router" : true,
			  					"icon" : "lui_iconfont_navleft_pindagate_all"
		  					},{
		  						"text" : "${ lfn:message('km-pindagate:kmPindagate.tree.join.mine') }",
		  						"href" :  "/joinMine",
		  						"router" : true,
			  					"icon" : "lui_iconfont_navleft_com_my_join"
		  					}]
		  			</ui:source>
		  	</ui:varParam>
		</ui:combin>
</ui:content>
<%--问卷设置--%>
<ui:content title="${ lfn:message('km-pindagate:kmPindagate.tree.set') }" expand="${param.key != 'set'?'false':'true' }">
	<ui:combin ref="menu.nav.simple">
		  	<ui:varParam name="source">
		  			<ui:source type="Static">
		  					[{
		  						"text" : "${ lfn:message('km-pindagate:kmPindagate.tree.all') }",
		  						"href" :  "/mydocMine",
		  						"router" : true,
			  					"icon" : "lui_iconfont_navleft_pindagate_all"
		  					},{
		  						"text" : "${ lfn:message('km-pindagate:kmPindagate.tree.create.mine') }",
		  						"href" :  "/mydocCreate",
		  						"router" : true,
			  					"icon" : "lui_iconfont_navleft_com_my_join"
		  					},{
		  						"text" : "${ lfn:message('list.approval') }",
		  						"href" :  "/mydocApproval",
		  						"router" : true,
			  					"icon" : "lui_iconfont_navleft_com_my_beapproval"
		  					},{
		  						"text" : "${ lfn:message('list.approved') }",
		  						"href" :  "/mydocApproved",
		  						"router" : true,
			  					"icon" : "lui_iconfont_navleft_com_my_approvaled"
		  					}]
		  			</ui:source>
		  	</ui:varParam>
		</ui:combin>
</ui:content>
<%--调查结果--%>
<ui:content title="${ lfn:message('km-pindagate:kmPindagate.tree.result') }" expand="${param.key != 'result'?'false':'true' }">
	<ui:combin ref="menu.nav.simple">
		  	<ui:varParam name="source">
		  			<ui:source type="Static">
		  					[{
		  						"text" : "${ lfn:message('km-pindagate:kmPindagate.tree.status.indagating') }",
		  						"href" :  "/indagating",
		  						"router" : true,
			  					"icon" : "lui_iconfont_navleft_pindagate_ing"
		  					},{
		  						"text" : "${ lfn:message('km-pindagate:kmPindagate.tree.status.complete') }",
		  						"href" :  "/complete",
		  						"router" : true,
			  					"icon" : "lui_iconfont_navleft_pindagate_end"
		  					}]
		  			</ui:source>
		  	</ui:varParam>
		</ui:combin>
</ui:content>
<kmss:authShow roles="ROLE_KMPINDAGATE_BACKSTAGE_MANAGER">
<%--后台管理--%>
<ui:content title="${ lfn:message('list.otherOpt') }" expand="${param.key != 'response'?'false':'true' }">
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