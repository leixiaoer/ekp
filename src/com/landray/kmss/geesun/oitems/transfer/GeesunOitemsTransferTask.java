package com.landray.kmss.geesun.oitems.transfer;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.sys.admin.transfer.model.SysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTask;
import com.landray.kmss.sys.admin.transfer.service.ISysAdminTransferTaskService;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferContext;
import com.landray.kmss.sys.admin.transfer.service.spring.SysAdminTransferResult;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOitemsTransferTask extends GeesunOitemsTransferChecker implements ISysAdminTransferTask {
	public SysAdminTransferResult run(
			SysAdminTransferContext sysAdminTransferContext) {
		String uuid=sysAdminTransferContext.getUUID();	
		ISysAdminTransferTaskService sysAdminTransferTaskService=(ISysAdminTransferTaskService)SpringBeanUtil
		.getBean("sysAdminTransferTaskService");
		IGeesunOitemsListingService geesunOitemsListingService = (IGeesunOitemsListingService) SpringBeanUtil
		.getBean("geesunOitemsListingService");
		IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService=(IGeesunOitemsWarehousingRecordJoinListService)SpringBeanUtil
		.getBean("geesunOitemsWarehousingRecordJoinListService");
		try {
			List list=new ArrayList();
			list=sysAdminTransferTaskService.getBaseDao().findValue(null, "sysAdminTransferTask.fdUuid='"+uuid+"'", null);		
			SysAdminTransferTask sysAdminTransferTask=(SysAdminTransferTask)list.get(0);
			if(sysAdminTransferTask.getFdStatus()!=1){
			HQLInfo hqlInfo=new HQLInfo();
			List<GeesunOitemsListing> geesunOitemsListinglist=new ArrayList<GeesunOitemsListing>();
			geesunOitemsListinglist=geesunOitemsListingService.findList(hqlInfo);
			for(GeesunOitemsListing geesunOitemsListing:geesunOitemsListinglist){
				GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList=new GeesunOitemsWarehousingRecordJoinList();
				geesunOitemsWarehousingRecordJoinList.setDocCreator(geesunOitemsListing.getDocCreator());
				geesunOitemsWarehousingRecordJoinList.setFdBrand(geesunOitemsListing.getFdBrand());
				geesunOitemsWarehousingRecordJoinList.setFdCurNumber(geesunOitemsListing.getFdAmount());
				geesunOitemsWarehousingRecordJoinList.setFdNumber(geesunOitemsListing.getFdAmount());
				geesunOitemsWarehousingRecordJoinList.setFdPrice(geesunOitemsListing.getFdReferencePrice());
				geesunOitemsWarehousingRecordJoinList.setGeesunOitemsListing(geesunOitemsListing);
				geesunOitemsWarehousingRecordJoinListService.add(geesunOitemsWarehousingRecordJoinList);												
			}	
		  }
		} catch (Exception e) {
			logger.error("执行旧数据迁移为空异常", e);

		}
		
		return SysAdminTransferResult.OK;
	}

}
