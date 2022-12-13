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
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" count="4">
						<list:sortgroup>
							<list:sort property="docCreateTime" text="${lfn:message('km-carmng:kmCarmngInfringeInfo.docCreateTime') }" group="sort.list" value="down"></list:sort>
							<list:sort property="fdNo" text="${lfn:message('km-carmng:kmCarmngInfomation.fdNo') }" group="sort.list"></list:sort>
							<list:sort property="fdVehichesType.fdName" text="${lfn:message('km-carmng:kmCarmngInfomation.fdVehichesType') }" group="sort.list"></list:sort>
							<list:sort property="fdSeatNumber" text="${lfn:message('km-carmng:kmCarmngInfomation.fdSeatNumber') }" group="sort.list"></list:sort>
							<list:sort property="fdDriverId" text="${lfn:message('km-carmng:kmCarmngInfomation.fdDriverName') }" group="sort.list"></list:sort>
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
					<ui:toolbar style="float:right" id="Btntoolbar">
						<c:set var="authAddUrl" value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=add"></c:set>
						<c:if test="${not empty param.motorcadeId}">
							<c:set var="authAddUrl" value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=add&motorcadeId=${param.motorcadeId}"></c:set>
						</c:if>
						<c:set var="authDeleteUrl" value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=deleteall"></c:set>
						<c:if test="${not empty param.motorcadeId}">
							<c:set var="authDeleteUrl" value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=deleteall&motorcadeId=${param.motorcadeId}"></c:set>
						</c:if>
						<kmss:auth requestURL="${authAddUrl}" requestMethod="GET">
						    <ui:button text="${lfn:message('button.add')}" onclick="addInfomation();" order="1" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="${authDeleteUrl}" requestMethod="GET">								
							<ui:button text="${lfn:message('button.deleteall')}" onclick="delInfomation();" id="delBtn">
							</ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<%@ include file="/km/carmng/km_carmng_info_ui/kmCarmngInfomation_listtable.jsp" %>
	
	<script type="text/javascript">
	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic, toolbar) {
		LUI.ready(function(){
		});
		
		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
	<!--新建-->
		window.addInfomation = function() {
			var fdCategoryId= getValueByHash("fdVehichesType");
		   	if(getValueByHash("fdVehichesType") == null){
		   		fdCategoryId = null;
			 }
		   	var creatUrl = '/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=add';
		   	if("${param.motorcadeId}" != null && "${param.motorcadeId}" != ""){
		   		creatUrl += '&motorcadeId=${param.motorcadeId}';
		   	}
		   	creatUrl += '&categoryId=!{id}';
			dialog.simpleCategoryForNewFile(
					'com.landray.kmss.km.carmng.model.KmCarmngCategory',
					creatUrl,false,null,null,fdCategoryId);
		};
	<!--删除-->
		window.delInfomation = function(){
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
					var deleteAllUrl = '${LUI_ContextPath}/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=deleteall';
					if("${param.motorcadeId}" != null && "${param.motorcadeId}" != ""){
						deleteAllUrl = '${LUI_ContextPath}/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=deleteall&motorcadeId=${param.motorcadeId}'
					}

                    var datas = $.param({"List_Selected":values},true);
					$.ajax({
						type: "POST",
						dataType : 'json',
						data: $.param({"List_Selected":values},true),
						url: deleteAllUrl,
						success:function(result){
							if (delCallback){
								delCallback(result);
							}
						},
						error:function(result){
							dialog["failure"]("${lfn:message('return.optFailure')}", $('body')); //failure 
						}
					});
                    //---
				}
			});
		};
		window.getValueByHash = function(key){
            hash = window.location.hash;
            if(hash.indexOf(key)<0){
                return "";
              	}
        	var url = hash.split("cri.q=")[1];
		    var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
		    var r=url.match(reg);
			    if(r!=null){
			    	 return unescape(r[2]);
			    }
			    return "";
			};
		window.delCallback = function(data){
			if(window.del_load!=null){
				window.del_load.hide();
				topic.publish("list.refresh");
			}
			dialog[data.result](data.msg,  $('body')); //failure "${lfn:message('return.optSuccess')}"
		};
	});
	</script>