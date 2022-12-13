package com.landray.kmss.geesun.oitems.service;

import java.util.List;

import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 人库记录业务对象接口
 */
public interface IGeesunOitemsWarehousingRecordJoinListService  extends IBaseService {
		
	public List<GeesunOitemsWarehousingRecordJoinList> findByGeesunOitemsListing(
			GeesunOitemsListing geesunOitemsListing) throws Exception;

	public GeesunOitemsWarehousingRecordJoinList findByOitemPrice(
			GeesunOitemsListing geesunOitemsListing, Double fdPrice) throws Exception;
}
