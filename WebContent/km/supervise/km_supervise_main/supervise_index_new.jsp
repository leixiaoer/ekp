<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
			<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
			<script type="text/javascript">
				seajs.use(['theme!list']);	
			</script>
            <!-- 筛选 -->
            <list:criteria id="criteria1">
            	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('km-supervise:kmSupervise.items') }"></list:cri-ref>
                <list:cri-criterion expand="false" title="${ lfn:message('km-supervise:py.YuWoXiangGuan') }" key="mydoc" multi="false">
                 <list:box-select>
                     <list:item-select cfg-enable="false">
                         <ui:source type="Static">
                             [{text:'${ lfn:message('km-supervise:py.WoGuanZhuDe') }', value:'concern'},
                             {text:'${ lfn:message('km-supervise:py.WoFuZeDe') }',value:'duty'},
                             {text:'${ lfn:message('km-supervise:py.SuoYouDuBan') }',value:'manage'},
                             {text:'${ lfn:message('km-supervise:py.ChaoSongWoDe') }',value:'copy'}]
                         </ui:source>
                     </list:item-select>
                 </list:box-select>
            	</list:cri-criterion>
                <list:tab-criterion title="" key="docStatus">  
					<list:box-select>
						<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas" cfg-if="param['mydoc'] == 'duty' || param['mydoc'] == 'fenguan' || param['mydoc'] == 'concern' || param['mydoc'] == 'undertake' || param['mydoc'] == 'sup'">
							<ui:source type="Static">
								[{text:'${ lfn:message('km-supervise:enums.doc_status.30')}',value:'30'},
								{text:'${ lfn:message('km-supervise:enums.doc_status.40')}',value:'40'},
								{text:'${ lfn:message('km-supervise:enums.doc_status.50')}',value:'50'}]
							</ui:source>
						</list:item-select>
					</list:box-select>
				</list:tab-criterion>
				
				<list:cri-ref key="fdSponsor" ref="criterion.sys.person" title="${lfn:message('km-supervise:kmSuperviseMain.fdSponsor') }" cfg-if="param['mydoc'] == 'duban'"></list:cri-ref>
				<list:cri-ref key="fdLeads" ref="criterion.sys.person" title="${lfn:message('km-supervise:kmSuperviseMain.fdLeads') }" cfg-if="param['mydoc'] == 'duty' || param['mydoc'] == 'fenguan' || param['mydoc'] == 'concern' || param['mydoc'] == 'undertake' || param['mydoc'] == 'sup'"></list:cri-ref>
				
               
                <%-- <list:cri-criterion title="${lfn:message('km-supervise:kmSuperviseMain.fdLevel')}" key="fdLevel" multi="false">
                    <list:box-select>
                        <list:item-select>
                            <ui:source type="Static">
                                <%=KmSuperviseUtil.buildCriteria( "kmSuperviseLevelService", "fdId,fdName", "fdIsAvailable = '1'", null) %>
                            </ui:source>
                        </list:item-select>
                    </list:box-select>
                </list:cri-criterion> --%>
                
                <!-- 督办来源 -->
				<list:cri-criterion title="${lfn:message('km-supervise:kmSuperviseMain.source') }" key="fdModelName" multi="true">
					<list:box-select>
						<list:item-select type="lui/criteria!CriterionSelectDatas">
							<ui:source type="AjaxJson" >
								{url: "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getModules"}
							</ui:source>
						</list:item-select>
					</list:box-select>
				</list:cri-criterion>
				
                <list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseMain" property="fdStartTime;fdFinishTime;docTemplate" />
            </list:criteria>
            <!-- 操作 -->
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
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                        	<list:sortgroup>
	                            <list:sort property="docCreateTime" text="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime')}" group="sort.list" value="down"/>
	                            <list:sort property="fdFinishTime" text="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}" group="sort.list" />
	                            <list:sort property="fdStatus" text="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}" group="sort.list" />
	                        </list:sortgroup>
                        </ui:toolbar>
                    </div>
                </div>
                <!-- 分页 -->
				<div class="lui_list_operation_page_top">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3" id="Btntoolbar">
                            <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:authShow>
                            <%-- <kmss:authShow roles="ROLE_KMSUPERVISE_IMPORT">
								<ui:button text="${lfn:message('km-supervise:kmSuperviseMain.import')}" onclick="importSupervise()" order="2" ></ui:button>
							</kmss:authShow> --%>
                            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall">
                                <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            </kmss:auth>
                        	<kmss:authShow roles="ROLE_KMSUPERVISE_SUPERVISOR_EXPORT">
								<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain')" order="2" ></ui:button>
							</kmss:authShow>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&categoryId=${JsParam.categoryId}&myStatus=${JsParam.myStatus}'}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" isDefault="true" layout="sys.ui.listview.columntable" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto/>
                </list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
               
            <script>
            	var listOption = {
                    contextPath: '${LUI_ContextPath}',
                    modelName: 'com.landray.kmss.km.supervise.model.KmSuperviseMain',
                    templateName: 'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
                    basePath: '/km/supervise/km_supervise_main/kmSuperviseMain.do',
                    canDelete: 'false',
                    mode: 'main_template',
                    customOpts: {

                        ____fork__: 0
                    },
                    lang: {
                        noSelect: '${lfn:message("page.noSelect")}',
                        comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                    }

                };
                Com_IncludeFile("list.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
            	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'],function($,dialog,topic,toolbar){
                	window.removeDelBtn = function(){
						if(LUI('btnDelete')){
	              	    LUI('Btntoolbar').removeButton(LUI('btnDelete'));
	              	    LUI('btnDelete').destroy();
	              	   }
					};
                	var cateId= '', nodeType = '';
            		//根据筛选器分类异步校验权限
            		<%
				   		request.setAttribute("admin",UserUtil.getKMSSUser().isAdmin());
					%>
            		topic.subscribe('criteria.spa.changed',function(evt){
            			if("${admin}"=="false"){
       					  removeDelBtn();
            			}
            			var hasCate = false;
            			cateId= '';
            			for(var i=0;i<evt['criterions'].length;i++){
           				  //获取分类id和类型
                       	  if(evt['criterions'][i].key == "docTemplate"){
                       		 hasCate = true;
                           	 cateId= evt['criterions'][i].value[0];
          	                 nodeType = evt['criterions'][i].nodeType;
                       	  }
            			}
            			//分类变化刷新
           				if(hasCate)
               				showButtons(cateId,nodeType);
           				//筛选器全部清空的情况
           				if(evt['criterions'].length==0){
           					 showButtons('','');
           				}
            		});
            		
            		function showButtons(categoryId, nodeType){
            			var checkDelUrl = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall&categoryId="+categoryId+"&nodeType="+nodeType;
            			var data = new Array();
            			data.push(["delBtn",checkDelUrl]);
                        $.ajax({
                        	url: "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
                        	dataType : 'json',
                  			type : 'post',
                  			data:{  data : LUI.stringify(data) },
                  			async : false,
                  			success : function(rtn){
                  				for(var i = 0;i < rtn.length;i++){
                  					if(!LUI('btnDelete')){
	       		                 		var delBtn = toolbar.buildButton({ id:'btnDelete',order:'3',text:'${lfn:message("button.deleteall")}', click:'delDoc()'});
	       		                 		LUI('Btntoolbar').addButton(delBtn);
	       		                	}
                  				}
                  			}
                        });
            		}
            		
            		//删除
    				window.delDoc = function(){
    					var values = [];
    					$("input[name='List_Selected']:checked").each(function(){
    							values.push($(this).val());
    						});
    					if(values.length==0){
    						dialog.alert('${lfn:message("page.noSelect")}');
    						return;
    					}
    					/* 软删除配置 */
    					var url='<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall"/>'+'&categoryId='+cateId+'&nodeType='+nodeType;
    					var config = {
    						url : url, // 删除数据的URL
    						data : $.param({"List_Selected":values},true), // 要删除的数据
    						modelName : "com.landray.kmss.km.supervise.model.KmSuperviseMain"
    					};
    					// 通用删除方法
    					Com_Delete(config, delCallback);
    				};
    				//批量导入督办
                	window.importSupervise = function() {
                		dialog.categoryForNewFile('com.landray.kmss.km.supervise.model.KmSuperviseTemplet', 
                				'/km/supervise/km_supervise_main/kmSupervise_upload.jsp?docTemplate=!{id}',
        		    			false,null,null);
                	};
                	//新建督办
                	window.addDoc = function() {
                		dialog.categoryForNewFile(
                				'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
                				'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&i.docTemplate=!{id}',false,null,null,cateId,null,null,true,null,{"fdType":"10"});
                	}
                });
            </script>
	</template:replace>	 
</template:include>