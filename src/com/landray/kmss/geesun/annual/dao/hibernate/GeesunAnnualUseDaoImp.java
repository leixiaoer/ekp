package com.landray.kmss.geesun.annual.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;
import java.util.Date;
import com.landray.kmss.geesun.annual.dao.IGeesunAnnualUseDao;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.annual.model.GeesunAnnualUse;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunAnnualUseDaoImp extends BaseDaoImp implements IGeesunAnnualUseDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunAnnualUse geesunAnnualUse = (GeesunAnnualUse) modelObj;
        if (geesunAnnualUse.getDocCreator() == null) {
            geesunAnnualUse.setDocCreator(UserUtil.getUser());
        }
        if (geesunAnnualUse.getDocCreateTime() == null) {
            geesunAnnualUse.setDocCreateTime(new Date());
        }
        return super.add(geesunAnnualUse);
    }
}
