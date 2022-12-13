package com.landray.kmss.geesun.base.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;
import java.util.Date;
import com.landray.kmss.geesun.base.dao.IGeesunBaseAuditDao;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.base.model.GeesunBaseAudit;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunBaseAuditDaoImp extends BaseDaoImp implements IGeesunBaseAuditDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunBaseAudit geesunBaseAudit = (GeesunBaseAudit) modelObj;
        if (geesunBaseAudit.getDocCreator() == null) {
            geesunBaseAudit.setDocCreator(UserUtil.getUser());
        }
        if (geesunBaseAudit.getDocCreateTime() == null) {
            geesunBaseAudit.setDocCreateTime(new Date());
        }
        return super.add(geesunBaseAudit);
    }
}
