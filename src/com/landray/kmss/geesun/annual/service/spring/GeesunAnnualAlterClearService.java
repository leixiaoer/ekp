package com.landray.kmss.geesun.annual.service.spring;

import java.util.ArrayList;
import java.util.List;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualAlterService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 定时器，清除已经主域模型中已被删除的记录
 *
 */
public class GeesunAnnualAlterClearService {
	
	private IGeesunAnnualAlterService geesunAnnualAlterService;
	
	public void clearData() throws Exception{
		HQLInfo hqlInfo = new HQLInfo();
		//查找不重复的fdModelName和fdModelId
		hqlInfo.setSelectBlock("distinct fdModelName, fdModelId");
		List<Object[]> resultList = getGeesunAnnualAlterService().findValue(hqlInfo);
		HQLInfo findHql = null;
		List<HQLInfo> hqlList = new ArrayList<HQLInfo>();
		//根据fdModelName和fdModelId构造Hql
		for(Object[] obj : resultList) {
			findHql = new HQLInfo();
			findHql.setSelectBlock("1");
			findHql.setModelName((String) obj[0]);
			findHql.setWhereBlock("fdId = :fdId");
			findHql.setParameter("fdId", obj[1]);
			hqlList.add(findHql);
		}
		HQLInfo deleteHql = null;
		List<String> ids = new ArrayList<String>();
		List<HQLInfo> deleteHqlList = new ArrayList<HQLInfo>();
		//根据构造的，查找记录存不存在
		for(HQLInfo hql : hqlList) {
			List list = getGeesunAnnualAlterService().getBaseDao().findValue(hql);
			//把不存在的记录，重新查找修改记录表中需要删除的id
			if(ArrayUtil.isEmpty(list)) {
				deleteHql = new HQLInfo();
				deleteHql.setSelectBlock("distinct fdId");
				deleteHql.setWhereBlock("fdModelName = :modelName and fdModelId = :modelId");
				deleteHql.setParameter("modelName", hql.getModelName());
				deleteHql.setParameter("modelId", hql.getParameterList().get(0).getValue());
				deleteHqlList.add(deleteHql);
			}
		}
		for(HQLInfo hql : deleteHqlList) {
			List<String> deleteIdList = getGeesunAnnualAlterService().findValue(hql);
			for(String obj : deleteIdList) {
				ids.add((String)obj);
			}
		}
		//删除需要删除的数据
		if(!ArrayUtil.isEmpty(ids)) {
			getGeesunAnnualAlterService().delete(ids.toArray(new String[0]));
		}
	}

	public IGeesunAnnualAlterService getGeesunAnnualAlterService() {
		if(null == geesunAnnualAlterService){
			geesunAnnualAlterService = (IGeesunAnnualAlterService) SpringBeanUtil
					.getBean("geesunAnnualAlterService");
		}
		return geesunAnnualAlterService;
	}
}
