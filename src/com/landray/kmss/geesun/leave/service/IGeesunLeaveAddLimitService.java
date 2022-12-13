package com.landray.kmss.geesun.leave.service;

import java.util.Map;

import com.landray.kmss.km.review.model.KmReviewMain;

public interface IGeesunLeaveAddLimitService {
	/**
	 * 调整调休额度
	 */
	void AddLimit(Map<String, Object> map, KmReviewMain kmReviewMain);
}
