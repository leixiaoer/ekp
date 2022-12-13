package com.landray.kmss.geesun.leave.dao.hibernate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveInfoDao;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 调休信息表
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveInfoDaoImpl implements IGeesunLeaveInfoDao {
	/**
	 * 获取指定用户,年份的调休信息
	 */
	@Override
	public Map<String, String> getUserLeave(String userId, String year) {
		Map<String, String> hashMap = new HashMap<>();
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		ResultSet resultSet = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "select fd_id , fd_surplus_leave , fd_use_leave , fd_sun_leave "
					+ "from geesun_leave_main where doc_creator_id = ? and fd_time = ? ";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, userId);
			pst.setString(2, year);
			resultSet = pst.executeQuery(); // sql语句进行查询数据库操作
			while (resultSet.next()) {
				hashMap.put("fdId", resultSet.getString("fd_id").toString());// 流程ID
				hashMap.put("surplusLeave", resultSet.getString("fd_surplus_leave").toString());// 剩余调休时数
				hashMap.put("useLeave", resultSet.getString("fd_use_leave").toString());// 已使用调休时数
				hashMap.put("sunLeave", resultSet.getString("fd_sun_leave").toString());// 调休时数总计
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
		return hashMap;
	}

	/**
	 * 新增一条调休额度数据
	 */
	@Override
	public void AddLeaveInfo(Map<String, String> map) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "insert into geesun_leave_main(fd_id , doc_create_time , "
					+ "fd_time, fd_surplus_leave , fd_use_leave , fd_sun_leave , doc_creator_id , "
					+ "doc_failure_time , fd_owner_no , doc_dept_id) " + "values(?,?,?,?,?,?,?,?,?,?)";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, map.get("fdId"));
			pst.setString(2, format.format(new Date()));
			pst.setString(3, map.get("fdTime"));
			pst.setString(4, map.get("fdSurplusLeave"));
			pst.setString(5, map.get("fdUseLeave"));
			pst.setString(6, map.get("fdSunLeave"));
			pst.setString(7, map.get("docCreateId"));
			pst.setString(8, map.get("docFailureTime"));
			pst.setString(9, map.get("fdOwnerNo"));
			pst.setString(10, map.get("docDeptId"));
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
	 * 修改调休信息
	 */
	@Override
	public void updateLeaveInfo(Map<String, String> map) {
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst1 = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "update geesun_leave_main set fd_surplus_leave = ?, fd_use_leave = ?, fd_sun_leave = ? where fd_id = ? ";
			pst1 = (PreparedStatement) connection.prepareStatement(sql);
			pst1.setDouble(1, Double.parseDouble(map.get("fdSurplusLeave")));
			pst1.setDouble(2, Double.parseDouble(map.get("fdUseLeave")));
			pst1.setDouble(3, Double.parseDouble(map.get("fdSunLeave")));
			pst1.setString(4, map.get("fdId"));
			pst1.executeUpdate();
			pst1.executeUpdate();
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeStatement(pst1);
			JdbcUtils.closeConnection(connection);
		}
	}
}
