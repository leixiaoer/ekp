package com.landray.kmss.geesun.leave.dao.hibernate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveRepairKaoqinDao;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunLeaveRepairKaoqinDaoImpl implements IGeesunLeaveRepairKaoqinDao {

	/**
	 * 查询获取指定用户ID,补卡时间当月的补卡的次数
	 */
	public Integer getTime(String userId, String date) {
		int a = -1;// 返回值
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			connection.setAutoCommit(false);

			//mysql兼容
//			String sql = "select count(1) from ekp_kq_buka where date_format(fd_buLuRiQiShiJian,'%Y-%m')= ? "
//					+ "and fd_shenQingRenXingMing = ? and ( fd_state is null or fd_state = ? ) ";
			
			//sqlServer兼容
			String sql = "select count(1) from ekp_bk_kaoqin where substring(convert(varchar(30),fd_buLuRiQiShiJian,120),1,7)= ? "
					+ "and fd_shenQingRenXingMing = ? and ( fd_state is null or fd_state = ? ) ";
			pst = connection.prepareStatement(sql); // 讲sql语句传输进行筛选
			pst.setString(1, date);
			pst.setString(2, userId);
			pst.setString(3, "20");
			resultSet = pst.executeQuery(); // sql语句进行查询数据库操作
			while (resultSet.next()) {
				a = Integer.parseInt(resultSet.getString(1));// 得到sql返回值
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
		return a;
	}

	/**
	 * 修改指定fdID的流程状态
	 */
	public void upState(String fdId, String state) {
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "update ekp_bk_kaoqin set fd_state = ? where fd_id = ? ";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, state);
			pst.setString(2, fdId);
			pst.executeUpdate();
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeStatement(pst);
			JdbcUtils.closeConnection(connection);
		}
	}

}
