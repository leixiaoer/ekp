<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/sys/profile/resource/css/operations.css?s_cache=${LUI_Cache}"/>
			<script type="text/javascript">
				seajs.use(['theme!list']);	
			</script>
			<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
            <!-- 筛选 -->
            <list:criteria id="criteria1">
            	<list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('sys-task:supervise_task_docSubject') }"></list:cri-ref>
				<list:cri-criterion expand="true" title="${ lfn:message('km-supervise:kmSuperviseMain.fdStatus') }" key="fdStatus" multi="false" >  
					<list:box-select>
						<list:item-select>
							<ui:source type="Static">
								[{text:'${ lfn:message('km-supervise:enums.status.soon.start')}', value:'00'},
								{text:'${ lfn:message('km-supervise:enums.status.normal')}', value:'10'},
								{text:'${ lfn:message('km-supervise:enums.status.soon.delay')}',value:'20'},
								{text:'${ lfn:message('km-supervise:enums.status.delay')}',value:'30'},
								{text:'${ lfn:message('km-supervise:enums.status.delayFinsh')}',value:'35'},
								{text:'${ lfn:message('km-supervise:enums.status.normalFinsh')}',value:'38'},
								{text:'${ lfn:message('km-supervise:enums.status.stop')}',value:'50'},
								{text:'${ lfn:message('km-supervise:enums.status.change')}',value:'60'}]
							</ui:source>
						</list:item-select>
					</list:box-select>
				</list:cri-criterion>
				<list:cri-ref key="docCreator" ref="criterion.sys.person" title="${lfn:message('km-supervise:kmSuperviseMain.docCreator') }"></list:cri-ref>
                <list:cri-auto modelName="com.landray.kmss.km.supervise.model.KmSuperviseMain" property="fdApprovalTime;fdStartTime;fdFinishTime" />
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
	                            <list:sort property="fdStartTime" text="${lfn:message('km-supervise:kmSuperviseMain.fdStartTime')}" group="sort.list" value="down"/>
	                            <list:sort property="fdApprovalTime" text="${lfn:message('km-supervise:kmSuperviseMain.fdApprovalTime')}" group="sort.list" />
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
                            <!-- 批量催办 -->
                            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=urgeall">
                                <ui:button text="${lfn:message('km-supervise:py.CuiBanAll')}" onclick="urgeAll()" order="4" />
                            </kmss:auth>
                            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall">
                                <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                            </kmss:auth>
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise_main_data.css?s_cache=${LUI_Cache}"/>
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&categoryId=${JsParam.categoryId}&q.j_path=/ItemView&isMyConcern=${JsParam.isMyConcern}'}
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
    				
                	//新建督办
                	window.addDoc = function() {
                		dialog.categoryForNewFile(
                				'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
                				'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}',false,null,null,null,null,null,true,null,{"fdType":"10"});
                	}
                	
    				//批量催办
    				window.urgeAll = function(){
    					var values = [];
    					$("input[name='List_Selected']:checked").each(function(){
    							values.push($(this).val());
    						});
    					if(values.length==0){
    						dialog.alert('${lfn:message("page.noSelect")}');
    						return;
    					}
   	                	dialog.iframe('/km/supervise/km_supervise_urge/kmSuperviseUrge.do?method=showUrgeSupervise&fdMainIds='+values,
   	                			'新建催办',null,{width:800,height:360});
						
					}
    				
    				window.urgeDoc = function(id){
    					var values = [];
    					if(id) {
    		 				values.push(id);
    			 		} 
    					if(values.length==0){
    						dialog.alert('<bean:message key="page.noSelect"/>');
    						return;
    					}
    					dialog.iframe('/km/supervise/km_supervise_urge/kmSuperviseUrge.do?method=showUrgeSupervise&fdMainIds='+values,
   	                			'新建催办',null,{width:800,height:360});
    				}
    				
    				window.instructionDoc = function(id){
    					var values = [];
    					if(id) {
    		 				values.push(id);
    			 		} 
    					if(values.length==0){
    						dialog.alert('<bean:message key="page.noSelect"/>');
    						return;
    					}
    					dialog.iframe('/km/supervise/km_supervise_instruction/kmSuperviseInstruction.do?method=showInstruction&fdMainId='+values,
   	                			'新建批示',null,{width:600,height:360});
    				}
                });
            </script>
	</template:replace>	 
</template:include>