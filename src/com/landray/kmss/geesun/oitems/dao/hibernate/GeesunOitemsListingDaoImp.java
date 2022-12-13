package com.landray.kmss.geesun.oitems.dao.hibernate;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;

import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.oitems.dao.IGeesunOitemsListingDao;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReceiveContext;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.StringUtil;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 用品清单管理数据访问接口实现
 */
public class GeesunOitemsListingDaoImp extends BaseDaoImp implements
		IGeesunOitemsListingDao {

	public List<GeesunOitemsReceiveContext> findReceiveCount(
			HttpServletRequest request) throws Exception {
		List rtnList = new ArrayList();
		Session session = this.getSession();
		Query query = session.createQuery((String) request.getAttribute("sql"));
		String fdStartTime = (String) request.getAttribute("fdStartTime");
		String fdEndTime = (String) request.getAttribute("fdEndTime");

		if (StringUtil.isNotNull(fdStartTime)) {
			Date startDate = DateUtil.convertStringToDate(fdStartTime
					+ " 00:00:00", DateUtil.TYPE_DATETIME, Locale.getDefault());
			query.setParameter("fdStartTime", startDate);
		}
		if (StringUtil.isNotNull(fdEndTime)) {
			Date endDate = DateUtil.convertStringToDate(
					fdEndTime + " 23:59:59", DateUtil.TYPE_DATETIME, Locale
							.getDefault());
			query.setParameter("fdEndTime", endDate);
		}
		List valueList = query.list();
		for (Iterator itera = valueList.iterator(); itera.hasNext();) {
			Object[] objs = (Object[]) itera.next();
			// GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) objs[0];
			String oitemsListingId = (String) objs[0];
			GeesunOitemsReceiveContext geesunOitemsReceiveContext = new GeesunOitemsReceiveContext();
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) this
					.findByPrimaryKey(oitemsListingId);
			geesunOitemsReceiveContext.setGeesunOitemsListing(geesunOitemsListing);
			Long number = (Long) objs[1];
			geesunOitemsReceiveContext.setFdReceiveAmount(new Long(number)
					.intValue());

			geesunOitemsReceiveContext.setFdAmount(geesunOitemsListing.getFdAmount());
			rtnList.add(geesunOitemsReceiveContext);
		}
		return rtnList;
	}

	@Override
	public String add(IBaseModel modelObj) throws Exception {
		GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) modelObj;
		if (geesunOitemsListing.getFdAmount() == null) {
			geesunOitemsListing.setFdAmount(0);
		}
		if (geesunOitemsListing.getFdReferencePrice() == null) {
			geesunOitemsListing.setFdReferencePrice(0.0);
		}
		return super.add(geesunOitemsListing);
	}
}
