package com.landray.kmss.geesun.org.dao.hibernate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.cfg.Environment;
import org.springframework.jdbc.support.JdbcUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.geesun.org.dao.IGeesunOrgEkpDao;
import com.landray.kmss.geesun.org.model.GeesunOrgBaseElementModel;
import com.landray.kmss.geesun.org.model.GeesunOrgDetailElementModel;
import com.landray.kmss.sys.admin.dbchecker.metadata.util.MetadataUtil;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

/**
 * HR同步日志数据访问接口实现
 * 
 * @author 
 * @version 1.0 2019-06-19
 */
public class GeesunOrgEkpDaoImp extends BaseDaoImp implements IGeesunOrgEkpDao {

	private static final Log logger = LogFactory.getLog(GeesunOrgEkpDaoImp.class);
	
	private final int batchCount = 1000;
	
	/**
	 * 从中间表获取组织架构数据
	 * @param dataSource
	 * @param baseList
	 * @param detailList
	 * @param filterOrganList
	 * @param filterPersonList
	 * @param filterPostList
	 * @return
	 * @throws Exception
	 */
	public void getBaseElementList(DataSource dataSource, 
			List<GeesunOrgBaseElementModel> baseList, List<GeesunOrgDetailElementModel> detailList,
			List<String> filterOrganList, List<String> filterPersonList, List<String> filterPostList) throws Exception {
		Connection connect = null;
		PreparedStatement selectOrganMiddle = null;
		PreparedStatement selectPersonMiddle = null;
		PreparedStatement selectPostMiddle = null;
		ResultSet resultSetOrgan = null;
		ResultSet resultSetPerson = null;
		ResultSet resultSetPost = null;
		try {
			connect = dataSource.getConnection();
			connect.setAutoCommit(false);
			Boolean isSqlServer = MetadataUtil
					.isSQLServer(ResourceUtil.getKmssConfigString(Environment.DIALECT));
			String personSql = "SELECT person.fd_person_id, person.fd_emp_no, person.fd_emp_name, person.fd_parent_id, person.fd_post_id, person.fd_sex, person.fd_birth_date, "
					+ "person.fd_mobile, person.fd_address, person.fd_country, person.fd_super_post_id, person.fd_super_dept_id, person.fd_rank, person.fd_email, person.fd_id_card, "
					+ "person.fd_entry_date, person.fd_leave_date, person.fd_city, person.fd_subject_name, person.fd_work_state, person.fd_new_date, person.fd_estimate_time, "
					+ "person.fd_empcategory, person.fd_education, person.fd_kqcategory FROM geesun_org_person person "
					+ " left join geesun_org_post post on person.fd_post_id = post.fd_post_id left join geesun_org_organ organ on person.fd_parent_id = organ.fd_dept_id";
			if (isSqlServer) {
				personSql = StringUtil.linkString(personSql, " where ", "(charindex(?, post.fd_post_name) <= 0 or charindex(?, organ.fd_dept_name) <= 0)");
			} else {
				personSql = StringUtil.linkString(personSql, " where ", "(instr(post.fd_post_name, ?) <= 0 or instr(organ.fd_dept_name, ?) <= 0)");
			}
			if (!ArrayUtil.isEmpty(filterPersonList)) {
		    	personSql = StringUtil.linkString(personSql, " and ", HQLUtil.buildLogicNotIN("person.fd_person_id", filterPersonList));
		    }
			String organSql = "select fd_dept_id, fd_dept_name, fd_dept_no, fd_parent_id, fd_setup_date, fd_is_del, fd_new_date, fd_remark, fd_charge_man from geesun_org_organ";
			if (!ArrayUtil.isEmpty(filterOrganList)) {
		    	organSql = StringUtil.linkString(organSql, " where ", HQLUtil.buildLogicNotIN("fd_dept_id", filterOrganList));
		    }
			selectOrganMiddle = connect
					.prepareStatement(organSql);
			selectPersonMiddle = connect
					.prepareStatement(personSql);
			selectPersonMiddle.setString(1, "临时");
			selectPersonMiddle.setString(2, "临时工");
			String postSql = "select fd_post_id, fd_post_name, fd_parent_id, fd_post_no, fd_super_post_id, fd_super_dept_id, fd_qidong_date, fd_new_date, fd_is_del from geesun_org_post";
			if (!ArrayUtil.isEmpty(filterPostList)) {
		    	postSql = StringUtil.linkString(postSql, " where ", HQLUtil.buildLogicNotIN("fd_post_id", filterPostList));
		    }
			selectPostMiddle = connect
					.prepareStatement(postSql);
			resultSetOrgan = selectOrganMiddle.executeQuery();
			while (resultSetOrgan.next()) {
				GeesunOrgBaseElementModel baseModel = new GeesunOrgBaseElementModel();
				GeesunOrgDetailElementModel detailModel = new GeesunOrgDetailElementModel();
				String id = "02" + resultSetOrgan.getInt(1);
				String lunid = "02" + resultSetOrgan.getInt(1) + resultSetOrgan.getString(3);
				baseModel.setId(id);
				baseModel.setLunid(lunid);
				baseModel.setNo(resultSetOrgan.getString(3));
				baseModel.setName(resultSetOrgan.getString(2));
				detailModel.setId(id);
				detailModel.setLunid(lunid);
				detailModel.setNo(resultSetOrgan.getString(3));
				detailModel.setName(resultSetOrgan.getString(2));
				Integer parent = resultSetOrgan.getInt(4);
				if (null != parent && 987654321 != parent) {
					detailModel.setParent("02" + parent.toString());
				}
				Integer thisLeader = resultSetOrgan.getInt(9);
				if (null != thisLeader && 987654321 != thisLeader) {
					detailModel.setThisLeader(getTypeFromTable(thisLeader.toString()) + thisLeader.toString());
				}
//				Integer order = resultSetOrgan.getInt(7);
//				if (null != order && 987654321 != order) {
//					baseModel.setOrder(order);
//					detailModel.setOrder(order.toString());
//				}
				baseModel.setType("dept");
				detailModel.setType("dept");
				Integer isDel = resultSetOrgan.getInt(6);
				if (isDel == 0) {
					detailModel.setIsAvailable(true);
				} else {
					detailModel.setIsAvailable(false);
				}
				//拼接自定义参数
				org.json.simple.JSONObject customerProperty = new org.json.simple.JSONObject();
				String fdDeptId = resultSetOrgan.getString(1);
				if (StringUtil.isNotNull(fdDeptId)) {
					customerProperty.put("bumenid", fdDeptId);
				}
				if (!customerProperty.isEmpty()) {
					detailModel.setCustomProps(customerProperty);
				}
				detailModel.setMemo(resultSetOrgan.getString(8));
				baseList.add(baseModel);
				detailList.add(detailModel);
			}
			resultSetPerson = selectPersonMiddle.executeQuery();
			while (resultSetPerson.next()) {
				GeesunOrgBaseElementModel baseModel = new GeesunOrgBaseElementModel();
				GeesunOrgDetailElementModel detailModel = new GeesunOrgDetailElementModel();
				String id = "08" + resultSetPerson.getInt(1);
				String lunid = "08" + resultSetPerson.getInt(1) + resultSetPerson.getString(2);
				baseModel.setId(id);
				baseModel.setLunid(lunid);
				baseModel.setNo(resultSetPerson.getString(2));
				baseModel.setName(resultSetPerson.getString(3));
				detailModel.setId(id);
				detailModel.setLunid(lunid);
				detailModel.setNo(resultSetPerson.getString(2));
				detailModel.setLoginName(resultSetPerson.getString(2));
				detailModel.setName(resultSetPerson.getString(3));
//				detailModel.setNickName(resultSetPerson.getString(3));
//				baseModel.setNickName(resultSetPerson.getString(3));
				//岗位列表
				List postList = new ArrayList();
				Integer fdPost = resultSetPerson.getInt(5);
				if (null != fdPost && 987654321 != fdPost) {
					postList.add("04" + fdPost);
				}
				detailModel.setPosts(postList);
				Integer parent = resultSetPerson.getInt(4);
				if (null != parent && 987654321 != parent) {
					detailModel.setParent("02" + parent.toString());
				}
				//拼接自定义参数
				org.json.simple.JSONObject customerProperty = new org.json.simple.JSONObject();
				String fdBirthDate = resultSetPerson.getString(7);
				String fdAddress = resultSetPerson.getString(9);
				String fdIdCard = resultSetPerson.getString(15);
				String fdEntryDate = resultSetPerson.getString(16);
				String fdEstimatetrialtime = resultSetPerson.getString(22);
				String fdEmpCategory = resultSetPerson.getString(23);
				String fdEducation = resultSetPerson.getString(24);
				String fdKQCategory = resultSetPerson.getString(25);
				String fdOutDate = resultSetPerson.getString(17);
				String fdPersonId = resultSetPerson.getString(1);
				String fdDeptId = resultSetPerson.getString(4);
				String fdPostId = resultSetPerson.getString(5);
				if (StringUtil.isNotNull(fdBirthDate)) {
					customerProperty.put("chushengriqi", fdBirthDate.replaceAll("T", " "));
				}
				if (StringUtil.isNotNull(fdAddress)) {
					customerProperty.put("zhuzhi", fdAddress);
				}
				if (StringUtil.isNotNull(fdIdCard)) {
					customerProperty.put("shenfenzhenghao", fdIdCard);
				}
				if (StringUtil.isNotNull(fdOutDate)) {
					customerProperty.put("lizhiriqi", fdOutDate.replaceAll("T", " "));
				}
				if (StringUtil.isNotNull(fdEntryDate)) {
					customerProperty.put("ruzhiriqi", fdEntryDate.replaceAll("T", " "));
				}
				if (StringUtil.isNotNull(fdEstimatetrialtime)) {
					customerProperty.put("evaculate_leave_date", String.valueOf(fdEstimatetrialtime.replaceAll("/", "-")) + " 00:00");
				}
				if (StringUtil.isNotNull(fdEmpCategory)) {
					customerProperty.put("yuangongleixing", fdEmpCategory);
				}
				if (StringUtil.isNotNull(fdEducation)) {
					customerProperty.put("xueli", fdEducation);
				}
				if (StringUtil.isNotNull(fdKQCategory)) {
					customerProperty.put("kqleixing", fdKQCategory);
				}
				if (StringUtil.isNotNull(fdPersonId)) {
					customerProperty.put("renyuanid", fdPersonId);
				}
				if (StringUtil.isNotNull(fdDeptId)) {
					customerProperty.put("renyuanbumenid", fdDeptId);
				}
				if (StringUtil.isNotNull(fdPostId)) {
					customerProperty.put("renyuangangweiid", fdPostId);
				}
				if (!customerProperty.isEmpty()) {
					detailModel.setCustomProps(customerProperty);
				}
				detailModel.setMobileNo(resultSetPerson.getString(8));
				detailModel.setEmail(resultSetPerson.getString(14));
//				detailModel.setWorkPhone(resultSetPerson.getString(9));
//				detailModel.setWechat(resultSetPerson.getString(10));
				String fdSex = resultSetPerson.getString(6);
				detailModel.setSex("男".equals(fdSex)?"M":"F");
				baseModel.setType("person");
				detailModel.setType("person");
				String workState = resultSetPerson.getString(20);
				if ("在职".equals(workState)) {
					detailModel.setIsAvailable(true);
				} else {
					detailModel.setIsAvailable(false);
				}
				baseList.add(baseModel);
				detailList.add(detailModel);
			}
			resultSetPost = selectPostMiddle.executeQuery();
			while (resultSetPost.next()) {
				GeesunOrgBaseElementModel baseModel = new GeesunOrgBaseElementModel();
				GeesunOrgDetailElementModel detailModel = new GeesunOrgDetailElementModel();
				String id = "04" + resultSetPost.getInt(1);
				String lunid = "04" + resultSetPost.getInt(1) + resultSetPost.getString(4);
				baseModel.setId(id);
				baseModel.setLunid(lunid);
				baseModel.setNo(resultSetPost.getString(4));
				baseModel.setName(resultSetPost.getString(2));
				detailModel.setId(id);
				detailModel.setLunid(lunid);
				detailModel.setNo(resultSetPost.getString(4));
				detailModel.setName(resultSetPost.getString(2));
				Integer parent = resultSetPost.getInt(3);
				if (null != parent && 987654321 != parent) {
					detailModel.setParent("02" + parent.toString());
				}
				Integer thisLeader = resultSetPost.getInt(5);
				if (null != thisLeader && 987654321 != thisLeader) {
					detailModel.setThisLeader("04" + thisLeader.toString());
				}
//				Integer order = resultSetPost.getInt(6);
//				if (null != order && 987654321 != order) {
//					baseModel.setOrder(order);
//					detailModel.setOrder(order.toString());
//				}
				baseModel.setType("post");
				detailModel.setType("post");
				Integer isDel = resultSetPost.getInt(9);
				if (isDel == 0) {
					detailModel.setIsAvailable(true);
				} else {
					detailModel.setIsAvailable(false);
				}
				//拼接自定义参数
				org.json.simple.JSONObject customerProperty = new org.json.simple.JSONObject();
				String fdPostId = resultSetPost.getString(1);
				String fdDeptId = resultSetPost.getString(3);
				if (StringUtil.isNotNull(fdPostId)) {
					customerProperty.put("gangweiid", fdPostId);
				}
				if (StringUtil.isNotNull(fdDeptId)) {
					customerProperty.put("gangweibumenid", fdDeptId);
				}
				if (!customerProperty.isEmpty()) {
					detailModel.setCustomProps(customerProperty);
				}
				baseList.add(baseModel);
				detailList.add(detailModel);
			}
		} catch (SQLException ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(resultSetOrgan);
			JdbcUtils.closeResultSet(resultSetPerson);
			JdbcUtils.closeResultSet(resultSetPost);
			JdbcUtils.closeStatement(selectOrganMiddle);
			JdbcUtils.closeStatement(selectPersonMiddle);
			JdbcUtils.closeStatement(selectPostMiddle);
			JdbcUtils.closeConnection(connect);
		}
	}
	
