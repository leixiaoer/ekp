package com.landray.kmss.geesun.annual.formula;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.component.dbop.ds.DataSet;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.formula.parser.FormulaParser;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.organization.service.ISysOrgPersonService;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunCheckPersonHasTrain {
	
	private static Log logger = LogFactory.getLog(GeesunCheckPersonHasTrain.class);
	
	private static ISysOrgPersonService sysOrgPersonService;
	
	public static ISysOrgPersonService getSysOrgPersonService() {
		if (sysOrgPersonService == null) {
			sysOrgPersonService = (ISysOrgPersonService) SpringBeanUtil.getBean("sysOrgPersonService");
		}
		return sysOrgPersonService;
	}
	
	private static ISysOrgElementService sysOrgElementService;
	
	public static ISysOrgElementService getSysOrgElementService() {
		if (sysOrgElementService == null) {
			sysOrgElementService = (ISysOrgElementService) SpringBeanUtil.getBean("sysOrgElementService");
		}
		return sysOrgElementService;
	}

	/**
	 * 根据数据源名称和人员ID查询人员是否有培训记录
	 * @param dbName
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public static boolean checkPersonHasTrain(String dbName, String personId) throws Exception {
		boolean flag = false;
		Object object = FormulaParser.getRunningData();
		if (object instanceof KmReviewMain) {
//			KmReviewMain apply = (KmReviewMain)FormulaParser.getRunningData();
			SysOrgPerson person = (SysOrgPerson) getSysOrgPersonService().findByPrimaryKey(personId, SysOrgPerson.class, true);
			if (null != person) {
				Map<String, Object> map = person.getCustomPropMap();
				String renyuanid = (String) map.get("renyuanid");
				DataSet dataSet = null;
				logger.warn("====>开始执行根据人员去HR库判断是否有打卡记录<====");
				ResultSet rs = null;
				try {
					dataSet = new DataSet(dbName);
					String sqlEkp = "select count(*) from V_HREduExternal "
							+ " where EID = ?";
					dataSet.prepareStatement(sqlEkp);
					dataSet.setString(1, renyuanid);
					rs = dataSet.executeQuery();
					if (rs.next() && rs.getLong(1) > 0) {
						flag = true;
					}
				} catch (Exception e) {
					logger.error(e);
				} finally {
					if (rs != null) {
						try {
							rs.close();
						} catch (SQLException e) {
							logger.error(e);
						}
					}
				}
			}
		}
		return flag;
	}
	
	/**
	 * 根据给定的组织ID获取到组织架构SysOrgElement对象
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public static SysOrgElement getOrganObjById(String id) throws Exception {
		return (SysOrgElement) getSysOrgElementService().findByPrimaryKey(id, SysOrgElement.class, true);
	}
	
}
