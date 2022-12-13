package com.landray.kmss.geesun.base.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;
import java.util.Date;
import com.landray.kmss.geesun.base.dao.IGeesunBaseProjectDao;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.base.model.GeesunBaseProject;
import com.landray.kmss.common.dao.BaseDaoImp;

/**
  * 项目号信息 Dao层实现
  */
public class GeesunBaseProjectDaoImp extends BaseDaoImp implements IGeesunBaseProjectDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunBaseProject geesunBaseProject = (GeesunBaseProject) modelObj;
        if (geesunBaseProject.getDocCreator() == null) {
            geesunBaseProject.setDocCreator(UserUtil.getUser());
        }
        if (geesunBaseProject.getDocCreateTime() == null) {
            geesunBaseProject.setDocCreateTime(new Date());
        }
        return super.add(geesunBaseProject);
    }
}
