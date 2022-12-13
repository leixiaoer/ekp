<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.geesun.annual.util.GeesunAnnualUtil" %>
		<!-- 筛选 -->
        <list:criteria id="criteria1">
            <list:cri-ref key="fdHasExecute" ref="criterion.sys.docSubject" title="${lfn:message('geesun-annual:geesunAnnualReset.fdHasExecute')}" />
            <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualReset" property="fdOwner" />
            <list:cri-criterion title="${lfn:message('geesun-annual:geesunAnnualReset.fdAnnual')}" key="fdAnnual" multi="false">
                <list:box-select>
                    <list:item-select>
                        <ui:source type="Static">
                            <%=GeesunAnnualUtil.buildCriteria( "geesunAnnualMainService", "geesunAnnualMain.fdId,geesunAnnualMain.fdOwnerNo", null, null) %>
                        </ui:source>
                    </list:item-select>
                </list:box-select>
            </list:cri-criterion>
            <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualReset" property="fdExecuteTime" />

        </list:criteria>
		 
		<!-- 列表工具栏 -->
		<div class="lui_list_operation">
			<table width="100%">
				<tr>
					<div style='color: #979797;float: left;padding-top:1px;'>
						${ lfn:message('list.orderType') }：
					</div>
					<div style="float:left">
						<div style="display: inline-block;vertical-align: middle;">
							<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                                <list:sort property="geesunAnnualReset.fdExecuteTime" text="${lfn:message('geesun-annual:geesunAnnualReset.fdExecuteTime')}" group="sort.list" />
                            </ui:toolbar>
						</div>
					</div>
					<div style="float:left;">	
						<list:paging layout="sys.ui.paging.top" > 		
						</list:paging>
					</div>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
	 	<list:listview id="listview">
			<ui:source type="AjaxJson">
                {url:'/geesun/annual/geesun_annual_reset/geesunAnnualReset.do?method=data'}
            </ui:source>
            <!-- 列表视图 -->
            <list:colTable isDefault="false" rowHref="/geesun/annual/geesun_annual_reset/geesunAnnualReset.do?method=view&fdId=!{fdId}" name="columntable">
                <list:col-checkbox />
                <list:col-serial/>
                <list:col-auto props="fdOwner.name;fdHasExecute.name;fdExecuteTime" url="" /></list:colTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>		 	