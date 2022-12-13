package com.landray.kmss.geesun.base.util.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.landray.kmss.geesun.base.util.BoxJdbcUtils;
import com.landray.kmss.geesun.base.util.example.BoxJdbcCUDExample;
import com.landray.kmss.geesun.base.util.example.BoxJdbcQueryExample;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.IDGenerator;

public final class BoxJdbcTest {

	/**
	 * 查询 默认返回集合，内容为map<列名，值>
	 */
	public static void testQueryWithDefaultMapper() {
		String sql = "select fd_id1, fd_name from sys_org_element where fd_name = ? and fd_create_time > ? and fd_is_available = ?";
		List<Object> list = new ArrayList<Object>();
		list.add("张三");
		list.add(DateUtil.getNextDay(new Date(), -1));
		list.add(Boolean.TRUE);
		BoxJdbcQueryExample example = BoxJdbcQueryExample.createInstance("",
				sql,
				list);
		List<Map<String, Object>> resultList = BoxJdbcUtils.executeQuery(example);
		System.out.println(resultList);
	}

	/**
	 * 查询 返回自定义的内容集合 DiyRowMapperTest为自定义的返回内容类，实现RowMapper接口，实现rowMap方法
	 */
	public static void testQueryWithDiyMapper() {
		String sql = "select fd_id, fd_name from sys_org_element where fd_name = ?";
		List<Object> list = new ArrayList<Object>();
		list.add("张三");
		BoxJdbcQueryExample example = BoxJdbcQueryExample.createInstance("",
				sql,
				list);
		PersonRowMapper personRowMapper = PersonRowMapper.getInstance();
		List<Person> resultList = BoxJdbcUtils.executeQuery(example,
				personRowMapper);
		System.out.println(resultList);
	}

	/**
	 * 操作数据库的数据（操作单条示例），
	 */
	public static void testInsert() {
		String sql = "insert into sys_log_app(fd_id,fd_created,fd_ip,fd_operator) values(?,?,?,?)";
		List<Object> paramList = new ArrayList<Object>();
		paramList.add(IDGenerator.generateID());
		paramList.add(new Date());
		paramList.add("127.0.0.1");
		paramList.add("张三");
		BoxJdbcCUDExample example = BoxJdbcCUDExample
				.createInstanceForParams(sql, paramList);
		BoxJdbcUtils.excuteCUD(example);
	}

	/**
	 * 操作数据库的数据（操作多条示例）
	 */
	public static void testInsertManyRows() {
		String sql = "insert into sys_log_app2(fd_id,fd_created,fd_ip,fd_operator) values(?,?,?,?)";
		List<List<Object>> listParams = new ArrayList<List<Object>>();
		for (int i = 0; i < 100; i++) {
			List<Object> paramList = new ArrayList<Object>();
			paramList.add(IDGenerator.generateID());
			paramList.add(new Date());
			paramList.add("127.0.0.1");
			paramList.add("张三");
			listParams.add(paramList);
		}
		BoxJdbcCUDExample example = BoxJdbcCUDExample
				.createInstanceForParamsList("", sql, listParams);
		BoxJdbcUtils.excuteCUD(example);
	}

	/**
	 * 批量操作数据到数据库表中去，需要传入数据源,sql语句，参数集合，批量处理数量
	 */
	public static void testInsertWithBatch() {
		String sql = "insert into sys_log_app(fd_id,fd_created,fd_ip,fd_operator) values(?,?,?,?)";
		List<List<Object>> paramsList = new ArrayList<List<Object>>();
		for (int i = 0; i < 580; i++) {
			List<Object> paramList = new ArrayList<Object>();
			paramList.add(IDGenerator.generateID());
			paramList.add(new Date());
			paramList.add("127.0.0.1");
			paramList.add("张三");
			paramsList.add(paramList);
		}
		BoxJdbcCUDExample example = BoxJdbcCUDExample
				.createInstanceForParamsList("", sql, paramsList);
		// 每100个做一次提交
		BoxJdbcUtils.executeCUDInBatch(example, 100);
	}

	/**
	 * 测试修改
	 */
	public static void testUpdate() {
		String sql = "update sys_log_app set fd_ip = ? where fd_operator = ?";
		List<Object> paramList = new ArrayList<Object>();
		paramList.add("127.0.0.100");
		paramList.add("张三");
		BoxJdbcCUDExample example = BoxJdbcCUDExample
				.createInstanceForParams(sql, paramList);
		BoxJdbcUtils.excuteCUD(example);
	}

	/**
	 * 测试删除
	 */
	public static void testDelete() {
		String sql = "delete from sys_log_app where fd_operator = ?";
		List<Object> paramList = new ArrayList<Object>();
		paramList.add("张三");
		BoxJdbcCUDExample example = BoxJdbcCUDExample
				.createInstanceForParams(sql, paramList);
		BoxJdbcUtils.excuteCUD(example);
	}
	
}