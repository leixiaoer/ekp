package com.landray.kmss.geesun.annual.service;

import java.util.List;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.model.GeesunAnnualReset;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;

public interface IGeesunAnnualResetService extends IExtendDataService {

    public abstract List<GeesunAnnualReset> findByFdAnnual(GeesunAnnualMain fdAnnual) throws Exception;
}
