package com.landray.kmss.geesun.oitems.transfer;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;

import com.landray.kmss.geesun.oitems.service.IGeesunOitemsBudgerApplicationService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferResult;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOitemsTask extends GeesunOitemsTransferChecker implements ISysAdminTransferTask {
	public SysAdminTransferResult run(
			SysAdminTransferContext sysAdminTransferContext) {
		String uuid=sysAdminTransferContext.getUUID();	
		ISysAdminTransferTaskService sysAdminTransferTaskService=(ISysAdminTransferTaskService)SpringBeanUtil.getBean("sysAdminTransferTaskService");
		IGeesunOitemsBudgerApplicationService geesunOitemsBudgerApplicationService=(IGeesunOitemsBudgerApplicationService)SpringBeanUtil.getBean("geesunOitemsBudgerApplicationService");
		IGeesunOitemsManageService geesunOitemsManageService  = (IGeesunOitemsManageService)SpringBeanUtil.getBean("geesunOitemsManageService");
		try {
			List list=new ArrayList();
			list=sysAdminTransferTaskService.getBaseDao().findValue(null, "sysAdminTransferTask.fdUuid='"+uuid+"'", null);		
			SysAdminTransferTask sysAdminTransferTask=(SysAdminTransferTask)list.get(0);
			//if(sysAdminTransferTask.getFdStatus()!=1){
				String hql1 = "update GeesunOitemsManage m  set m.authReaderFlag = '1' where m.authReaderFlag is null";
				String hql2 = "update GeesunOitemsBudgerApplication b set b.docStatus = '31' where ( b.fdOutStatus = '1' or b.fdOutStatus is null )";
				Query q1 = geesunOitemsManageService.getBaseDao().getHibernateSession()
				.createQuery(hql1);
				Query q2 = geesunOitemsBudgerApplicationService.getBaseDao().getHibernateSession()
				.createQuery(hql2);
				q1.executeUpdate();		
				q2.executeUpdate();	
		//  }
		} catch (Exception e) {
			logger.error("执行旧数据迁移为空异常", e);

		}
		
		return SysAdminTransferResult.OK;
	}

}
