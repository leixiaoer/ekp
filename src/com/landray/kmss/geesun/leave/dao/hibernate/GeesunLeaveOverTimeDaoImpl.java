package com.landray.kmss.geesun.leave.dao.hibernate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveOverTimeDao;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 加班记录表
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveOverTimeDaoImpl implements IGeesunLeaveOverTimeDao {

	@Override
	public void AddOverTime(Map<String, String> map) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "insert into geesun_leave_adjust(fd_id, doc_subject , "
					+ "fd_start_time, fd_end_time, doc_creator_id, doc_dept_id, doc_create_time,fd_leave_hour) "
					+ "values(?,?,?,?,?,?,?,?)";
			pst = (PreparedStatement) connection.prepareStatement(sql);
			pst.setString(1, map.get("fdId"));
			pst.setString(2, map.get("docSubject"));
			pst.setString(3, map.get("fdStartTime"));
			pst.setString(4, map.get("fdEndTime"));
			pst.setString(5, map.get("docCreatorId"));
			pst.setString(6, map.get("docDeptId"));
			pst.setString(7, format.format(new Date()));
			pst.setString(8, map.get("fdLeaveHour"));
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
