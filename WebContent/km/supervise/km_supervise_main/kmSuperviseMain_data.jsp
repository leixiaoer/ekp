<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil"%>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseMain"%>
<list:data>
    <list:data-columns var="kmSuperviseMain" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column property="fdOriginId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
		<%-- 督办事项 --%>
        <list:data-column headerClass="width300" col="docSubject" title="${lfn:message('km-supervise:kmSupervise.items')}" escape="false">
        	<span class="com_subject"><c:out value="${kmSuperviseMain.docSubject}" /></span>
        </list:data-column>
         <%-- 督办领导id --%>
        <list:data-column col="fdLead.id" escape="false">
            <c:out value="${kmSuperviseMain.fdLead.fdId}" />
        </list:data-column>
        <c:choose>
        	<c:when  test="${param['q.mydoc']=='duban'}">
        		<%-- 主办单位负责人 --%>
		        <list:data-column col="fdSponsor" title="${lfn:message('km-supervise:kmSuperviseMain.fdSponsor') }" escape="false">
		        	<c:out value="${kmSuperviseMain.fdSponsor.fdName }" />
		        </list:data-column>
        	</c:when>
        	<c:otherwise>
        		 <%-- 督办领导name --%>
		        <list:data-column col="fdLead.name" title="${lfn:message('km-supervise:kmSuperviseMain.fdLead')}" escape="false">
		            <c:out value="${kmSuperviseMain.fdLead.fdName}" />
		        </list:data-column>
        	</c:otherwise>
       	</c:choose>
       	<%-- 开始时间 --%>
        <list:data-column headerClass="width100" col="fdStartTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdStartTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdStartTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 完成时限 --%>
        <list:data-column headerClass="width100" col="fdFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 立项时间 --%>
        <list:data-column headerClass="width100" col="fdApprovalTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdApprovalTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdApprovalTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 重启时间 --%>
        <list:data-column col="fdRestartTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdRestartTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdRestartTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 实际完成时间 --%>
        <list:data-column headerClass="width100" col="fdRealFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdRealFinishTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdRealFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 撤销时间 --%>
        <list:data-column col="fdRepealTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdRepealTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdRepealTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 督办状态 --%>
        <list:data-column headerClass="width100" col="fdStatus" title="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}">
        	<c:choose>
        		<c:when test="${kmSuperviseMain.docStatus=='30' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.30" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.docStatus=='40' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.40" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.docStatus=='50' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.50" />
        		</c:when>
        		<c:otherwise>
        			<kmss:message bundle="km-supervise" key="enums.doc_status.20" />
        		</c:otherwise>
        	</c:choose>
        </list:data-column>
        <%-- 督办进度 --%>
        <list:data-column col="fdSuperviseProgress" title="${lfn:message('km-supervise:kmSuperviseMain.fdSuperviseProgress')}" escape="false" style="width: 113px;height: 7px;">
		<%--	<style>
				.pro_barline{width: 113px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;}
				.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
				.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
			</style>--%>
			<c:choose>
				<c:when test="${empty kmSuperviseMain.fdSuperviseProgress}">
					0%
				</c:when>
				<c:otherwise>
					<c:out value="${kmSuperviseMain.fdSuperviseProgress}" />%
				</c:otherwise>
			</c:choose>
			<div class='pro_barline'>
				<c:if test="${kmSuperviseMain.fdSuperviseProgress=='100' }">
					<div class='complete' style="width:${kmSuperviseMain.fdSuperviseProgress}%"></div>
				</c:if>
				<c:if test="${empty kmSuperviseMain.fdSuperviseProgress }">
					<div class='uncomplete' style="width:0%"></div>
				</c:if>
				<c:if test="${not empty kmSuperviseMain.fdSuperviseProgress && kmSuperviseMain.fdSuperviseProgress!='100' }">
					<div class='uncomplete' style="width:${kmSuperviseMain.fdSuperviseProgress}%"></div>
				</c:if>
			</div>
        </list:data-column>
        <%-- 创建时间 --%>
        <list:data-column headerClass="width100" col="docCreateTime" title="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime')}">
            <kmss:showDate value="${kmSuperviseMain.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <%-- 主办单位 --%>
        <list:data-column headerClass="width100" col="fdUnit" title="${lfn:message('km-supervise:kmSuperviseMain.fdUnit') }" escape="false">
        	<c:out value="${kmSuperviseMain.fdUnit.fdName }" />
        </list:data-column>
        <%-- 经办人 --%>
        <list:data-column headerClass="width100" col="fdResponsible" title="${lfn:message('km-supervise:kmSuperviseMain.fdResponsible') }" escape="false">
        	<c:out value="${kmSuperviseMain.fdResponsible.fdName }" />
        </list:data-column>
        <%-- 考评状态 --%>
        <list:data-column col="fdRemarkStatus" title="${lfn:message('km-supervise:kmSuperviseMain.fdRemarkStatus') }" escape="false">
        	<c:if test="${kmSuperviseMain.fdRemarkStatus == '0' }">
        		<kmss:message bundle="km-supervise" key="enums.remark_status.0" />
        	</c:if>
        	<c:if test="${kmSuperviseMain.fdRemarkStatus == '1' }">
        		<kmss:message bundle="km-supervise" key="enums.remark_status.1" />
        	</c:if>
        </list:data-column>
        <%-- 考评状态值 --%>
        <list:data-column property="fdRemarkStatus" />
         <%-- 完成星级 --%>
        <list:data-column col="fdFinishLevel" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishLevel') }" escape="false">
         <%--	<style>
			    .all>span{font-size:2em;color:#999;}
			    .all>.gold{color:gold;}
			    
        	</style> --%>
        	<p class="all">
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '1' }">
		      	<span class="gold">★</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      </c:if>
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '2' }">
		     	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      </c:if>
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '3' }">
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      </c:if>
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '4' }">
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span>☆</span>
		      </c:if>
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '5' }">
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      </c:if>
		    </p>
        </list:data-column>
        <%-- 评价说明 --%>
        <list:data-column property="fdRemark" title="${lfn:message('km-supervise:kmSuperviseMain.fdRemark') }" />
        <%-- 创建人name --%>
        <list:data-column headerClass="width100" col="docCreator.name" title="${lfn:message('km-supervise:kmSuperviseMain.initiator') }">
        	<c:out value="${kmSuperviseMain.docCreator.fdName }" />
        </list:data-column>
        <%-- 创建人id --%>
        <list:data-column col="docCreator.id">
        	<c:out value="${kmSuperviseMain.docCreator.fdId }" />
        </list:data-column>
        <%-- 文档状态 --%>
        <list:data-column headerClass="width100" col="docStatus" title="${lfn:message('km-supervise:kmSuperviseMain.docStatus')}">
        	<c:if test="${kmSuperviseMain.docStatus=='10' }">${lfn:message('status.draft') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='20' }">${lfn:message('status.examine') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='11' }">${lfn:message('status.refuse') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='30' }">${lfn:message('status.publish') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='00' }">${lfn:message('status.discard') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='40' }">${lfn:message('km-supervise:enums.status.finish') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='50' }">${lfn:message('km-supervise:enums.status.stop') }</c:if>
        	<c:if test="${kmSuperviseMain.docStatus=='60' }">${lfn:message('km-supervise:enums.status.change') }</c:if>
        </list:data-column>
        <%-- 当前环节 --%>
        <list:data-column headerClass="width100" col="nodeName" title="${ lfn:message('km-supervise:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues  var="nodevalue" idValue="${kmSuperviseMain.fdId}" propertyName="nodeName" />
			    <div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
        <%-- 当前处理人 --%>
        <list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-supervise:sysWfNode.processingNode.currentProcessor') }" escape="false">
		   <kmss:showWfPropertyValues  var="handlerValue" idValue="${kmSuperviseMain.fdId}" propertyName="handlerName" />
			    <div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
		<%-- 操作按钮 --%>
		<list:data-column headerClass="width80" col="operations" title="${ lfn:message('list.operation') }" escape="false">
	 		<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=delete&fdId=${kmSuperviseMain.fdId}" requestMethod="GET">
				<div class="conf_show_more_w">
					<div class="conf_btn_edit">
						<a class="btn_txt" href="javascript:deleteDoc('${kmSuperviseMain.fdId}')">${lfn:message('button.delete')}</a>
					</div>
				</div>
			</kmss:auth>
		</list:data-column>
		<%-- 督办类型 --%>
		<list:data-column headerClass="width100" col="docTemplate.name" title="${lfn:message('km-supervise:kmSuperviseMain.type')}" escape="false">
            <c:out value="${kmSuperviseMain.docTemplate.fdName}" />
        </list:data-column>
        <%-- 主办单位负责人 --%>
        <list:data-column headerClass="width100" col="fdSponsor.name" title="${lfn:message('km-supervise:kmSuperviseMain.fdSponsor') }" escape="false">
        	<c:out value="${kmSuperviseMain.fdSponsor.fdName }" />
        </list:data-column>
		<%-- 主办部门 --%>
		<list:data-column headerClass="width100" col="fdSysUnit.name" title="${lfn:message('km-supervise:kmSuperviseMain.fdSysUnit')}" escape="false">
            <c:choose>
            	<c:when test="${kmSuperviseMain.fdSysUnitEnable == true }">
            		<c:out value="${kmSuperviseMain.fdSysUnit.fdName}" />
            	</c:when>
            	<c:otherwise>
            		<c:out value="${kmSuperviseMain.fdUnit.fdName }" />
            	</c:otherwise>
            </c:choose>
        </list:data-column>
        <%-- 反馈时间 --%>
		<list:data-column headerClass="width100" col="fdBackTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdBackTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdBackTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 变更时间 --%>
		<list:data-column  headerClass="width100" col="fdChangeTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdChangeTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdChangeTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 变更人 --%>
		<list:data-column headerClass="width100" col="fdChangePerson.name" title="${lfn:message('km-supervise:kmSuperviseMain.fdChangePerson')}">
            <c:out value="${kmSuperviseMain.fdChangePerson.fdName}" />
        </list:data-column>
        <%-- 变更原因 --%>
		<list:data-column headerClass="width200" col="fdChangeDesc" title="${lfn:message('km-supervise:kmSuperviseMain.fdChangeDesc')}" escape="false">
            <c:out value="${kmSuperviseMain.fdChangeDesc}" />
        </list:data-column>
        <%-- 最新反馈 --%>
		<list:data-column headerClass="width160" col="fdBackContent" title="${lfn:message('km-supervise:kmSuperviseMain.fdBackContent')}">
            <c:out value="${kmSuperviseMain.fdBackContent}" />
        </list:data-column>
        <list:data-column headerClass="width100"  col="fdStatusNew" title="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}" escape="false">
        	<c:if test="${kmSuperviseMain.docStatus == '30' || kmSuperviseMain.docStatus == '40' || kmSuperviseMain.docStatus == '50'|| kmSuperviseMain.docStatus == '60'}">
	        	<c:choose>
	        		<c:when test="${kmSuperviseMain.fdStatus=='10' }">
	        			<%
	        				if(pageContext.getAttribute("kmSuperviseMain")!=null){
	        					KmSuperviseMain kmSuperviseMain = (KmSuperviseMain)pageContext.getAttribute("kmSuperviseMain");
	    						if(KmSuperviseUtil.isSoonStart(kmSuperviseMain)){
	    				%>
	        						<i class="lui_supervise_status lui_supervise_status_soon_start" ></i><kmss:message bundle="km-supervise" key="enums.status.soon.start" />
	        			<% 
	        					}else{
	        			%>
	        						<i class="lui_supervise_status lui_supervise_status_normal" ></i><kmss:message bundle="km-supervise" key="enums.status.normal" />
	        			<%		
	        					}
	        				}
	        			%>
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='20' }">
	        			<i class="lui_supervise_status lui_supervise_status_soon_delay"></i><kmss:message bundle="km-supervise" key="enums.status.soon.delay" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='30' }">
	        			<i class="lui_supervise_status lui_supervise_status_delay"></i><kmss:message bundle="km-supervise" key="enums.status.delay" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='40' && kmSuperviseMain.fdIsDelay=='35'}">
	        			<i class="lui_supervise_status lui_supervise_status_delay_finish"></i><kmss:message bundle="km-supervise" key="enums.status.delayFinsh" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='40' && kmSuperviseMain.fdIsDelay=='38'}">
	        			<i class="lui_supervise_status lui_supervise_status_finish"></i><kmss:message bundle="km-supervise" key="enums.status.normalFinsh" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='50' }">
	        			<i class="lui_supervise_status lui_supervise_status_stop"></i><kmss:message bundle="km-supervise" key="enums.status.stop" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='60' }">
	        			<i class="lui_supervise_status lui_supervise_status_change"></i><kmss:message bundle="km-supervise" key="enums.status.change" />
	        		</c:when>
	        	</c:choose>
        	</c:if>
        </list:data-column>
        <list:data-column headerClass="width80" col="newOperations" title="${ lfn:message('list.operation') }" escape="false">
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<c:if test="${kmSuperviseMain.docStatus == '30'}">
						<c:if test="${kmSuperviseMain.fdStatus=='20' || kmSuperviseMain.fdStatus=='30'}">
							<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=urgeSupervise&fdId=${kmSuperviseMain.fdId}" requestMethod="GET">
								<a class="btn_txt" href="javascript:urgeDoc('${kmSuperviseMain.fdId}')"><kmss:message bundle="km-supervise" key="py.CuiBan" /></a>
							</kmss:auth>
						</c:if>
						<c:if test="${kmSuperviseMain.fdStatus=='10' || kmSuperviseMain.fdStatus=='20' || kmSuperviseMain.fdStatus=='30'}">
							<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddInstruction&fdId=${kmSuperviseMain.fdId}" requestMethod="GET">
								<a class="btn_txt" href="javascript:instructionDoc('${kmSuperviseMain.fdId}')"><kmss:message bundle="km-supervise" key="py.PiShi" /></a>
							</kmss:auth>
						</c:if>
					</c:if>
				</div>
			</div>
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
