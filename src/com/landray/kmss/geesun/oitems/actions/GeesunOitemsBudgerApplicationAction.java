package com.landray.kmss.geesun.oitems.actions;

import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.KmssRuntimeException;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.ICoreOuterService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsBudgerApplicationForm;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsShoppingTrolleyForm;
import com.landray.kmss.geesun.oitems.interfaces.Constants;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsBudgerApplicationService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsShoppingTrolleyService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsTempletService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.print.interfaces.ISysPrintLogCoreService;
import com.landray.kmss.sys.simplecategory.service.ISysSimpleCategoryService;
import com.landray.kmss.sys.workflow.interfaces.SysFlowUtil;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HtmlToMht;
import com.landray.kmss.util.KmssMessage;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟
 */
public class GeesunOitemsBudgerApplicationAction extends ExtendAction

{
	protected IGeesunOitemsBudgerApplicationService geesunOitemsBudgerApplicationService;

	protected IGeesunOitemsBudgerApplicationService getServiceImp(
			HttpServletRequest request) {
		if (geesunOitemsBudgerApplicationService == null)
			geesunOitemsBudgerApplicationService = (IGeesunOitemsBudgerApplicationService) getBean("geesunOitemsBudgerApplicationService");
		return geesunOitemsBudgerApplicationService;
	}

	private IGeesunOitemsTempletService geesunOitemsTempletService;

	public IGeesunOitemsTempletService getGeesunOitemsTempletService() {
		if (geesunOitemsTempletService == null) {
			geesunOitemsTempletService = (IGeesunOitemsTempletService) getBean("geesunOitemsTempletService");
		}
		return geesunOitemsTempletService;
	}

	private IGeesunOitemsShoppingTrolleyService geesunOitemsShoppingTrolleyService;

	public IGeesunOitemsShoppingTrolleyService getGeesunOitemsShoppingTrolleyService() {
		if (geesunOitemsShoppingTrolleyService == null) {
			geesunOitemsShoppingTrolleyService = (IGeesunOitemsShoppingTrolleyService) getBean("geesunOitemsShoppingTrolleyService");
		}
		return geesunOitemsShoppingTrolleyService;
	}

	private ICoreOuterService dispatchCoreService;

	protected ICoreOuterService getDispatchCoreService() {
		if (dispatchCoreService == null) {
			dispatchCoreService = (ICoreOuterService) getBean("dispatchCoreService");
		}
		return dispatchCoreService;
	}

	protected IGeesunOitemsListingService geesunOitemsListingService;

	public IGeesunOitemsListingService getGeesunOitemsListingService() {
		if (geesunOitemsListingService == null) {
			geesunOitemsListingService = (IGeesunOitemsListingService) getBean("geesunOitemsListingService");
		}
		return geesunOitemsListingService;
	}
	protected IGeesunOitemsWarehousingRecordService geesunOitemsWarehousingRecordService;

	public IGeesunOitemsWarehousingRecordService getGeesunOitemsWarehousingRecordService() {
		if (geesunOitemsWarehousingRecordService == null) {
			geesunOitemsWarehousingRecordService = (IGeesunOitemsWarehousingRecordService) getBean("geesunOitemsWarehousingRecordService");
		}
		return geesunOitemsWarehousingRecordService;
	}

	public ISysSimpleCategoryService getSysSimpleCategoryService() {
		return (ISysSimpleCategoryService) getGeesunOitemsTempletService();
	}

	// 打印日志
	protected ISysPrintLogCoreService sysPrintLogCoreService;

	public ISysPrintLogCoreService getSysPrintLogCoreService() {
		if (sysPrintLogCoreService == null)
			sysPrintLogCoreService = (ISysPrintLogCoreService) getBean(
					"sysPrintLogCoreService");
		return sysPrintLogCoreService;
	}

