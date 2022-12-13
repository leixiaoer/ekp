package com.landray.kmss.geesun.base.service.spring;

import java.util.Date;
import java.util.List;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.base.model.GeesunBaseAccount;
import com.landray.kmss.geesun.base.service.IGeesunBaseAccountService;
import com.landray.kmss.geesun.base.util.GeesunBaseUtil;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;

public class GeesunBaseAccountServiceImp extends ExtendDataServiceImp implements IGeesunBaseAccountService {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunBaseAccount) {
            GeesunBaseAccount geesunBaseAccount = (GeesunBaseAccount) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunBaseAccount geesunBaseAccount = new GeesunBaseAccount();
        geesunBaseAccount.setDocCreateTime(new Date());
        geesunBaseAccount.setFdOwner(UserUtil.getUser());
        geesunBaseAccount.setDocCreator(UserUtil.getUser());
        GeesunBaseUtil.initModelFromRequest(geesunBaseAccount, requestContext);
        return geesunBaseAccount;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunBaseAccount geesunBaseAccount = (GeesunBaseAccount) model;
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
    
    /**
	 * 根据指定人员获取对应的账号信息
	 * @param person
	 * @return
	 * @throws Exception
	 */
	public GeesunBaseAccount getAccountByUser(SysOrgPerson 
			person) throws Exception {
		HQLInfo hql = new HQLInfo();
		hql.setWhereBlock("geesunBaseAccount.fdOwner.fdId=:fdOwnerId");
		hql.setParameter("fdOwnerId", person.getFdId());
		hql.setOrderBy("geesunBaseAccount.docCreateTime desc");
		List<GeesunBaseAccount> internalAccounts = this.findList(hql);
		if (!ArrayUtil.isEmpty(internalAccounts)) {
			return internalAccounts.get(0);
		}
		return null;
	}
	
}
