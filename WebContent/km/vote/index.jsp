<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.list" spa="true" rwd="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-vote:module.km.vote') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script>
		seajs.use(['lui/jquery'], function($){
			
			window.getFromHash = function(key){
	 			var params = window.location.hash ? window.location.hash.substr(1)
	 					.split("&") : [], paramsObject = {};
	 			for (var i = 0; i < params.length; i++) {
	 				if (!params[i])
	 					continue;
	 				var a = params[i].split("=");
	 				if(a[0] == key){
	 					return decodeURIComponent(a[1]);
	 				}
	 			}
	 			return "";
	 		};
			
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
		});
		</script>	
	</template:replace>
<!--	所有分类-->
	<template:replace name="nav">
		<ui:combin ref="menu.nav.create">
			<ui:varParam name="title" value="${ lfn:message('km-vote:module.km.vote') }" />
			<ui:varParam name="button">
					[{
						"text": "",
						"href": "javascript:void(0)'",
						"icon": "km_vote"
					}]
			</ui:varParam>
		</ui:combin>
		
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
				<ui:content title="${ lfn:message('list.search') }">
					<ui:combin ref="menu.nav.simple">
		  				<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
			  				{
			  					"text" : "${ lfn:message('km-vote:kmVoteMain.all') }",
								"href" :  "/all",
								"router" : true,  					
			  					"icon" : "lui_iconfont_navleft_vote_all"
			  				},{
			  					"text" : "${ lfn:message('km-vote:kmVoteMain.notstart') }",
								"href" :  "/notstart",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_vote_my_crteat"
			  				},{
			  					"text" : "${ lfn:message('km-vote:kmVoteMain.end') }",
								"href" :  "/end",
								"router" : true,		  					
			  					"icon" : "lui_iconfont_navleft_vote_my_vote"
			  				}]
		  					</ui:source>
		  				</ui:varParam>
		  			</ui:combin>
				</ui:content>
				<kmss:authShow roles="ROLE_KMVOTEMAIN_BACKSTAGE_MANAGER">
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
	
	<template:replace name="content">
		<ui:tabpanel id="kmVotePanel" layout="sys.ui.tabpanel.list" cfg-router="true">
		<ui:content id="kmVoteContent" title="${ lfn:message('km-vote:kmVoteMain.all') }">
		<list:criteria id="criteria1">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
			</list:cri-ref>
		<%-- --%>
			<list:cri-ref ref="criterion.sys.simpleCategory" key="fdVoteCategory" multi="false" title="${ lfn:message('km-vote:kmVoteMain.category.navigation')}">
			  <list:varParams modelName="com.landray.kmss.km.vote.model.KmVoteCategory"/>
			</list:cri-ref>
				
			<%-- <list:cri-criterion title="${ lfn:message('km-vote:kmVote.kmVoteMain.my')}" key="myvote">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-vote:kmVoteMain.notstart') }', value:'notstart'},
							{text:'${ lfn:message('km-vote:kmVoteMain.end') }',value:'end'}]
						</ui:source>
					</list:item-select>
				</list:box-select> 
			</list:cri-criterion> --%>
			<!-- 投票状态 -->
			<list:cri-criterion title="${ lfn:message('km-vote:kmVoteMain.status')}" key="fdVoteStatus"> 
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-vote:kmVoteMain.Status.draft')}', value:'10'},
							
							{text:'${ lfn:message('km-vote:kmVoteMain.Status.started')}',value:'0'},
							{text:'${ lfn:message('km-vote:kmVoteMain.Status.ended')}',value:'2'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<!-- 发起者 -->
			<list:cri-auto modelName="com.landray.kmss.km.vote.model.KmVoteMain" 
				property="docCreator;docCreateTime" />
			<%if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
				<list:cri-auto modelName="com.landray.kmss.km.vote.model.KmVoteMain" property="authArea"/>
			<%} %>
		</list:criteria> 
		
		<%@ include file="/km/vote/km_vote_ui/kmVoteMain_listview.jsp" %>
		</ui:content>
		</ui:tabpanel>
	</template:replace>
	<template:replace name="script">
		<!-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 -->
		<script type="text/javascript">
			seajs.use(['lui/framework/module'],function(Module){
				Module.install('kmVote',{
					//模块变量
					$var : {},
					//模块多语言
					$lang : {
						'all' : '${ lfn:message("km-vote:kmVoteMain.all") }',
						'notstart' : '${ lfn:message("km-vote:kmVoteMain.notstart") }',
						'end' : '${ lfn:message("km-vote:kmVoteMain.end") }'
					},
					//搜索标识符
					$search : ''
				});
			});
		</script>
		<!-- 引入JS -->
		<script type="text/javascript" src="${LUI_ContextPath}/km/vote/resource/js/index.js"></script>
	</template:replace>
</template:include>