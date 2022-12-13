package com.landray.kmss.geesun.annual.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;
import java.util.Date;
import com.landray.kmss.geesun.annual.dao.IGeesunAnnualMainDao;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunAnnualMainDaoImp extends BaseDaoImp implements IGeesunAnnualMainDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunAnnualMain geesunAnnualMain = (GeesunAnnualMain) modelObj;
        if (geesunAnnualMain.getDocCreator() == null) {
            geesunAnnualMain.setDocCreator(UserUtil.getUser());
        }
        if (geesunAnnualMain.getDocCreateTime() == null) {
            geesunAnnualMain.setDocCreateTime(new Date());
        }
        return super.add(geesunAnnualMain);
    }
}
