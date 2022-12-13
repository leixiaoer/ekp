<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="default.simple">
	<template:replace name="body">
	 <script type="text/javascript">
		seajs.use(['theme!module']);	
	 </script>
	  <link rel="stylesheet" href="${KMSS_Parameter_ContextPath}sys/search/styles/newSearch.css" />
		<div>
			<div class="lui_search_container" id="searchPage">
				<div class='lui_search_doc'><span id="searchDoc" data-active="0" onclick="showSearch(this)"><span id="searchDocTitle"></span><i class="close"></i></span></div>
				<div id="searchContent" class="lui_search_content" style="display: none">
					<div class='lui_search_input'>
						<input type="text" name='search_keyword' oninput="doInput(this)" onpropertychange="doInput(this)" onkeypress="doKeyPress(this)" class="lui_search_keyword" placeholder="请搜索"/>
						<div class="lui_search_empty" id="searchEmpty" style="display: none;" onclick="doEmpty(this)"></div>
						<i class="lui_profile_listview_icon lui_icon_s_icon_search lui_search_btn" style="cursor: pointer" onclick="doSearch()"></i>
					</div>
					<div class='lui_search_list'>
						<ui:dataview id="docDataView">
							<ui:source type="AjaxJson">
								{"url":"/sys/search/sys_search_main/sysSearchMain.do?method=listConfig&category=${JsParam.category }&modelName=${JsParam.modelName}"} 
							</ui:source>
							<ui:render type="Template">
								if(data.length > 0){
										{$
										<ul id="searchTab" class="lui_search_list_ul">
										$}
										        for(var n=0; n < data.length;n++){
										         {$
										            <li onclick="showSearchDialog('{%data[n].value%}',this);${empty varParams.onClick ? '' : varParams.onClick}" class="lui_search_list_item">
										                <span class="lui_search_item_text">{%strutil.encodeHTML(data[n].text)%}</span>
										            </li>
										          $}
										         } 
										{$
										</ul>
									$}
								}else{
									{$
										<div>			     
										</div>
									$} 
								}
							</ui:render>
							<ui:event event="load">
							if(LUI.isSearch != true){
								var data = this.data;
								if(data.length == 0){
									LUI('search_Iframe').erase();
									$("#emptyPage").show();
									$("#searchPage").hide();
								}
			
								if($('#searchTab li').length > 0){
									setTimeout(function(){
										$('#searchTab li:first').trigger("click");
									},100);
								}
							}else{
								//把搜索的关键字给加上颜色
								var keyword = LUI.keyword;
								if(keyword){
									var itemObjs = $('#searchTab li');
									for(var i=0; i<itemObjs.length; i++){
										var itemObj = itemObjs[i];
										var itemText = $(itemObj).find("span.lui_search_item_text").text();
										var index = itemText.indexOf(keyword);
										var leftStr = itemText.substring(0,index);
										var rightStr = itemText.substring(index+keyword.length);
										var html = leftStr+"<span style='color:#4285F4;'>"+keyword+"</span>"+rightStr;
										$(itemObj).find("span.lui_search_item_text").html(html);
									}
								}
							}
							</ui:event>
						</ui:dataview>
					</div>
				</div>
			</div>
			<div id="emptyPage" style="display: none">
				<div class="lui-search-panel-heading">			     
				    <div id="expandDiv" class="lui-search-extra-wrap">
					     <h2 class="lui-search-panel-heading-title"><bean:message bundle="sys-search" key="search.common"/></h2>
						<div class="lui-search-extra-border"></div>
					</div> 
				</div>
				<div class="lui-cate-queryEmpty-wrap">
					<div class="lui-cate-queryEmpty">
						<div class="queryEmpty-icon">
						</div>
						<p class="queryEmpty-tips"><bean:message bundle="sys-search" key="search.common.empty"/></p>
						<p class="queryEmpty-suggest"><bean:message bundle="sys-search" key="search.common.empty.hint"/></p>
					</div>
				</div>
			</div>
			<ui:dataview format="sys.ui.iframe" id="search_Iframe">
				<ui:source type="Static">
					{"src":""}
				</ui:source>		
			</ui:dataview>
		</div>
<script type="text/javascript">
	//条件查询
	seajs.use(['lui/util/str'], function(strutil) {
		window.strutil=strutil;
	});
	
	//清空输入
	window.doEmpty = function(obj){
		$("[name='search_keyword']").val("");
		$(obj).css("display","none");
		doSearch();
	}
	
	//回车
	window.doKeyPress = function(obj){
		if(event && event.keyCode == "13"){
			doSearch(obj);
		}
	}
	
	//输入
	window.doInput = function(obj){
		var value = obj.value;
		if(value){
			$("#searchEmpty").css("display","inline");
		}else{
			$("#searchEmpty").css("display","none");
		}
	}
	
	//搜索
	window.doSearch = function(obj){
		var keyword = $("[name='search_keyword']").val();
		LUI.isSearch = true;
		LUI.keyword = keyword;
		var keywordCov = encodeURIComponent(keyword);
		var url = "/sys/search/sys_search_main/sysSearchMain.do?method=listConfig&category=${JsParam.category }&modelName=${JsParam.modelName}"+"&keyword="+keywordCov;
		LUI("docDataView").source.setUrl(url);
		LUI("docDataView").source.get();
	}
	
	//显示搜索下拉框
	window.showSearch = function(obj){
		if (event && event.stopPropagation ){ 
			event.stopPropagation(); 
		}else{ 
		    window.event.cancelBubble = true; 
		}
		$(obj).toggleClass("active");
		var active = $(obj).attr("data-active");
		if(active == "0"){
			$(obj).attr("data-active","1");
			$("#searchContent").show();
		}else{
			$(obj).attr("data-active","0");
			$("#searchContent").hide();
		}
	}
	
	window.showSearchDialog = function(id,obj) {
		var active = $("#searchDoc").attr("data-active");
		if(active == "1"){
			$("#searchDoc").toggleClass("active");
			$("#searchDoc").attr("data-active","0");
			$("#searchContent").hide();
		}
		$("#searchDocTitle").text($(obj).text())
		seajs.use(['lui/util/str'], function(strutil) {
			var params = {
					value: id,
					modelName: '${param.modelName}'
			};
			var url = "/sys/search/search.do?method=condition&searchId=!{value}&fdModelName=!{modelName}&canClose=false&isNew=true";
			url = strutil.variableResolver(url, params);
			
			 var dataview=LUI("search_Iframe");
			 dataview.source.source={src:url};
			 dataview.refresh();
		});
	};
	
	Com_AddEventListener(window,'load',function(){
		$("#searchPage").on('click',function(event){
			if($("#searchContent").find(event.target).length > 0){
				return;
			}
			var active = $("#searchDoc").attr("data-active");
			if(active == "1"){
				$("#searchDoc").toggleClass("active");
				$("#searchDoc").attr("data-active","0");
				$("#searchContent").hide();
			}
		})
	})
</script>
	</template:replace>
</template:include>
