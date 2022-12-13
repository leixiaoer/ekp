package com.landray.kmss.geesun.org.service.spring;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.transaction.TransactionStatus;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.constant.SysOrgConstant;
import com.landray.kmss.geesun.org.model.GeesunOrgBaseElementModel;
import com.landray.kmss.geesun.org.model.GeesunOrgConfig;
import com.landray.kmss.geesun.org.model.SysSynchroOrgElement;
import com.landray.kmss.geesun.org.service.ISysSynchroOrganService;
import com.landray.kmss.geesun.org.util.SysSynchroOrgConstant;
import com.landray.kmss.sys.notify.interfaces.NotifyContext;
import com.landray.kmss.sys.oms.notify.service.ISynchroOrgNotify;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgDept;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgGroup;
import com.landray.kmss.sys.organization.model.SysOrgOrg;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.organization.model.SysOrgPost;
import com.landray.kmss.sys.organization.model.SysOrganizationStaffingLevel;
import com.landray.kmss.sys.organization.service.IKmssPasswordEncoder;
import com.landray.kmss.sys.organization.service.ISysOrgDeptService;
import com.landray.kmss.sys.organization.service.ISysOrgElementBakService;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.organization.service.ISysOrgGroupService;
import com.landray.kmss.sys.organization.service.ISysOrgOrgService;
import com.landray.kmss.sys.organization.service.ISysOrgPersonService;
import com.landray.kmss.sys.organization.service.ISysOrgPostService;
import com.landray.kmss.sys.organization.service.ISysOrganizationStaffingLevelService;
import com.landray.kmss.sys.organization.util.PasswordUtil;
import com.landray.kmss.sys.organization.util.SysOrgUtil;
import com.landray.kmss.sys.organization.webservice.in.ISysSynchroSetOrgWebService;
import com.landray.kmss.sys.organization.webservice.in.SysSynchroSetOrgContext;
import com.landray.kmss.sys.organization.webservice.in.SysSynchroSetResult;
import com.landray.kmss.sys.organization.webservice.org.SysSynchroStaffingLevelInfo;
import com.landray.kmss.sys.organization.webservice.org.SysSyncroOrgConfig;
import com.landray.kmss.sys.property.custom.DynamicAttributeUtil;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.SecureUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.TransactionUtils;

