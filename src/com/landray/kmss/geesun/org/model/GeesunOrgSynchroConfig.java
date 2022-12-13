package com.landray.kmss.geesun.org.model;

import com.landray.kmss.sys.appconfig.model.BaseAppConfig;
import com.landray.kmss.util.StringUtil;

public class GeesunOrgSynchroConfig extends BaseAppConfig {

		public GeesunOrgSynchroConfig() throws Exception {
			super();
		}

		public String getJSPUrl() {
			return "/geesun/org/geesun_org_config/geesunOrgSynchro_config.jsp";
		}
		
		/**
		 * @return fdAccount
		 */
		public String getFdAccount() {
			return getValue("fdAccount");
		}
		
		/**
		 * @param fdAccount 
		 */
		public void setFdAccount(String fdAccount) {
			setValue("fdAccount", fdAccount);
		}
		
		/**
		 * @return fdSecretKey
		 */
		public String getFdSecretKey() {
			return getValue("fdSecretKey");
		}
		
		/**
		 * @param fdSecretKey 
		 */
		public void setFdSecretKey(String fdSecretKey) {
			setValue("fdSecretKey", fdSecretKey);
		}
		
		/**
		 * @return fdZzType
		 */
		public String getFdZzType() {
			String str = "";
			str = super.getValue("fdZzType");
			if (StringUtil.isNull(str)) {
				str = "1";
				return str;
			}
			return getValue("fdZzType");
		}
		
		/**
		 * @param fdZzType 
		 */
		public void setFdZzType(String fdZzType) {
			setValue("fdZzType", fdZzType);
		}
		
		/**
		 * @return 接口地址
		 */
		public String getFdUrl() {
			return getValue("fdUrl");
		}
		
		/**
		 * @param fdUrl 接口地址
		 */
		public void setFdUrl(String fdUrl) {
			setValue("fdUrl", fdUrl);
		}
		
		/**
		 * @return 用户
		 */
		public String getFdUserName() {
			return getValue("fdUserName");
		}
		
		/**
		 * @param fdUserName 用户
		 */
		public void setFdUserName(String fdUserName) {
			setValue("fdUserName", fdUserName);
		}
		
		/**
		 * @return 密码
		 */
		public String getFdPassword() {
			return getValue("fdPassword");
		}
		
		/**
		 * @param fdPassword 密码
		 */
		public void setFdPassword(String fdPassword) {
			setValue("fdPassword", fdPassword);
		}
		
		/**
		 * @return fdFilterParentIds
		 */
		public String getFdFilterParentIds() {
			return getValue("fdFilterParentIds");
		}
		
		/**
		 * @param fdFilterParentIds 
		 */
		public void setFdFilterParentIds(String fdFilterParentIds) {
			setValue("fdFilterParentIds", fdFilterParentIds);
		}
		
		/**
		 * @return 返回 定时任务运行出错通知人Ids
		 */
		public String getNotifyExceptionTargetIds() {
			return getValue("notifyExceptionTargetIds");
		}

		/**
		 * @param notifyExceptionTargetIds
		 *            要设置的 定时任务出错通知人Ids
		 */
		public void setNotifyExceptionTargetIds(String notifyExceptionTargetIds) {
			setValue("notifyExceptionTargetIds", notifyExceptionTargetIds);
		}

		/**
		 * @return 返回 定时任务出错通知人
		 */
		public String getNotifyExceptionTargetNames() {
			return getValue("notifyExceptionTargetNames");
		}

		/**
		 * @param notifyExceptionTargetNames
		 *            要设置的 定时任务出错通知人
		 */
		public void setNotifyCrashTargetNames(String notifyExceptionTargetNames) {
			setValue("notifyExceptionTargetNames", notifyExceptionTargetNames);
		}
		
		/**
		 * @param notifyErrorNotifyType
		 *            要设置的 消息异步运行出错时通知方式
		 */
		public void setNotifyErrorNotifyType(String notifyErrorNotifyType) {
			setValue("notifyErrorNotifyType", notifyErrorNotifyType);
		}

		/**
		 * @return 返回 消息异步运行出错时通知方式
		 */
		public String getNotifyErrorNotifyType() {
			String str = super.getValue("notifyErrorNotifyType");
			if (StringUtil.isNull(str)) {
				str = "todo";
			}
			return str;
		}
		
	}
