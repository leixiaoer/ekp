package com.landray.kmss.geesun.leave.dao.hibernate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Map.Entry;

import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveMappingFormDao;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 映射表的信息
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveMappingFormDaoImpl implements IGeesunLeaveMappingFormDao {

	/**
	 * 修改表单状态信息
	 */
	@Override
	public void upMessage(Map<String, String> map) {
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "update ekp_geesun_take_working set fd_state = ? where fd_id = ? ";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, map.get("state"));
			pst.setString(2, map.get("flowId"));
			pst.executeUpdate();
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
	}

	/**
	 * 查询表单信息
	 */
	public Double getFreezeHour(String userId) {
		Double leaveHour = 0.0;
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		ResultSet resultSet = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "select fd_leave_hour from ekp_geesun_take_working where fd_applicant_id = ? and fd_state is null ";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, userId);
			resultSet = pst.executeQuery(); // sql语句进行查询数据库操作
			while (resultSet.next()) {
				Double hour = resultSet.getDouble("fd_leave_hour");
				leaveHour += hour;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
		return leaveHour;
	}

	/**
	 * 删除冻结信息
	 */
	@Override
	public void deleteMessage(String fdId) {
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "delete from ekp_geesun_take_working where fd_id = ? ";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, fdId);
			pst.executeUpdate();
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
	}

	/**
	 * 查询表单指定信息的开始以及结束时间
	 */
	@Override
	public JSONArray getFreezeDate(Map<String, String> map) {
		JSONArray jsonArr = new JSONArray();
		JSONObject jsonObj = new JSONObject();
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		ResultSet resultSet = null;
		try {
			connection = (Connection) dataSource.getConnection();
			String sql = "select * from ekp_geesun_take_working where fd_applicant_id = ? and ( fd_state != '30' or"
					+ " fd_state is null ) and year(fd_start_time)= ? and (month(fd_start_time)= ? or month(fd_end_time)= ? )";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, map.get("userId"));
			pst.setString(2, map.get("year"));
			pst.setString(3, map.get("startMonth"));
			pst.setString(4, map.get("endMonth"));
			resultSet = pst.executeQuery(); // sql语句进行查询数据库操作
			int index = 0;
			while (resultSet.next()) {
				jsonObj.put("startTime", resultSet.getString("fd_start_time"));
				jsonObj.put("endTime", resultSet.getString("fd_end_time"));
				jsonObj.put("hour", resultSet.getString("fd_leave_hour"));
				jsonArr.add(index, jsonObj);
				index++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
		return jsonArr;
	}

}
