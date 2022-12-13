<%@ page import="com.landray.kmss.kms.knowledge.util.KmsKnowledgeConstantUtil"%>
<%@ page import="com.landray.kmss.kms.knowledge.borrow.util.KmsKnowledgeBorrowUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%
    boolean isBorrowOpen = KmsKnowledgeBorrowUtil.checkBorrowOpen(request);
    request.setAttribute("isBorrowOpen", isBorrowOpen);
%>

<%@ page import="com.landray.kmss.kms.category.model.KmsCategoryConfig"%>
<c:set var="kmsKnowledgeIndex" value="${lfn:message('kms-knowledge:kmsKnowledge.index.categoryTrue') }"></c:set>
<c:set var="kmsKnowledgeOverview" value="${lfn:message('kms-knowledge:kmsKnowledge.overview.categoryTrue') }"></c:set>
<c:set var="kmsKnowledgeMyTemplate" value="${lfn:message('kms-knowledge:kmsKnowledge.my.attention.template.categoryTrue') }"></c:set>
<c:choose>
	<c:when test="${not empty param.orderBy  }">
		<c:set var="fdOrderBy" value="kmsKnowledgeBaseDoc.${param.orderBy}" />
	</c:when>
	<c:otherwise>
		<c:set var="fdOrderBy" value="kmsKnowledgeBaseDoc.docPublishTime" />
	</c:otherwise>
</c:choose>

