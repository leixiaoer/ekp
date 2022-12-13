<%@ page language="java" pageEncoding="UTF-8"%>
		<!-- 查询条件  -->
        <list:criteria id="criteria1">
            <list:cri-ref key="fdPersonId" ref="criterion.sys.docSubject" title="${lfn:message('geesun-org:geesunOrgPerson.fdPersonId')}" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdEmpNo" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdEmpName" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdSex" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdBirthDate" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdMobile" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdAddress" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdCountry" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdRank" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdEmail" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdIdCard" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdEntryDate" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="fdNewDate" />
            <list:cri-auto modelName="com.landray.kmss.geesun.org.model.GeesunOrgPerson" property="docCreateTime" />

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
                            <list:sort property="geesunOrgPerson.fdNewDate" text="${lfn:message('geesun-org:geesunOrgPerson.fdNewDate')}" group="sort.list" value="down" />
                            <list:sort property="geesunOrgPerson.docCreateTime" text="${lfn:message('geesun-org:geesunOrgPerson.docCreateTime')}" group="sort.list" value="down" />
                        </ui:toolbar>
					</td>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
	 	<list:listview cfg-criteriaInit="${empty param.categoryId?'false':'true'}">
			<ui:source type="AjaxJson">
                {url:'/geesun/org/geesun_org_person/geesunOrgPerson.do?method=data'}
            </ui:source>
            <!-- 列表视图 -->
            <list:colTable isDefault="false" rowHref="/geesun/org/geesun_org_person/geesunOrgPerson.do?method=view&fdId=!{fdId}" name="columntable">
                <list:col-checkbox />
                <list:col-serial/>
                <list:col-auto props="fdEmpNo;fdEmpName;fdSex;fdRank;fdWorkState" url="" />
            </list:colTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>		 	
