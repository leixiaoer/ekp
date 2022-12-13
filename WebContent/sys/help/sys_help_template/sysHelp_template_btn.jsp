<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<kmss:authShow roles="ROLE_SYSHELP_DEFAULT">
<c:if test="${ sysHelpIsLoad != 'true' }">
	<style>
		.helpImg{
			width: 40px !important;
		    height: 40px !important;
		    margin: 4px !important;
		}
		.sysHelpBtnFixed{   
			visibility: visible !important;
		}
	</style>
	<ui:button parentId="top" styleClass="lui-praise-btn sysHelpBtnFixed" order="9" onclick="toHelpPage()" id="sysHelpBtn" style="display:none">
		<img class="helpImg" src="${LUI_ContextPath}/sys/help/sys_help_template/image/helpImage.png">
	</ui:button> 
		
	
	<script>
		LUI.ready(function(){
			seajs.use(['lui/jquery', 'lui/toolbar'], function($, toolbar){
				$.ajax({
					url: '${LUI_ContextPath}/sys/help/sys_help_module/sysHelpModule.do?method=checkIsShowBtn',
					type: 'post',
					dataType: 'json',
					data: {
						'url': window.location.pathname + window.location.search
					},
					success: function(data) {
						if(data){
							// #96935,ie8图标位置错误
							var isAdminMenu =parent.window.location.href.indexOf("sys/profile") >=0;
							// alert("isAdminMenu=>"+isAdminMenu+","+window.location.href);
							if(checkIE8() && isAdminMenu){
								$('#sysHelpBtn').css('float', 'right');
							}
							
							// #97000 防止出现2个按钮
							var tIsAdminIfm = top.window.location.href.indexOf("management") >=0 ;
							// alert("tIsAdminIfm=>"+tIsAdminIfm);
							// alert("top.window.location.href=>"+top.window.location.href);
							// alert("window.location.href=>"+window.location.href);

                            // 极速模式
                            if (top.window.location.href.indexOf("j_start") >= 0) {
                                if (tIsAdminIfm) {
                                    // console.log("极速模式")
                                    if (parent.parent.window.document.getElementById("sysHelpBtn")) {
                                        var ppbtn = parent.parent.window.document.getElementById("sysHelpBtn");
                                        // console.log("parent.parent=>", parent.parent.window.document);
                                        // console.log("parent.parent btn=>", parent.parent.window.document.getElementById("sysHelpBtn"))
                                        // console.log($(ppbtn).css("display"));
                                        if ($(ppbtn).css("display") == "block") {
                                            // $(ppbtn).css("display","none");
                                            $('#sysHelpBtn').css('display', 'none');
                                            // $('#sysHelpBtn').css('display', 'block');

                                            $(ppbtn).removeAttr("onclick");
                                            var childUrl = window.location.pathname + window.location.search;
                                            // alert("childUrl=>"+childUrl)
                                            $(ppbtn).attr("onclick", "toHelpPageIframe('"+childUrl+"');");
                                        }
                                    } else {
                                        $('#sysHelpBtn').css('display', 'block');
                                    }
                                } else {
                                    // 普通页面
                                    //console.log("parent.parent=>", parent.parent.window.document);
                                    //console.log("parent.parent btn=>", parent.parent.window.document.getElementById("sysHelpBtn"))
                                    //console.log($(ppbtn).css("display"));
                                    $('#sysHelpBtn').css('display', 'block');
                                }
                                return;
                            }
							
							// 兼容模式
							if(tIsAdminIfm && top.window.location.href!=window.location.href){
								var tHelpBtns = $(top.window.document).find(".sysHelpBtnFixed");
								if(tHelpBtns.length>0){
									var tHelpBtn=tHelpBtns[0];
									// alert($(tHelpBtn).css("display"))
									var tp = $(top.window.document).find("#top")[0];
									// alert($(tp).css("display"));
									if(tHelpBtn && $(tHelpBtn).css("display")=="block"){
										// chrome再次点击修复
										 if(tp&& $(tp).css("display")=="block"){
											 $('#sysHelpBtn').css('display', 'none');
										 }else{
											 $('#sysHelpBtn').css('display', 'block'); 
										 }
									}else{
										$('#sysHelpBtn').css('display', 'block');
									}
								}else{
									$('#sysHelpBtn').css('display', 'block');
								}
							}else{
								$('#sysHelpBtn').css('display', 'block');
							}
						}
					}
				});
			});
		});
		
		function checkIE8(){
			var isIE8=false;
			var DEFAULT_VERSION = 8.0;  
            var ua = navigator.userAgent.toLowerCase();  
            var isIE = ua.indexOf("msie")>-1;  
            var ieVersion;  
            if(isIE){  
            	ieVersion = ua.match(/msie ([\d.]+)/)[1];  
            }  
            if(ieVersion <= DEFAULT_VERSION ){  
                // alert('系统检测到您正在使用ie8以下内核的浏览器，不能实现完美体验，请更换或升级浏览器访问！');
            	isIE8=true;
            };
            return isIE8;
		}
	</script>
	
	<script>
		function toHelpPage(){
			var fdUrl = window.location.pathname + window.location.search;
			toHelpPageByUrl(fdUrl);
		}

		function toHelpPageIframe(childUrl) {
            // alert("admin里面修改过的click方法，"+(top.window.location.href.indexOf("management")));
            
            var fdUrl = window.location.pathname + window.location.search;
            
            if(top.window.location.href.indexOf("management")>=0){
            	// alert("childUrl=>"+childUrl);
            	toHelpPageByUrl(childUrl);
            }else{
            	// alert("fdUrl=>"+fdUrl);
            	toHelpPageByUrl(fdUrl);
            }
        }

		function toHelpPageByUrl(fdUrl){
			seajs.use(['lui/jquery', 'lui/dialog'], function($, dialog){
				var url = '${LUI_ContextPath}/sys/help/sys_help_config/sysHelpConfig.do?method=findConfigByUrl';
				$.ajax({
					url: url,
					type: 'post',
					dataType: 'json',
					data: {
						'fdUrl': fdUrl
					},
					success: function(data) {
						if(data.message == 'noData'){
							dialog.alert('<bean:message bundle="sys-help" key="sysHelpConfig.template.nodata" />');
						}else if(data.message == 'more'){
							dialog.alert('<bean:message bundle="sys-help" key="sysHelpConfig.template.more" />');
						}else{
							Com_OpenWindow('${LUI_ContextPath}/sys/help/sys_help_main/sysHelpMain.do?method=findHTMLById&fdId='+data.mainId+'&configId='+data.configId,'_blank')
						}
					}
				});
			});
		}
	</script>
</c:if>
</kmss:authShow>