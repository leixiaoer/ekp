package com.landray.kmss.geesun.oitems.service.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;

public class GeesunOitemsManageServiceTreeImp implements IXMLDataBean{

	private IGeesunOitemsManageService geesunOitemsManageService ;
	
	public void setGeesunOitemsManageService(
			IGeesunOitemsManageService geesunOitemsManageService) {
		this.geesunOitemsManageService = geesunOitemsManageService;
	}



	public List getDataList(RequestContext requestInfo) throws Exception {
		String categoryId = requestInfo.getParameter("categoryId");
		String nodeType = requestInfo.getParameter("nodeType");
		String showOtherCate = requestInfo.getParameter("showOtherCate");
		List rtnList = new ArrayList();
		String whereString = "";
		HQLInfo hqlInfo = new HQLInfo();
		if ("node".equals(nodeType)) {
			whereString +=" geesunOitemsManage.hbmParent.fdId=null";
			hqlInfo.setSelectBlock("geesunOitemsManage.fdName, geesunOitemsManage.fdId");
	        hqlInfo.setWhereBlock(whereString);
	        hqlInfo.setOrderBy("geesunOitemsManage.fdOrder asc");
        	List categoriesList = geesunOitemsManageService.findValue(hqlInfo);
        	for (int i = 0; i < categoriesList.size(); i++) {
		    Object[] info = (Object[]) categoriesList.get(i);
			HashMap node = new HashMap();
			node.put("text", info[0]);
			node.put("value", info[1]);
			node.put("nodeType", "CATEGORY");
			rtnList.add(node);
		   }
         if("yes".equals(showOtherCate)){
        	HashMap node0 = new HashMap();
    		node0.put("text", ResourceUtil.getString("geesunOitemsListing.fdCategory.other", "geesun-oitems"));
    		node0.put("value", "");
    		node0.put("nodeType", "CATEGORY");
    		rtnList.add(node0);
          }
		}else{
		  if(StringUtil.isNotNull(categoryId)) {
			whereString +=" geesunOitemsManage.hbmParent.fdId=:categoryId";
			hqlInfo.setParameter("categoryId", categoryId);
			hqlInfo.setSelectBlock("geesunOitemsManage.fdName, geesunOitemsManage.fdId");
			hqlInfo.setWhereBlock(whereString);
			hqlInfo.setOrderBy("geesunOitemsManage.fdOrder asc");
			List categoriesList = geesunOitemsManageService.findValue(hqlInfo);
			for (int i = 0; i < categoriesList.size(); i++) {
				Object[] info = (Object[]) categoriesList.get(i);
					HashMap node = new HashMap();
					node.put("text", info[0]);
					node.put("value", info[1]);
					node.put("nodeType", "lastNode");
					rtnList.add(node);
				}
		  }		
		}		
		return rtnList;
	}
}
