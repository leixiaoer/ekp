<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<script language="JavaScript">
			Com_IncludeFile("jquery.js");
		</script>
		<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/km_supervise_main/js/jsTree/themes/default/style.min.css?s_cache=${LUI_Cache}" />
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
		<div name="allTree" class="allTree" id="allTree"></div>
		<div name="myConcernTree" class="myConcernTree" id="myConcernTree"></div>
        <script type="text/javascript" src="${LUI_ContextPath}/km/supervise/km_supervise_main/js/jsTree/jstree.js?s_cache=${LUI_Cache}"></script>
		<script type="text/javascript" src="${LUI_ContextPath}/sys/admin/resource/js/jquery.corner.js?s_cache=${LUI_Cache}"></script>
        <script>
        	$(document).ready(function(){
        		var allTree;
        		var concernTree;
        		 setTimeout(function(){
	        		$.ajax( {
						url : '${LUI_ContextPath}/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=getAllTree',
						type : 'get',
						dataType : 'json',
						async : true,
						data : '',
						success : function(data, textStatus, xhr) {
							if (data == false) {
								dialog.failure("${ lfn:message('km-supervise:py.searchFailture') }");
							} else {
								// 如果树已存在，需要销毁
								try {
									if (allTree) {
										allTree.destroy();
									}
								} catch (e) {
								}
				        		$("#allTree").jstree({
				        			plugins: ["state"],
				        			core : {
					        			themes : {
											// 消除连线
											dots : false,
											// 消除图标
											icons : false
										},
										data : data
									}
				                })
				                .on('click.jstree', function(e) {
									var target = $(e.target);
									
									var id = $(e.target).parents('li').attr('id');
									
									var node = allTree.get_node(id);
									if(id == "allRoot"){
										id = "";
									}
									if(target.hasClass("jstree-anchor")) {
										var href ="${LUI_ContextPath}/km/supervise/km_supervise_main/supervise_item_view.jsp?categoryId="
											+ id;
										Com_OpenWindow(href,'viewFrame');
									}
									
								})
								.on('ready.jstree', function(e, data) {
									allTree = data.instance;
									var obj = allTree.get_node(e.target.firstChild.firstChild.lastChild);  
									allTree.select_node(obj);
									var href ="${LUI_ContextPath}/km/supervise/km_supervise_main/supervise_item_view.jsp";
									Com_OpenWindow(href,'viewFrame');
								});
							}
						}
					});
	        		$.ajax( {
						url : '${LUI_ContextPath}/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=getMyConcernTree',
						type : 'get',
						dataType : 'json',
						async : true,
						data : '',
						success : function(data, textStatus, xhr) {
							if (data == false) {
								dialog.failure("${ lfn:message('km-supervise:py.searchFailture') }");
							} else {
								// 如果树已存在，需要销毁
								try {
									if (concernTree) {
										concernTree.destroy();
									}
								} catch (e) {
								}
				        		$("#myConcernTree").jstree({
				        			plugins: ["state"],
				        			state: {
				        	             "opened":true,
				        	        },
				        			core : {
					        			themes : {
											// 消除连线
											dots : false,
											// 消除图标
											icons : false
										},
										data : data
									}
				                })
				                .on('click.jstree', function(e) {
									var target = $(e.target);
									
									var id = $(e.target).parents('li').attr('id');
									if(id == "concernRoot"){
										id = "";
									}
									var node = concernTree.get_node(id);
									
									if(target.hasClass("jstree-anchor")) {
										var href ="${LUI_ContextPath}/km/supervise/km_supervise_main/supervise_item_view.jsp?categoryId="
											+ id + "&isMyConcern=true";
										Com_OpenWindow(href,'viewFrame');
									}
									
								})
								.on('ready.jstree', function(e, data) {
									concernTree = data.instance;
								});
							}
						}
					});
        		 },500);
        	});
        </script>
	</template:replace>
</template:include>