package com.landray.kmss.common.service;

import java.beans.PropertyDescriptor;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.IFormToModelConvertor;
import com.landray.kmss.common.convertor.IModelToFormConvertor;
import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.dao.IBaseDao;
import com.landray.kmss.common.exception.FormModelConvertException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.sys.config.design.SysCfgFtSearch;
import com.landray.kmss.sys.config.design.SysConfigs;
import com.landray.kmss.sys.log.util.UserOperConvertHelper;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.IUserOper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.sys.notify.model.SysNotifyTodo;
import com.landray.kmss.sys.notify.service.ISysNotifyTodoService;
import com.landray.kmss.sys.recycle.model.ISysRecycleModel;
import com.landray.kmss.sys.recycle.model.SysRecycleConstant;
import com.landray.kmss.sys.recycle.service.ISysRecycleLogService;
import com.landray.kmss.sys.recycle.util.SysRecycleUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.sunbor.web.tag.Page;

/**
 * ???????????????IBaseDao???????????????????????????CRUD????????????????????????<br>
 * ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????<br>
 * ?????????????????????????????????<br>
 * <li>?????????model?????????{@link com.landray.kmss.common.model.IBaseModel IBaseModel}???</li>
 * 
 * @author ?????????
 * @version 1.0 2006-04-02
 */
public class BaseServiceImp implements IBaseService {
	private static final Log logger = LogFactory.getLog(BaseServiceImp.class);

	private IBaseDao baseDao;

	protected ICoreOuterService dispatchCoreService = null;

	private static final String METHOD_GET_ADD = "add";
	private static final String METHOD_SAVE = "save";
	private static final String METHOD_SAVE_ADD = "saveadd";

	public String add(IBaseModel modelObj) throws Exception {
		String rtnVal = getBaseDao().add(modelObj);
		if (dispatchCoreService != null)
			dispatchCoreService.add(modelObj);
		return rtnVal;
	}
	
	public String add(IExtendForm form, RequestContext requestContext)
			throws Exception {
		String modelName = form.getModelClass().getName();
		modelName = StringUtil.isNotNull(modelName) ? modelName : getModelName();
		UserOperHelper.logAdd(modelName);
		IBaseModel model = convertFormToModel(form, null, requestContext);
		String fdId = model.getFdId();
		if (fdId != null) {
			String reqMethodGet = requestContext.getParameter("method_GET");
			String reqMethod = requestContext.getParameter("method");
			if (METHOD_GET_ADD.equals(reqMethodGet)
					&& (METHOD_SAVE.equals(reqMethod)
							|| METHOD_SAVE_ADD.equals(reqMethod))) {
				if (getBaseDao().isExist(getModelName(), fdId)) {
					throw new UnexpectedRequestException();
				}
			}
		}
		return add(model);
	}

	public IExtendForm cloneModelToForm(IExtendForm form, IBaseModel model,
			RequestContext requestContext) throws Exception {
		ConvertorContext context = new ConvertorContext();
		context.setBaseService(this);
		context.setObjMap(new HashMap());
		context.setRequestContext(requestContext);
		context.setIsClone(true);
		return convertModelToForm(form, model, context);
	}

