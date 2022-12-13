<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count='4'>
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('km-vote:kmVoteCategory.docCreateTime') }" group="sort.list" value="down"></list:sort>
							<list:sort property="fdEffectTime" text="${lfn:message('km-vote:kmVoteMain.fdEffectTime') }" group="sort.list"></list:sort>
							<list:sort property="fdExpireTime" text="${lfn:message('km-vote:kmVoteMain.fdExpireTime') }" group="sort.list"></list:sort>
							<list:sort property="fdVoteNum" text="${lfn:message('km-vote:kmVoteMain.fdVoteNum') }" group="sort.list"></list:sort>
						</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar count='3' style="float:right">
						<kmss:authShow roles="ROLE_KMVOTEMAIN_CREATE">
							<ui:button text="${lfn:message('km-vote:button.launchedVote')}" onclick="addVote()" order="2">
							</ui:button>	
						</kmss:authShow>
						<%--
						<ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport')" order="2" ></ui:button>
						 --%>
						<ui:button text="${lfn:message('button.deleteall')}" onclick="delVote()" order="4"
							cfg-map="{\"fdVoteStatus\":\"criteria('fdVoteStatus')\",\"fdVoteCategory\":\"criteria('fdVoteCategory')\"}"
							cfg-auth="/km/vote/km_vote_main/kmVoteMain.do?method=deleteall&status=!{fdVoteStatus}&categoryId=!{fdVoteCategory}&nodeType=${param.nodeType}">
						</ui:button>
						
					</ui:toolbar>
				</div>
			</div>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		
		<%@ include file="/km/vote/km_vote_ui/kmVoteMain_listtable.jsp" %>
		
	<script type="text/javascript">
	 	//var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.doc.model.KmDocKnowledge";
			seajs.use(['lui/jquery','lui/dialog','lui/topic', 'lui/spa/Spa'], function($, dialog , topic, Spa) {
				LUI.ready(function(){
                     //初始化门户传递的category
                     var categoryId = getValueByHash("fdVoteCategory");
                     if(categoryId == ""){
                         return;
                     }
                     var hash = window.location.hash;
                     if(hash == ""){
                   	   window.location.hash = "cri.q=fdVoteCategory:"+categoryId;
                     }else{
                   	   window.location.hash = hash + ";fdVoteCategory:"+categoryId;
		             }
					});
			// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				topic.publish('list.refresh');
			});
				
			//发起投票
				window.addVote = function(){
					 dialog.simpleCategoryForNewFile('com.landray.kmss.km.vote.model.KmVoteCategory',
					 '/km/vote/km_vote_main/kmVoteMain.do?method=add&fdCategoryId=!{id}',false,null,null,getValueByHash("fdVoteCategory"));
                };             
            //删除
				window.delVote = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/km/vote/km_vote_main/kmVoteMain.do?method=deleteall"/>&categoryId=${JsParam.categoryId}',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
						topic.publish("list.refresh");
					}
					dialog.result(data);
				};

				//根据地址获取key对应的筛选值
	            window.getValueByHash = function(key){
	                var hash = window.location.hash;
	                var cateId = '${JsParam.categoryId}';
	                if(hash.indexOf(key)<0){
	                	if(cateId){
							return cateId;
						}
						return "";
	                 }
	            	var url = hash.split("cri.q=")[1];
	  			    var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
				    var r=url.match(reg);
				    if(r!=null){
				    	 return unescape(r[2]);
				    }
				    
				    if(cateId){
						return cateId;
					}
				    return "";
	           };
	           window.clearAllValue = function() {
				 	this.location = "${LUI_ContextPath}/km/vote";
				};
			});
		</script>	