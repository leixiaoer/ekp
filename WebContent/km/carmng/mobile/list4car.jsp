<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ArrayUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.carmng.model.KmCarmngInfomation"%>
<%@page import="com.landray.kmss.km.carmng.service.IKmCarmngInfomationService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%
IKmCarmngInfomationService kmCarmngInfomationService= (IKmCarmngInfomationService)SpringBeanUtil.getBean("kmCarmngInfomationService");
%>
<list:data>
	<list:data-columns var="kmCarmngInfomation" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
        <list:data-column col="type" escape="false">
		   car
		</list:data-column>
		<list:data-column  col="fdNo"  title="${ lfn:message('km-carmng:kmCarmngInfomation.fdNo') }" escape="false">
			<c:out value="${kmCarmngInfomation.fdNo}"/>
		</list:data-column>
		<list:data-column col="docSubject" title="${ lfn:message('km-carmng:kmCarmngInfomation.docSubject')}" escape="false">
			<c:out value="${kmCarmngInfomation.docSubject}"/>
		</list:data-column>
		<list:data-column col="fdVehichesType" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdVehichesType')}" escape="false">
			<c:out value="${kmCarmngInfomation.fdVehichesType.fdName}"/>
		</list:data-column>
		<list:data-column col="fdSeatNumber" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdSeatNumber')}"  escape="false">
			<c:out value="${kmCarmngInfomation.fdSeatNumber}"/> ${ lfn:message('km-carmng:kmCarmngInfomation.seat') }
		</list:data-column>
		<list:data-column col="fdMotorcadeName" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdMotorcadeId')}"  escape="false">
			<c:out value="${kmCarmngInfomation.fdMotorcade.fdName}"/>
		</list:data-column>
		<list:data-column col="fdDriverName" title="${ lfn:message('km-carmng:kmCarmngInfomation.fdDriverName')}"  escape="false">
			<c:out value="${kmCarmngInfomation.fdDriverName}"/>
		</list:data-column>
		<list:data-column col="docStatus" title="${ lfn:message('km-carmng:kmCarmngInfomation.docStatus')}"  escape="false">
		    <c:out value="${kmCarmngInfomation.docStatus}"/>
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		        /km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=view&fdId=${kmCarmngInfomation.fdId}
		</list:data-column>
		<list:data-column col="fdImageUrl">
			<%  Object basedocObj = pageContext.getAttribute("kmCarmngInfomation");
			   if(basedocObj != null) { 
				   KmCarmngInfomation kmCarmngInfomation = (KmCarmngInfomation)basedocObj;
					String ids = kmCarmngInfomationService.getCarPicIdsByCarId(kmCarmngInfomation.getFdId());
					if(StringUtil.isNotNull(ids)){
						out.print("/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId="+ids.split(";")[0]);
					}
				}
	        %>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>