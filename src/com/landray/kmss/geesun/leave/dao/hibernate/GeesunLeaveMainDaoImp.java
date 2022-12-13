package com.landray.kmss.geesun.leave.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveMainDao;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.leave.model.GeesunLeaveMain;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunLeaveMainDaoImp extends BaseDaoImp implements IGeesunLeaveMainDao {

	public String add(IBaseModel modelObj) throws Exception {
		GeesunLeaveMain geesunLeaveMain = (GeesunLeaveMain) modelObj;
		if (geesunLeaveMain.getDocCreator() == null) {
			geesunLeaveMain.setDocCreator(UserUtil.getUser());
		}
		if (geesunLeaveMain.getDocCreateTime() == null) {
			geesunLeaveMain.setDocCreateTime(new Date());
		}
		return super.add(geesunLeaveMain);
	}

	// 增加geesun_leave_main_areader
	public void addAreader(Map<String, String> map) {
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "insert into geesun_leave_main_areader(fd_source_id , fd_target_id) values(? , ?)";
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
}
