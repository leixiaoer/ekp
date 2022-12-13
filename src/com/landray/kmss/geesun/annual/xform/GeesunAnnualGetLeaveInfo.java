package com.landray.kmss.geesun.annual.xform;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.geesun.annual.model.GeesunAnnualConfig;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.sys.config.loader.ConfigLocationsUtil;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.organization.service.ISysOrgPersonService;
import com.landray.kmss.sys.xform.base.service.controls.relation.RelationParamsField;
import com.landray.kmss.sys.xform.base.service.controls.relation.SysFormRelationAdapta;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

/**
 * 根据用户获取对应结束的请假信息
 * @author 郭玉平
 */
public class GeesunAnnualGetLeaveInfo extends SysFormRelationAdapta {
	
	private Log logger = LogFactory.getLog(GeesunAnnualGetLeaveInfo.class);
	
	protected IKmReviewMainService kmReviewMainService;
	
	public IKmReviewMainService getKmReviewMainService() {
		if (kmReviewMainService == null) {
			kmReviewMainService = (IKmReviewMainService) SpringBeanUtil
					.getBean("kmReviewMainService");
		}
		return kmReviewMainService;
	}
	
	protected ISysOrgPersonService sysOrgPersonService;
	
	public ISysOrgPersonService getSysOrgPersonService() {
		if (sysOrgPersonService == null) {
			sysOrgPersonService = (ISysOrgPersonService) SpringBeanUtil
					.getBean("sysOrgPersonService");
		}
		return sysOrgPersonService;
	}
	
	/**
	 * @param key和扩展点中sourceUUID匹配
	 * @searchs 事件控件搜索条件的值
	 * @ins 传入参数的值 RelationParamsField中fieldIdForm对应表单的ID
	 *      fieldValueForm对应该表单字段的值
	 */
	@Override
	protected List<List<RelationParamsField>> getData(String key,
			List<RelationParamsField> searchs, List<RelationParamsField> ins) {
		String personId = "";
		String subject = "";
		String number = "";
		//解析出传入参数
		if (!ArrayUtil.isEmpty(ins)) {
			for (RelationParamsField field : ins) {
				if ("personId".equals(field.getFieldId())) {
					personId = field.getFieldValueForm();
				}
			}
		}
		//解析出传入参数
		if (!ArrayUtil.isEmpty(searchs)) {
			for (RelationParamsField field : searchs) {
				if ("subject".equals(field.getFieldId())) {
					subject = field.getFieldValue();
				}
				if ("number".equals(field.getFieldId())) {
					number = field.getFieldValue();
				}
			}
		}
		List<List<RelationParamsField>> rows = new ArrayList<List<RelationParamsField>>();
		if (StringUtil.isNull(personId)) {
			return rows;
		}
		try {
			GeesunAnnualConfig config = new GeesunAnnualConfig();
			if (StringUtil.isNotNull(config.getFdTemplateIds())) {
				List<String> leaveIdList = getResumedLeaveIdList(personId);
				HQLInfo hql = new HQLInfo();
				String where = "kmReviewMain.docCreator.fdId=:docCreatorId and kmReviewMain.fdTemplate.fdId=:fdTemplateId "
						+ "and kmReviewMain.docStatus=:docStatus";
				if (!ArrayUtil.isEmpty(leaveIdList)) {
					where = StringUtil.linkString(where, " and ", "kmReviewMain.fdId not in (:reviewIds)");
					hql.setParameter("reviewIds", leaveIdList);
				}
				if (StringUtil.isNotNull(subject)) {
					where = StringUtil.linkString(where, " and ", "upper(kmReviewMain.docSubject) like:subject");
					hql.setParameter("subject", "%" + subject.trim().toUpperCase() + "%");
				}
				if (StringUtil.isNotNull(number)) {
					where = StringUtil.linkString(where, " and ", "upper(kmReviewMain.fdNumber) like:number");
					hql.setParameter("number", "%" + number.trim().toUpperCase() + "%");
				}
				hql.setWhereBlock(where);
				hql.setParameter("docStatus", SysDocConstant.DOC_STATUS_PUBLISH);
				hql.setParameter("docCreatorId", personId);
				hql.setParameter("fdTemplateId", config.getFdTemplateIds());
				List<KmReviewMain> reviewList = getKmReviewMainService().findList(hql);
				if (!ArrayUtil.isEmpty(reviewList)) {
					for (KmReviewMain review : reviewList) {
						Map<String, Object> data = review.getExtendDataModelInfo()
								.getModelData();// 自定义表单内容
						List<RelationParamsField> columns = new ArrayList<RelationParamsField>();
						Date begin = null;
						Date end = null;
						String fdLeaveType = (null!= data.get("fd_395a0c2b56a790"))?data.get("fd_395a0c2b56a790").toString():"0";
						Date beginDate = (null!= data.get("fd_39443cd6b60ebe"))?(Date)data.get("fd_39443cd6b60ebe"):null;
						Date endDate = (null!= data.get("fd_39443cdd503ed6"))?(Date)data.get("fd_39443cdd503ed6"):null;
						Date beginTime = (null!= data.get("fd_3968fd2698034e"))?(Date)data.get("fd_3968fd2698034e"):null;
						Date endTime = (null!= data.get("fd_3968fd27cef0fc"))?(Date)data.get("fd_3968fd27cef0fc"):null;
						SysOrgPerson leaver = findOrg((Map)data.get("fd_395a0b5847e700"));
						int fdLeaveTypeVaue = Double.valueOf(fdLeaveType).intValue();
						if (fdLeaveTypeVaue > 11) {
							begin = beginTime;
							end = endTime;
						} else {
							begin = new Date(DateUtil.getDateTimeNumber(beginDate, DateUtil.convertStringToDate("00:00", "HH:mm")));
							end = new Date(DateUtil.getDateTimeNumber(endDate, DateUtil.convertStringToDate("23:59", "HH:mm")));
						}
						columns.add(new RelationParamsField("leaveId", "请假单ID", review.getFdId()));
						columns.add(new RelationParamsField("subject", "标题", review.getDocSubject()));
						columns.add(new RelationParamsField("number", "单据编号", review.getFdNumber()));
						columns.add(new RelationParamsField("leaverId", "请假人ID", leaver.getFdId()));
						columns.add(new RelationParamsField("name", "姓名", leaver.getFdName()));
						columns.add(new RelationParamsField("deptId", "部门ID", leaver.getFdParent().getFdId()));
						columns.add(new RelationParamsField("deptName", "部门名称", leaver.getFdParent().getFdName()));
						columns.add(new RelationParamsField("leaveTypeValue", "请假类型实际值", String.valueOf(fdLeaveTypeVaue)));
						columns.add(new RelationParamsField("leaveType", "请假类型", ResourceUtil.getString("geesunAnnualMain.fdLeaveType." + fdLeaveTypeVaue, "geesun-annual")));
						columns.add(new RelationParamsField("beginTime", "请假开始时间", DateUtil
								.convertDateToString(begin, "yyyy-MM-dd HH:mm")));
						columns.add(new RelationParamsField("endTime", "请假结束时间", DateUtil
								.convertDateToString(end, "yyyy-MM-dd HH:mm")));
						rows.add(columns);
					}
				}
			} else {
				logger.error("未配置请休假模板ID信息");
			}
		} catch (Exception e) {
			logger.error("根据人员ID获取请假信息出错", e);
		}
		return rows;
	}

