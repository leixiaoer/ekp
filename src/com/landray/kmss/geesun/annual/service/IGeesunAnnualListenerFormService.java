package com.landray.kmss.geesun.annual.service;

import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.metadata.interfaces.ISysMetadataParser;

public interface IGeesunAnnualListenerFormService {

	/**
	 * 插入、更新或者删除请假记录表记录
	 * @param kmReviewMain
	 * @param dataParser
	 * @throws fdType
	 */
	public void addOrUpdateOrDeleteLeave(KmReviewMain kmReviewMain, 
			ISysMetadataParser dataParser, String fdType) throws Exception;
	
}
