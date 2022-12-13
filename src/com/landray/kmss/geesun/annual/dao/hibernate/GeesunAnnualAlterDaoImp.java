package com.landray.kmss.geesun.annual.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;

import java.util.Date;

import org.hibernate.Session;

import com.landray.kmss.geesun.annual.dao.IGeesunAnnualAlterDao;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.annual.model.GeesunAnnualAlter;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunAnnualAlterDaoImp extends BaseDaoImp implements IGeesunAnnualAlterDao {

    public String add(IBaseModel modelObj) throws Exception {
        GeesunAnnualAlter geesunAnnualAlter = (GeesunAnnualAlter) modelObj;
        if (geesunAnnualAlter.getDocCreator() == null) {
            geesunAnnualAlter.setDocCreator(UserUtil.getUser());
        }
        if (geesunAnnualAlter.getDocCreateTime() == null) {
            geesunAnnualAlter.setDocCreateTime(new Date());
        }
        return super.add(geesunAnnualAlter);
    }
    
    @Override
	public int getAlterRecordInfoCount(String modelId, String modelName) {
		String whereStr = " where geesunAnnualAlter.fdModelId = ? and geesunAnnualAlter.fdModelName = ?";
		Session session = this.getSession();
		int total = ((Long) session.createQuery(
				"select count(*) from com.landray.kmss.geesun.annual.model.GeesunAnnualAlter"
						+ " geesunAnnualAlter " + whereStr).setString(0, modelId).setString(1, modelName)
				.iterate().next())
						.intValue();
		return total;
	}
    
}
