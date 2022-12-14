<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsoaassistUtil"%>
<c:set var="wpsoaassist" value="<%=SysAttWpsoaassistUtil.isEnable()%>"/>

<c:choose>
	<c:when test="${ param.fdAttType == 'office'}">
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit_ocx.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="${ param.fdKey }" />
			<c:param name="fdModelName" value="${ param.fdModelName }" />
			<c:param name="fdModelId" value="${ param.fdModelId }" />
			<c:param name="fdMulti" value="${ param.fdMulti }" />
			<c:param name="fdAttType" value="${ param.fdAttType }" />
			<c:param name="fdViewType" value="${ param.fdViewType }" />
			<c:param name="formBeanName" value="${param.formBeanName }" />	
			
			<c:param name="fdImgHtmlProperty" value="${param.fdImgHtmlProperty }" />
			<c:param name="fdShowMsg" value="${ param.fdShowMsg }" />
			<c:param name="showDefault" value="${ param.showDefault }" />
			<c:param name="buttonDiv" value="${ param.buttonDiv }" />
			<c:param name="fdOfficeType" value="${param.fdOfficeType}" />
			<c:param name="bookMarks" value="${param.bookMarks}" />
			<c:param name="width" value="${param.picWidth}" />
			<c:param name="height" value="${param.picHeight}" />
			<c:param name="proportion" value="${param.proportion}" />
			
			<c:param name="isTemplate" value="${ param.isTemplate }" />
			<c:param name="fdTemplateModelId" value="${param.fdTemplateId}" />
			<c:param name="fdTemplateModelName" value="${param.fdTemplateModelName}" />
			<c:param name="fdTemplateKey" value="${param.fdTemplateKey}" />
			<c:param name="templateBeanName" value="${param.templateBeanName}"/>
			<c:param name="fdSupportLarge" value="${param.fdSupportLarge}"/>
		</c:import>
	</c:when>
	<c:when test="${ param.dtable == 'true'}">
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit_dt_swf.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="${ param.fdKey }" />
			<c:param name="fdModelName" value="${ param.fdModelName }" />
			<c:param name="fdModelId" value="${ param.fdModelId }" />
			<c:param name="fdMulti" value="${ param.fdMulti }" />
			<c:param name="fdAttType" value="${ param.fdAttType }" />
			<c:param name="fdViewType" value="${ param.fdViewType }" />
			<c:param name="fdRequired" value="${ param.fdRequired }" />
			<c:param name="formBeanName" value="${ param.formBeanName }" />	
			<c:param name="enabledFileType" value="${ param.enabledFileType }" />
			<c:param name="uploadUrl" value="${ param.uploadUrl }" />	
			
			<c:param name="fdImgHtmlProperty" value="${ param.fdImgHtmlProperty }" />
			<c:param name="fdShowMsg" value="${ param.fdShowMsg }" />
			<c:param name="showDefault" value="${ param.showDefault }" />
			<c:param name="buttonDiv" value="${ param.buttonDiv }" />
			<c:param name="fdOfficeType" value="${param.fdOfficeType}" />
			<c:param name="bookMarks" value="${param.bookMarks}" />
			<c:param name="width" value="${param.picWidth}" />
			<c:param name="height" value="${param.picHeight}" />
			<c:param name="proportion" value="${param.proportion}" />
			
			<c:param name="isTemplate" value="${ param.isTemplate }" />
			<c:param name="fdTemplateModelId" value="${param.fdTemplateId}" />
			<c:param name="fdTemplateModelName" value="${param.fdTemplateModelName}" />
			<c:param name="fdTemplateKey" value="${param.fdTemplateKey}" />
			<c:param name="templateBeanName" value="${param.templateBeanName}" />
			<c:param name="fdSupportLarge" value="${param.fdSupportLarge}"/>
			
			<c:param name="extParam" value="${param.extParam}"/>
			<c:param name="fdLayoutType" value="${param.fdLayoutType}" />	
			<c:param name="fdPicContentWidth" value="${param.fdPicContentWidth}" />	
			<c:param name="fdPicContentHeight" value="${param.fdPicContentHeight}" />
			<c:param name="idx" value="${param.idx}" />	
			<%-- ?????????????????????????????????????????? --%>
			<c:param name="otherCanNotDelete" value="${ param.otherCanNotDelete }" />
			<c:param name="allCanNotDelete" value="${ param.allCanNotDelete }" />
			<c:param  name="hideReplace"  value="${param.hideReplace}"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:if test="${param.wpsExtAppModel eq 'kmImissive'}">
			<c:set var="wpsoaassist" value="true"/>
		</c:if>
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit_swf.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="${ param.fdKey }" />
			<c:param name="fdModelName" value="${ param.fdModelName }" />
			<c:param name="fdModelId" value="${ param.fdModelId }" />
			<c:param name="fdMulti" value="${ param.fdMulti }" />
			<c:param name="fdAttType" value="${ param.fdAttType }" />
			<c:param name="fdViewType" value="${ param.fdViewType }" />
			<c:param name="fdRequired" value="${ param.fdRequired }" />
			<c:param name="formBeanName" value="${ param.formBeanName }" />	
			<c:param name="enabledFileType" value="${ param.enabledFileType }" />	
			<c:param name="uploadUrl" value="${ param.uploadUrl }" />
			<c:param name="fileNumLimit" value="${ param.fileNumLimit }" />	
			<c:param name="disabledImageView" value="${JsParam.disabledImageView }" />	
			
			<c:param name="fdImgHtmlProperty" value="${ param.fdImgHtmlProperty }" />
			<c:param name="fdImgSizeLimit" value="${ param.fdImgSizeLimit }" />
			<c:param name="fdShowMsg" value="${ param.fdShowMsg }" />
			<c:param name="showDefault" value="${ param.showDefault }" />
			<c:param name="buttonDiv" value="${ param.buttonDiv }" />
			<c:param name="fdOfficeType" value="${param.fdOfficeType}" />
			<c:param name="bookMarks" value="${param.bookMarks}" />
			<c:param name="width" value="${param.picWidth}" />
			<c:param name="height" value="${param.picHeight}" />
			<c:param name="proportion" value="${param.proportion}" />
			<c:param name="uploadText" value="${param.uploadText}" />
			
			<c:param name="isTemplate" value="${ param.isTemplate }" />
			<c:param name="fdTemplateModelId" value="${param.fdTemplateId}" />
			<c:param name="fdTemplateModelName" value="${param.fdTemplateModelName}" />
			<c:param name="fdTemplateKey" value="${param.fdTemplateKey}" />
			<c:param name="templateBeanName" value="${param.templateBeanName}" />
			<c:param name="fdSupportLarge" value="${param.fdSupportLarge}"/>
			
			<c:param name="extParam" value="${param.extParam}"/>
			<c:param name="fdLayoutType" value="${param.fdLayoutType}" />	
			<c:param name="fdPicContentWidth" value="${param.fdPicContentWidth}" />	
			<c:param name="fdPicContentHeight" value="${param.fdPicContentHeight}" />	
			<c:param name="fdLabel" value="${ param.fdLabel }" />
			<c:param name="fdGroup" value="${ param.fdGroup }" />
			<c:param name="addToPreview" value="${ param.addToPreview }" />
			<%-- ???????????????????????????????????????????????? --%>
			<c:param name="supportDnd" value="${ param.supportDnd }" />
			<%-- ?????????????????????????????????????????? --%>
			<c:param name="supportDndSort" value="${ param.supportDndSort }" />
			<%-- ???????????? --%>
			<c:param name="fixedWidth" value="${ param.fixedWidth }" />
			<%-- ????????????????????????90% ??? 980px???????????????100% --%>
			<c:param name="totalWidth" value="${ param.totalWidth }" />
			<%-- ????????????????????????????????????????????????window.isPrintModel = true??? --%>
			<c:param name="isPrintModel" value="${ param.isPrintModel }" />
			<%-- ????????????????????????????????????????????????????????????????????? --%>
			<c:param name="showDelete" value="${ param.showDelete }" />
			<%-- ?????????????????????????????????????????? --%>
			<c:param name="otherCanNotDelete" value="${ param.otherCanNotDelete }" />
			<c:param name="allCanNotDelete" value="${ param.allCanNotDelete }" />
			<c:param name="wpsoaassist" value="${wpsoaassist}" />
			<c:param name="wpsExtAppModel" value="${param.wpsExtAppModel}" />
			<c:param name="cleardraft" value="${param.cleardraft}" />
			<c:param name="signtrue" value="${param.signtrue}" />
			<c:param name="newFlag" value="${param.newFlag}" />
			<c:param  name="saveRevisions"  value="${param.saveRevisions}"/>
			<c:param  name="forceRevisions"  value="${param.forceRevisions}"/>
			<%-- ?????????????????? --%>
			<c:param  name="canRead"  value="${param.canRead}"/>
			<%-- ?????????????????? --%>
			<c:param  name="canEdit"  value="${param.canEdit}"/>
			<%-- ??????????????????--%>
			<c:param  name="canPrint"  value="${param.canPrint}"/>
			<%-- ????????????????????????????????? --%>
			<c:param  name="hideTips"  value="${param.hideTips}"/>
			<%-- ??????????????????????????????????????? --%>
			<c:param  name="hideReplace"  value="${param.hideReplace}"/>
			 <%-- ???????????????????????? --%>
			 <c:param  name="canChangeName"  value="${param.canChangeName}"/>
			  <%-- ???????????????????????? --%>
			  <c:param  name="filenameWidth"  value="${param.filenameWidth}"/>
			<c:param  name="fileNameMax"  value="${param.fileNameMax}"/>
		</c:import>
	</c:otherwise>
</c:choose>