	/**
	 * 根据ID获取类型
	 * @param fdId
	 * @return
	 * @throws Exception
	 */
	private String getTypeFromTable(String id) throws Exception {
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		String type = "04";
		Connection connect = null;
		PreparedStatement selectType = null;
		ResultSet resultSet = null;
		try {
			connect = dataSource.getConnection();
			connect.setAutoCommit(false);
			selectType = connect
					.prepareStatement("select count(fd_id) from geesun_org_person "
							+ " where fd_person_id = ?");
			selectType.setString(1, id);
			resultSet = selectType.executeQuery();
			if (resultSet.next() && resultSet.getLong(1) > 0) {
				type = "08";
			}
		} catch (SQLException ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(selectType);
			JdbcUtils.closeConnection(connect);
		}
		return type;
	}
	
	public void addOrganizationMiddle(DataSource dataSource, JSONArray organArray, 
			JSONArray personArray, JSONArray postArray) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		Calendar c = Calendar.getInstance();
		Connection connect = null;
		PreparedStatement organInsertSql = null;
		PreparedStatement personInsertSql = null;
		PreparedStatement postInsertSql = null;
		try {
			connect = dataSource.getConnection();
			connect.setAutoCommit(false);
			long loop = 0;
			long loop1 = 0;
			long loop2 = 0;
			organInsertSql = connect
					.prepareStatement("insert into geesun_org_organ(fd_id, fd_dept_id, fd_dept_name, fd_dept_no, fd_remark, fd_parent_id, fd_setup_date, fd_is_del, fd_new_date, doc_create_time, fd_charge_man)"
							+ " values(?,?,?,?,?,?,?,?,?,?,?)");
			personInsertSql = connect
					.prepareStatement("insert into geesun_org_person(fd_id, fd_person_id, fd_emp_no, fd_emp_name, fd_parent_id, fd_post_id, fd_sex, fd_birth_date, fd_mobile, fd_address, "
							+ "fd_country, fd_super_post_id, fd_super_dept_id, fd_rank, fd_email, fd_id_card, fd_entry_date, fd_leave_date, fd_city, fd_subject_name, fd_work_state, fd_new_date, fd_estimate_time, " 
							+ "fd_empcategory, fd_education, fd_kqcategory, doc_create_time) "
							+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			postInsertSql = connect
					.prepareStatement("insert into geesun_org_post(fd_id, fd_post_id, fd_post_name, fd_parent_id, fd_is_del, fd_post_no, fd_super_post_id, fd_super_dept_id, fd_qidong_date, fd_new_date, doc_create_time)"
							+ " values(?,?,?,?,?,?,?,?,?,?,?)");
			for (int i = 0; i < organArray.size(); i++) {
				if (loop > 0 && (loop % batchCount == 0)) {
					organInsertSql.executeBatch();
					connect.commit();
					logger.debug("第" + loop / batchCount
									+ "批次提交基础架构组织数据.");
				}
				JSONObject organ = organArray.getJSONObject(i);
				organInsertSql.setString(1, IDGenerator.generateID());
				organInsertSql.setInt(2, null!=organ.getInteger("ID")?organ.getInteger("ID"):987654321);
				organInsertSql.setString(3, organ.getString("DeptName"));
				organInsertSql.setString(4, organ.getString("DeptNo"));
				organInsertSql.setString(5, organ.getString("Remark"));
				organInsertSql.setInt(6, (null!=organ.getInteger("ParentID")&&organ.getInteger("ParentID")!=0)?organ.getInteger("ParentID"):987654321);
				organInsertSql.setTimestamp(7, (StringUtil.isNotNull(organ.getString("SetupDate"))?new java.sql
						.Timestamp(sdf.parse(organ.getString("SetupDate")).getTime()):null));
				organInsertSql.setInt(8, null!=organ.getInteger("isDel")?organ.getInteger("isDel"):987654321);
				organInsertSql.setTimestamp(9, (StringUtil.isNotNull(organ.getString("newdate"))?new java.sql
						.Timestamp(sdf.parse(organ.getString("newdate")).getTime()):null));
				organInsertSql.setTimestamp(10, new java.sql.Timestamp(c.getTimeInMillis()));
				organInsertSql.setInt(11, (null!=organ.getInteger("ChargeMan")&&organ.getInteger("ChargeMan")!=0)?organ.getInteger("ChargeMan"):987654321);
				organInsertSql.addBatch();
				loop++;
			}
			for (int i = 0; i < personArray.size(); i++) {
				if (loop1 > 0 && (loop1 % batchCount == 0)) {
					personInsertSql.executeBatch();
					connect.commit();
					logger.debug("第" + loop1 / batchCount
									+ "批次提交详细组织数据.");
				}
				JSONObject person = personArray.getJSONObject(i);
				personInsertSql.setString(1, IDGenerator.generateID());
				personInsertSql.setInt(2, null!=person.getInteger("ID")?person.getInteger("ID"):987654321);
				personInsertSql.setString(3, person.getString("EmpID"));
				personInsertSql.setString(4, person.getString("EmpName"));
				personInsertSql.setInt(5, (null!=person.getInteger("DeptID")&&person.getInteger("DeptID")!=0)?person.getInteger("DeptID"):987654321);
				personInsertSql.setInt(6, (null!=person.getInteger("PostID")&&person.getInteger("PostID")!=0)?person.getInteger("PostID"):987654321);
				personInsertSql.setString(7, person.getString("Sex"));
				personInsertSql.setString(8, person.getString("Birthday"));
				personInsertSql.setString(9, person.getString("Mobile"));
				personInsertSql.setString(10, person.getString("Address"));
				personInsertSql.setString(11, person.getString("Country"));
				personInsertSql.setInt(12, (null!=person.getInteger("PPostID")&&person.getInteger("PPostID")!=0)?person.getInteger("PPostID"):987654321);
				personInsertSql.setInt(13, (null!=person.getInteger("PDeptID")&&person.getInteger("PDeptID")!=0)?person.getInteger("PDeptID"):987654321);
				personInsertSql.setString(14, person.getString("RankName"));
				personInsertSql.setString(15, person.getString("Email"));
				personInsertSql.setString(16, person.getString("IDCardNO"));
				personInsertSql.setString(17, person.getString("EntryTime"));
				personInsertSql.setString(18, person.getString("LeaveTime"));
				personInsertSql.setString(19, person.getString("City"));
				personInsertSql.setString(20, person.getString("SubjectName"));
				personInsertSql.setString(21, person.getString("WorkState"));
				personInsertSql.setTimestamp(22, (StringUtil.isNotNull(person.getString("newdate"))?new java.sql
						.Timestamp(sdf.parse(person.getString("newdate")).getTime()):null));
				personInsertSql.setString(23, person.getString("Estimatetrialtime"));
				personInsertSql.setString(24, person.getString("yglx"));
				personInsertSql.setString(25, person.getString("Education"));
				personInsertSql.setString(26, person.getString("xzlx"));
				personInsertSql.setTimestamp(27, new java.sql.Timestamp(c.getTimeInMillis()));
				personInsertSql.addBatch();
				loop1++;
			}
			for (int i = 0; i < postArray.size(); i++) {
				if (loop2 > 0 && (loop2 % batchCount == 0)) {
					postInsertSql.executeBatch();
					connect.commit();
					logger.debug("第" + loop2 / batchCount
									+ "批次提交基础架构组织数据.");
				}
				JSONObject post = postArray.getJSONObject(i);
				postInsertSql.setString(1, IDGenerator.generateID());
				postInsertSql.setInt(2, null!=post.getInteger("ID")?post.getInteger("ID"):987654321);
				postInsertSql.setString(3, post.getString("PosName"));
				postInsertSql.setInt(4, (null!=post.getInteger("DeptID")&&post.getInteger("DeptID")!=0)?post.getInteger("DeptID"):987654321);
				postInsertSql.setInt(5, null!=post.getInteger("isDel")?post.getInteger("isDel"):987654321);
				postInsertSql.setString(6, post.getString("PosID"));
				postInsertSql.setInt(7, (null!=post.getInteger("ParentID")&&post.getInteger("ParentID")!=0)?post.getInteger("ParentID"):987654321);
				postInsertSql.setInt(8, 987654321);
				postInsertSql.setTimestamp(9, (StringUtil.isNotNull(post.getString("qidongTime"))?new java.sql
						.Timestamp(sdf.parse(post.getString("qidongTime")).getTime()):null));
				postInsertSql.setTimestamp(10, (StringUtil.isNotNull(post.getString("newdate"))?new java.sql
						.Timestamp(sdf.parse(post.getString("newdate")).getTime()):null));
				postInsertSql.setTimestamp(11, new java.sql.Timestamp(c.getTimeInMillis()));
				postInsertSql.addBatch();
				loop2++;
			}
			logger.debug("新增岗位人员数据" + loop2 + "条.");
			organInsertSql.executeBatch();
			postInsertSql.executeBatch();
			personInsertSql.executeBatch();
			connect.commit();
			logger.debug("批量处理完毕.");
		} catch (SQLException ex) {
			connect.rollback();
			throw ex;
		} finally {
			JdbcUtils.closeStatement(organInsertSql);
			JdbcUtils.closeStatement(personInsertSql);
			JdbcUtils.closeStatement(postInsertSql);
			JdbcUtils.closeConnection(connect);
		}
	}
	
