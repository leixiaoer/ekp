/**
 * 
 */
package com.landray.kmss.km.review.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.actions.DataAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.dao.HQLWrapper;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.geesun.base.model.GeesunBaseConfig;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.sys.category.model.SysCategoryMain;
import com.landray.kmss.sys.category.service.ISysCategoryMainService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.lbpmservice.interfaces.LbpmUtil;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.profile.model.ShowConfig;
import com.landray.kmss.sys.workflow.interfaces.SysFlowUtil;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

import edu.emory.mathcs.backport.java.util.Arrays;
import net.sf.json.JSONObject;

/**
 * 二级页面主页对应action
 * 
 * @author 傅游翔
 * 
 */
public class KmReviewIndexAction extends DataAction {

	private IKmReviewMainService kmReviewMainService;

	@Override
	protected IKmReviewMainService getServiceImp(HttpServletRequest request) {
		if (kmReviewMainService == null) {
			kmReviewMainService = (IKmReviewMainService) getBean("kmReviewMainService");
		}
		return kmReviewMainService;
	}

	@Override
	protected String getParentProperty() {
		return "fdTemplate";
	}

	private ISysCategoryMainService categoryMainService;

	@Override
	protected IBaseService getCategoryServiceImp(HttpServletRequest request) {
		if (categoryMainService == null)
			categoryMainService = (ISysCategoryMainService) getBean("sysCategoryMainService");
		return categoryMainService;
	}
	
	private ISysOrgElementService sysOrgElementService;

	protected ISysOrgElementService getSysOrgElementService(HttpServletRequest request) {
		if (sysOrgElementService == null) {
			sysOrgElementService = (ISysOrgElementService) getBean("sysOrgElementService");
		}
		return sysOrgElementService;
	}
	
