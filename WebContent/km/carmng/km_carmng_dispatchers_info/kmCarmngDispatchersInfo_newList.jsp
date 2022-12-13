<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfo"%>
<%@ page import="com.landray.kmss.km.carmng.model.KmCarmngDispatchersInfoList"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngDispatchersInfo" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<%--
		<list:data-column  col="fdCarInfo.fdNo"  title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdCarInfoId') }" escape="false" style="text-align:left">
			<c:out value="${kmCarmngDispatchersInfo.fdCarInfo.fdNo}"/>
		</list:data-column>
		<list:data-column headerStyle="100px" col="fdCarInfo.fdMotorcade.fdName" title="${ lfn:message('km-carmng:kmCarmngDriversInfo.fdMotorcadeId')}" style="width:15%"  escape="false">
			<c:out value="${kmCarmngDispatchersInfo.fdCarInfo.fdMotorcade.fdName}"/>
		</list:data-column>
		<list:data-column headerStyle="100px" col="fdDestination" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdDestination')}" style="width:20%"  escape="false">
			<c:out value="${kmCarmngDispatchersInfo.fdDestination}"/>
		</list:data-column>
		<list:data-column headerStyle="100px" col="fdTravelPath" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdTravelPath')}" style="width:20%"  escape="false">
			<c:out value="${kmCarmngDispatchersInfo.fdTravelPath}"/>
		</list:data-column>
		--%>
		<list:data-column  col="fdApplicationNames"  title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdApplicationIds') }" escape="false" style="text-align:center">
			<span class="com_subject"><c:out value="${kmCarmngDispatchersInfo.fdApplicationNames}"/></span>
		</list:data-column>
		<list:data-column  headerStyle="width200" col="fdCarInfoNames"  title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdCarInfoId') }" escape="false" >
			<%
				if(pageContext.getAttribute("kmCarmngDispatchersInfo")!=null){
					String fdCarInfoNames = null;
					KmCarmngDispatchersInfo kmCarmngDispatchersInfo = (KmCarmngDispatchersInfo)pageContext.getAttribute("kmCarmngDispatchersInfo");
					if(null != kmCarmngDispatchersInfo.getFdDispatchersInfoList() && kmCarmngDispatchersInfo.getFdDispatchersInfoList().size() > 0){
						for(KmCarmngDispatchersInfoList infoList : kmCarmngDispatchersInfo.getFdDispatchersInfoList()){
							fdCarInfoNames = (null == fdCarInfoNames ? infoList.getFdCarInfoNo() : fdCarInfoNames + ";" + infoList.getFdCarInfoNo());
						}
					}
					request.setAttribute("fdCarInfoNames", fdCarInfoNames);
				}
			%>
			<c:choose>
				<c:when test="${not empty fdCarInfoNames}">
					<c:out value="${fdCarInfoNames}"/>
				</c:when>
				<c:otherwise>
					<bean:message  bundle="km-carmng" key="KmCarmngDispatchersInfo.field.null"/>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<list:data-column headerStyle="width140" col="fdStartTime" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdStartTime')}" style="width:20%"  escape="false">
			<c:choose>
				<c:when test="${not empty kmCarmngDispatchersInfo.fdStartTime}">
					<kmss:showDate value="${kmCarmngDispatchersInfo.fdStartTime}" />
				</c:when>
				<c:otherwise>
					<bean:message  bundle="km-carmng" key="KmCarmngDispatchersInfo.field.null"/>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<list:data-column headerStyle="width140" col="fdEndTime" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdEndTime')}" style="width:20%"  escape="false">
			<c:choose>
				<c:when test="${not empty kmCarmngDispatchersInfo.fdEndTime}">
					<kmss:showDate value="${kmCarmngDispatchersInfo.fdEndTime}" />
				</c:when>
				<c:otherwise>
					<bean:message  bundle="km-carmng" key="KmCarmngDispatchersInfo.field.null"/>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<list:data-column headerStyle="width100" col="fdFlag" title="${ lfn:message('km-carmng:kmCarmngDispatchersInfo.fdFlag')}" style="width:5%"  escape="false">
			<sunbor:enumsShow value="${kmCarmngDispatchersInfo.fdFlag}"  enumsType="kmCarmngDispatchersInfo_fdFlag"/>	
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>