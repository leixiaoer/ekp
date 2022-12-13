package com.landray.kmss.common.service;

import java.util.ArrayList;
import java.util.List;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;

/**
 * 用于根据key值查询资源的XML的通用Service
 * 
 * @author 叶中奇
 */
public class XMLGetResourceService implements IXMLDataBean {
	public List getDataList(RequestContext xmlContext) throws Exception {
		String para = xmlContext.getParameter("key");
		String locale = xmlContext.getParameter("locale");
		List rtnList = new ArrayList();
		if (!StringUtil.isNull(para)) {
			String[] paraArr = para.split("\\s*;\\s*");
			for (int i = 0; i < paraArr.length; i++) {
				if (StringUtil.isNull(paraArr[i])) {
					rtnList.add("");
				} else {
					if (StringUtil.isNotNull(locale)
							&& ResourceUtil.getLocale(locale) != null) {
						rtnList.add(ResourceUtil.getStringValue(paraArr[i], null,
								ResourceUtil.getLocale(locale)));
					} else {
						rtnList.add(ResourceUtil.getString(paraArr[i],
								xmlContext.getLocale()));
					}
				}
			}
		}
		return rtnList;
	}
}
