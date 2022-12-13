<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.ModelUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.km.pindagate.forms.KmPindagateMainForm"%>
<%
	Date now = new Date();
	request.setAttribute("now", now.getTime());
	ISysAttMainCoreInnerService sysAttMainCoreInnerService=(ISysAttMainCoreInnerService)
			SpringBeanUtil.getBean("sysAttMainService");
	KmPindagateMainForm form=(KmPindagateMainForm)request.getAttribute("kmPindagateMainForm");
	List list=sysAttMainCoreInnerService.findByModelKey("com.landray.kmss.km.pindagate.model.KmPindagateMain",form.getFdId(),"pic");
	if(list!=null && list.size()>0){
		SysAttMain att=(SysAttMain)list.get(0);
		request.setAttribute("pictureUrl","/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=big&fdId="+att.getFdId());
	}else{
		request.setAttribute("pictureUrl", "/km/pindagate/resource/images/pindagate_bg.jpg");
	}
%>
<template:include ref="mobile.edit" compatibleMode="true">

	<template:replace name="title">
		<c:out value="${kmPindagateMainForm.docSubject}"></c:out>
	</template:replace>
	
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/pindagate/mobile/resource/css/edit.css?s_cache=${MUI_Cache}" />
		<mui:min-file name="mui-pindagate.js"/>
		<mui:min-file name="mui-pindagate-question.js"/>
	</template:replace>

	<template:replace name="content">
		<html:form action="/km/pindagate/km_pindagate_response/kmPindagateResponse.do" onsubmit="return canSubmit();">
			<html:hidden property="fdId"/>
			<html:hidden property="fdQuetionairId"/>
			<html:hidden property="docStatus" value="30" />
			<html:hidden property="method_GET"/>
			<input type="hidden" id="fdRelationCheck" value="">
			<input type="hidden" id="noType" value="0">
			<input type="hidden" id="noTypes">
			<c:forEach items="${kmPindagateResponseForm.fdItems}" var="KmPindagateQuestionResForm" varStatus="vstatus">					
				<input type="hidden" name="fdItems[${vstatus.index}].fdDraftAnswer" value="${KmPindagateQuestionResForm.fdAnswer}">
				<input type="hidden" name="fdItems[${vstatus.index}].fdDraftAnswerTxt" value="${KmPindagateQuestionResForm.fdAnswerTxt}">
				<input type="hidden" name="fdItems[${vstatus.index}].fdDraftRelHide" value="${KmPindagateQuestionResForm.fdRelationHide}">
				<input type="hidden" name="fdItems[${vstatus.index}].fdDraftOther" value="${KmPindagateQuestionResForm.fdOther}">	
				<input type="hidden" name="fdItems[${vstatus.index}].fdDraftSelectReason" value="${KmPindagateQuestionResForm.fdSelectReason}">					
			</c:forEach>
			
			<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView">
				<%-- 基本信息 --%>
				<div id="basicInfoView">
					<section class="muiPindagateHeader">
						<div class="muiPindagateHeaderImgBox">
							<%-- 标题图片 --%>
							<img alt="" src="${LUI_ContextPath}${pictureUrl}">
							<%-- 标题 --%>
							<h4 class="muiPindagateHeaderTitle">
								<span><c:out value="${kmPindagateMainForm.docSubject}"></c:out></span>
							</h4>
						</div>
						<%-- 状态 --%>
						<div id="muiPindagateStatusBtn" class="muiPindagateStatusBtn">
							<c:choose>
								<c:when test="${kmPindagateMainForm.docStatus=='30'}">
									${ lfn:message('km-pindagate:kmPindagate.tree.status.publish') }
								</c:when>
								<c:when test="${kmPindagateMainForm.docStatus=='31'}">
									${ lfn:message('km-pindagate:kmPindagate.tree.status.indagating') }
								</c:when>
								<c:when test="${kmPindagateMainForm.docStatus=='32'}">
									${ lfn:message('km-pindagate:kmPindagate.tree.status.complete') }
								</c:when>
							</c:choose>
						</div>
						<div class="muiPindagateHeaderTooltip">
							<%--截止日期 --%>
							<div class="muiPindagateTimeCard"></div>
							<%-- 参加人数 --%>
							<p class="muiPindagateHomePeople">
								<i class="mui mui-person"></i>
								<c:out value="${kmPindagateMainForm.fdParticipantNum }"></c:out><bean:message bundle="km-pindagate" key="mobile.kmPindagateMain.person" /> 
							</p>
						</div>
					</section>
					<c:if test="${not empty kmPindagateMainForm.fdQuestionExplain}">
						<section class="muiPindagateHomeBody" id='fdQuestionExplainSection'>
							<%-- 问卷说明 --%>
							<p class="muiPindagateHomeTxt">
								<c:out value="${kmPindagateMainForm.fdQuestionExplain }" escapeXml="false"></c:out>
								<script type="text/javascript">
									require(['mui/rtf/RtfResize','dojo/ready'],function(Rtf,ready){
										ready(function(){
											new Rtf({
												containerNode:document.getElementById('fdQuestionExplainSection')
											});
										});
									});
								</script>
							</p>
						</section>
					</c:if>
				</div>
				<!--底部按钮-->
				<ul id='TabBar' data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				<c:if test="${isPindagateFinish !='1'}">
					<c:if test="${canResponse}">
					<c:if test="${canReject==true}">
	            	 <c:if test="${isReject!=true}">
						<li data-dojo-type="mui/tabbar/TabBarButton"  class="muiBtnSubmit muiPindagateSubmit" 
							  	data-dojo-props="colSize:1,href:'/km/pindagate/km_pindagate_reject/kmPindagateRejectPerson.do?method=add&pindageteId=${param.pindageteId}'">
							  		<i class="mui mui-cancel"></i> <bean:message bundle="km-pindagate" key="kmPindagateMain.notParticipate"/>
						</li>
					</c:if>
					</c:if>
					</c:if>
				  	<c:if test="${canResponse}">
				  	<c:if test="${isReject!=true}">	
					  	<li data-dojo-type="mui/tabbar/TabBarButton" id="beginPindagateBtn" class="muiBtnSubmit muiPindagateSubmit" 
						  	data-dojo-props='colSize:1' onclick="window.beginPindagate();">
						  		<i class="mui mui-survey"></i> <bean:message bundle="km-pindagate" key="mobile.kmPindagateMain.participate.soon" />
						 </li>
					 </c:if>
					</c:if>
					</c:if>
				</ul>
			</div>
			<div id="questionView" class="gray" data-dojo-type="mui/view/DocScrollableView" data-dojo-props="scrollDir:''">
				<div id="responseList"   data-dojo-type="km/pindagate/mobile/resource/js/QuestionResponseList" data-dojo-props="cardCount:'${cardCount}'">
					<%-- 序号、页码 --%>
					<% int serialNum = 0; int pageno=1; %>
					<c:forEach items="${kmPindagateMainForm.fdItems}" var="kmPindagateQuestionForm" varStatus="vstatus">
					
						<%-- 题型 --%>
						<c:if test="${kmPindagateQuestionForm.fdSplit != 'true'}">
							<% serialNum++; %>
							<div data-dojo-type="km/pindagate/mobile/resource/js/QuestionResponse" class="muiResponse" name="questionResoinseKey${vstatus.index}"  data-dojo-props="index:${vstatus.index}">
								<input type="hidden" class="questionDef" value="${kmPindagateQuestionForm.fdQuestionDefView}" >
								<input type="hidden" id="relationDef${vstatus.index}" class="relationDef" value="${kmPindagateQuestionForm.fdRelationDefView}" >
								<input type="hidden" id="type${vstatus.index}" class="type" value="${kmPindagateQuestionForm.fdType}">
								<input type="hidden" class="typeName" value="${kmPindagateQuestionForm.fdTypeName}">
								<input type="hidden" class="split" name="fdSplit" value="${kmPindagateQuestionForm.fdSplit}">
								<input type="hidden" class="serialNum" value="<%=serialNum%>">
								<input type="hidden" class="pageno" value="<%=pageno%>">
								<input type="hidden" class="title" value="<c:out value="${kmPindagateQuestionForm.fdName}"/>">
								<input type="hidden" class="subjectImg">
								<input type="hidden" name="fdItems[${vstatus.index}].fdQuetionairResId" value="${kmPindagateResponseForm.fdId}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionId" value="${kmPindagateQuestionForm.fdId}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateQuestionForm.fdOrder}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdRelationShow" value="">
							</div>
						</c:if>
						
						<%-- 分页符 --%>
						<c:if test="${kmPindagateQuestionForm.fdSplit == 'true'}">
							<% pageno++; %>
							<div class="muiSplit">
								<input type="hidden" id="type${vstatus.index}" class="type" value="${kmPindagateQuestionForm.fdType}">
								<input type="hidden" class="typeName" value="${kmPindagateQuestionForm.fdTypeName}">
								<input type="hidden" class="split" name="fdSplit" value="${kmPindagateQuestionForm.fdSplit}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdQuetionairResId" value="${kmPindagateResponseForm.fdId}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionId" value="${kmPindagateQuestionForm.fdId}">
								<input type="hidden" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateQuestionForm.fdOrder}">
							</div>
						</c:if>
					</c:forEach>
					<input type="hidden" id="questionSize" value="<%=serialNum%>">
					<input type="hidden" id="navSgin" name="navSgin" value="">
					<%-- 分页组件
					<div data-dojo-type="km/pindagate/mobile/resource/js/QuestionPage"
						data-dojo-props="currentPage:1,totalPage:<%=pageno%>" >
					</div> 
					--%>
				  <!-- 底栏 starts -->
				   <div class="pindagate_nav" id="pindagateNav"/>
				  <!-- 底栏 ends -->
					
					
				 <!-- 所有题目 starts -->
			    <div class="pindagate_all">
			    <div class="pindagate_all_shadow"></div>
			      <div class="pindagate_all_panel">
			        <div class="pindagate_all_panel_tit">
			          <p class="pindagate_all_panel_tit_must"><i>*</i><bean:message bundle="km-pindagate" key="kmPindagateMain.MustAnswer"/></p>
			          <p class="pindagate_all_panel_tit_will"><span></span><bean:message bundle="km-pindagate" key="kmPindagateMain.Unanswered"/></p>
			          <p class="pindagate_all_panel_tit_done"><span></span><bean:message bundle="km-pindagate" key="kmPindagateMain.Answer"/></p>
			        </div>
			        <div class="pindagate_all_panel_body" id="allPanelBody"></div>
			      </div>
			    <!-- 所有题目 ends -->
			    <!-- 蒙板 starts -->
			   <!--  <div class="pindagate_mask"> -->
			      </div>
			    </div>
			   <!-- 蒙板 ends -->
			</div>
		</html:form>
	</template:replace>


