package com.landray.kmss.geesun.leave.service;

import java.util.Map;

import com.landray.kmss.km.review.model.KmReviewMain;

/**
 * 
 * 增加调休申请记录
 * 
 * @author 渣渣辉
 *
 */
public interface IGeesunLeaveTakeWorkingService {
	void addTakeWorking(Map<String, Object> map, KmReviewMain kmReviewMain);
}
