package com.landray.kmss.geesun.leave.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveAdjustDao;
import com.landray.kmss.tic.jdbc.util.JdbcUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.leave.model.GeesunLeaveAdjust;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunLeaveAdjustDaoImp extends BaseDaoImp implements IGeesunLeaveAdjustDao {

	public String add(IBaseModel modelObj) throws Exception {
		GeesunLeaveAdjust geesunLeaveAdjust = (GeesunLeaveAdjust) modelObj;
		if (geesunLeaveAdjust.getDocCreator() == null) {
			geesunLeaveAdjust.setDocCreator(UserUtil.getUser());
		}
		if (geesunLeaveAdjust.getDocCreateTime() == null) {
			geesunLeaveAdjust.setDocCreateTime(new Date());
		}
		return super.add(geesunLeaveAdjust);
	}

	// 查询指定用户的所有请假信息
	public JSONArray getDateMessage(String userId) {
		JSONArray jsonArray = new JSONArray();
		Integer index = 0;
		JSONObject json = new JSONObject();
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		ResultSet resultSet = null;
		try {
			connection = (Connection) dataSource.getConnection();
			String sql = "select fd_id , fd_start_time , fd_end_time from geesun_leave_adjust where doc_creator_id = ? ";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, userId);
			resultSet = pst.executeQuery(); // sql语句进行查询数据库操作
			while (resultSet.next()) {
				json.put("fdId", resultSet.getString("fd_id"));
				json.put("fdStartTime", resultSet.getString("fd_start_time"));
				json.put("fdEndTime", resultSet.getString("fd_end_time"));
				jsonArray.add(index, json);
				index++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
		return jsonArray;
	}

	// 增加geesun_leave_adjust_areader信息
	public void addAreader(Map<String, String> map) {
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "insert into geesun_leave_adjust_areader(fd_source_id , fd_target_id) values(? , ?)";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, map.get("fdSourceId"));
			pst.setString(2, map.get("fdTargetId"));
			pst.executeUpdate();
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
	}

	// 修改被冻结的请假申请时间状态
	public void upAdjustState(Map<String, String> map) {
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "update ekp_geesun_over_time set fd_state = ? where fd_id = ?";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, map.get("fdState"));
			pst.setString(2, map.get("fdId"));
			pst.executeUpdate();
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
	}

	// 查询指定用户的请假冻结信息
	public JSONArray getFreezeMessage(String userId, JSONArray jsonArray) {
		Integer index = 0;
		if (jsonArray.size() > 0) {
			index = jsonArray.size();
		}
		JSONObject json = new JSONObject();
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		ResultSet resultSet = null;
		try {
			connection = (Connection) dataSource.getConnection();
			String sql = "select fd_id , fd_start_time , fd_end_time from ekp_geesun_over_time "
					+ "where fd_applicant_id = ? and fd_state is null ";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, userId);
			resultSet = pst.executeQuery(); // sql语句进行查询数据库操作
			while (resultSet.next()) {
				json.put("fdId", resultSet.getString("fd_id"));
				json.put("fdStartTime", resultSet.getString("fd_start_time"));
				json.put("fdEndTime", resultSet.getString("fd_end_time"));
				jsonArray.add(index, json);
				index++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
		return jsonArray;
	}
}
