package com.landray.kmss.geesun.oitems.service.spring;

import java.math.BigDecimal;
import java.util.List;

import org.hibernate.Query;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsShoppingTrolleyService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.util.StringUtil;

public class GeesunOitemsShoppingTrolleyServiceImp extends BaseServiceImp implements
		IGeesunOitemsShoppingTrolleyService {

	private IGeesunOitemsListingService geesunOitemsListingService = null;
	private IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService = null;

	public void setGeesunOitemsWarehousingRecordJoinListService(
			IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService) {
		this.geesunOitemsWarehousingRecordJoinListService = geesunOitemsWarehousingRecordJoinListService;
	}

	public void setGeesunOitemsListingService(
			IGeesunOitemsListingService geesunOitemsListingService) {
		this.geesunOitemsListingService = geesunOitemsListingService;
	}

	public void addOitems(IExtendForm form, RequestContext requestContext)
			throws Exception {
		String fdOitemsId = requestContext.getParameter("fdOitemsId");
		String fdChecked = requestContext.getParameter("fdChecked");
		String fdApplicationId = requestContext.getParameter("fdApplicationId");
		String fdPrice = requestContext.getParameter("fdPrice");
		String fdCurNum = requestContext.getParameter("fdCurNum");
		String fdIsCancle = requestContext.getParameter("fdIsCancle");
		String warehousingRecordId = requestContext
				.getParameter("warehousingRecordId");
		List<GeesunOitemsShoppingTrolley> valueList = this
				.findList(
						"geesunOitemsShoppingTrolley.fdApplicationId = '"
								+ fdApplicationId
								+ "' and geesunOitemsShoppingTrolley.geesunOitemsWarehousingRecordJoinList.fdId = '"
								+ warehousingRecordId
								+ "' and geesunOitemsShoppingTrolley.geesunOitemsListing.fdId = '"
								+ fdOitemsId + "'", null);
		if (StringUtil.isNotNull(warehousingRecordId)
				&& "false".equals(fdChecked)) {

			for (int i = 0; i < valueList.size(); i++) {
				GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley) valueList
						.get(i);
				this.delete(geesunOitemsShoppingTrolley);
			}
		}
		// List<GeesunOitemsShoppingTrolley> valueList = this.findList(
		// "geesunOitemsShoppingTrolley.fdApplicationId = '"
		// + fdApplicationId
		// +
		// "' and geesunOitemsShoppingTrolley.geesunOitemsListing.fdId = '"+fdOitemsId+"'",
		// null);
		// if (valueList == null || valueList.size() == 0) {
		if (StringUtil.isNotNull(fdOitemsId)
				&& StringUtil.isNotNull(warehousingRecordId)
				&& "true".equals(fdChecked)) {
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) geesunOitemsListingService
					.findByPrimaryKey(fdOitemsId);
			GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = (GeesunOitemsWarehousingRecordJoinList) geesunOitemsWarehousingRecordJoinListService
					.findByPrimaryKey(warehousingRecordId);
			if (valueList.size() == 0 && geesunOitemsListing != null
					&& geesunOitemsWarehousingRecordJoinList != null) {
				GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = new GeesunOitemsShoppingTrolley();
				geesunOitemsShoppingTrolley.setFdApplicationId(fdApplicationId);
				BigDecimal Price = new BigDecimal(fdPrice);
				BigDecimal CurNum = new BigDecimal(fdCurNum);
				geesunOitemsShoppingTrolley.setGeesunOitemsListing(geesunOitemsListing);
				geesunOitemsShoppingTrolley
						.setGeesunOitemsWarehousingRecordJoinList(geesunOitemsWarehousingRecordJoinList);
				if (geesunOitemsShoppingTrolley.getFdApplicationNumber() == null) {
					geesunOitemsShoppingTrolley.setFdApplicationNumber(1);
				}
				geesunOitemsShoppingTrolley
						.setFdReferencePrice(Price.doubleValue());
				geesunOitemsShoppingTrolley.setFdAmount(CurNum.intValue());
				// 添加日志信息
				if (UserOperHelper.allowLogOper("addOitems", getModelName())) {
					UserOperContentHelper.putAdd(geesunOitemsShoppingTrolley,
							"fdApplicationId",
							"geesunOitemsListing",
							"geesunOitemsWarehousingRecordJoinList",
							"fdApplicationNumber", "fdReferencePrice",
							"fdAmount");
				}
				this.add(geesunOitemsShoppingTrolley);
			} else {
				return;
			}
		}
		if ("1".equals(fdIsCancle)
				|| ("false".equals(fdChecked) && StringUtil
						.isNull(warehousingRecordId))) {
			List<GeesunOitemsShoppingTrolley> List = this
					.findList(
							"geesunOitemsShoppingTrolley.fdApplicationId = '"
									+ fdApplicationId
									+ "' and geesunOitemsShoppingTrolley.geesunOitemsListing.fdId = '"
									+ fdOitemsId + "'", null);
			for (int i = 0; i < List.size(); i++) {
				GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolleytemp = (GeesunOitemsShoppingTrolley) List
						.get(i);
				this.delete(geesunOitemsShoppingTrolleytemp);
			}
		}
		// } else {
		// return;
		// }
		// } else {
		// List<GeesunOitemsShoppingTrolley> valueList = this.findList(
		// "geesunOitemsShoppingTrolley.fdApplicationId = '"
		// + fdApplicationId
		// +
		// "' and geesunOitemsShoppingTrolley.geesunOitemsWarehousingRecord.fdId = '"+warehousingRecordId+"'",
		// null);
		// for(int i = 0; i < valueList.size(); i++){
		// GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley =
		// (GeesunOitemsShoppingTrolley)valueList.get(i);
		// this.delete(geesunOitemsShoppingTrolley);
		// }
		// }

	}

	public void deleteShoppingTrolley(SysQuartzJobContext context)
			throws Exception {

		String hql = "delete from GeesunOitemsShoppingTrolley  geesunOitemsShoppingTrolley  where geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdId is null";
		Query query = this.getBaseDao().getHibernateSession().createQuery(hql);
		query.executeUpdate();
	}

	@Override
	public List<GeesunOitemsShoppingTrolley>
			addShops(List<GeesunOitemsShoppingTrolley> shops, String fdAppId)
					throws Exception {
		for (GeesunOitemsShoppingTrolley shop : shops) {
			add(shop);
		}
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock(
				"geesunOitemsShoppingTrolley.fdApplicationId=:fdApplicationId and geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdId is null");
		hqlInfo.setParameter("fdApplicationId", fdAppId);
		List<GeesunOitemsShoppingTrolley> list = findList(hqlInfo);
		return list;
	}

	@Override
	public void deleteShoppingTrolley(String fdApplicationId) throws Exception {
		String hql = "delete from GeesunOitemsShoppingTrolley  geesunOitemsShoppingTrolley  where geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdId is null and geesunOitemsShoppingTrolley.fdApplicationId=:fdApplicationId";
		Query query = this.getBaseDao().getHibernateSession()
				.createQuery(hql);
		query.setParameter("fdApplicationId", fdApplicationId);
		query.executeUpdate();
	}

	@Override
	public boolean checkShop(String fdAppId,
			GeesunOitemsWarehousingRecordJoinList record) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock(
				"geesunOitemsShoppingTrolley.fdApplicationId=:fdApplicationId and geesunOitemsShoppingTrolley.geesunOitemsWarehousingRecordJoinList=:record");
		hqlInfo.setParameter("fdApplicationId", fdAppId);
		hqlInfo.setParameter("record", record);
		List<GeesunOitemsShoppingTrolley> list = findList(hqlInfo);
		return list.isEmpty();
	}

}
