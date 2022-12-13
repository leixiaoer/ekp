<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ page import="com.landray.kmss.sys.vote.model.IVoteMainModel"%>
<%@ page import="com.landray.kmss.common.model.IBaseModel"%>
<%@ page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ page import="com.landray.kmss.common.service.IBaseService"%>
<%@ page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@ page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

<div data-dojo-type="mui/panel/Content" title="${ lfn:message('km-vote:kmVoteMain.mechanism.tab') }" data-dojo-props="icon:''">
	<div data-dojo-type="dojox/mobile/View">
		<ul data-dojo-type="mui/list/JsonStoreList" 
			data-dojo-mixins="km/vote/mobile/js/list/VoteItemListMixin"
			data-dojo-props="url:'/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&modelId=${param.fdModelId}&modelName=${param.fdModelName }',lazy:false">
		</ul>
		
		<div class="muiAccordionPanelContentBottom">
			<kmss:authShow roles="ROLE_KMVOTEMAIN_CREATE">
			<c:if test="${param.showCreate == 'true'}">
				<li class="muiAccordionPanelContentBtn"
					style="float: none;"
					data-dojo-type="km/vote/mobile/import/js/CreateButton" 
					data-dojo-mixins="mui/simplecategory/SimpleCategoryMixin"
					data-dojo-props="icon:'',fdVoteCategoryId:'${fdVoteCategoryId}',colSize:2,createUrl:'/km/vote/km_vote_main/kmVoteMain.do?method=add&fdCategoryId=!{curIds}&modelName=${param.fdModelName}&modelId=${param.fdModelId}',modelName:'com.landray.kmss.km.vote.model.KmVoteCategory'">
					+ <bean:message bundle="km-vote" key="button.launchedVote" />
				</li>
			</c:if>
			</kmss:authShow>
		</div>
		
	</div>
</div>