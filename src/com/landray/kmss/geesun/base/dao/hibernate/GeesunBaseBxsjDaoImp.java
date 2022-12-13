package com.landray.kmss.geesun.base.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;
import java.util.Date;
import com.landray.kmss.geesun.base.dao.IGeesunBaseBxsjDao;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.base.model.GeesunBaseBxsj;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunBaseBxsjDaoImp extends BaseDaoImp implements IGeesunBaseBxsjDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunBaseBxsj geesunBaseBxsj = (GeesunBaseBxsj) modelObj;
        if (geesunBaseBxsj.getDocCreator() == null) {
            geesunBaseBxsj.setDocCreator(UserUtil.getUser());
        }
        if (geesunBaseBxsj.getDocCreateTime() == null) {
            geesunBaseBxsj.setDocCreateTime(new Date());
        }
        return super.add(geesunBaseBxsj);
    }
}