	protected String getParentProperty() {
		return "fdTemplate";
	}

	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdType = request.getParameter("type");
		HQLInfo hqlInfo = new HQLInfo();
		GeesunOitemsBudgerApplicationForm geesunOitemsBudgerApplicationForm = (GeesunOitemsBudgerApplicationForm) super
				.createNewForm(mapping, form, request, response);
		geesunOitemsBudgerApplicationForm.setDocCreatorId(UserUtil.getUser()
				.getFdId().toString());
		geesunOitemsBudgerApplicationForm.setDocCreatorName(UserUtil.getUser()
				.getFdName());

		geesunOitemsBudgerApplicationForm.setDocCreateTime(DateUtil
				.convertDateToString(new Date(), DateUtil.TYPE_DATETIME,
						request.getLocale()));

		//兼容个人流程中心跳转链接
		String fdTemplateId = request.getParameter("fdTemplateId");
		GeesunOitemsTemplet templet = (GeesunOitemsTemplet) getGeesunOitemsTempletService().findByPrimaryKey(fdTemplateId);
		if (StringUtil.isNull(fdType) && null != templet) {
			fdType = templet.getFdTempletType() == 1 ? "dept" : "person";
		}

		// 添加模板Form
		IExtendForm templetForm = null;

		if ("dept".equals(fdType)) {
			hqlInfo.setWhereBlock("geesunOitemsTemplet.fdTempletType="
					+ Constants.GEESUNOITEMS_TYPE_DEPT);
			if (UserUtil.getUser().getFdParent() != null) {
				geesunOitemsBudgerApplicationForm.setFdApplicantsId(UserUtil
						.getUser().getFdParent().getFdId());
				geesunOitemsBudgerApplicationForm.setFdApplicantsName(UserUtil
						.getUser().getFdParent().getDeptLevelNames());
			}
			geesunOitemsBudgerApplicationForm
					.setFdType(Constants.GEESUNOITEMS_TYPE_DEPT);
		} else {
				hqlInfo.setWhereBlock("geesunOitemsTemplet.fdTempletType="
						+ Constants.GEESUNOITEMS_TYPE_PERSON);
				geesunOitemsBudgerApplicationForm
						.setFdType(Constants.GEESUNOITEMS_TYPE_PERSON);
				geesunOitemsBudgerApplicationForm.setFdApplicantsId(UserUtil
						.getUser().getFdId());
				geesunOitemsBudgerApplicationForm.setFdApplicantsName(UserUtil
						.getUser().getFdName());

		}
		
		hqlInfo.setCheckParam(SysAuthConstant.CheckType.AllCheck,
				SysAuthConstant.AllCheck.DEFAULT);
		
