package com.landray.kmss.geesun.base.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.ArgumentPreparedStatementSetter;
import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.util.Assert;

import com.landray.kmss.component.dbop.ds.DataSet;
import com.landray.kmss.geesun.base.util.example.BoxJdbcCUDExample;
import com.landray.kmss.geesun.base.util.example.BoxJdbcQueryExample;
import com.landray.kmss.geesun.base.util.rowmapper.BoxJdbcDefaultRowMapper;
import com.landray.kmss.geesun.base.util.rowmapper.RowMapper;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.StringUtil;

/**
 * jdbc工具类，用于执行查询和更新操作。
 * 
 * @author 黄永超
 *
 */
public class BoxJdbcUtils {

	private static final Logger logger = LoggerFactory
			.getLogger(BoxJdbcUtils.class);

	private BoxJdbcUtils() {
	}

	/**
	 * 获取数据源数据库连接对象
	 * 
	 * @param dataSourceId
	 *            数据源名称，为空则取本地数据源
	 * @return
	 * @throws Exception
	 */
	private static DataSet getDataSet(String dataSourceId) throws Exception {
		DataSet dataSet = null;
		try {
			if (StringUtil.isNull(dataSourceId)) {
				dataSet = new DataSet();
			} else {
				dataSet = new DataSet(dataSourceId);
			}
		} catch (Exception e) {
			throw e;
		}
		return dataSet;
	}

	/**
	 * 执行sql查询，使用BoxJdbcDefaultRowMapper做数据转换。
	 * 
	 * @param queryExample
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String, Object>> executeQuery(BoxJdbcQueryExample queryExample){
		// 创建一个默认的rowMapper。将resultSet里面的值返回成一个map，map的key就是字段名，value就是字段值。
		return executeQuery(queryExample,
				BoxJdbcDefaultRowMapper.getInstance());

	}

	/**
	 * 执行sql查询，根据rowMapper做数据转换
	 * 
	 * @param queryExample
	 *            查询对象，不能为空。
	 * @param rowMapper
	 *            数据行转换器，不能为空。
	 * @return 转换后的对象集合
	 * @throws SQLException
	 */
	public static <T> List<T> executeQuery(BoxJdbcQueryExample queryExample, RowMapper<T> rowMapper){
		Assert.notNull(queryExample, "queryExample不能为空！");
		Assert.notNull(rowMapper, "rowMapper不能为空！");
		List<T> resultList = new LinkedList<>();
		// 获取连接，执行sql语句，根据rowMapper，返回结果
		DataSet dataSet = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			dataSet = getDataSet(queryExample.getDataSourceId());
			connection = dataSet.getConnection();
			preparedStatement = connection.prepareStatement(queryExample.getQuerySql());
			List<Object> paramList = queryExample.getParamList();
			if (!ArrayUtil.isEmpty(paramList)) {
				ArgumentPreparedStatementSetter setter = new ArgumentPreparedStatementSetter(
						paramList.toArray());
				setter.setValues(preparedStatement);
			}
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				resultList.add(rowMapper.mapRow(resultSet, resultSet.getRow()));
			}
		} catch (Exception e) {
			logger.error("box-jdbc查询出错! BoxJdbcQueryExample=" + queryExample,
					e);
			throw new RuntimeException(
					"box-jdbc查询出错!", e);
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(preparedStatement);
			JdbcUtils.closeConnection(connection);
		}
		return resultList;
	}

	/**
	 * 执行sql增删改方法
	 * 
	 * @param cudExample   BoxJdbcCUDExample的实例，包括数据源、sql和参数集合
	 *                     sql不可为空，其他两个参数可为null
	 */
	public static void excuteCUD(BoxJdbcCUDExample cudExample) {
		executeCUDInBatch(cudExample, 0);
	}

	/**
	 * 批量处理增删改
	 * 
	 * @param cudExample  BoxJdbcCUDExample对象的实例，包括数据源、sql和参数集合,sql不可为空 
	 * @param batchSize 
	 *            批量修改的数量，如果小于等于0，默认一次性执行完所有
	 * @throws SQLException
	 */
	public static void executeCUDInBatch(BoxJdbcCUDExample cudExample, int batchSize){
		DataSet dataSet = null;
		PreparedStatement preparedStatement = null;
		boolean isNeedBatch = batchSize > 0;
		try {
			dataSet = getDataSet(cudExample.getDataSourceName());
			dataSet.beginTran();
			dataSet.prepareStatement(cudExample.getSql());
			preparedStatement = dataSet.getPreparedStatement();
			List<List<Object>> paramsList = cudExample.getParamsList();
			if (ArrayUtil.isEmpty(paramsList)) {
				preparedStatement.executeUpdate();
			}
			else {
				int rowCount = 0;
				for (List<Object> paramList : paramsList) {
					ArgumentPreparedStatementSetter setter = new ArgumentPreparedStatementSetter(
							paramList.toArray());
					setter.setValues(preparedStatement);
					preparedStatement.addBatch();
					if (isNeedBatch && ++rowCount % batchSize == 0) {
						preparedStatement.executeBatch();
					}
				}
				preparedStatement.executeBatch();
			}
			dataSet.commit();
		} catch (Exception e) {
			dataSet.rollback();
			logger.error("box-jdbc增删改出错! BoxJdbcCUDExample=" + cudExample,
					e);
			throw new RuntimeException(
					"box-jdbc增删改出错!", e);
		} finally {
			if (dataSet != null) {
				JdbcUtils.closeStatement(preparedStatement);
				JdbcUtils.closeConnection(dataSet.getConnection());
			}
		}
	}
}
