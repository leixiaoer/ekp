package com.landray.kmss.geesun.org.dao.hibernate;

import java.util.Date;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.org.dao.IGeesunOrgOrganDao;
import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.geesun.org.model.GeesunOrgOrgan;

public class GeesunOrgOrganDaoImp extends BaseDaoImp implements IGeesunOrgOrganDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunOrgOrgan geesunOrgOrgan = (GeesunOrgOrgan) modelObj;
        if (geesunOrgOrgan.getDocCreateTime() == null) {
            geesunOrgOrgan.setDocCreateTime(new Date());
        }
        return super.add(geesunOrgOrgan);
    }
}
