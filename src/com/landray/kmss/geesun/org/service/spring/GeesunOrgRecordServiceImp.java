package com.landray.kmss.geesun.org.service.spring;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.Date;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.alibaba.fastjson.JSONArray;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.geesun.org.dao.IGeesunOrgRecordDao;
import com.landray.kmss.geesun.org.model.GeesunOrgRecord;
import com.landray.kmss.geesun.org.service.IGeesunOrgRecordService;
import com.landray.kmss.geesun.org.util.GeesunOrgUtil;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOrgRecordServiceImp extends BaseServiceImp implements IGeesunOrgRecordService {

	private static final Log logger = LogFactory.getLog(GeesunOrgRecordServiceImp.class);
	
	protected static Boolean isRunning = false;
	
    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunOrgRecord) {
            GeesunOrgRecord geesunOrgRecord = (GeesunOrgRecord) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunOrgRecord geesunOrgRecord = new GeesunOrgRecord();
        geesunOrgRecord.setDocCreateTime(new Date());
        GeesunOrgUtil.initModelFromRequest(geesunOrgRecord, requestContext);
        return geesunOrgRecord;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunOrgRecord geesunOrgRecord = (GeesunOrgRecord) model;
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
    
    public void addRecordMiddle(DataSource dataSource, JSONArray organArray, 
			JSONArray personArray, JSONArray postArray) throws Exception {
		//调用Dao层写入将HR数据记录表
		((IGeesunOrgRecordDao) getBaseDao()).addRecordMiddle(dataSource, organArray, personArray, postArray);
	}
    
    /**
	 * 定时清除一周前HR记录表日志
	 * @param context
	 * @throws Exception
	 */
	public void deleteWeekBeforeLogQuartz(SysQuartzJobContext context) throws Exception {
		context.logMessage("开始执行定时清除一周前HR记录表日志定时任务！");
		if(!isRunning){ // 开始执行定时任务
			isRunning = true; // 锁定任务
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_MONTH, -7);
			String deleteWeekBeforeLog_sql = "delete from geesun_org_record where doc_create_time < ?";
			PreparedStatement deleteWeekBeforeLog = null;
			Connection conn = null;
			try {
				DataSource dataSource = (DataSource) SpringBeanUtil
						.getBean("dataSource");
				conn = dataSource.getConnection();
				deleteWeekBeforeLog = conn.prepareStatement(deleteWeekBeforeLog_sql);
				deleteWeekBeforeLog.setTimestamp(1, new java.sql.Timestamp(c.getTimeInMillis()));
				deleteWeekBeforeLog.executeUpdate();
			} catch (Exception ex) {
				context.logError("定时清除一周前HR记录表日志定时任务执行异常", ex);
				logger.error("定时清除一周前HR记录表日志定时任务执行异常"+ex);
			} finally {
				isRunning = false; // 解锁任务
				// 关闭流
				JdbcUtils.closeStatement(deleteWeekBeforeLog);
				JdbcUtils.closeConnection(conn);
			}
		}
		context.logMessage("定时清除一周前HR记录表日志定时任务执行结束！");
	}
    
}
