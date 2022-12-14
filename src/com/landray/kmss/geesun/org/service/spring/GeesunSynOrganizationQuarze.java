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
 * ??????HR????????????
 */
public class GeesunSynOrganizationQuarze implements IGeesunSynOrganizationQuarzeService, GeesunOrgConstants {
	
	private static final Log logger = LogFactory.getLog(GeesunSynOrganizationQuarze.class);
	
	/**
	 * ????????????bean
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
	 * ????????????bean
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
	 * ??????bean
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
	 * ??????HR??????????????????????????????????????????
	 */
	public void SynchOrganizationToMiddleQuartz(SysQuartzJobContext 
			context) throws Exception {
		context.logMessage("?????????????????????????????????HR????????????????????????????????????????????????");
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Calendar calendar = Calendar.getInstance();
		String nowDate = DateUtil.convertDateToString(calendar.getTime(), DateUtil.PATTERN_DATE);
		//????????????????????????????????????
		GeesunOrgEkp log = new GeesunOrgEkp();
		String url = ModelUtil.getModelUrl(log);
		log.setDocCreateTime(calendar.getTime());//??????
		log.setFdResult(FD_RESULT_FAILURE);//????????????
		log.setFdType(GeesunOrgConstants.FD_TYPE_MIDDLE);//HR-?????????
		boolean flag = true;
		//????????????????????????
		String message = "";
		//??????????????????????????????????????????
		JSONArray returnsArray = new JSONArray();
		//??????????????????
		JSONArray organArray = new JSONArray();
		JSONArray personArray = new JSONArray();
		JSONArray postArray = new JSONArray();
		try {
			//????????????????????????????????????????????????????????????
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
			//????????????HR????????????
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
			//????????????HR????????????
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
			//??????????????????????????????????????????????????????,??????????????????
			if (flag) {
				//?????????????????????????????????????????????HR?????????????????????????????????
				getGeesunOrgEkpService().clean(dataSource);
				getGeesunOrgEkpService().addOrganizationMiddle(dataSource, organArray, personArray, postArray);
//				getGeesunOrgRecordService().addRecordMiddle(dataSource, organArray, personArray, postArray);
				log.setFdResult(FD_RESULT_SUCCESS);//??????
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
		context.logMessage("?????????????????????????????????HR???????????????????????????????????????????????????");
	}
	
	/**
	 * ??????HR????????????????????????
	 * @param config
	 * @return
	 * @throws Exception
	 */
	public static String sendPost(String url) throws Exception {
		 HttpClient client = MySSLSocketFactory.getNewHttpClient();  
	    HttpPost post = new HttpPost(url);
        post.setHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)"); 
	    String responseContent = null; // ????????????
	    HttpResponse response = null;
	    try {
	        response = client.execute(post);
	        if (response.getStatusLine().getStatusCode() == 200) {
	            HttpEntity entity = response.getEntity();
	            responseContent = EntityUtils.toString(entity);//??????json??????       
	        }
	    } catch(Exception e) {
	    	throw new RuntimeException(e);
	    } finally {
	    	
	    }
	    return responseContent;
	}
	
	/**
	 * ??????????????????EKP????????????????????????
	 */
	public void SynchOrganizationQuartz(SysQuartzJobContext context) throws Exception {
		context.logMessage("?????????????????????????????????HR????????????????????????????????????");
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		Calendar calendar = Calendar.getInstance();
		//????????????????????????????????????
		GeesunOrgEkp log = new GeesunOrgEkp();
		String url = ModelUtil.getModelUrl(log);
		log.setDocCreateTime(calendar.getTime());//??????
		log.setFdResult("FAILURE");//????????????
		log.setFdType(GeesunOrgConstants.FD_TYPE_EKP);//?????????-EKP
		String nowDate = DateUtil.convertDateToString(calendar.getTime(), "yyyy-MM");
		try {
			//??????????????????????????????????????????
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
				logger.error("???????????????????????????ID??????????????????" + filterOrganList.size() + ", ??????????????????" + filterOrganList);
				List<String> filterPersonList = getGeesunOrgEkpService().getChildIdList(parentIdList, dataSource, "geesunOrgPerson", "fdPersonId", "fdParentId", filterOrganList);
				logger.error("???????????????????????????ID??????????????????" + filterPersonList.size() + ", ??????????????????" + filterPersonList);
				List<String> filterPostList = getGeesunOrgEkpService().getChildIdList(parentIdList, dataSource, "geesunOrgPost", "fdPostId", "fdParentId", filterOrganList);
				logger.error("???????????????????????????ID??????????????????" + filterPostList.size() + ", ??????????????????" + filterPostList);
				//??????????????????????????????????????????
				getGeesunOrgEkpService().getBaseElementList(dataSource, baseList, detailList, filterOrganList, filterPersonList, filterPostList);
				if (!ArrayUtil.isEmpty(baseList) && !ArrayUtil.isEmpty(detailList)) {
					SysSynchroSetOrgContext orgDetailContext = new SysSynchroSetOrgContext();
					orgDetailContext.setAppName("EHR");
					orgDetailContext.setOrgJsonData(net.sf.json.JSONArray.fromObject(detailList).toString());
//					if (FD_ZZTYPE_ALL.equals(config.getFdZzType())) {
						getSysSynchroOrganService().syncOrgElementsBaseInfo(context, baseList, orgDetailContext);
//						config.setFdZzType(FD_ZZTYPE_ZL);//?????????????????????
//						config.save();
//					} else {
//						getSysSynchroOrganService().updateOrgElement(orgDetailContext);
//					}
					log.setFdResult(FD_RESULT_SUCCESS);//??????
				} else {
					context.logMessage("???????????????????????????????????????????????????");
					log.setFdMessage("???????????????????????????????????????????????????");
					sendSynExecuteException(nowDate, url);
				}
			} else {
				context.logMessage("??????HR??????????????????????????????????????????????????????????????????????????????????????????????????????");
				log.setFdMessage("??????HR???????????????????????????????????????????????????????????????????????????????????????");
				sendSynExecuteException(nowDate, url);
			}
		} catch (Exception e) {
			//????????????????????????????????????
			//generateCommonQuartz(log);
			//??????????????????
			log.setFdMessage(getExceptionDetail(e));
			logger.error(e);
			//????????????
			sendSynExecuteException(nowDate, url);
			context.logError(e);
		} finally {
			//??????????????????
			getGeesunOrgEkpService().add(log);
		}
		context.logMessage("?????????????????????????????????HR???????????????????????????????????????");
	}
	
	/**
	 * ??????????????????
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
		quartzContext.setQuartzSubject("??????????????????????????????");
		quartzContext.setQuartzEnabled(true);
		getSysQuartzCoreService().addScheduler(quartzContext,
				geesunOrgEkp);
	}
	
	/**
	 * ????????????????????????????????????????????????
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
	 * ????????????
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
		// ????????????
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