	/**
	 * @param key和扩展点中sourceUUID匹配
	 */
	@Override
	protected File getTemplateFile(String key) {
		return new File(ConfigLocationsUtil
				.getWebContentPath()
				+ "/geesun/annual/xform/leaveRecordInfo.xml");
	}
	
	/**
	 * 根据已用被销假单使用的请假单ID
	 * @param fdId
	 * @return
	 * @throws Exception
	 */
	private List<String> getResumedLeaveIdList(String docCreatorId) throws Exception {
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		List<String> leaveIdList = new ArrayList<String>();
		Connection connect = null;
		PreparedStatement selectResumedLeaveIds = null;
		ResultSet resultSet = null;
		try {
			connect = dataSource.getConnection();
			connect.setAutoCommit(false);
			selectResumedLeaveIds = connect
					.prepareStatement("select distinct fd_leave_id from ekp_kq_xiaojia where fd_shenQingRenXingMing = ?");
			selectResumedLeaveIds.setString(1, docCreatorId);
			resultSet = selectResumedLeaveIds.executeQuery();
			while (resultSet.next()) {
				leaveIdList.add(resultSet.getString(1));
			}
		} catch (SQLException ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(selectResumedLeaveIds);
			JdbcUtils.closeConnection(connect);
		}
		return leaveIdList;
	}
	
	private SysOrgPerson findOrg(Map orgMap) throws Exception {
		if (orgMap == null || orgMap.size() <= 0) {
			return null;
		}
		SysOrgPerson org = (SysOrgPerson) getSysOrgPersonService()
				.findByPrimaryKey(orgMap.get("id").toString(),
						SysOrgPerson.class, true);
		return org;
	}
	
}
