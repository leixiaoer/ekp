<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.list" compatibleMode="true">
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<bean:message bundle="km-supervise" key="module.km.supervise"/>
		</c:if>
	</template:replace>
	<template:replace name="head">	   
	   	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/primarycss.css?s_cache=${MUI_Cache}"></link>
	   	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/supervise/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/sys/mportal/mobile/css/portal.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="content">
		<div class="gray" data-dojo-type="mui/view/DocScrollableView">		
			<div data-dojo-type="dojox/mobile/View">
				<div class="lui_sm_mc_card lui_sm_mc_echart_box">
			    	<div id="luiEchart" class="lui_sm_mc_echart" style="width:100%;height:100%;"></div>
			    </div>
				
				<!-- 督办事项类别 -->
				<div class="lui_sm_mc_card lui_sm_mc_statistics">
					<div class="lui_sm_mcs_title">
			          	<span class="lui_font_family_bold">督办类别</span>
			          	<div class="lui_sm_mcst_nav">
			            	<span>已超期</span>
			            	<span>即将超期</span>
			            	<span class="lui_sm_mcst_nav-active">正常推进</span>
			          	</div>
			        </div>
			        <div class="lui_sm_mcs_itemList" id="templateList" data-dojo-type="mui/list/JsonStoreList" 
				    	data-dojo-mixins="km/supervise/mobile/resource/js/list/TemplateItemListMixin"
				    	data-dojo-props="url:'/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=getCount&status=10',lazy:false">
					</div>
				</div>
		        
		        <!-- 督办动态 -->
				<div class="lui_sm_mc_card" data-dojo-type="sys/mportal/mobile/Card"
					data-dojo-props="
						title: '督办动态',
						configs:[{
						'operations': {
							'toolbar': true,
							'random': {
								'href': '',
								'name': '换一批',
								'type': 'random'
							}
						},
						'url': '/km/supervise/mobile/dynamic_portal.jsp?rowsize=6'
					}]">
				</div>
			</div>
		</div>
		<!-- 快速入口 Starts -->
	  	<div id="head" data-dojo-type="mui/header/Header">
		    <kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
		          <!-- 督办立项 -->
		          <div class="lui_supervise_create" data-dojo-type="km/supervise/mobile/resource/js/CreateButton"
				  		data-dojo-mixins="mui/syscategory/SysCategoryMixin"
				  		data-dojo-props="key:'10',iconclass:'ekp-ledger-fast-nav-btn',createUrl:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&i.docTemplate=!{curIds}',mainModelName:'com.landray.kmss.km.supervise.model.KmSuperviseMain',
				  		modelName:'com.landray.kmss.km.supervise.model.KmSuperviseTemplet'" style="bottom:11rem;right:0.5rem">
			  		</div>
		     </kmss:authShow>
		</div>
		<!-- 快速入口 Ends -->
		
		<div class="lui_db_footer">
		    <div class="lui_db_footer_item active" onclick="navigate2View(0)">
		      <div class="lui_db_footer_item_img index"></div>
		      <p>首页</p>
		    </div>
		    <div class="lui_db_footer_item " onclick="navigate2View(1)">
		      <div class="lui_db_footer_item_img leader"></div>
		      <p>领导关注</p>
		    </div>
		    <div class="lui_db_footer_item" onclick="navigate2View(2)">
		        <div class="lui_db_footer_item_img all"></div>
		        <p>所有督办</p>
		    </div>
		    <div class="lui_db_footer_item" onclick="navigate2View(3)">
		        <div class="lui_db_footer_item_img mine"></div>
		        <p>我的</p>
		    </div>
		</div>
	</template:replace>
