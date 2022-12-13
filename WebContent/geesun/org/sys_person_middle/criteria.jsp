<%@ page language="java" pageEncoding="UTF-8"%>
		<!-- 查询条件  -->
		<list:criteria id="criteria1">
			<list:cri-auto modelName="com.landray.kmss.geesun.org.model.SysPersonMiddle" 
				property="pernr;nachn;vnamc;orger;plans01;plans02;phone;email;ccall;wxid;zsfyx" />
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
							<list:sort property="pernr" text="${lfn:message('geesun-org:sysPersonMiddle.pernr') }" group="sort.list" value="up"></list:sort>
						</ui:toolbar>
					</td>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
	 	<list:listview cfg-criteriaInit="${empty param.categoryId?'false':'true'}">
			<ui:source type="AjaxJson">
					{url:'/geesun/org/sys_person_middle/sysPersonMiddle.do?method=data&categoryId=${param.categoryId}'}
			</ui:source>
			<!-- 列表视图 -->	
			<list:colTable isDefault="false"
				rowHref="/geesun/org/sys_person_middle/sysPersonMiddle.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				 
				<list:col-auto props="pernr;nachn;vnamc;orger;phone;email;ccall;wxid;gender;zsfyx"></list:col-auto>
			</list:colTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>		 	
