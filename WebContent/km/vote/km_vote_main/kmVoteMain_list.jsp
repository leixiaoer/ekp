<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include file="/sys/profile/resource/template/list.jsp">
	<%-- 查询栏 --%>
	<template:replace name="content">
		<list:criteria id="criteria1">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<%-- <list:cri-ref ref="criterion.sys.simpleCategory" key="fdVoteCategory"
				multi="false"
				title="${ lfn:message('km-vote:kmVoteMain.category.navigation')}"
				expand="true">
				<list:varParams
					modelName="com.landray.kmss.km.vote.model.KmVoteCategory" />
			</list:cri-ref> --%>
			<list:cri-criterion
				title="${ lfn:message('km-vote:kmVote.kmVoteMain.my')}" key="myvote">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-vote:kmVoteMain.notstart') }', value:'notstart'},
							{text:'${ lfn:message('km-vote:kmVoteMain.end') }',value:'end'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<!-- 投票状态 -->
			<list:cri-criterion
				title="${ lfn:message('km-vote:kmVoteMain.status')}"
				key="fdVoteStatus">
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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left"
						count='4'>
						<list:sortgroup>
							<list:sort property="docCreateTime"
								text="${lfn:message('km-vote:kmVoteCategory.docCreateTime') }"
								group="sort.list" value="down"></list:sort>
							<list:sort property="fdEffectTime"
								text="${lfn:message('km-vote:kmVoteMain.fdEffectTime') }"
								group="sort.list"></list:sort>
							<list:sort property="fdExpireTime"
								text="${lfn:message('km-vote:kmVoteMain.fdExpireTime') }"
								group="sort.list"></list:sort>
							<list:sort property="fdVoteNum"
								text="${lfn:message('km-vote:kmVoteMain.fdVoteNum') }"
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
					<ui:toolbar count='4' style="float:right">
						<!-- 搜素 -->
						<%-- <ui:button text="${lfn:message('button.search')}"
							onclick="Search_Show();"></ui:button> --%>
						<!-- 新增 -->
						<kmss:authShow roles="ROLE_KMVOTEMAIN_CREATE">
							<ui:button text="${lfn:message('km-vote:button.launchedVote')}"
								onclick="addVote()" order="2">
							</ui:button>
						</kmss:authShow>
						<!-- 删除 -->
						<kmss:auth
							requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=deleteall&status=${param.status}&categoryId=${param.categoryId}&nodeType=${param.nodeType}"
							requestMethod="GET">
							<ui:button text="${lfn:message('button.deleteall')}"
								onclick="delVote()" order="4">
							</ui:button>
						</kmss:auth>
						<!-- 分类转移 -->
						<%-- <% 
							if(com.landray.kmss.util.UserUtil.checkRole("ROLE_KMINSTITUTION_OPTALL")) {
								request.setAttribute("authType", "00");
							} 
						%> --%>
						<c:import
							url="/sys/simplecategory/import/doc_cate_change_button.jsp"
							charEncoding="UTF-8">
							<c:param name="modelName"
								value="com.landray.kmss.km.vote.model.KmVoteMain" />
							<c:param name="docFkName" value="fdVoteCategory" />
							<c:param name="cateModelName"
								value="com.landray.kmss.km.vote.model.KmVoteCategory" />
							<%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
							<%-- <c:param name="authType" value="${authType}" /> --%>
						</c:import>
					</ui:toolbar>

				</div>
			</div>
		</div>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&q.fdVoteCategory=${JsParam.categoryId}'}
			</ui:source>
			  <!-- 列表视图 -->	
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/vote/km_vote_main/kmVoteMain.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial> 
				<list:col-html   title="${ lfn:message('km-vote:kmVoteMain.docSubject') }" style="text-align:left;">
				{$ <span class="com_subject">{%row['docSubject']%}</span> $}
				</list:col-html>
				<list:col-auto props="fdVoteCategory;fdVoteNum;docCreator;fdEffectTime;fdExpireTime;fdVoteStatus"></list:col-auto>
			</list:colTable>
		</list:listview> 
		<list:paging></list:paging>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<script type="text/javascript">
			seajs
					.use(
							[ 'lui/jquery', 'lui/dialog', 'lui/topic' ],
							function($, dialog, topic) {
								LUI
										.ready(function() {
											//初始化门户传递的category
											var categoryId = getValueByHash("fdVoteCategory");
											if (categoryId == "") {
												return;
											}
											var hash = window.location.hash;
											if (hash == "") {
												window.location.hash = "cri.q=fdVoteCategory:"
														+ categoryId;
											} else {
												window.location.hash = hash
														+ ";fdVoteCategory:"
														+ categoryId;
											}
										});
								// 监听新建更新等成功后刷新
								topic.subscribe('successReloadPage',
										function() {
											topic.publish('list.refresh');
										});

								//发起投票
								window.addVote = function() {
									dialog
											.simpleCategoryForNewFile(
													'com.landray.kmss.km.vote.model.KmVoteCategory',
													'/km/vote/km_vote_main/kmVoteMain.do?method=add&fdCategoryId=!{id}',
													false,
													null,
													null,
													getValueByHash("fdVoteCategory"));
								};
								//删除
								window.delVote = function() {
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
									dialog
											.confirm(
													'<bean:message key="page.comfirmDelete"/>',
													function(value) {
														if (value == true) {
															window.del_load = dialog
																	.loading();
															$
																	.post(
																			'<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=deleteall"/>&categoryId=${JsParam.categoryId}',
																			$
																					.param(
																							{
																								"List_Selected" : values
																							},
																							true),
																			delCallback,
																			'json');
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

								//根据地址获取key对应的筛选值
								window.getValueByHash = function(key) {
									var hash = window.location.hash;
									var cateId = '${JsParam.categoryId}';
									if (hash.indexOf(key) < 0) {
										if (cateId) {
											return cateId;
										}
										return "";
									}
									var url = hash.split("cri.q=")[1];
									var reg = new RegExp("(^|;)" + key
											+ ":([^;]*)(;|$)");
									var r = url.match(reg);
									if (r != null) {
										return unescape(r[2]);
									}

									if (cateId) {
										return cateId;
									}
									return "";
								};
								window.clearAllValue = function() {
									this.location = "${LUI_ContextPath}/km/vote";
								};
							});
			function List_ConfirmStop(checkName) {
				return List_CheckSelect(checkName)
						&& confirm('<bean:message bundle="km-vote" key="message.terminate.vote.confirm"/>');
			}
			function List_ConfirmStop(checkName) {
				return List_CheckSelect(checkName)
						&& confirm('<bean:message bundle="km-vote" key="message.terminate.vote.confirm"/>');
			}
		</script>
		<!-- 搜索框 -->
		<%-- <c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
			<c:param name="fdModelName"
				value="com.landray.kmss.km.vote.model.KmVoteMain" />
		</c:import> --%>

	</template:replace>
</template:include>