public class SysSynchroOrganServiceImp implements
		ISysSynchroOrganService, SysSynchroOrgConstant, SysOrgConstant {

	private static final Log logger = LogFactory
			.getLog(SysSynchroOrganServiceImp.class);
	
	public static String EHR_SYNCHRO_IN_BATCH_SIZE = "kmss.ehr.in.batch.size";

	public static String EHR_SYNCHRO_IN_DELETE_SIZE = "kmss.ehr.in.delete.size";
	
	public static String EHR_SYNCHRO_NEW_PERSON_INIT_PASSWORD = "kmss.ehr.new.person.init.password";

	private final int batchCount = 1000;

	private IKmssPasswordEncoder passwordEncoder;

	private ISysOrganizationStaffingLevelService sysOrganizationStaffingLevelService = null;
	
	private SysQuartzJobContext jobContext = null;

	private ISysOrgElementService sysOrgElementService = null;

	private ISysOrgOrgService sysOrgOrgService = null;

	private ISysOrgDeptService sysOrgDeptService = null;

	private ISysOrgPersonService sysOrgPersonService = null;

	private ISysOrgPostService sysOrgPostService = null;

	private ISysOrgGroupService sysOrgGroupService = null;

	private ISysOrgCoreService sysOrgCoreService = null;

	private ISysOrgElementBakService sysOrgElementBakService = null;
	
	private ISynchroOrgNotify synchroOrgNotify;
	
	public ISynchroOrgNotify getSynchroOrgNotify() {
		if (null == synchroOrgNotify) {
			synchroOrgNotify = (ISynchroOrgNotify) SpringBeanUtil
					.getBean("synchroOrgNotify");
		}
		return synchroOrgNotify;
	}
	
	public ISysOrgElementBakService getSysOrgElementBakService() {
		if (null == sysOrgElementBakService) {
			sysOrgElementBakService = (ISysOrgElementBakService) SpringBeanUtil
					.getBean("sysOrgElementBakService");
		}
		return sysOrgElementBakService;
	}

	public ISysOrgElementService getSysOrgElementService() {
		if (null == sysOrgElementService) {
			sysOrgElementService = (ISysOrgElementService) SpringBeanUtil
					.getBean("sysOrgElementService");
		}
		return sysOrgElementService;
	}
	
	public ISysOrgOrgService getSysOrgOrgService() {
		if (null == sysOrgOrgService) {
			sysOrgOrgService = (ISysOrgOrgService) SpringBeanUtil
					.getBean("sysOrgOrgService");
		}
		return sysOrgOrgService;
	}
	
	public ISysOrgDeptService getSysOrgDeptService() {
		if (null == sysOrgDeptService) {
			sysOrgDeptService = (ISysOrgDeptService) SpringBeanUtil
					.getBean("sysOrgDeptService");
		}
		return sysOrgDeptService;
	}

	public ISysOrgPersonService getSysOrgPersonService() {
		if (null == sysOrgPersonService) {
			sysOrgPersonService = (ISysOrgPersonService) SpringBeanUtil
					.getBean("sysOrgPersonService");
		}
		return sysOrgPersonService;
	}

	public ISysOrgPostService getSysOrgPostService() {
		if (null == sysOrgPostService) {
			sysOrgPostService = (ISysOrgPostService) SpringBeanUtil
					.getBean("sysOrgPostService");
		}
		return sysOrgPostService;
	}

	public ISysOrgGroupService getSysOrgGroupService() {
		if (null == sysOrgGroupService) {
			sysOrgGroupService = (ISysOrgGroupService) SpringBeanUtil
					.getBean("sysOrgGroupService");
		}
		return sysOrgGroupService;
	}

	public ISysOrgCoreService getSysOrgCoreService() {
		if (null == sysOrgCoreService) {
			sysOrgCoreService = (ISysOrgCoreService) SpringBeanUtil
					.getBean("sysOrgCoreService");
		}
		return sysOrgCoreService;
	}

	public ISysOrganizationStaffingLevelService getSysOrganizationStaffingLevelService() {
		if (null == sysOrganizationStaffingLevelService) {
			sysOrganizationStaffingLevelService = (ISysOrganizationStaffingLevelService) SpringBeanUtil
					.getBean("sysOrganizationStaffingLevelService");
		}
		return sysOrganizationStaffingLevelService;
	}
	
	public IKmssPasswordEncoder getPasswordEncoder() {
		if (null == passwordEncoder) {
			passwordEncoder = (IKmssPasswordEncoder) SpringBeanUtil
					.getBean("passwordEncoder");
		}
		return passwordEncoder;
	}
	
	private long startTime;
	private long lastEchoTime;
	private int updated;

	private void echoInfo() {
		long elapsedTime = System.currentTimeMillis() - lastEchoTime;
		if (elapsedTime > (60 * 1000)) {
			lastEchoTime = System.currentTimeMillis();
			String info = "";
			long xxx = (lastEchoTime - startTime) / 1000;
			if (xxx > 3600) {
				info += "" + xxx / 3600 + "小时,";
				xxx = xxx % 3600;
			}
			if (xxx > 60) {
				info += "" + xxx / 60 + "分钟,";
				xxx = xxx % 60;
			}
			info += "" + xxx + "秒";

			if (updated > 0) {
				logger.info("组织架构同步正在运行：已经运行" + info + ".更新数目:" + updated);
			} else {
				logger.info("组织架构同步正在运行：已经运行" + info + ".");
			}
		}
	}
	
	/**
	 * 同步所有组织信息,删除没有组织的机构
	 */
	public void syncOrgElementsBaseInfo(SysQuartzJobContext jobContext, 
			List<GeesunOrgBaseElementModel> baseList, SysSynchroSetOrgContext setOrgContext) throws Exception {
		Map<String, Object> argContext = new HashMap<String, Object>();
		if (!checkNullIfNecessary(setOrgContext, null, argContext))
			return;
		String orgInappName = (String)argContext.get("orgInappName");
		Long oms_synchro_start = new Date().getTime();
		logger.info("组织架构同步开始运行");
		GeesunOrgConfig config = new GeesunOrgConfig();
		//备份系统组织架构表
		getSysOrgElementBakService().clean();
		getSysOrgElementBakService().backUp();
		jobContext.logMessage("备份组织架构成功");
		this.updated = 0;
		this.startTime = System.currentTimeMillis();
		this.lastEchoTime = System.currentTimeMillis();
		this.jobContext = jobContext;
		try {
			echoInfo(); // 清除零临时表
			flagDeleted(orgInappName);
			insertOrUpdateBaseInfo(baseList, orgInappName);
			String[] deleteKeywords = getKeywordsForDelete(orgInappName);
			echoInfo();
			TransactionStatus deleteStatus = TransactionUtils.beginNewTransaction();
			try {
				delete(deleteKeywords, orgInappName);
				TransactionUtils.getTransactionManager().commit(deleteStatus);
			} catch (Exception ex) {
				TransactionUtils.getTransactionManager().rollback(deleteStatus);
				throw ex;
			}
			executeUpdate((JSONArray) JSONValue.parse(setOrgContext
					.getOrgJsonData()), argContext, config);
		} catch (Exception ex) {
			StringWriter stringWriter = new StringWriter();
			PrintWriter printWriter = new PrintWriter(stringWriter);
			ex.printStackTrace(printWriter);
			StringBuffer error = stringWriter.getBuffer();
			jobContext.logMessage("组织架构同步时出错:" + error.toString());
			ex.printStackTrace();
			throw ex;
		} finally {
			jobContext.logMessage("组织架构同步结束,共更新" + updated + "条记录");
			logger.info("组织架构同步结束,共更新" + updated + "条记录");
			this.updated = 0;
			long oms_synchro_end = new Date().getTime();
			jobContext.logMessage("组织架构同步耗时："
					+ (oms_synchro_end - oms_synchro_start) / 1000 + "秒");
		}
	}
	
	/**
	 * 执行同步操作
	 */
	private void executeUpdate(JSONArray orgElements,
			Map<String, Object> arguContext, GeesunOrgConfig config) throws Exception {
		logger.debug("执行组织架构更新操作..");
		TransactionStatus updateDtatus = TransactionUtils.beginNewTransaction();
		echoInfo();
		try {
			String batchUpdateSizeString = config
					.getValue(EHR_SYNCHRO_IN_BATCH_SIZE);
			int batchUpdateSize = batchCount;
			if (StringUtil.isNotNull(batchUpdateSizeString)) {
				batchUpdateSize = Integer.parseInt(batchUpdateSizeString);
			}
			getSysOrgElementService().setNotToUpdateRelation(true);
			getSysOrgDeptService().setNotToUpdateRelation(true);
			getSysOrgOrgService().setNotToUpdateRelation(true);
			getSysOrgPersonService().setNotToUpdateRelation(true);
			getSysOrgPostService().setNotToUpdateRelation(true);
			getSysOrgGroupService().setNotToUpdateRelation(true);

			logger.debug("共" + orgElements.size() + "条组织架构数据,需要更新处理.");
			for (int i = 0; i < orgElements.size(); i++) {
				echoInfo();
				if (batchUpdateSize > 0 && updated > 0
						&& ((updated % batchUpdateSize) == 0)) {
					TransactionUtils.getTransactionManager().commit(
							updateDtatus);
					getSysOrgElementService().getBaseDao().getHibernateSession()
							.clear();
					// System.gc();
					updateDtatus = TransactionUtils.beginNewTransaction();
					logger.info("第" + updated / batchUpdateSize + "批次提交组织架构更新处理.");
				}
				SysSynchroOrgElement syncOrgElement = new SysSynchroOrgElement(
						(JSONObject) orgElements.get(i));
				String updateId = syncOrgElement.getId();
				SysOrgElement orgElment = getSysOrgCoreService()
						.format(getSynchroOrgRecord(updateId, arguContext));
				if (orgElment == null)
					continue;
				update(orgElment, syncOrgElement, arguContext);
				updated++;
			}
			TransactionUtils.getTransactionManager().commit(updateDtatus);
			updateDtatus = TransactionUtils.beginNewTransaction();
			echoInfo();
			// 统一更新层级字段fd_hierarchy_id
			getSysOrgElementService().updateRelation();
			echoInfo();
			// 提交事务
			TransactionUtils.getTransactionManager().commit(updateDtatus);
			logger.info("组织架构同步结束!");
		} catch (Exception ex) {
			TransactionUtils.getTransactionManager().rollback(updateDtatus);
			throw ex;
		} finally {
			getSysOrgDeptService().setNotToUpdateRelation(null);
			getSysOrgOrgService().setNotToUpdateRelation(null);
			getSysOrgPersonService().setNotToUpdateRelation(null);
			getSysOrgPostService().setNotToUpdateRelation(null);
			getSysOrgGroupService().setNotToUpdateRelation(null);
			getSysOrgElementService().setNotToUpdateRelation(null);
		}
	}

	/**
	 * 根据临时表数据和现有数据得到需要删除的元素
	 * 
	 * @param providerKey
	 * @return
	 * @throws Exception
	 */
	private String[] getKeywordsForDelete(String providerKey)
			throws Exception {
		String sql = " SELECT fd_id from sys_org_element where fd_import_info like '"
				+ providerKey
				+ "%' and fd_is_available = 1 and fd_flag_deleted = 1";
		List ids = new ArrayList();
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				ids.add(rs.getString(1));
			}
		} catch (Exception ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(rs);
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
		return (String[]) ids.toArray(new String[0]);
	}

	/**
	 * 需要删除的数据
	 * @param deleteKeys
	 * @throws Exception
	 */
	private void delete(String[] keywords, String providerKey) throws Exception {
		logger.info("开始处理需要删除的记录");
		if (keywords == null)
			return;
		jobContext.logMessage("删除组织机构记录数:" + keywords.length + "条记录");
		logger.info("删除组织机构记录数:" + keywords.length + "条记录");
		String deleteSizeStr = new GeesunOrgConfig()
				.getValue(EHR_SYNCHRO_IN_DELETE_SIZE);
		int deleteSize = 0;
		if (StringUtil.isNotNull(deleteSizeStr)) {
			try {
				deleteSize = Integer.parseInt(deleteSizeStr);
				if (keywords.length >= deleteSize) {
					jobContext.logMessage("删除组织机构记录数大于:" + deleteSize
							+ "。不直接执行“置为无效”操作，由管理员手动执行");
					// 通知管理员
					try {
						NotifyContext notifyContext = getSynchroOrgNotify()
								.getSyncExceptionNotifyContext();
						if (notifyContext != null) {

							notifyContext
									.setSubject("组织架构导入时需要删除的记录为："
											+ keywords.length
											+ "。请检查这些数据是否都是需要删除的，如果是则手动执行”置为无效“的操作，否则请检查数据以及oms相关配置！");
							notifyContext
									.setContent("组织架构导入时需要删除的记录为："
											+ keywords.length
											+ "。请检查这些数据是否都是需要删除的，如果是则手动执行”置为无效“的操作，否则请检查数据以及oms相关配置！"
									);
							notifyContext
									.setLink("/sys/organization/sys_org_dept/index.jsp?all=true&fdFlagDeleted=true&fdImportInfo="
											+ providerKey);
							getSynchroOrgNotify().send(null, notifyContext, null);
						}
					} catch (Exception ex) {
						logger.error("组织架构接入通知发送失败", ex);
					}
					return;
				}
			} catch (Exception e) {
				logger.error("组织导入时删除记录数阀值设置不正确", e);
			}
		}

		long time = System.currentTimeMillis();
		for (int i = 0; i < keywords.length; i++) {
			echoInfo();
			SysOrgElement sysOrgElement = getSysOrgCoreService()
					.findByPrimaryKey(keywords[i]);
			if (sysOrgElement != null) {
				sysOrgElement.setFdIsAvailable(new Boolean(false));
				sysOrgElement.getHbmChildren().clear();
				sysOrgElement.setFdFlagDeleted(new Boolean(false));
				// 停用帐号与删除帐号时，都不要将fdImportInfo清空！不然停用后，再启用同一帐号会出现问题。
				getSysOrgElementService().update(sysOrgElement);
				logger.debug("记录置为无效：" + sysOrgElement.getFdId() + "---"
						+ sysOrgElement.getFdNameOri());
			}
		}
		jobContext.logMessage("删除组织机构耗时::"
				+ (System.currentTimeMillis() - time) / 1000 + "s");
	}

	/**
	 * 校验,设置组织架构来源
	 * 
	 * @param orgContext
	 * @return
	 */
	private boolean checkNullIfNecessary(SysSynchroSetOrgContext orgContext,
			SysSynchroSetResult orgResult, Map<String, Object> arguContext) {
		if (orgContext == null) {
			return false;
		}
		if (StringUtil.isNull(orgContext.getOrgJsonData())) {
			return false;
		}
		arguContext.put("orgConfig", new SysSyncroOrgConfig(ORG_WEB_SET_CONFIG_DEFAULT));
		if (StringUtil.isNotNull(orgContext.getAppName())) {
			arguContext.put("orgInappName", orgContext.getAppName());
		} else {
			arguContext.put("orgInappName", ISysSynchroSetOrgWebService.class
					.getName());
		}
		return true;
	}

	private void flagDeleted(String orgInappName) throws Exception {
		logger.debug("设置组织架构待删除标识");
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			ps = conn
					.prepareStatement("update sys_org_element set fd_flag_deleted = 1 where fd_import_info like '" + 
							orgInappName + "%'");
			ps.executeUpdate();
			conn.commit();
		} catch (Exception ex) {
			logger.error("设置待删除标识时出错", ex);
			conn.rollback();
			throw ex;
		} finally {
			// 关闭流
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
	}

	/**
	 * 将所有的 baseList 插入更新
	 * 
	 * @param baseList
	 * @throws Exception
	 */
	private void insertOrUpdateBaseInfo(List<GeesunOrgBaseElementModel> baseList, String orgInappName)
			throws Exception {
		logger.info("开始同步所有记录");
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Connection conn = null;
		PreparedStatement psselect = null;
		PreparedStatement psinsert = null;
		PreparedStatement psinsert2 = null;
		PreparedStatement psupdate_all = null;
		ResultSet rs2 = null;
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			int loop = 0;
			psselect = conn
					.prepareStatement("select fd_id from sys_org_element where (fd_import_info = ? and fd_org_type = ?) or fd_id = ?");

			psinsert = conn
					.prepareStatement(
							"insert into sys_org_element(fd_id,fd_name,fd_org_type,fd_no,fd_keyword,fd_is_available,fd_is_business,fd_import_info,fd_flag_deleted,fd_create_time,fd_name_pinyin,fd_name_simple_pinyin) values(?,?,?,?,?,?,?,?,?,?,?,?)");
			psinsert2 = conn
					.prepareStatement("insert into sys_org_person(fd_id) values(?)");

			psupdate_all = conn
					.prepareStatement("update sys_org_element set fd_name=?,fd_order=?,fd_no=?,fd_keyword=?,fd_flag_deleted=?,fd_name_pinyin=?,fd_name_simple_pinyin=? where fd_id=?");
			for (int i = 0; i < baseList.size(); i ++) {
				GeesunOrgBaseElementModel baseModel = baseList.get(i);
				if (loop > 0 && (loop % 2000 == 0)) {
					psinsert.executeBatch();
					psinsert2.executeBatch();
					psupdate_all.executeBatch();
					conn.commit();
					echoInfo();
				}
				String inportInfo = orgInappName + baseModel.getId();
				psselect.setString(1, inportInfo);
				int orgType = getOrgType(baseModel.getType());
				String fdId = baseModel.getLunid();
				psselect.setInt(2, orgType);
				psselect.setString(3, fdId);
				rs2 = psselect.executeQuery();
				if (rs2.next()) {
					logger.debug("更新记录：" + fdId);
					fdId = rs2.getString(1);
					psupdate_all.setString(1, baseModel.getName());
					if (baseModel.getOrder() == null)
						psupdate_all.setNull(2, Types.INTEGER);
					else
						psupdate_all.setInt(2, Integer.valueOf(baseModel
								.getOrder()));
					psupdate_all.setString(3, baseModel.getNo());
					psupdate_all.setString(4, baseModel.getKeyword());
					psupdate_all.setBoolean(5, false);
					// 增加名称拼音与简拼
					psupdate_all.setString(6, SysOrgUtil.getFullPinyin(baseModel.getName()));
					psupdate_all.setString(7, SysOrgUtil.getSimplePinyin(baseModel.getName()));
					psupdate_all.setString(8, fdId);
					psupdate_all.addBatch();
				} else {
					logger.debug("新增记录：" + fdId);
					psinsert.setString(1, fdId);
					psinsert.setString(2, baseModel.getName());
					psinsert.setInt(3, orgType);
					psinsert.setString(4, baseModel.getNo());
					psinsert.setString(5, baseModel.getKeyword());
					psinsert.setBoolean(6, true);
					psinsert.setBoolean(7, true);
					psinsert.setString(8, inportInfo);
					psinsert.setBoolean(9, false);
					psinsert.setTimestamp(10,
							new Timestamp(new java.util.Date().getTime()));
					// 增加名称拼音与简拼
					psinsert.setString(11, SysOrgUtil.getFullPinyin(baseModel.getName()));
					psinsert.setString(12, SysOrgUtil.getSimplePinyin(baseModel.getName()));
					psinsert.addBatch();
					if (orgType == 8) {
						psinsert2.setString(1, fdId);
//						psinsert2.setString(2, baseModel.getNickName());
						psinsert2.addBatch();
					}
				}
				loop++;
			}
			psinsert.executeBatch();
			psinsert2.executeBatch();
			psupdate_all.executeBatch();
			conn.commit();
			jobContext.logMessage("更新importInfo信息:" + loop);
			logger.info("更新importInfo信息：" + loop);
		} catch (Exception ex) {
			logger.error("同步所有记录时出错", ex);
			conn.rollback();
			throw ex;
		} finally {
			// 关闭流
			if (rs2 != null) {
				try {
					rs2.close();
				} catch (SQLException ex) {
					logger.error("关闭流出错", ex);
				} catch (Throwable ex) {
					logger.error("关闭流出错", ex);
				}
			}
			JdbcUtils.closeStatement(psselect);
			JdbcUtils.closeStatement(psinsert);
			JdbcUtils.closeStatement(psinsert2);
			JdbcUtils.closeStatement(psupdate_all);
			JdbcUtils.closeConnection(conn);
		}
	}
	
	/**
	 * 密码加密
	 * 
	 * @param passStr
	 * @return
	 */
	private String getPersonPass(String passStr) {
		if (StringUtil.isNull(passStr))
			return null;
		return getPasswordEncoder()
				.encodePassword(passStr);
	}

	/**
	 * 组织架构类型读取
	 * 
	 * @param orgWebType
	 * @return
	 */
	private int getOrgType(String orgWebType) {
		int orgType = 0;
		if (ORG_WEB_TYPE_ORG.equalsIgnoreCase(orgWebType)) {
			orgType = ORG_TYPE_ORG;
		} else if (ORG_WEB_TYPE_DEPT.equalsIgnoreCase(orgWebType)) {
			orgType = ORG_TYPE_DEPT;
		} else if (ORG_WEB_TYPE_GROUP.equalsIgnoreCase(orgWebType)) {
			orgType = ORG_TYPE_GROUP;
		} else if (ORG_WEB_TYPE_POST.equalsIgnoreCase(orgWebType)) {
			orgType = ORG_TYPE_POST;
		} else if (ORG_WEB_TYPE_PERSON.equalsIgnoreCase(orgWebType)) {
			orgType = ORG_TYPE_PERSON;
		}
		return orgType;
	}

	private SysOrgElement getSynchroOrgRecord(String keyword,
			Map<String, Object> arguContext) throws Exception {
		keyword = (String) arguContext.get("orgInappName") + keyword;
		SysOrgElement sysOrgElement = getSysOrgCoreService().findByImportInfo(keyword);
		if (sysOrgElement == null)
			return null;
		return sysOrgElement;
	}

	/**
	 * 更新组织架构
	 * 
	 * @param orgElment
	 * @param syncOrgElement
	 * @throws Exception
	 */
	private void update(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, Map<String, Object> arguContext)
			throws Exception {
		if (syncOrgElement.getIsAvailable() != true) {
			orgElment.setFdIsAvailable(new Boolean(false));
			orgElment.getHbmChildren().clear();
			orgElment.setFdFlagDeleted(new Boolean(false));
			getSysOrgElementService().update(orgElment);
			return;
		}
		SysSyncroOrgConfig orgConfig = (SysSyncroOrgConfig) arguContext
				.get("orgConfig");
		if (orgElment instanceof SysOrgOrg) {
			setBaseInfo(orgElment, syncOrgElement, orgConfig.getOrg(),
					arguContext);
			SysOrgOrg orgOrg = (SysOrgOrg) orgElment;
			if (orgConfig.getOrg() == null
					|| orgConfig.getOrg().contains(PARENT)) {
				if (StringUtil.isNotNull(syncOrgElement.getParent())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getParent() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgOrg.setFdParent(orgTemp);
					} else
						orgOrg.setFdParent(null);
				} 
//				else
//					orgOrg.setFdParent(null);
			}
			if (orgConfig.getOrg() == null
					|| orgConfig.getOrg().contains(THIS_LEADER)) {
				if (StringUtil.isNotNull(syncOrgElement.getThisLeader())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getThisLeader() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgOrg.setHbmThisLeader(orgTemp);
					} else
						orgOrg.setHbmThisLeader(null);
				} 
//				else
//					orgOrg.setHbmThisLeader(null);
			}
			if (orgConfig.getOrg() == null
					|| orgConfig.getOrg().contains(SUPER_LEADER)) {
				if (StringUtil.isNotNull(syncOrgElement.getSuperLeader())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getSuperLeader() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgOrg.setHbmSuperLeader(orgTemp);
					} else
						orgOrg.setHbmSuperLeader(null);
				} 
