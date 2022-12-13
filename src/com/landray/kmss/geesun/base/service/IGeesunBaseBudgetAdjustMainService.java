package com.landray.kmss.geesun.base.service;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import com.landray.kmss.km.review.model.KmReviewMain;

public interface IGeesunBaseBudgetAdjustMainService {
	
	/**
	 * 预算调整校验当前行借出金额是否足够
	 */
	public JSONObject checkLendMoney(HttpServletRequest request) throws Exception;
	
	/**
	 * 预算调整/追加校验当前行借入成本中心对应预算是否存在
	 */
	public JSONObject checkBorrowMoney(HttpServletRequest request) throws Exception;
	
	/**
	 * 操作预算
	 * @param kmReviewMain
	 * @param method
	 * @throws Exception
	 */
	public void operationBudget(KmReviewMain kmReviewMain, String method) throws Exception;
	
	/**
	 * 校验预算数据查看页面调整，调减金额不能不能调为负数
	 */
	public boolean checkAdjust(HttpServletRequest request) throws Exception;

}
