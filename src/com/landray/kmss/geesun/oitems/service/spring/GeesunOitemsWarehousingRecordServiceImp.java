package com.landray.kmss.geesun.oitems.service.spring;

import java.math.BigDecimal;
import java.util.List;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsWarehousingRecordForm;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordService;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 人库记录业务接口实现
 */
public class GeesunOitemsWarehousingRecordServiceImp extends BaseServiceImp implements IGeesunOitemsWarehousingRecordService {

	protected IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService;

	protected IGeesunOitemsWarehousingRecordJoinListService getGeesunOitemsWarehousingRecordJoinListService() {
		if (geesunOitemsWarehousingRecordJoinListService == null)
			geesunOitemsWarehousingRecordJoinListService = (IGeesunOitemsWarehousingRecordJoinListService)  SpringBeanUtil.getBean("geesunOitemsWarehousingRecordJoinListService");
		return geesunOitemsWarehousingRecordJoinListService;
	}

	protected IGeesunOitemsListingService geesunOitemsListingService;

	protected IBaseService getGeesunOitemsListingService() {
		if (geesunOitemsListingService == null)
			geesunOitemsListingService = (IGeesunOitemsListingService) SpringBeanUtil.getBean("geesunOitemsListingService");
		return geesunOitemsListingService;
	}

	@Override
	public String addRecord(IExtendForm form, RequestContext requestContext) throws Exception {
		GeesunOitemsWarehousingRecordForm geesunOitemsWarehousingRecordForm = (GeesunOitemsWarehousingRecordForm) form;
		String price = geesunOitemsWarehousingRecordForm.getFdPrice();
		String listingId = geesunOitemsWarehousingRecordForm.getFdListingId();
		HQLInfo hqlInfo = new HQLInfo();
		String whereBlock = hqlInfo.getWhereBlock();
		if (whereBlock == null)
			whereBlock = "1=1";
		whereBlock += " and geesunOitemsWarehousingRecordJoinList.fdPrice=" + price
				+ " and geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId='" + listingId + "'";
		hqlInfo.setWhereBlock(whereBlock);
		List<GeesunOitemsWarehousingRecordJoinList> list = getGeesunOitemsWarehousingRecordJoinListService().findList(hqlInfo);
		BigDecimal Num = new BigDecimal(geesunOitemsWarehousingRecordForm.getFdNumber());
		BigDecimal Price = new BigDecimal(geesunOitemsWarehousingRecordForm.getFdPrice());
		if (list.size() == 0) {
			GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = new GeesunOitemsWarehousingRecordJoinList();
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) getGeesunOitemsListingService()
					.findByPrimaryKey(geesunOitemsWarehousingRecordForm.getFdListingId());
			geesunOitemsWarehousingRecordJoinList.setGeesunOitemsListing(geesunOitemsListing);
			geesunOitemsWarehousingRecordJoinList.setDocCreator(com.landray.kmss.util.UserUtil.getUser());
			geesunOitemsWarehousingRecordJoinList.setFdCurNumber(Num.intValue());
			geesunOitemsWarehousingRecordJoinList.setFdNumber(Num.intValue());
			geesunOitemsWarehousingRecordJoinList.setFdPrice(Price.doubleValue());
			getGeesunOitemsWarehousingRecordJoinListService().add(geesunOitemsWarehousingRecordJoinList);
		} else {
			GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = list.get(0);
			geesunOitemsWarehousingRecordJoinList
					.setFdNumber(geesunOitemsWarehousingRecordJoinList.getFdNumber() + Num.intValue());
			geesunOitemsWarehousingRecordJoinList
					.setFdCurNumber(geesunOitemsWarehousingRecordJoinList.getFdCurNumber() + Num.intValue());
			getGeesunOitemsWarehousingRecordJoinListService().update(geesunOitemsWarehousingRecordJoinList);
		}
		String number = geesunOitemsWarehousingRecordForm.getFdNumber();
		if (StringUtil.isNotNull(number) && !"0".equals(number)) {

			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) getGeesunOitemsListingService()
					.findByPrimaryKey(listingId);
			int fdAmount = new Integer(number) + geesunOitemsListing.getFdAmount();
			geesunOitemsListing.setFdAmount(fdAmount);
			geesunOitemsListing.setFdReferencePrice(new Double(geesunOitemsWarehousingRecordForm.getFdPrice()));
			getGeesunOitemsListingService().update(geesunOitemsListing);
		}

		return super.add((IExtendForm) geesunOitemsWarehousingRecordForm, requestContext);
	}
}