//				else
//					orgOrg.setHbmSuperLeader(null);
			}
			if (syncOrgElement.contains("customProps") && null != syncOrgElement.getCustomProps()) {
				JSONObject props = syncOrgElement.getCustomProps();
				Map<String, Object> map = new HashMap<String, Object>();
				for (Object key : props.keySet()) {
					map.put(key.toString(), props.get(key).toString());
				}
				Map propsMap = DynamicAttributeUtil
						.convertCustomProp(SysOrgOrg.class.getName(), map);
				orgOrg.getCustomPropMap().putAll(propsMap);
			}
			getSysOrgOrgService().update(orgOrg);
		}
		if (orgElment instanceof SysOrgDept) {
			setBaseInfo(orgElment, syncOrgElement, orgConfig.getDept(),
					arguContext);
			SysOrgDept orgDept = (SysOrgDept) orgElment;
			if (orgConfig.getDept() == null
					|| orgConfig.getDept().contains(PARENT)) {
				if (StringUtil.isNotNull(syncOrgElement.getParent())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getParent() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgDept.setFdParent(orgTemp);
					} else
						orgDept.setFdParent(null);
				} 
//				else
//					orgDept.setFdParent(null);
			}
			if (orgConfig.getDept() == null
					|| orgConfig.getDept().contains(THIS_LEADER)) {
				if (StringUtil.isNotNull(syncOrgElement.getThisLeader())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getThisLeader() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgDept.setHbmThisLeader(orgTemp);
					} else
						orgDept.setHbmThisLeader(null);
				} 
