package com.landray.kmss.geesun.org.dao.hibernate;

import java.util.Date;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.org.dao.IGeesunOrgPostDao;
import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.geesun.org.model.GeesunOrgPost;

public class GeesunOrgPostDaoImp extends BaseDaoImp implements IGeesunOrgPostDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunOrgPost geesunOrgPost = (GeesunOrgPost) modelObj;
        if (geesunOrgPost.getDocCreateTime() == null) {
            geesunOrgPost.setDocCreateTime(new Date());
        }
        return super.add(geesunOrgPost);
    }
}
