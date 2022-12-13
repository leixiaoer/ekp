package com.landray.kmss.geesun.leave.service;

import java.util.Map;

import com.landray.kmss.km.review.model.KmReviewMain;

public interface IGeesunLeaveOverTimeService {
	public void addMessage(Map<String, Object> map, KmReviewMain kmReviewMain, String userId);
}