	protected IBaseModel convertBizFormToModel(IExtendForm form,
			IBaseModel model, ConvertorContext context) throws Exception {
		String sPropertyName = null;
		try {
			if (form == null)
				return null;
			TimeCounter.logCurrentTime("service-convertFormToModel", true, form
					.getClass());
			Map objMap = context.getObjMap();
			if (objMap.containsKey(form))
				return (IBaseModel) objMap.get(form);
			// ??????????????????
			if (model == null) {
				boolean formIdNotNull = StringUtil.isNotNull(form.getFdId());
				if (formIdNotNull) {
					model = findByPrimaryKey(form.getFdId(), form
							.getModelClass(), true);
				}
				if (model == null) {
					if (logger.isDebugEnabled())
						logger.debug("????????????" + form.getModelClass().getName()
								+ "?????????");
					model = (IBaseModel) form.getModelClass().newInstance();
					if (formIdNotNull) {
						model.setFdId(form.getFdId());
					}
				}
			}
			form.setFdId(model.getFdId());
			ConvertorContext convertorContext = new ConvertorContext(context);
			convertorContext.setSObject(form);
			convertorContext.setTObject(model);
			//????????????????????????
			UserOperConvertHelper.createOper(convertorContext, model, form);
			// ??????????????????Form???????????????
			objMap.put(form, model);
			// ??????Form?????????????????????
			Map propertyMap = form.getToModelPropertyMap().getPropertyMap();
			List propertyList = form.getToModelPropertyMap().getPropertyList();
			// ??????Form????????????????????????????????????????????????
			PropertyDescriptor[] sProperties = PropertyUtils
					.getPropertyDescriptors(form);
			for (int i = 0; i < sProperties.length; i++) {
				sPropertyName = sProperties[i].getName();
				if (propertyMap.containsKey(sPropertyName)) {
					continue;
				} else {
					try {
						if (!PropertyUtils.isReadable(form, sPropertyName)
								|| !PropertyUtils.isWriteable(model,
										sPropertyName))
							continue;
					} catch (Exception e) {
						continue;
					}
				}
				// ??????Map?????????????????????CoreService????????????
				if ("mechanismMap".equals(sPropertyName)) {
					continue;
				}
				// ?????? ???????????????????????????????????????????????????
				if ("customPropMap".equals(sPropertyName)) {
					ICoreOuterService dynamicAttributeService = (ICoreOuterService) SpringBeanUtil
							.getBean("dynamicAttributeService");
					dynamicAttributeService.convertFormToModel(form, model,
							context.getRequestContext());
					continue;
				}
				IFormToModelConvertor convertor = new FormConvertor_Common(
						sPropertyName);
				convertorContext.setSPropertyName(sPropertyName);
				convertor.excute(convertorContext);
				if (logger.isDebugEnabled())
					logger.debug("????????????" + form.getClass().getName() + "???Form."
							+ sPropertyName + "->Model."
							+ convertor.getTPropertyName() + "???"
							+ convertor.getClass().getName() + "??????");
			}
			// ????????????????????????
			for (int i = 0; i < propertyList.size(); i++) {
				sPropertyName = (String) propertyList.get(i);
				Object propertyInfo = propertyMap.get(sPropertyName);
				if (propertyInfo == null)
					continue;
				IFormToModelConvertor convertor;
				if (propertyInfo instanceof IFormToModelConvertor)
					convertor = (IFormToModelConvertor) propertyInfo;
				else
					convertor = new FormConvertor_Common((String) propertyInfo);
				convertorContext.setSPropertyName(sPropertyName);
				//???????????????????????????????????????
				IUserOper logOper = convertorContext.getLogOper();
				String logType = convertorContext.getLogType();
				//convert
				convertor.excute(convertorContext);
				//??????convert???????????????????????????????????????
				convertorContext.setLogOper(logOper);
				convertorContext.setLogType(logType);
				if (logger.isDebugEnabled())
					logger.debug("????????????" + form.getClass().getName() + "???Form."
							+ sPropertyName + "->Model."
							+ convertor.getTPropertyName() + "???"
							+ convertor.getClass().getName() + "??????");
			}
			TimeCounter.logCurrentTime("service-convertFormToModel", false,
					form.getClass());
		} catch (Exception e) {
			logger.error("??????Form?????????" + sPropertyName + "???????????????", e);
			if (sPropertyName == null)
				throw new FormModelConvertException(e);
			else
				throw new FormModelConvertException(sPropertyName, e);
		}
		return model;
	}

	public final IBaseModel convertFormToModel(IExtendForm form,
			IBaseModel model, ConvertorContext context) throws Exception {
		model = convertBizFormToModel(form, model, context);
		if (dispatchCoreService != null)
			dispatchCoreService.convertFormToModel(form, model, context
					.getRequestContext());
		// ????????????????????????
		if (model instanceof ISysRecycleModel) {
			ISysRecycleModel recycleModel = (ISysRecycleModel) model;
			// ???????????????????????????
			if (recycleModel.getDocDeleteFlag() == null) {
				// ???????????????????????????
				recycleModel.setDocDeleteFlag(SysRecycleConstant.OPT_TYPE_RECOVER);
			}
		}
		return model;
	}

	/**
	 * <pre>
	 * ??????????????????????????????????????????????????????{@link ConvertorContext}???????????????????????????????????????
	 * ???????????????????????????????????????????????????<b>super.</b>{@link #convertFormToModel(IExtendForm, IBaseModel, RequestContext)}
	 * </pre>
	 */
	public IBaseModel convertFormToModel(IExtendForm form, IBaseModel model,
			RequestContext requestContext) throws Exception {
		ConvertorContext context = new ConvertorContext();
		context.setBaseService(this);
		context.setObjMap(new HashMap());
		context.setRequestContext(requestContext);
		//???????????????????????????????????????????????????????????????????????????
		if(requestContext.getAttribute(ICoreOuterService.CORE_SERVICE_LOG_OPER_KEY)!=null){
		    context.setLogOper((IUserOper)requestContext.getAttribute(ICoreOuterService.CORE_SERVICE_LOG_OPER_KEY));
		}
		if(requestContext.getAttribute(ICoreOuterService.CORE_SERVICE_LOGTYPE_KEY)!=null){
		    context.setLogType((String)requestContext.getAttribute(ICoreOuterService.CORE_SERVICE_LOGTYPE_KEY));
		}
		return convertFormToModel(form, model, context);
	}

