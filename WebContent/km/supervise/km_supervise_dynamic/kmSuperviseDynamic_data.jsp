<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseDynamic" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
		<%-- 动态名称 --%>
        <list:data-column col="docSubject" title="${lfn:message('km-supervise:kmSuperviseDynamic.docSubject')}" escape="false">
        	<span class="com_subject"><c:out value="${kmSuperviseDynamic.docSubject}" /></span>
        </list:data-column>
        <%-- 动态内容 --%>
		<list:data-column col="fdContent" title="${lfn:message('km-supervise:kmSuperviseDynamic.fdContent')}" escape="false">
            <c:out value="${kmSuperviseDynamic.fdContent}" />
        </list:data-column>
        <%-- 类型 --%>
		<list:data-column col="fdType" title="${lfn:message('km-supervise:kmSuperviseDynamic.fdType')}" escape="false">
            <c:choose>
        		<c:when test="${kmSuperviseMain.fdType=='0' }">
        			<kmss:message bundle="km-supervise" key="py.DuBanLiXiang" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.fdType=='1' }">
        			<kmss:message bundle="km-supervise" key="py.DuBanBianGeng" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.fdType=='2' }">
        			<kmss:message bundle="km-supervise" key="py.JieDuanFanKui" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.fdType=='3' }">
        			<kmss:message bundle="km-supervise" key="py.RenWuFanKui" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.fdType=='4' }">
        			<kmss:message bundle="km-supervise" key="py.DuBanBanJie" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.fdType=='5' }">
        			<kmss:message bundle="km-supervise" key="py.DuBanZhongZhi" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.fdType=='6' }">
        			<kmss:message bundle="km-supervise" key="py.DuBanKaoPing" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.fdType=='7' }">
        			<kmss:message bundle="km-supervise" key="py.leaderInstruction" />
        		</c:when>
        	</c:choose>
        </list:data-column>
        <%-- 所属督办 --%>
		<list:data-column col="fdSupervise" title="${lfn:message('km-supervise:kmSuperviseDynamic.fdSupervise')}" escape="false">
            <c:out value="${kmSuperviseDynamic.fdSupervise.docSubject}" />
        </list:data-column>
        <%-- 创建时间--%>
		<list:data-column col="docCreateTime" title="${lfn:message('km-supervise:kmSuperviseDynamic.docCreateTime')}" escape="false">
            <kmss:showDate value="${kmSuperviseDynamic.docCreateTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 创建人 --%>
		<list:data-column col="docCreator" title="${lfn:message('km-supervise:kmSuperviseDynamic.docCreator')}" escape="false">
            <c:out value="${kmSuperviseDynamic.docCreator.fdName}" />
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
