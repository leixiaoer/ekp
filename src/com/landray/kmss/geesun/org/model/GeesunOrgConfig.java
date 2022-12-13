package com.landray.kmss.geesun.org.model;

import com.landray.kmss.sys.appconfig.model.BaseAppConfig;


public class GeesunOrgConfig extends BaseAppConfig {
	
	public GeesunOrgConfig() throws Exception {
		super();
	}

	@Override
	public String getJSPUrl() {
		return "/geesun/org/geesun_org_config/geesunOrgConfig_edit.jsp";
	}

	public String getValue(String name) {
		return (String) getDataMap().get(name);
	}

	public void setValue(String name, String value) {
		getDataMap().put(name, value);
	}
	

}
