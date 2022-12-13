package com.landray.kmss.geesun.org.service.spring;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.util.EntityUtils;
import org.springframework.jdbc.support.JdbcUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.landray.kmss.constant.SysNotifyConstant;
import com.landray.kmss.geesun.org.model.GeesunOrgBaseElementModel;
import com.landray.kmss.geesun.org.model.GeesunOrgDetailElementModel;
import com.landray.kmss.geesun.org.model.GeesunOrgEkp;
import com.landray.kmss.geesun.org.model.GeesunOrgSynchroConfig;
import com.landray.kmss.geesun.org.service.IGeesunOrgEkpService;
import com.landray.kmss.geesun.org.service.IGeesunOrgRecordService;
import com.landray.kmss.geesun.org.service.IGeesunSynOrganizationQuarzeService;
import com.landray.kmss.geesun.org.service.ISysSynchroOrganService;
import com.landray.kmss.geesun.org.util.GeesunOrgConstants;
import com.landray.kmss.geesun.org.util.MySSLSocketFactory;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.notify.interfaces.NotifyContext;
import com.landray.kmss.sys.notify.interfaces.NotifyReplace;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.organization.service.ISysOrgElementBakService;
import com.landray.kmss.sys.organization.webservice.in.SysSynchroSetOrgContext;
import com.landray.kmss.sys.quartz.interfaces.ISysQuartzCoreService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzModelContext;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

/**
 * @author guoyp
 * 同步HR组织架构
 */
public class GeesunSynOrganizationQuarze implements IGeesunSynOrganizationQuarzeService, GeesunOrgConstants {
	
	private static final Log logger = LogFactory.getLog(GeesunSynOrganizationQuarze.class);
	
	/**
	 * 发送邮件bean
	 */
	protected ISysNotifyMainCoreService sysNotifyMainCoreService;
	
