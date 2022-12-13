package com.landray.kmss.geesun.oitems.transfer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;

import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferChecker;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferCheckResult;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOitemsTransferChecker implements ISysAdminTransferChecker {
	protected final Log logger = LogFactory.getLog(getClass());
	public SysAdminTransferCheckResult check(
			SysAdminTransferCheckContext sysAdminTransferCheckContext) {
				
		IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService=(IGeesunOitemsWarehousingRecordJoinListService)SpringBeanUtil
		.getBean("geesunOitemsWarehousingRecordJoinListService");
		String hql1 = "select count(*) from  GeesunOitemsWarehousingRecordJoinList where 1=1";
		IGeesunOitemsListingService geesunOitemsListingService = (IGeesunOitemsListingService)SpringBeanUtil
		.getBean("geesunOitemsListingService");
		String hql2 = "select count(*) from  GeesunOitemsListing where 1=1";
		try {
			Query q1 = geesunOitemsWarehousingRecordJoinListService.getBaseDao().getHibernateSession()
					.createQuery(hql1);
			Long count1 = (Long) q1.uniqueResult();
			Query q2 = geesunOitemsWarehousingRecordJoinListService.getBaseDao().getHibernateSession()
			        .createQuery(hql2);
	        Long count2 = (Long) q2.uniqueResult();

			if (count1 == 0&&count2!=0) {
				return SysAdminTransferCheckResult.TASK_STATUS_NOT_RUNED;
			}

		} catch (Exception e) {
			logger.error("检查是否执行过旧数据迁移为空异常", e);
		}
		return SysAdminTransferCheckResult.TASK_STATUS_RUNED;
	}

}
