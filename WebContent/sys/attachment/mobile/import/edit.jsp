<%@page import="com.landray.kmss.sys.filestore.location.util.SysFileLocationUtil"%>
<%@page import="com.landray.kmss.sys.filestore.location.interfaces.ISysFileLocationDirectService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.metadata.interfaces.IExtendDataForm"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.landray.kmss.sys.attachment.util.SysAttViewerUtil"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="com.landray.kmss.sys.mobile.util.MobileUtil"%>
<%@page import="com.landray.kmss.sys.attachment.util.SysAttViewerUtil"%>
<%@page import="com.landray.kmss.util.DbUtils"%>
<%@page import="com.landray.kmss.sys.attachment.util.SysAttPicUtils"%>
<%@page import="java.util.List"%>
<%@ page import="com.landray.kmss.sys.authentication.user.KMSSUser" %>
<%@page import="com.landray.kmss.common.forms.IExtendForm"%>
<%@page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="org.apache.commons.beanutils.PropertyUtils"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>

<c:if test="${empty tiny && empty JsParam._data }">
	<mui:cache-file name="mui-attachment.js" cacheType="md5"/>
</c:if>
<c:choose>
	<c:when test="${param.dTableType=='nonxform'}">
	</c:when>
	<c:otherwise>
		<c:set var="_fdKey" value="${param.fdKey}"/>
	</c:otherwise>
</c:choose>
<% 
KMSSUser user = UserUtil.getKMSSUser();
pageContext.setAttribute("currUserId", user.getUserId()); 
pageContext.setAttribute("isAdmin", user.isAdmin()); 
%>
<c:if test="${param.fdInDetail=='true'}">
	<%
		String dTableType=request.getParameter("dTableType");
		if("nonxform".equals(dTableType)){
			String idx=request.getParameter("idx");
			if(idx.indexOf("!{index}")==-1){
				String key=request.getParameter("fdKey");
				String fieldName=key.split("\\.")[1];
				String formListAttribute=request.getParameter("formListAttribute");
				String formName=request.getParameter("formName");
				IExtendForm formxx=(IExtendForm)request.getAttribute(formName);
				List formList= (List)PropertyUtils.getProperty(formxx,formListAttribute);
				IExtendForm listDetail=(IExtendForm)formList.get(Integer.parseInt(idx));
				String key2=(String)PropertyUtils.getProperty(listDetail,fieldName);
				if(StringUtil.isNull(fieldName)){
					key2="uid_"+IDGenerator.generateID();
				}
				pageContext.setAttribute("_fdKey", key2);
			}
		}else{
			IExtendDataForm form = (IExtendDataForm)request.getAttribute(request.getParameter("formName"));
			String key= request.getParameter("fdFiledName");
			key = key.replace("extendDataFormInfo.value(","").replace(")","");
			String[] keys = key.split("\\.");
			if("!{index}".equals(keys[1])){
				pageContext.setAttribute("_fdKey", "");
			}else{
			   	Map<String,Object> map = form.getExtendDataFormInfo().getFormData();
			    List list = (List)map.get(keys[0]);
			    if(!list.isEmpty()){
				    Map<String,Object> mapDetail=(Map<String,Object>)list.get(Integer.parseInt(keys[1]));
				    pageContext.setAttribute("_fdKey", mapDetail.get(keys[2]));
			    }else{
			    	 pageContext.setAttribute("_fdKey", "");
			    }
			}
		}
	%>
	
</c:if>

<c:if test="${param.formName!=null && param.formName!=''}">
 	<c:set var="_formBean" value="${requestScope[param.formName]}"/>
 	<c:set var="attForms" value="${_formBean.attachmentForms[_fdKey]}" />
 </c:if>
 
 <c:set var="_fdModelName" value="${param.fdModelName}"/>
 <c:if test="${_fdModelName==null || _fdModelName == ''}">
 	<c:if test="${_formBean!=null}">
 		<c:set var="_fdModelName" value="${_formBean.modelClass.name}"/>
 	</c:if>
 </c:if>
 
 <c:set var="_fdModelId" value="${param.fdModelId}"/>
 <c:if test="${_fdModelId==null || _fdModelId == ''}">
 	<c:if test="${_formBean!=null}">
 		<c:set var="_fdModelId" value="${_formBean.fdId}"/>
 	</c:if>
 </c:if>

