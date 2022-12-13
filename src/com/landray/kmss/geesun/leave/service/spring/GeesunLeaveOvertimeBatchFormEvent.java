package com.landray.kmss.geesun.leave.service.spring;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataEvent;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataModel;
import com.landray.kmss.sys.metadata.interfaces.ISysMetadataParser;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 批量加班提交写入加班记录表
 * @author 郭玉平
 *
 */
public class GeesunLeaveOvertimeBatchFormEvent implements IExtendDataEvent {
	private static final Log logger = LogFactory
			.getLog(GeesunLeaveOvertimeBatchFormEvent.class);
	
	@Override
	public void onAdd(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		addOrUpdateOrDeleteAdjust(kmReviewMain, dataParser, "ADD");
	}

	@Override
	public void onDelete(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		addOrUpdateOrDeleteAdjust(kmReviewMain, dataParser, "DELETE");
	}

	@Override
	public void onInit(RequestContext request, IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
	}
	
	@Override
	public void onUpdate(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		addOrUpdateOrDeleteAdjust(kmReviewMain, dataParser, "UPDATE");
	}
	
	/**
	 * 插入、更新或者删除加班表记录
	 * @param kmReviewMain
	 * @param dataParser
	 * @throws fdType
	 */
	public void addOrUpdateOrDeleteAdjust(KmReviewMain kmReviewMain, 
			ISysMetadataParser dataParser, String fdType) throws Exception {
		List<String> deptList = (List<String>) dataParser.getFieldValue(kmReviewMain,
				"fd_3adfea1f6aea9c.fd_3982e650de503a", true);//所属部门ID
		List<SysOrgPerson> fdApplyerList = (List<SysOrgPerson>) dataParser.getFieldValue(kmReviewMain,
				"fd_3adfea1f6aea9c.fd_395a0e397f83b2", true);//加班申请人
		List<String> fdDetailIdList = (List<String>) dataParser.getFieldValue(kmReviewMain,
				"fd_3adfea1f6aea9c.fdId", true);//明细ID集合
		List<Date> fdBeginDateList = (List<Date>) dataParser.getFieldValue(kmReviewMain,
				"fd_3adfea1f6aea9c.fd_39443cd6b60ebe", true);
		List<Date> fdEndDateList = (List<Date>) dataParser.getFieldValue(kmReviewMain,
				"fd_3adfea1f6aea9c.fd_395a06218b7eae", true);
		List<String> fdHourList = (List<String>) dataParser.getFieldValue(kmReviewMain,
				"fd_3adfea1f6aea9c.fd_396de00b2f804a", true);
		if (!ArrayUtil.isEmpty(fdApplyerList)) {
			DataSource dataSource = (DataSource) SpringBeanUtil
					.getBean("dataSource");
			Connection connect = null;
			PreparedStatement sql = null;
			PreparedStatement selectSql = null;
			ResultSet resultSet = null;
			boolean needCommit = false;
			try {
//				KmReviewMain oldMain = (KmReviewMain) getKmReviewMainService().findByPrimaryKey(kmReviewMain
//						.getFdId(), null, true);
//				if (null == oldMain || (null != oldMain && 
//						!oldMain.getDocStatus().equals(kmReviewMain.getDocStatus()))) {
					connect = dataSource.getConnection();
					connect.setAutoCommit(false);
					if ("ADD".equals(fdType)) {
						sql = connect
								.prepareStatement("insert into geesun_leave_adjust(fd_id, doc_subject , "
										+ "fd_start_time, fd_end_time, doc_creator_id, doc_dept_id, doc_create_time, fd_leave_hour, fd_model_id, fd_detail_id) "
										+ "values(?,?,?,?,?,?,?,?,?,?)");
					} else if ("UPDATE".equals(fdType)) {
						sql = connect
								.prepareStatement("update geesun_leave_adjust set doc_subject = ?, fd_start_time = ?, fd_end_time = ?, "
										+ " doc_creator_id = ?, doc_dept_id = ?, fd_leave_hour = ? where fd_model_id = ? and fd_detail_id = ?");
					} else if ("DELETE".equals(fdType)) {
						sql = connect
								.prepareStatement("delete from geesun_leave_adjust where fd_model_id = ?");
					}
					for (int i = 0; i < fdApplyerList.size(); i ++) {
						SysOrgPerson applyer = fdApplyerList.get(i);
						if (!SysDocConstant.DOC_STATUS_DRAFT.equals(kmReviewMain.getDocStatus())) {
							needCommit = true;
							String fdDeptId = deptList.get(i);
							String fdDetailId = fdDetailIdList.get(i);
							Date fdBeginDate = fdBeginDateList.get(i);
							Date fdEndDate = fdEndDateList.get(i);
							String fdHour = fdHourList.get(i);
							if ("ADD".equals(fdType)) {
								sql.setString(1, IDGenerator.generateID());
								sql.setString(2, kmReviewMain.getDocSubject());
								sql.setTimestamp(3, new Timestamp(fdBeginDate.getTime()));
								sql.setTimestamp(4, new Timestamp(fdEndDate.getTime()));
								sql.setString(5, applyer.getFdId());
								sql.setString(6, fdDeptId);
								sql.setTimestamp(7, new Timestamp(new Date().getTime()));
								sql.setDouble(8, Double.valueOf(fdHour));
								sql.setString(9, kmReviewMain.getFdId());
								sql.setString(10, fdDetailId);
							} else if ("UPDATE".equals(fdType)) {
								sql.setString(1, kmReviewMain.getDocSubject());
								sql.setTimestamp(2, new Timestamp(fdBeginDate.getTime()));
								sql.setTimestamp(3, new Timestamp(fdEndDate.getTime()));
								sql.setString(4, applyer.getFdId());
								sql.setString(5, fdDeptId);
								sql.setDouble(6, Double.valueOf(fdHour));
								sql.setString(7, kmReviewMain.getFdId());
								sql.setString(8, fdDetailId);
							} else if ("DELETE".equals(fdType)) {
								sql.setString(1, kmReviewMain.getFdId());
							}
							sql.addBatch();
						}
					}
					if (needCommit) {
						sql.executeBatch();
						connect.commit();
					}
//				}
			} catch (SQLException ex) {
				connect.rollback();
				throw ex;
			} finally {
				JdbcUtils.closeResultSet(resultSet);
				JdbcUtils.closeStatement(selectSql);
				JdbcUtils.closeStatement(sql);
				JdbcUtils.closeConnection(connect);
			}
		}
	}

}
