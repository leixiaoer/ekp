package com.landray.kmss.geesun.base.util.rowmapper;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.jdbc.support.JdbcUtils;

/**
 * 默认提供的RowMapper，将ResultSet的一条记录转换为一个Map。
 * Map的key就是字段名，value就是字段值。
 * 
 * @author 黄永超
 *
 */
public class BoxJdbcDefaultRowMapper implements RowMapper<Map<String, Object>> {
	
	private static BoxJdbcDefaultRowMapper INSTANCE;
	
	private BoxJdbcDefaultRowMapper() {
		
	}
	
	public static BoxJdbcDefaultRowMapper getInstance() {
		if (INSTANCE == null) {
			synchronized(BoxJdbcDefaultRowMapper.class) {
				if (INSTANCE == null) {
					INSTANCE = new BoxJdbcDefaultRowMapper();
				}
			}
		}
		return INSTANCE;
	}

	@Override
	public Map<String, Object> mapRow(ResultSet resultSet, int rowNum) throws SQLException {
		ResultSetMetaData rsmd = resultSet.getMetaData();
		int columnCount = rsmd.getColumnCount();
		Map<String, Object> valueMap = new LinkedHashMap<>(columnCount);
		for (int i = 1; i <= columnCount; i++) {
			String key = JdbcUtils.lookupColumnName(rsmd, i);
			Object value = JdbcUtils.getResultSetValue(resultSet, i);
			valueMap.put(key, value);
		}
		return valueMap;
	}

}
