package com.landray.kmss.geesun.leave.service.spring;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.geesun.leave.model.GeesunLeaveConfig;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.workflow.constant.OAConstant;
import com.landray.kmss.sys.workflow.interfaces.AfterDoingWfNode;
import com.landray.kmss.sys.workflow.interfaces.Event_SysFlowDiscard;
import com.landray.kmss.sys.workflow.interfaces.Event_SysFlowFinish;
import com.landray.kmss.sys.workflow.interfaces.Event_SysFlowRefuse;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

/**
 * 监听流程发布、废弃、驳回到起草人、起草人撤回接口
 * 
 * @author guoyp
 *
 */
public class GeesunLeaveOvertimeBatchApplicationService implements ApplicationListener {
	
	private static final Log logger = LogFactory.getLog(GeesunLeaveOvertimeBatchApplicationService.class);
	
	public void onApplicationEvent(ApplicationEvent event) {
		if (event == null)
			return;
		Object obj = event.getSource();
		if (!(obj instanceof KmReviewMain))
			return;
		KmReviewMain kmReviewMain = (KmReviewMain) obj;
		try {
			DataSource dataSource = (DataSource) SpringBeanUtil
					.getBean("dataSource");
			//获取表单中数据
			if (null != kmReviewMain && kmReviewMain.getFdUseForm()) {
				if (event instanceof Event_SysFlowFinish) {
					//流程发布配置的监听模板，发布
					GeesunLeaveConfig config = new GeesunLeaveConfig();
					if (null != kmReviewMain && null != kmReviewMain.getFdTemplate() && StringUtil.isNotNull(config.getFdTemplateIds())
							&& config.getFdTemplateIds().indexOf(kmReviewMain.getFdTemplate().getFdId()) != -1) {
						cleanAdjust(dataSource, kmReviewMain.getFdId());
						addAdjust(kmReviewMain, dataSource);
					}
				} else if (event instanceof Event_SysFlowDiscard) {
					//流程废弃
					GeesunLeaveConfig config = new GeesunLeaveConfig();
					if (null != kmReviewMain && null != kmReviewMain.getFdTemplate() && StringUtil.isNotNull(config.getFdTemplateIds())
							&& config.getFdTemplateIds().indexOf(kmReviewMain.getFdTemplate().getFdId()) != -1) {
						cleanAdjust(dataSource, kmReviewMain.getFdId());
					}
				} else if (event instanceof AfterDoingWfNode) {
					AfterDoingWfNode afterDoing = (AfterDoingWfNode) event;
					if (afterDoing.getOprType() == OAConstant.CREATOR_OPERATION_TYPE_SUBMIT) {
						//流程起草人提交
						GeesunLeaveConfig config = new GeesunLeaveConfig();
						if (null != kmReviewMain && null != kmReviewMain.getFdTemplate() && StringUtil.isNotNull(config.getFdTemplateIds())
								&& config.getFdTemplateIds().indexOf(kmReviewMain.getFdTemplate().getFdId()) != -1) {
							cleanAdjust(dataSource, kmReviewMain.getFdId());
							addAdjust(kmReviewMain, dataSource);
						}
					} else if (afterDoing.getOprType() == OAConstant.CREATOR_OPERATION_TYPE_RETURN) {
						//流程起草人撤回
						GeesunLeaveConfig config = new GeesunLeaveConfig();
						if (null != kmReviewMain && null != kmReviewMain.getFdTemplate() && StringUtil.isNotNull(config.getFdTemplateIds())
								&& config.getFdTemplateIds().indexOf(kmReviewMain.getFdTemplate().getFdId()) != -1) {
							cleanAdjust(dataSource, kmReviewMain.getFdId());
						}
					} 
				} else if(event instanceof Event_SysFlowRefuse){
					//驳回到起草人
					if (((Event_SysFlowRefuse) event).getWfNode().getFdActivityType()
							.equals("draftNode")) {
						//驳回到起草人回写
						GeesunLeaveConfig config = new GeesunLeaveConfig();
						if (null != kmReviewMain && null != kmReviewMain.getFdTemplate() && StringUtil.isNotNull(config.getFdTemplateIds())
								&& config.getFdTemplateIds().indexOf(kmReviewMain.getFdTemplate().getFdId()) != -1) {
							cleanAdjust(dataSource, kmReviewMain.getFdId());
						}
					}
				}
			}
		} catch (Exception e) {
			throw new RuntimeException("========出现问题，请联系特权人处理，出错原因为:======" + e.getMessage());
		}
	}
	
