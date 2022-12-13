package com.landray.kmss.geesun.annual.service.spring;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.annual.dao.IGeesunAnnualAlterDao;
import com.landray.kmss.geesun.annual.interfaces.IGeesunAnnualAlterForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualAlter;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualAlterService;
import com.landray.kmss.geesun.annual.util.AlterRecordUtil;
import com.landray.kmss.geesun.annual.util.ApplicationUtil;
import com.landray.kmss.geesun.annual.util.GeesunAnnualUtil;
import com.landray.kmss.geesun.annual.util.alterfield.AlterFieldRecord;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.sunbor.web.tag.Page;

public class GeesunAnnualAlterServiceImp extends ExtendDataServiceImp implements IGeesunAnnualAlterService {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunAnnualAlter) {
            GeesunAnnualAlter geesunAnnualAlter = (GeesunAnnualAlter) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunAnnualAlter geesunAnnualAlter = new GeesunAnnualAlter();
        geesunAnnualAlter.setDocCreateTime(new Date());
        geesunAnnualAlter.setDocCreator(UserUtil.getUser());
        GeesunAnnualUtil.initModelFromRequest(geesunAnnualAlter, requestContext);
        return geesunAnnualAlter;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunAnnualAlter geesunAnnualAlter = (GeesunAnnualAlter) model;
    }

    public List<GeesunAnnualAlter> findByFdAnnual(GeesunAnnualMain fdAnnual) throws Exception {
        HQLInfo hqlInfo = new HQLInfo();
        hqlInfo.setWhereBlock("geesunAnnualAlter.fdModelId=:fdId");
        hqlInfo.setParameter("fdId", fdAnnual.getFdId());
        return this.findList(hqlInfo);
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
    
    @Override
	public int getAlterRecordInfoCount(String modelId, String modelName) throws Exception {
		return ((IGeesunAnnualAlterDao) getBaseDao())
				.getAlterRecordInfoCount(modelId, modelName);
	}
    
    public int updateAlterFieldRecord(IGeesunAnnualAlterForm form,String source)
			throws Exception {
		IBaseModel srcModel = getBaseDao().findByPrimaryKey(form.getFdId(),
				form.getModelClass(), true);
		if (srcModel == null) {
			return 0;
		}
		IExtendForm srcForm = (IExtendForm) Class.forName(
				form.getClass().getName()).newInstance();
		RequestContext requestContext = new RequestContext();
		requestContext.setLocale(UserUtil.getKMSSUser().getLocale());
		convertModelToForm(srcForm, srcModel, requestContext);
		AlterRecordUtil recordUtil = new AlterRecordUtil(
				form.getAlterFieldXMLPath(), form.getAlterFieldXMLFieldsId());
		List<AlterFieldRecord> records = recordUtil.compare(srcForm, form);
		if (ArrayUtil.isEmpty(records)) {
			return 0;
		}
		List<GeesunAnnualAlter> geesunAnnualAlterRecords = new ArrayList<GeesunAnnualAlter>();
		for (AlterFieldRecord record : records) {
			GeesunAnnualAlter geesunAnnualAlter = new GeesunAnnualAlter();
			String fieldName = ApplicationUtil.getText(record.getText());
			if (StringUtil.isNull(fieldName)) {
				fieldName = record.getText();
			}
			geesunAnnualAlter.setFdFieldName(fieldName);
			geesunAnnualAlter
					.setFdBerforAlter(record.getValueBeforAlter() == null ? ""
							: record.getValueBeforAlter().toString());
			geesunAnnualAlter
					.setFdAfterAlter(record.getValueAfterAlter() == null ? ""
							: record.getValueAfterAlter().toString());
			geesunAnnualAlter.setDocCreateTime(new Date());
			geesunAnnualAlter.setDocCreator(UserUtil.getUser());
			geesunAnnualAlter.setFdModelName(form.getModelClass().getName());
			geesunAnnualAlter.setFdModelId(form.getFdId());
			geesunAnnualAlter.setFdSource(source);
			geesunAnnualAlterRecords.add(geesunAnnualAlter);
		}
		for (GeesunAnnualAlter geesunAnnualAlter : geesunAnnualAlterRecords) {
			add(geesunAnnualAlter);
		}
		return geesunAnnualAlterRecords.size();
	}
	/**
	 * 记录xml文件配置的字段修改记录
	 */
	public int updateAlterFieldRecord(IGeesunAnnualAlterForm form)
			throws Exception {
		return this.updateAlterFieldRecord(form, ResourceUtil.getString("geesunAnnualAlter.updateFormJsp", "geesun-annual"));
	}

	/**
	 * 根据主报销单Id查找修改记录
	 */
	public Page findAlterFieldRecord(RequestContext requestContext)
			throws Exception {
		String modelName = requestContext.getParameter("modelName");
		String modelId = requestContext.getParameter("modelId");
		String s_pageno = requestContext.getParameter("pageno");
		String s_rowsize = requestContext.getParameter("rowsize");
		String orderby = requestContext.getParameter("orderby");
		int pageno = 0;
		int rowsize = SysConfigParameters.getRowSize();
		if (s_pageno != null && s_pageno.length() > 0) {
			pageno = Integer.parseInt(s_pageno);
		}
		if (s_rowsize != null && s_rowsize.length() > 0) {
			rowsize = Integer.parseInt(s_rowsize);
		}
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setOrderBy(orderby);
		hqlInfo.setPageNo(pageno);
		hqlInfo.setRowSize(rowsize);
		hqlInfo.setOrderBy("docCreateTime desc");
		hqlInfo.setWhereBlock("fdModelName = :modelName and fdModelId = :modelId");
		hqlInfo.setParameter("modelName", modelName);
		hqlInfo.setParameter("modelId", modelId);
		return findPage(hqlInfo);
	}
	
	public int findAlterFieldRecordSize(RequestContext requestContext) throws Exception{
		String modelName = requestContext.getParameter("modelName");
		String modelId = requestContext.getParameter("modelId");
		if (modelName == null || modelId == null) {
			return 0;
		}
		String hql = "select count(k.fdId) from GeesunAnnualAlter k where k.fdModelName=:modelName and k.fdModelId =:modelId ";
		Query query = getBaseDao()
				.getHibernateSession().createQuery(hql);
		query.setParameter("modelName", modelName);
		query.setParameter("modelId", modelId);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
		 
	}
    
}
