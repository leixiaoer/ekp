package com.landray.kmss.geesun.oitems.service.spring;

import java.util.List;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 人库记录业务接口实现
 */
public class GeesunOitemsWarehousingRecordJoinListServiceImp extends BaseServiceImp
		implements IGeesunOitemsWarehousingRecordJoinListService {

	@Override
	public List<GeesunOitemsWarehousingRecordJoinList> findByGeesunOitemsListing(
			GeesunOitemsListing geesunOitemsListing) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock(
				"geesunOitemsWarehousingRecordJoinList.geesunOitemsListing=:geesunOitemsListing");
		hqlInfo.setParameter("geesunOitemsListing", geesunOitemsListing);
		List<GeesunOitemsWarehousingRecordJoinList> result = findList(hqlInfo);
		return result;
	}

	@Override
	public GeesunOitemsWarehousingRecordJoinList findByOitemPrice(
			GeesunOitemsListing geesunOitemsListing, Double fdPrice) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock(
				"geesunOitemsWarehousingRecordJoinList.geesunOitemsListing=:geesunOitemsListing and geesunOitemsWarehousingRecordJoinList.fdPrice=:fdPrice");
		hqlInfo.setParameter("geesunOitemsListing", geesunOitemsListing);
		hqlInfo.setParameter("fdPrice", fdPrice);
		List<GeesunOitemsWarehousingRecordJoinList> result = findList(hqlInfo);
		if (!result.isEmpty())
			return result.get(0);
		return null;
	}
}
