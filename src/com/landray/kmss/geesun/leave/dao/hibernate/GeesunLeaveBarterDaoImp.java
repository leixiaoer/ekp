package com.landray.kmss.geesun.leave.dao.hibernate;

import com.landray.kmss.common.model.IBaseModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveBarterDao;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.geesun.leave.model.GeesunLeaveBarter;
import com.landray.kmss.common.dao.BaseDaoImp;

public class GeesunLeaveBarterDaoImp extends BaseDaoImp implements IGeesunLeaveBarterDao {

	public String add(IBaseModel modelObj) throws Exception {
		GeesunLeaveBarter geesunLeaveBarter = (GeesunLeaveBarter) modelObj;
		if (geesunLeaveBarter.getDocCreator() == null) {
			geesunLeaveBarter.setDocCreator(UserUtil.getUser());
		}
		if (geesunLeaveBarter.getDocCreateTime() == null) {
			geesunLeaveBarter.setDocCreateTime(new Date());
		}
		return super.add(geesunLeaveBarter);
	}

	// 增加geesun_leave_barter_areader表单信息
	public void addAreader(Map<String, String> map) {
		// jdbc连接,用于连接java后端和数据库的桥梁
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection connection = null;
		PreparedStatement pst = null;
		try {
			connection = (Connection) dataSource.getConnection();
			connection.setAutoCommit(false);
			String sql = "insert into geesun_leave_barter_areader(fd_source_id , fd_target_id) values(? , ?)";
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
