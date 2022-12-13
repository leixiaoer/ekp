package com.landray.kmss.geesun.oitems.transfer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.sys.admin.transfer.constant.ISysAdminTransferConstant;
import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferChecker;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckResult;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferResult;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOitemsWarehousingRecordJoinListTask
		implements ISysAdminTransferChecker, ISysAdminTransferTask {

	protected final Log logger = LogFactory.getLog(getClass());

	public void doTransfer() throws SQLException {
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Connection conn = dataSource.getConnection();
		ResultSet rs_select = null;
		PreparedStatement ps_insert = null;
		PreparedStatement ps_select = null;
		ResultSet rs = null;
		try {
			rs = conn.getMetaData().getTables(null, null,
					"geesun_oitems_warehousing_Joinlist", null);
			if (rs != null && rs.next()) {
				ps_insert = conn.prepareStatement(
						"insert into geesun_oitems_warehousing_joinlist(fd_id,fd_number,fd_cur_number,fd_brand,fd_price,fd_listing_id,doc_creator_id) values(?,?,?,?,?,?,?)");
				ps_select = conn.prepareStatement(
						"select * from geesun_oitems_warehousing_Joinlist");
				rs_select = ps_select.executeQuery();
				while (rs_select.next()) {
					ps_insert.setString(1, rs_select.getString("fd_id"));
					ps_insert.setInt(2, rs_select.getInt("fd_number"));
					ps_insert.setInt(3, rs_select.getInt("fd_cur_number"));
					ps_insert.setString(4, rs_select.getString("fd_brand"));
					ps_insert.setDouble(5, rs_select.getDouble("fd_price"));
					ps_insert.setString(6,
							rs_select.getString("fd_listing_id"));
					ps_insert.setString(7,
							rs_select.getString("doc_creator_id"));
					ps_insert.addBatch();
				}
				ps_insert.executeBatch();
			}
		} catch (SQLException e) {
			logger.error("执行旧数据迁移为空异常", e);
			conn.rollback();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 关闭流
			JdbcUtils.closeResultSet(rs_select);
			JdbcUtils.closeResultSet(rs);
			JdbcUtils.closeStatement(ps_select);
			JdbcUtils.closeStatement(ps_insert);
			JdbcUtils.closeConnection(conn);
		}
	}

	@Override
	public SysAdminTransferResult
			run(SysAdminTransferContext sysAdminTransferContext) {
		try {
			String uuid = sysAdminTransferContext.getUUID();
			ISysAdminTransferTaskService sysAdminTransferTaskService = (ISysAdminTransferTaskService) SpringBeanUtil
					.getBean("sysAdminTransferTaskService");
			List sysAdminTransferList = new ArrayList();
			sysAdminTransferList = sysAdminTransferTaskService.getBaseDao()
					.findValue(null,
							"sysAdminTransferTask.fdUuid='" + uuid + "'", null);
			SysAdminTransferTask sysAdminTransferTask = (SysAdminTransferTask) sysAdminTransferList
					.get(0);
			if (sysAdminTransferTask.getFdStatus() != 1) {
				doTransfer();
			}
		} catch (Exception e) {
			logger.error("执行旧数据迁移为空异常", e);
			return new SysAdminTransferResult(
					ISysAdminTransferConstant.TASK_STATUS_NOT_RUNED,
					e.getLocalizedMessage(),
					e);
		}
		return SysAdminTransferResult.OK;
	}

	@Override
	public SysAdminTransferCheckResult
			check(SysAdminTransferCheckContext sysAdminTransferCheckContext) {
		try {
			IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService = (IGeesunOitemsWarehousingRecordJoinListService) SpringBeanUtil
					.getBean("geesunOitemsWarehousingRecordJoinListService");
			String hql1 = "select count(*) from  GeesunOitemsWarehousingRecordJoinList where 1=1";
			Query q1 = geesunOitemsWarehousingRecordJoinListService.getBaseDao()
					.getHibernateSession()
					.createQuery(hql1);
			Long count1 = (Long) q1.uniqueResult();
			if (count1 == 0) {
				return SysAdminTransferCheckResult.TASK_STATUS_NOT_RUNED;
			}
		} catch (Exception e) {
			logger.error(e);
		}
		return SysAdminTransferCheckResult.TASK_STATUS_RUNED;
	}

}
