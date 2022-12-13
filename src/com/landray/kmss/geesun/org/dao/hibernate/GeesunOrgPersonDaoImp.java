package com.landray.kmss.geesun.org.dao.hibernate;

import java.util.Date;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.org.dao.IGeesunOrgPersonDao;
import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.geesun.org.model.GeesunOrgPerson;

public class GeesunOrgPersonDaoImp extends BaseDaoImp implements IGeesunOrgPersonDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunOrgPerson geesunOrgPerson = (GeesunOrgPerson) modelObj;
        if (geesunOrgPerson.getDocCreateTime() == null) {
            geesunOrgPerson.setDocCreateTime(new Date());
        }
        return super.add(geesunOrgPerson);
    }
}
