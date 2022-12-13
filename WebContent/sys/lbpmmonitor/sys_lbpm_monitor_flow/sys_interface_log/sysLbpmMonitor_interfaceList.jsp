<%@page import="com.landray.kmss.sys.lbpmmonitor.model.Interfacelog"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<list:data>
	<list:data-columns var="interfacelog" list="${queryPage.list }" varIndex="status">
	    <list:data-column property="fdId">
		</list:data-column >
		
		 <list:data-column col="processStatus" >
		 	${interfacelog.lbpmProcess.fdStatus}
		</list:data-column >
		
		 <list:data-column col="interfacelogStatus" >
		 	${interfacelog.transferResult}
		</list:data-column >
		
		<list:data-column col="url" escape="false">
		    <c:if test="${not empty urltMap[interfacelog.fdId]}">
	             ${urltMap[interfacelog.fdId]}
	        </c:if>
		</list:data-column >
		<list:data-column col="index">
		     ${status+1}
		</list:data-column >
	    <!--标题-->
	    <list:data-column col="subject" title="${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.person.docSubject') }" escape="false" style="text-align:center">
		     <c:if test="${not empty subjectMap[interfacelog.fdId]}">
		          <span class="com_subject">${subjectMap[interfacelog.fdId]}</span>
	        </c:if>
		</list:data-column>
		
		<!--函数名称-->
		 <list:data-column  property="transferDesc" title="${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interfacelog.transferName') }"> 
		</list:data-column>

		<!--对接系统-->
		<list:data-column col="transferSystem"   title="${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interfacelog.transferSystem') }"> 
		 	<c:if test="${interfacelog.transferSystem=='1'}">
		          	SAP
	        </c:if>
	        <c:if test="${interfacelog.transferSystem=='2'}">
		          	K3
	        </c:if>
	        <c:if test="${interfacelog.transferSystem=='3'}">
		          	EAS
	        </c:if>
	         <c:if test="${interfacelog.transferSystem=='4'}">
		          	U8
	        </c:if>
	         <c:if test="${interfacelog.transferSystem=='5'}">
		          	业务集成
	        </c:if>
		</list:data-column>
		
	    <!--执行情况-->
	    <list:data-column  col="transferResult" title="${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interfacelog.implementation') }" escape="false" style="text-align:center">
		     <c:if test="${interfacelog.transferResult=='0'}">
		          	${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.sucess")}
	        </c:if>
	        <c:if test="${interfacelog.transferResult=='1'}">
		          	${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.error")}
	        </c:if>
	        <c:if test="${interfacelog.transferResult=='2'}">
		          	${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.busError")}
	        </c:if>
		</list:data-column>
		
		<!--流程状态-->
	    <list:data-column col="lbpmStatus" title="${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interface.flowStatus') }" escape="false" style="text-align:center">
		   	<c:if test="${interfacelog.lbpmProcess.fdStatus=='21'}">
		          	${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.error")}
	        </c:if>
	        <c:if test="${interfacelog.lbpmProcess.fdStatus!='21'}">
		          	${lfn:message("sys-lbpmmonitor:sysLbpmMonitor.interface.sucess")}
	        </c:if>
		</list:data-column>
		
		
		<!--创建时间-->
		<list:data-column col="fdCreateTime" styleClass="width100" title="${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interface.transferInterfaceTime') }">
				<kmss:showDate value="${interfacelog.fdCreateTime}" type="dateTime"/>
		</list:data-column>
		
		<!--当前环节-->
		<list:data-column col="nodeName" title="${ lfn:message('sys-lbpmmonitor:sysLbpmMonitor.interfacelog.currentNode') }" escape="false" style="text-align:center">
		     <c:if test="${not empty nodeNameMap[interfacelog.fdId]}">
		          <span class="com_subject">${nodeNameMap[interfacelog.fdId]}</span>
	        </c:if>
		</list:data-column>
		
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>