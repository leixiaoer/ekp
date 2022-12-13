<%@ page language="java" pageEncoding="UTF-8"%>
		<!-- 查询条件  -->
		<list:criteria id="criteria1">
           <list:cri-ref key="fdPostId" ref="criterion.sys.docSubject" title="${lfn:message('geesun-org:geesunOrgPost.fdPostId')}" />
           <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPost" property="fdPostName" />
           <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPost" property="fdParentId" />
           <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPost" property="fdPostNo" />
           <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPost" property="fdQidongDate" />
           <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPost" property="fdNewDate" />
           <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPost" property="docCreateTime" />

       </list:criteria>
		 
		<!-- 列表工具栏 -->
		<div class="lui_list_operation">
			<table width="100%">
				<tr>
					<td style='width: 60px;'>
						${ lfn:message('list.orderType') }：
					</td>
					<td>
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="geesunOrgPost.fdNewDate" text="${lfn:message('geesun-org:geesunOrgPost.fdNewDate')}" group="sort.list" value="down" />
                            <list:sort property="geesunOrgPost.docCreateTime" text="${lfn:message('geesun-org:geesunOrgPost.docCreateTime')}" group="sort.list" value="down" />
                        </ui:toolbar>
					</td>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
	 	<list:listview cfg-criteriaInit="${empty param.categoryId?'false':'true'}">
			<ui:source type="AjaxJson">
                {url:'/geesun/org/geesun_org_post/geesunOrgPost.do?method=data'}
            </ui:source>
            <!-- 列表视图 -->
            <list:colTable isDefault="false" rowHref="/geesun/org/geesun_org_post/geesunOrgPost.do?method=view&fdId=!{fdId}" name="columntable">
                <list:col-checkbox />
                <list:col-serial/>
                <list:col-auto props="fdPostId;fdPostName;fdParentId;fdPostNo;fdQidongDate;fdNewDate;docCreateTime" url="" />
            </list:colTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>		 	
