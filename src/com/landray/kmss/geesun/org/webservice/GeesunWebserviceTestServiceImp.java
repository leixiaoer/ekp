package com.landray.kmss.geesun.org.webservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.util.SpringBeanUtil;

public class GeesunWebserviceTestServiceImp implements IGeesunWebserviceTestService {

	@Override
	public String getMobileByLoginName(String fdLoginName) throws Exception {
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String fdMobile = "";
		System.out.println(fdLoginName);
		try {
			conn = dataSource.getConnection();
			ps = conn.prepareStatement("select fd_mobile_no from sys_org_person where fd_login_name = ?");
			ps.setString(1, fdLoginName);
			rs = ps.executeQuery();
			if (rs.next()) {
				fdMobile = rs.getString(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			JdbcUtils.closeResultSet(rs);
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
		return fdMobile;
	}

}
