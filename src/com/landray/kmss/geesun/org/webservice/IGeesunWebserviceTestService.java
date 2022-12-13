package com.landray.kmss.geesun.org.webservice;

import javax.jws.WebService;

import com.landray.kmss.sys.webservice2.interfaces.ISysWebservice;

@WebService
public interface IGeesunWebserviceTestService extends ISysWebservice {
	
	public String getMobileByLoginName(String fdLoginName) throws Exception;
}
