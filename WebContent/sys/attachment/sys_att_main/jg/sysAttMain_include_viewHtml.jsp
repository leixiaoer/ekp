<%@page import="com.landray.kmss.sys.tag.model.SysTagAppConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="java.util.List,com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil,com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsWebOfficeUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@ page import="com.landray.kmss.sys.attachment.util.SysAttConfigUtil" %>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(SysAttWpsCloudUtil.isEnable()));
%>

<%
String formBeanName = request.getParameter("formBeanName");
//是否使用了wps预览转换服务
String isUseWpsOnlineView = request.getParameter("isUseWpsOnlineView");
if ("true".equals(isUseWpsOnlineView)) {
	pageContext.setAttribute("_pIsUseWpsOnlineView", "true");
} else {
	pageContext.setAttribute("_pIsUseWpsOnlineView", "false");
}
Object formBean = null;

if(formBeanName != null && formBeanName.trim().length() != 0){
	formBean = pageContext.getAttribute(formBeanName);
	if(formBean == null){
		formBean = request.getAttribute(formBeanName);
	}
	if(formBean == null){
		formBean = session.getAttribute(formBeanName);
	}
	pageContext.setAttribute("_formBean", formBean);
}else{
	formBeanName = "com.landray.kmss.web.taglib.FormBean";
}
//得到文档状态，用于控制留痕按钮在发布状态中不显示
String docStatus = null;
try{
docStatus = (String)org.apache.commons.beanutils.PropertyUtils.getProperty(formBean,"docStatus");
pageContext.setAttribute("_docStatus", docStatus);
}catch(Exception e){}

//得到文档标题,下载时取文档标题
String fileName= null;
try{
	String docSubject = (String)org.apache.commons.beanutils.PropertyUtils.getProperty(formBean,"docSubject"); 
	if(StringUtil.isNotNull(docSubject)){
		fileName = docSubject;
	}else{
		String fdName = (String)org.apache.commons.beanutils.PropertyUtils.getProperty(formBean,"fdName"); 
		if(StringUtil.isNotNull(fdName)){
			fileName = fdName;
		}
	}
	Pattern pattern = Pattern.compile("[\\s\\\\/:\\*\\?\\\"<>\\|]");
    Matcher matcher = pattern.matcher(fileName);
    fileName= matcher.replaceAll("");
    
    if(fileName.length() > 100 ){
    	fileName = fileName.substring(0, 100);
    }
    
	pageContext.setAttribute("_fileName",fileName+".doc");
}catch(Exception e){}