</template:include>
<script>
	// 所有题目，保存所有题目，答案，是否可显示
	window.allTopics = [];
	require(['dijit/registry', "dojo/dom-construct", "dojo/dom-style", "dojo/dom-geometry", "dojo/dom-class", 'dojox/mobile/TransitionEvent',
        "dojo/ready", "dojo/date", "mui/calendar/CalendarUtil", "dojo/query", "mui/dialog/BarTip", "dojo/_base/window", "dojo/topic", "dojo/request",
        "dojo/on", "dojo/dom"],
    function (registry, domConstruct, domStyle, domGeo, domClass, TransitionEvent, ready, date, calendarUtil, query, BarTip, win, topic, request, on, dom) {
		ready(function() {
			var questionSize = query("#questionSize").val(),
            countAllSize = questionSize,
            countUpSize = questionSize,
            navStr = [],
            countTopic = 0,
            typeSign = [],
            typeUp = [],
            noTypes = [],
            noType = 0;
	        allRelation = {};
	        for (var u = 0; u < questionSize; u++) {
	            var fdTypeVal = query("input[id='type" + u + "']").val();
	            if (!fdTypeVal) {
	                typeSign.push(u);
	                countAllSize = parseInt(countAllSize) + parseInt("1");
	            }
	        }
	        for (var u = 0; u < questionSize; u++) {
	            var fdTypeVal = query("input[id='type" + u + "']").val();
	            if (!fdTypeVal) {
	                typeUp.push(u);
	                countUpSize = parseInt(countUpSize) - parseInt("1");
	            }
	        }
	        for (var u = 0; u < countAllSize; u++) {
	            var fdRelationDef = query('#relationDef' + u).val();
	            var fdTypeVal = query("input[id='type" + u + "']").val();
	            if (!fdTypeVal) {
	                noType++;
	                noTypes.push(u);
	            }
	            if (fdRelationDef == "" || fdRelationDef == "{}" || fdRelationDef == "undefined ") {
	            	// 增加一个正常的题目（正常显示）
	            	allTopics.push({"isShow": true, "isRel": false, "topic": u});
	                continue;
	            }
	            // 增加一个有关联的题目（有条件性的显示）
	            allTopics.push({"isShow": false, "isRel": true, "topic": u});
	            if (fdRelationDef) {
	                var relationJson = JSON.parse(fdRelationDef),
	                    relationSend = {};
	                for (var f in relationJson) {
	                    var number = f,
	                        showValue = query("input[name='fdItems[" + relationJson[f].topic + "].fdRelationShow']").val();
	                    //showTopic：第几题，relationOp:是否选择
	                    relationSend[number] = {
	                        showTopic: u, relationItem: relationJson[f].itemVals, relationOpt: relationJson[f].opt,
	                        relationSel: relationJson[f].multiseSel, relationFlag: relationJson[f].flagRelation,
	                        topic: relationJson[f].topic
	                    };
	                }
	                if (!relationJson[f]) {
	                    continue;
	                }
	                query("input[name='fdItems[" + relationJson[f].topic + "].fdRelationShow']").val(JSON.stringify(relationSend));
	
	
	                //$("input[name='navSgin']").val(JSON.stringify(""));
	                var divaa = document.querySelector("[name='questionResoinseKey" + u + "']");
	                var methodGet = query("input[name='method_GET']").val();
	
	
	                var topicSgin = query("input[name='fdItems[" + u + "].fdDraftRelHide']").val();
	                if (methodGet == "add") {
	                    divaa.style.display = "none";
	                    var navCount = parseInt(u) + parseInt("1");
	                    for (var n in noTypes) {
	                        if (parseInt(u) > parseInt(noTypes[n])) {
	                            navCount = parseInt(navCount) - parseInt("1");
	                        }
	                    }
	                    navStr[countTopic] = navCount;
	                    query("input[name='navSgin']").val(JSON.stringify(navStr));
	                    countTopic++;
	                } else {
	                    if (topicSgin == "1") {
	                        divaa.style.display = "none";
	                        var navCount = parseInt(u) + parseInt("1");
	                        navStr[countTopic] = navCount;
	                        query("input[name='navSgin']").val(JSON.stringify(navStr));
	                        countTopic++;
	                    }
	                }
	                var showUsed = query("input[name='fdItems[" + relationJson[f].topic + "].fdRelationShow']").val();
	                if (showUsed) {
	                    allRelation[u] = showUsed;
	                }
	                query("input[id='fdRelationCheck']").val(JSON.stringify(allRelation));
	            }
	            $("input[id='noType']").val(noType);
	            $("input[id='noTypes']").val(noTypes)
	
	        }
		});
    });
