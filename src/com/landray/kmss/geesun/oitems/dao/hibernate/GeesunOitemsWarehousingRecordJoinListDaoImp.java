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
import com.landray.kmss.geesun.oitems.dao.IGeesunOitemsWarehousingRecordJoinListDao;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReceiveContext;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 人库记录数据访问接口实现
 */
public class GeesunOitemsWarehousingRecordJoinListDaoImp extends BaseDaoImp implements IGeesunOitemsWarehousingRecordJoinListDao {

	@Override
	public String add(IBaseModel modelObj) throws Exception {
		GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = (GeesunOitemsWarehousingRecordJoinList) modelObj;
		geesunOitemsWarehousingRecordJoinList.setDocCreator(UserUtil.getUser());
		return super.add(geesunOitemsWarehousingRecordJoinList);
	}
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
			GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = (GeesunOitemsWarehousingRecordJoinList) this
					.findByPrimaryKey(oitemsListingId);
			if(geesunOitemsWarehousingRecordJoinList!=null){
			geesunOitemsReceiveContext.setGeesunOitemsWarehousingRecordJoinList(geesunOitemsWarehousingRecordJoinList);
			Long number = (Long) objs[1];
			geesunOitemsReceiveContext.setFdReceiveAmount(new Long(number)
					.intValue());
			geesunOitemsReceiveContext.setFdAmount(geesunOitemsWarehousingRecordJoinList.getFdCurNumber());
			rtnList.add(geesunOitemsReceiveContext);
			}
		}
		return rtnList;
	}

}
