package com.landray.kmss.km.review.service.spring;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.util.ClassUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Node;

import com.alibaba.fastjson.JSON;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.KmssRuntimeException;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.constant.SysNotifyConstant;
import com.landray.kmss.framework.util.PluginConfigLocationsUtil;
import com.landray.kmss.geesun.base.service.IGeesunBasePayService;
import com.landray.kmss.km.archives.interfaces.IAutoFileDataService;
import com.landray.kmss.km.archives.interfaces.IFileDataService;
import com.landray.kmss.km.archives.model.KmArchivesFileTemplate;
import com.landray.kmss.km.archives.model.KmArchivesMain;
import com.landray.kmss.km.archives.service.IKmArchivesFileTemplateService;
import com.landray.kmss.km.archives.service.IKmArchivesSignService;
import com.landray.kmss.km.archives.util.KmArchivesUtil;
import com.landray.kmss.km.review.Constant;
import com.landray.kmss.km.review.dao.IKmReviewMainDao;
import com.landray.kmss.km.review.forms.KmReviewMainForm;
import com.landray.kmss.km.review.model.KmReviewConfigNotify;
import com.landray.kmss.km.review.model.KmReviewDocKeyword;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.model.KmReviewSnContext;
import com.landray.kmss.km.review.model.KmReviewTemplate;
import com.landray.kmss.km.review.model.KmReviewTemplateKeyword;
import com.landray.kmss.km.review.service.IKmReviewGenerateSnService;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.km.review.service.IKmReviewOutSignService;
import com.landray.kmss.km.review.service.IKmReviewTemplateService;
import com.landray.kmss.km.review.util.KmReviewTitleUtil;
import com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge;
import com.landray.kmss.kms.multidoc.model.KmsMultidocSubside;
import com.landray.kmss.kms.multidoc.service.IKmsMultidocSubsideService;
import com.landray.kmss.sys.agenda.interfaces.ISysAgendaMainCoreService;
import com.landray.kmss.sys.agenda.interfaces.ISysAgendaMainForm;
import com.landray.kmss.sys.agenda.interfaces.SysAgendaMainContextFormula;
import com.landray.kmss.sys.agenda.util.SysAgendaTypeEnum;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.SysAttMain;
import com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService;
import com.landray.kmss.sys.cache.KmssCache;
import com.landray.kmss.sys.category.interfaces.CategoryUtil;
import com.landray.kmss.sys.category.service.ISysCategoryMainService;
import com.landray.kmss.sys.filestore.model.SysFileConvertClient;
import com.landray.kmss.sys.filestore.service.ISysFileConvertClientService;
import com.landray.kmss.sys.lbpm.engine.formula.LbpmFunction;
import com.landray.kmss.sys.lbpm.engine.integrate.rules.IRuleProvider;
import com.landray.kmss.sys.lbpm.engine.integrate.rules.RuleFact;
import com.landray.kmss.sys.lbpm.engine.manager.NoExecutionEnvironment;
import com.landray.kmss.sys.lbpm.engine.manager.ProcessServiceManager;
import com.landray.kmss.sys.lbpm.engine.persistence.AccessManager;
import com.landray.kmss.sys.lbpm.engine.persistence.model.LbpmNodeDefinition;
import com.landray.kmss.sys.lbpm.engine.persistence.model.LbpmNodeDefinitionHandler;
import com.landray.kmss.sys.lbpm.engine.service.ProcessExecuteService;
import com.landray.kmss.sys.lbpm.engine.service.ProcessInstanceInfo;
import com.landray.kmss.sys.lbpm.engine.support.def.XMLUtils;
import com.landray.kmss.sys.lbpmservice.interfaces.LbpmUtil;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.notify.interfaces.NotifyContext;
import com.landray.kmss.sys.notify.interfaces.NotifyReplace;
import com.landray.kmss.sys.number.interfaces.ISysNumberFlowService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.portal.cloud.dto.IconDataVO;
import com.landray.kmss.sys.portal.cloud.util.ListDataUtil;
import com.landray.kmss.sys.portal.util.PortletTimeUtil;
import com.landray.kmss.sys.workflow.interfaces.Event_SysFlowDiscard;
import com.landray.kmss.sys.workflow.interfaces.Event_SysFlowFinish;
import com.landray.kmss.sys.workflow.interfaces.SysFlowUtil;
import com.landray.kmss.sys.xform.interfaces.XFormUtil;
import com.landray.kmss.util.AutoArrayList;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.FileMimeTypeUtil;
import com.landray.kmss.util.HtmlHandler;
import com.landray.kmss.util.HtmlToMht;
import com.landray.kmss.util.KmssMessage;
import com.landray.kmss.util.MD5Util;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.sunbor.web.tag.Page;

/**
 * 创建日期 2007-Aug-30
 * 
 * @author 舒斌 审批文档基本信息业务接口实现
 */
