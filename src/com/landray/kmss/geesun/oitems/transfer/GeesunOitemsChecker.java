package com.landray.kmss.geesun.oitems.transfer;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;

import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferChecker;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckResult;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOitemsChecker implements ISysAdminTransferChecker {
	protected final Log logger = LogFactory.getLog(getClass());

	public SysAdminTransferCheckResult check(
			SysAdminTransferCheckContext sysAdminTransferCheckContext) {
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
			IGeesunOitemsManageService geesunOitemsManageService = (IGeesunOitemsManageService) SpringBeanUtil
					.getBean("geesunOitemsManageService");
			String hql = "select count(*) from  GeesunOitemsManage where 1=1";
			Query q = geesunOitemsManageService.getBaseDao().getHibernateSession()
					.createQuery(hql);
			Long count = (Long) q.uniqueResult();
			if (count == 0) {
				return SysAdminTransferCheckResult.TASK_STATUS_RUNED;
			}
		} catch (Exception e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		}
		return SysAdminTransferCheckResult.TASK_STATUS_NOT_RUNED;
	}
}
