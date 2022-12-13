package com.landray.kmss.geesun.oitems.service.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.geesun.oitems.interfaces.Constants;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsTempletService;
import com.landray.kmss.util.StringUtil;

public class GeesunOitemsTempletTreeService extends BaseServiceImp implements
		IXMLDataBean {

	private IGeesunOitemsTempletService geesunOitemsTempletService;

	public void setGeesunOitemsTempletService(
			IGeesunOitemsTempletService geesunOitemsTempletService) {
		this.geesunOitemsTempletService = geesunOitemsTempletService;
	}

	protected IBaseService getServiceImp() {
		return geesunOitemsTempletService;
	}

	public List getDataList(RequestContext requestInfo) throws Exception {
		String categoryId = requestInfo.getParameter("categoryId");
		if (StringUtil.isNotNull(categoryId)) {
			return null;
		}
		List rtnList = new ArrayList();
		HQLInfo hql = new HQLInfo();
		List valueList = geesunOitemsTempletService.findList(hql);
		for (Iterator itera = valueList.iterator(); itera.hasNext();) {
			GeesunOitemsTemplet geesunOitemsTemplet = (GeesunOitemsTemplet) itera.next();
			Map node = new HashMap();
			node.put("value", geesunOitemsTemplet.getFdId());
			node.put("text", geesunOitemsTemplet.getFdName());
			node.put("name", geesunOitemsTemplet.getFdName());
			node.put("id", geesunOitemsTemplet.getFdId());
			node.put("beanName", "geesunOitemsTempletTreeService&categoryId=" + geesunOitemsTemplet.getFdId());
			if (geesunOitemsTemplet.getFdTempletType().toString().equals(
					Constants.GEESUNOITEMS_TYPE_DEPT)) {
				node.put("fdType", "dept");
			} else if(geesunOitemsTemplet.getFdTempletType().toString().equals(
					Constants.GEESUNOITEMS_TYPE_PERSON)){
				node.put("fdType", "person");
			}
			rtnList.add(node);
		}
		return rtnList;
	}

	public String getModelName() {
		return "com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet";
	}

	// dropList数据源
	@Override
	public List<?> findValue(HQLInfo hqlInfo) throws Exception {
		List rtnList = new ArrayList();
		HQLInfo hql = new HQLInfo();
		List valueList = geesunOitemsTempletService.findList(hql);
		for (Iterator itera = valueList.iterator(); itera.hasNext();) {
			GeesunOitemsTemplet geesunOitemsTemplet = (GeesunOitemsTemplet) itera.next();
			String[] arr = new String[2];
			arr[0] = geesunOitemsTemplet.getFdId();
			arr[1] = geesunOitemsTemplet.getFdName();
			rtnList.add(arr);
		}
		return rtnList;
	}

}
