<%@ page language="java" pageEncoding="UTF-8"%>
		<!-- 筛选 -->
        <list:criteria id="criteria1">
            <list:cri-ref key="fdDeptId" ref="criterion.sys.docSubject" title="${lfn:message('geesun-org:geesunOrgOrgan.fdDeptId')}" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgOrgan" property="fdDeptName" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgOrgan" property="fdParentId" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgOrgan" property="fdSetupDate" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgOrgan" property="fdIsDel" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgOrgan" property="fdNewDate" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgOrgan" property="docCreateTime" />

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
                            <list:sort property="geesunOrgOrgan.fdNewDate" text="${lfn:message('geesun-org:geesunOrgOrgan.fdNewDate')}" group="sort.list" value="down" />
                            <list:sort property="geesunOrgOrgan.docCreateTime" text="${lfn:message('geesun-org:geesunOrgOrgan.docCreateTime')}" group="sort.list" value="down" />
                        </ui:toolbar>
					</td>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
	 	<list:listview cfg-criteriaInit="${empty param.categoryId?'false':'true'}">
			<ui:source type="AjaxJson">
                {url:'/geesun/org/geesun_org_organ/geesunOrgOrgan.do?method=data'}
            </ui:source>
			<!-- 列表视图 -->
            <list:colTable isDefault="false" rowHref="/geesun/org/geesun_org_organ/geesunOrgOrgan.do?method=view&fdId=!{fdId}" name="columntable">
                <list:col-checkbox />
                <list:col-serial/>
                <list:col-auto props="fdDeptId;fdDeptName;fdParentId;fdSetupDate;fdIsDel;fdNewDate;docCreateTime" url="" />
            </list:colTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>		 	
