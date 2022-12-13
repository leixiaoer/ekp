package com.landray.kmss.geesun.base.util.example;

import java.util.ArrayList;
import java.util.List;

import org.springframework.util.Assert;

import com.landray.kmss.util.ArrayUtil;

/**
 * sql更新语句对象
 * 
 * @author 黄永超
 *
 */
public class BoxJdbcCUDExample {
	
	private String dataSourceName;
	
	private String sql;
	
	private List<List<Object>> paramsList;

	/**
	 * 根据数据源名称，执行sql语句，携带多组参数（比如一次性插入多条记录）。
	 * 
	 * @param dataSourceName
	 *            数据源名称（来源于ekp的后台数据源的配置）
	 * @param sql
	 *            sql语句（delete、update、insert）
	 * @param paramsList
	 *            参数集合
	 * @return
	 */
	public static BoxJdbcCUDExample createInstanceForParamsList(String dataSourceName,
			String sql,
			List<List<Object>> paramsList) {
		return new BoxJdbcCUDExample(dataSourceName, sql, paramsList);
	}

	/**
	 * 根据数据源名称，执行sql语句，携带一组参数（比如执行一次update语句）。
	 * 
	 * @param dataSourceName
	 *            数据源名称（来源于ekp的后台数据源的配置）
	 * @param sql
	 *            sql语句（delete、update、insert）
	 * @param paramList
	 *            参数集合
	 * @return
	 */
	public static BoxJdbcCUDExample createInstanceForParams(String dataSourceName,
			String sql,
			List<Object> paramList) {
		if (ArrayUtil.isEmpty(paramList)) {
			return createInstanceForParamsList(dataSourceName, sql, null);
		} else {
			List<List<Object>> list = new ArrayList<List<Object>>();
			list.add(paramList);
			return createInstanceForParamsList(dataSourceName, sql, list);
		}
	}

	/**
	 * 在当前ekp数据库中执行一条带参数的sql语句
	 * 
	 * @param sql
	 *            sql语句（delete、update、insert）
	 * @param paramList
	 *            参数集合
	 * @return
	 */
	public static BoxJdbcCUDExample createInstanceForParams(String sql,
			List<Object> paramList) {
		return createInstanceForParams("", sql, paramList);
	}

	/**
	 * 在当前ekp数据库中执行一条无参数的sql语句
	 * 
	 * @param sql
	 *            sql语句（delete、update、insert）
	 * @return
	 */
	public static BoxJdbcCUDExample createInstanceWithoutParams(String sql) {
		return createInstanceForParamsList("", sql, null);
	}


	private BoxJdbcCUDExample(String dataSourceName, String sql,
			List<List<Object>> paramsList) {
		Assert.hasText(sql, "sql语句不能为空!");
		this.dataSourceName = dataSourceName;
		this.sql = sql;
		this.paramsList = paramsList;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public List<List<Object>> getParamsList() {
		return paramsList;
	}

	public void setParamsList(List<List<Object>> paramsList) {
		this.paramsList = paramsList;
	}

	public String getDataSourceName() {
		return dataSourceName;
	}

	public void setDataSourceName(String dataSourceName) {
		this.dataSourceName = dataSourceName;
	}

	@Override
	public String toString() {
		return "BoxJdbcCUDExample [dataSourceName=" + dataSourceName + ", sql="
				+ sql + ", paramsList.size=" + paramsList.size() + "]";
	}

}