@SuppressWarnings("unchecked")
public class KmReviewMainServiceImp extends ExtendDataServiceImp implements
		IKmReviewMainService, ApplicationListener, IFileDataService,IAutoFileDataService,
		com.landray.kmss.kms.multidoc.interfaces.IFileDataService {

	private static final Log logger = LogFactory.getLog(KmReviewMainServiceImp.class);
	
	public ISysAttMainCoreInnerService sysAttMainService;
	
	public IKmReviewTemplateService kmReviewTemplateService;

	public ISysNotifyMainCoreService sysNotifyMainCoreService;

	public ISysCategoryMainService sysCategoryMainService;

	private IKmReviewGenerateSnService kmReviewGenerateSnService;
	
	private IKmArchivesFileTemplateService kmArchivesFileTemplateService;

	private IKmsMultidocSubsideService kmsMultidocSubsideService;

	public void setKmsMultidocSubsideService(
			IKmsMultidocSubsideService kmsMultidocSubsideService) {
		this.kmsMultidocSubsideService = kmsMultidocSubsideService;
	}

	public void setKmArchivesFileTemplateService(
			IKmArchivesFileTemplateService kmArchivesFileTemplateService) {
		this.kmArchivesFileTemplateService = kmArchivesFileTemplateService;
	}
	public void setSysAttMainService(ISysAttMainCoreInnerService sysAttMainService) {
		this.sysAttMainService = sysAttMainService;
	}

	public void setKmReviewGenerateSnService(
			IKmReviewGenerateSnService kmReviewGenerateSnService) {
		this.kmReviewGenerateSnService = kmReviewGenerateSnService;
	}


	protected ISysOrgElementService getSysOrgElementService() {
		return (ISysOrgElementService) SpringBeanUtil.getBean("sysOrgElementService");
	}
	
	private IKmReviewOutSignService kmReviewOutSignService = null;

	public IKmReviewOutSignService getKmReviewOutSignService() {
		if (kmReviewOutSignService == null) {
			kmReviewOutSignService = (IKmReviewOutSignService) SpringBeanUtil
					.getBean("kmReviewOutSignService");
		}
		return kmReviewOutSignService;
	}
	
	private IGeesunBasePayService geesunBasePayService = null;

	public IGeesunBasePayService getGeesunBasePayService() {
		if (geesunBasePayService == null) {
			geesunBasePayService = (IGeesunBasePayService) SpringBeanUtil
					.getBean("geesunBasePayService");
		}
		return geesunBasePayService;
	}
	
	/**
	 * 
	 * @param orgId
	 * @return
	 * @throws Exception
	 */
	public List getOrgAndPost(HttpServletRequest request, String[] orgIds) throws Exception {
		List<String> orgIdList = new ArrayList<String>();
		for (String orgId : orgIds) {
			orgIdList.add(orgId);
		}

		List<String> postList = new ArrayList<String>();
		for (String orgId : orgIds) {
			SysOrgElement org = (SysOrgElement) getSysOrgElementService().findByPrimaryKey(orgId);
			List<SysOrgElement> posts = org.getFdPosts();
			for (SysOrgElement post : posts) {
				if (!postList.contains(orgId)) {
					postList.add(post.getFdId());
				}
			}

		}
		for (String post : postList) {
			orgIdList.add(post);
		}
		return orgIdList;
	}

	private ISysNumberFlowService sysNumberFlowService;

	public void setSysNumberFlowService(
			ISysNumberFlowService sysNumberFlowService) {
		this.sysNumberFlowService = sysNumberFlowService;
	}

	/**
	 * 修改流程文档权限
	 * 
	 * @param documentId
	 *            文档ID
	 * @param form
	 * @throws Exception
	 */
	public void updateDocumentPermission(IExtendForm form,
			RequestContext requestContext) throws Exception {
		IBaseModel model = convertFormToModel(form, null, requestContext);
		if (model == null)
			throw new NoRecordException();
		this.update(model);

	}

	/**
	 * 转移流程文档
	 * 
	 * @param fdId
	 *            文档ID
	 * @param categoryId
	 *            目标模板ID
	 * @throws Exception
	 */
	public void updateDocumentCategory(String fdId, String templateId)
			throws Exception {
		KmReviewMain main = (KmReviewMain) findByPrimaryKey(fdId);
		KmReviewTemplate template = (KmReviewTemplate) kmReviewTemplateService
				.findByPrimaryKey(templateId);
		main.setFdTemplate(template);
		update(main);
	}

	/**
	 * 新建流程文档
	 */
	@Override
	public String add(IExtendForm form, RequestContext requestContext)
			throws Exception {
		KmReviewMainForm main = (KmReviewMainForm) form;
		if (!Constant.STATUS_DRAFT.equals(main.getDocStatus())) {
			// 修改为调用新服务取得流水编号 modify by limh 2010年11月5日
			// main.setFdNumber(generateFlowNumber(main.getFdTemplateId(),
			// null));

			String fdNumber = "";
			if (com.landray.kmss.sys.number.util.NumberResourceUtil
					.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")) {
				IBaseModel model = initModelSetting(requestContext);
				model = convertFormToModel(main, model, requestContext);
				fdNumber = sysNumberFlowService.generateFlowNumber(model);
			} else {
				KmReviewSnContext context = new KmReviewSnContext();
				String templateId = main.getFdTemplateId();
				KmReviewTemplate template = (KmReviewTemplate) kmReviewTemplateService
						.findByPrimaryKey(templateId);
				context.setFdPrefix(template.getFdNumberPrefix());
				context.setFdModelName(KmReviewMain.class.getName());
				context.setFdTemplate(template);
				synchronized (this) {
					fdNumber = kmReviewGenerateSnService
							.getSerialNumber(context);
				}
			}

			main.setFdNumber(fdNumber);
		}
		// 解决子流程模板设置日程同步，启动子流程时选择跳过起草节点，无法同步到日程
		if (main instanceof ISysAgendaMainForm
				&& StringUtil.isNull(main.getSyncDataToCalendarTime())) {
			String templateId = main.getFdTemplateId();
			KmReviewTemplate template = (KmReviewTemplate) kmReviewTemplateService
					.findByPrimaryKey(templateId);
			main.setSyncDataToCalendarTime(
					template.getSyncDataToCalendarTime());
		}
		String fdId = super.add(form, requestContext);
		return fdId;
	}

	@Override
	public String add(IBaseModel modelObj) throws Exception {
		KmReviewMain mainModel = (KmReviewMain) modelObj;
		mainModel.setTitleRegulation(mainModel.getFdTemplate().getTitleRegulation());
		// 根据标题规则生成标题
		KmReviewTitleUtil.genTitle(modelObj);
		String fdId = super.add(modelObj);
		if ("flowSubmitAfter".equals(mainModel.getSyncDataToCalendarTime())) {
			// 日程机制新增同步(针对表单公式定义器模块)
			updateSyncDataToCalendarFormula(mainModel);
		}
		return fdId;
	}
	
	
	@Override
	public void update(IBaseModel modelObj) throws Exception {
		KmReviewMain main = (KmReviewMain) modelObj;
		if (!Constant.STATUS_DRAFT.equals(main.getDocStatus())
				&& StringUtil.isNull(main.getFdNumber())) {
			// 修改为调用新服务取得流水编号 modify by limh 2010年11月5日
			// main.setFdNumber(generateFlowNumber(null, main.getFdTemplate()));
			String fdNumber = "";
			if (com.landray.kmss.sys.number.util.NumberResourceUtil
					.isModuleNumberEnable("com.landray.kmss.km.review.model.KmReviewMain")) {
				fdNumber = sysNumberFlowService.generateFlowNumber(main);
			} else {
				KmReviewSnContext context = new KmReviewSnContext();
				KmReviewTemplate template = main.getFdTemplate();
				context.setFdPrefix(template.getFdNumberPrefix());
				context.setFdModelName(KmReviewMain.class.getName());
				context.setFdTemplate(template);
				synchronized (this) {
					fdNumber = kmReviewGenerateSnService
							.getSerialNumber(context);
				}
			}
			main.setFdNumber(fdNumber);
		}
		// 根据标题规则生成标题
		KmReviewTitleUtil.genTitle(modelObj);

		super.update(modelObj);
		if ("flowSubmitAfter".equals(main.getSyncDataToCalendarTime())) {
			// 日程机制新增同步(针对表单公式定义器模块)
			updateSyncDataToCalendarFormula(main);
		} else {
			// 修改了同步时机,删除日程
			deleteSyncDataToCalendarFormula(main);
		}
	}

	@Override
	public void delete(IBaseModel modelObj) throws Exception {
		final String fdId = modelObj.getFdId();
		KmReviewMain main = (KmReviewMain) modelObj;
		// 删除流程时删除日程
		if ("flowSubmitAfter".equals(main.getSyncDataToCalendarTime())
				|| "flowPublishAfter".equals(main.getSyncDataToCalendarTime())) {
			deleteSyncDataToCalendarFormula(main);
		}

		// 更新钉钉套件的实例状态
		dealwithDingSuiteInstance(main.getFdId());

		this.getBaseDao().getHibernateTemplate().execute(
				new HibernateCallback() {

					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// TODO Auto-generated method stub
						StringBuilder sb = new StringBuilder();
						sb
								.append("delete KmReviewFeedbackInfo kmReviewFeedbackInfo where kmReviewFeedbackInfo.kmReviewMain.fdId='");
						sb.append(fdId);
						sb.append("'");

						return session.createQuery(sb.toString())
								.executeUpdate();
					}

				});
		// 删除付款信息
		getBaseDao().getHibernateSession().createSQLQuery(
				"delete from geesun_base_pay where fd_review_id = ?")
				.setString(0, modelObj.getFdId()).executeUpdate();
		Integer signCount = getKmReviewOutSignService()
				.findBySignId(modelObj.getFdId());
		if (signCount > 0) {
			// 删除易企签署信息
			getBaseDao().getHibernateSession().createSQLQuery(
					"delete from km_review_out_sign where fd_main_id = ?")
					.setString(0, modelObj.getFdId()).executeUpdate();
		}
		super.delete(modelObj);
	}

	private void dealwithDingSuiteInstance(String fdId) {
		try {
			if (new File(PluginConfigLocationsUtil.getKmssConfigPath()
					+ "/third/ding/").exists()) {
				Object dingUtil = Class
						.forName("com.landray.kmss.third.ding.util.DingUtil")
						.newInstance();
				Class dingUtilClazz = dingUtil.getClass();
				Method deleteReviewMain = dingUtilClazz
						.getMethod("deleteReviewMain", String.class);
				deleteReviewMain.invoke(dingUtil, fdId);
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
	}

	public int updateDucmentTemplate(String ids, String templateId)
			throws Exception {
		if(UserOperHelper.allowLogOper("changeTemplate", getModelName())){
			 String[] idArr = ids.split(",");
			 for (int i = 0; i < idArr.length; i++) {
				 KmReviewMain main = (KmReviewMain) findByPrimaryKey(idArr[i]);
				 UserOperContentHelper.putUpdate(main.getFdId(),main.getDocSubject(),getModelName()).putSimple("fdTemplateId", main.getFdTemplate().getFdId(), templateId);
			 } 
		}
		return ((IKmReviewMainDao) this.getBaseDao()).updateDocumentTemplate(
				ids, templateId);
	}

	public void onApplicationEvent(ApplicationEvent event) {
		if (event == null)
			return;
		Object obj = event.getSource();
		if (!(obj instanceof KmReviewMain))
			return;
		if (event instanceof Event_SysFlowFinish) {
			KmReviewMain main = (KmReviewMain) obj;
			main.setDocPublishTime(new Date());
			try {
				// getBaseDao().update(main);
				// 为支持bam2修改的代码块 begin 2013-08-22
				this.update(main);
				// 为支持bam2修改的代码块 end 2013-08-22
				List feedbackList = main.getFdFeedback();
				if (feedbackList.size() > 0) {
					KmReviewConfigNotify configNotify = new KmReviewConfigNotify();
					configNotify.getFdNotifyType();
					if (StringUtil.isNull(configNotify.getFdNotifyType()))
						return;
					// HashMap map = new HashMap();
					// map.put("km-review:kmReviewMain.docSubject", main
					// .getDocSubject());
					NotifyReplace notifyReplace = new NotifyReplace();
					notifyReplace.addReplaceText(
							"km-review:kmReviewMain.docSubject", main
							.getDocSubject());
					NotifyContext notifyContext = sysNotifyMainCoreService
							.getContext("km-review:kmReview.feedback.notify");
					notifyContext.setKey("passreadKey");
					notifyContext
							.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
					notifyContext.setNotifyTarget(feedbackList);
					notifyContext.setNotifyType(configNotify.getFdNotifyType());
					sysNotifyMainCoreService.sendNotify(main, notifyContext,
							notifyReplace);

				}
				if ("flowPublishAfter".equals(main.getSyncDataToCalendarTime())) {
					// 日程机制新增同步(针对表单公式定义器模块)
					updateSyncDataToCalendarFormula(main);
				}
			} catch (Exception e) {
				throw new KmssRuntimeException(e);
			}

		} else if (event instanceof Event_SysFlowDiscard) {
			KmReviewMain main = (KmReviewMain) obj;
			main.setDocPublishTime(new Date());
			try {
				this.update(main);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				throw new KmssRuntimeException(e1);
			}
			// 废弃时删除日程
			if ("flowSubmitAfter".equals(main.getSyncDataToCalendarTime())) {
				try {
					deleteSyncDataToCalendarFormula(main);
				} catch (Exception e) {
					throw new KmssRuntimeException(e);
				}
			}
		}
	}

	public void updateFeedbackPeople(KmReviewMain main, List notifyTarget)
			throws Exception {
		super.update(main);
		if (main.getFdNotifyType() == null)
			return;
		// HashMap map = new HashMap();
		// map.put("km-review:kmReviewMain.docSubject", main.getDocSubject());
		NotifyReplace notifyReplace = new NotifyReplace();
		notifyReplace.addReplaceText("km-review:kmReviewMain.docSubject",
				main.getDocSubject());
		NotifyContext notifyContext = sysNotifyMainCoreService
				.getContext("km-review:kmReview.feedback.notify");
		notifyContext.setKey("passreadKey");
		notifyContext.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
		notifyContext.setNotifyTarget(notifyTarget);
		notifyContext.setNotifyType(main.getFdNotifyType());
		sysNotifyMainCoreService.sendNotify(main, notifyContext, notifyReplace);
	}

	public IKmReviewTemplateService getKmReviewTemplateService() {
		return kmReviewTemplateService;
	}

	public void setKmReviewTemplateService(
			IKmReviewTemplateService kmReviewTemplateService) {
		this.kmReviewTemplateService = kmReviewTemplateService;
	}

	public ISysCategoryMainService getSysCategoryMainService() {
		return sysCategoryMainService;
	}

	public void setSysCategoryMainService(
			ISysCategoryMainService sysCategoryMainService) {
		this.sysCategoryMainService = sysCategoryMainService;
	}

	public void setSysNotifyMainCoreService(
			ISysNotifyMainCoreService sysNotifyMainCoreService) {
		this.sysNotifyMainCoreService = sysNotifyMainCoreService;
	}

	@Override
	protected IBaseModel initBizModelSetting(RequestContext requestContext)
			throws Exception {
		String templateId = requestContext.getParameter("fdTemplateId");
		if (!StringUtil.isNotNull(templateId)) {
			return null;
		}
		KmReviewMain model = new KmReviewMain();
		KmReviewTemplate template = (KmReviewTemplate) getKmReviewTemplateService()
				.findByPrimaryKey(templateId);
		// 加载机制数据
		// getKmReviewTemplateService().convertModelToForm(null, template,
		// requestContext);
		model.setFdTemplate(template);
		model.setDocContent(template.getDocContent());
		model.setFdFeedback(new ArrayList(template.getFdFeedback()));
		model.setFdFeedbackModify(template.getFdFeedbackModify() ? "1" : "0");
		List<KmReviewTemplateKeyword> templateList = template.getDocKeyword();
		List modelKeywordList = new ArrayList();
		for (KmReviewTemplateKeyword tkey : templateList) {
			KmReviewDocKeyword tKeyword = new KmReviewDocKeyword();
			tKeyword.setDocKeyword(tkey.getDocKeyword());
			modelKeywordList.add(tKeyword);
		}
		model.setDocKeyword(modelKeywordList);
		model.setFdLableReaders(new ArrayList(template.getFdLabelReaders()));
		model.setFdPosts(new ArrayList(template.getFdPosts()));
		model.setDocProperties(new ArrayList(template.getDocProperties()));
		model.setDocCreator(UserUtil.getUser());
		model.setDocCreateTime(new Date());
		// 增加是否使用表单模式的判断
		if (Boolean.FALSE.equals(template.getFdUseForm())
				&& Boolean.FALSE.equals(template.getFdUseWord())) {
			model.setDocContent(template.getDocContent());
		}
		model.setFdUseForm(template.getFdUseForm());
		model.setFdUseWord(template.getFdUseWord());
		model.setFdDisableMobileForm(template.getFdDisableMobileForm());
		model.setFdDepartment(UserUtil.getUser().getFdParent());
		
		// 支持移动端新建
		model.setFdIsMobileCreate(template.getFdIsMobileCreate());
		// 支持移动端审批
		model.setFdIsMobileApprove(template.getFdIsMobileApprove());
		
		// model.setExtendFilePath(XFormUtil.getFileName(template
		// .getSysFormTemplateModels(), "reviewMainDoc"));
		// 修改为新的接口

		if (Boolean.TRUE.equals(template.getFdUseForm())) {
			model.setExtendFilePath(XFormUtil.getFileName(template,
					"reviewMainDoc"));
		}
		return model;
	}

	@Override
	protected void initCoreServiceFormSetting(IExtendForm form,
			IBaseModel model, RequestContext requestContext) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		dispatchCoreService.initFormSetting(form, "reviewMainDoc", kmReviewMain
				.getFdTemplate(), "reviewMainDoc", requestContext);
	}

	// ********** 以下的代码为日程机制需要的代码，从业务模板同步数据到时间管理模块 开始**********
	private ISysAgendaMainCoreService sysAgendaMainCoreService = null;

	public void setSysAgendaMainCoreService(
			ISysAgendaMainCoreService sysAgendaMainCoreService) {
		this.sysAgendaMainCoreService = sysAgendaMainCoreService;
	}

	// 新增同步(针对表单公式定义器模块)
	public void addSyncDataToCalendarFormula(IBaseModel model) throws Exception {
		KmReviewMain mainModel = (KmReviewMain) model;
		SysAgendaMainContextFormula sysAgendaMainContextFormula = initSysAgendaMainContextFormula(mainModel);
		sysAgendaMainCoreService.addSyncDataToCalendar(
				sysAgendaMainContextFormula, mainModel);
	}

	// 更新同步数据接口(针对表单公式定义器模块)
	public void updateSyncDataToCalendarFormula(IBaseModel model)
			throws Exception {
		KmReviewMain mainModel = (KmReviewMain) model;
		SysAgendaMainContextFormula sysAgendaMainContextFormula = initSysAgendaMainContextFormula(mainModel);
		sysAgendaMainCoreService.updateDataSyncDataToCalendar(
				sysAgendaMainContextFormula, mainModel);
	}

	// 删除同步数据接口(针对表单公式定义器模块)
	public void deleteSyncDataToCalendarFormula(IBaseModel model)
			throws Exception {
		KmReviewMain mainModel = (KmReviewMain) model;
		sysAgendaMainCoreService.deleteSyncDataToCalendar(mainModel);
	}

	// 初始化数据（针对表单公式定义器模块）
	private SysAgendaMainContextFormula initSysAgendaMainContextFormula(
			IBaseModel mainModel) {
		SysAgendaMainContextFormula sysAgendaMainContextFormula = new SysAgendaMainContextFormula();
		sysAgendaMainContextFormula
				.setDocUrl("/km/review/km_review_main/kmReviewMain.do?method=view&fdId="
						+ mainModel.getFdId());
		sysAgendaMainContextFormula
				.setCalType(SysAgendaTypeEnum.fdCalendarType.EVENT.getKey());
		sysAgendaMainContextFormula.setLunar(false);
		return sysAgendaMainContextFormula;
	}
	// ********** 以上的代码为日程机制需要的代码，从业务模板同步数据到时间管理模块 结束 **********
	
	/**
	 * 复制文档附件，用于“复制流程”功能
	 */
	public void copyAttachment(KmReviewMainForm newForm, KmReviewMainForm oldForm) throws Exception {
		Map newMap = new HashMap();
		// 获取旧文档附件
		Map attMap = oldForm.getAttachmentForms();

		for (Object obj : attMap.keySet()) {
			Object _obj = attMap.get(obj);
			if (_obj instanceof AttachmentDetailsForm) {
				AutoArrayList newList = new AutoArrayList(SysAttMain.class);
				AttachmentDetailsForm _form = (AttachmentDetailsForm) _obj;
				List<SysAttMain> list = _form.getAttachments();
				for (SysAttMain attMain : list) {
					newList.add(sysAttMainService.clone(attMain));
				}
				// 封装新文档附件
				AttachmentDetailsForm newDetailsForm = new AttachmentDetailsForm();
				newDetailsForm.setAttachments(newList);
				newMap.put(obj, newDetailsForm);
			}
		}
		newForm.getAttachmentForms().putAll(newMap);
	}
	
	
	
	@Override
	public void addFileMainDoc(HttpServletRequest request, String fdId,
			KmArchivesFileTemplate fileTemplate)
			throws Exception {
		// 手动归档只有结束和已反馈的文档可以归档
		KmReviewMain mainModel = (KmReviewMain) findByPrimaryKey(fdId);
		if (!mainModel.getDocStatus()
				.equals(Constant.STATUS_PUBLISH)
				&& !mainModel.getDocStatus().equals(Constant.STATUS_FEEDBACK)) {
			throw new KmssRuntimeException(
					new KmssMessage("km-archives:file.notsupport"));
		}
		
		KmReviewTemplate tempalte = mainModel.getFdTemplate();
		// 模块支持归档
		if (KmArchivesUtil.isStartFile("km/review")) {
			KmArchivesFileTemplate fTemplate = kmArchivesFileTemplateService
					.getFileTemplate(tempalte, null);
			// 有归档模板
			if (fTemplate != null) {
				addArchives(request, mainModel, fTemplate);
			} else if (null != request && "1".equals(request.getParameter("userSetting"))) { // 支持用户级配置
				addArchives(request, mainModel, fileTemplate);
			}
		}
	}

	private void addArchives(HttpServletRequest request, KmReviewMain mainModel,
			KmArchivesFileTemplate fileTemplate) throws Exception {
		KmArchivesMain kmArchivesMain = new KmArchivesMain();
		kmArchivesFileTemplateService.setFileField(kmArchivesMain,
				fileTemplate, mainModel);
		// 归档页面URL(若为多表单，暂时归档默认表单)
		int saveApproval = fileTemplate.getFdSaveApproval() != null
				&& fileTemplate.getFdSaveApproval() ? 1 : 0;
		String url = "/km/review/km_review_main/kmReviewMain.do?method=printFileDoc&fdId="
				+ mainModel.getFdId() + "&s_xform=default&saveApproval="
				+ saveApproval;
		String fileName = mainModel.getDocSubject() + ".html";
		kmArchivesFileTemplateService.setFilePrintPage(kmArchivesMain,
				request, url, fileName);
		
		// 找到与主文档绑定的所有附件
		kmArchivesFileTemplateService.setFileAttachement(kmArchivesMain,
				mainModel);
		kmArchivesFileTemplateService.addFileArchives(kmArchivesMain);
		if(UserOperHelper.allowLogOper("fileDoc", "*")){
			UserOperContentHelper.putAdd(kmArchivesMain).putSimple("docTemplate", fileTemplate);
		}

		mainModel.setFdIsFiling(true);
		if(UserOperHelper.allowLogOper("fileDoc", "*")|| UserOperHelper.allowLogOper("fileDocAll", "*")){
		    UserOperContentHelper.putUpdate(mainModel);
		}
		update(mainModel);
	}
	
	

	@Override
	public String getCount(String type, Boolean isDraft) throws Exception {

		String count = "0";
		HQLInfo hql = new HQLInfo();
		hql.setGettingCount(true);
		if ("draft".equals(type)) {
			String whereBlock = " kmReviewMain.docCreator.fdId=:createorId";
			if (isDraft) {
				whereBlock = StringUtil.linkString(whereBlock, " and ",
						" kmReviewMain.docStatus=:docStatus");
				hql.setParameter("docStatus", "10");
			}
			hql.setParameter("createorId", UserUtil.getUser().getFdId());
			hql.setWhereBlock(whereBlock);
		} else if ("approved".equals(type)) {
			LbpmUtil.buildLimitBlockForMyApproved("kmReviewMain", hql, UserUtil.getUser().getFdId());
		} else {
			hql.setCheckParam(SysAuthConstant.CheckType.AllCheck, SysAuthConstant.AllCheck.DEFAULT);
		}

		List<Long> list = this.getBaseDao().findValue(hql);
		if (list.size() > 0) {
			count = list.get(0).toString();
		} else {
			count = "0";
		}
		return count;
	}

	@Override
	public String getCount(HQLInfo hqlInfo) throws Exception {
		String count = "0";
		List<Long> list = this.getBaseDao().findValue(hqlInfo);
		if (list.size() > 0) {
			count = list.get(0).toString();
		} else {
			count = "0";
		}
		return count;
	}

	@Override
	public String addSubsideFileMainDoc(HttpServletRequest request, String fdId,
			KmsMultidocSubside subside)
			throws Exception {
		ISysFileConvertClientService sysFileConvertClientService = (ISysFileConvertClientService) SpringBeanUtil
				.getBean("sysFileConvertClientService");
		sysFileConvertClientService.refreshClients(false);
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock("converterFullKey = :converterFullKey and avail = :avail ");
		hqlInfo.setParameter("converterFullKey", "toPDF-Aspose");
		hqlInfo.setParameter("avail", Boolean.TRUE);
		List<SysFileConvertClient> findClients=sysFileConvertClientService.findList(hqlInfo);
		boolean toPdfAlive = findClients.size()>0;
		KmReviewMain mainModel = (KmReviewMain) findByPrimaryKey(fdId);
		KmReviewTemplate tempalte = mainModel.getFdTemplate();
		List list = kmsMultidocSubsideService.getCoreModels(tempalte, null);
		KmsMultidocKnowledge kmsMultidocKnowledge = new KmsMultidocKnowledge();
		kmsMultidocKnowledge.setSubModelId(fdId);
		kmsMultidocKnowledge.setSubModelName(
				"com.landray.kmss.km.review.model.KmReviewMain");
		if (subside != null) {
				if (list.size() > 0 && list != null) {
					KmsMultidocSubside kmsMultidocSubside = (KmsMultidocSubside) list.get(0);
					subside.setDocSubjectMapping(kmsMultidocSubside.getDocSubjectMapping());
					subside.setDocCreatorMapping(kmsMultidocSubside.getDocCreatorMapping());
					}
				kmsMultidocSubsideService.addFileField(kmsMultidocKnowledge,
						subside, mainModel);
				String url = "/km/review/km_review_main/kmReviewMain.do?method=printSubsideDoc&fdId="
						+ mainModel.getFdId() + "&s_xform=default&fdSaveApproval="
						+ subside.getFdSaveApproval();
				String fileName = mainModel.getDocSubject() + ".html";
				//附加html文件到知识文档库主文档
				addFilePrintPage(kmsMultidocKnowledge,request, url, fileName,toPdfAlive);
				
				//附加附件到知识文档库主文档
				addFileAttachement(kmsMultidocKnowledge,mainModel,toPdfAlive);
				
				
				kmsMultidocSubsideService.addSubside(kmsMultidocKnowledge, request);
				update(mainModel);
				//加入当前文档的附件到pdf转换队列
				if(toPdfAlive){
					kmsMultidocSubsideService.addToPdfConventerQueen(kmsMultidocKnowledge, request);
				}
			return kmsMultidocKnowledge.getFdId();
		} else {
			if (list.size() > 0 && list != null) {
				KmsMultidocSubside kmsMultidocSubside = (KmsMultidocSubside) list
						.get(0);
				kmsMultidocSubsideService.addFileField(kmsMultidocKnowledge,
						kmsMultidocSubside, mainModel);
				String url = "/km/review/km_review_main/kmReviewMain.do?method=printSubsideDoc&fdId="
						+ mainModel.getFdId();
				/**
				 * 自动沉淀逻辑
				 */
				String signKey = MD5Util.getMD5String(fdId);
				KmssCache cache = new KmssCache(KmsMultidocSubside.class);
				String signJsonStr = (String) cache.get(signKey);
				if (!StringUtil.isNull(signJsonStr)) {
					com.alibaba.fastjson.JSONObject sign = (com.alibaba.fastjson.JSONObject) JSON.parse(signJsonStr);
					sign.put("printUrl", url);
					cache.put(signKey, sign.toJSONString());
					url = "/km/review/km_review_main/kmReviewMainSubside.do?method=printSubsideDoc&fdId="+fdId;
				}
				
				String fileName = mainModel.getDocSubject() + ".html";
				//附加html文件到知识文档库主文档
				addFilePrintPage(kmsMultidocKnowledge,request, url, fileName, toPdfAlive);
				
				//附加附件到知识文档库主文档
				addFileAttachement(kmsMultidocKnowledge,mainModel,toPdfAlive);
				
				kmsMultidocSubsideService.addSubside(kmsMultidocKnowledge,
						request);
				update(mainModel);
				if (kmsMultidocSubside.getCategory() != null) {
					//加入当前文档的附件到pdf转换队列
					if(toPdfAlive){
						kmsMultidocSubsideService.addToPdfConventerQueen(kmsMultidocKnowledge, request);
					}
					return kmsMultidocKnowledge.getFdId();
				} else {
					return null;
				}
			}
		}
		return null;
	}
	
	public void addFileAttachement(KmsMultidocKnowledge kmsMultidocKnowledge,
			IBaseModel mainModel, boolean toPdfAlive) throws Exception {
		List list = sysAttMainService.findAttListByModel(
				ModelUtil.getModelClassName(mainModel), mainModel.getFdId());
		if (list.size() > 0 && list != null) {
			for (int i = 0; i < list.size(); i++) {
				SysAttMain attmain = (SysAttMain) list.get(i);
				if (!isNotNeedWhenSubside(attmain)) {
					InputStream is = sysAttMainService.getInputStream(attmain);
					sysAttMainService.addAttachment(kmsMultidocKnowledge, toPdfAlive?"attachment_tmp":"attachment", IOUtils.toByteArray(is),
							attmain.getFdFileName(), "byte");
					IOUtils.closeQuietly(is);
				}
			}
		}

	}
	
	public void addFilePrintPage(KmsMultidocKnowledge kmsMultidocKnowledge,
			HttpServletRequest request, String url, String fileName, boolean toPdfAlive)
			throws Exception {
		HtmlToMht htm = new HtmlToMht(false);
		String serverUrl = ResourceUtil.getKmssConfigString("kmss.innerUrlPrefix");
		url = serverUrl + url;
		String page = htm.getClientPage(request, url);
		page = new HtmlHandler().handlingHTMLAgain(page);
		if (StringUtil.isNotNull(page)) {
			SysAttMain sysAttMain = new SysAttMain();
			sysAttMain.setDocCreateTime(new Date());
			sysAttMain.setFdFileName(fileName);
			sysAttMain.setFdSize(Double.valueOf(page.getBytes("UTF-8").length));
			sysAttMain.setFdFileName(fileName);
			sysAttMain.setDocCreateTime(new Date());
			String contentType = FileMimeTypeUtil.getContentType(fileName);
			sysAttMain.setFdContentType(contentType);
			sysAttMain.setInputStream(new ByteArrayInputStream(page.getBytes("UTF-8")));
			sysAttMain.setFdKey(toPdfAlive?"attachment_tmp":"attachment");
			sysAttMain.setFdModelId(kmsMultidocKnowledge.getFdId());
			String modelName = ModelUtil.getModelClassName(kmsMultidocKnowledge);
			sysAttMain.setFdModelName(modelName);
			sysAttMain.setFdAttType("byte");
			sysAttMain.setFdOrder(0);
			sysAttMainService.add(sysAttMain);
		}
	}
	
	
	/**
	 * 判断是否是不需要归档的附件，一般是一些流程中的签批图片等
	 * 
	 * @param attMain
	 * @return
	 */
	private boolean isNotNeedWhenSubside(SysAttMain attMain) {
		/**
		 * sp语音，sg批注，qz签章，hw手写，不需要归档过去
		 */
		String[] noFileKeys = new String[] { "_sp", "_sg", "_qz", "_hw", "historyVersionAttachment" };
		String fdKey = attMain.getFdKey();
		if (StringUtil.isNotNull(fdKey)) {
			for (String key : noFileKeys) {
				if (fdKey.endsWith(key)) {
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public Map<String, ?> listPortlet(RequestContext request) throws Exception {
		Map<String, Object> rtnMap = new HashMap<>();
		JSONArray datas = new JSONArray();// 列表形式使用
		Page page = Page.getEmptyPage();// 简单列表使用
		String dataview = request.getParameter("dataview");
		String owner = request.getParameter("owner");// 我发起的
		String status = request.getParameter("status");
		String myFlow = request.getParameter("myFlow");// 我审批的
		HQLInfo hqlInfo = new HQLInfo();
		if (StringUtil.isNotNull(owner)) {
			getOwnerData(request, status, hqlInfo);
			request.setAttribute("flag", "owner");
		} else {
			getMyFlowDate(request, myFlow, hqlInfo);
		}
		hqlInfo.setGetCount(false);
		// 时间范围参数
		String scope = request.getParameter("scope");
		if (StringUtil.isNotNull(scope) && !scope.equals("no")) {
			String block = hqlInfo.getWhereBlock();
			if ("all".equals(myFlow)) {
				hqlInfo.setWhereBlock(StringUtil.linkString(block, " and ",
						"kmReviewMain.docPublishTime > :fdStartTime"));
			} else {
				hqlInfo.setWhereBlock(StringUtil.linkString(block, " and ",
						"kmReviewMain.docCreateTime > :fdStartTime"));
			}
			hqlInfo.setParameter("fdStartTime", PortletTimeUtil
					.getDateByScope(scope));
		}
		// 门户不进行场所过滤
		if (!"all".equals(myFlow)) {
			hqlInfo.setCheckParam(
				SysAuthConstant.CheckType.AreaCheck,
				SysAuthConstant.AreaCheck.NO);
		}
		page = findPage(hqlInfo);
		UserOperHelper.logFindAll(page.getList(), getModelName());
		if ("classic".equals(dataview)) {// 视图展现方式:classic(简单列表)
			List<KmReviewMain> topics = page.getList();
			for (KmReviewMain topic : topics) {
				JSONObject data = new JSONObject();
				// 主题
				data.put("text", topic.getDocSubject());
				if (request.isCloud()) {
					data.put("creator",
							ListDataUtil.buildCreator(topic.getDocCreator()));
					data.put("created", topic.getDocCreateTime().getTime());
					if (isNew(topic, request.getParameter("isnew"))) {
						List<IconDataVO> icons = new ArrayList<>(1);
						IconDataVO icon = new IconDataVO();
						icon.setName("new");
						icon.setType("bitmap");
						icons.add(icon);
						data.put("icons", icons);
					}
					// 分类
					data.put("cateName", topic.getFdTemplate().getFdName());
					data.put("cateHref",
							"/km/review/#cri.q=fdTemplate:"
									+ topic.getFdTemplate().getFdId());
					data.put("statusInfo", ListDataUtil
							.getDocStatusString(topic.getDocStatus()));
					data.put("statusColor", ListDataUtil
							.getDocStatusColor(topic.getDocStatus()));
				} else {
					// 创建人
					data.put("creator", topic.getDocCreator().getFdName());
					// 创建时间
					data.put("created", DateUtil.convertDateToString(topic
							.getDocCreateTime(), DateUtil.TYPE_DATE, null));
					// 分类
					data.put("catename", topic.getFdTemplate().getFdName());
					data.put("catehref",
							"/km/review/#cri.q=fdTemplate:"
									+ topic.getFdTemplate().getFdId());
				}
				StringBuffer sb = new StringBuffer();
				sb
						.append("/km/review/km_review_main/kmReviewMain.do?method=view");
				sb.append("&fdId=" + topic.getFdId());
				data.put("href", sb.toString());
				datas.add(data);
			}
		}
		rtnMap.put("datas", datas);
		rtnMap.put("page", page);
		return rtnMap;
	}

	private boolean isNew(KmReviewMain mainModel, String isnew) {
		// MK-PAAS的NEW图标统一在前端呈现中处理
		// if (StringUtil.isNotNull(isnew)) {
		// int day = Integer.parseInt(isnew);
		// if (day > 0) {
		// Calendar now = Calendar.getInstance();
		// Calendar date = Calendar.getInstance();
		// date.setTime(mainModel.getDocCreateTime());
		// date.add(Calendar.DATE, day);
		// return date.after(now);
		// }
		// }
		return false;
	}

	private void getOwnerData(RequestContext request, String status,
			HQLInfo hqlInfo) throws Exception {
		String param = request.getParameter("rowsize");
		int rowsize = 6;
		if (!StringUtil.isNull(param))
			rowsize = Integer.parseInt(param);
		String whereBlock = "";
		if ("all".equals(status)) {
			whereBlock = StringUtil.linkString(whereBlock, " AND ",
					"kmReviewMain.docCreator.fdId=:creatorId");
			hqlInfo.setParameter("creatorId", UserUtil.getUser().getFdId());
		} else {
			whereBlock = StringUtil
					.linkString(whereBlock, " AND ",
							"kmReviewMain.docStatus=:docStatus AND kmReviewMain.docCreator.fdId=:creatorId");
			hqlInfo.setParameter("docStatus", status);
			hqlInfo.setParameter("creatorId", UserUtil.getUser().getFdId());
		}
		hqlInfo.setWhereBlock(whereBlock);
		hqlInfo.setOrderBy("kmReviewMain.docCreateTime desc");
		hqlInfo.setRowSize(rowsize);
		hqlInfo.setPageNo(1);
		hqlInfo.setGetCount(false);
	}

	private void getMyFlowDate(RequestContext request, String myFlow,
			HQLInfo hqlInfo) throws Exception {
		String param = request.getParameter("rowsize");
		int rowsize = 6;
		if (!StringUtil.isNull(param))
			rowsize = Integer.parseInt(param);
		String whereBlock = getTemplateString(request,hqlInfo);
		if ("approved".equals(myFlow)) {
			SysFlowUtil.buildLimitBlockForMyApproved("kmReviewMain", hqlInfo);
		} else if ("approval".equals(myFlow)) {
			SysFlowUtil.buildLimitBlockForMyApproval("kmReviewMain", hqlInfo);
		} else if ("all".equals(myFlow)) {
			hqlInfo.setWhereBlock(whereBlock);
		}
		hqlInfo.setOrderBy("kmReviewMain.docCreateTime desc");
		hqlInfo.setRowSize(rowsize);
		hqlInfo.setPageNo(1);
		hqlInfo.setGetCount(false);
	}

	// 分类ID的查询语句
	private String getTemplateString(RequestContext request,HQLInfo hqlInfo)
			throws Exception {
		String fdCategoryId = request.getParameter("fdCategoryId");
		StringBuffer whereBlock = new StringBuffer();
		if (StringUtil.isNotNull(fdCategoryId)) {
			// 选择的分类
			String templateProperty = "kmReviewMain.fdTemplate";
			whereBlock.append(CategoryUtil.buildChildrenWhereBlock(
					fdCategoryId, null, templateProperty,hqlInfo));
		} else {
			whereBlock.append("1=1 ");
		}
		return whereBlock.toString();
	}

	/**
	 * 自动归档
	 */
	@Override
	public void addAutoFileMainDoc(String fdId, KmArchivesFileTemplate fileTemplate) throws Exception {
		String sign = fdId.split(",")[1];
		KmReviewMain mainModel = (KmReviewMain) findByPrimaryKey(fdId.split(",")[0]);
		KmReviewTemplate tempalte = mainModel.getFdTemplate();
		// 模块支持归档
		if (KmArchivesUtil.isStartFile("km/review")) {
			KmArchivesFileTemplate fTemplate = kmArchivesFileTemplateService
					.getFileTemplate(tempalte, null);
			// 有归档模板
			if (fTemplate != null) {
				addSignArchives(mainModel, fTemplate, sign);
			}else{
				return;
			}
		}
	}

	private IKmArchivesSignService kmArchivesSignService;

	public IKmArchivesSignService getArchivesSignService() {
		if (kmArchivesSignService == null) {
			kmArchivesSignService = (IKmArchivesSignService) SpringBeanUtil.getBean("kmArchivesSignService");
		}
		return kmArchivesSignService;
	}
	/**
	 * 流程结束自动归档请求
	 * @param mainModel
	 * @param saveApproval
	 */
	public void addSignArchives(KmReviewMain mainModel,
			KmArchivesFileTemplate fileTemplate, String sign){
		KmArchivesMain kmArchivesMain = new KmArchivesMain();
		try {
			kmArchivesFileTemplateService.setFileField(kmArchivesMain,
					fileTemplate, mainModel);
			if (kmArchivesMain.getDocCreator() == null || kmArchivesMain.getDocCreator().isAnonymous()) {
				kmArchivesMain.setDocCreator(mainModel.getDocCreator());
			}
			// 归档页面URL(若为多表单，暂时归档默认表单)
			int saveApproval = fileTemplate.getFdSaveApproval() != null
					&& fileTemplate.getFdSaveApproval() ? 1 : 0;
			//流程自动归档
			String fdModelId = mainModel.getFdId();
			long expires = System.currentTimeMillis() + (3 * 60 * 1000);//下载链接3分钟有效
			String url = "/km/review/km_review_main/kmReviewMainArchives.do?method=printFileDocArchives&fdId=" 
					+ fdModelId + "&s_xform=default&saveApproval="+saveApproval + "&Signature=" + sign + "&Expires=" + expires;
			String fileName = mainModel.getDocSubject() + ".html";
			kmArchivesFileTemplateService.setFilePrintArchivesPage(kmArchivesMain, url, fileName);
			
			// 找到与主文档绑定的所有附件
			kmArchivesFileTemplateService.setFileAttachement(kmArchivesMain,
					mainModel);
			kmArchivesFileTemplateService.addFileArchives(kmArchivesMain);
			getArchivesSignService().deleteSign(fdModelId);

			if(UserOperHelper.allowLogOper("fileDoc", "*")){
				UserOperContentHelper.putAdd(kmArchivesMain).putSimple("docTemplate", fileTemplate);
			}
	
			mainModel.setFdIsFiling(true);
			if(UserOperHelper.allowLogOper("fileDoc", "*")|| UserOperHelper.allowLogOper("fileDocAll", "*")){
			    UserOperContentHelper.putUpdate(mainModel);
			}
			update(mainModel);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Map<String, String>> getRecentTemplate(int count)
			throws Exception {
		List<Map<String, String>> retVal = new ArrayList<Map<String, String>>();
		HQLInfo info = new HQLInfo();
		info.setSelectBlock(
				"kmReviewMain.fdTemplate.fdId,kmReviewMain.fdTemplate.fdName");
		info.setWhereBlock("kmReviewMain.docCreator.fdId=:userId");
		info.setOrderBy("kmReviewMain.docCreateTime desc");
		info.setParameter("userId", UserUtil.getUser().getFdId());
		// 避免重复的流程，只获取指定条目3倍的数量来获取
		info.setRowSize(count * 3);
		List templates = findValue(info);
		if (templates != null) {
			int size = 0;
			Map<String, Integer> addedTemplate = new HashMap<String, Integer>();
			for (Object template : templates) {
				Object[] tmp = (Object[]) template;
				if (!addedTemplate.containsKey(tmp[0])) {
					// 逐个添加最近使用模板列表
					Map<String, String> data = new HashMap<String, String>();
					data.put("id", (String) tmp[0]);
					data.put("name", (String) tmp[1]);
					retVal.add(data);
					addedTemplate.put((String) tmp[0], 1);
					size++;
					if (size >= count) {
						// 超出限定条目，则结束查找
						break;
					}
				}
			}
		}
		return retVal;
	}
	
	/**
	 * 将节点特权人增加为文档增加可阅读者
	 * @param mainModel
	 */
	private void addNodePriviledges(IBaseModel mainModel) {
		Map<String, SysOrgElement> allReadersMap = new HashMap<>();
		List<SysOrgElement> allNodePriviledgers = new ArrayList<SysOrgElement>();

		ProcessExecuteService processExecuteService = (ProcessExecuteService) SpringBeanUtil.getBean("lbpmProcessExecuteService");
		AccessManager accessManager = (AccessManager) SpringBeanUtil.getBean("accessManager");
		ProcessInstanceInfo processInfo = processExecuteService.load(mainModel.getFdId());
		List<?> currentNodeInfos = processInfo.getCurrentNodeInfos();
		// 查找节点特权人org类型
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processDefId", processInfo.getProcessDefinitionInfo().getDefinition().getFdId());
		params.put("attribute", "nodePrivilegeIds");
		List<LbpmNodeDefinitionHandler> handlers = accessManager.find("LbpmNodeDefinitionHandler.findByAttributeAndDefinitionId", params);
		List<LbpmNodeDefinition> nodeDefinitions = accessManager.find("LbpmNodeDefinition.findDefinitionsByDefinitionId", processInfo.getProcessDefinitionInfo().getDefinition().getFdId());
		for (LbpmNodeDefinitionHandler h : handlers) {
			if (!allReadersMap.containsKey(h.getFdHandler().getFdId())) {
				allReadersMap.put(h.getFdHandler().getFdId(), h.getFdHandler());
			}
		}

		// 查找节点特权人formula类型
		for (LbpmNodeDefinition nodeDefinition : nodeDefinitions) {
			Document nodeDocument = XMLUtils.parse(nodeDefinition.getFdContent());
			Node rootNode = nodeDocument.getFirstChild();
			if (!"signNode".equals(rootNode.getNodeName()) && !"reviewNode".equals(rootNode.getNodeName())) {
				continue;
			}
			String modifyNodeHandler = XMLUtils.getAttrValue(rootNode, "modifyNodeHandler");
			String urgeHandler = XMLUtils.getAttrValue(rootNode, "urgeHandler");
			String nodePrivilegeIds = XMLUtils.getAttrValue(rootNode, "nodePrivilegeIds");
			String selectType = XMLUtils.getAttrValue(rootNode, "nodePrivilegeSelectType");

			if (StringUtil.isNotNull(nodePrivilegeIds) && "formula".equals(selectType)) {
				try {
					Class modelClass = ClassUtils.forName(processInfo.getProcessInstance().getFdModelName());
					IBaseModel model = accessManager.get(modelClass, processInfo.getProcessInstance().getFdModelId());
					ProcessServiceManager processServiceManager = (ProcessServiceManager) SpringBeanUtil
							.getBean("lbpmProcessServiceManager");
					IRuleProvider ruleProvider = processServiceManager.getRuleService().getRuleProvider(new NoExecutionEnvironment(mainModel));
					// 追加解析器
					ruleProvider.addRuleParser(LbpmFunction.class.getName());
					// 规则事实参数
					RuleFact fact = new RuleFact(mainModel);
					fact.setScript(nodePrivilegeIds);
					fact.setReturnType(SysOrgElement.class.getName() + "[]");
					List<SysOrgElement> results = (List<SysOrgElement>) ruleProvider.executeRules(fact);
					if (results != null && results.size() > 0) {
						for (SysOrgElement result : results) {
							if (!allReadersMap.containsKey(result.getFdId())) {
								allReadersMap.put(result.getFdId(), result);
							}
						}
					}
				} catch (Exception e) {
					logger.error("公式解析节点特权人处理人出错", e);
				}
			}
		}

		for (Object readerObj : ((KmReviewMain)mainModel).getAuthReaders()) {
			SysOrgElement reader = (SysOrgElement) readerObj;
			if (!allReadersMap.containsKey(reader.getFdId())) {
				allReadersMap.put(reader.getFdId(), reader);
			}
		}

		((KmReviewMain)mainModel).setAuthReaders(new ArrayList(allReadersMap.values()));
	}
}