//				else
//					orgDept.setHbmThisLeader(null);
			}
			if (orgConfig.getDept() == null
					|| orgConfig.getDept().contains(SUPER_LEADER)) {
				if (StringUtil.isNotNull(syncOrgElement.getSuperLeader())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getSuperLeader() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgDept.setHbmSuperLeader(orgTemp);
					} else
						orgDept.setHbmSuperLeader(null);
				} 
//				else
//					orgDept.setHbmSuperLeader(null);
			}
			if (syncOrgElement.contains("customProps") && null != syncOrgElement.getCustomProps()) {
				JSONObject props = syncOrgElement.getCustomProps();
				Map<String, Object> map = new HashMap<String, Object>();
				for (Object key : props.keySet()) {
					map.put(key.toString(), props.get(key).toString());
				}
				Map propsMap = DynamicAttributeUtil
						.convertCustomProp(SysOrgDept.class.getName(), map);
				orgDept.getCustomPropMap().putAll(propsMap);
			}
			getSysOrgDeptService().update(orgDept);
		}
		if (orgElment instanceof SysOrgGroup) {
			setBaseInfo(orgElment, syncOrgElement, orgConfig.getGroup(),
					arguContext);
			SysOrgGroup orgGroup = (SysOrgGroup) orgElment;
			if (orgConfig.getGroup() == null
					|| orgConfig.getGroup().contains(MEMBERS)) {
				if (syncOrgElement.getMembers() != null) {
					List tmpList = getForeignObj(syncOrgElement.getMembers(),
							(String) arguContext.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						orgGroup.setFdMembers(tmpList);
					} else
						orgGroup.setFdMembers(null);
				} else
					orgGroup.setFdMembers(null);
			}
			getSysOrgGroupService().update(orgGroup);
		}
		if (orgElment instanceof SysOrgPost) {
			setBaseInfo(orgElment, syncOrgElement, orgConfig.getPost(),
					arguContext);
			SysOrgPost orgPost = (SysOrgPost) orgElment;
			if (orgConfig.getPost() == null
					|| orgConfig.getPost().contains(PARENT)) {
				if (StringUtil.isNotNull(syncOrgElement.getParent())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getParent() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgPost.setFdParent(orgTemp);
					} else
						orgPost.setFdParent(null);
				} else
					orgPost.setFdParent(null);
			}
			if (orgConfig.getPost() == null
					|| orgConfig.getPost().contains(THIS_LEADER)) {
				if (StringUtil.isNotNull(syncOrgElement.getThisLeader())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getThisLeader() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgPost.setHbmThisLeader(orgTemp);
					} else
						orgPost.setHbmThisLeader(null);
				} 