<template:include ref="default.list" spa="true" rwd="true"
	mobileUrl="/kms/knowledge/mobile/#path=0&query=q.docCategory%3A!{docCategory}%3B!{cri.q}">
	<template:replace name="title">${lfn:message('kms-knowledge:module.kms.knowledge') }</template:replace>
	<template:replace name="head">
		<script>
			(function() {

				var toggleView = "${JsParam.toggleView}";
				if (toggleView) {
					var toggleList = [
							"rowtable",
							"gridtable",
							"columntable",
							"attmaintable" ];
					for (var i = 0; i < toggleList.length; i++) {
						if (toggleView === toggleList[i])
							localStorage.setItem("toggle.change", toggleView);
					}
				}

			})();
		</script>
	</template:replace>
	<%-- 当前路径 --%>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams
				modelName="com.landray.kmss.kms.knowledge.model.KmsKnowledgeCategory"
				moduleTitle="${lfn:message('kms-knowledge:module.kms.knowledge') }"
				extkey="mydoc;docStatus;type" />

		</ui:combin>
	</template:replace>
	<%-- 左边栏 --%>
	<template:replace name="nav">

		<ui:combin ref="menu.nav.title">
			<ui:varParam name="infonew">
				<ui:source type="AjaxJson">
					{url:'/kms/knowledge/kms_knowledge_ui/info.jsp'}
				</ui:source>
			</ui:varParam>
			<ui:varParam name="operation">
				<ui:source type="AjaxJson">
					{url:'/kms/knowledge/kms_knowledge_ui/operation.jsp'}
				</ui:source>
			</ui:varParam>
		</ui:combin>

		<div class="lui_list_nav_frame">
			<ui:accordionpanel>

				<%-- 历史中心 --%>
				<ui:content title="${lfn:message('kms-knowledge:kmsKnowledge.readHistory') }">
					<ui:combin ref="menu.nav.simple">
						<ui:varParam name="source">
							<ui:source type="Static">
			  					[
					  				{
					  					"text" : "${lfn:message('kms-knowledge:kmsKnowledge.my.readHistory') }",
										"href" :  "/readInfo",
										"router" : true,
										"icon" : "lui_iconfont_navleft_archives_borrow"
					  				}
				  				]
  							</ui:source>
						</ui:varParam>
					</ui:combin>
				</ui:content>

				<%-- 常用分类 --%>
				<ui:combin ref="menu.nav.favorite.category">
					<ui:varParams
						modelName="com.landray.kmss.kms.knowledge.model.KmsKnowledgeCategory" />
					<ui:varParams
						title="${kmsKnowledgeMyTemplate}"/>
				</ui:combin>

				<%-- 分类索引 --%>
				<ui:content
					title="${kmsKnowledgeIndex}">

					<ui:combin ref="menu.nav.simplecategory.flat.all" >
						<ui:varParams
							modelName="com.landray.kmss.kms.knowledge.model.KmsKnowledgeCategory" />
						<ui:varParams
							isHasSearch="true" />
					</ui:combin>

					<ui:operation
						href="/sys/sc/categoryPreivew.do?method=forward&service=kmsKnowledgeCategoryPreManagerService"
						name="${kmsKnowledgeOverview}"
						target="_rIframe" vertical="top" />

				</ui:content>

				<%-- 后台配置 --%>
					<ui:content title="${ lfn:message('list.otherOpt')}">
						<kmss:authShow roles="ROLE_KMSKNOWLEDGE_BACKSTAGE_MANAGER">
							<ui:combin ref="menu.nav.simple">
								<ui:varParam name="source">
									<ui:source type="Static">
					  					[
					  				<kmss:auth requestURL="/sys/recycle/import/sysRecycle_index.jsp" requestMethod="GET">
					  					<% if(com.landray.kmss.sys.recycle.util.SysRecycleUtil.isEnableSoftDelete("com.landray.kmss.kms.wiki.model.KmsWikiMain")){ %>
										<kmss:ifModuleExist path="/kms/wiki/"><c:set value="com.landray.kmss.kms.wiki.model.KmsWikiMain" var="wiki"></c:set> </kmss:ifModuleExist>
										<% } %>
										<% if(com.landray.kmss.sys.recycle.util.SysRecycleUtil.isEnableSoftDelete("com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge")){%>
										<kmss:ifModuleExist path="/kms/multidoc/"><c:set value="com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge" var="multidoc"></c:set> </kmss:ifModuleExist>
										<% } %>
										<c:if test="${ not empty wiki || not empty multidoc}">
					  					{
						  					"text" : "${ lfn:message('sys-recycle:module.sys.recycle') }",
											"href" :  "/recover",
											"router" : true,
						  					"icon" : "lui_iconfont_navleft_com_recycle"
						  				}
						  				,
						  				</c:if>
						  			</kmss:auth>
						  				{
						  					"text" : "${ lfn:message('list.manager') }",
											"href":"/management",
											"router":true,
						  					"icon" : "lui_iconfont_navleft_com_background"
						  				}
						  				]
		  							</ui:source>
								</ui:varParam>
							</ui:combin>
						</kmss:authShow>
					</ui:content>

			</ui:accordionpanel>
		</div>
	</template:replace>
	<%-- 右边栏 --%>
	<template:replace name="content">
		<list:criteria>

			<%
				Map map = KmsKnowledgeConstantUtil.getKnowledgeModelNames();
							if (map != null && map.size() == 2) {
			%>
			<list:cri-criterion
				title="${lfn:message('kms-knowledge:kmsKnowledgeCategory.fdTemplateType') }"
				key="template" expand="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
				[{text:'${ lfn:message('kms-knowledge:title.kms.multidoc') }', value:'1'},
				{text:'${ lfn:message('kms-knowledge:title.kms.wiki') }',value:'2'}]
			</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<%
				}
			%>

			<%@ include file="./kmsKnowledge_index_cri_include.jsp"%>
		</list:criteria>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>

		<%-- 按钮 --%>
		<div class="lui_list_operation">

			<div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
				<div style="display: inline-block;">
					<label>
						<input type="checkbox" name="introduce">
						${lfn:message('kms-knowledge:kmsKnowledge.portlet.essential') }
					</label>
				</div>
			</div>
			<!-- 分割线 -->
			<div class="lui_list_operation_line"></div>

			<div class="lui_list_operation_sort_btn">
				<div class="lui_list_operation_order_text">
					${ lfn:message('list.orderType') }：
				</div>
				<div class="lui_list_operation_sort_toolbar">
					<ui:toolbar layout="sys.ui.toolbar.sort">
						<list:sortgroup>
							<c:choose>
								<c:when test="${ param.orderBy=='fdTotalCount'}">
									<list:sort property="kmsKnowledgeBaseDoc.docPublishTime"
										text="${lfn:message('kms-knowledge:kmsKnowledge.docPublishTime') }"
										group="sort.list" />
									<list:sort property="kmsKnowledgeBaseDoc.fdTotalCount"
										text="${lfn:message('kms-knowledge:kmsKnowledge.readCount') }"
										group="sort.list" value="down" />
									<list:sort property="kmsKnowledgeBaseDoc.docIntrCount"
										text="${lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.docIntrCount.num') }"
										group="sort.list" />
									<list:sort property="kmsKnowledgeBaseDoc.docEvalCount"
										text="${lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.docEvalCount.num') }"
										group="sort.list" />
									<list:sort property="kmsKnowledgeBaseDoc.docScore"
										text="${lfn:message('kms-knowledge:kmsKnowledge.score') }"
										group="sort.list" />
									<list:sort property="kmsKnowledgeBaseDoc.docSubject"
                                        text="${lfn:message('kms-knowledge:kmsKnowledge.docSubject.small') }"
                                        group="sort.list" />
								</c:when>
								<c:otherwise>

									<list:sort property="kmsKnowledgeBaseDoc.docPublishTime"
										text="${lfn:message('kms-knowledge:kmsKnowledge.docPublishTime') }"
										group="sort.list" value="down" />
									<list:sort property="kmsKnowledgeBaseDoc.fdTotalCount"
										text="${lfn:message('kms-knowledge:kmsKnowledge.readCount') }"
										group="sort.list" />
									<list:sort property="kmsKnowledgeBaseDoc.docIntrCount"
										text="${lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.docIntrCount.num') }"
										group="sort.list" />
									<list:sort property="kmsKnowledgeBaseDoc.docEvalCount"
										text="${lfn:message('kms-knowledge:kmsKnowledgeBaseDoc.docEvalCount.num') }"
										group="sort.list" />
									<list:sort property="kmsKnowledgeBaseDoc.docScore"
										text="${lfn:message('kms-knowledge:kmsKnowledge.score') }"
										group="sort.list" />
									<list:sort property="kmsKnowledgeBaseDoc.docSubject"
                                        text="${lfn:message('kms-knowledge:kmsKnowledge.docSubject.small') }"
                                        group="sort.list" />
								</c:otherwise>
							</c:choose>

						</list:sortgroup>
					</ui:toolbar>
				</div>

			</div>

			<div class="lui_list_operation_page_top">
				<list:paging layout="sys.ui.paging.top">
				</list:paging>
			</div>

			<div class="lui_list_operation_toolbar">
				<ui:toolbar count="3" id="Btntoolbar">
					<ui:togglegroup order="0">
						<ui:toggle icon="lui_icon_s_zaiyao"
							title="${ lfn:message('list.rowTable') }" selected="true"
							group="tg_1" value="rowtable"
							text="${ lfn:message('list.rowTable') }"
							onclick="LUI('listview').switchType(this.value);LUI('fileType').setEnable(false);">
						</ui:toggle>
						<ui:toggle icon="lui_icon_s_tuwen"
							title="${lfn:message('list.gridTable') }" group="tg_1"
							value="gridtable" text="${lfn:message('list.gridTable') }"
							onclick="LUI('listview').switchType(this.value);LUI('fileType').setEnable(false);">
						</ui:toggle>
						<ui:toggle icon="lui_icon_s_liebiao"
							title="${ lfn:message('list.columnTable') }" group="tg_1"
							value="columntable" text="${ lfn:message('list.columnTable') }"
							onclick="LUI('listview').switchType(this.value);LUI('fileType').setEnable(false);">
						</ui:toggle>
						<ui:toggle icon="lui_icon_s_fujian"
							title="${ lfn:message('kms-knowledge:kmsKnowledge.att')}"
							group="tg_1" value="attmaintable"
							text="${lfn:message('kms-knowledge:kmsKnowledge.att')}"
							onclick="LUI('listview').switchType(this.value);LUI('fileType').setEnable(true);">
						</ui:toggle>
					</ui:togglegroup>

					<%-- 新增删除属性修改--%>
					<%@include file="./kmsKnowledge_button.jsp"%>

				</ui:toolbar>
			</div>
		</div>

		<%--列表视图  --%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDocIndex.do?method=listChildren&docIsIntroduced=${docIsIntroduced}&docIsIndexTop=!{docIsIndexTop}&orderby=${fdOrderBy}&ordertype=down&categoryId=!{docCategory}'}
			</ui:source>

			<%-- 摘要视图--%>
			<list:rowTable layout="sys.ui.listview.rowtable" name="rowtable"
				onRowClick=""
				rowHref="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=view&fdId=!{fdId}&fdKnowledgeType=!{fdKnowledgeType}"
				style="" target="_blank">
				<list:row-template ref="kms.knowledge.listview.rowtable">
				{
					showOtherProps:"fdTotalCount;docIntrCount;docEvalCount;docScore;docBorrowFlagName"
				}
				</list:row-template>
			</list:rowTable>

			<%-- 列表视图--%>
			<list:colTable layout="sys.ui.listview.columntable"
				name="columntable"
				rowHref="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=view&fdId=!{fdId}&fdKnowledgeType=!{fdKnowledgeType}">
				<%@ include
					file="/kms/knowledge/kms_knowledge_ui/kmsKnowledge_col_tmpl.jsp"%>
			</list:colTable>
			<%-- 视图列表 --%>
			<list:gridTable name="gridtable" columnNum="4"
				gridHref="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=view&fdId=!{fdId}&fdKnowledgeType=!{fdKnowledgeType}">
				<ui:source type="AjaxJson">
					{url:'/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDocIndex.do?method=listChildren&docIsIntroduced=${docIsIntroduced}&orderby=${fdOrderBy}&ordertype=down&dataType=pic&rowsize=12&categoryId=!{docCategory}&showRead=fdTotalCount'}
				</ui:source>
				<list:row-template ref="kms.knowledge.listview.landrayblue">
				</list:row-template>
			</list:gridTable>

			<%-- 附件视图--%>
			<list:colTable layout="sys.ui.listview.columntable"
				name="attmaintable"
				rowHref="/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDoc.do?method=view&fdId=!{fdId}&fdKnowledgeType=!{fdKnowledgeType}">
				<ui:source type="AjaxJson">
					{url:'/kms/knowledge/kms_knowledge_base_doc/kmsKnowledgeBaseDocIndex.do?method=getSysAttList&orderby=${fdOrderBy}&categoryId=!{docCategory}'}
				</ui:source>
				<list:col-checkbox name="List_Selected" style="width:5%"></list:col-checkbox>
				<list:col-serial title="${ lfn:message('page.serial') }"
					headerStyle="width:5%"></list:col-serial>
				<list:col-html
					title="${lfn:message('kms-knowledge:kmsKnowledge.attName')}"
					styleClass="lui_knowledge_attName">
					{$
						<img
						src="${KMSS_Parameter_ResPath}style/common/fileIcon/{% GetIconNameByFileName(row['attName']) %}" />
					<span class="com_subject">{%row['attName']%}</span>
					$}
				</list:col-html>
				<list:col-html
					title="${lfn:message('kms-knowledge:kmsKnowledge.uploader')}">
					{$
						<span class="com_author">{%row['attCreator']%}</span>
					$}
				</list:col-html>
				<list:col-auto props="attSize;uploadTime"></list:col-auto>
				<list:col-html
					title="${lfn:message('kms-knowledge:kmsKnowledge.docSubject')}"
					styleClass="lui_knnowledge_subject">
					{$
						<span class="com_subject">{%row['docSubject']%}</span>
					$}
				</list:col-html>
                <c:if test="${isBorrowOpen}">
					 <list:col-html title="${ lfn:message('kms-knowledge-borrow:kmsKnowledgeBorrow.readStatus')}">
					 	{$
					 		{%row['docBorrowFlagName']%}
					 	$}
					 </list:col-html>
				</c:if>
				<list:col-html style="width:10%">
					{$
						<a class="lui_knowledge_download"
						href="javascript:downloadAttAndLog('{%row['attId']%}');" />
					$}
				</list:col-html>
			</list:colTable>
			<!-- 知识仓库取消推荐用 -->
			<ui:event topic="list.loaded" args="vt">
				var datas = vt.table.kvData;
				window.datas = datas;

                // “待我审”、“我已审”、“我的草稿”去掉“借阅”按钮
                setTimeout(function () {
                    checkBorrowBtn();
                }, 500);

                function checkBorrowBtn(){
                    $(".lui_widget_btn_txt").each(function(){
                        if($(this).text() == "${lfn:message('kms-knowledge:kms.knowledge.borrow')}"){
                            if(window.location.href.indexOf("mydoc=approval") > -1 ||
                                window.location.href.indexOf("mydoc=approved") > -1  ||
                                window.location.href.indexOf("myDraft=myDraft") > -1){
                                $(this).parent().parent().parent().parent().parent().hide();
                            }else{
                                var isAuth = false;
                                // console.log("len=>", vt.table._data.datas.length)

								// datas.length有缓存不准确
	                            if(vt.table._data.datas.length > 0 && datas[0]["borrowOpenFlag"] == "true"){
	                                isAuth = true;
	                            }
	                            // console.log("isAuth=>" + isAuth);
                                if(isAuth){
                                    $(this).parent().parent().parent().parent().show();
                                    $(this).parent().parent().parent().parent().parent().show();
                                }else{
                                    $(this).parent().parent().parent().parent().hide();
                                    $(this).parent().parent().parent().parent().parent().hide();
                                }
                            }
                        }
                    });
                }
			</ui:event>
		</list:listview>
		<%-- 列表分页 --%>
		<list:paging></list:paging>

	</template:replace>

	<template:replace name="script">
		<script>
			seajs.use('kms/knowledge/kms_knowledge_ui/style/index.css');

			seajs.use('kms/knowledge/kms_knowledge_ui/js/button');
			seajs.use('kms/knowledge/kms_knowledge_ui/js/subscribe');

			Com_IncludeFile("fileIcon.js", Com_Parameter.ResPath
					+ "style/common/fileIcon/", "js", true);

			Com_IncludeFile("calendar.js");
		</script>
	</template:replace>
</template:include>