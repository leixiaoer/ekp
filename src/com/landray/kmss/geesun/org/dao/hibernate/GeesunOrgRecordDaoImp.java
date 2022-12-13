package com.landray.kmss.geesun.org.dao.hibernate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.org.dao.IGeesunOrgRecordDao;
import com.landray.kmss.geesun.org.model.GeesunOrgRecord;

public class GeesunOrgRecordDaoImp extends BaseDaoImp implements IGeesunOrgRecordDao {

	private static final Log logger = LogFactory.getLog(GeesunOrgRecordDaoImp.class);
	
	private final int batchCount = 1000;
	
    public String add(IBaseModel modelObj) throws Exception {
        GeesunOrgRecord geesunOrgRecord = (GeesunOrgRecord) modelObj;
        if (geesunOrgRecord.getDocCreateTime() == null) {
            geesunOrgRecord.setDocCreateTime(new Date());
        }
        return super.add(geesunOrgRecord);
    }
    
    public void addRecordMiddle(DataSource dataSource, JSONArray organArray, 
			JSONArray personArray, JSONArray postArray) throws Exception {
		Connection connect = null;
		PreparedStatement insertSql = null;
		List<GeesunOrgRecord> recordList = new ArrayList<GeesunOrgRecord>();
		Calendar c = Calendar.getInstance();
		try {
			for (int i = 0; i < organArray.size(); i++) {
				GeesunOrgRecord record = new GeesunOrgRecord();
				JSONObject organ = organArray.getJSONObject(i);
				record.setObjid(null!=organ.getBigDecimal("OBJID")?organ.getBigDecimal("OBJID").toString():"");
				record.setStext(organ.getString("STEXT"));
				record.setObjidUp((null!=organ.getBigDecimal("OBJID_UP"))?organ.getBigDecimal("OBJID_UP").toString():"");
				record.setObjidSUp((null!=organ.getBigDecimal("OBJID_S_UP"))?organ.getBigDecimal("OBJID_S_UP").toString():"");
				record.setZsfyx(organ.getString("ZSFYX"));
				record.setZhrOmJglx(organ.getString("ZHR_OM_JGLX"));
				record.setPriox(null!=organ.getBigDecimal("PRIOX")?organ.getBigDecimal("PRIOX").toString():"");
				record.setZzDatum(organ.getString("ZZ_DATUM"));
				record.setFdOrganType("dpet");
				recordList.add(record);
			}
			for (int i = 0; i < personArray.size(); i++) {
				GeesunOrgRecord record = new GeesunOrgRecord();
				JSONObject person = personArray.getJSONObject(i);
				record.setPernr(null!=person.getBigDecimal("PERNR")?person.getBigDecimal("PERNR").toString():"");
				record.setNachn(person.getString("NACHN"));
				record.setVnamc(person.getString("VNAMC"));
				record.setOrgeh(null!=person.getBigDecimal("ORGEH")?person.getBigDecimal("ORGEH").toString():"");
				record.setPlans01(null!=person.getBigDecimal("PLANS_01")?person.getBigDecimal("PLANS_01").toString():"");
				record.setPlans02(person.getString("PLANS_02"));
				record.setPhone(person.getString("PHONE"));
				record.setEmail(person.getString("EMAIL"));
				record.setCall(person.getString("CALL"));
				record.setWxid(person.getString("WXID"));
				record.setZhrOmGwzj(person.getString("ZHR_OM_GWZJ"));
				record.setZhrOmGwzd(person.getString("ZHR_OM_GWZD"));
				record.setZsfyx(person.getString("ZSFYX"));
				record.setGender(person.getString("GENDER"));
				record.setIcnum(person.getString("ICNUM"));
				record.setZzDatum(person.getString("ZZ_DATUM"));
				record.setFdOrganType("person");
				recordList.add(record);
			}
			for (int i = 0; i < postArray.size(); i++) {
				GeesunOrgRecord record = new GeesunOrgRecord();
				JSONObject post = postArray.getJSONObject(i);
				record.setObjid((null!=post.getBigDecimal("OBJID"))?post.getBigDecimal("OBJID").toString():"");
				record.setStext(post.getString("STEXT"));
				record.setObjidUp((null!=post.getBigDecimal("OBJID_UP"))?post.getBigDecimal("OBJID_UP").toString():"");
				record.setObjidSUp((null!=post.getBigDecimal("OBJID_S_UP"))?post.getBigDecimal("OBJID_S_UP").toString():"");
				record.setZsfyx(post.getString("ZSFYX"));
				record.setPriox((null!=post.getBigDecimal("PRIOX"))?post.getBigDecimal("PRIOX").toString():"");
				record.setZzDatum(post.getString("ZZ_DATUM"));
				record.setFdOrganType("post");
				recordList.add(record);
			}
			connect = dataSource.getConnection();
			connect.setAutoCommit(false);
			long loop = 0;
			insertSql = connect
					.prepareStatement("insert into geesun_org_record(fd_id, stext, objid_up, objid, priox, zsfyx, zhr_om_jglx, zz_datum, objid_s_up, "
							+ "begda, nachn, phone, gbdat, call_ekp, gender, wxid, pernr, plans_02, email, zhr_om_gwzd, plans_01, zhr_om_gwzj, vnamc, orgeh, icnum, doc_create_time, fd_organ_type)"
							+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			for (int i = 0; i < recordList.size(); i++) {
				if (loop > 0 && (loop % batchCount == 0)) {
					insertSql.executeBatch();
					connect.commit();
					logger.debug("第" + loop / batchCount
									+ "批次提交基础架构组织数据.");
				}
				GeesunOrgRecord record = recordList.get(i);
				insertSql.setString(1, record.getFdId());
				insertSql.setString(2, record.getStext());
				insertSql.setString(3, record.getObjidUp());
				insertSql.setString(4, record.getObjid());
				insertSql.setString(5, record.getPriox());
				insertSql.setString(6, record.getZsfyx());
				insertSql.setString(7, record.getZhrOmJglx());
				insertSql.setString(8, record.getZzDatum());
				insertSql.setString(9, record.getObjidSUp());
				insertSql.setString(10, record.getBegda());
				insertSql.setString(11, record.getNachn());
				insertSql.setString(12, record.getPhone());
				insertSql.setString(13, record.getGbdat());
				insertSql.setString(14, record.getCall());
				insertSql.setString(15, record.getGender());
				insertSql.setString(16, record.getWxid());
				insertSql.setString(17, record.getPernr());
				insertSql.setString(18, record.getPlans02());
				insertSql.setString(19, record.getEmail());
				insertSql.setString(20, record.getZhrOmGwzd());
				insertSql.setString(21, record.getPlans01());
				insertSql.setString(22, record.getZhrOmGwzj());
				insertSql.setString(23, record.getVnamc());
				insertSql.setString(24, record.getOrgeh());
				insertSql.setString(25, record.getIcnum());
				insertSql.setTimestamp(26, new java.sql.Timestamp(c.getTimeInMillis()));
				insertSql.setString(27, record.getFdOrganType());
				insertSql.addBatch();
				loop++;
			}
			logger.debug("新增数据" + loop + "条.");
			insertSql.executeBatch();
			connect.commit();
			logger.debug("批量处理完毕.");
		} catch (SQLException ex) {
			connect.rollback();
			throw ex;
		} finally {
			JdbcUtils.closeStatement(insertSql);
			JdbcUtils.closeConnection(connect);
		}
	}
    
}