Object originFormBean = pageContext.getAttribute("com.landray.kmss.web.taglib.FormBean");
pageContext.setAttribute("com.landray.kmss.web.taglib.FormBean", formBean);
if(formBean == null){
	formBean = com.landray.kmss.web.taglib.TagUtils.getInstance().lookup(pageContext,
			formBeanName, null);
	pageContext.setAttribute("_formBean", formBean);
}
%>
<c:set var="attForms" value="${_formBean.attachmentForms[param.fdKey]}" />
<c:set var="attachmentId" value=""/>
<c:set var="fdFileName" value="${_fileName}"/>
<c:set var="sysAttMains" value="${attForms.attachments}" />
<%
		//以下代码用于附件不通过form读取的方式
		List sysAttMains = (List)pageContext.getAttribute("sysAttMains");
		if(sysAttMains==null || sysAttMains.isEmpty()){
			try{
				String _modelName = request.getParameter("fdModelName");
				String _modelId = request.getParameter("fdModelId");
				String _key = request.getParameter("fdKey");
				if(StringUtil.isNotNull(_modelName) 
						&& StringUtil.isNotNull(_modelId) 
						&& StringUtil.isNotNull(_key)){
					ISysAttMainCoreInnerService sysAttMainService = (ISysAttMainCoreInnerService)SpringBeanUtil.getBean("sysAttMainService");
					sysAttMains = sysAttMainService.findByModelKey(_modelName,_modelId,_key);
				}
				if(sysAttMains!=null && !sysAttMains.isEmpty()){
					pageContext.setAttribute("sysAttMains",sysAttMains);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
<c:forEach items="${sysAttMains}" var="sysAttMain"	varStatus="vstatus">
	<c:set var="attachmentId" value="${sysAttMain.fdId}"/>
	<c:if test="${empty _fileName}">
	  <c:set var="fdFileName" value="${sysAttMain.fdFileName}"/>
	</c:if>
	<c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
</c:forEach>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<c:choose>
	<c:when test="${empty param.isShowImg or param.isShowImg}">
	   <%
	   //取fdAttMainId的值判断附件是否已经转换
	   if(JgWebOffice.isExistViewPath(request) && !"true".equals(isUseWpsOnlineView)){ 
	  %>
		    <%
			   boolean isExpand = "true".equals(request.getParameter("isExpand"));
			   if(isExpand){
		    %>
		    			<c:choose>
	                  <c:when test="${_isWpsCloudEnable or  param.showAllPage eq 'false'}">
	                  	<c:set var="iframeH" value="556px"></c:set>
	                  </c:when>
	                   <c:otherwise>
	                   	<c:set var="iframeH" value="100%"></c:set>
	                   </c:otherwise>
	                </c:choose>
				   <c:choose>
	                  <c:when test="${empty param.showAllPage or param.showAllPage}">
						   <iframe id="IFrame_Content" width="100%" height="${iframeH}" src='<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&showAllPage=true"/>'
									frameborder="0" scrolling="no">
						   </iframe>
					  </c:when>
					  <c:otherwise>
						  <iframe id="IFrame_Content" width="100%" height="${iframeH}" src='<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&toolPosition=top&newOpen=true&inner=yes"/>'
									frameborder="0" scrolling="auto">
						   </iframe>
				      </c:otherwise>
					</c:choose>
			 <%}else{ %>
			       <c:choose>
	                  <c:when test="${empty param.showAllPage or param.showAllPage}">
					     <ui:event event="show">
					  	  	document.getElementById('IFrame_Content').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&showAllPage=true"/>");
					     </ui:event>
					     <iframe id="IFrame_Content" width="100%" height="100%"
							frameborder="0" scrolling="no"> 
					     </iframe>
				     </c:when>
					 <c:otherwise> 
					     <ui:event event="show">
					  	  document.getElementById('IFrame_Content').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attachmentId}&viewer=htmlviewer&toolPosition=top&newOpen=true&inner=yes"/>");
					     </ui:event>
					     <iframe id="IFrame_Content" width="100%" height="600px"
							frameborder="0" scrolling="auto"> 
					     </iframe>
				     </c:otherwise>
					</c:choose>
			<%} %>	 
	 <%}else{ 
		 boolean fdForceUseJG = "true".equals(request.getParameter("fdForceUseJG"));
		 	 if(fdForceUseJG){
	 %>	 
		 	<%@ include file="sysAttMain_viewinclude.jsp"%>
		 <%	 } else {
			 if(SysAttWpsWebOfficeUtil.isEnable()){
		 %>
	 		<%@ include file="/sys/attachment/sys_att_main/wps/sysAttMain_viewinclude.jsp"%>
	         <%}else if(SysAttWpsCloudUtil.isEnable() || "true".equals(isUseWpsOnlineView) || SysAttWpsCloudUtil.getUseWpsLinuxView()){
	         %>	 
	         <%@ include file="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_viewinclude.jsp"%>
	        <% }else { 
	        	 boolean showAsJG = !"false".equals(request.getParameter("showAsJG"));
	   		    if(showAsJG){
	         %>
		     	 <%@ include file="sysAttMain_viewinclude.jsp"%>
		     <% }%>
	     <% }%>
	    <%} %> 
	<%} %>
	</c:when>
	<c:otherwise>
	<%
		boolean fdForceUseJG = "true".equals(request.getParameter("fdForceUseJG"));
	 	 if(fdForceUseJG){
	%>
		<%@ include file="sysAttMain_viewinclude.jsp"%>
	<%}else{ 
		if(SysAttWpsWebOfficeUtil.isEnable()){ %>
        	<%@ include file="/sys/attachment/sys_att_main/wps/sysAttMain_viewinclude.jsp"%>
         <%}else if(SysAttWpsCloudUtil.isEnable() || SysAttWpsCloudUtil.getUseWpsLinuxView()){
	         %>	 
	         <%@ include file="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_viewinclude.jsp"%>
        <% }else{%>
        	<%@ include file="sysAttMain_viewinclude.jsp"%>
        <% }%>
	<% }%>
		
    </c:otherwise>
</c:choose>