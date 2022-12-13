package com.landray.kmss.geesun.base.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;
import java.util.Date;
import com.landray.kmss.geesun.base.dao.IGeesunBasePayDao;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.base.model.GeesunBasePay;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunBasePayDaoImp extends BaseDaoImp implements IGeesunBasePayDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunBasePay geesunBasePay = (GeesunBasePay) modelObj;
        if (geesunBasePay.getDocCreator() == null) {
            geesunBasePay.setDocCreator(UserUtil.getUser());
        }
        if (geesunBasePay.getDocCreateTime() == null) {
            geesunBasePay.setDocCreateTime(new Date());
        }
        return super.add(geesunBasePay);
    }
}