</template:include>
<script>
	require(["dojo/ready","dojo/dom-class","dojo/request","dojo/dom","dojo/query","dojo/on","dojo/dom-attr","dojo/dom-style","dojox/mobile/TransitionEvent", 'dojo/topic','dijit/registry','${LUI_ContextPath}/sys/mobile/js/lib/echart/echarts.js','mui/dialog/Tip'], 
		function(ready,domClass,request,dom,query,on,domAttr,domStyle,TransitionEvent,topic,registry,echarts,Tip) {
		window.navigate2View = function(view) {
			var url ="${LUI_ContextPath}/km/supervise/mobile/";
			if(0 == view){
				url += "index.jsp"
			}else if(1 == view){
				url += "index_leader_concern.jsp"
			}else if(2 == view){
				url += "index_all.jsp"
			}else if(3 == view){
				url += "index_my.jsp"
			}
			window.open(url, '_self');
		}
		
		ready(function(){
		    var navSelect = document.getElementsByClassName("lui_sm_mcst_nav")[0]
		    navSelect.onclick = function (e) {
		      switch(e.target.innerHTML) {
		        case '已超期':
		          changeNavStyle(navSelect);
		          e.target.setAttribute('class','lui_sm_mcst_nav-active');
		          reloadTemplate("30");
		          break;
		        case '即将超期':
		          changeNavStyle(navSelect)
		          e.target.setAttribute('class','lui_sm_mcst_nav-active')
		          reloadTemplate("20");
		          break;
		        case '正常推进':
		          changeNavStyle(navSelect)
		          e.target.setAttribute('class','lui_sm_mcst_nav-active')
		          reloadTemplate("10");
		          break;
		      }
		    }
		    
		    initEcharts();
		    if(checkWeixin() && checkIOS()){
		    	if(window.history.length == 1){
		    		window.history.pushState(null, null, "#");
		    	}
		    }
		})
		
		window.checkWeixin = function(){
			var userAgent = navigator.userAgent;
			if(userAgent.indexOf("MicroMessenger") > -1){
				return true;
			}
			return false;
		}
		
		window.checkIOS = function(){
			var userAgent = navigator.userAgent;
			var isIos = !!userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
			return isIos
		}
		
		  window.changeNavStyle=function(e) {
		    for(var i = 0; i < e.children.length; i++) {
		      e.children[i].setAttribute('class','')
		    }
		  }
		
		
		  
		  window.reloadTemplate = function(status){
		  	var href="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=getCount&status="+status;
			registry.byId("templateList").set('url',href);
			registry.byId("templateList").reload();
		  }
		  
		  
		  window.initEcharts = function(){
			  var myChart = echarts.init(document.getElementById('luiEchart'));
			  var url = '${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getLeaderTopCount';
			  var promise = request.get(url);
			  promise.response.then(function(result) {
				  if (result.status == 200) {
					  var datas = JSON.parse(result.data);
					  var option = {
						    title: {
						      text: '督办状态',
						      x: 'left',
						      textStyle: {
						        color: '#333',
						        fontSize: 17,
						      }
						    },
						    tooltip : {
						        trigger: 'item',
						        formatter: "{a}<br/>{b}:{c}({d}%)"
						    },
						    calculable: true,
						    series: [
						      {
						        name: '面积模式',
						        type: 'pie',
						        radius: [30, 110],
						        center: ['50%', '50%'],
						        roseType: 'area',
						        color:['#FF6F6F','#FF8D8D','#69A0FD','#CFCFCF','#E5E5E5','#4B8FFF'],
						        data: [
						          { value: datas[0].delayCount, name: '已超期'},
						          { value: datas[0].soonDelayCount, name: '即将超期'},
						          { value: datas[0].soonStartCount, name: '即将开始'},
						          { value: datas[0].finishCount, name: '已办结'},
						          { value: datas[0].stopCount, name: '已终止'},
						          { value: datas[0].normalCount, name: '正常推进'},
						        ],
						        itemStyle: {
						            normal:{
					            		label: {//指示到模块的标签文字
		                                	show: true,
		                                	formatter: '{b}\n{c}({d}%)'
		                            	},
						              	labelLine:{
						             		show:true,
						                	length:-8,
						                	lineStyle:{
						                		width:1
						                	}
						              	}
						              }
						            },
						      }
						    ]
						  };
					  myChart.setOption(option);
				  }
			  });
				
			  
			  
		  }
	});
</script>
