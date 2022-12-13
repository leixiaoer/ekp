package com.landray.kmss.geesun.base.model;

import com.landray.kmss.sys.appconfig.model.BaseAppConfig;

public class GeesunBaseConfig extends BaseAppConfig {

		public GeesunBaseConfig() throws Exception {
			super();
		}

		public String getJSPUrl() {
			return "/geesun/base/geesun_base_config/geesunBase_config.jsp";
		}
		
		/**
		 * @return 返回 报销模板ID
		 */
		public String getFdTemplateIds() {
			return getValue("fdTemplateIds");
		}

		/**
		 * @param fdTemplateIds
		 *            要设置的 报销模板ID
		 */
		public void setFdTemplateIds(String fdTemplateIds) {
			setValue("fdTemplateIds", fdTemplateIds);
		}
		
		/**
		 * @return 返回 预算调整模板ID
		 */
		public String getFdAdjustTemplateIds() {
			return getValue("fdAdjustTemplateIds");
		}

		/**
		 * @param fdAdjustTemplateIds
		 *            要设置的 预算调整模板ID
		 */
		public void setFdAdjustTemplateIds(String fdAdjustTemplateIds) {
			setValue("fdAdjustTemplateIds", fdAdjustTemplateIds);
		}
		
		/**
		 * @return 返回 HR数据源名称
		 */
		public String getFdHrDbName() {
			return getValue("fdHrDbName");
		}

		/**
		 * @param fdHrDbName
		 *            要设置的 HR数据源名称
		 */
		public void setFdHrDbName(String fdHrDbName) {
			setValue("fdHrDbName", fdHrDbName);
		}
		
	}