	/**
	 * 获取nav多标签文档数量
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward count(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		TimeCounter.logCurrentTime("Action-count", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setSelectBlock("count(*)");
			this.changeFindPageHQLInfo(request, hqlInfo);
			hqlInfo.setOrderBy(null);
			@SuppressWarnings("unchecked")
			List<Object> list = getServiceImp(request).findList(hqlInfo);
			request.setAttribute("lui-source", new JSONObject().element(
					"count", list.get(0)));
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-count", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("lui-source", mapping, form, request,
					response);
		}
	}

	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		String orderBy = request.getParameter("orderby");
		String ordertype = request.getParameter("ordertype");
		boolean isReserve = false;
		if (ordertype != null && ordertype.equalsIgnoreCase("down")) {
			isReserve = true;
		}
		String orderById = ",kmReviewMain.fdId";
		if (StringUtil.isNotNull(orderBy)) {
			orderBy = "kmReviewMain." + orderBy ;
			String orderbyDesc = orderBy + " desc" + orderById + " desc";
			String orderbyAll = isReserve ? orderbyDesc : orderBy + orderById;
			return orderbyAll;
		}
		return " kmReviewMain.docCreateTime desc" + orderById + " desc ";
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
		CriteriaValue cv = new CriteriaValue(request);
		String categoryId = cv.poll("fdTemplate");
		String mydoc = cv.poll("mydoc");
		String doctype = cv.poll("doctype");
		String[] docStatusVal = cv.polls("docStatus");
		String whereStr = hqlInfo.getWhereBlock();
		StringBuilder hql = new StringBuilder(StringUtil.isNull(whereStr) ? "1=1 " : whereStr);
		String fdIsFile = cv.poll("fdIsFile");
		if (StringUtil.isNotNull(fdIsFile)) {
			if (fdIsFile.equals("1")) {
				hql.append(" and kmReviewMain.fdIsFiling =:fdIsFiling");
				hqlInfo.setParameter("fdIsFiling", true);
			} else if (fdIsFile.equals("0")) {
				hql.append(
						" and (kmReviewMain.fdIsFiling =:fdIsFiling or kmReviewMain.fdIsFiling is null)");
				hqlInfo.setParameter("fdIsFiling", false);
			}
		}
		String docStatus = "";
		if (docStatusVal != null) {
			if (docStatusVal.length > 1) {
				List<String> __list = new ArrayList<String>();
				for (int i = 0; i < docStatusVal.length; i++) {
					__list.add(docStatusVal[i]);
				}
				hql.append(" and " + HQLUtil.buildLogicIN("kmReviewMain.docStatus", __list));
			} else {
				docStatus = docStatusVal[0];
				if (!("41".equals(docStatus))) {
					hql.append(" and kmReviewMain.docStatus =:docStatus");
					hqlInfo.setParameter("docStatus", docStatus);
					if ("10".equals(docStatus) && "true".equals(request.getParameter("owner"))) {
						hql.append(" and kmReviewMain.docCreator.fdId=:docCreator");
						hqlInfo.setParameter("docCreator", UserUtil.getUser().getFdId());
					}
				}
			}
		}
		if (StringUtil.isNotNull(mydoc)) {
			mydoc = mydoc.trim().toLowerCase();
			if ("create".equals(mydoc)) { // 我启动的流程,不包含废弃和归档
				hql.append(
						" and kmReviewMain.docCreator.fdId=:docCreator ");
				hqlInfo.setParameter("docCreator", UserUtil.getUser().getFdId());
				hqlInfo.setCheckParam(SysAuthConstant.CheckType.AllCheck, SysAuthConstant.AllCheck.NO);
			} else if ("approval".equals(mydoc)) { // 待我审的流程
				SysFlowUtil.buildLimitBlockForMyApproval("kmReviewMain", hqlInfo);
				hqlInfo.setCheckParam(SysAuthConstant.CheckType.AllCheck, SysAuthConstant.AllCheck.NO);
			} else if ("approved".equals(mydoc)) { // 我已审的流程
				SysFlowUtil.buildLimitBlockForMyApproved("kmReviewMain", hqlInfo);
				hqlInfo.setCheckParam(SysAuthConstant.CheckType.AllCheck, SysAuthConstant.AllCheck.NO);
			} else if ("payconfirm".equals(mydoc)) { // 待我审的流程-付款确认
				GeesunBaseConfig config = new GeesunBaseConfig();
				if (StringUtil.isNotNull(config.getFdTemplateIds())) {
					String fdTemplateIds = config.getFdTemplateIds() + ";17775dcba9e95c14e8dd7f54e279c9eb";
					hql.append(" and kmReviewMain.fdTemplate.fdId in (:templateIds) ");
					List templateIdList = Arrays.asList(fdTemplateIds.split(";"));
					hqlInfo.setParameter("templateIds", templateIdList);
				}
				hql.append(" and kmReviewMain.fdId not in (select distinct(geesunBasePay.fdReview.fdId) from com.landray.kmss.geesun.base.model.GeesunBasePay geesunBasePay)");
//				List<String> hasPayReviewList = getHasPayReviewList();
//				if (!ArrayUtil.isEmpty(hasPayReviewList)) {
//					
//				}
//				SysFlowUtil.buildLimitBlockForMyApproval("kmReviewMain", hqlInfo);
				hqlInfo.setCheckParam(SysAuthConstant.CheckType.AllCheck, SysAuthConstant.AllCheck.NO);
			}
		}
		if (StringUtil.isNotNull(doctype)) {
			if ("examine".equals(doctype)) { // 流程审核
				if (StringUtil.isNotNull(docStatus)) {
					hql.append(" and kmReviewMain.docStatus =:docStatus");
					hqlInfo.setParameter("docStatus", docStatus);
				} else {
					hql.append(" and (kmReviewMain.docStatus = '20' or kmReviewMain.docStatus = '11')");
				}
			} else if ("follow".equals(doctype)) { // 流程跟踪
				StringBuffer buff = new StringBuffer();
				if (StringUtil.isNotNull(hqlInfo.getJoinBlock())) {
					buff.append(hqlInfo.getJoinBlock());
				}
				buff.append(", com.landray.kmss.sys.lbpmservice.support.model.LbpmFollow lbpmFollow ");
				hqlInfo.setJoinBlock(buff.toString());
				hql.append(" and lbpmFollow.fdProcessId = kmReviewMain.fdId and lbpmFollow.fdWatcher.fdId=:fdWatcher");
				hqlInfo.setParameter("fdWatcher", UserUtil.getUser().getFdId());
			} else if ("feedback".equals(doctype)) { // 流程反馈
				if (StringUtil.isNull(docStatus)) {
					hql.append(" and (kmReviewMain.docStatus = '30' or kmReviewMain.docStatus = '31')");
				} else {
					if ("41".equals(docStatus)) { // 未反馈
						hql.append(" and kmReviewMain.docStatus = '30'");
					}
				}
			}
		}
		if (StringUtil.isNull(categoryId)) {
			categoryId = request.getParameter("categoryId");
		}

		if (StringUtil.isNotNull(categoryId)) {
			// 默认 show all
			SysCategoryMain category = (SysCategoryMain) getCategoryServiceImp(
					request).findByPrimaryKey(categoryId, null, true);
			if (category != null) {
				hql
						.append(" and kmReviewMain.fdTemplate.docCategory.fdHierarchyId like :category");
				hqlInfo.setParameter("category", category.getFdHierarchyId()
						+ "%");
			} else {
				hql.append(" and kmReviewMain.fdTemplate.fdId = :template");
				hqlInfo.setParameter("template", categoryId);
			}
		}
		String[] docCreator = cv.polls("docCreator");
		if(docCreator!=null){
			if (docCreator.length > 1) {
				HQLWrapper hqlW = HQLUtil.buildPreparedLogicIN("kmReviewMain.docCreator.fdId","kmReviewMain"+ "0_", Arrays.asList(docCreator));
				hql.append( " and "+hqlW.getHql());
				hqlInfo.setParameter(hqlW.getParameterList());
			}else{
				hql.append(" and kmReviewMain.docCreator.fdId = :creator");
				hqlInfo.setParameter("creator", docCreator[0]);
			}
		}
		String docProperties = cv.poll("docProperties");
		if (StringUtil.isNotNull(docProperties)) {
			hql.append(" and kmReviewMain.docProperties.fdId = :docProperties");
			hqlInfo.setParameter("docProperties", docProperties);
		}
		CriteriaUtil.buildHql(cv, hqlInfo, KmReviewMain.class);
		if (StringUtil.isNotNull(hqlInfo.getWhereBlock())) {
			hql.append(" and (").append(hqlInfo.getWhereBlock());
		}
		//ai判断逻辑
		String ai = cv.poll("ai");
		if(StringUtil.isNotNull(ai)&&"true".equals(ai)){
			String docSubject = cv.poll("docSubject");
			if(StringUtil.isNotNull(docSubject)){
				if(docSubject.startsWith(";"))
					docSubject = docSubject.replaceFirst(";", "");
				if(docSubject.indexOf(";")>=0){
					String[] ds = docSubject.split("[,;]");
					StringBuffer aiw = new StringBuffer();
					for(int i=0;i<ds.length;i++){
						//if(StringUtil.isNotNull(ds[i])&&ds.length>1&&i<2){限制2个关键字
						if(StringUtil.isNotNull(ds[i])){
							if(i==0){
								aiw.append(" or (kmReviewMain.docSubject like '%"+ds[i]+"%' or kmReviewMain.fdTemplate.fdName like '%"+ds[i]+"%'");
							}else if(i==ds.length-1){
								aiw.append(" or kmReviewMain.docSubject like '%"+ds[i]+"%' or kmReviewMain.fdTemplate.fdName like '%"+ds[i]+"%'))");
							}else{
								aiw.append(" or kmReviewMain.docSubject like '%"+ds[i]+"%' or kmReviewMain.fdTemplate.fdName like '%"+ds[i]+"%'");
							}
						}
					}
					hql.append(aiw.toString());
				}else{
					hql.append(" or kmReviewMain.fdTemplate.fdName like :tname)");
					hqlInfo.setParameter("tname", "%"+docSubject.trim()+"%");
				}
			}
		}else{
			if (StringUtil.isNotNull(hqlInfo.getWhereBlock()))
				hql.append(")");
		}
		hqlInfo.setWhereBlock(hql.toString());
		//当前处理人
		String[] fdCurrentHandler = cv.polls("fdCurrentHandler");
		if(fdCurrentHandler!=null){
			LbpmUtil.buildLimitBlockForMyApproval("kmReviewMain", hqlInfo,
					getServiceImp(request).getOrgAndPost(request, fdCurrentHandler));
			hqlInfo.setAuthCheckType(null);
		}
		//已处理人
		String fdAlreadyHandler = cv.poll("fdAlreadyHandler");
		if(StringUtil.isNotNull(fdAlreadyHandler)){
			LbpmUtil.buildLimitBlockForMyApproved("kmReviewMain", hqlInfo,fdAlreadyHandler);
			hqlInfo.setAuthCheckType(null);
		}
		buildHomeZoneHql(cv, hqlInfo, request);
	}
	
	/**
	 * 获取已付款的记录
	 * @return
	 * @throws Exception
	 */
	private List<String> getHasPayReviewList() throws Exception {
		List<String> result = new ArrayList<String>();
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		String sql = "select distinct(fd_review_id) from geesun_base_pay";
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				result.add(rs.getString(1));
			}
		} catch (Exception ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(rs);
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
		return result;
	}

	
	private void buildHomeZoneHql(CriteriaValue cv, HQLInfo hqlInfo,
			HttpServletRequest request) throws Exception {
		String whereStr = hqlInfo.getWhereBlock();
		StringBuilder where = new StringBuilder(
				StringUtil.isNull(whereStr) ? "1=1 " : whereStr);
		String self = cv.poll("selfdoc");
		String tadoc = cv.poll("tadoc");
		boolean isSelfDoc = StringUtil.isNotNull(self);
		String mydoc = isSelfDoc ? self : tadoc;
		String userId = isSelfDoc ? UserUtil.getUser().getFdId() : request
				.getParameter("userid");

		if (StringUtil.isNull(userId) || StringUtil.isNull(mydoc)) {
			return;
		}

		if (StringUtil.isNotNull(mydoc)) {
			// 我启动的流程
			mydoc = mydoc.trim().toLowerCase();
			if ("create".equals(mydoc)) {
				where.append(" and kmReviewMain.docCreator.fdId=:docCreator");
				hqlInfo.setParameter("docCreator", userId);
				hqlInfo.setWhereBlock(where.toString());
			} else if ("approval".equals(mydoc)) {
				List<String> userIds = new ArrayList<String>();
				// #55126 修复 待办列表显示有，在“我的流程---待我审的”一栏中，却显示为空。
				if (isSelfDoc) {
					userIds = getRelationOrgIds(UserUtil.getUser());
				} else {
					SysOrgElement element = (SysOrgElement) getSysOrgElementService(
							request).findByPrimaryKey(userId);
					userIds = getRelationOrgIds(element);
					// userIds.add(userId);
				}
				LbpmUtil.buildLimitBlockForMyApproval("kmReviewMain", hqlInfo,userIds);
				hqlInfo.setAuthCheckType(null);
			} else if ("approved".equals(mydoc)) {
				LbpmUtil.buildLimitBlockForMyApproved("kmReviewMain", hqlInfo, userId);
				hqlInfo.setAuthCheckType(null);
			}
		}
	}

	/**
	 * @param person
	 * @return 当前用户ID和所属岗位ID
	 */
	@SuppressWarnings("unchecked")
	private List<String> getRelationOrgIds(SysOrgElement element) {
		List<String> results = new ArrayList<String>();
		results.add(element.getFdId());

		List<SysOrgElement> posts = element.getFdPosts();
		for (SysOrgElement post : posts) {
			results.add(post.getFdId());
		}
		return results;
	}

	public ActionForward showKeydataUsed(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-list", true, getClass());
		KmssMessages messages = new KmssMessages();

		String whereBlock = "";
		String keydataIdStr = "";
		String keydataId = request.getParameter("keydataId");
		if (StringUtil.isNotNull(keydataId)) {
			keydataIdStr = " and kmKeydataUsed.keydataId = :keydataId";
		}
		// 从kmKeydataUsed表中查找使用了‘keydataId’数据的对应主文档ID（这里指流程管理主文档ID），“kmReviewMainForm”指的是模块的form名称
		whereBlock += "kmReviewMain.fdId in (select kmKeydataUsed.modelId from com.landray.kmss.km.keydata.base.model.KmKeydataUsed kmKeydataUsed"
				+ " where kmKeydataUsed.formName='kmReviewMainForm'"
				+ keydataIdStr + ")";

		// 以下部分可直接参考list中的逻辑代码
		try {
			String s_pageno = request.getParameter("pageno");
			String s_rowsize = request.getParameter("rowsize");
			String orderby = request.getParameter("orderby");
			String ordertype = request.getParameter("ordertype");
			boolean isReserve = false;
			if (ordertype != null && ordertype.equalsIgnoreCase("down")) {
				isReserve = true;
			}
			int pageno = 0;
			int rowsize = SysConfigParameters.getRowSize();
			if (s_pageno != null && s_pageno.length() > 0) {
				pageno = Integer.parseInt(s_pageno);
			}
			if (s_rowsize != null && s_rowsize.length() > 0) {
				rowsize = Integer.parseInt(s_rowsize);
			}
			if (isReserve)
				orderby += " desc";
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setOrderBy(orderby);
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			changeFindPageHQLInfo(request, hqlInfo);
			String whereBlockOri = hqlInfo.getWhereBlock();
			if (StringUtil.isNotNull(whereBlockOri)) {
				whereBlock = whereBlockOri + " and (" + whereBlock + ")";
			}
			if (StringUtil.isNotNull(keydataId)) {
				hqlInfo.setParameter("keydataId", keydataId);
			}
			hqlInfo.setWhereBlock(whereBlock);
			Page page = getServiceImp(request).findPage(hqlInfo);
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-list", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("list", mapping, form, request, response);
		}
	}

	@Override
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String forwardStr = request.getParameter("forwardStr");
		TimeCounter.logCurrentTime("Action-list", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String s_pageno = request.getParameter("pageno");
			String s_rowsize = request.getParameter("rowsize");
			String s_pagingType = request.getParameter("pagingtype");
			String orderby = request.getParameter("orderby");
			String ordertype = request.getParameter("ordertype");
			String pagingSetting = request.getParameter("pagingSetting");
			boolean isReserve = false;
			if (ordertype != null && ordertype.equalsIgnoreCase("down")) {
				isReserve = true;
			}
			int pageno = 0;
			int rowsize = SysConfigParameters.getRowSize();
			if (s_pageno != null && s_pageno.length() > 0 && Integer.parseInt(s_pageno) > 0) {
				pageno = Integer.parseInt(s_pageno);
			}
			if (s_rowsize != null && s_rowsize.length() > 0 && Integer.parseInt(s_rowsize) > 0) {
				rowsize = Integer.parseInt(s_rowsize);
			}
			if (isReserve)
				orderby += " desc";
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setOrderBy(orderby);
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			changeFindPageHQLInfo(request, hqlInfo);
			if ("simple".equals(s_pagingType)
					|| ShowConfig.PAGING_SETTING_SIMPLE.equals(pagingSetting)) {
				hqlInfo.setPagingType(HQLInfo.PAGING_TYPE_SIMPLE);
			}
			Page page = getServiceImp(request).findPage(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(page.getList(),
					getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-list", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			if (StringUtil.isNotNull(forwardStr)) {
				return getActionForward(forwardStr, mapping, form, request, response);
			}else{
				return getActionForward("list", mapping, form, request, response);
			}
		}
		
	}

}