	protected IExtendForm convertBizModelToForm(IExtendForm form,
			IBaseModel model, ConvertorContext context) throws Exception {
		String sPropertyName = null;
		try {
			if (model == null)
				return null;
			TimeCounter.logCurrentTime("service-convertModelToForm", true,
					model.getClass());
			Map objMap = context.getObjMap();
			if (objMap.containsKey(model))
				return (IExtendForm) objMap.get(model);
			// ????????????Form??????
			if (form == null)
				form = (IExtendForm) model.getFormClass().newInstance();
			objMap.put(model, form);
			ConvertorContext convertorContext = new ConvertorContext(context);
			convertorContext.setSObject(model);
			convertorContext.setTObject(form);
			// ?????????????????????
			Map propertyMap = model.getToFormPropertyMap().getPropertyMap();
			List propertyList = model.getToFormPropertyMap().getPropertyList();
			// ?????????????????????????????????????????????????????????
			PropertyDescriptor[] sProperties = PropertyUtils
					.getPropertyDescriptors(model);
			for (int i = 0; i < sProperties.length; i++) {
				sPropertyName = sProperties[i].getName();
				if (propertyMap.containsKey(sPropertyName)) {
					continue;
				} else {
					try {
						if (!PropertyUtils.isReadable(model, sPropertyName)
								|| !PropertyUtils.isWriteable(form,
										sPropertyName))
							continue;
					} catch (Exception e) {
						continue;
					}
				}

				// ??????Map?????????????????????CoreService????????????
				if ("mechanismMap".equals(sPropertyName)) {
					continue;
				}

				if ("dynamicMap".equals(sPropertyName)) {
					Map<String, String> dynamicMap_model = model
							.getDynamicMap();
					Map<String, String> dynamicMap_form = form.getDynamicMap();
					if (dynamicMap_model != null && dynamicMap_form != null) {
						dynamicMap_form.putAll(dynamicMap_model);
					}
				} else {
					IModelToFormConvertor convertor = new ModelConvertor_Common(
							sPropertyName);
					convertorContext.setSPropertyName(sPropertyName);
					convertor.excute(convertorContext);

					if (logger.isDebugEnabled())
						logger.debug("????????????" + model.getClass().getName()
								+ "???Model." + sPropertyName + "->Form."
								+ convertor.getTPropertyName() + "???"
								+ convertor.getClass().getName() + "??????");
				}
			}
			// ????????????????????????
			for (int i = 0; i < propertyList.size(); i++) {
				sPropertyName = (String) propertyList.get(i);
				IModelToFormConvertor convertor;
				Object propertyInfo = propertyMap.get(sPropertyName);
				if (propertyInfo == null)
					continue;
				if (propertyInfo instanceof IModelToFormConvertor)
					convertor = (IModelToFormConvertor) propertyInfo;
				else
					convertor = new ModelConvertor_Common((String) propertyInfo);
				convertorContext.setSPropertyName(sPropertyName);
				convertor.excute(convertorContext);
				if (logger.isDebugEnabled())
					logger.debug("????????????" + model.getClass().getName()
							+ "???Model." + sPropertyName + "->Form."
							+ convertor.getTPropertyName() + "???"
							+ convertor.getClass().getName() + "??????");
			}
			TimeCounter.logCurrentTime("service-convertModelToForm", false,
					model.getClass());
		} catch (Exception e) {
			logger.error("??????Model?????????" + sPropertyName + "???????????????", e);
			if (sPropertyName == null)
				throw new FormModelConvertException(e);
			else
				throw new FormModelConvertException(sPropertyName, e);
		}
		return form;
	}

	public final IExtendForm convertModelToForm(IExtendForm form,
			IBaseModel model, ConvertorContext context) throws Exception {
		form = convertBizModelToForm(form, model, context);
		if (dispatchCoreService != null) {
			if (context.getIsClone()) {
				form.setFdId(IDGenerator.generateID());
				dispatchCoreService.cloneModelToForm(form, model, context
						.getRequestContext());
			} else
				dispatchCoreService.convertModelToForm(form, model, context
						.getRequestContext());
		}
		return form;
	}

