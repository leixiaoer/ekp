<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.vote.model.IVoteMainModel"%>
<%@ page import="com.landray.kmss.common.model.IBaseModel"%>
<%@ page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ page import="com.landray.kmss.common.service.IBaseService"%>
<%@ page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@ page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>
<%
	String fdModelId = request.getParameter("fdModelId");
	String fdModelName = request.getParameter("fdModelName");
	if (StringUtil.isNotNull(fdModelId)
			&& StringUtil.isNotNull(fdModelName)) {
		SysDictModel dictModel = SysDataDict.getInstance().getModel(fdModelName);
		if (dictModel != null) {
			IBaseService baseService = (IBaseService) SpringBeanUtil.getBean(dictModel.getServiceBean());
			IBaseModel sModel =  baseService.findByPrimaryKey(fdModelId);
			if (sModel != null && sModel instanceof IVoteMainModel) {
				IVoteMainModel voteModel = (IVoteMainModel) sModel;
				if (StringUtil.isNotNull(voteModel.getFdVoteCategoryId())) {
					request.setAttribute("fdVoteCategoryId", voteModel.getFdVoteCategoryId());
				}
			}
		}
	}
%>
<kmss:authShow roles="ROLE_KMVOTEMAIN_CREATE">
	<li class="muiBtn muiBtnFeedback"
		data-dojo-type="km/vote/mobile/import/js/CreateButton" 
		data-dojo-mixins="mui/simplecategory/SimpleCategoryMixin"
		data-dojo-props="icon:'mui mui-task-icon',fdVoteCategoryId:'${fdVoteCategoryId}',colSize:2,createUrl:'/km/vote/km_vote_main/kmVoteMain.do?method=add&fdCategoryId=!{curIds}&modelName=${JsParam.fdModelName}&modelId=${JsParam.fdModelId}',modelName:'com.landray.kmss.km.vote.model.KmVoteCategory'">
		<bean:message bundle="km-vote" key="button.launchedVote" />
	</li>
</kmss:authShow>