</script>
<script>
require(["mui/form/ajax-form!kmPindagateResponseForm"]);
require(['dijit/registry', "dojo/dom-construct", "dojo/dom-style", "dojo/dom-geometry", "dojo/dom-class", 'dojox/mobile/TransitionEvent',
        "dojo/ready", "dojo/date", "mui/calendar/CalendarUtil", "dojo/query", "mui/dialog/BarTip", "dojo/_base/window", "dojo/topic", "dojo/request",
        "dojo/on", "dojo/dom"],
    function (registry, domConstruct, domStyle, domGeo, domClass, TransitionEvent, ready, date, calendarUtil, query, BarTip, win, topic, request, on, dom) {
        ready(function () {
            var finish = query('.muiPindagateFinish')[0], wdt = registry.byId('finishWidget')
            var dialogContent = '';
            if (finish)
                domStyle.set(finish, "display", "none");
            if (wdt)
                registry.byId('finishWidget').setDisabled(true);
            //显示相关提示
            if ("${canResponse}" == "false") {
                var finishTime = "${finishTime}";
                var isPindagateFinish = "${isPindagateFinish}";

                if (isPindagateFinish == "1") {
                    dialogContent += "<bean:message bundle='km-pindagate' key='kmPindagateResponse.pindagate.finish'/>";
                } else if (finishTime == "") {
                    dialogContent += "<bean:message bundle='km-pindagate' key='kmPindagateResponse.notInvolvedAuth'/>";
                } else {
                    dialogContent += "<bean:message bundle='km-pindagate' key='kmPindagateResponse.hasBeenInvolved1'/>" + finishTime + "<bean:message bundle='km-pindagate' key='kmPindagateResponse.hasBeenInvolved2'/>";
                }

            } else {
                if ('${isReject}' == 'true') {
                    dialogContent += "您已经拒绝问卷调查";
                } else {
                    // 调查类型为不限定范围且从移动端扫码调查
                    if ('${kmPindagateMainForm.fdPindagateType}' == 'code' && '${param.addFrom}' == 'code')
                        beginPindagate();
                }

            }

            if (dialogContent) {
                var barTip = BarTip.tip({
                    text: dialogContent
                });
                var clientHeight = win.global.innerHeight,
                    tabBarHeight = domGeo.getMarginSize(query('#TabBar')[0]).h,
                    tipHeight = domGeo.getMarginSize(barTip.domNode).h;
                domStyle.set(barTip.domNode, 'top', clientHeight - tabBarHeight - tipHeight + 'px');
                domClass.add(barTip.domNode, 'muiResponseBarTip');
            }

            $(document).ready(function () {
                // 点击可提交按钮时显示蒙板弹窗
                var submit = $(".pindagate_nav_submit.active a");
                submit.on("click", function () {
                    $(".pindagate_mask").addClass("active");
                    setTimeout(function () {
                        $(".pindagate_mask_success").addClass("active");
                    }, 1)
                })

                // 点击蒙板确认，回到主界面
                $(".pindagate_mask_success_confirm").on("click", function () {
                    $(".pindagate_mask_success").removeClass("active");
                    setTimeout(function () {
                        $(".pindagate_mask").removeClass("active");
                    }, 300)
                })

                // 点击可提交按钮时显示蒙板弹窗
                var submit = $(".pindagate_nav_submit.active a");
                submit.on("click", function () {
                    $(".pindagate_mask").addClass("active");
                    setTimeout(function () {
                        $(".pindagate_mask_fail").addClass("active");
                    }, 1)
                })

                // 点击蒙板确认，回到主界面
                $(".pindagate_mask_fail_confirm").on("click", function () {
                    $(".pindagate_mask_fail").removeClass("active");
                    setTimeout(function () {
                        $(".pindagate_mask").removeClass("active");
                    }, 300)
                })

                //  点击更多按钮，查看所有题目
                $(".pindagate_nav_left").on("click", function () {
                    $(".pindagate_nav_see").toggleClass("active");
                    $(".pindagate_all").toggleClass("active");
                    var allFlag = $(".pindagate_all").hasClass("active");
                    var panel = $(".pindagate_all_panel");
                    if (allFlag) {
                        setTimeout(function () {
                            panel.addClass("in");
                        }, 1)
                    } else {
                        panel.removeClass("in");
                        setTimeout(function () {
                            $(".pindagate_all").removeClass("active");
                        }, 300)
                    }
                })
                // 点击蒙版返回主页面
                $(".pindagate_all_shadow").on("click", function () {
                    $(".pindagate_all").removeClass("active");
                    $(".pindagate_nav_see").removeClass("active");
                })
             	// 针对某些浏览器，解析“下一页”可能会比较慢，导致无法显示下一页
                var _interval = setInterval(function() {
                    // 获取当前题目
                    var pindagate = query(".pindagate_body");
                    if(pindagate && pindagate.length > 0) {
                        var curr = registry.byNode(pindagate[0].children[0]);
                        if(curr) {
                            var idx = curr.index, isShow = false;
                            for(; idx<allTopics.length; idx++) {
                                if(allTopics[idx].isShow) {
                                    isShow = true;
                                    break;
                                }
                            }
                            if(window.console) {
                                console.log("是否显示“下一页”：", isShow);
                            }
                            // 判断是否需要显示“下一页”
                            if(isShow) {
                                // 显示下一页
                                var next = query("#endNext" + curr.serialNum);
                                var display = domStyle.get(next[0], "display");
                                if(display != "none") {
                                    isShow = false;
                                    // 停止循环
                                    clearInterval(_interval);
                                }
                            }
                            if(isShow) {
                                // 需要显示“下一页”
                                domStyle.set(next[0], "display", "block");
                                // 停止循环
                                clearInterval(_interval);
                            }
                        }
                    }
                }, 300);
            });
        });
        var finishedTime = '${kmPindagateMainForm.docFinishedTime}',
            timeCard = query('.muiPindagateTimeCard')[0];
        finishedTime = calendarUtil.parseDate(finishedTime);

        if (finishedTime) {
            var timer = window.setInterval(_setInterval, 1000);
        } else {
            domConstruct.create('span', {
                className: 'item',
                innerHTML: '${ lfn:message("km-pindagate:mobile.kmPindagateMain.time.not.limit") }'
            }, timeCard);
        }

        var now = new Date(parseFloat('${now}'));

        function _setInterval() {
            domConstruct.empty(timeCard);
            var duration = date.difference(now, finishedTime, 'millisecond');
            if (duration >= 1000) {
                var day = parseInt(duration / (24 * 60 * 60 * 1000)),
                    hour = parseInt(duration % (24 * 60 * 60 * 1000) / (60 * 60 * 1000)),
                    minute = parseInt(duration % (60 * 60 * 1000) / (60 * 1000)),
                    second = parseInt(duration % (60 * 1000) / 1000),
                    item = null;
                //天
                if (day > 0) {
                    item = domConstruct.create('span', {
                        className: 'item',
                        innerHTML: '${ lfn:message("km-pindagate:mobile.days") }'
                    }, timeCard);
                    domConstruct.create('span', {innerHTML: formatValue(day), className: 'num'}, item, 'first');
                }
                //时
                item = domConstruct.create('span', {
                    className: 'item',
                    innerHTML: '${ lfn:message("km-pindagate:mobile.hours") }'
                }, timeCard);
                domConstruct.create('span', {innerHTML: formatValue(hour), className: 'num'}, item, 'first');
                //分
                item = domConstruct.create('span', {
                    className: 'item',
                    innerHTML: '${ lfn:message("km-pindagate:mobile.minute") }'
                }, timeCard);
                domConstruct.create('span', {innerHTML: formatValue(minute), className: 'num'}, item, 'first');
                //秒
                item = domConstruct.create('span', {
                    className: 'item',
                    innerHTML: '${ lfn:message("km-pindagate:mobile.second") }'
                }, timeCard);
                domConstruct.create('span', {innerHTML: formatValue(second), className: 'num'}, item, 'first');

                domConstruct.create('span', {
                    className: 'item',
                    innerHTML: '${ lfn:message("km-pindagate:mobile.kmPindagateMain.stop.pindagate") }'
                }, timeCard);
            } else {
                domConstruct.empty(timeCard);
                domConstruct.create('span', {
                    className: 'item',
                    innerHTML: '${ lfn:message("km-pindagate:mobile.kmPindagateMain.hasend.pindagate") }'
                }, timeCard);
                document.getElementById('muiPindagateStatusBtn').innerHTML = '${ lfn:message("km-pindagate:kmPindagate.tree.status.complete") }';
                var beginPindagateBtn = registry.byId('beginPindagateBtn');
                if (beginPindagateBtn) {
                    beginPindagateBtn.destroy();
                }
                var submitPindagateBtn = registry.byId('submitWidget');
                if (submitPindagateBtn) {
                    submitPindagateBtn.destroy();
                }
                timer = null;
                if (query('.muiPindagateFinish')) {
                    domStyle.set(query('.muiPindagateFinish')[0], "display", "");
                }
            }
            now = new Date(now.getTime() + 1000);
        }


        function formatValue(value) {
            if (value < 10) {
                value = '0' + value;
            }
            return value;
        }

        window.beginPindagate = function () {
            var opts = {
                transition: 'slide',
                moveTo: 'questionView'
            };
            new TransitionEvent(document.body, opts).dispatch();
            //操作结束
            //topic.publish('km/pindagate/touchEnd',null);
            setTimeout(function () {
                registry.byId('responseList').tip();
            }, 500);
        };

        var tolast = false;
        topic.subscribe('km/pindagate/paging', function (args) {

            var currentPage = args.currentPage,
                totalPage = args.totalPage,
                pageType = args.pageType,
                responseWidget = registry.byId('responseList'),
                submitWidget = registry.byId('submitWidget');
            if (submitWidget) {
                var result = responseWidget._validateAll() || {};
                if (currentPage == totalPage || (tolast && result.status)) {
                    submitWidget.setDisabled(false);
                } else {
                    submitWidget.setDisabled(true);
                }
                if (currentPage == totalPage) {
                    tolast = true;
                }
            }
        });

        var _canSubmit = false;
        canSubmit = function () {
            return _canSubmit;
        }

        saveMethod = function (str) {
            var responseList = registry.byId('responseList');
            if (responseList.validateAll()) {//校验通过
                request("${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do?method=getDocStatus&fdId=${param.pindageteId}").then(function (data) {
                    if (Number(data) == 32) {
                        var barTip = BarTip.tip({
                            text: '${ lfn:message("km-pindagate:kmPindagateResponse.pindagate.finish") }'
                        });
                    } else {
                        request("${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=checkIfCanRes&pid=${param.pindageteId}").then(function (data) {
                            if (data.indexOf("true") > -1) {
                                if ('save' == str) {
                                    request("${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=checkRepeatSubmit&pindageteId=${param.pindageteId}").then(function (data) {
                                        if (data.indexOf("true") > -1) {
                                            _canSubmit = true;
                                            var formObj = document.kmPindagateResponseForm;
                                            if ('save' == str) {
                                                Com_Submit(formObj, str, 'fdId');
                                            } else {
                                                Com_Submit(formObj, str);
                                            }
                                        } else {
                                            var barTip = BarTip.tip({
                                                text: '${ lfn:message("km-pindagate:kmPindagateMain.tip.hasResponseFasle") }'
                                            });
                                        }
                                    })
                                } else {
                                    _canSubmit = true;
                                    var formObj = document.kmPindagateResponseForm;
                                    if ('save' == str) {
                                        Com_Submit(formObj, str, 'fdId');
                                    } else {
                                        Com_Submit(formObj, str);
                                    }
                                }
                            } else {
                                var barTip = BarTip.tip({
                                    text: '${ lfn:message("km-pindagate:kmPindagateMain.tip.hasResponse") }'
                                });
                            }
                        })
                    }
                })
            } else {
            	var msg = '${ lfn:message("km-pindagate:mobile.kmPindagateMain.notnullAll") }';
            	if(responseList.tips && responseList.tips.length > 0) {
            		var tip = responseList.tips[0];
            		msg = tip.text;
            	}
            	var barTip = BarTip.tip({
                    text: msg
                });
            }
        }

        window.submitMethod = function (method, status) {
            var responseList = registry.byId('responseList');
            if (responseList.validateAll()) {//校验通过
                request("${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do?method=getDocStatus&fdId=${param.pindageteId}").then(function (data) {

                    if (Number(data) == 32) {
                        var barTip = BarTip.tip({
                            text: '${ lfn:message("km-pindagate:kmPindagateResponse.pindagate.finish") }'
                        });
                    } else {
                        var formObj = document.kmPindagateResponseForm;
                        if ('save' == method) {
                            Com_Submit(formObj, method, 'fdId');
                        } else {
                            Com_Submit(formObj, method);
                        }
                    }
                })

            }
        };

    });
</script>