	public IExtendForm convertModelToForm(IExtendForm form, IBaseModel model,
			RequestContext requestContext) throws Exception {
		ConvertorContext context = new ConvertorContext();
		context.setBaseService(this);
		context.setObjMap(new HashMap());
		context.setRequestContext(requestContext);
		return convertModelToForm(form, model, context);
	}

	public void delete(IBaseModel modelObj) throws Exception {
		UserOperHelper.logDelete(modelObj);
		// huangwq ????????????????????????
		String modelClassName = ModelUtil.getModelClassName(modelObj);
		if (SysRecycleUtil
				.isEnableSoftDelete(modelClassName)) {
			deleteSoft(modelObj);
			return;
		}
		if (dispatchCoreService != null)
			dispatchCoreService.delete(modelObj);
		getBaseDao().delete(modelObj);
	}

	public void deleteSoft(IBaseModel modelObj) throws Exception {
		if (dispatchCoreService != null)
			dispatchCoreService.deleteSoft(modelObj);

		// ?????????????????????
		if (modelObj instanceof ISysRecycleModel) {
			ISysRecycleModel recycleModel = (ISysRecycleModel) modelObj;
			// ??????????????????
			recycleModel.setDocDeleteFlag(SysRecycleConstant.OPT_TYPE_SOFTDELETE);
			// ????????????
			recycleModel.setDocDeleteTime(new Date());
			// ?????????
			recycleModel.setDocDeleteBy(UserUtil.getUser());
		}
		// ??????????????????????????????
		updateLastModifiedTime(modelObj);
		getBaseDao().update(modelObj);
		
		// ??????????????????????????????????????? ???????????? ????????? ????????????
		ISysNotifyTodoService sysNotifyTodoService = (ISysNotifyTodoService) SpringBeanUtil.getBean("sysNotifyTodoService");
		List<?> todos = sysNotifyTodoService.getCoreModels(modelObj, null, null, null);
		for (int i = 0; i < todos.size(); i++) {
			SysNotifyTodo todo = (SysNotifyTodo) todos.get(i);
			sysNotifyTodoService.setTodoDone(todo);
		}

		ISysRecycleLogService sysRecycleLogService = (ISysRecycleLogService) SpringBeanUtil.getBean("sysRecycleLogService");
		sysRecycleLogService.addRecycleLog(modelObj,SysRecycleConstant.OPT_TYPE_SOFTDELETE);
	}

	public void deleteHard(IBaseModel modelObj) throws Exception {
		//?????????????????????????????????????????????????????????????????????????????????session???????????? ??????2020-3-7
		if(modelObj!=null&&modelObj.getFdId()!=null) {
			
			/**
			 * ??????service?????????dao?????????getBaseDao().getModelName()???null;
			 * ??????????????????????????????????????????model
			 */
			IBaseModel modelTemp=null;
			if(getBaseDao().getModelName()!=null) {
				 modelTemp=getBaseDao().findByPrimaryKey(modelObj.getFdId());
			}else {
				logger.warn("getBaseDao().getModelName() is null");
				modelTemp=modelObj; 
			}
			
			
			UserOperHelper.logDelete(modelTemp);
			
			if (dispatchCoreService != null)
				dispatchCoreService.delete(modelTemp);
			getBaseDao().delete(modelTemp);

			ISysRecycleLogService sysRecycleLogService = (ISysRecycleLogService) SpringBeanUtil
					.getBean("sysRecycleLogService");
			sysRecycleLogService.addRecycleLog(modelTemp,
					SysRecycleConstant.OPT_TYPE_HARDDELETE);
		}
	}

	public final void delete(String id) throws Exception {
		delete(findByPrimaryKey(id));
	}

	public final void delete(String[] ids) throws Exception {
		for (int i = 0; i < ids.length; i++) {
			if (i > 0)
				flushHibernateSession();
			delete(ids[i]);
		}
	}

	public final void deleteHard(String[] ids) throws Exception {
		for (int i = 0; i < ids.length; i++) {
			if (i > 0)
				flushHibernateSession();
			deleteHard(findByPrimaryKey(ids[i]));
		}
	}

	public final void update2Recover(String[] ids) throws Exception {
		for (int i = 0; i < ids.length; i++) {
			if (i > 0)
				flushHibernateSession();
			update2Recover(findByPrimaryKey(ids[i]));
		}
	}

