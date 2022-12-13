<%@ page language="java" pageEncoding="UTF-8"%>
		<!-- 查询条件  -->
        <list:criteria id="criteria1">
            <list:cri-ref key="stext" ref="criterion.sys.docSubject" title="${lfn:message('geesun-org:geesunOrgRecord.stext')}" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="objidUp" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="objid" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="priox" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zsfyx" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zhrOmJglx" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zzDatum"/>
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="objidSUp" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="begda" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="nachn" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="phone" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="gbdat" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="call" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="gender" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="wxid" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="pernr" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="plans02" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="email" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zhrOmGwzd" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="plans01" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="zhrOmGwzj" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="vnamc" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="orgeh" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgRecord" property="icnum" />

        </list:criteria>
		 
		<!-- 列表工具栏 -->
		<div class="lui_list_operation">
			<table width="100%">
				<tr>
					<td style='width: 60px;'>
						${ lfn:message('list.orderType') }：
					</td>
					<td>
						<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
							<list:sort property="geesunOrgRecord.docCreateTime" text="${lfn:message('geesun-org:geesunOrgRecord.docCreateTime')}" group="sort.list" value="down" />
						</ui:toolbar>
					</td>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
	 	<list:listview cfg-criteriaInit="${empty param.categoryId?'false':'true'}">
			<ui:source type="AjaxJson">
					{url:'/geesun/org/geesun_org_record/geesunOrgRecord.do?method=data&categoryId=${param.categoryId}'}
			</ui:source>
			<!-- 列表视图 -->	
			<list:colTable isDefault="false" rowHref="/geesun/org/geesun_org_record/geesunOrgRecord.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdOrganType.name;stext;nachn;pernr;objid;orgeh;zsfyx;docCreateTime" url="" />
            </list:colTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>		 	
