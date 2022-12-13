<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="key" value="${param.key}"/>
<c:set var="criteria" value="${param.criteria}"/>
		<!-- 常用分类 -->
	 	<ui:combin ref="menu.nav.favorite.category">
			<ui:varParams 
				href="/km/supervise/km_supervise_main/?categoryId=!{value}"
				modelName="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" />
		</ui:combin>
		<!-- 督办一览 -->
        <ui:content title="${ lfn:message('km-supervise:py.DuBanYiLan') }">
              <ul class='lui_list_nav_list'>
              	   <kmss:authShow roles="ROLE_KMSUPERVISE_OVERVIEW">
	                  <li><a id="supervise_res" href="javascript:void(0)" onclick="window.open('${LUI_ContextPath }/km/supervise/index.jsp','_self');">${lfn:message('km-supervise:py.DuBanGaiLan')}</a>
	                  </li>
	              </kmss:authShow>
                  <li><a id="km_supervise_main_concern" href="javascript:void(0)" onclick="setUrl('km_supervise_main','mydoc','concern');resetMenuNavStyle(this);">${lfn:message('km-supervise:py.WoGuanZhuDe')}</a>
                  </li>
                  <li><a id="km_supervise_main_duty" href="javascript:void(0)" onclick="setUrl('km_supervise_main','mydoc','duty');resetMenuNavStyle(this);">${lfn:message('km-supervise:py.WoFuZeDe')}</a>
                  </li>
                  <li><a id="km_supervise_main_all" href="javascript:void(0)" onclick="setUrl('km_supervise_main','mydoc','manage');resetMenuNavStyle(this);">${lfn:message('km-supervise:py.SuoYouDuBan')}</a>
                  </li>
                  <li><a id="km_supervise_main_copy" href="javascript:void(0)" onclick="setUrl('km_supervise_main','mydoc','copy');resetMenuNavStyle(this);">${lfn:message('km-supervise:py.ChaoSongWoDe')}</a>
                  </li>
              </ul>
          </ui:content>
          <!-- 督办管理 -->
          <ui:content title="${ lfn:message('km-supervise:module.km.supervise') }">
              <ul class='lui_list_nav_list'>
                  <li><a id="supervise_project" href="javascript:void(0)" onclick="setUrl('project');">${lfn:message('km-supervise:py.DuBanLiXiang')}</a>
                  </li>
                  <li><a id="supervise_task" href="javascript:void(0)" onclick="window.open('${LUI_ContextPath }/km/supervise/km_supervise_task/index.jsp','_self');">${lfn:message('km-supervise:py.RenWuZhiPai')}</a>
                  </li>
                  <li><a id="supervise_remark" href="javascript:void(0)" onclick="setUrl('remark');">${lfn:message('km-supervise:py.DuBanKaoPing')}</a>
                  </li>
              </ul>
          </ui:content>
          <!-- 其他操作 -->
          <kmss:authShow roles="ROLE_KMSUPERVISE_SETTING">
	          <ui:content title="${ lfn:message('km-supervise:py.QiTaCaoZuo') }">
		            <ul class='lui_list_nav_list'>
		            	<li>
							<a href="javascript:void(0)" onclick="moduleAPI.supervise.switchDoc(this,{ cri :{'docStatus':'00'},title :'废弃的流程'});resetMenuNavStyle(this);">
								<i class="fontmui">&#xe75c;</i>废弃的流程
							</a>
						</li>
						<li>
							<a href="javascript:void(0)" onclick="LUI.pageOpen('${LUI_ContextPath}/sys/recycle/import/sysRecycle_index.jsp?modelName=com.landray.kmss.km.review.model.KmReviewMain','_rIframe');resetMenuNavStyle(this);">
								<i class="fontmui">&#xe761;</i>回收站
							</a>
						</li>
		                <li><a href="${LUI_ContextPath}/sys/profile/index.jsp#app/ekp/km/supervise" target="_blank"><i class="fontmui">&#xe6a7;</i>${ lfn:message('list.manager') }</a>
		                </li>
		            </ul>
	          </ui:content>
	      </kmss:authShow>
	<script type="text/javascript">
	seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/mvc/module'], function($, strutil, dialog, topic, Module){
			window.setUrl= function (key,mykey,type){
				 if(key!="${key}"){
			    	 if(key == 'km_supervise_main'){
					        if(type ==''){
						         openUrl('','',key);
							    }else{
					    		 openUrl('km_supervise_main','cri.q='+mykey+':'+type,key);
						    }
					  }
			    	 if(key == 'project'){
			    		 var url = "${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain_project.jsp";
						 window.open(url,"_self");
			    	 }
			    	 if(key == 'remark'){
						 var url = "${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain_remark.jsp";
						 window.open(url,"_self");
					 }
				}else{
						openQuery();
						if(type==''){
							LUI('${criteria}').clearValue();
						}else{
						 	LUI('${criteria}').setValue(mykey, type);
						}
				}
			};
			window.openUrl = function(prefix,hash,key){
			    var srcUrl = "${LUI_ContextPath}/km/supervise/";
			    if(key==''){
			    	 srcUrl = srcUrl+"index.jsp";
			    }else{
				   srcUrl = srcUrl+ prefix+"/index.jsp";
			    }
				if(hash!=""){
					srcUrl+="#"+hash;
			    }
				window.open(srcUrl,"_self"); 
			};
			
			LUI.ready(function(){
		 		  // 初始化左则菜单样式
	      	  setTimeout("initMenuNav('${JsParam.key}')", 300);
			});
			// 左则样式
			window.initMenuNav = function(fdKey) {
				var mydoc = getValueByHash("mydoc");
				if(mydoc != "") {
					resetMenuNavStyle($("#"+fdKey+"_" + mydoc));
				}
				if(fdKey == "supervise"){
					resetMenuNavStyle($("#"+fdKey+"_" + "${criteria}"));
				}
			 }
			
			
			window.moduleAPI = window.moduleAPI || {};
			window.moduleAPI.supervise = {
				switchDoc:function(obj,evt){
					topic.publish('spa.change.reset', {
						value : evt.cri,
						target : obj
					});
					
					/* setTimeout(function(){
						var tabpanel = LUI('kmReviewPanel');
						tabpanel.props(0,{
							title : evt.title,
							visible : true
						});
					},100); */
				},	
				open : function(key, value) {
					LUI.pageHide("_rIframe");
					Spa.spa.setValue(key, value);
				},
				clear : function() {
					Spa.spa.clear();
				}
			};
			
			LUI.ready(function(){
				if(getFromHash('mydoc')){
					var type = getFromHash('mydoc');
					var title = '所有督办';
					switch(type){
						case 'duty' :  
							title = '我负责的';
							break;
						case 'manage' :  
							title = '我经办的';
							break;
						case 'concern' : 
							title = '我关注的';
							break;
						case 'copy' :  
							title = '抄送我的';
							break;
					}
					moduleAPI.supervise.switchDoc(null,{cri:{'mydoc':type},title:title});
				}
			});
			
	 		window.getFromHash = function(key){
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
	});
</script>
