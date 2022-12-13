package com.landray.kmss.geesun.annual.model;

import com.landray.kmss.sys.appconfig.model.BaseAppConfig;

public class GeesunAnnualConfig extends BaseAppConfig {

		public GeesunAnnualConfig() throws Exception {
			super();
		}

		public String getJSPUrl() {
			return "/geesun/annual/geesun_annual_config/geesunAnnual_config.jsp";
		}
		
		/**
		 * @return 返回 调休请假模板ID
		 */
		public String getFdTemplateIds() {
			return getValue("fdTemplateIds");
		}

		/**
		 * @param fdTemplateIds
		 *            要设置的 调休请假模板ID
		 */
		public void setFdTemplateIds(String fdTemplateIds) {
			setValue("fdTemplateIds", fdTemplateIds);
		}
		
		/**
		 * @return 返回 组织ID
		 */
		public String getFdOrgId() {
			return getValue("fdOrgId");
		}

		/**
		 * @param fdOrgId
		 *            要设置的 组织ID
		 */
		public void setFdOrgId(String fdOrgId) {
			setValue("fdOrgId", fdOrgId);
		}
		
	}
