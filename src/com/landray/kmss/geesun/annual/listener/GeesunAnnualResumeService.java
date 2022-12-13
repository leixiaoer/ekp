package com.landray.kmss.geesun.annual.listener;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualMainService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualUseService;
import com.landray.kmss.geesun.annual.util.GeesunAnnualConstant;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.SpringBeanUtil;
/**
 * 销假申请流程结束后将年假信息回退  
 *
 */
public class GeesunAnnualResumeService implements IEventListener, GeesunAnnualConstant {
	
	private static Log logger = LogFactory.getLog(GeesunAnnualResumeService.class);
	
	protected IGeesunAnnualUseService geesunAnnualUseService;
	
	public IGeesunAnnualUseService getGeesunAnnualUseService() {
		if (null == geesunAnnualUseService) {
			geesunAnnualUseService = (IGeesunAnnualUseService) SpringBeanUtil
					.getBean("geesunAnnualUseService");
		}
		return geesunAnnualUseService;
	}
	
	protected IGeesunAnnualMainService geesunAnnualMainService;
	
	public IGeesunAnnualMainService getGeesunAnnualMainService() {
		if (geesunAnnualMainService == null) {
			geesunAnnualMainService = (IGeesunAnnualMainService) SpringBeanUtil
					.getBean("geesunAnnualMainService");
		}
		return geesunAnnualMainService;
	}
	
	@Override
	public void handleEvent(EventExecutionContext context, String parameter)
			throws Exception {
		BaseModel  _model=(BaseModel) context.getMainModel();
		if(_model == null){
			return;
		}
		KmReviewMain kmReviewMain = (KmReviewMain) _model;
		try {
			Map<String, Object> data = kmReviewMain.getExtendDataModelInfo()
					.getModelData();// 自定义表单内容
			String fdLeaveType = (null!= data.get("fd_leave_type"))?data.get("fd_leave_type").toString():"";//请假类型
			//判断如果销的是年假
			if ("1".equals(fdLeaveType)) {
				//写入销假使用记录
				addUseList(kmReviewMain, data);
			}
		} catch (Exception e) {
			logger.error(e);
		} finally {
			
		}
	}
	
	private void addUseList(KmReviewMain kmReviewMain, Map<String, Object> data) throws Exception {
		SysOrgPerson fdLeaver = kmReviewMain.getDocCreator();
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Connection connect = null;
		PreparedStatement sql = null;
		PreparedStatement selectSql = null;
		ResultSet resultSet = null;
		try {
			Date docCreateTime = (null!= data.get("fd_39443c9a4178d6"))?(Date)data.get("fd_39443c9a4178d6"):null;
			Date beginTime = (null!= data.get("fd_39443d1062635a"))?(Date)data.get("fd_39443d1062635a"):null;
			Date endTime = (null!= data.get("fd_395a0d69c0e73a"))?(Date)data.get("fd_395a0d69c0e73a"):null;
			Date fdBeginTime = DateUtil.convertStringToDate("00:00", "HH:mm");
			Date fdEndTime = DateUtil.convertStringToDate("23:59", "HH:mm");
			long begin = DateUtil.getDateTimeNumber(beginTime, fdBeginTime);
			long end = DateUtil.getDateTimeNumber(endTime, fdEndTime);
			connect = dataSource.getConnection();
			connect.setAutoCommit(false);
			sql = connect
					.prepareStatement("insert into geesun_annual_use(fd_id, doc_create_time, fd_begin_date, "
							+ "fd_end_date, fd_begin_time, fd_end_time, doc_subject, fd_model_id, fd_model_name, fd_use, doc_creator_id, fd_annual_id, fd_type) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			String fdAnnualId = null;
			GeesunAnnualMain geesunAnnualMain = getGeesunAnnualMainService()
					.getAnnualByApplyer(fdLeaver.getFdId());
			fdAnnualId = null!=geesunAnnualMain?geesunAnnualMain.getFdId():null;
			sql.setString(1, IDGenerator.generateID());
			sql.setTimestamp(2, new Timestamp(docCreateTime.getTime()));
			sql.setTimestamp(3, new java.sql.Timestamp(begin));
			sql.setTimestamp(4, new java.sql.Timestamp(end));
			sql.setTimestamp(5, (fdBeginTime!=null?new java.sql.Timestamp(fdBeginTime.getTime()):null));
			sql.setTimestamp(6, (fdEndTime!=null?new java.sql.Timestamp(fdEndTime.getTime()):null));
			sql.setString(7, kmReviewMain.getDocSubject());
			sql.setString(8, kmReviewMain.getFdId());
			sql.setString(9, KmReviewMain.class.getName());
			Double fdLeaveYearDay =  getGeesunAnnualUseService().getAvailableDays(fdLeaver.getFdId(), new Date(begin), new Date(end));
			sql.setDouble(10, -fdLeaveYearDay);
			sql.setString(11, fdLeaver.getFdId());
			sql.setString(12, fdAnnualId);
			sql.setString(13, GEESUN_ANNUAL_USE_TYPE_RESUME);
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
