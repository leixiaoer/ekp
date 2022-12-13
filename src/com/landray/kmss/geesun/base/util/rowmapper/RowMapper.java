package com.landray.kmss.geesun.base.util.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 数据行转换器
 * 
 * @author 黄永超
 *
 * @param <T>
 */
public interface RowMapper<T> {

	/**
	 * 将resultSet中的一行记录转换为相应的对象
	 * 
	 * @param rs
	 *            resultSet
	 * @param rowNum
	 *            行数
	 * @return 转换后的对象
	 * @throws SQLException
	 */
	T mapRow(ResultSet rs, int rowNum) throws SQLException;

}
