<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	import="com.landray.kmss.fssc.base.util.FsscBaseUtil,com.landray.kmss.fssc.common.util.FsscCommonUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc" %>

<template:include ref="default.list" spa="true" rwd="true">
    <template:replace name="title">
        <c:out value="${ lfn:message('fssc-ledger:module.fssc.ledger') }-${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
    </template:replace>
    
    <!-- 是否启用合同台账 -->
	<%
		if("1".equals(FsscBaseUtil.getSwitchValue("fdContractIsStart"))){
			request.setAttribute("fdIsStart",true);
		}
	%>
    
    <template:replace name="nav">
        <ui:combin ref="menu.nav.title">
            <ui:varParam name="title" value="${ lfn:message('fssc-ledger:module.fssc.ledger') }"></ui:varParam>
            <ui:varParam name="operation">
				<ui:source type="Static">
					
				</ui:source>
			</ui:varParam>
        </ui:combin>
        <div id="menu_nav" class="lui_list_nav_frame">
			<ui:accordionpanel>
				<ui:combin ref="menu.nav.search">
					<ui:varParams modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice"/>
				</ui:combin>
				<ui:content title="${ lfn:message('list.search') }" expand="true">
					<ui:combin ref="menu.nav.simple">
						<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[
		  					<kmss:authShow roles="ROLE_FSSCLEDGER_IMPORT;ROLE_FSSCLEDGER_DELETE;ROLE_FSSCLEDGER_VIEW">
		  					{
		  						"text" : "${lfn:message('fssc-ledger:table.fsscLedgerInvoice')}",
		  						"href" :  "/listAll",
								"router" : true,		  					
				  				"icon" : "lui_iconfont_navleft_com_all"
		  					}
		  					</kmss:authShow>
		  					<kmss:authShow roles="ROLE_FSSCLEDGER_IMPORT;ROLE_FSSCLEDGER_DELETE;ROLE_FSSCLEDGER_VIEW">
		  					,
		  					</kmss:authShow>
		  					<kmss:authShow roles="ROLE_FSSCLEDGER_MATERIAL_ADD;ROLE_FSSCLEDGER_MATERIAL_VIEW">
		  					<fssc:checkVersion version="true">
		  					<kmss:ifModuleExist path="/fssc/purch/">
		  					{
		  						"text" : "${lfn:message('fssc-ledger:table.fsscLedgerMaterial')}",
		  						"href" :  "/listMaterial",
								"router" : true,		  					
				  				"icon" : "lui_iconfont_navleft_com_all"
		  					}
		  					</kmss:ifModuleExist>
		  					</fssc:checkVersion>
		  					</kmss:authShow>
		  					<kmss:authShow roles="ROLE_FSSCLEDGER_CONTRACT_ADD;ROLE_FSSCLEDGER_CONTRACT_VIEW;ROLE_FSSCLEDGER_CONTRACT_EDIT;ROLE_FSSCLEDGER_CONTRACT_DELETE">
		  					<c:if test="${fdIsStart eq true}">
			  					<fssc:checkVersion version="true">
			  					<kmss:authShow roles="ROLE_FSSCLEDGER_MATERIAL_ADD;ROLE_FSSCLEDGER_MATERIAL_VIEW">
		  						<kmss:ifModuleExist path="/fssc/purch/">
			  					,
			  					</kmss:ifModuleExist>
			  					</kmss:authShow>
			  					{
			  						"text" : "${lfn:message('fssc-ledger:table.fsscLedgerContract')}",
			  						"href" :  "/listContract",
									"router" : true,		  					
					  				"icon" : "lui_iconfont_navleft_com_all"
			  					}
			  					</fssc:checkVersion>
			  				</c:if>
			  				</kmss:authShow>
		  					]
		  					</ui:source>
		  				</ui:varParam>
		  			</ui:combin>
				</ui:content>
				<kmss:authShow roles="ROLE_FSSCLEDGER_SETTING">
				<ui:content title="${ lfn:message('list.otherOpt') }" expand="true">
					<ui:combin ref="menu.nav.simple">
						<ui:varParam name="source">
		  					<ui:source type="Static">
		  					[{
                                "text" : "${lfn:message('list.manager') }",
                                "href" :  "javascript:LUI.pageOpen('${LUI_ContextPath }/sys/profile/moduleindex.jsp?nav=/fssc/ledger/tree.jsp','_rIframe');",
                                "icon" : "lui_iconfont_navleft_com_background"
                                }]
		  					</ui:source>
		  				</ui:varParam>
		  			</ui:combin>
				</ui:content>
				</kmss:authShow>
			</ui:accordionpanel>
		</div>
    </template:replace>
    <template:replace name="content">
        <ui:tabpanel id="fsscLedgerPanel" layout="sys.ui.tabpanel.list"  cfg-router="true">
			<ui:content id="fsscLedgerContent" title="" cfg-route="{path:'/listAll'}">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdInvoiceCode" ref="criterion.sys.docSubject" title="${lfn:message('fssc-ledger:fsscLedgerInvoice.fdInvoiceCode')}" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdInvoiceNumber" expand="true" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdIsAvailable" expand="true" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdInvoiceType" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdState" />
                <list:cri-auto modelName="com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice" property="fdPurchaserName" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="fsscLedgerInvoice.docAlterTime" text="${lfn:message('fssc-ledger:fsscLedgerInvoice.docAlterTime')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">

                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />

                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdInvoiceCode;fdInvoiceNumber;fdInvoiceType;fdState.name;fdTotalAmount;fdPurchaserName;fdBillingDate;fdIsAvailable.name" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </ui:content>
        </ui:tabpanel>
        </template:replace>
        <template:replace name="script">
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice',
                templateName: '',
                basePath: '/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do',
                canDelete: '${canDelete}',
                mode: '',
                templateService: '',
                templateAlert: '${lfn:message("fssc-ledger:treeModel.alert.templateAlert")}',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            seajs.use(['lui/framework/module'],function(Module){
				Module.install('fsscLedger',{
					//模块变量
					$var : {
						
					},
					//模块多语言
					$lang : {
						
					},
					//搜索标识符
					$search : ''
				});
			});
            LUI.ready(function() {
            	seajs.use(['lui/util/str','lui/topic','lui/util/env','lui/framework/router/router-utils','lui/spa/const','lui/framework/module' ], function(str,topic,env,routerUtils,spaConst,Module) {
            		setTimeout(function(){
            			if (seajs.data.env.isSpa) {
               				// 启用路由模式
               				var router = routerUtils.getRouter();
    						var path=$(".lui_list_nav_list").find('li').eq(0).data('path');
    						var j_path=getParamsByKey('j_path');
    						if(j_path){
    							path=j_path;
    						}
               				if (router&&!j_path) {
               					router.push(path, null)
               					topic.publish(spaConst.SPA_CHANGE_ADD, {
               						value : {
            							'j_path' : path
            						}
               					})
               					router._startpath=path;
               					if(routerUtils.equalPath(path) 
               							|| routerUtils.isParentPath(path)){
               						$(".lui_list_nav_list").find('li').eq(0).addClass('lui_list_nav_selected');
               					}
               				}

               				return true;
               			}
            		},500);

           		});
            });
            function getParamsByKey(key){
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
            Com_IncludeFile("list.js", "${LUI_ContextPath}/fssc/ledger/resource/js/", 'js', true);
        </script>
         <!-- 引入JS -->
		<script type="text/javascript" src="${LUI_ContextPath}/fssc/ledger/resource/js/index.js"></script>
    </template:replace>
</template:include>