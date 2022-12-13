package com.landray.kmss.geesun.oitems.service.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.hibernate.Query;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.sys.category.interfaces.ConfigUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

public class GeesunOitemsManageServiceCheckTreeImp implements IXMLDataBean{

	private IGeesunOitemsManageService geesunOitemsManageService ;

	public void setGeesunOitemsManageService(
			IGeesunOitemsManageService geesunOitemsManageService) {
		this.geesunOitemsManageService = geesunOitemsManageService;
	}



	public List getDataList(RequestContext requestInfo) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		String categoryId = requestInfo.getParameter("categoryId");
		//deptBudger 是否为部门节点
		String deptBudger = requestInfo.getParameter("deptBudger");
		//type 为类型是否为add,还是edit
		String type = requestInfo.getParameter("type");
		//获取申请Id
		String fdApplicationId = requestInfo.getParameter("fdApplicationId");

		String hql = "";
		List categoriesList = new ArrayList();
		List rtnList = new ArrayList();
		if (UserUtil.getKMSSUser().isAdmin()) {
			String whereString = "1=1";
			if (StringUtil.isNotNull(categoryId)) {
				whereString += " and geesunOitemsManage.hbmParent.fdId=:categoryId";
				hqlInfo.setParameter("categoryId", categoryId);
			} else {
				whereString += " and geesunOitemsManage.hbmParent.fdId=null";
			}
			hqlInfo.setDistinctType(HQLInfo.DISTINCT_YES);
			hqlInfo.setSelectBlock("geesunOitemsManage.fdName, geesunOitemsManage.fdId");
			hqlInfo.setWhereBlock(whereString);
			categoriesList = geesunOitemsManageService.findValue(hqlInfo);
		} else if (!ConfigUtil.auth("com.landray.kmss.geesun.oitems.model.GeesunOitemsManage")) {
			hql = "select distinct geesunOitemsManage.fdName, geesunOitemsManage.fdId from com.landray.kmss.geesun.oitems.model.GeesunOitemsManage geesunOitemsManage  left join geesunOitemsManage"
					+ ".authUses use where ((use.fdId in (:orgIds) or use.fdId is null) and (geesunOitemsManage.authNotUseFlag=0 or geesunOitemsManage.authNotUseFlag is null))";
			if (StringUtil.isNull(categoryId)) {
				hql = hql + " and geesunOitemsManage.hbmParent.fdId=null";
			} else {
				hql = hql + " and geesunOitemsManage.hbmParent.fdId='" + categoryId + "'";
			}
			Query query = geesunOitemsManageService.getBaseDao().getHibernateSession().createQuery(hql);
			query.setParameterList("orgIds", UserUtil.getKMSSUser().getUserAuthInfo().getAuthOrgIds());
			categoriesList = query.list();
		}else{
			if (StringUtil.isNotNull(categoryId)) {
				/*hql = "select geesunOitemsManage.fdName, geesunOitemsManage.fdId from com.landray.kmss.geesun.oitems.model.GeesunOitemsManage geesunOitemsManage  left join geesunOitemsManage"
						+ ".authAllReaders readers where geesunOitemsManage.hbmParent.fdId=:categoryId and ((readers.fdId in (:orgIds)) or geesunOitemsManage.authReaderFlag=1 )";*/

				hql = "select distinct geesunOitemsManage.fdName, geesunOitemsManage.fdId from com.landray.kmss.geesun.oitems.model.GeesunOitemsManage geesunOitemsManage  left join geesunOitemsManage"
						+ ".authUses use where geesunOitemsManage.hbmParent.fdId=:categoryId and ((use.fdId in (:orgIds) or use.fdId is null) and (geesunOitemsManage.authNotUseFlag=0 or geesunOitemsManage.authNotUseFlag is null))";

				Query query = geesunOitemsManageService.getBaseDao()
						.getHibernateSession().createQuery(hql);
				query.setParameter("categoryId", categoryId);
				query.setParameterList("orgIds", UserUtil.getKMSSUser()
						.getUserAuthInfo().getAuthOrgIds());
				categoriesList = query.list();
			} else {
				/*hql = "select geesunOitemsManage.fdName, geesunOitemsManage.fdId from com.landray.kmss.geesun.oitems.model.GeesunOitemsManage geesunOitemsManage  left join geesunOitemsManage"
						+ ".authAllReaders readers where geesunOitemsManage.hbmParent.fdId=null and ((readers.fdId in (:orgIds)) or geesunOitemsManage.authReaderFlag=1 )";*/

				hql = "select distinct geesunOitemsManage.fdName, geesunOitemsManage.fdId from com.landray.kmss.geesun.oitems.model.GeesunOitemsManage geesunOitemsManage  left join geesunOitemsManage"
						+ ".authUses use where geesunOitemsManage.hbmParent.fdId=null and ((use.fdId in (:orgIds) or use.fdId is null) and (geesunOitemsManage.authNotUseFlag=0 or geesunOitemsManage.authNotUseFlag is null))";
				Query query = geesunOitemsManageService.getBaseDao()
						.getHibernateSession().createQuery(hql);
				query.setParameterList("orgIds", UserUtil.getKMSSUser()
						.getUserAuthInfo().getAuthOrgIds());
				categoriesList = query.list();
			}
		}
		for (int i = 0; i < categoriesList.size(); i++) {
			Object[] info = (Object[]) categoriesList.get(i);
			HashMap node = new HashMap();
			node.put("text", info[0]);
			node.put("value", info[1]);
			node.put("target", "chacked");
			node.put("href",
					requestInfo.getContextPath()
							+ "/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=checkOitemsList&categoryId=!{value}&deptBudger="
							+ deptBudger + "&type=" + type + "&fdApplicationId=" + fdApplicationId);
			rtnList.add(node);
		}
		return rtnList;

	}
}