		List<GeesunOitemsTemplet> geesunOitemsTempletList = getGeesunOitemsTempletService()
				.findList(hqlInfo);
		if (geesunOitemsTempletList.size() > 0) {
			GeesunOitemsTemplet geesunOitemsTemplet = (GeesunOitemsTemplet) geesunOitemsTempletList
					.get(0);
			geesunOitemsBudgerApplicationForm.setFdTemplateId(geesunOitemsTemplet
					.getFdId());
			geesunOitemsBudgerApplicationForm.setFdTemplateName(geesunOitemsTemplet
					.getFdName());
			geesunOitemsBudgerApplicationForm.setTitleRegulation(geesunOitemsTemplet.getTitleRegulation());
			getDispatchCoreService().initFormSetting(
					geesunOitemsBudgerApplicationForm, "geesunOitemsTemplet",
					geesunOitemsTemplet, "geesunOitemsTemplet",
					new RequestContext(request));
			templetForm = getGeesunOitemsTempletService().convertModelToForm(
					templetForm, geesunOitemsTemplet,
					new RequestContext(request));
			request.setAttribute(getFormName(templetForm, request),
					templetForm);

		}
		return geesunOitemsBudgerApplicationForm;
	}

	public ActionForward change(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-change", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			GeesunOitemsBudgerApplicationForm geesunOitemsBudgerApplicationForm = (GeesunOitemsBudgerApplicationForm) form;
			String fdTempletId = geesunOitemsBudgerApplicationForm.getFdTemplateId();
			if (StringUtil.isNotNull(fdTempletId)) {
				GeesunOitemsTemplet geesunOitemsTemplet = (GeesunOitemsTemplet) getGeesunOitemsTempletService()
						.findByPrimaryKey(fdTempletId);
				geesunOitemsBudgerApplicationForm.setFdTemplateId(geesunOitemsTemplet.getFdId());;
				geesunOitemsBudgerApplicationForm.setFdTemplateName(geesunOitemsTemplet
						.getFdName());
				geesunOitemsBudgerApplicationForm.setTitleRegulation(geesunOitemsTemplet.getTitleRegulation());
				//geesunOitemsBudgerApplicationForm.setDocSubject("");
				
				// 启动模板流程
				geesunOitemsBudgerApplicationForm.getSysWfBusinessForm()
						.setCanStartProcess("true");
				getDispatchCoreService().initFormSetting(
						geesunOitemsBudgerApplicationForm, "geesunOitemsTemplet",
						geesunOitemsTemplet, "geesunOitemsTemplet",
						new RequestContext(request));
			}
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("edit", mapping, form, request, response);
		}
	}
	
	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		String whereBlock=null;
		String docStatus = request.getParameter("docStatus");
		String fdType = request.getParameter("type");
		String myDoc = request.getParameter("myDoc");
		//String fdOutStatus = request.getParameter("outStatus");
		if (StringUtil.isNotNull(docStatus)) {
			whereBlock = StringUtil.linkString(getFindPageByStatus(request,hqlInfo),
					" and ", whereBlock);
		} else {
			StringUtil.linkString("geesunOitemsBudgerApplication.docStatus !='"+SysDocConstant.DOC_STATUS_DRAFT + "' ",
					" and ", whereBlock);
		}
		if (StringUtil.isNotNull(myDoc)) {
			whereBlock = StringUtil.linkString(" geesunOitemsBudgerApplication.docCreator.fdId=:creatorId "," and ", whereBlock);
			hqlInfo.setParameter("creatorId", UserUtil.getUser().getFdId());
		}
		//if (StringUtil.isNotNull(fdOutStatus)) {
		//	whereBlock = StringUtil.linkString("geesunOitemsBudgerApplication.fdOutStatus=:fdOutStatus ", " and ", whereBlock);
		//	hqlInfo.setParameter("fdOutStatus", fdOutStatus);
		//}
		if ("dept".equals(fdType)) {
			whereBlock = StringUtil.linkString("geesunOitemsBudgerApplication.fdType = '" + Constants.GEESUNOITEMS_TYPE_DEPT + "'", " and ", whereBlock);
		} else if ("person".equals(fdType)) {
			whereBlock = StringUtil.linkString("geesunOitemsBudgerApplication.fdType = '" + Constants.GEESUNOITEMS_TYPE_PERSON + "'", " and ", whereBlock);
		}
		hqlInfo.setOrderBy("geesunOitemsBudgerApplication.docCreateTime desc");
		hqlInfo.setWhereBlock(whereBlock);
		String type = request.getParameter("flowType");
		// 已审列表
		if ("executed".equals(type)) {
			SysFlowUtil.buildLimitBlockForMyApproved("geesunOitemsBudgerApplication", hqlInfo);
		}
		// 待审列表
		if ("unExecuted".equals(type)) {
			SysFlowUtil.buildLimitBlockForMyApproval("geesunOitemsBudgerApplication", hqlInfo);
		}
		CriteriaUtil.buildHql(new CriteriaValue(request), hqlInfo,
				GeesunOitemsBudgerApplication.class);
	}
	
	
	public ActionForward checkListing(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		String fdId = request.getParameter("fdId");
		String isMore = "true";
		String listNames = "";
		String docStatus = "";
		try {
			synchronized (this) {
				// 比较物品少，则返回报错
				GeesunOitemsBudgerApplication geesunOitemsBudgerApplication = (GeesunOitemsBudgerApplication) getServiceImp(request)
						.findByPrimaryKey(fdId);
				for (int i = 0; i < geesunOitemsBudgerApplication.getGeesunOitemsShoppingTrolleyList().size(); i++) {
					GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley) geesunOitemsBudgerApplication
							.getGeesunOitemsShoppingTrolleyList().get(i);
					if (geesunOitemsShoppingTrolley.getGeesunOitemsWarehousingRecordJoinList() != null) {
						if (null == geesunOitemsShoppingTrolley.getFdApplicationNumber()
								|| 0 == geesunOitemsShoppingTrolley.getFdApplicationNumber()) {
							continue;
						} else if (null == geesunOitemsShoppingTrolley.getGeesunOitemsWarehousingRecordJoinList()
								.getFdCurNumber()
								|| 0 == geesunOitemsShoppingTrolley.getGeesunOitemsWarehousingRecordJoinList()
										.getFdCurNumber()) {
							isMore = "false";
							listNames += "," + geesunOitemsShoppingTrolley.getFdName();
						} else {
							if (geesunOitemsShoppingTrolley.getFdApplicationNumber() > geesunOitemsShoppingTrolley
									.getGeesunOitemsWarehousingRecordJoinList().getFdCurNumber()) {
								isMore = "false";
								listNames += "," + geesunOitemsShoppingTrolley.getFdName();
							}
						}
					}
				}
				docStatus = geesunOitemsBudgerApplication.getDocStatus();
			}
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-save", false, getClass());
		JSONObject json = new JSONObject();
		json.put("isMore", isMore);
		if (StringUtil.isNotNull(listNames)) {
			json.put("names", listNames.substring(1));
		}
		json.put("docStatus", docStatus);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append(json.toString());
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}
	

	public ActionForward receive(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String fdId = request.getParameter("fdId");
			GeesunOitemsBudgerApplication geesunOitemsBudgerApplication = (GeesunOitemsBudgerApplication) getServiceImp(
					request).findByPrimaryKey(fdId);
			String docStatus = geesunOitemsBudgerApplication.getDocStatus();
			if (StringUtil.isNotNull(docStatus)
					&& docStatus.equals(SysDocConstant.DOC_STATUS_PUBLISH)) {
				// 更改物品发放状态
				geesunOitemsBudgerApplication.setDocStatus("31");
				// 更新物品领取时间
				geesunOitemsBudgerApplication.setFdOutTime(new Date());
				// 添加日志信息
				if (UserOperHelper.allowLogOper("receive",
						getServiceImp(request).getModelName())) {
					UserOperContentHelper.putUpdate(geesunOitemsBudgerApplication)
							.putSimple("docStatus",
									((GeesunOitemsBudgerApplicationForm) form)
											.getDocStatus(),
									"31")
							.putSimple("fdOutTime", null,
									geesunOitemsBudgerApplication.getFdOutTime());
				}
				getServiceImp(request).update(geesunOitemsBudgerApplication);
				synchronized (this) {
					// 修改库存量
					for (int i = 0; i < geesunOitemsBudgerApplication.getGeesunOitemsShoppingTrolleyList().size(); i++) {
						GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley) geesunOitemsBudgerApplication
								.getGeesunOitemsShoppingTrolleyList().get(i);
						GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = (GeesunOitemsWarehousingRecordJoinList) geesunOitemsShoppingTrolley
								.getGeesunOitemsWarehousingRecordJoinList();
						GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) geesunOitemsShoppingTrolley
								.getGeesunOitemsListing();
						if (geesunOitemsWarehousingRecordJoinList != null) {
							if (geesunOitemsListing.getFdAmount() < geesunOitemsShoppingTrolley.getFdApplicationNumber()) {
								throw new KmssRuntimeException(
										new KmssMessage("geesun-oitems:geesunOitemsShoppingTrolley.fdApplicationNumberRunout"));
							}
							geesunOitemsListing.setFdAmount(
									geesunOitemsListing.getFdAmount() - geesunOitemsShoppingTrolley.getFdApplicationNumber());

							geesunOitemsWarehousingRecordJoinList
									.setFdCurNumber(geesunOitemsWarehousingRecordJoinList.getFdCurNumber()
											- geesunOitemsShoppingTrolley.getFdApplicationNumber());
							getGeesunOitemsListingService().update(geesunOitemsListing);
							getGeesunOitemsWarehousingRecordService().update(geesunOitemsWarehousingRecordJoinList);
						}
					}
				}
			} else {
				throw new KmssRuntimeException(new KmssMessage(
						"geesun-oitems:geesunOitemsBudgerApplication.receive.checkStatus.tip"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_RETURN).save(request);
			return getActionForward("failure", mapping, form, request,
					response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("success", mapping, form, request,
					response);
		}
	}

	/**
	 * 审查用户密码
	 */
	public ActionForward checkedUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String password = request.getParameter("password");
		String fdId = request.getParameter("fdId");
		GeesunOitemsBudgerApplication geesunOitemsBudgerApplication = (GeesunOitemsBudgerApplication) getServiceImp(
				request).findByPrimaryKey(fdId);
		boolean isLive = false;
		boolean isMore = true;
		TimeCounter.logCurrentTime("Action-checkedUser", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (StringUtil.isNotNull(ResourceUtil
					.getKmssConfigString("kmss.authentication.providers"))) {
				String ldapURL = ResourceUtil
						.getKmssConfigString("kmss.ldap.url");
				isLive = userLogin(geesunOitemsBudgerApplication.getDocCreator()
						.getFdLoginName(), password, ldapURL + ":389");
			} else {
				if (geesunOitemsBudgerApplication.getDocCreator().getFdPassword()
						.equals(md5s(password))) {
					isLive = true;
				}
			}
			// //比较物品少，则返回报错
			// for(int
			// i=0;i<geesunOitemsBudgerApplication.getGeesunOitemsBudgerListingList().size();i++){
			// GeesunOitemsBudgerListing geesunOitemsBudgerListing =
			// (GeesunOitemsBudgerListing)geesunOitemsBudgerApplication.getGeesunOitemsBudgerListingList().get(0);
			// if(null!=geesunOitemsBudgerListing.getFdApplicationNumber()){
			// if(null==geesunOitemsBudgerListing.getGeesunOitemsListing().getFdAmount()&&geesunOitemsBudgerListing.getFdApplicationNumber()>0){
			// isMore = false ;
			// }else{
			// if(geesunOitemsBudgerListing.getFdApplicationNumber()>geesunOitemsBudgerListing.getGeesunOitemsListing().getFdAmount()){
			// isMore = false ;
			// }
			// }
			// }
			// }

		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-checkedUser", false, getClass());
		if (!isLive) {
			KmssMessage error = new KmssMessage(
					"geesun-oitems:geesunOitemsGetApplication.password.error");
			messages.addError(error);
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		}
		if (!isMore) {
			KmssMessage error = new KmssMessage(
					"geesun-oitems:geesunOitemsGetApplication.goods.less");
			messages.addError(error);
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		}
		if (isLive && isMore) {
			// 更改物品发放状态
			geesunOitemsBudgerApplication.setDocStatus("31");
			getServiceImp(request).update(geesunOitemsBudgerApplication);
			// 修改库存量
			// for(int
			// i=0;i<geesunOitemsBudgerApplication.getGeesunOitemsBudgerListingList().size();i++){
			// GeesunOitemsBudgerListing geesunOitemsBudgerListing =
			// (GeesunOitemsBudgerListing)geesunOitemsBudgerApplication.getGeesunOitemsBudgerListingList().get(0);
			// GeesunOitemsListing geesunOitemsListing =
			// (GeesunOitemsListing)geesunOitemsBudgerListing.getGeesunOitemsListing();
			// geesunOitemsListing.setFdAmount(geesunOitemsListing.getFdAmount()-geesunOitemsBudgerListing.getFdApplicationNumber());
			// getGeesunOitemsListingService().update(geesunOitemsListing);
			// }
			// KmssReturnPage.getInstance(request).addMessages(messages)
			// .addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("success", mapping, form, request, response);
		}
		return null;
	}

	// AD中判断是否存在
	public static boolean userLogin(String adminName, String adminPassword,
			String ldapURL) { // 新建用户验证。
		try {
			Properties env = new Properties();
			env.put(Context.INITIAL_CONTEXT_FACTORY,
					"com.sun.jndi.ldap.LdapCtxFactory");
			// set security credentials, note using simple cleartext
			// authentication
			env.put(Context.SECURITY_AUTHENTICATION, "simple");
			env.put(Context.SECURITY_PRINCIPAL, adminName);
			env.put(Context.SECURITY_CREDENTIALS, adminPassword);
			// connect to my domain controller
			env.put(Context.PROVIDER_URL, ldapURL);
			InitialContext iCnt = new InitialContext(env);
			return true;
		} catch (Exception e) {
			// e.printStackTrace();
			return false;
		}
	}

	// 数据库验证，md5验证
	public String md5s(String plainText) throws Exception {
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(plainText.getBytes());
		byte b[] = md.digest();
		int i;
		StringBuffer buf = new StringBuffer("");
		for (int offset = 0; offset < b.length; offset++) {
			i = b[offset];
			if (i < 0)
				i += 256;
			if (i < 16)
				buf.append("0");
			buf.append(Integer.toHexString(i));
		}
		return buf.toString();
	}

	/**
	 * 部门预算统计
	 */
	public ActionForward count(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		String fdDeptId = request.getParameter("fdDeptId");
		String fdDeptName = request.getParameter("fdDeptName");
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		request.setAttribute("fdDeptId", fdDeptId);
		request.setAttribute("fdDeptName", fdDeptName);
		// 查询部门预算用品
		// Map geesunOitemsListingMap = getServiceImp(request).count(request);

		// request.setAttribute("geesunOitemsListingMap", geesunOitemsListingMap);
		return getActionForward("count", mapping, form, request, response);
	}

	/*
	 * 部门预算统计导出
	 */
	public void deptExport(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 查询部门预算用品
		// Map geesunOitemsListingMap = getServiceImp(request).count(request);
		SimpleDateFormat format = new SimpleDateFormat(ResourceUtil
				.getString("date.format.date"));
		String title = ResourceUtil.getString(
				"geesunOitemsBudgerApplication.count", "geesun-oitems")
				+ format.format(new Date());
		// getServiceImp(request).export(response, geesunOitemsListingMap, title);
	}
 
	private String getFindPageByOutStatus(HttpServletRequest request,
			String fdOutStatus) {
		String whereBlock = null;
		whereBlock = " geesunOitemsBudgerApplication.fdOutStatus='" + fdOutStatus
				+ "' ";
		return whereBlock;
	}

	protected String getFindPageByStatus(HttpServletRequest request,HQLInfo hqlInfo)
			throws Exception {
		String whereBlock = null;
		String docStatus = request.getParameter("docStatus");
		whereBlock = " geesunOitemsBudgerApplication.docStatus=:docStatus ";
		if ("draft".equals(docStatus)) {
			hqlInfo.setParameter("docStatus", "10");
		}
		if ("wait".equals(docStatus)) {
			hqlInfo.setParameter("docStatus", "20");
		}
		if ("publish".equals(docStatus)) {
			hqlInfo.setParameter("docStatus", "30");
		}
		if ("discard".equals(docStatus)) {
			hqlInfo.setParameter("docStatus", "00");
		}
		if ("refuse".equals(docStatus)) {
			hqlInfo.setParameter("docStatus", "11");
		}
 
		return whereBlock;
	}

	public ActionForward listForReceive(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setAttribute("isReceive", "1");
		return super.list(mapping, form, request, response);
	}

	public ActionForward draftDelete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return super.deleteall(mapping, form, request, response);
	}

	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if (StringUtil.isNull(curOrderBy)) {
			curOrderBy = "geesunOitemsBudgerApplication.docCreateTime desc";
		}
		return curOrderBy;
	}

	/****
	 * 重写载入action
	 */
	@Override
	protected void loadActionForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		form.reset(mapping, request);
		IExtendForm rtnForm = null;
		IExtendForm templetForm = null;
		String id = request.getParameter("fdId");
		if (!StringUtil.isNull(id)) {
			GeesunOitemsBudgerApplication model = (GeesunOitemsBudgerApplication) getServiceImp(
					request).findByPrimaryKey(id, null, true);
			if (model.getFdTotalAmount() == null) {
                Double d = 0.0;
				List l = model.getGeesunOitemsShoppingTrolleyList();
				for (int i = 0; i < l.size(); i++) {
					GeesunOitemsShoppingTrolley k = (GeesunOitemsShoppingTrolley) l
							.get(i);
					d += k.getFdReferencePrice() * k.getFdApplicationNumber();
				}
				model.setFdTotalAmount(d);
				getServiceImp(request).update(model);
			}
			if (model != null) {
				UserOperHelper.logFind(model);// 添加日志信息
				//设置模型和模板的Form
				rtnForm = getServiceImp(request).convertModelToForm(
						(IExtendForm) form, model, new RequestContext(request));
				GeesunOitemsBudgerApplicationForm geesunOitemsBudgerApplicationForm = ((GeesunOitemsBudgerApplicationForm) rtnForm);
				List list = geesunOitemsBudgerApplicationForm
						.getGeesunOitemsShoppingTrolleyFormList();
				if (list.size() > 1) {
					Collections.sort(list, new Comparator() {
						@Override
						public int compare(Object arg0, Object arg1) {
							// TODO 自动生成的方法存根
							String value1 = ((GeesunOitemsShoppingTrolleyForm) arg0)
									.getFdNo();
							String value2 = ((GeesunOitemsShoppingTrolleyForm) arg1)
									.getFdNo();
							value1 = value1 == null ? "" : value1;
							value2 = value2 == null ? "" : value2;
							return value1.compareToIgnoreCase(value2);
						}
					});
				}
				templetForm = getGeesunOitemsTempletService().convertModelToForm(
						templetForm, model.getFdTemplate(),
						new RequestContext(request));
			}

		}
		if (rtnForm == null)
			throw new NoRecordException();
		request.setAttribute(getFormName(rtnForm, request), rtnForm);
		request.setAttribute(getFormName(templetForm, request), templetForm);
	}

	
	protected ISysOrgCoreService sysOrgCoreService;

	protected ISysOrgCoreService getSysOrgServiceImp(
			HttpServletRequest request) {
		if (sysOrgCoreService == null)
			sysOrgCoreService = (ISysOrgCoreService) getBean("sysOrgCoreService");
		return sysOrgCoreService;
	}
	 
	
	public ActionForward getApplicantDept(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		String fdApplicantsId = request.getParameter("fdApplicantsId");
		String deptId = "";
		String deptName = "";
		try {
			if (StringUtil.isNotNull(fdApplicantsId)) {
				SysOrgElement sysOrgElement = getSysOrgServiceImp(request).findByPrimaryKey(fdApplicantsId);
				if(sysOrgElement.getFdParent()!=null){
					deptId = sysOrgElement.getFdParent().getFdId();
					deptName = sysOrgElement.getFdParent().getFdName();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-save", false, getClass());
		JSONObject json = new JSONObject();
		json.put("deptId", deptId);
		json.put("deptName", deptName);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append(json.toString());
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}
	
	/**
	 * 打印
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-print", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			HtmlToMht.setLocaleWhenExport(request);
			loadActionForm(mapping, form, request, response);
			String fdId = request.getParameter("fdId");
			GeesunOitemsBudgerApplication model = (GeesunOitemsBudgerApplication) getServiceImp(
					request).findByPrimaryKey(fdId);
			// 记录打印日志
			getSysPrintLogCoreService().addPrintLog(model,
					new RequestContext(request));
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-print", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("print", mapping, form, request, response);
		}
	}
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			GeesunOitemsBudgerApplicationForm geesunOitemsBudgerApplicationForm = (GeesunOitemsBudgerApplicationForm) form;
			List<GeesunOitemsShoppingTrolleyForm> formList = geesunOitemsBudgerApplicationForm
					.getGeesunOitemsShoppingTrolleyFormList();
			List<GeesunOitemsShoppingTrolleyForm> willRemoveList = new ArrayList<GeesunOitemsShoppingTrolleyForm>();
			for (GeesunOitemsShoppingTrolleyForm geesunOitemsShoppingTrolleyForm : formList) {
				if (StringUtil.isNull(geesunOitemsShoppingTrolleyForm.getFdApplicationId())
						|| StringUtil.isNull(geesunOitemsShoppingTrolleyForm.getKmApplicationId())) {
					willRemoveList.add(geesunOitemsShoppingTrolleyForm);
				}
			}
			formList.removeAll(willRemoveList);
			getServiceImp(request).update((IExtendForm) form,
					new RequestContext(request));
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(
					request);
			return getActionForward("edit", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("success", mapping, form, request, response);
		}
	}
	
	@Override
	public ActionForward save(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			GeesunOitemsBudgerApplicationForm geesunOitemsBudgerApplicationForm = (GeesunOitemsBudgerApplicationForm) form;
			List<GeesunOitemsShoppingTrolleyForm> formList = geesunOitemsBudgerApplicationForm
					.getGeesunOitemsShoppingTrolleyFormList();
			List<GeesunOitemsShoppingTrolleyForm> willRemoveList = new ArrayList<GeesunOitemsShoppingTrolleyForm>();
			for (GeesunOitemsShoppingTrolleyForm geesunOitemsShoppingTrolleyForm : formList) {
				if (StringUtil.isNull(geesunOitemsShoppingTrolleyForm.getFdApplicationId())
						|| StringUtil.isNull(geesunOitemsShoppingTrolleyForm.getKmApplicationId())) {
					willRemoveList.add(geesunOitemsShoppingTrolleyForm);
				}
			}
			formList.removeAll(willRemoveList);
			getServiceImp(request).add((IExtendForm) form,
					new RequestContext(request));
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(request);
			return getActionForward("edit", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("success", mapping, form, request, response);
		}
	}
	
	public ActionForward add4m(ActionMapping mapping, ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-add", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			ActionForm newForm = createNewForm(mapping, form, request,
					response);
			if (newForm != form)
				request.setAttribute(getFormName(newForm, request), newForm);
			GeesunOitemsBudgerApplicationForm geesunOitemsBudgerApplicationForm = (GeesunOitemsBudgerApplicationForm) form;
			String fdTemplateId = request.getParameter("fdTemplateId");
			if (StringUtil.isNotNull(fdTemplateId)) {
				geesunOitemsBudgerApplicationForm.setFdTemplateId(fdTemplateId);
				GeesunOitemsTemplet geesunOitemsTemplet = (GeesunOitemsTemplet) getGeesunOitemsTempletService()
						.findByPrimaryKey(fdTemplateId);
				geesunOitemsBudgerApplicationForm
						.setFdTemplateId(geesunOitemsTemplet.getFdId());
				;
				geesunOitemsBudgerApplicationForm.setFdTemplateName(geesunOitemsTemplet
						.getFdName());
				geesunOitemsBudgerApplicationForm.setTitleRegulation(
						geesunOitemsTemplet.getTitleRegulation());
				// geesunOitemsBudgerApplicationForm.setDocSubject("");

				geesunOitemsBudgerApplicationForm.setMethod_GET("add");
				// 启动模板流程
				geesunOitemsBudgerApplicationForm.getSysWfBusinessForm()
						.setCanStartProcess("true");
				getDispatchCoreService().initFormSetting(
						geesunOitemsBudgerApplicationForm, "geesunOitemsTemplet",
						geesunOitemsTemplet, "geesunOitemsTemplet",
						new RequestContext(request));
			}
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-add", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request,
					response);
		} else {
			return getActionForward("edit", mapping, form, request, response);
		}
	}

}
