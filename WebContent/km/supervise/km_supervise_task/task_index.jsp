<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil" %>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
			<script type="text/javascript">
				seajs.use(['theme!list']);	
			</script>
			
            <!-- 筛选 -->
            <list:criteria id="criteria1">
            	
            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

               
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3" id="Btntoolbar">
                            <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:authShow>
                            <kmss:authShow roles="ROLE_KMSUPERVISE_IMPORT">
								<ui:button text="${lfn:message('km-supervise:kmSuperviseMain.import')}" onclick="importSupervise()" order="2" ></ui:button>
							</kmss:authShow>
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
                    {url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&categoryId=${JsParam.categoryId}'}
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
                				'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&i.docTemplate=!{id}',false,null,null,cateId,null,null,true);
                	}
                });
            </script>
	</template:replace>	 
</template:include>