	public void update2Recover(IBaseModel modelObj) throws Exception {
		if (modelObj instanceof ISysRecycleModel) {
			ISysRecycleModel recycleModel = (ISysRecycleModel) modelObj;
			if (UserOperHelper.allowLogOper("Service_Update",
					ModelUtil.getModelClassName(modelObj))) {
				UserOperContentHelper.putUpdate(modelObj)
						.putSimple("docDeleteFlag",
								recycleModel.getDocDeleteFlag(),
								SysRecycleConstant.OPT_TYPE_RECOVER)
						.putSimple("docDeleteTime",
								recycleModel.getDocDeleteTime(), null)
						.putSimple("docDeleteBy", recycleModel.getDocDeleteBy(),
								null);
			}
			// ??????????????????
			recycleModel.setDocDeleteFlag(SysRecycleConstant.OPT_TYPE_RECOVER);
			// ??????????????????
			recycleModel.setDocDeleteTime(null);
			// ???????????????
			recycleModel.setDocDeleteBy(null);
		}
		// ??????????????????????????????
		updateLastModifiedTime(modelObj);
		getBaseDao().update(modelObj);

		if (dispatchCoreService != null)
			dispatchCoreService.update2Recover(modelObj);

		ISysRecycleLogService sysRecycleLogService = (ISysRecycleLogService) SpringBeanUtil
				.getBean("sysRecycleLogService");
		sysRecycleLogService.addRecycleLog(modelObj,
				SysRecycleConstant.OPT_TYPE_RECOVER);
	}

	/**
	 * ????????????????????????
	 * 
	 * ???????????????????????????????????????????????????????????????????????????????????????????????????????????????design.xml??????ftSearch???????????????timeField?????????????????????
	 * 
	 * @param modelObj
	 */
	private void updateLastModifiedTime(IBaseModel modelObj) throws Exception {
		// ???ModelName
		String modelName = ModelUtil.getModelClassName(modelObj);
		if (StringUtil.isNull(modelName)) {
			return;
		}
		// ??????????????????????????????
		SysCfgFtSearch search = (SysCfgFtSearch) SysConfigs.getInstance().getFtSearchs().get(modelName);
		if (search != null) {
			// ?????????????????????????????????????????????
			String timeField = search.getTimeField();
			if (StringUtil.isNotNull(timeField)) {
				// ??????model??????????????????(????????????????????????)
				if (PropertyUtils.isWriteable(modelObj, timeField)) {
					// ???????????????
					PropertyUtils.setProperty(modelObj, timeField, new Date());
				}
			}
		}
	}

	public void flushHibernateSession() {
		getBaseDao().flushHibernateSession();
	}

	public IBaseModel findByPrimaryKey(String id) throws Exception {
		return getBaseDao().findByPrimaryKey(id);
	}

	public IBaseModel findByPrimaryKey(String id, Object modelInfo,
			boolean noLazy) throws Exception {
		return getBaseDao().findByPrimaryKey(id, modelInfo, noLazy);
	}

	public List findByPrimaryKeys(String[] ids) throws Exception {
		return getBaseDao().findByPrimaryKeys(ids);
	}

	public List findList(HQLInfo hqlInfo) throws Exception {
		return getBaseDao().findList(hqlInfo);
	}

	public List findList(String whereBlock, String orderBy) throws Exception {
		return getBaseDao().findList(whereBlock, orderBy);
	}

	public Page findPage(HQLInfo hqlInfo) throws Exception {
		return getBaseDao().findPage(hqlInfo);
	}

	public Page findPage(String whereBlock, String orderBy, int pageno,
			int rowsize) throws Exception {
		return getBaseDao().findPage(whereBlock, orderBy, pageno, rowsize);
	}

	public List findValue(HQLInfo hqlInfo) throws Exception {
		return getBaseDao().findValue(hqlInfo);
	}

	public List findValue(String selectBlock, String whereBlock, String orderBy)
			throws Exception {
		return getBaseDao().findValue(selectBlock, whereBlock, orderBy);
	}

	public IBaseDao getBaseDao() {
		return baseDao;
	}

	public String getModelName() {
		return getBaseDao().getModelName();
	}

	public void setBaseDao(IBaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public final void setDispatchCoreService(ICoreOuterService coreService) {
		this.dispatchCoreService = coreService;
	}

	public void update(IBaseModel modelObj) throws Exception {
		getBaseDao().update(modelObj);
		if (dispatchCoreService != null)
			dispatchCoreService.update(modelObj);
	}

	public void update(IExtendForm form, RequestContext requestContext)
			throws Exception {
		String modelName = form.getModelClass().getName();
		modelName = StringUtil.isNotNull(modelName) ? modelName : getModelName();
		UserOperHelper.logUpdate(modelName);
		IBaseModel model = convertFormToModel(form, null, requestContext);
		update(model);
	}

	public void clearHibernateSession() {
		getBaseDao().clearHibernateSession();
	}
}