<c:set var="_fdMulti" value="true"/>
<c:if test="${param.fdMulti!=null}">
	<c:set var="_fdMulti" value="${param.fdMulti}"/>
</c:if>

<%-- fdAttType: byte/pic--%>
<c:set var="_fdAttType" value="byte"/>
<c:if test="${param.fdAttType!=null}">
	<c:set var="_fdAttType" value="${param.fdAttType}"/>
</c:if>

<c:set var="_fdRequired" value="false"></c:set>
<c:if test="${param.fdRequired==true || param.fdRequired=='true'}">
	<c:set var="_fdRequired" value="true"/>
</c:if>

<%-- fdViewType: normal/simple--%>
<c:set var="_fdViewType" value="normal"></c:set>
<c:if test="${param.fdViewType!=null}">
	<c:set var="_fdViewType" value="${param.fdViewType}"/>
</c:if>

<c:set var="_extParam" value=""></c:set>
<c:if test="${param.extParam!=null}">
	<c:set var="_extParam" value="${param.extParam}"/>
</c:if>

<c:set var="_fdName" value=""></c:set>
<c:if test="${param.fdName!=null}">
	<c:set var="_fdName" value="${param.fdName}"/>
</c:if>

<c:set var="_subject" value="${ lfn:message('sys-attachment:mui.sysAttMain.button.upload') }"></c:set>
<c:if test="${param.fdAttType!=null&&param.fdAttType=='pic'}">
	<c:set var="_subject" value="${ lfn:message('sys-attachment:sysAttMain.button.img.upload') }"/>
</c:if>
<c:if test="${param.label!=null}">
	<c:set var="_subject" value="${param.label}"/>
</c:if>
<c:set var="_orient" value="none"></c:set>
<c:if test="${param.orient!=null}">
	<c:set var="_orient" value="${param.orient}"/>
</c:if>

<c:set var="_customSubject" value=""></c:set>
<c:if test="${param.customSubject!=null}">
	<c:set var="_customSubject" value="${param.customSubject}"/>
</c:if>

<c:set var="_customWarnTipMsg" value=""></c:set>
<c:if test="${param.customWarnTipMsg!=null}">
	<c:set var="_customWarnTipMsg" value="${param.customWarnTipMsg}"/>
</c:if>

<%--?????????????????? --%>
<c:set var="_enabledFileType" value=""></c:set>
<c:if test="${param.enabledFileType!=null}">
	<c:set var="_enabledFileType" value="${param.enabledFileType}"/>
</c:if>

<c:set var="_capture" value=""></c:set>
<c:if test="${param.capture!=null}">
	<c:set var="_capture" value="${param.capture}"/>
</c:if>

<%-- ???????????? --%>
<c:set var="align" value="left"></c:set>
<c:if test="${param.align!=null}">
	<c:set var="align" value="${param.align}"/>
</c:if>

<c:set var="_fdDisabledFileType" value=""/>
<% 
	if(StringUtil.isNotNull(ResourceUtil.getKmssConfigString("sys.att.fileLimitType"))){
		pageContext.setAttribute("_fileLimitType",ResourceUtil.getKmssConfigString("sys.att.fileLimitType"));
		pageContext.setAttribute("_fdDisabledFileType",ResourceUtil.getKmssConfigString("sys.att.disabledFileType"));
	}else{
		pageContext.setAttribute("_fileLimitType","1");
		pageContext.setAttribute("_fdDisabledFileType",".js;.bat;.exe;.sh");		
	}
    if(StringUtil.isNotNull(ResourceUtil.getKmssConfigString("sys.att.smallMaxSize"))){
	pageContext.setAttribute("_fdSmallMaxSize",ResourceUtil.getKmssConfigString("sys.att.smallMaxSize"));
	}  
	  if(StringUtil.isNotNull(ResourceUtil.getKmssConfigString("sys.att.imageMaxSize"))){
			pageContext.setAttribute("_fdImageMaxSize",ResourceUtil.getKmssConfigString("sys.att.imageMaxSize"));
    }
