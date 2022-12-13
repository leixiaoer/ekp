package com.landray.kmss.geesun.base.service;

import java.util.List;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.geesun.base.model.GeesunBasePay;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;

public interface IGeesunBasePayService extends IExtendDataService {

    public abstract List<GeesunBasePay> findByFdReview(KmReviewMain fdReview) throws Exception;
}