	/**
	 * 清除写入的批量加班表
	 * @param dataSource
	 * @param fdReviewId
	 * @throws Exception
	 */
	public void cleanAdjust(DataSource dataSource, String fdReviewId) throws Exception {
	    String sql = "delete from geesun_leave_adjust where fd_model_id = ?";
	    PreparedStatement ps = null;
	    Connection conn = null;
	    try {
	      conn = dataSource.getConnection();
	      ps = conn.prepareStatement(sql);
	      ps.setString(1, fdReviewId);
	      ps.executeUpdate();
	    }
	    catch (Exception ex) {
	      logger.error("清除写入的批量加班表发生异常：" + ex);
	      throw ex;
	    }
	    finally {
	      JdbcUtils.closeStatement(ps);
	      JdbcUtils.closeConnection(conn);
	    }
	}
	
	/**
	 * 插入加班表记录
	 * @param kmReviewMain
	 * @param dataParser
	 * @throws fdType
	 */
	public void addAdjust(KmReviewMain kmReviewMain, DataSource dataSource) throws Exception {
		Map<String, Object> data = kmReviewMain.getExtendDataModelInfo()
				.getModelData();// 自定义表单内容
		List<Map<String, Object>> detailList = (List<Map<String, Object>>) data.get("fd_3adfea1f6aea9c");
		if (!ArrayUtil.isEmpty(detailList)) {
			Connection connect = null;
			PreparedStatement sql = null;
			try {
					connect = dataSource.getConnection();
					connect.setAutoCommit(false);
					sql = connect
							.prepareStatement("insert into geesun_leave_adjust(fd_id, doc_subject , "
									+ "fd_start_time, fd_end_time, doc_creator_id, doc_dept_id, doc_create_time, fd_leave_hour, fd_model_id, fd_detail_id) "
									+ "values(?,?,?,?,?,?,?,?,?,?)");
					for (Map<String, Object> detail : detailList) {
						String fdHour = (null!= detail.get("fd_396de00b2f804a"))?detail.get("fd_396de00b2f804a").toString():"";
						Date fdBeginDate = (null!= detail.get("fd_39443cd6b60ebe"))?(Date)detail.get("fd_39443cd6b60ebe"):null;
						Date fdEndDate = (null!= detail.get("fd_395a06218b7eae"))?(Date)detail.get("fd_395a06218b7eae"):null;
						String fdDetailId = (null!= detail.get("fdId"))?detail.get("fdId").toString():"";
						Map<String, Object> applyerMap = (Map<String, Object>) detail.get("fd_395a0e397f83b2");
						Map<String, Object> deptMap = (Map<String, Object>) detail.get("fd_3982e650de503a");
						sql.setString(1, IDGenerator.generateID());
						sql.setString(2, kmReviewMain.getDocSubject());
						sql.setTimestamp(3, new Timestamp(fdBeginDate.getTime()));
						sql.setTimestamp(4, new Timestamp(fdEndDate.getTime()));
						sql.setString(5, applyerMap.get("id").toString());
						sql.setString(6, deptMap.get("id").toString());
						sql.setTimestamp(7, new Timestamp(new Date().getTime()));
						sql.setDouble(8, Double.valueOf(fdHour));
						sql.setString(9, kmReviewMain.getFdId());
						sql.setString(10, fdDetailId);
						sql.addBatch();
					}
					sql.executeBatch();
					connect.commit();
//				}
			} catch (SQLException ex) {
				connect.rollback();
				throw ex;
			} finally {
				JdbcUtils.closeStatement(sql);
				JdbcUtils.closeConnection(connect);
			}
		}
	}
	
}
