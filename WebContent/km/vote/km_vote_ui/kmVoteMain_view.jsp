<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
    <template:replace name="head">
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmVoteMainForm.docSubject } - ${ lfn:message('km-vote:module.km.vote') }"></c:out>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams 
				moduleTitle="${ lfn:message('km-vote:module.km.vote') }" 
				modulePath="/km/vote/" 
				modelName="com.landray.kmss.km.vote.model.KmVoteCategory" 
				autoFetch="false"
				href="/km/vote/"
				categoryId="${kmVoteMainForm.fdCategoryId}" />
		</ui:combin>
	</template:replace>	
	<template:replace name="content">
	    <link href="${LUI_ContextPath}/km/vote/resource/css/vote.css" rel="stylesheet" type="text/css" />
	    <script type="text/javascript">
	   	 	seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
		   	 	LUI.ready( function() {
		   	 		showCountDown();
			   	 	var top = $(".lui_vote_titleBar").position().top;
			            $(window).scroll(function () {
			                var scrolls = $(this).scrollTop();
			                if (scrolls > top) { //如果滚动到页面超出了当前元素element的相对页面顶部的高度
			                    $(".lui_vote_titleBar_fixed").css("display", "block");
			                } else {
			                    $(".lui_vote_titleBar_fixed").css({
			                        "display": "none"
			                    });
			                }
			            });
			            $(".vote_tb_w .barline").each(function () {
			                var charts = $(this).find(".charts");
			                var width = charts.width();
			                charts.css("width", "0px").animate({ width: width }, 1200);
		
			            });
			            
			            var returnInfo = "${returnInfo}";
				   		if (returnInfo != null && returnInfo != ""){
				   			dialog.success(returnInfo);
				   			
				   		}  
				   		onloadCommentMsg(); 
		   	 	});

		   		//删除评论
				window.delComment = function(id){
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							
							$.post('<c:url value="/km/vote/km_vote_comment/kmVoteComment.do?method=delete"/>&fdId=' + id,
									'',delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
						$('#listview dd').empty();
						topic.publish("list.refresh");
					}
					dialog.result(data);
				};

				//终止投票
				window.terminateVote = function(url){
					dialog.confirm('<bean:message key="message.terminate.this.vote.confirm" bundle="km-vote" />',function(isOk){
						if(isOk){
							Com_OpenWindow(url,'_self');
						}	
					});
					return;
				};

				//删除投票
				window.deleteVote = function(delUrl){
					dialog.confirm('<bean:message key="message.delete.vote.confirm" bundle="km-vote" />',function(isOk){
						if(isOk){
							Com_OpenWindow(delUrl,'_self');
						}	
					});
					return;
				};
				window.checkMaxSecletNum = function(thisObj) {
			   		var num=0;
			   		var obj = document.getElementsByName("fdVoteItemIds");
			   		var maxNum = '${kmVoteMainForm.fdMaxOption}'==""?0:parseInt('${kmVoteMainForm.fdMaxOption}');
			   		for (var i=0; i<obj.length; i++) {
			   			if (obj[i].checked) {
			   				num++;
			   				if (maxNum != 0 && num > maxNum) {
			   					dialog.alert('<bean:message bundle="km-vote" key="error.select.max" arg0="${kmVoteMainForm.fdMaxOption}" />','','','',true);
			   					thisObj.checked = false;
			   					break;
			   				}
			   			}
			   		}
			   	}
			   	
			   	var isSubmit = false;
				window.validateData = function(){
					if(isSubmit){
							return ;
					} 
			   		var thisObj = document.getElementsByName("fdVoteItemIds"); 
			   		var num=0;
			   		for (var i=0; i<thisObj.length; i++) {
			   			if (thisObj[i].checked) {
			   				num++;	   				
			   			}
			   		}
			   		if (num>0){
			   			var docContent=document.getElementsByName("docContent")[0]; 
		   				var msg='<bean:message bundle="km-vote" key="kmVoteMain.commentDocContent" />';
		   				if(docContent!=null&&docContent.value==msg){  
		   					document.getElementsByName("docContent")[0].value="";
		   				   }  
		   				document.kmVoteMainForm.action='<c:url value="/km/vote/km_vote_main/kmVoteMain.do" />';
		   				
		   				var minOption = '${kmVoteMainForm.fdMinOption}'==""?0:parseInt('${kmVoteMainForm.fdMinOption}');
		   				var maxOption = '${kmVoteMainForm.fdMaxOption}'==""?0:parseInt('${kmVoteMainForm.fdMaxOption}');		   				
		   				if (num<minOption && minOption!=0){
		   					dialog.alert('<bean:message bundle="km-vote" key="error.select.min" arg0="${kmVoteMainForm.fdMinOption}" />','','','',true);
		   					return false;
	   					}
		   				if (num>maxOption && maxOption!=0){
		   					dialog.alert('<bean:message bundle="km-vote" key="error.select.max" arg0="${kmVoteMainForm.fdMaxOption}" />','','','',true);
		   					return false;
	   					}
		   				isSubmit = true;
		   				Com_Submit(document.kmVoteMainForm,'participatedVote');
		   				return true;
			   		}
			   		dialog.alert('<bean:message bundle="km-vote" key="error.item.required" />','','','',true);
			   		return false;
			   	} 
				//点击预览图片
				window.previewTooltip = function (e,obj){
					var tipContent = $(obj).find("img").attr("src");
					var datas = {
							data : [{value : tipContent}],
							value : tipContent,
							valueType:'url'
					};
					seajs.use([ 'lui/imageP/preview' ],function(preview) {
						preview({
							data : datas
						});
					});
				}
	   	 	});

	   	 function SetWinHeight(obj)
	   	{   
	   	    var win=obj;
	   	    if (document.getElementById)
	   	    {
	   	        if (win && !window.opera)
	   	        { 
	   	        	 if (win.contentDocument) {
	   	                if(win.contentDocument.body.offsetHeight) {
	   		            	//oIframe.style.height = oWin.document.body.scrollHeight + "px";
	   		                win.height = win.contentDocument.body.offsetHeight ; 
	   	                }else if(win.contentDocument.body.scrollHeight){
	   	                    win.style.height = win.contentDocument.body.scrollHeight;
	   	                }
	   	            }else if(win.document && win.document.body.scrollHeight)
	   	                win.height = win.Document.body.scrollHeight ;
	   	        }
	   	    } 
	   	}


	   	window.onload = function(){
	   		
	   	}

	   	
	   
	   	function onfocusClear(obj){ 
	   		var msg='<bean:message bundle="km-vote" key="kmVoteMain.commentDocContent" />';
	   		if(obj.value==msg){
	   			document.getElementsByName("docContent")[0].value="";
	   		}
	   	}

	   	function onblurClear(obj){ 
	   		var msg='<bean:message bundle="km-vote" key="kmVoteMain.commentDocContent" />';
	   		if(obj.value==""){
	   			document.getElementsByName("docContent")[0].value=msg;
	   		}
	   	}
	   	function onloadCommentMsg(){ 
	   		var msg='<bean:message bundle="km-vote" key="kmVoteMain.commentDocContent" />';
	   		var docContent = document.getElementsByName("docContent")[0];
	   		 if(docContent!=null){
	   			 document.getElementsByName("docContent")[0].value=msg;
	   		 }	 
	   	} 
	   	function filter(str){
	   		str = str.replace(/&lt;/g, "<");
	   		str = str.replace(/&gt;/g, ">");
	   		str = str.replace(/&amp;/g, "&");
	   		str = str.replace(/&quot;/g, "\"");
	   		str = str.replace(/&#034;/g, "\"");
	   		str = str.replace(/&#39;/g, "<");
	   		str = str.replace(/&lt;/g, "'");
	   		str = str.replace(/&#039;/g, "'");
	   		return str;
	   	}
	   	function confirmDelete(msg){
	   		var del = confirm("<bean:message key="page.comfirmDelete"/>");
	   		return del;
	   	}
	   	function delComment_old(id){
	   		if(!confirmDelete())return;
	   		var url="<c:url value='/km/vote/km_vote_comment/kmVoteComment.do' />?method=delete&fdId="+id;
	   		Com_OpenWindow(url,'_self');
	   	}
	   	
	  	//倒计时
		<% 
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
		
			String __currentTime = formatter.format(currentTime); //将日期时间格式化 
			request.setAttribute("currentTime",__currentTime); //将要调用的值传到页面request.setAttribute（“参数”，值）；
		%>
		var currentTimeString = '${currentTime}',//String类型
		currentTime = new Date(Date.parse(delimiterConvert(currentTimeString))).getTime(),//Long类型
		docFinishedTimeString = '${kmVoteMainForm.fdExpireTime}';//String类型
		fdVoteStatus = '${kmVoteMainForm.fdVoteStatus}';//投票状态
		docFinishedTime = null,//Long类型
		Timer = null;//定时器
		
		function showCountDown(){
			if(docFinishedTimeString && fdVoteStatus=='0'){
				docFinishedTime = new Date(Date.parse(delimiterConvert(docFinishedTimeString))).getTime();//Long类型
			 	if(docFinishedTime>currentTime){
					Timer = setInterval(_setInterval,1000);
				}
			}
		}
		function delimiterConvert(value){
			return value.replace(/-/g,'/');
		}
		function _setInterval(){
			var duration = docFinishedTime - currentTime;
			if(duration >= 1000*60){
				var day=parseInt( duration/(24*60*60*1000) ),
					hour=parseInt( duration % (24*60*60*1000) /(60*60*1000) ),
					minute=parseInt (duration % (60*60*1000) / (60*1000) ),
					second=parseInt (duration % (60*1000) / 1000 );
				var _text =  "${lfn:message('km-vote:kmVoteMain.expireTime.countdown')}";
				_text = _text.toLowerCase().replace(/%day%/g,day).replace(/%hour%/g,hour).replace(/%minute%/g,minute).replace(/%second%/g,second);
				$('._countdown').text(_text);
				docFinishedTime = docFinishedTime - 1000;
			}else{
				window.clearInterval(Timer);
				Timer = null;
				$('._countdown').empty();
				//var _text = "${lfn:message('km-pindagate:kmPindagateResponse.pindagate.hasFinished')}";
			}
		}
		
	   	</script>

  
    <div class="lui_vote_wrapper">
        <!-- 回到顶部 -->
        <div id="lui_common_top_divL" class="lui_common_top_divL">
            <a href="#top" class="lui_common_top_divR"><span class="lui_common_top_divM"></span>
            </a>
        </div>
        <!-- 当前位置 End -->
        <div class="main_body">
            <div class="lui_vote_view_box ">
                <!-- 操作按钮 Begin -->
                <div class="lui_vote_optionsBtn clrfix">
                    <ul class="clrfix">
                        <!-- 修改可投票者 -->
                        <c:if test="${kmVoteMainForm.fdVoteStatus=='0'|| kmVoteMainForm.docStatus =='10' || kmVoteMainForm.fdVoteStatus=='1'}">
                        	<kmss:auth 
								requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=edit&fdId=${param.fdId}" 
								requestMethod="GET"> 
		                        <li>
									<span><a onclick="Com_OpenWindow('kmVoteMain.do?method=editVoter&fdId=${param.fdId}&fdCategoryId=${kmVoteMainForm.fdCategoryId}','_target');">${lfn:message('km-vote:button.editVoter')}</a></span>
								</li>
							</kmss:auth>
						</c:if>
                        <!-- 编辑投票 -->
                        <c:if test="${kmVoteMainForm.fdVoteStatus=='0'|| kmVoteMainForm.docStatus =='10' || kmVoteMainForm.fdVoteStatus=='1'}"> 
							<kmss:auth 
								requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=edit&fdId=${param.fdId}" 
								requestMethod="GET">
								<li><span><a onclick="Com_OpenWindow('kmVoteMain.do?method=edit&fdId=${param.fdId}','_self');">${lfn:message('km-vote:button.editVote')}</a></span></li>
							</kmss:auth>
						</c:if>
                       <c:if test="${kmVoteMainForm.fdVoteStatus=='0'&&kmVoteMainForm.docStatus !='10'}"> 
	                        <!-- 终止投票 -->
							<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=terminateVote&fdId=${param.fdId}" requestMethod="GET">
								<li><span><a onclick="terminateVote('kmVoteMain.do?method=terminateVote&fdId=${param.fdId}');">
	                        		<bean:message bundle="km-vote" key="button.terminateVote"/></a></span>
	                        	</li>
							</kmss:auth>
	                        
	                        <!-- 催办投票 -->				
							<kmss:auth 
								requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=remindVote&fdId=${param.fdId}" 
								requestMethod="GET">
								<li>
									<span><a onclick="Com_OpenWindow('kmVoteMain.do?method=remindVote&fdId=${param.fdId}','_target');">${lfn:message('km-vote:button.remindVote')}</a></span>
								</li>
							</kmss:auth>
							
                       </c:if>
                       <!-- 投票明细-->
                        <c:if test="${kmVoteMainForm.fdVoteStatus=='0'||kmVoteMainForm.fdVoteStatus =='2'}"> 
							<kmss:auth 
								requestURL="/km/vote/km_vote_record/kmVoteRecord.do?method=viewVotedDetail&fdMainId=${param.fdId}" 
								requestMethod="GET">
								<li><span><a onclick="Com_OpenWindow('${ LUI_ContextPath }/km/vote/km_vote_record/kmVoteRecord.do?method=viewVotedDetail&fdMainId=${param.fdId}','_self');">${lfn:message('km-vote:button.viewVoted')}</a></span></li>
							</kmss:auth>
							 <!-- 投票人员信息-->
							<c:if test="${kmVoteMainForm.fdAuthVoteFlag eq 'false'}"> 
							<kmss:auth 
								requestURL="/km/vote/km_vote_record/kmVoteRecord.do?method=viewPersonDetail&fdMainId=${param.fdId}" 
								requestMethod="GET">
								<li><span><a onclick="Com_OpenWindow('${ LUI_ContextPath }/km/vote/km_vote_record/kmVoteRecord.do?method=viewPersonDetail&fdMainId=${param.fdId}','_self');">${lfn:message('km-vote:button.viewPersonDetail')}</a></span></li>
							</kmss:auth>
							</c:if>
						</c:if>
                        <!-- 删除 -->
						<kmss:auth 
							requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=delete&fdId=${param.fdId}" 
							requestMethod="GET">
							 <li><span><a onclick="deleteVote('kmVoteMain.do?method=delete&&fdId=${param.fdId}');">${lfn:message('km-vote:button.delete')}</a></span></li>
						</kmss:auth>
								
                    </ul>
                </div>
                <!-- 操作按钮 End -->
                <!-- 投票标题 Begin -->
                <div class="lui_vote_titleBar">
                    <div class="vote_img">
                        <img src="${ LUI_ContextPath }/km/vote/resource/images/vote_logo.png" />
                    </div>
                    <h1 class="title" style="word-wrap:break-word; overflow:hidden;">
                        <c:out value="${kmVoteMainForm.docSubject}" />
					</h1>
                        
						
                    <p class="p1">
                    	<bean:message bundle="km-vote" key="kmVoteMain.docCreateTime" />${lfn:message('km-vote:kmVoteMain.colon')}<c:out value="${kmVoteMainForm.docCreateTime}" /><em>|</em>
                        <bean:message bundle="km-vote" key="kmVoteMain.fdEffectTime" />${lfn:message('km-vote:kmVoteMain.colon')}<c:out value="${kmVoteMainForm.fdEffectTime}" /><em>|</em> 
                        <bean:message bundle="km-vote" key="kmVoteMain.fdExpireTime" />${lfn:message('km-vote:kmVoteMain.colon')}
                        <c:if test="${not empty kmVoteMainForm.fdExpireTime}"><c:out value="${kmVoteMainForm.fdExpireTime}" /><em></em></c:if>
                        <c:if test="${empty kmVoteMainForm.fdExpireTime}">${lfn:message('km-vote:kmVoteMain.null.not.limit.time')}<em></em></c:if>
                        <c:if test="${not empty kmVoteMainForm.fdExpireTime && kmVoteMainForm.fdVoteStatus=='0'}">
                        	<img style="margin-bottom:-2px;" src="../resource/images/countdown.png" /><span class="_countdown"></span>
                        </c:if>
                  	</p>
                    <div class="vote_num">
                        <p class="p2">
                            ${kmVoteMainForm.fdVoteNum}</p>
                        <p class="p3">
                            	${lfn:message('km-vote:kmVoteMain.fdVoteNum')}
                        </p>
                    </div>
                </div>
                <!-- 投票标题 End -->
                <!-- 投票标题 固定 Begin -->
                <div class="lui_vote_titleBar_fixed" style="display: none;">
                    <div class="lui_vote_titlebar_w">
                        <div class="main_body" style="width:90%; min-width:980px;max-width:${ fdPageMaxWidth };">
                            <div class="lui_vote_titleBar ">
                                <div class="vote_img">
                                    <img alt="" src="${ LUI_ContextPath }/km/vote/resource/images/vote_logo.png" />
                                </div>
                                <h1 class="title">
                                   <c:out value="${kmVoteMainForm.docSubject}"/></h1>
                                <p class="p1">
                                    <bean:message bundle="km-vote" key="kmVoteMain.docCreateTime" />${lfn:message('km-vote:kmVoteMain.colon')}<c:out value="${kmVoteMainForm.docCreateTime}" /><em>|</em>
                                    <bean:message bundle="km-vote" key="kmVoteMain.fdEffectTime" />${lfn:message('km-vote:kmVoteMain.colon')}<c:out value="${kmVoteMainForm.fdEffectTime}" /><em>|</em>
                                    <bean:message bundle="km-vote" key="kmVoteMain.fdExpireTime" />${lfn:message('km-vote:kmVoteMain.colon')}
                                     <c:if test="${not empty kmVoteMainForm.fdExpireTime}"><c:out value="${kmVoteMainForm.fdExpireTime}" /><em></em></c:if>
                        			 <c:if test="${empty kmVoteMainForm.fdExpireTime}">${lfn:message('km-vote:kmVoteMain.null.not.limit.time')}<em></em></c:if>
                        			 <c:if test="${not empty kmVoteMainForm.fdExpireTime && kmVoteMainForm.fdVoteStatus=='0'}">
			                        	<img style="margin-bottom:-2px;" src="../resource/images/countdown.png" /><span class="_countdown"></span>
			                         </c:if>
                                 </p>
                                <div class="title_btnBar">
                                    <ul class="clrfix">
                                        <c:if test="${kmVoteMainForm.docStatus !=10}"> 
									<%---		<c:if test="${kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsVoted != 'true' && requestScope.showResult != 'true'}">
												<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=participatedVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
													<li class="vote_btn_submit"><span><a onclick="validateData();">${lfn:message('km-vote:button.submitVote')}</a></span></li>
												</kmss:auth>
											</c:if>
								 			<c:if test="${kmVoteMainForm.fdVoteStatus != '1' && requestScope.showResult != 'true'}">
												<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=viewResult&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
													<li class="vote_btn_view"><span><a onclick="Com_OpenWindow('kmVoteMain.do?method=viewResult&fdId=${kmVoteMainForm.fdId}', '_self');" >${lfn:message('km-vote:button.viewResult')}</a></span></li>
												</kmss:auth>
											</c:if>---%>
										</c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 投票标题 固定 End -->
                <!-- 投票内容 Begin -->
                <html:form action="/km/vote/km_vote_main/kmVoteMain.do" method="GET">
                <html:hidden property="sleep" value="${HtmlParam.sleep}" />
				<html:hidden property="method" value="participatedVote" />
				<html:hidden property="fdId" value="${HtmlParam.fdId}" />
                <div class="lui_vote_contents">
                    <p class="abstract" style="word-break:break-all;">
                        <c:if test="${not empty kmVoteMainForm.fdDescription}">
                        	<span style="padding-left: 4px;"><xform:textarea property="fdDescription"></xform:textarea></span>
                        </c:if>
					</p>
                   <div class="vote_tb_w">
                   <c:if test="${kmVoteMainForm.fdIsRadio == 'false'}">    
                      <h4>
                            <em>${lfn:message('km-vote:kmVoteMain.checkbox.description')}</em>
                            
							(<bean:message bundle="km-vote" key="kmVoteMain.checkbox.min" />
                            <c:choose>
	                           	<c:when test="${kmVoteMainForm.fdMinOption>0}">                    		
									<c:out value="${kmVoteMainForm.fdMinOption}" />
									<bean:message bundle="km-vote" key="kmVoteMain.item" />
	                           	</c:when>
	                           	<c:otherwise>
	                           		<bean:message bundle="km-vote" key="kmVoteMain.checkbox.msg" />
	                           	</c:otherwise>
                           	</c:choose>,
                           	<bean:message bundle="km-vote" key="kmVoteMain.checkbox.max" />    
                           	<c:choose>             	
	                           	<c:when test="${kmVoteMainForm.fdMaxOption>0}">							
									<c:out value="${kmVoteMainForm.fdMaxOption}" />
									<bean:message bundle="km-vote" key="kmVoteMain.item" />
								</c:when>
								<c:otherwise>
									<bean:message bundle="km-vote" key="kmVoteMain.checkbox.msg" />                         		
	                           	</c:otherwise>
                           	</c:choose>)
                      </h4>
                   </c:if>
                   <c:if test="${kmVoteMainForm.fdIsRadio != 'false'}">    
                      <h4>
                            <em>${lfn:message('km-vote:kmVoteMain.radio.description')}</em>
                      </h4>
                   </c:if>
                   <table >
                   <c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
                   		<c:choose>
                   			<c:when test="${kmVoteMainForm.fdDisplay eq 'true'}">
                   				<c:if test="${vstatus.index % (kmVoteMainForm.fdCount) == 0}">
				                  <tr>
				               </c:if>
                   			</c:when>
                   			<c:otherwise>
                   				<tr>
                   			</c:otherwise>
                   		</c:choose>
                           <td style="width:15px;padding-bottom: 10px;padding-top: 3px;">
                              	<c:if test="${kmVoteMainForm.fdIsRadio == 'false'}">
                              		<c:if test="${kmVoteMainForm.fdIsVoted != 'true' &&kmVoteMainForm.fdVoteStatus == '0'}">
	                              		<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
											<input type="checkbox" id="_fdVoteItemIds${vstatus.index+1}_" name="fdVoteItemIds" value="${kmVoteMainItemForm.fdId}" onclick="checkMaxSecletNum(this);"  />
										</kmss:auth>
									</c:if>		
								</c:if>
								<c:if test="${kmVoteMainForm.fdIsRadio == 'true'}">
									<c:if test="${kmVoteMainForm.fdIsVoted != 'true' &&kmVoteMainForm.fdVoteStatus == '0'}">
										<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
											<input type="radio" id="_fdVoteItemIds${vstatus.index+1}_" name="fdVoteItemIds" value="${kmVoteMainItemForm.fdId}" />
										</kmss:auth>
									</c:if>
								</c:if>
                           </td>
                           <c:choose>                           
	                           <c:when test="${not empty kmVoteMainItemForm.fdAttId}">  
		                           	<td style="width:15%;">	
		                           		<label for="_fdVoteItemIds${vstatus.index+1}_" onclick="previewTooltip(event, this)">                          	                        
				                      		<img src="${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?${LUI_Cache}&method=download&fdId=${kmVoteMainItemForm.fdAttId}" 
				                       		style="width:120px; min-height:120px;background:#fff; padding:3px; text-align:center; border:1px solid #e4e4e4;"  disabled=" "/>		                       		                       	 
			                       		</label>
			                       	</td>
		                      	</c:when>
		                      	<c:otherwise>
		                      		<td style="display:none;">		                      			
		                      		</td>
		                      	</c:otherwise>
	                     	</c:choose>
                          <td style="padding-bottom: 10px;font-size:13px;" class="com_subject" colspan="2">
	                          <label for="_fdVoteItemIds${vstatus.index+1}_">
	                          	<script type="text/javascript">     
	                          		document.write('<c:out value="${kmVoteMainItemForm.fdName}"  />');																			
								</script>								
	                		  </label>
                          </td>
                        <c:choose>
                   			<c:when test="${kmVoteMainForm.fdDisplay eq 'true'}">
                   				<c:if test="${(vstatus.index-((kmVoteMainForm.fdCount)-1)) % (kmVoteMainForm.fdCount) == 0}">
				                  </tr>
				               </c:if>
                   			</c:when>
                   			<c:otherwise>
                   				</tr>
                   			</c:otherwise>
                   		</c:choose>
                      </c:forEach>
                   </table>  
                     <c:choose>
                      		<%-- 当投票可查看，而且有设置例外人员时，要判断当前用户是否在例外人员之中，在则不显示，不在则正常显示 --%>
                       		<c:when test="${not empty kmVoteMainForm.fdViewerIds and (fn:contains(kmVoteMainForm.fdViewerIds,KMSS_Parameter_CurrentUserId))}">
                       		  <h4>
		                        <em>${lfn:message('km-vote:kmVoteMain.viewVote.voteResult')}</em>
		                      </h4>
		                      <%@ include file="/km/vote/km_vote_ui/kmVoteMain_result.jsp" %>
                       		</c:when>
                       		<c:otherwise>
                       		 <c:if test="${(kmVoteMainForm.fdIsVoted  eq 'true' and kmVoteMainForm.fdVoterViewFlag == true) or (kmVoteMainForm.fdVoterViewFlag == false and  KMSS_Parameter_CurrentUserId eq kmVoteMainForm.docCreatorId) }">
                       		  	<h4>
			                       <em>${lfn:message('km-vote:kmVoteMain.viewVote.voteResult')}</em>
			                   </h4>
                             	 <%@ include file="/km/vote/km_vote_ui/kmVoteMain_result.jsp" %>
	                  		 </c:if>
                     		</c:otherwise>
                    </c:choose>
                       <%---填写评论---%>
					<c:if test="${kmVoteMainForm.docStatus !=10 &&kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsAllowSay=='true' && kmVoteMainForm.fdIsVoted != 'true'}">
				      <kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
				       		<TEXTAREA   class="inputmul txtarea"   name='docContent'  onfocus="onfocusClear(this)"  onblur="onblurClear(this)"></TEXTAREA>  
				       </kmss:auth>
				     </c:if>
					     
					  <c:if test="${kmVoteMainForm.docStatus !=10 && kmVoteMainForm.fdVoteStatus == '0'&& kmVoteMainForm.fdIsVoted == 'true'}">   
						   <div class="lui_vote_voted_box">
						   		<span class="lui_vote_voted_tip">${lfn:message('km-vote:kmVoteMain.voted.tip')}</span>
						   </div>
					   </c:if>
					   <!-- 投票已结束 -->
					   <c:if test="${kmVoteMainForm.docStatus !=10 && kmVoteMainForm.fdVoteStatus == '2'}">   
						   <div class="lui_vote_voted_box">
						   		<span class="lui_vote_ended_tip">${lfn:message('km-vote:kmVoteMain.ended.tip')}</span>
						   </div>
					   </c:if>
                        
                        <div class="p1">
                            <div class="title_btnBar">
                                <ul class="clrfix">
                                    <c:if test="${kmVoteMainForm.docStatus !=10 &&kmVoteMainForm.fdVoteStatus == '0' && kmVoteMainForm.fdIsVoted != 'true'}"> 
										
											<kmss:auth requestURL="/km/vote/km_vote_main/kmVoteMain.do?method=submitVote&fdId=${kmVoteMainForm.fdId}" requestMethod="GET">
												<li class="vote_btn_submit"><span><a onclick="validateData();"><bean:message bundle="km-vote" key="button.submitVote" /></a></span></li>
											</kmss:auth>
									</c:if>
                                </ul>
                            </div>
                        </div>
           
                          <c:import url="/km/vote/km_vote_main/kmVoteMain.do?method=moreVoting&voteStatus=0&fdCurVoteId=${kmVoteMainForm.fdId}" charEncoding="UTF-8">
						   </c:import> 
                   
                    </div>
                </div>
                </html:form>
                <!-- 投票内容 End -->
            </div>
            <!-- 评论内容 Begin-->
      
			<c:import url="/km/vote/km_vote_comment/kmVoteComment_list.jsp" charEncoding="UTF-8">
				<c:param name="fdVoteMainId" value="${param.fdId}"/>
			</c:import>
               
            <!-- 评论内容 End-->
        </div>
    </div>				
	</template:replace>	

</template:include>