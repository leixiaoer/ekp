package com.landray.kmss.geesun.leave.model;

import com.landray.kmss.sys.appconfig.model.BaseAppConfig;

public class GeesunLeaveConfig extends BaseAppConfig {

		public GeesunLeaveConfig() throws Exception {
			super();
		}

		public String getJSPUrl() {
			return "/geesun/leave/geesun_leave_config/geesunLeave_config.jsp";
		}
		
		/**
		 * @return 返回 集成模板ID
		 */
		public String getFdTemplateIds() {
			return getValue("fdTemplateIds");
		}

		/**
		 * @param fdTemplateIds
		 *            要设置的 集成模板ID
		 */
		public void setFdTemplateIds(String fdTemplateIds) {
			setValue("fdTemplateIds", fdTemplateIds);
		}
		
	}
