<%@page import="com.landray.kmss.sys.vote.forms.IVoteCategoryForm"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.vote.service.IKmVoteCategoryService"%>
<%@page import="com.landray.kmss.km.vote.model.KmVoteCategory"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%
	IVoteCategoryForm form = (IVoteCategoryForm)request.getAttribute(request.getParameter("formName"));
	String propertyId = StringUtil.isNotNull(request.getParameter("propertyId")) ? 
			request.getParameter("propertyId") : "fdVoteCategoryId";
	String propertyName = StringUtil.isNotNull(request.getParameter("propertyName")) ?
			request.getParameter("propertyName") : "fdVoteCategoryName";	
	if(StringUtil.isNull(form.getFdVoteCategoryName())
			&& StringUtil.isNotNull(form.getFdVoteCategoryId())){
		IKmVoteCategoryService service = (IKmVoteCategoryService)SpringBeanUtil.getBean("kmVoteCategoryService");
		KmVoteCategory category = (KmVoteCategory)service.findByPrimaryKey(form.getFdVoteCategoryId());
		form.setFdVoteCategoryName(category.getFdName());
	}
	request.setAttribute("propertyId", propertyId);	
	request.setAttribute("propertyName", propertyName);	
%>
<xform:text property="${propertyName }"></xform:text>