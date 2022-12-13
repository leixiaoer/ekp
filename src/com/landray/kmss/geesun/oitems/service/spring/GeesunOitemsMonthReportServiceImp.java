package com.landray.kmss.geesun.oitems.service.spring;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReportListing;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsMonthReportService;

/**
 * 月统计表业务接口实现
 * 
 * @author
 * @version 1.0 2011-11-23
 */
public class GeesunOitemsMonthReportServiceImp extends BaseServiceImp implements
		IGeesunOitemsMonthReportService {
	/***
	 * 将list按人员ID分组Map 以人员ID为key
	 * 
	 * @param geesunOitemsReportListing
	 * @return
	 */
	public Map<String, List<GeesunOitemsReportListing>> groupListByPerson(
			List<GeesunOitemsReportListing> geesunOitemsReportListing) {
		Map<String, List<GeesunOitemsReportListing>> resultMap = new TreeMap<String, List<GeesunOitemsReportListing>>();
		// 遍历
		for (GeesunOitemsReportListing item : geesunOitemsReportListing) {
			if (item.getFdAmount() != null) {
				// 已存在的往同一个key添加
				String key = item.getDocDept().getFdId()
						+ item.getDocCreator().getFdId();
				if (resultMap.containsKey(key)) {
					List<GeesunOitemsReportListing> temp = resultMap.get(key);
					temp.add(item);
					resultMap.put(key, temp);
				}
				// 不存在的新添加key
				else {
					List<GeesunOitemsReportListing> temp = new ArrayList<GeesunOitemsReportListing>();
					temp.add(item);
					resultMap.put(key, temp);
				}
			}
		}
		return resultMap;
	}

}
