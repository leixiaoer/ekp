package com.landray.kmss.geesun.base.service.spring;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.fssc.base.model.FsscBaseBudgetScheme;
import com.landray.kmss.fssc.base.model.FsscBaseCompany;
import com.landray.kmss.fssc.base.service.IFsscBaseBudgetSchemeService;
import com.landray.kmss.fssc.base.service.IFsscBaseCompanyService;
import com.landray.kmss.geesun.annual.util.GeesunAnnualConstant;
import com.landray.kmss.geesun.base.service.IGeesunBaseBudgetAdjustMainService;
import com.landray.kmss.geesun.base.service.IGeesunBaseListenerFormService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataEvent;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataModel;
import com.landray.kmss.sys.metadata.interfaces.ISysMetadataParser;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 监听预算调整表单的增删改查事件初始化公司等信息及扣减预算
 * @author guoyp
 */
public class GeesunBaseBudgetListenerFormServiceImp implements IExtendDataEvent, 
	IGeesunBaseListenerFormService, GeesunAnnualConstant {
	
	private static final Log logger = LogFactory
			.getLog(GeesunBaseBudgetListenerFormServiceImp.class);
	
	private IFsscBaseCompanyService fsscBaseCompanyService;

	public IFsscBaseCompanyService getFsscBaseCompanyService() {
		if(fsscBaseCompanyService==null){
			fsscBaseCompanyService = (IFsscBaseCompanyService) SpringBeanUtil.getBean("fsscBaseCompanyService");
		}
		return fsscBaseCompanyService;
	}
	
	protected IFsscBaseBudgetSchemeService fsscBaseBudgetSchemeService;
	
	public IFsscBaseBudgetSchemeService getFsscBaseBudgetSchemeService() {
		if (null == fsscBaseBudgetSchemeService) {
			fsscBaseBudgetSchemeService = (IFsscBaseBudgetSchemeService) SpringBeanUtil
					.getBean("fsscBaseBudgetSchemeService");
		}
		return fsscBaseBudgetSchemeService;
	}
	
	protected IGeesunBaseBudgetAdjustMainService geesunBaseBudgetAdjustMainService;
	
	public IGeesunBaseBudgetAdjustMainService getGeesunBaseBudgetAdjustMainService() {
		if (null == geesunBaseBudgetAdjustMainService) {
			geesunBaseBudgetAdjustMainService = (IGeesunBaseBudgetAdjustMainService) SpringBeanUtil
					.getBean("geesunBaseBudgetAdjustMainService");
		}
		return geesunBaseBudgetAdjustMainService;
	}
	
	@Override
	public void onAdd(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		if (null != kmReviewMain) {
			if (!SysDocConstant.DOC_STATUS_DRAFT.equals(kmReviewMain.getDocStatus())) {
				// 根据明细信息将对应的预算进行冻结
				getGeesunBaseBudgetAdjustMainService().operationBudget(kmReviewMain, "create");
			}
		}
	}

	@Override
	public void onDelete(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
	}

	@Override
	public void onInit(RequestContext request, IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		SysOrgPerson person = UserUtil.getUser();
		//设置默认公司
        List<FsscBaseCompany> own = getFsscBaseCompanyService().findCompanyByUserId(person.getFdId());;
        if(!ArrayUtil.isEmpty(own)){
        	//根据公司获取预算方案
        	HQLInfo hql = new HQLInfo();
        	hql.setJoinBlock("left join fsscBaseBudgetScheme.fdCompanys companys");
        	hql.setWhereBlock("fsscBaseBudgetScheme.fdIsAvailable=:fdIsAvailable and companys.fdId=:companyId");
        	hql.setParameter("fdIsAvailable", Boolean.TRUE);
        	hql.setParameter("companyId", own.get(0).getFdId());
        	List<FsscBaseBudgetScheme> schemeList = getFsscBaseBudgetSchemeService().findList(hql);
        	if (!ArrayUtil.isEmpty(schemeList)) {
        		FsscBaseBudgetScheme budgetScheme = schemeList.get(0);
        		dataParser.setFieldValue(model, "fd_scheme_id", budgetScheme.getFdId());//预算方案
        	}
        	dataParser.setFieldValue(model, "fd_company_id", own.get(0).getFdId());//记账公司
    		dataParser.setFieldValue(model, "fd_currency_id", own.get(0).getFdAccountCurrency().getFdId());//币种ID
        }
	}
	
	@Override
	public void onUpdate(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		if(kmReviewMain!=null){
			// 如果进入待审状态，需要往费用明细表写入已占用的金额，将该费用冻结
			if (!SysDocConstant.DOC_STATUS_DRAFT.equals(kmReviewMain.getDocStatus()) && !SysDocConstant.DOC_STATUS_PUBLISH.equals(kmReviewMain.getDocStatus())
					&& !SysDocConstant.DOC_STATUS_DISCARD.equals(kmReviewMain.getDocStatus())) {
				// 重新对预算进行占用
				getGeesunBaseBudgetAdjustMainService().operationBudget(kmReviewMain, "update");
			}
		}
	}
	
	
}