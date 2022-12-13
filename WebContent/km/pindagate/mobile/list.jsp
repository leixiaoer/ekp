<%@page import="com.landray.kmss.km.pindagate.service.IKmPindagateResponseService"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ModelUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.km.pindagate.model.KmPindagateMain"%>
<%
	ISysAttMainCoreInnerService sysAttMainCoreInnerService=(ISysAttMainCoreInnerService)
			SpringBeanUtil.getBean("sysAttMainService");
	IKmPindagateResponseService kmPindagateResponseService = (IKmPindagateResponseService)
			SpringBeanUtil.getBean("kmPindagateResponseService");
	String prefix = request.getContextPath();
%>
<list:data>
	<list:data-columns var="kmPindagateMain" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		<%--状态--%>
		<list:data-column col="status" title="${ lfn:message('sys-news:sysNewsMain.docStatus') }" escape="false">
			<c:out value="${kmPindagateMain.docStatus}"/>
		</list:data-column>
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('sys-news:sysNewsMain.docSubject') }" escape="false">
			<c:out value="${kmPindagateMain.docSubject}"/>
		</list:data-column>
		<%-- 标题图片 --%>
		<list:data-column col="img" escape="false">
			<%
				KmPindagateMain kmPindagateMain=(KmPindagateMain)pageContext.getAttribute("kmPindagateMain");
				List list=sysAttMainCoreInnerService.findByModelKey(ModelUtil.getModelClassName(kmPindagateMain),kmPindagateMain.getFdId(),"pic");
				if(list!=null && list.size()>0){
					SysAttMain att=(SysAttMain)list.get(0);
					out.print(prefix + "/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=small&fdId="+att.getFdId());
				}else{
					out.print(prefix +"/km/pindagate/resource/images/pindagate_bg.jpg");
				}
			%>
		</list:data-column>
		 <%-- 调查截止时间--%>
	 	<list:data-column col="finishedTime" title="${ lfn:message('sys-news:sysNewsMain.docCreateTime') }">
	        <kmss:showDate value="${kmPindagateMain.docFinishedTime}" type="datetime"></kmss:showDate>
      	</list:data-column>
      	<%-- 参加人数 --%>
      	<list:data-column col="participate" title="${ lfn:message('sys-news:sysNewsMain.docCreateTime') }" escape="false">
      		<% 
      			KmPindagateMain kmPindagateMain = (KmPindagateMain)pageContext.getAttribute("kmPindagateMain");
      			Long participateNumber = kmPindagateResponseService.getParticipateNumber(kmPindagateMain.getFdId());
      			out.print(participateNumber);
      		%>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
			<c:if test="${param.treeNode == 'participate' }">
				/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=add&pindageteId=${kmPindagateMain.fdId}
			</c:if>
			<c:if  test="${param.treeNode == 'set' }">
				/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=view&fdId=${kmPindagateMain.fdId}
			</c:if>
			<c:if  test="${param.treeNode == 'result' }">
				/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateMain.fdId}
			</c:if>
		</list:data-column>
		<list:data-column col="treeNode" >
			<c:out value="${param.treeNode}"></c:out>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>