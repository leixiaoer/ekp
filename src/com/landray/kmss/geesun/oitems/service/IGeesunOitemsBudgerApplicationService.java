package com.landray.kmss.geesun.oitems.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.geesun.oitems.model.GeesunOitemsReceiveContext;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 部门预算申请业务对象接口
 */
public interface IGeesunOitemsBudgerApplicationService extends IExtendDataService {

	/**
	 * 部门预算统计
	 */
	//public Map count(HttpServletRequest request) throws Exception ;
	/*
	 * 导出
	 */
	public void export(HttpServletResponse response,Map kmArticleListingMap,String title) throws Exception ;
	public void exportOutCount(HttpServletResponse response,Map kmArticleListingMap,String title) throws Exception ;
	public void exportInCount(HttpServletResponse response,Map kmArticleListingMap,String title) throws Exception ;
	public void exportReceive(HttpServletResponse response,
			List<GeesunOitemsReceiveContext> rtnList, String title) throws Exception;
}
