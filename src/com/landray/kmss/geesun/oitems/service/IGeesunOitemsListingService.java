package com.landray.kmss.geesun.oitems.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReceiveContext;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 用品清单管理业务对象接口
 */
public interface IGeesunOitemsListingService extends IBaseService {

	/**
	 * 入库统z计
	 */
	public LinkedHashMap inCount(HttpServletRequest request) throws Exception;

	/**
	 * 出库统计
	 */
	public LinkedHashMap outCount(HttpServletRequest request) throws Exception;

	public List<GeesunOitemsReceiveContext> findReceiveCount(
			HttpServletRequest request) throws Exception;
	/**
	 * 获取用品的图片
	 */
	public String getPicIdsByListingId(String fdId) throws Exception;
	
	/**
	 * 校验编码唯一性
	 */
	public String checkUnique(String fdNo,String fdListingId) throws Exception;

	/**
	 * 下载导入模板
	 * 
	 * @param request
	 * 
	 * @param response
	 * @throws Exception
	 */
	public void downloadTemplate(HttpServletRequest request,
			HttpServletResponse response) throws Exception;

	/**
	 * 根据编号查找用品
	 * 
	 * @param fdNo
	 * @return
	 * @throws Exception
	 */
	public GeesunOitemsListing findByFdNo(String fdNo) throws Exception;

}
