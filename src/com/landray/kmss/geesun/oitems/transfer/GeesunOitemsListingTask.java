package com.landray.kmss.geesun.oitems.transfer;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferChecker;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckResult;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferResult;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOitemsListingTask
		implements ISysAdminTransferChecker, ISysAdminTransferTask {

	protected final Log logger = LogFactory.getLog(getClass());

	private void doTransfer() throws SQLException {
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Connection conn = dataSource.getConnection();
		Statement ps = conn.createStatement();
		try {
			String dialect = ResourceUtil
					.getKmssConfigString("hibernate.dialect").toLowerCase();
			if (dialect.indexOf("oracle") > 0 && conn.getMetaData().supportsBatchUpdates()) {
				ps.addBatch("ALTER TABLE geesun_oitems_listing MODIFY fd_reference_price NUMBER(38,2)");
				ps.addBatch("AlTER TABLE geesun_oitems_shopping_trolley MODIFY fd_reference_price NUMBER(38,2)");
				ps.addBatch(
						"ALTER TABLE geesun_oitems_warehousing_record MODIFY (fd_price NUMBER(38,2),fd_account_price NUMBER(38,2))");
				ps.addBatch("ALTER TABLE geesun_oitems_warehousing_joinlist MODIFY fd_price NUMBER(38,2)");
				ps.executeBatch();
			}
		} catch (SQLException e) {
			logger.error("执行旧数据迁移为空异常", e);
			conn.rollback();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 关闭流
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
	}

	@Override
	public SysAdminTransferResult
			run(SysAdminTransferContext sysAdminTransferContext) {
		String uuid = sysAdminTransferContext.getUUID();
		ISysAdminTransferTaskService sysAdminTransferTaskService = (ISysAdminTransferTaskService) SpringBeanUtil
				.getBean("sysAdminTransferTaskService");
		try {
			List list = new ArrayList();
			list = sysAdminTransferTaskService.getBaseDao().findValue(null,
					"sysAdminTransferTask.fdUuid='" + uuid + "'", null);
			SysAdminTransferTask sysAdminTransferTask = (SysAdminTransferTask) list
					.get(0);
			if (sysAdminTransferTask.getFdStatus() != 1) {
				doTransfer();
			}
		} catch (Exception e) {
			logger.error("执行旧数据迁移为空异常", e);
		}
		return SysAdminTransferResult.OK;
	}

	@Override
	public SysAdminTransferCheckResult
			check(SysAdminTransferCheckContext sysAdminTransferCheckContext) {
		try {
			ISysAdminTransferTaskService sysAdminTransferTaskService = (ISysAdminTransferTaskService) SpringBeanUtil
					.getBean("sysAdminTransferTaskService");
			String uuid = sysAdminTransferCheckContext.getUUID();
			List list = new ArrayList();
			list = sysAdminTransferTaskService.getBaseDao().findValue(null,
					"sysAdminTransferTask.fdUuid='" + uuid + "'", null);

			if (list.size() > 0) {
				SysAdminTransferTask sysAdminTransferTask = (SysAdminTransferTask) list
						.get(0);
				if (sysAdminTransferTask.getFdStatus() == 1) {
					return SysAdminTransferCheckResult.TASK_STATUS_RUNED;
				}
			}

		} catch (Exception e) {
			logger.error(e);
		}
		return SysAdminTransferCheckResult.TASK_STATUS_NOT_RUNED;
	}

}
