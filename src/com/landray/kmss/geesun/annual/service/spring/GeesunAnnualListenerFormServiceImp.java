package com.landray.kmss.geesun.annual.service.spring;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualListenerFormService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualMainService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualUseService;
import com.landray.kmss.geesun.annual.util.CalculateUtil;
import com.landray.kmss.geesun.annual.util.GeesunAnnualConstant;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataEvent;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataModel;
import com.landray.kmss.sys.metadata.interfaces.ISysMetadataParser;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.time.interfaces.ISysTimeCountService;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 监听请假表单的增删改查事件往请假表中写入更新获取删除数据
 * @author guoyp
 */
public class GeesunAnnualListenerFormServiceImp implements IExtendDataEvent, 
	IGeesunAnnualListenerFormService, GeesunAnnualConstant {
	
	private static final Log logger = LogFactory
			.getLog(GeesunAnnualListenerFormServiceImp.class);
	
	protected IGeesunAnnualUseService geesunAnnualUseService;
	
	public IGeesunAnnualUseService getGeesunAnnualUseService() {
		if (null == geesunAnnualUseService) {
			geesunAnnualUseService = (IGeesunAnnualUseService) SpringBeanUtil
					.getBean("geesunAnnualUseService");
		}
		return geesunAnnualUseService;
	}
	
	protected IKmReviewMainService kmReviewMainService;
	
	public IKmReviewMainService getKmReviewMainService() {
		if (null == kmReviewMainService) {
			kmReviewMainService = (IKmReviewMainService) SpringBeanUtil
					.getBean("kmReviewMainService");
		}
		return kmReviewMainService;
	}
	
	protected IGeesunAnnualMainService geesunAnnualMainService;
	
	public IGeesunAnnualMainService getGeesunAnnualMainService() {
		if (null == geesunAnnualMainService) {
			geesunAnnualMainService = (IGeesunAnnualMainService) SpringBeanUtil
					.getBean("geesunAnnualMainService");
		}
		return geesunAnnualMainService;
	}
	
	/**
     * 工时计算bean
     */
    protected ISysTimeCountService sysTimeCountService;
    
    public ISysTimeCountService getSysTimeCountService() {
    	if (null == sysTimeCountService) {
			sysTimeCountService = (ISysTimeCountService) SpringBeanUtil
					.getBean("sysTimeCountService");;
    	}
    	return sysTimeCountService;
    }
	
	@Override
	public void onAdd(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		addOrUpdateOrDeleteLeave(kmReviewMain, dataParser, "ADD");
	}

	@Override
	public void onDelete(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		addOrUpdateOrDeleteLeave(kmReviewMain, dataParser, "DELETE");
	}

	@Override
	public void onInit(RequestContext request, IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		SysOrgPerson person = UserUtil.getUser();
		//获取员工假期记录
		GeesunAnnualMain geesunAnnualMain = getGeesunAnnualMainService()
				.getAnnualByApplyer(person.getFdId());
		if (null != geesunAnnualMain) {
			boolean isLast = false;
			Date lastResetDate = geesunAnnualMain.getFdLastResetDate();
			Double njDays = geesunAnnualMain.getFdTotal();
			if (new Date().before(lastResetDate)) {
				njDays = geesunAnnualMain.getFdLastTotal();
				isLast = true;
			}
			Double usedYear = getGeesunAnnualUseService().getLeaveDayAuditingByPerson(null, isLast, geesunAnnualMain);
			dataParser.setFieldValue(model, "fd_395a0c7f057e14", String.valueOf(CalculateUtil.sub(njDays, usedYear)));//剩余年假
		} else {
			dataParser.setFieldValue(model, "fd_395a0c7f057e14", "0.0");//剩余年假
		}
	}
	
	@Override
	public void onUpdate(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		addOrUpdateOrDeleteLeave(kmReviewMain, dataParser, "UPDATE");
	}
	
	/**
	 * 插入、更新或者删除请假表记录
	 * @param kmReviewMain
	 * @param dataParser
	 * @throws fdType
	 */
	@SuppressWarnings("resource")
	public void addOrUpdateOrDeleteLeave(KmReviewMain kmReviewMain, 
			ISysMetadataParser dataParser, String fdType) throws Exception {
		Double fdLeaveType = (Double) dataParser.getFieldValue(kmReviewMain, "fd_395a0c2b56a790", true);//请假类型
		SysOrgPerson fdLeaver = (SysOrgPerson) dataParser.getFieldValue(kmReviewMain,
				"fd_395a0b5847e700", true);//提交人
		Date docCreateTime = (Date) dataParser.getFieldValue(kmReviewMain,
				"fd_39443ddc3424ee", true);
		Date fdBeginDate = (Date) dataParser.getFieldValue(kmReviewMain,
				"fd_39443cd6b60ebe", true);
		Date fdBeginTime = DateUtil.convertStringToDate("00:00", "HH:mm");
		Date fdEndDate = (Date) dataParser.getFieldValue(kmReviewMain,
				"fd_39443cdd503ed6", true);
		Date fdEndTime = DateUtil.convertStringToDate("23:59", "HH:mm");
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Connection connect = null;
		PreparedStatement sql = null;
		PreparedStatement selectSql = null;
		ResultSet resultSet = null;
		try {
			connect = dataSource.getConnection();
			connect.setAutoCommit(false);
			if (fdLeaveType != null && fdLeaveType <= 1) {
				String fdAnnualId = null;
				GeesunAnnualMain geesunAnnualMain = getGeesunAnnualMainService()
						.getAnnualByApplyer(fdLeaver.getFdId());
				fdAnnualId = null!=geesunAnnualMain?geesunAnnualMain.getFdId():null;
				if ("ADD".equals(fdType)) {
					sql = connect
							.prepareStatement("insert into geesun_annual_use(fd_id, doc_create_time, fd_begin_date, "
									+ "fd_end_date, fd_begin_time, fd_end_time, doc_subject, fd_model_id, fd_model_name, fd_use, doc_creator_id, fd_annual_id, fd_type) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					sql.setString(1, IDGenerator.generateID());
					sql.setTimestamp(2, new Timestamp(docCreateTime.getTime()));
					sql.setTimestamp(3, new java.sql.Timestamp(fdBeginDate.getTime()));
					sql.setTimestamp(4, new java.sql.Timestamp(fdEndDate.getTime()));
					sql.setTimestamp(5, (fdBeginTime!=null?new java.sql.Timestamp(fdBeginTime.getTime()):null));
					sql.setTimestamp(6, (fdEndTime!=null?new java.sql.Timestamp(fdEndTime.getTime()):null));
					sql.setString(7, kmReviewMain.getDocSubject());
					sql.setString(8, kmReviewMain.getFdId());
					sql.setString(9, KmReviewMain.class.getName());
					Double fdLeaveYearDay =  getGeesunAnnualUseService().getAvailableDays(fdLeaver.getFdId(), fdBeginDate, fdEndDate);
					sql.setDouble(10, fdLeaveYearDay);
					sql.setString(11, fdLeaver.getFdId());
					sql.setString(12, fdAnnualId);
					sql.setString(13, GEESUN_ANNUAL_USE_TYPE_LEAVE);
				} else if ("UPDATE".equals(fdType)) {
					selectSql = connect
							.prepareStatement("select fd_id from geesun_annual_use"
									+ " where fd_model_id = ?");
					selectSql.setString(1, kmReviewMain.getFdId());
					resultSet = selectSql.executeQuery();
					if (resultSet.next()) {
						sql = connect
								.prepareStatement("update geesun_annual_use set fd_begin_date = ?, fd_end_date = ?, "
										+ " fd_begin_time = ?, fd_end_time = ?, doc_creator_id = ?, fd_use = ?, fd_annual_id = ? where fd_model_id = ?");
						sql.setTimestamp(1, new java.sql.Timestamp(fdBeginDate.getTime()));
						sql.setTimestamp(2, new java.sql.Timestamp(fdEndDate.getTime()));
						sql.setTimestamp(3, (fdBeginTime!=null?new java.sql.Timestamp(fdBeginTime.getTime()):null));
						sql.setTimestamp(4, (fdEndTime!=null?new java.sql.Timestamp(fdEndTime.getTime()):null));
						sql.setString(5, fdLeaver.getFdId());
						Double fdLeaveYearDay =  getGeesunAnnualUseService().getAvailableDays(fdLeaver.getFdId(), fdBeginDate, fdEndDate);
						sql.setDouble(6, fdLeaveYearDay);
						sql.setString(7, fdAnnualId);
						sql.setString(8, kmReviewMain.getFdId());
					} else {
						sql = connect
								.prepareStatement("insert into geesun_annual_use(fd_id, doc_create_time, fd_begin_date, "
										+ "fd_end_date, fd_begin_time, fd_end_time, doc_subject, fd_model_id, fd_model_name, fd_use, doc_creator_id, fd_annual_id, fd_type) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
						sql.setString(1, IDGenerator.generateID());
						sql.setTimestamp(2, new Timestamp(docCreateTime.getTime()));
						sql.setTimestamp(3, new java.sql.Timestamp(fdBeginDate.getTime()));
						sql.setTimestamp(4, new java.sql.Timestamp(fdEndDate.getTime()));
						sql.setTimestamp(5, (fdBeginTime!=null?new java.sql.Timestamp(fdBeginTime.getTime()):null));
						sql.setTimestamp(6, (fdEndTime!=null?new java.sql.Timestamp(fdEndTime.getTime()):null));
						sql.setString(7, kmReviewMain.getDocSubject());
						sql.setString(8, kmReviewMain.getFdId());
						sql.setString(9, KmReviewMain.class.getName());
						Double fdLeaveYearDay =  getGeesunAnnualUseService().getAvailableDays(fdLeaver.getFdId(), fdBeginDate, fdEndDate);
						sql.setDouble(10, fdLeaveYearDay);
						sql.setString(11, fdLeaver.getFdId());
						sql.setString(12, fdAnnualId);
						sql.setString(13, GEESUN_ANNUAL_USE_TYPE_LEAVE);
					}
				} else if ("DELETE".equals(fdType)) {
					sql = connect
							.prepareStatement("delete from geesun_annual_use where fd_model_id = ?");
					sql.setString(1, kmReviewMain.getFdId());
				}
			} else {
				sql = connect
						.prepareStatement("delete from geesun_annual_use where fd_model_id = ?");
				sql.setString(1, kmReviewMain.getFdId());
			}
			sql.executeUpdate();
			connect.commit();
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