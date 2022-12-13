package com.landray.kmss.geesun.base.util.example;

import java.util.List;

import org.springframework.util.Assert;

/**
 * sql查询语句对象
 * 
 * @author 黄永超
 *
 */
public class BoxJdbcQueryExample {
	
	private String dataSourceName;
	
	private String querySql;
	
	private List<Object> paramList;

	public String getDataSourceId() {
		return dataSourceName;
	}

	public void setDataSourceId(String dataSourceId) {
		this.dataSourceName = dataSourceId;
	}

	public String getQuerySql() {
		return querySql;
	}

	public void setQuerySql(String querySql) {
		this.querySql = querySql;
	}

	public List<Object> getParamList() {
		return paramList;
	}

	public void setParamList(List<Object> paramList) {
		this.paramList = paramList;
	}
	
	private BoxJdbcQueryExample(String dataSourceName, String querySql,
			List<Object> paramList) {
		Assert.hasText(querySql, "sql语句不能为空!");
		this.dataSourceName = dataSourceName;
		this.querySql = querySql;
		this.paramList = paramList;
	}

	/**
	 * 根据数据源名称，查询带参数的sql语句
	 * 
	 * @param dataSourceName
	 *            可为空，为空则查询ekp的数据源
	 * @param querySql
	 *            sql语句，不能为空。 参数用?来占位
	 * @param paramList
	 *            sql语句的参数，按顺序排列。
	 * @return
	 */
	public static BoxJdbcQueryExample createInstance(String dataSourceName,
			String querySql,
			List<Object> paramList) {
		return new BoxJdbcQueryExample(dataSourceName, querySql, paramList);
	}

	/**
	 * 根据数据源名称，查询sql语句。
	 * 
	 * @param dataSourceName
	 *            可为空，为空则查询ekp的数据源
	 * @param querySql
	 *            sql语句，不能为空。
	 * @return
	 */
	public static BoxJdbcQueryExample createInstance(String dataSourceName,
			String querySql) {
		return new BoxJdbcQueryExample(dataSourceName, querySql, null);
	}

	/**
	 * 本地ekp数据库，查询sql语句。
	 * 
	 * @param querySql
	 *            查询sql。
	 * 
	 * @return
	 */
	public static BoxJdbcQueryExample createInstance(String querySql) {
		return new BoxJdbcQueryExample("", querySql, null);
	}

	@Override
	public String toString() {
		return "BoxJdbcQueryExample [dataSourceName=" + dataSourceName
				+ ", querySql=" + querySql + ", paramList=" + paramList + "]";
	}

}
