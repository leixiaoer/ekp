<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.landray.kmss.sys.time.util.SysTimeUtil,com.landray.kmss.util.StringUtil,com.landray.kmss.sys.time.forms.SysTimeLeaveAmountForm,com.landray.kmss.sys.time.model.SysTimeLeaveConfig,com.landray.kmss.sys.time.service.ISysTimeLeaveRuleService" %>
<%
	SysTimeLeaveAmountForm sysTimeLeaveAmountForm = (SysTimeLeaveAmountForm) request.getAttribute("sysTimeLeaveAmountForm");
	Float convertTime = SysTimeUtil.getConvertTime();
%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="title">
		${ lfn:message('sys-time:table.sysTimeLeaveAmount') }
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<kmss:auth requestURL="/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do?method=edit">
				<ui:button text="${lfn:message('button.edit')}" onclick="editDoc();" order="2">
				</ui:button>
			</kmss:auth>
			<kmss:auth requestURL="/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do?method=delete">
				<ui:button text="${lfn:message('button.delete')}" order="4" onclick="deleteDoc();">
				</ui:button>
			</kmss:auth>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content"> 
		<div class='lui_form_title_frame' style="padding-top: 10px;">
			<div class='lui_form_subject'>
				${ lfn:message('sys-time:table.sysTimeLeaveAmount') }
			</div>
		</div>
		<div class="lui_form_content_frame" style="padding-top:20px">
			<table class="tb_normal" width=100%>
				<tr>
					<%-- 人员 --%>
					<td width="15%" class="td_normal_title">
						${ lfn:message('sys-time:sysTimeLeaveAmount.fdPerson') }
					</td>
					<td width="35%">
						<c:out value="${sysTimeLeaveAmountForm.fdPersonName }"></c:out>
					</td>
					<%-- 年份 --%>
					<td width="15%" class="td_normal_title">
						${ lfn:message('sys-time:sysTimeLeaveAmount.fdYear') }
					</td>
					<td width="35%">
						${sysTimeLeaveAmountForm.fdYear }
					</td>
				</tr>
			<%-- 所属场所 --%>
		    <%if(ISysAuthConstant.IS_AREA_ENABLED){ %>
				<tr>
					<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field_single.jsp" charEncoding="UTF-8">
		                <c:param name="id" value="${sysTimeLeaveAmountForm.authAreaId}"/>
		            </c:import>
				</tr>
			<%} %>
			<c:forEach items="${sysTimeLeaveAmountForm.fdAmountItems }" var="amountItem" varStatus="vstatus">
				<tr>
					<%-- 剩余天数 --%>
					<td width="15%" class="td_normal_title">
						<c:out value="${amountItem.fdLeaveName }"/>${ lfn:message('sys-time:sysTimeLeaveAmount.fdRestDay') }
					</td>
					<td>
						<c:if test="${not empty amountItem.fdRestDay}">
							<c:set var="__fdRestDay" value="${amountItem.fdRestDay }"></c:set>
							<c:if test="${amountItem.fdStatType == '3' }">
								<%
									Float restDay = Float.parseFloat((String) pageContext.getAttribute("__fdRestDay"));
									pageContext.setAttribute("rest_day", SysTimeUtil.formatLeaveTimeStr(restDay, 0f));
								%>
								${rest_day}
							</c:if>
							<c:if test="${amountItem.fdStatType != '3' }">
								<fmt:formatNumber value="${amountItem.fdRestDay }" pattern="#.##"/>${ lfn:message('sys-time:sysTimeLeaveAmount.day') }
							</c:if>
							<c:if test="${!amountItem.fdIsAvail }">
								<span style="color: red;">（${ lfn:message('sys-time:sysTimeLeaveAmount.notAvailable') }）</span>
							</c:if>
						</c:if>
					</td>
					<%-- 失效日期 --%>
					<td width="15%" class="td_normal_title">
						<c:out value="${amountItem.fdLeaveName }"/>${ lfn:message('sys-time:sysTimeLeaveAmount.fdValidDate') }
					</td>
					<td>
						<c:if test="${not empty amountItem.fdValidDate}">
							<xform:datetime property="fdAmountItems[${vstatus.index }].fdValidDate" value="${amountItem.fdValidDate }" dateTimeType="date" showStatus="view"></xform:datetime>
						</c:if>
					</td>
				</tr>
				<tr>
					<%-- 上周期剩余天数 --%>
					<td width="15%" class="td_normal_title">
						${ lfn:message('sys-time:sysTimeLeaveAmount.lastPeriod') }${ lfn:message('sys-time:sysTimeLeaveAmount.fdRestDay') }
					</td>
					<td>
						<c:if test="${not empty amountItem.fdLastRestDay}">
							<c:set var="__fdLastRestDay" value="${amountItem.fdLastRestDay }"></c:set>
							<c:if test="${amountItem.fdStatType == '3' }">
								<%
									Float lastRestDay = Float.parseFloat((String) pageContext.getAttribute("__fdLastRestDay"));
									pageContext.setAttribute("lastRest_day", SysTimeUtil.formatLeaveTimeStr(lastRestDay, 0f));
								%>
								${lastRest_day}
							</c:if>
							<c:if test="${amountItem.fdStatType != '3' }">
								<fmt:formatNumber value="${amountItem.fdLastRestDay }" pattern="#.##"/>${ lfn:message('sys-time:sysTimeLeaveAmount.day') }
							</c:if>
							<c:if test="${!amountItem.fdIsLastAvail }">
								<span style="color: red;">（${ lfn:message('sys-time:sysTimeLeaveAmount.notAvailable') }）</span>
							</c:if>
						</c:if>
					</td>
					<%-- 上周期失效日期 --%>
					<td width="15%" class="td_normal_title">
						${ lfn:message('sys-time:sysTimeLeaveAmount.lastPeriod') }${ lfn:message('sys-time:sysTimeLeaveAmount.fdValidDate') }
					</td>
					<td>
						<c:if test="${not empty amountItem.fdLastValidDate}">
							<xform:datetime property="fdAmountItems[${vstatus.index }].fdLastValidDate" value="${amountItem.fdLastValidDate }" dateTimeType="date" showStatus="view"></xform:datetime>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</table>
			
			<ui:tabpage expand="false">
				<%-- 请假使用情况 --%>
				<c:if test="${not empty sysTimeLeaveAmountForm.fdAmountItems }">
				<ui:content expand="true" title="${ lfn:message('sys-time:sysTimeLeaveAmount.used.situation') }">
					<table class="tb_normal" width=100% style="text-align: center;">
						<tr>
							<td rowspan="2" class="td_normal_title" width="15%">
								${ lfn:message('sys-time:sysTimeLeaveRule.leaveType') }
							</td>
							<td colspan="4" class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.thisPeriod') }
							</td>
							<td colspan="4" class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.lastPeriodRest') }
							</td>
							<td rowspan="2" class="td_normal_title" width="15%">
								${ lfn:message('sys-time:sysTimeLeaveAmount.totalRestDay') }
							</td>
						</tr>
						<tr>
							<td class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.fdTotalDay') }
							</td>
							<td class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.fdUsedDay') }
							</td>
							<td class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.fdRestDay') }
							</td>
							<td class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.fdValidDate') }
							</td>
							<td class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.fdTotalDay') }
							</td>
							<td class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.fdUsedDay') }
							</td>
							<td class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.fdRestDay') }
							</td>
							<td class="td_normal_title">
								${ lfn:message('sys-time:sysTimeLeaveAmount.fdValidDate') }
							</td>
						</tr>
						<c:forEach items="${sysTimeLeaveAmountForm.fdAmountItems }" var="amountItem" varStatus="vstatus">
						<tr>
							<td>
								<c:out value="${amountItem.fdLeaveName }"/>
							</td>
							<%-- 本周期 --%>
							<%-- 总天数 --%>
							<td>
								<fmt:formatNumber value="${amountItem.fdTotalDay }" pattern="#.##"/>
								<c:if test="${amountItem.fdIsAuto }">
									(${ lfn:message('sys-time:sysTimeLeaveAmount.auto.release') })
								</c:if>
								<c:if test="${amountItem.fdIsAuto eq null || !amountItem.fdIsAuto }">
									(${ lfn:message('sys-time:sysTimeLeaveAmount.manual.release') })
								</c:if>
							</td>
							<%-- 已使用天数 --%>
							<td>
								<c:if test="${not empty amountItem.fdUsedDay}">
									<%-- <c:set var="__fdUsedDay" value="${amountItem.fdUsedDay }" />
									<c:if test="${amountItem.fdStatType == '3' }">
										<%
											Float usedDay = Float.parseFloat((String) pageContext.getAttribute("__fdUsedDay"));
											
											pageContext.setAttribute("used_day", SysTimeUtil.formatLeaveTimeStr(usedDay, 0f));
										%>
										${used_day}
									</c:if>
									<c:if test="${amountItem.fdStatType != '3' }"> --%>
										<fmt:formatNumber value="${amountItem.fdUsedDay }" pattern="#.##"/>
									<%-- </c:if> --%>
								</c:if>
								<c:if test="${empty amountItem.fdUsedDay}">
									0
								</c:if>
							</td>
							<%-- 剩余天数 --%>
							<td>
								<c:if test="${not empty amountItem.fdRestDay}">
									<%-- <c:set var="__fdRestDay" value="${amountItem.fdRestDay }"></c:set>
									<c:if test="${amountItem.fdStatType == '3' }">
										<%
											Float __restDay = Float.parseFloat((String) pageContext.getAttribute("__fdRestDay"));
											pageContext.setAttribute("rest_day",SysTimeUtil.formatLeaveTimeStr(__restDay, 0f));
										%>
										${rest_day}
									</c:if>
									<c:if test="${amountItem.fdStatType != '3' }"> --%>
										<fmt:formatNumber value="${amountItem.fdRestDay }" pattern="#.##"/>
									<%-- </c:if> --%>
									<c:if test="${!amountItem.fdIsAvail }">
										<span style="color: red;">(${ lfn:message('sys-time:sysTimeLeaveAmount.notAvailable') })</span>
									</c:if>
								</c:if>
								<c:if test="${empty amountItem.fdRestDay}">
									0
								</c:if>
							</td>
							<%-- 失效日期 --%>
							<td>
								<c:if test="${not empty amountItem.fdValidDate}">
									<xform:datetime property="fdAmountItems[${vstatus.index }].fdValidDate" value="${amountItem.fdValidDate }" dateTimeType="date" showStatus="view"></xform:datetime>
								</c:if>
							</td>
							<%-- 上周期 --%>
							<%-- 总天数 --%>
							<td>
								<c:if test="${not empty amountItem.fdLastTotalDay}">
									<%-- <c:set var="__fdLastTotalDay" value="${amountItem.fdLastTotalDay }" />
									<c:if test="${amountItem.fdStatType == '3' }">
										<%
											Float lastTotalDay = Float.parseFloat((String) pageContext.getAttribute("__fdLastTotalDay"));
											pageContext.setAttribute("lastTotal_day", SysTimeUtil.formatLeaveTimeStr(lastTotalDay, 0f));
										%>
										${lastTotal_day}
									</c:if>
									<c:if test="${amountItem.fdStatType != '3' }"> --%>
										<fmt:formatNumber value="${amountItem.fdLastTotalDay}" pattern="#.##"/>
									<%-- </c:if> --%>
								</c:if>
								<c:if test="${empty amountItem.fdLastTotalDay}">
									0
								</c:if>
							</td>
							<%-- 已使用天数 --%>
							<td>
								<c:if test="${not empty amountItem.fdLastUsedDay}">
									<c:set var="__fdLastUsedDay" value="${amountItem.fdLastUsedDay }" />
									<%-- <c:if test="${amountItem.fdStatType == '3' }">
										<%
											Float lastUsedDay = Float.parseFloat((String) pageContext.getAttribute("__fdLastUsedDay"));
											pageContext.setAttribute("lastUsed_day", SysTimeUtil.formatLeaveTimeStr(lastUsedDay, 0f));
										%>
										${lastUsed_day}
									</c:if>
									<c:if test="${amountItem.fdStatType != '3' }"> --%>
										<fmt:formatNumber value="${amountItem.fdLastUsedDay}" pattern="#.##"/>
									<%-- </c:if> --%>
								</c:if>
								<c:if test="${empty amountItem.fdLastUsedDay}">
									0
								</c:if>
							</td>
							<%-- 剩余天数 --%>
							<td>
								<c:if test="${not empty amountItem.fdLastRestDay}">
									<%-- <c:set var="__fdLastRestDay" value="${amountItem.fdLastRestDay }"></c:set>
									<c:if test="${amountItem.fdStatType == '3' }">
										<%
											Float __lastRestDay = Float.parseFloat((String) pageContext.getAttribute("__fdLastRestDay"));
											pageContext.setAttribute("lastRest_day", SysTimeUtil.formatLeaveTimeStr(__lastRestDay, 0f));
										%>
										${lastRest_day}
									</c:if>
									<c:if test="${amountItem.fdStatType != '3' }"> --%>
										<fmt:formatNumber value="${amountItem.fdLastRestDay }" pattern="#.##"/>
								<%-- 	</c:if> --%>
									<c:if test="${!amountItem.fdIsLastAvail }">
										<span style="color: red;">(${ lfn:message('sys-time:sysTimeLeaveAmount.notAvailable') })</span>
									</c:if>
								</c:if>
								<c:if test="${empty amountItem.fdLastRestDay}">
								 	0
								</c:if>
							</td>
							<%-- 失效日期 --%>
							<td>
								<c:if test="${not empty amountItem.fdLastValidDate}">
									<xform:datetime property="fdAmountItems[${vstatus.index }].fdLastValidDate" value="${amountItem.fdLastValidDate }" dateTimeType="date" showStatus="view"></xform:datetime>
								</c:if>
							</td>
							<%-- 剩余总天数 --%>
							<td>
								<c:if test="${not empty amountItem.fdRestTotalDay}">
									<%-- <c:set var="__fdRestTotalDay" value="${amountItem.fdRestTotalDay }" />
									<c:if test="${amountItem.fdStatType == '3' }">
										<%
											Float restTotalDay = Float.parseFloat((String) pageContext.getAttribute("__fdRestTotalDay"));
											pageContext.setAttribute("restTotal_day", SysTimeUtil.formatLeaveTimeStr(restTotalDay, 0f));
										%>
										${restTotal_day}
									</c:if>
									<c:if test="${amountItem.fdStatType != '3' }"> --%>
										<fmt:formatNumber value="${amountItem.fdRestTotalDay }" pattern="#.##"/>
									<%-- </c:if> --%>
								</c:if>
								<c:if test="${empty amountItem.fdRestTotalDay}">
									0
								</c:if>
							</td>
						</tr>
						</c:forEach>
						<tr>
							<td>
								${ lfn:message('sys-time:sysTimeLeaveAmount.total') }
							</td>
							<td>
								<fmt:formatNumber value="${total }" pattern="#.##"/>
							</td>
							<td>
								${usedTotal }
							</td>
							<td>
								${restTotal }
							</td>
							<td>
							</td>
							
							<td>
								${lastTotal }
							</td>
							<td>
								${lastUsedTotal }
							</td>
							<td>
								${lastRestTotal }
							</td>
							<td>
							</td>
							
							<td>
								${restAndRest }
							</td>
						</tr>
					</table>
				</ui:content>
				</c:if>
				<%-- 请假明细 --%>
				<ui:content expand="true" title="${ lfn:message('sys-time:table.sysTimeLeaveDetail') }">
					<list:listview id="listview">
						<ui:source type="AjaxJson">
							{url:'/sys/time/sys_time_leave_detail/sysTimeLeaveDetail.do?method=list&personId=${sysTimeLeaveAmountForm.fdPersonId}&year=${sysTimeLeaveAmountForm.fdYear}&fdType=1'}
						</ui:source>
						<list:colTable isDefault="false" layout="sys.ui.listview.columntable"
							rowHref="/sys/time/sys_time_leave_detail/sysTimeLeaveDetail.do?method=view&fdId=!{fdId}"  name="columntable">
							<list:col-serial></list:col-serial> 
							<list:col-auto props="fdPerson.fdName;fdLeaveName;fdStartTime;fdEndTime;fdLeaveTime;fdOprType;fdOprDesc;fdReview;operation;"></list:col-auto>
						</list:colTable>
					</list:listview> 
					<list:paging></list:paging>
				</ui:content>
				
				<%-- 加班明细 --%>
				<ui:content expand="true" title="${ lfn:message('sys-time:sysTimeLeaveDetail.overTimeDetail') }">
					<list:listview id="overListview">
						<ui:source type="AjaxJson">
							{url:'/sys/time/sys_time_leave_detail/sysTimeLeaveDetail.do?method=list&personId=${sysTimeLeaveAmountForm.fdPersonId}&year=${sysTimeLeaveAmountForm.fdYear}&fdType=2'}
						</ui:source>
						<list:colTable isDefault="false" layout="sys.ui.listview.columntable" name="columntable">
							<list:col-serial></list:col-serial>
							<list:col-auto props="fdPerson.fdName;fdLeaveName;fdStartTime;fdEndTime;fdLeaveTime;fdOprType;fdOprDesc;fdReview;"></list:col-auto>
						</list:colTable>
					</list:listview>
					<list:paging channel="overListview"></list:paging>
				</ui:content>
				
			</ui:tabpage>
		</div>
		
		<script type="text/javascript">
		seajs.use(['lui/jquery','lui/topic','lui/dialog'],function($,topic,dialog){
			window.deleteDoc = function(){
				var delUrl = '<c:url value="/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do"/>?method=delete&fdId=${param.fdId}';
				dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(result){
					if(result){
						Com_OpenWindow(delUrl,'_self');
					}	
				});
			};
			window.editDoc = function(){
				Com_OpenWindow('<c:url value="/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do"/>?method=edit&fdId=${param.fdId}','_self');
			};
			window.deduct = function(id) {
				window.loading = dialog.loading();
				$.post('<c:url value="/sys/time/sys_time_leave_detail/sysTimeLeaveDetail.do?method=deduct"/>&fdId=' + id, 
						null,function(data){
					if(window.loading!=null)
						window.loading.hide();
					if(data) {
						if(data.status != 1) {
							var errMsg = "${ lfn:message('sys-time:sysTimeLeaveDetail.deduct.fail') }";
							if(data.reason){
								errMsg += '。' + "${ lfn:message('sys-time:sysTimeLeaveDetail.reason') }" + '：' + data.reason;
							}
							dialog.failure(errMsg, null, function(){
								location.reload();
							});
						} else {
							dialog.success('<bean:message key="return.optSuccess" />', null, function(){
								location.reload();
							});
						}
					} else {
						dialog.failure('<bean:message key="return.optFailure" />', null, function(){
							location.reload();
						});
					}
				},'json');
			};
			
			window.updateAttend = function(id){
				window.loading = dialog.loading();
				$.post('<c:url value="/sys/time/sys_time_leave_detail/sysTimeLeaveDetail.do?method=updateAttend"/>&fdId=' + id, 
						null,function(data){
					if(window.loading!=null)
						window.loading.hide();
					if(data) {
						dialog.success('<bean:message key="return.optSuccess" />', null, function(){
							topic.publish("list.refresh");
						});
					} else {
						dialog.failure('<bean:message key="return.optFailure" />', null, function(){
							topic.publish("list.refresh");
						});
					}
				},'json');
			};
		});
		</script>
	</template:replace>
</template:include>