//				else
//					orgPost.setHbmThisLeader(null);
			}
			if (orgConfig.getPost() == null
					|| orgConfig.getPost().contains(PERSONS)) {
				if (syncOrgElement.getPersons() != null) {
					List tmpList = getForeignObj(syncOrgElement.getPersons(),
							(String) arguContext.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						orgPost.setFdPersons(tmpList);
					} else
						orgPost.setFdPersons(null);
				} else
					orgPost.setFdPersons(null);
			}
			if (syncOrgElement.contains("customProps") && null != syncOrgElement.getCustomProps()) {
				JSONObject props = syncOrgElement.getCustomProps();
				Map<String, Object> map = new HashMap<String, Object>();
				for (Object key : props.keySet()) {
					map.put(key.toString(), props.get(key).toString());
				}
				Map propsMap = DynamicAttributeUtil
						.convertCustomProp(SysOrgPost.class.getName(), map);
				orgPost.getCustomPropMap().putAll(propsMap);
			}
			getSysOrgPostService().update(orgPost);

		}
		if (orgElment instanceof SysOrgPerson) {
			SysOrgPerson orgPerson = (SysOrgPerson) orgElment;
			setOrgPerson(orgPerson, syncOrgElement, orgConfig.getPerson(),
					arguContext);
			if (orgConfig.getPerson() == null
					|| orgConfig.getPerson().contains(PARENT)) {
				if (StringUtil.isNotNull(syncOrgElement.getParent())) {
					List tmpList = getForeignObj(ArrayUtil
							.convertArrayToList(new String[] { syncOrgElement
									.getParent() }), (String) arguContext
							.get("orgInappName"));
					if (tmpList != null && !tmpList.isEmpty()) {
						SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
						orgPerson.setFdParent(orgTemp);
					} else
						orgPerson.setFdParent(null);
				} else
					orgPerson.setFdParent(null);
			}
			if (orgConfig.getPerson() == null
					|| orgConfig.getPerson().contains(POSTS)) {
				if (syncOrgElement.getPosts() != null) {
					List tmpList = getForeignObj(syncOrgElement.getPosts(),
							(String) arguContext.get("orgInappName"));
					List<SysOrgElement> newTempList = new ArrayList<SysOrgElement>();
					List<SysOrgElement> oldPostList = orgPerson.getFdPosts();
					if (tmpList != null && !tmpList.isEmpty()) {
						newTempList.addAll(tmpList);
					}
					if (!ArrayUtil.isEmpty(oldPostList)) {
						for (SysOrgElement oldPost : oldPostList) {
							if (StringUtil.isNull(oldPost.getFdImportInfo())) {
								newTempList.add(oldPost);
							}
						}
						orgPerson.setFdPosts(newTempList);
					} else {
						orgPerson.setFdPosts(newTempList);
					} 
					//else {
					//	orgPerson.setFdPosts(null);
					//}
				} 
				//else {
				//	orgPerson.setFdPosts(null);
				//}
			}
			if (syncOrgElement.contains("customProps") && null != syncOrgElement.getCustomProps()) {
				JSONObject props = syncOrgElement.getCustomProps();
				Map<String, Object> map = new HashMap<String, Object>();
				for (Object key : props.keySet()) {
					map.put(key.toString(), props.get(key).toString());
				}
				Map propsMap = DynamicAttributeUtil
						.convertCustomProp(SysOrgPerson.class.getName(), map);
				orgPerson.getCustomPropMap().putAll(propsMap);
			}
			getSysOrgPersonService().update(orgPerson);
		}
	}

	private void setBaseInfo(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, List rules,
			Map<String, Object> arguContext) {
		orgElment.setFdName(syncOrgElement.getName());
		if (rules == null || rules.contains(NO)) {
			orgElment.setFdNo(syncOrgElement.getNo());
		}
		//取消排序号同步
		if (rules == null || rules.contains(ORDER)) {
			if (StringUtil.isNotNull(syncOrgElement.getOrder()))
				orgElment
						.setFdOrder(Integer.valueOf(syncOrgElement.getOrder()));
			else
				orgElment.setFdOrder(null);
		}
		if (rules == null || rules.contains(KEYWORD)) {
			if (StringUtil.isNotNull(syncOrgElement.getKeyword())) {
				orgElment.setFdKeyword(syncOrgElement.getKeyword());
			}
		}
		if (rules == null || rules.contains(MEMO)) {
			if (StringUtil.isNotNull(syncOrgElement.getMemo())) {
				orgElment.setFdMemo(syncOrgElement.getMemo());
			}
		}
		orgElment.setFdIsAvailable(syncOrgElement.getIsAvailable());
		orgElment.setFdAlterTime(new Date());
		orgElment.setFdImportInfo(arguContext.get("orgInappName")
				+ syncOrgElement.getId());
	}

	private void setOrgPerson(SysOrgPerson orgPerson,
			SysSynchroOrgElement syncOrgElement, List rules,
			Map<String, Object> arguContext) throws Exception {
		if (rules == null || rules.contains(LOGIN_NAME)) {
			orgPerson.setFdLoginName(syncOrgElement.getLoginName());
		}
		if (StringUtil.isNull(orgPerson.getFdPassword())) {
			GeesunOrgConfig config = new GeesunOrgConfig();
			orgPerson
				.setFdPassword(getPersonPass(config.getValue(EHR_SYNCHRO_NEW_PERSON_INIT_PASSWORD)));
			orgPerson.setFdInitPassword(config.getValue(EHR_SYNCHRO_NEW_PERSON_INIT_PASSWORD));
		}
		if (rules == null || rules.contains(EMAIL)) {
			if (StringUtil.isNotNull(syncOrgElement.getEmail())) {
				orgPerson.setFdEmail(syncOrgElement.getEmail());
			}
		}
		if (rules == null || rules.contains(MOBILE_NO)) {
			if (StringUtil.isNotNull(syncOrgElement.getMobileNo())) {
				orgPerson.setFdMobileNo(syncOrgElement.getMobileNo());
			}
		}
		if (rules == null || rules.contains(ATTENDANCE_CARD_NUMBER)) {
			orgPerson.setFdAttendanceCardNumber(syncOrgElement
					.getAttendanceCardNumber());
		}
		if (rules == null || rules.contains(WORK_PHONE)) {
			if (StringUtil.isNotNull(syncOrgElement.getWorkPhone())) {
				orgPerson.setFdWorkPhone(syncOrgElement.getWorkPhone());
			}
		}
		if (rules == null || rules.contains(NICK_NAME)) {
			orgPerson.setFdNickName(syncOrgElement.getNickName());
		}
		if (rules == null || rules.contains(RTX_NO)) {
			orgPerson.setFdRtxNo(syncOrgElement.getRtx());
		}
		if (rules == null || rules.contains(WECHAT_NO)) {
			orgPerson.setFdWechatNo(syncOrgElement.getWechat());
		}
		if (rules == null || rules.contains(SEX)) {
			orgPerson.setFdSex(syncOrgElement.getSex());
		}
		if (rules == null || rules.contains(SHORT_NO)) {
			orgPerson.setFdShortNo(syncOrgElement.getShortNo());
		}
		setBaseInfo(orgPerson, syncOrgElement, rules, arguContext);
	}

	private List getForeignObj(List searchValue, String orgInappName)
			throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		String whereBlock = " ";
		String temp = "";
		String[] fdids = null;
		if (searchValue != null && !ArrayUtil.isEmpty(searchValue)) {
			if (searchValue.size() == 1) {
				whereBlock = "sysOrgElement.fdImportInfo=:searchName ";
				hqlInfo.setParameter("searchName", orgInappName
						+ searchValue.get(0));
			} else {
				temp = "";
				for (int i = 0; i < searchValue.size(); i++) {
					if (StringUtil.isNotNull((String) searchValue.get(i))) {
						temp += ",'" + orgInappName + searchValue.get(i) + "'";
					}
				}
				if (temp.length() > 0) {
					temp = temp.substring(1);
					whereBlock = " sysOrgElement.fdImportInfo in( " + temp
							+ ") ";
				}
			}
			hqlInfo.setSelectBlock("sysOrgElement.fdId");
			hqlInfo.setWhereBlock(whereBlock);
			fdids = (String[]) getSysOrgElementService().getBaseDao()
					.findValue(hqlInfo).toArray(new String[0]);
			return getSysOrgElementService().findByPrimaryKeys(fdids);
		} else
			return null;
	}

	private String[] getForeignObjIds(List searchValue, String orgInappName)
			throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		String whereBlock = " ";
		String temp = "";
		String[] fdids = null;
		if (searchValue != null && !ArrayUtil.isEmpty(searchValue)) {
			if (searchValue.size() == 1) {
				whereBlock = "sysOrgElement.fdImportInfo=:searchName ";
				hqlInfo.setParameter("searchName", orgInappName
						+ searchValue.get(0));
			} else {
				temp = "";
				for (int i = 0; i < searchValue.size(); i++) {
					if (StringUtil.isNotNull((String) searchValue.get(i))) {
						temp += ",'" + orgInappName + searchValue.get(i) + "'";
					}
				}
				if (temp.length() > 0) {
					temp = temp.substring(1);
					whereBlock = " sysOrgElement.fdImportInfo in( " + temp
							+ ") ";
				}
			}
			hqlInfo.setSelectBlock("sysOrgElement.fdId");
			hqlInfo.setWhereBlock(whereBlock);
			fdids = (String[]) getSysOrgElementService().getBaseDao()
					.findValue(hqlInfo).toArray(new String[0]);
			return fdids;
		} else
			return null;
	}

	private String addStaffingLevel(
			SysSynchroStaffingLevelInfo syncOrgStaffingLevel,
			String orgInappName) throws Exception {
		SysOrganizationStaffingLevel sysOrgStaffingLevel = new SysOrganizationStaffingLevel();
		if (StringUtil.isNotNull(syncOrgStaffingLevel.getId())) {
			sysOrgStaffingLevel.setFdId(syncOrgStaffingLevel.getId());
		}
		setStaffingLevelValue(sysOrgStaffingLevel, syncOrgStaffingLevel,
				orgInappName);
		return sysOrganizationStaffingLevelService.add(sysOrgStaffingLevel);

	}

	private String updateStaffingLevel(
			SysSynchroStaffingLevelInfo syncOrgStaffingLevel,
			String orgInappName) throws Exception {
		String id = syncOrgStaffingLevel.getId();
		if (StringUtil.isNull(id)) {
			return addStaffingLevel(syncOrgStaffingLevel, orgInappName);
		}
		SysOrganizationStaffingLevel sysOrgStaffingLevel = (SysOrganizationStaffingLevel) sysOrganizationStaffingLevelService
				.findByPrimaryKey(id, null, true);
		if (sysOrgStaffingLevel == null) {
			return addStaffingLevel(syncOrgStaffingLevel, orgInappName);
		} else {
			sysOrgStaffingLevel.getFdPersons();
		}
		setStaffingLevelValue(sysOrgStaffingLevel, syncOrgStaffingLevel,
				orgInappName);
		sysOrganizationStaffingLevelService.update(sysOrgStaffingLevel);
		return id;
	}

	private void setStaffingLevelValue(
			SysOrganizationStaffingLevel sysOrgStaffingLevel,
			SysSynchroStaffingLevelInfo syncOrgStaffingLevel,
			String orgInappName) throws Exception {
		sysOrgStaffingLevel.setFdName(syncOrgStaffingLevel.getName());
		sysOrgStaffingLevel.setFdLevel(syncOrgStaffingLevel.getLevel());
		if (syncOrgStaffingLevel.getDescription() != null) {
			sysOrgStaffingLevel.setFdDescription(syncOrgStaffingLevel
					.getDescription());
		}
		sysOrgStaffingLevel.setFdIsDefault(false);

		if (syncOrgStaffingLevel.getPersons() != null) {
			if (syncOrgStaffingLevel.getPersons().size() > 0) {
				String[] ids = getForeignObjIds(syncOrgStaffingLevel
						.getPersons(), orgInappName);
				if (ids != null && ids.length > 0) {
					sysOrgStaffingLevel.setFdPersons(getSysOrgPersonService()
							.findByPrimaryKeys(ids));
				} else
					sysOrgStaffingLevel.setFdPersons(null);
			} else if (syncOrgStaffingLevel.getPersons().size() == 0) {
				sysOrgStaffingLevel.setFdPersons(null);
			}
		}
	}

	private List<String> executeUpdateStaffingLevel(
			JSONArray orgStaffingLevels, String orgInappName) throws Exception {
		logger.debug("执行职务更新操作..");
		TransactionStatus updateDtatus = TransactionUtils.beginNewTransaction();
		int loop = 0;
		try {
			logger.debug("共" + orgStaffingLevels.size() + "条职务数据,需要更新处理.");
			List<String> ids = new ArrayList<String>();
			//SysSynchroStaffingLevelInfo syncOrgStaffingLevel_defaule = null;
			String id_default = null;
			for (int i = 0; i < orgStaffingLevels.size(); i++) {
				if (loop > 0 && (loop % batchCount == 0)) {
					TransactionUtils.getTransactionManager().commit(
							updateDtatus);
					sysOrganizationStaffingLevelService.getBaseDao()
							.getHibernateSession().clear();
					logger.debug("第" + loop / batchCount + "批次提交职务更新处理.");
					updateDtatus = TransactionUtils.beginNewTransaction();
				}
				SysSynchroStaffingLevelInfo syncOrgStaffingLevel = new SysSynchroStaffingLevelInfo(
						(JSONObject) orgStaffingLevels.get(i));
				
				String id = updateStaffingLevel(syncOrgStaffingLevel,
						orgInappName);
				if(syncOrgStaffingLevel.getIsDefault()){
					id_default = id;
				}
				ids.add(id);
			}
			TransactionUtils.getTransactionManager().commit(updateDtatus);
			
			
			SysOrganizationStaffingLevel sysOrgStaffingLevel = (SysOrganizationStaffingLevel) sysOrganizationStaffingLevelService
			.findByPrimaryKey(id_default, null, true);
			if (sysOrgStaffingLevel != null) {
				sysOrgStaffingLevel.setFdIsDefault(true);
				sysOrganizationStaffingLevelService.update(sysOrgStaffingLevel);
			} 
			logger.info("职务同步结束!");
			return ids;
		} catch (Exception ex) {
			TransactionUtils.getTransactionManager().rollback(updateDtatus);
			logger.error(ex);
			throw ex;
		}
	}

	private List<String> executeDelStaffingLevel(JSONArray orgStaffingLevels) {
		logger.debug("执行职务删除操作..");

		logger.debug("共" + orgStaffingLevels.size() + "条职务数据,需要删除处理.");
		List<String> results = new ArrayList<String>();
		for (int i = 0; i < orgStaffingLevels.size(); i++) {

			SysSynchroStaffingLevelInfo syncOrgStaffingLevel = new SysSynchroStaffingLevelInfo(
					(JSONObject) orgStaffingLevels.get(i));
			try {
				sysOrganizationStaffingLevelService.delete(syncOrgStaffingLevel
						.getId());
				results.add("success");
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e);
				results.add(e.getMessage());
			}
		}
		logger.info("职务删除结束!");
		return results;

	}

	@Override
	public SysSynchroSetResult updateOrgStaffingLevels(
			SysSynchroSetOrgContext setOrgContext) throws Exception {
		SysSynchroSetResult setResult = new SysSynchroSetResult();
		setResult.setReturnState(OPT_ORG_STATUS_NOOPT);
		String orgInappName = null;
		if (StringUtil.isNotNull(setOrgContext.getAppName())) {
			orgInappName = setOrgContext.getAppName();
		} else {
			orgInappName = ISysSynchroSetOrgWebService.class.getName();
		}
		List<String> ids = executeUpdateStaffingLevel((JSONArray) JSONValue
				.parse(setOrgContext.getOrgJsonData()), orgInappName);
		String message = "";
		for (String id : ids) {
			message += ",\"" + id + "\"";
		}
		if (message.length() > 0) {
			message = message.substring(1);
		}
		message = "[" + message + "]";
		setResult.setMessage(message);
		setResult.setReturnState(OPT_ORG_STATUS_SUCCESS);
		return setResult;
	}

	@Override
	public SysSynchroSetResult delOrgStaffingLevels(
			SysSynchroSetOrgContext setOrgContext) throws Exception {
		SysSynchroSetResult setResult = new SysSynchroSetResult();
		setResult.setReturnState(OPT_ORG_STATUS_NOOPT);
		List<String> results = executeDelStaffingLevel((JSONArray) JSONValue
				.parse(setOrgContext.getOrgJsonData()));
		String message = "";
		for (String result : results) {
			message += ",\"" + result + "\"";
		}
		if (message.length() > 0) {
			message = message.substring(1);
		}
		message = "[" + message + "]";
		setResult.setMessage(message);
		setResult.setReturnState(OPT_ORG_STATUS_SUCCESS);
		return setResult;
	}
	
	@Override
	public SysSynchroSetResult updateOrgElement(
			SysSynchroSetOrgContext setOrgContext) throws Exception {
		SysSynchroSetResult setResult = new SysSynchroSetResult();
		setResult.setReturnState(OPT_ORG_STATUS_NOOPT);
		Map<String, Object> arguContext = new HashMap<String, Object>();
		if (!checkNullIfNecessary(setOrgContext, setResult, arguContext))
			return setResult;
		JSONArray orgElements = (JSONArray) JSONValue.parse(setOrgContext
				.getOrgJsonData());
		for (int i = 0; i < orgElements.size(); i++) {
			JSONObject object = (JSONObject) orgElements.get(i);
			if (!object.containsKey(ID)) {
				setResult.setReturnState(OPT_ORG_STATUS_FAIL);
				setResult.setMessage("id属性不能为空!");
				return setResult;
			}
			if (!object.containsKey(TYPE)) {
				setResult.setReturnState(OPT_ORG_STATUS_FAIL);
				setResult.setMessage("type属性不能为空!");
				return setResult;
			}
			executeAddOrUpdate(object, arguContext);
		}
		setResult.setReturnState(OPT_ORG_STATUS_SUCCESS);
		return setResult;
	}

	private void executeAddOrUpdate(JSONObject orgElement,
			Map<String, Object> arguContext) throws Exception {
		logger.debug("执行组织架构更新操作..");
		try {
			SysSynchroOrgElement syncOrgElement = new SysSynchroOrgElement(
					orgElement);
			String updateId = syncOrgElement.getId();
			SysOrgElement orgElment = getSysOrgCoreService()
					.format(getSynchroOrgRecord(updateId, arguContext));
			if (orgElment == null) {
				int orgType = 0;
				Object type = orgElement.get(TYPE);
				if (type != null) {
					orgType = getOrgType((String) type);
				}
				if (orgType == 0) {
					throw new Exception("组织架构类型设置不正确：" + type);
				}
				switch (orgType) {
				case ORG_TYPE_ORG:
					orgElment = new SysOrgOrg();
					break;
				case ORG_TYPE_DEPT:
					orgElment = new SysOrgDept();
					break;
				case ORG_TYPE_PERSON:
					orgElment = new SysOrgPerson();
					break;
				case ORG_TYPE_GROUP:
					orgElment = new SysOrgGroup();
					break;
				case ORG_TYPE_POST:
					orgElment = new SysOrgPost();
					break;

				}
				add(orgElment, syncOrgElement,
						(String) arguContext.get("orgInappName"));
			} else {
				update(orgElment, syncOrgElement,
						(String) arguContext.get("orgInappName"));
			}
			// 统一更新层级字段fd_hierarchy_id
			logger.info("组织架构同步结束!");
		} catch (Exception ex) {
			logger.error(ex);
			throw ex;
		}
	}
	
	private void add(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		if (syncOrgElement.contains(LUNID)) {
			orgElment.setFdId(syncOrgElement.getLunid());
		}
		if (orgElment instanceof SysOrgOrg) {
			SysOrgOrg orgOrg = setOrgInfo(orgElment, syncOrgElement, appName);
			getSysOrgOrgService().add(orgOrg);
		}
		if (orgElment instanceof SysOrgDept) {
			SysOrgDept orgDept = setDeptInfo(orgElment, syncOrgElement,
					appName);
			getSysOrgDeptService().add(orgDept);
		}
		if (orgElment instanceof SysOrgGroup) {
			SysOrgGroup orgGroup = setGroupInfo(orgElment, syncOrgElement,
					appName);
			getSysOrgGroupService().add(orgGroup);
		}
		if (orgElment instanceof SysOrgPost) {
			SysOrgPost orgPost = setPostInfo(orgElment, syncOrgElement,
					appName);
			getSysOrgPostService().add(orgPost);
		}
		if (orgElment instanceof SysOrgPerson) {
			SysOrgPerson orgPerson = setPersonInfo(orgElment, syncOrgElement,
					appName);
			getSysOrgPersonService().add(orgPerson);
		}
	}
	
	private void updateParent(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		if (syncOrgElement.contains(PARENT)) {
			if (StringUtil.isNotNull(syncOrgElement.getParent())) {
				List tmpList = getForeignObj(ArrayUtil
						.convertArrayToList(new String[] { syncOrgElement
								.getParent() }),
						appName);
				if (tmpList != null && !tmpList.isEmpty()) {
					SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
					orgElment.setFdParent(orgTemp);
				} else
					orgElment.setFdParent(null);
			} else
				orgElment.setFdParent(null);
		}
	}

	private void updateThisLeader(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		if (syncOrgElement.contains(THIS_LEADER)) {
			if (StringUtil.isNotNull(syncOrgElement.getThisLeader())) {
				List tmpList = getForeignObj(ArrayUtil
						.convertArrayToList(new String[] { syncOrgElement
								.getThisLeader() }),
						appName);
				if (tmpList != null && !tmpList.isEmpty()) {
					SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
					orgElment.setHbmThisLeader(orgTemp);
				} else
					orgElment.setHbmThisLeader(null);
			} 
//			else
//				orgElment.setHbmThisLeader(null);
		}
	}

	private void updateSuperLeader(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		if (syncOrgElement.contains(SUPER_LEADER)) {
			if (StringUtil.isNotNull(syncOrgElement.getSuperLeader())) {
				List tmpList = getForeignObj(ArrayUtil
						.convertArrayToList(new String[] { syncOrgElement
								.getSuperLeader() }),
						appName);
				if (tmpList != null && !tmpList.isEmpty()) {
					SysOrgElement orgTemp = (SysOrgElement) tmpList.get(0);
					orgElment.setHbmSuperLeader(orgTemp);
				} else
					orgElment.setHbmSuperLeader(null);
			} 
//			else
//				orgElment.setHbmSuperLeader(null);
		}
	}

	private SysOrgOrg setOrgInfo(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		setBaseInfo(orgElment, syncOrgElement, appName);
		SysOrgOrg orgOrg = (SysOrgOrg) orgElment;
		updateParent(orgElment, syncOrgElement, appName);
		updateThisLeader(orgElment, syncOrgElement, appName);
		updateSuperLeader(orgElment, syncOrgElement, appName);
		if (syncOrgElement.contains("customProps") && null != syncOrgElement.getCustomProps()) {
			JSONObject props = syncOrgElement.getCustomProps();
			Map<String, Object> map = new HashMap<String, Object>();
			for (Object key : props.keySet()) {
				map.put(key.toString(), props.get(key).toString());
			}
			Map propsMap = DynamicAttributeUtil
					.convertCustomProp(SysOrgOrg.class.getName(), map);
			orgOrg.getCustomPropMap().putAll(propsMap);
		}
		return orgOrg;
	}

	private SysOrgDept setDeptInfo(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		setBaseInfo(orgElment, syncOrgElement, appName);
		SysOrgDept orgDept = (SysOrgDept) orgElment;
		updateParent(orgElment, syncOrgElement, appName);
		updateThisLeader(orgElment, syncOrgElement, appName);
		updateSuperLeader(orgElment, syncOrgElement, appName);
		if (syncOrgElement.contains("customProps") && null != syncOrgElement.getCustomProps()) {
			JSONObject props = syncOrgElement.getCustomProps();
			Map<String, Object> map = new HashMap<String, Object>();
			for (Object key : props.keySet()) {
				map.put(key.toString(), props.get(key).toString());
			}
			Map propsMap = DynamicAttributeUtil
					.convertCustomProp(SysOrgDept.class.getName(), map);
			orgDept.getCustomPropMap().putAll(propsMap);
		}
		return orgDept;
	}

	private SysOrgPerson setPersonInfo(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		SysOrgPerson orgPerson = (SysOrgPerson) orgElment;
		setOrgPerson(orgPerson, syncOrgElement, appName);
		updateParent(orgElment, syncOrgElement, appName);
		if (syncOrgElement.contains(POSTS)) {
			if (syncOrgElement.getPosts() != null) {
				List tmpList = getForeignObj(syncOrgElement.getPosts(),
						appName);
				if (tmpList != null && !tmpList.isEmpty()) {
					orgPerson.setFdPosts(tmpList);
				} else
					orgPerson.setFdPosts(null);
			} else
				orgPerson.setFdPosts(null);
		}
		if (syncOrgElement.contains("customProps") && null != syncOrgElement.getCustomProps()) {
			JSONObject props = syncOrgElement.getCustomProps();
			Map<String, Object> map = new HashMap<String, Object>();
			for (Object key : props.keySet()) {
				map.put(key.toString(), props.get(key).toString());
			}
			Map propsMap = DynamicAttributeUtil
					.convertCustomProp(SysOrgPerson.class.getName(), map);
			orgPerson.getCustomPropMap().putAll(propsMap);
		}
		return orgPerson;
	}

	private SysOrgGroup setGroupInfo(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		setBaseInfo(orgElment, syncOrgElement, appName);
		SysOrgGroup orgGroup = (SysOrgGroup) orgElment;
		if (syncOrgElement.contains(MEMBERS)) {
			if (syncOrgElement.getMembers() != null) {
				List tmpList = getForeignObj(syncOrgElement.getMembers(),
						appName);
				if (tmpList != null && !tmpList.isEmpty()) {
					orgGroup.setFdMembers(tmpList);
				} else
					orgGroup.setFdMembers(null);
			} else
				orgGroup.setFdMembers(null);
		}
		return orgGroup;
	}

	private SysOrgPost setPostInfo(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		setBaseInfo(orgElment, syncOrgElement, appName);
		SysOrgPost orgPost = (SysOrgPost) orgElment;
		updateParent(orgElment, syncOrgElement, appName);
		updateThisLeader(orgElment, syncOrgElement, appName);
		if (syncOrgElement.contains(PERSONS)) {
			if (syncOrgElement.getPersons() != null) {
				List tmpList = getForeignObj(syncOrgElement.getPersons(),
						appName);
				if (tmpList != null && !tmpList.isEmpty()) {
					orgPost.setFdPersons(tmpList);
				} else
					orgPost.setFdPersons(null);
			} else
				orgPost.setFdPersons(null);
		}
		if (syncOrgElement.contains("customProps") && null != syncOrgElement.getCustomProps()) {
			JSONObject props = syncOrgElement.getCustomProps();
			Map<String, Object> map = new HashMap<String, Object>();
			for (Object key : props.keySet()) {
				map.put(key.toString(), props.get(key).toString());
			}
			Map propsMap = DynamicAttributeUtil
					.convertCustomProp(SysOrgPost.class.getName(), map);
			orgPost.getCustomPropMap().putAll(propsMap);
		}
		return orgPost;
	}

	private void update(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName)
			throws Exception {
		if (syncOrgElement.getIsAvailable() != true) {
			orgElment.setFdIsAvailable(new Boolean(false));
			orgElment.getHbmChildren().clear();
			orgElment.setFdFlagDeleted(new Boolean(false));
			getSysOrgElementService().update(orgElment);
			return;
		}
		if (orgElment instanceof SysOrgOrg) {
			SysOrgOrg orgOrg = setOrgInfo(orgElment, syncOrgElement, appName);
			getSysOrgOrgService().update(orgOrg);
		}
		if (orgElment instanceof SysOrgDept) {
			SysOrgDept orgDept = setDeptInfo(orgElment, syncOrgElement,
					appName);
			getSysOrgDeptService().update(orgDept);
		}
		if (orgElment instanceof SysOrgGroup) {
			SysOrgGroup orgGroup = setGroupInfo(orgElment, syncOrgElement,
					appName);
			getSysOrgGroupService().update(orgGroup);
		}
		if (orgElment instanceof SysOrgPost) {
			SysOrgPost orgPost = setPostInfo(orgElment, syncOrgElement,
					appName);
			getSysOrgPostService().update(orgPost);
		}
		if (orgElment instanceof SysOrgPerson) {
			SysOrgPerson orgPerson = setPersonInfo(orgElment, syncOrgElement,
					appName);
			getSysOrgPersonService().update(orgPerson);
		}
	}
	
	private void setBaseInfo(SysOrgElement orgElment,
			SysSynchroOrgElement syncOrgElement, String appName) {
		orgElment.setFdName(syncOrgElement.getName());
		if (syncOrgElement.contains(NO)) {
			orgElment.setFdNo(syncOrgElement.getNo());
		}
		if (syncOrgElement.contains(ORDER)) {
			if (StringUtil.isNotNull(syncOrgElement.getOrder())) {
				orgElment
						.setFdOrder(Integer.valueOf(syncOrgElement.getOrder()));
			}
		}
		if (syncOrgElement.contains(KEYWORD)) {
			if (StringUtil.isNotNull(syncOrgElement.getKeyword())) {
				orgElment.setFdKeyword(syncOrgElement.getKeyword());
			}
		}
		if (syncOrgElement.contains(MEMO)) {
			if (StringUtil.isNotNull(syncOrgElement.getMemo())) {
				orgElment.setFdMemo(syncOrgElement.getMemo());
			}
		}
		orgElment.setFdIsAvailable(syncOrgElement.getIsAvailable());
		orgElment.setFdAlterTime(new Date());
		orgElment.setFdImportInfo(appName
				+ syncOrgElement.getId());
	}

	private void setOrgPerson(SysOrgPerson orgPerson,
			SysSynchroOrgElement syncOrgElement, String appName) throws Exception {
		if (syncOrgElement.contains(LOGIN_NAME)) {
			orgPerson.setFdLoginName(syncOrgElement.getLoginName());
		}
		if (syncOrgElement.contains(PASSWORD)) {
			if (StringUtil.isNull(orgPerson.getFdPassword())) {
				GeesunOrgConfig config = new GeesunOrgConfig();
				orgPerson
					.setFdPassword(getPersonPass(config.getValue(EHR_SYNCHRO_NEW_PERSON_INIT_PASSWORD)));
				orgPerson.setFdInitPassword(config.getValue(EHR_SYNCHRO_NEW_PERSON_INIT_PASSWORD));
			}
		}
		if (syncOrgElement.contains(MOBILE_NO)) {
			if (StringUtil.isNotNull(syncOrgElement.getMobileNo())) {
				orgPerson.setFdMobileNo(syncOrgElement.getMobileNo());
			}
		}
		if (syncOrgElement.contains(ATTENDANCE_CARD_NUMBER)) {
			orgPerson.setFdAttendanceCardNumber(syncOrgElement
					.getAttendanceCardNumber());
		}
		if (syncOrgElement.contains(WORK_PHONE)) {
			if (StringUtil.isNotNull(syncOrgElement.getWorkPhone())) {
				orgPerson.setFdWorkPhone(syncOrgElement.getWorkPhone());
			}
		}
		if (syncOrgElement.contains(RTX_NO)) {
			orgPerson.setFdRtxNo(syncOrgElement.getRtx());
		}
		if (syncOrgElement.contains(WECHAT_NO)) {
			if (StringUtil.isNotNull(syncOrgElement.getWechat())) {
				orgPerson.setFdWechatNo(syncOrgElement.getWechat());
			}
		}
		if (syncOrgElement.contains(NICK_NAME)) {
			orgPerson.setFdNickName(syncOrgElement.getNickName());
		}
		if (syncOrgElement.contains(SEX)) {
			orgPerson.setFdSex(syncOrgElement.getSex());
		}
		if (syncOrgElement.contains(SHORT_NO)) {
			if (StringUtil.isNotNull(syncOrgElement.getShortNo())) {
				orgPerson.setFdShortNo(syncOrgElement.getShortNo());
			}
		}
		setBaseInfo(orgPerson, syncOrgElement, appName);
	}

}