	@Override
	public void clean(DataSource dataSource) throws Exception {
		String sysOrganMiddle_sql = "delete from geesun_org_organ";
		String sysPostMiddle_sql = "delete from geesun_org_person" ;
		String sysMiddleMiddle_sql = "delete from geesun_org_post";
		
		PreparedStatement psSysOrganMiddle = null;
		PreparedStatement psSysPostMiddle = null;
		PreparedStatement psSysPersonMiddle = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();

			psSysOrganMiddle = conn.prepareStatement(sysOrganMiddle_sql);
			psSysOrganMiddle.executeUpdate();
			
			psSysPostMiddle = conn.prepareStatement(sysPostMiddle_sql);
			psSysPostMiddle.executeUpdate();
			
			psSysPersonMiddle = conn.prepareStatement(sysMiddleMiddle_sql);
			psSysPersonMiddle.executeUpdate();
			
		} catch (Exception ex) {
			logger.error("清除组织架构中间表数据clean发生异常："+ex);
			throw ex;
		} finally {
			// 关闭流
			JdbcUtils.closeStatement(psSysOrganMiddle);
			JdbcUtils.closeStatement(psSysPostMiddle);
			JdbcUtils.closeStatement(psSysPersonMiddle);
			JdbcUtils.closeConnection(conn);
		}
	}
	
}
