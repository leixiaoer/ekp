package com.landray.kmss.geesun.annual.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.model.GeesunAnnualUse;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;

public interface IGeesunAnnualUseService extends IExtendDataService {
	
	/**
	 * 获取指定人员的所有冻结或者已用的年假数目
	 * @param fdReviewId
	 * @param fdType
	 * @param isLast
	 * @param geesunAnnualMain
	 * @return
	 * @throws Exception 
	 */
	public Double getYearLeaveDayAuditingByPerson(String fdReviewId, 
			String fdType, boolean isLast, GeesunAnnualMain geesunAnnualMain) throws Exception;
	
	/**
	 * 根据状态获取使用中的年假信息
	 * @param fdReviewId
	 * @param isLast
	 * @param geesunAnnualMain
	 * @return
	 * @throws Exception 
	 */
	public Double getLeaveDayAuditingByPerson(String fdReviewId, 
			boolean isLast, GeesunAnnualMain geesunAnnualMain) throws Exception;

    public abstract List<GeesunAnnualUse> findByFdAnnual(GeesunAnnualMain fdAnnual) throws Exception;
    
    /**
	 * 根据类型获取数量
	 * @param requestContext
	 * @return
	 * @throws Exception
	 */
	public int getNumByAnnual(HttpServletRequest requestContext) throws Exception;
	
	/**
	 * 根据排班计算对应人员开始时间和结束时间范围内容有效天数
	 * @param personId
	 * @param begin
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public double getAvailableDays(String personId, 
			Date begin, Date end) throws Exception;
	
}