	public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
		if (sysNotifyMainCoreService == null) {
			sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil
					.getBean("sysNotifyMainCoreService");
		}
		return sysNotifyMainCoreService;
	}
	
	private ISysQuartzCoreService sysQuartzCoreService;
	
	public ISysQuartzCoreService getSysQuartzCoreService () {
		if (null == sysQuartzCoreService) {
			sysQuartzCoreService = (ISysQuartzCoreService) SpringBeanUtil
					.getBean("sysQuartzCoreService");
		}
		return sysQuartzCoreService;
	}
	
	protected ISysOrgCoreService sysOrgCoreService ;
	
	public ISysOrgCoreService getSysOrgCoreService(){
		if(sysOrgCoreService==null){
			sysOrgCoreService = (ISysOrgCoreService) SpringBeanUtil
					.getBean("sysOrgCoreService");
		}
		return sysOrgCoreService;
	}
	
	/**
	 * 日志记录bean
	 */
	protected IGeesunOrgEkpService geesunOrgEkpService ;
	
	public IGeesunOrgEkpService getGeesunOrgEkpService(){
		if(geesunOrgEkpService==null){
			geesunOrgEkpService = (IGeesunOrgEkpService) SpringBeanUtil
					.getBean("geesunOrgEkpService");
		}
		return geesunOrgEkpService;
	}
	
	/**
	 * 记录bean
	 */
	protected IGeesunOrgRecordService geesunOrgRecordService ;
	
	public IGeesunOrgRecordService getGeesunOrgRecordService(){
		if(geesunOrgRecordService==null){
			geesunOrgRecordService = (IGeesunOrgRecordService) SpringBeanUtil
					.getBean("geesunOrgRecordService");
		}
		return geesunOrgRecordService;
	}
	
	private ISysOrgElementBakService sysOrgElementBakService = null;
	
	public ISysOrgElementBakService getSysOrgElementBakService() {
		if (null == sysOrgElementBakService) {
			sysOrgElementBakService = (ISysOrgElementBakService) SpringBeanUtil
					.getBean("sysOrgElementBakService");
		}
		return sysOrgElementBakService;
	}
	
	protected ISysSynchroOrganService sysSynchroOrganService;
	
	public ISysSynchroOrganService getSysSynchroOrganService() {
		if (null == sysSynchroOrganService) {
			sysSynchroOrganService = (ISysSynchroOrganService) SpringBeanUtil
					.getBean("sysSynchroOrganService");
		}
		return sysSynchroOrganService;
	}
	
	/**
	 * 同步HR组织架构数据到中间表定时任务
	 */
	public void SynchOrganizationToMiddleQuartz(SysQuartzJobContext 
			context) throws Exception {
		context.logMessage("开始执行定时任务，同步HR组织架构数据到中间表定时任务……");
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Calendar calendar = Calendar.getInstance();
		String nowDate = DateUtil.convertDateToString(calendar.getTime(), DateUtil.PATTERN_DATE);
		//日志类实例，保存日志信息
		GeesunOrgEkp log = new GeesunOrgEkp();
		String url = ModelUtil.getModelUrl(log);
		log.setDocCreateTime(calendar.getTime());//时间
		log.setFdResult(FD_RESULT_FAILURE);//默认失败
		log.setFdType(GeesunOrgConstants.FD_TYPE_MIDDLE);//HR-中间表
		boolean flag = true;
		//记录失败信息变量
		String message = "";
		//用于记录三个接口调用返回信息
		JSONArray returnsArray = new JSONArray();
		//组织对象数组
		JSONArray organArray = new JSONArray();
		JSONArray personArray = new JSONArray();
		JSONArray postArray = new JSONArray();
		try {
			//配置类实例，用于获取接口信息及出错通知人
			GeesunOrgSynchroConfig config = new GeesunOrgSynchroConfig();
			String fdUrl = config.getFdUrl().trim() + "dept";
			String organResult = sendPost(fdUrl);
			if (StringUtil.isNotNull(organResult)) {
				JSONObject organ = JSONObject.parseObject(organResult);
				if (organ.containsKey("State") && organ.getInteger("State") == 1) {
					organArray = organ.getJSONArray("Data").getJSONArray(0);
					returnsArray.add(organArray);
				} else {
					message = StringUtil.linkString(message, "</br>", organ.getString("ErrorMessage"));
				}
			} else {
				flag = false;
			}
			//开始获取HR人员数据
			fdUrl = config.getFdUrl().trim() + "emp";
			String personResult = sendPost(fdUrl);
			if (StringUtil.isNotNull(personResult)) {
				JSONObject person = JSONObject.parseObject(personResult);
				if (person.containsKey("State") && person.getInteger("State") == 1) {
					personArray = person.getJSONArray("Data").getJSONArray(0);
					returnsArray.add(personArray);
				} else {
					message = StringUtil.linkString(message, "</br>", person.getString("ErrorMessage"));
				}
			} else {
				flag = false;
			}
			//开始获取HR岗位数据
			fdUrl = config.getFdUrl().trim() + "post";
			String postResult = sendPost(fdUrl);
			if (StringUtil.isNotNull(postResult)) {
				JSONObject post = JSONObject.parseObject(postResult);
				if (post.containsKey("State") && post.getInteger("State") == 1) {
					postArray = post.getJSONArray("Data").getJSONArray(0);
					returnsArray.add(postArray);
				} else {
					message = StringUtil.linkString(message, "</br>", post.getString("ErrorMessage"));
				}
			} else {
				flag = false;
			}
			log.setFdReturns(returnsArray.toString());
			log.setFdMessage(message);
			//标志位如果失败说明执行过程中出现失败,发送邮件通知
			if (flag) {
				//先清除中间表，再重新将获取到的HR组织架构数据写入中间表
				getGeesunOrgEkpService().clean(dataSource);
				getGeesunOrgEkpService().addOrganizationMiddle(dataSource, organArray, personArray, postArray);
//				getGeesunOrgRecordService().addRecordMiddle(dataSource, organArray, personArray, postArray);
				log.setFdResult(FD_RESULT_SUCCESS);//成功
			} else {
				sendSynExecuteException(nowDate, url);
			}
		} catch (Exception e) {
			log.setFdMessage(getExceptionDetail(e));
			logger.error(e);
			sendSynExecuteException(nowDate, url);
			context.logError(e);
		} finally {
			getGeesunOrgEkpService().add(log);
		}
		context.logMessage("执行定时任务完成，同步HR组织架构数据到中间表定时任务结束！");
	}
	
	/**
	 * 调用HR接口获取组织信息
	 * @param config
	 * @return
	 * @throws Exception
	 */
	public static String sendPost(String url) throws Exception {
		 HttpClient client = MySSLSocketFactory.getNewHttpClient();  
	    HttpPost post = new HttpPost(url);
        post.setHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)"); 
	    String responseContent = null; // 响应内容
	    HttpResponse response = null;
	    try {
	        response = client.execute(post);
	        if (response.getStatusLine().getStatusCode() == 200) {
	            HttpEntity entity = response.getEntity();
	            responseContent = EntityUtils.toString(entity);//返回json格式       
	        }
	    } catch(Exception e) {
	    	throw new RuntimeException(e);
	    } finally {
	    	
	    }
	    return responseContent;
	}
	
	/**
	 * 同步中间表到EKP组织架构定时任务
	 */
	public void SynchOrganizationQuartz(SysQuartzJobContext context) throws Exception {
		context.logMessage("开始执行定时任务，同步HR组织架构数据定时任务……");
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Calendar calendar = Calendar.getInstance();
		//日志类实例，保存日志信息
		GeesunOrgEkp log = new GeesunOrgEkp();
		String url = ModelUtil.getModelUrl(log);
		log.setDocCreateTime(calendar.getTime());//时间
		log.setFdResult("FAILURE");//默认失败
		log.setFdType(GeesunOrgConstants.FD_TYPE_EKP);//中间表-EKP
		String nowDate = DateUtil.convertDateToString(calendar.getTime(), "yyyy-MM");
		try {
			//配置类实例，用于获取同步方式
			GeesunOrgSynchroConfig config = new GeesunOrgSynchroConfig();
			boolean flag = checkMiddleQuartzExecSuccess(dataSource, nowDate);
			if (flag) {
				List<GeesunOrgBaseElementModel> baseList = new ArrayList<GeesunOrgBaseElementModel>();
				List<GeesunOrgDetailElementModel> detailList = new ArrayList<GeesunOrgDetailElementModel>();
				String fdFilterParentIds = config.getFdFilterParentIds();
				List<String> parentIdList = new ArrayList<String>();
				if (StringUtil.isNotNull(fdFilterParentIds)) {
					parentIdList.addAll(Arrays.asList(ArrayUtil.toStringArray(fdFilterParentIds.split(";"))));
				}
				List<String> filterOrganList = getGeesunOrgEkpService().getChildIdList(parentIdList, dataSource, "geesunOrgOrgan", "fdDeptId", "fdParentId", null);
				logger.error("获取到需排除的组织ID集合长度为：" + filterOrganList.size() + ", 集合信息为：" + filterOrganList);
				List<String> filterPersonList = getGeesunOrgEkpService().getChildIdList(parentIdList, dataSource, "geesunOrgPerson", "fdPersonId", "fdParentId", filterOrganList);
				logger.error("获取到需排除的人员ID集合长度为：" + filterPersonList.size() + ", 集合信息为：" + filterPersonList);
				List<String> filterPostList = getGeesunOrgEkpService().getChildIdList(parentIdList, dataSource, "geesunOrgPost", "fdPostId", "fdParentId", filterOrganList);
				logger.error("获取到需排除的岗位ID集合长度为：" + filterPostList.size() + ", 集合信息为：" + filterPostList);
				//获取到基础及详细组织架构数据
				getGeesunOrgEkpService().getBaseElementList(dataSource, baseList, detailList, filterOrganList, filterPersonList, filterPostList);
				if (!ArrayUtil.isEmpty(baseList) && !ArrayUtil.isEmpty(detailList)) {
					SysSynchroSetOrgContext orgDetailContext = new SysSynchroSetOrgContext();
					orgDetailContext.setAppName("EHR");
					orgDetailContext.setOrgJsonData(net.sf.json.JSONArray.fromObject(detailList).toString());
//					if (FD_ZZTYPE_ALL.equals(config.getFdZzType())) {
						getSysSynchroOrganService().syncOrgElementsBaseInfo(context, baseList, orgDetailContext);
//						config.setFdZzType(FD_ZZTYPE_ZL);//设置为增量同步
//						config.save();
//					} else {
//						getSysSynchroOrganService().updateOrgElement(orgDetailContext);
//					}
					log.setFdResult(FD_RESULT_SUCCESS);//成功
				} else {
					context.logMessage("未获取到中间表的临时组织架构数据！");
					log.setFdMessage("未获取到中间表的临时组织架构数据！");
					sendSynExecuteException(nowDate, url);
				}
			} else {
				context.logMessage("同步HR组织架构数据到中间表定时任务执行失败或者未执行，请先检查此定时任务！");
				log.setFdMessage("同步HR组织架构数据到中间表定时任务执行失败，本定时任务不予执行！");
				sendSynExecuteException(nowDate, url);
			}
		} catch (Exception e) {
			//设置普通任务还原组织架构
			//generateCommonQuartz(log);
			//记录错误信息
			log.setFdMessage(getExceptionDetail(e));
			logger.error(e);
			//发送待办
			sendSynExecuteException(nowDate, url);
			context.logError(e);
		} finally {
			//保存同步日志
			getGeesunOrgEkpService().add(log);
		}
		context.logMessage("执行定时任务完成，同步HR组织架构数据定时任务结束！");
	}
	
	/**
	 * 创建普通任务
	 * @param geesunOrgEkp
	 * @throws Exception
	 */
	private void generateCommonQuartz(GeesunOrgEkp geesunOrgEkp) throws Exception {
		SysQuartzModelContext quartzContext = new SysQuartzModelContext();
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MINUTE, 4);
		JSONObject parameter = new JSONObject();
		parameter.put("fdId", geesunOrgEkp.getFdId());
		quartzContext.setQuartzParameter(parameter.toString());
		quartzContext.setQuartzCronExpression(SysQuartzModelContext
				.getCronExpression(calendar));
		quartzContext.setQuartzJobMethod("restore");
		quartzContext.setQuartzJobService("sysOrgElementBakService");
		quartzContext.setQuartzKey("restoreOrganizationQuartz");
		quartzContext.setQuartzLink(ModelUtil.getModelUrl(geesunOrgEkp));
		quartzContext.setQuartzSubject("执行组织架构还原逻辑");
		quartzContext.setQuartzEnabled(true);
		getSysQuartzCoreService().addScheduler(quartzContext,
				geesunOrgEkp);
	}
	
	/**
	 * 判断指定日期的中间表同步是否成功
	 * @param dataSource
	 * @param fdDate
	 * @return
	 * @throws Exception
	 */
	private boolean checkMiddleQuartzExecSuccess(DataSource dataSource, 
			String fdDate) throws Exception {
		boolean flag = false;
		Connection connect = null;
		PreparedStatement selectFlonaEkp = null;
		ResultSet resultSet = null;
		try {
			connect = dataSource.getConnection();
			connect.setAutoCommit(false);
			String sqlDialet = ResourceUtil
					.getKmssConfigString("hibernate.dialect");
			String dateWhere = "";
			if (sqlDialet.contains("Oracle")) {
				dateWhere = "to_char(doc_create_time, 'yyyy-MM') = ?";
			} else if (sqlDialet.contains("MySQL")) {
				dateWhere = "DATE_FORMAT(doc_create_time, '%Y-%m') = ?";
			} else if (sqlDialet.contains("SQLServer")) {
				dateWhere = "convert(varchar(7), doc_create_time, 126) = ?";
			}
			selectFlonaEkp = connect
					.prepareStatement("select count(fd_id) from geesun_org_ekp "
					+ " where fd_result = ? and fd_type = ? and " + dateWhere);
			selectFlonaEkp.setString(1, FD_RESULT_SUCCESS);
			selectFlonaEkp.setString(2, FD_TYPE_MIDDLE);
			selectFlonaEkp.setString(3, fdDate);
			resultSet = selectFlonaEkp.executeQuery();
			while (resultSet.next()) {
				if (resultSet.getLong(1) > 0) {
					flag = true;
				}
			}
		} catch (SQLException ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(resultSet);
			JdbcUtils.closeStatement(selectFlonaEkp);
			JdbcUtils.closeConnection(connect);
		}
		return flag;
	}
	
	/**
	 * 发送邮件
	 * @param fdDate
	 * @param url
	 * @throws Exception
	 */
	private void sendSynExecuteException(String fdDate, String url) throws Exception {
		GeesunOrgSynchroConfig config = new GeesunOrgSynchroConfig();
		String exceptionTargetIds = config.getNotifyExceptionTargetIds();
		if (StringUtil.isNull(exceptionTargetIds)) {
			return;
		}
		List<SysOrgElement> listOrg = getSysOrgCoreService().expandToPerson(ArrayUtil.convertArrayToList(exceptionTargetIds.split(";")));
		// 通知方式
		String notifyType = config.getNotifyErrorNotifyType();
		NotifyReplace notifyReplace = new NotifyReplace();
		notifyReplace.addReplaceText("executeDate",
				fdDate);
		NotifyContext notifyContext = getSysNotifyMainCoreService()
				.getContext(
						"geesun-org:geesunOrgSynchroConfig.notify");
		notifyContext.setNotifyType(notifyType);
		notifyContext.setKey("geesunOrgSynchroErrorException");
		notifyContext.setLink(url);
		notifyContext
				.setFlag(SysNotifyConstant.NOTIFY_TODOTYPE_ONCE);
		notifyContext.setNotifyTarget(listOrg);
		notifyContext
				.setDocCreator((SysOrgPerson) getSysOrgCoreService()
						.findByPrimaryKey(
								"1183b0b84ee4f581bba001c47a78b2d9",
								SysOrgPerson.class, true));
		getSysNotifyMainCoreService().sendNotify(null, notifyContext,
				notifyReplace);
	}
	
	private String getExceptionDetail(Exception e) {  
        StringBuffer stringBuffer = new StringBuffer(e.toString() + "\n");  
        StackTraceElement[] messages = e.getStackTrace();  
        int length = messages.length;  
        for (int i = 0; i < length; i++) {  
            stringBuffer.append("\t"+messages[i].toString()+"\n");  
        }  
        return stringBuffer.toString();  
    } 
	
}
