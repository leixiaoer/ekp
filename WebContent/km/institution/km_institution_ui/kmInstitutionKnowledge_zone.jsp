<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="TA" value="${param.zone_TA}"/>
<c:set var="userId" value="${(empty param.userId)?KMSS_Parameter_CurrentUserId:(param.userId)}"/>
<template:include ref="zone.navlink">
	<%-- 标签页标题 --%>
	<template:replace name="title">
		<c:out value="${ lfn:message('km-institution:module.km.institution') }"></c:out>
	</template:replace>
	<%-- 右侧页面 --%>
	<template:replace name="content">  
	<list:criteria id="criteria1" expand="true">
		    <list:cri-criterion title="${lfn:message(lfn:concat('km-institution:kmInstitution.tree.title.',TA))}" key="taInstitution" multi="false">
				<list:box-select>
					<list:item-select cfg-defaultValue="create" cfg-required="true">
						<ui:source type="Static">
						    [{text:'${lfn:message(lfn:concat('km-institution:kmInstitution.tree.title.Create.', TA))}', value:'create'}
							]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${lfn:message('km-institution:kmInstitution.status')}" key="docStatus" > 
				<list:box-select>
					<list:item-select id="docStatus1" cfg-enable="true">
						<ui:source type="Static">
							  [{text:'${ lfn:message('status.draft') }',value:'10'},
								{text:'${ lfn:message('status.examine') }', value: '20'},
								{text:'${ lfn:message('status.refuse') }',value:'11'},
								{text:'${ lfn:message('status.discard') }',value:'00'},
								{text:'${ lfn:message('status.publish') }',value:'30'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-criterion title="${lfn:message('km-institution:kmInstitution.status')}" key="docStatus" > 
				<list:box-select>
					 <list:item-select id="docStatus2" cfg-enable="false">
								<ui:source type="Static">
									[{text:'${ lfn:message('status.examine') }', value: '20'},
									{text:'${ lfn:message('status.refuse') }',value:'11'},
									{text:'${ lfn:message('status.discard') }',value:'00'},
									{text:'${ lfn:message('status.publish') }',value:'30'}]
								</ui:source>
				   </list:item-select>	
				</list:box-select>
			</list:cri-criterion>
			
		</list:criteria>
		<%-- 操作栏 --%>
		<div class="lui_list_operation">
			<table width="100%">
				<tr>
					<td style="width:65px;">${ lfn:message('list.orderType') }：</td>
					<td>
						<%-- 提供按发布时间排序 --%>
						<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left"  count="4">
							<list:sortgroup>
								<list:sort property="docPublishTime" text="${lfn:message('km-institution:kmInstitution.docPublishTime') }" group="sort.list" value="down"></list:sort>
								<list:sort property="docCreateTime" text="${lfn:message('km-institution:kmInstitutionKnowledge.docCreateTime') }" group="sort.list"></list:sort>
								<list:sort property="fdNumber" text="${lfn:message('km-institution:kmInstitution.fdNumber') }" group="sort.list"></list:sort>
							</list:sortgroup>
						</ui:toolbar>
					</td>
					<td align="right">
						<ui:toolbar id="toolbar" count="3">
							<%-- 视图选择 --%>	
							<ui:togglegroup order="0">
								<ui:toggle icon="lui_icon_s_zaiyao" title="${ lfn:message('list.rowTable') }" 
									group="tg_1" text="${ lfn:message('list.rowTable') }" value="rowtable" selected="true"
									onclick="LUI('listview').switchType(this.value);">
								</ui:toggle>
								<ui:toggle icon="lui_icon_s_liebiao" title="${ lfn:message('list.columnTable') }" 
									value="columntable"	 group="tg_1" text="${ lfn:message('list.columnTable') }" 
									onclick="LUI('listview').switchType(this.value);">
								</ui:toggle>
							</ui:togglegroup>
							<%-- 收藏 --%>
							<c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
								<c:param name="fdTitleProName" value="docSubject" />
								<c:param name="fdModelName"	value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
							</c:import>
						</ui:toolbar>
					</td>
				</tr>
			</table>
		</div>	
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 <%--list页面--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&categoryId=${JsParam.categoryId}&type=zone&userId=${userId}'}
			</ui:source>
			<%--列表视图--%>
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<%-- <list:col-html title="${ lfn:message('km-institution:kmInstitution.docSubject') }" style="text-align:left">
				{$ <span class="com_subject" >{%row['docSubject']%}</span> $}
				</list:col-html> --%>
				<list:col-auto props="fdNumber;docStatus;docDept.fdName;docCreator;docPublishTime" ></list:col-auto>
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
							<span>${lfn:message('sys-doc:sysDocBaseInfo.docPublishTime') }：{%row['docPublishTime']%}</span>
							<span>{%row['fdTagNames']%}</span>
						</dd>
					</dl>
			     </div>		
				$}
				</list:row-template>
			</list:rowTable>
		</list:listview> 
	 	<list:paging></list:paging>	 
	</template:replace>
</template:include>
