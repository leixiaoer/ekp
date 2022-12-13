package com.landray.kmss.geesun.base.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;
import java.util.Date;
import com.landray.kmss.geesun.base.dao.IGeesunBaseAccountDao;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.base.model.GeesunBaseAccount;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunBaseAccountDaoImp extends BaseDaoImp implements IGeesunBaseAccountDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunBaseAccount geesunBaseAccount = (GeesunBaseAccount) modelObj;
        if (geesunBaseAccount.getDocCreator() == null) {
            geesunBaseAccount.setDocCreator(UserUtil.getUser());
        }
        if (geesunBaseAccount.getDocCreateTime() == null) {
            geesunBaseAccount.setDocCreateTime(new Date());
        }
        return super.add(geesunBaseAccount);
    }
}