%>

	<%
		JSONObject jsonObj = new JSONObject();
		jsonObj.accumulate("fdKey",pageContext.getAttribute("_fdKey"));
		jsonObj.accumulate("name",pageContext.getAttribute("_fdName"));
		jsonObj.accumulate("fdFiledName",request.getParameter("fdFiledName"));
		jsonObj.accumulate("fdModelName",pageContext.getAttribute("_fdModelName"));
		jsonObj.accumulate("fdModelId",pageContext.getAttribute("_fdModelId"));
		jsonObj.accumulate("viewType",pageContext.getAttribute("_fdViewType"));
		jsonObj.accumulate("required","true".equals(pageContext.getAttribute("_fdRequired")));
		jsonObj.accumulate("editMode","edit");
		jsonObj.accumulate("extParam",pageContext.getAttribute("_extParam"));
		jsonObj.accumulate("fdAttType",pageContext.getAttribute("_fdAttType"));
		jsonObj.accumulate("fileLimitType",pageContext.getAttribute("_fileLimitType"));	
		jsonObj.accumulate("fdDisabledFileType",pageContext.getAttribute("_fdDisabledFileType"));
		jsonObj.accumulate("fdSmallMaxSize",pageContext.getAttribute("_fdSmallMaxSize"));
		jsonObj.accumulate("fdImageMaxSize",pageContext.getAttribute("_fdImageMaxSize"));
		jsonObj.accumulate("fdMulti","true".equals(pageContext.getAttribute("_fdMulti")));
		jsonObj.accumulate("subject",pageContext.getAttribute("_subject"));
		jsonObj.accumulate("orient",pageContext.getAttribute("_orient"));
		jsonObj.accumulate("capture",pageContext.getAttribute("_capture"));
		jsonObj.accumulate("align",pageContext.getAttribute("align"));
		jsonObj.accumulate("customWarnTipMsg",pageContext.getAttribute("_customWarnTipMsg"));
		jsonObj.accumulate("enabledFileType",pageContext.getAttribute("_enabledFileType"));
		String jsonProp = jsonObj.toString();
		pageContext.setAttribute("jsonProp",StringUtil.XMLEscape(jsonProp.substring(1,jsonProp.length()-1)));
		pageContext.setAttribute("required","true".equals(pageContext.getAttribute("_fdRequired")));
		pageContext.setAttribute("_fdAttType",pageContext.getAttribute("_fdAttType"));
	%>
	<div 
		data-dojo-type="sys/attachment/mobile/js/AttachmentList"  <c:if test="${not empty param.widgitId }">id="${param.widgitId}"</c:if>
		data-dojo-props="${ jsonProp }">
		<div data-dojo-type="sys/attachment/mobile/js/AttachmentEvent"
			 data-dojo-props="isResizeListView:${JsParam.isResizeListView == 'false' ? false : true}">
		</div>
		<c:forEach var="sysAttMain" items="${attForms.attachments}" varStatus="vsStatus">
			<c:set var="downLoadUrl" value="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${sysAttMain.fdId}" />
			<c:if test="${_downLoadNoRight==true || _downLoadNoRight=='true'}">
				<c:set var="downLoadUrl" value="/third/pda/attdownload.jsp?fdId=${sysAttMain.fdId}" />
			</c:if>
			<%
				SysAttMain sysAtt = (SysAttMain) pageContext.getAttribute("sysAttMain");
				String escapeFileName = StringEscapeUtils.escapeJavaScript(sysAtt.getFdFileName());
				pageContext.setAttribute("escapeFileName", escapeFileName);
			%>
		<%
			SysAttMain sysAttMain = (SysAttMain) pageContext
						.getAttribute("sysAttMain");
				Boolean hasViewer = Boolean.FALSE;
				String viewPicHref = "/third/pda/attdownload.jsp?open=1";
				if (SysAttViewerUtil.isConverted(sysAttMain)
						&& sysAttMain.getFdContentType().indexOf("video") < 0
						|| sysAttMain.getFdFileName().indexOf("mp4") >= 0
						|| sysAttMain.getFdFileName().indexOf("m4v") >= 0
						|| sysAttMain.getFdFileName().indexOf("flv") >= 0
						|| sysAttMain.getFdFileName().indexOf("f4v") >= 0
						|| sysAttMain.getFdFileName().indexOf("ogg") >= 0
						|| sysAttMain.getFdFileName().indexOf("3gp") >= 0
						|| sysAttMain.getFdFileName().indexOf("avi") >= 0
						|| sysAttMain.getFdFileName().indexOf("wmv") >= 0
						|| sysAttMain.getFdFileName().indexOf("asx") >= 0
						|| sysAttMain.getFdFileName().indexOf("asf") >= 0
						|| sysAttMain.getFdFileName().indexOf("mpg") >= 0
						|| sysAttMain.getFdFileName().indexOf("mov") >= 0
						|| sysAttMain.getFdFileName().indexOf("rm") >= 0
						|| sysAttMain.getFdFileName().indexOf("rmvb") >= 0
						|| sysAttMain.getFdFileName().indexOf("wmv9") >= 0
						|| sysAttMain.getFdFileName().indexOf("wrf") >= 0						
						|| sysAttMain.getFdContentType().indexOf("audio") >= 0) {
					hasViewer = Boolean.TRUE;
				}
				String extensionName = FilenameUtils
						.getExtension(sysAttMain.getFdFileName());
				if (MobileUtil.getClientType(request) >= 6
						&& ("pic".equals(sysAttMain.getFdAttType())
								|| SysAttPicUtils.isImageType(extensionName))) {
					long timestamp = DbUtils.getDbTimeMillis();
					viewPicHref = "/resource/pic/attachment.do?method=view";
					viewPicHref += "&t=" + String.valueOf(timestamp);
					viewPicHref += "&k=" + SysAttPicUtils.generate(
							String.valueOf(timestamp) + sysAttMain.getFdId());
				}
				pageContext.setAttribute("viewPicHref", viewPicHref);
				pageContext.setAttribute("hasViewer", hasViewer);
		%>
		
			<div data-dojo-type="sys/attachment/mobile/js/AttachmentEditListItem" 
				data-dojo-props="name:'${escapeFileName}',
					size:'${sysAttMain.fdSize}',
					href:'${downLoadUrl}',
					thumb:'/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=small&fdId=${sysAttMain.fdId}',
					viewPicHref : '${viewPicHref }',
					hasViewer:${hasViewer},
					fdId:'${sysAttMain.fdId}',
					showDeleteIcon:'${   param.allCanNotDelete eq 'true' ? isAdmin  :  ( param.otherCanNotDelete eq 'true' ? (sysAttMain.fdCreatorId eq currUserId || isAdmin) : true )  }',
					type:'${sysAttMain.fdContentType}'">
			</div>
		</c:forEach>
		
		<div data-dojo-type="sys/attachment/mobile/js/AttachmentOptListItem" 
			data-dojo-props="_fdAttType:'${_fdAttType}',customSubject:'${_customSubject }',capture:'${_capture}',orient:'${_orient}',align:'${align}'">
		</div>
		
		<%-- ??????form.js--%>
		<c:if test="${param.fdInDetail=='true'}">
			<xform:text showStatus="noShow"  property="${param.fdFiledName}" value="${_fdKey}"/>
		</c:if>
	</div>
<%
		ISysFileLocationDirectService directService =
				SysFileLocationUtil.getDirectService();
		request.setAttribute("methodName", directService.getMethodName());
		request.setAttribute("uploadUrl", directService.getUploadUrl(request.getHeader("User-Agent")));
		request.setAttribute("isSupportDirect", directService.isSupportDirect(request.getHeader("User-Agent")));
		request.setAttribute("fileVal", directService.getFileVal());
	%>
<script>
	var attachmentConfig = {
		<%-- ????????????--%>
		uploadurl: '${uploadUrl}',
		<%-- ???????????????--%>
		methodName: '${methodName}',
		<%-- ????????????????????????--%>
		isSupportDirect: ${isSupportDirect},
		<%-- ??????key--%>
		fileVal: '${fileVal}'|| null
	}
</script>
