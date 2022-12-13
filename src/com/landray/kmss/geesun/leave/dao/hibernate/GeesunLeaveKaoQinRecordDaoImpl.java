package com.landray.kmss.geesun.leave.dao.hibernate;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import org.springframework.jdbc.support.JdbcUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.landray.kmss.component.dbop.ds.DataSet;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveKaoQinRecordDao;

public class GeesunLeaveKaoQinRecordDaoImpl implements IGeesunLeaveKaoQinRecordDao {
	/**
	 * 获取指定工号指定日期的打卡记录
	 */
	@Override
	public JSONArray getKaoQin(Map<String, String> map) {
		JSONArray jsonArr = new JSONArray();
		JSONObject jsonOb = new JSONObject();
		DataSet dataSet = null;
		ResultSet resultSet = null;
		try {
			dataSet = new DataSet("kaoqin");
			// 连接数据库
			String sql = "select sb1 , sb2 , sb3 , xb1 , xb2 , xb3 from HRAttrDayRpt where EmpNo = ? and KQDate = ? ";
			dataSet.prepareStatement(sql);
			dataSet.setString(1, map.get("fdNo"));
			dataSet.setString(2, map.get("date"));
			resultSet = dataSet.executeQuery(); // sql语句进行查询数据库操作
			while (resultSet.next()) {
				jsonOb.put("sb1", resultSet.getString("sb1") + "");
				jsonOb.put("sb2", resultSet.getString("sb2") + "");
				jsonOb.put("sb3", resultSet.getString("sb3") + "");
				jsonOb.put("xb1", resultSet.getString("xb1") + "");
				jsonOb.put("xb2", resultSet.getString("xb2") + "");
				jsonOb.put("xb3", resultSet.getString("xb3") + "");
				jsonArr.add(jsonOb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			dataSet.close();
		}
		return jsonArr;
	}

}
