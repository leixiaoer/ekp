package com.landray.kmss.geesun.annual.service.spring;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.hibernate.cfg.Environment;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.model.GeesunAnnualUse;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualMainService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualUseService;
import com.landray.kmss.geesun.annual.util.CalculateUtil;
import com.landray.kmss.geesun.annual.util.GeesunAnnualConstant;
import com.landray.kmss.geesun.annual.util.GeesunAnnualUtil;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.sys.admin.dbchecker.metadata.util.MetadataUtil;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.time.interfaces.ISysTimeCountService;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

public class GeesunAnnualUseServiceImp extends ExtendDataServiceImp implements IGeesunAnnualUseService, IXMLDataBean {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;
    
    /**
     * 工时计算bean
     */
    protected ISysTimeCountService sysTimeCountService;
    
    public ISysTimeCountService getSysTimeCountService() {
    	if (null == sysTimeCountService) {
			sysTimeCountService = (ISysTimeCountService) SpringBeanUtil.getBean("sysTimeCountService");;
    	}
    	return sysTimeCountService;
    }
    
    protected IKmReviewMainService kmReviewMainService;
	
	public IKmReviewMainService getKmReviewMainService() {
		if (kmReviewMainService == null) {
			kmReviewMainService = (IKmReviewMainService) SpringBeanUtil
					.getBean("kmReviewMainService");
		}
		return kmReviewMainService;
	}

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunAnnualUse) {
            GeesunAnnualUse geesunAnnualUse = (GeesunAnnualUse) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunAnnualUse geesunAnnualUse = new GeesunAnnualUse();
        geesunAnnualUse.setDocCreateTime(new Date());
        geesunAnnualUse.setDocCreator(UserUtil.getUser());
        GeesunAnnualUtil.initModelFromRequest(geesunAnnualUse, requestContext);
        return geesunAnnualUse;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunAnnualUse geesunAnnualUse = (GeesunAnnualUse) model;
    }

    public List<GeesunAnnualUse> findByFdAnnual(GeesunAnnualMain fdAnnual) throws Exception {
        HQLInfo hqlInfo = new HQLInfo();
        hqlInfo.setWhereBlock("geesunAnnualUse.fdAnnual.fdId=:fdId and geesunAnnualUse.fdType=:fdType");
        hqlInfo.setParameter("fdId", fdAnnual.getFdId());
        hqlInfo.setParameter("fdType", GeesunAnnualConstant.GEESUN_ANNUAL_USE_TYPE_LEAVE);
        return this.findList(hqlInfo);
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
    
    private static Log logger = LogFactory.getLog(GeesunAnnualUseServiceImp.class);
	
	protected IGeesunAnnualMainService geesunAnnualMainService;
	
	public IGeesunAnnualMainService getGeesunAnnualMainService() {
		if (null == geesunAnnualMainService) {
			geesunAnnualMainService = (IGeesunAnnualMainService) SpringBeanUtil
					.getBean("geesunAnnualMainService");
		}
		return geesunAnnualMainService;
	}
	
	/**
	 * 根据类型获取数量
	 * @param requestContext
	 * @return
	 * @throws Exception
	 */
	public int getNumByAnnual(HttpServletRequest requestContext) throws Exception {
		String fdType = requestContext.getParameter("fdType");
		String fdModelId = requestContext.getParameter("fdModelId");
		if (StringUtil.isNull(fdType) || StringUtil.isNull(fdModelId)) {
			return 0;
		}
		String hql = "select count(k.fdId) from GeesunAnnualUse u, KmReviewMain k where u.fdAnnual.fdId=:fdModelId and u.fdModelId = k.fdId and k.docStatus=:docStatus and u.fdType=:fdType ";
		Query query = getBaseDao()
				.getHibernateSession().createQuery(hql);
		query.setParameter("docStatus", "using".equals(fdType)?SysDocConstant.DOC_STATUS_EXAMINE:SysDocConstant.DOC_STATUS_PUBLISH);
		query.setParameter("fdModelId", fdModelId);
		query.setParameter("fdType", GeesunAnnualConstant.GEESUN_ANNUAL_USE_TYPE_LEAVE);
		Long result = (Long) query.uniqueResult();
		return result.intValue();
		 
	} 

	/**
	 * 获取指定人员的所有冻结或者已用的年假数目
	 * @param fdReviewId
	 * @param fdType
	 * @param isLast
	 * @param isLast
	 * @param geesunAnnualMain
	 * @return
	 * @throws Exception 
	 */
	public Double getYearLeaveDayAuditingByPerson(String fdReviewId, 
			String fdType, boolean isLast, GeesunAnnualMain geesunAnnualMain) throws Exception {
		//获取员工假期记录
//		GeesunAnnualMain geesunAnnualMain = getGeesunAnnualMainService()
//				.getAnnualByApplyer(fdPersonId);
		if (geesunAnnualMain == null)
			return 0.0;
		Boolean isSqlServer = MetadataUtil
				.isSQLServer(ResourceUtil.getKmssConfigString(Environment.DIALECT));
		Boolean isMysql = MetadataUtil
				.isMySQL(ResourceUtil.getKmssConfigString(Environment.DIALECT));
		String fdPersonId =  geesunAnnualMain.getFdOwner().getFdId();
		Date lastResetDate = geesunAnnualMain.getFdLastResetDate();
		Date nextResetDate = geesunAnnualMain.getFdNextResetDate();
		StringBuffer hql = new StringBuffer();
		String functionName = isSqlServer?"isnull":isMysql?"ifnull":"nvl";
		hql.append("select sum(" + functionName + "(geesunAnnualUse.fd_use, 0.0)) ");
		hql.append("from geesun_annual_use geesunAnnualUse left join km_review_main kmReviewMain");
		hql.append(" on geesunAnnualUse.fd_model_id = kmReviewMain.fd_id where ");
		if (isLast) {
			hql.append(" geesunAnnualUse.doc_create_time < ? ");
		} else {
			hql.append(" geesunAnnualUse.doc_create_time <= ? and geesunAnnualUse.doc_create_time >= ? ");
		}
		hql.append(" and geesunAnnualUse.doc_creator_id = ? and kmReviewMain.doc_status = ? ");
		if (StringUtil.isNotNull(fdReviewId)) {
			hql.append(" and geesunAnnualUse.fd_model_id <> ?");
		}
		if (StringUtil.isNotNull(hql.toString())) {
			List<Object> list = new ArrayList<Object>();
			if (StringUtil.isNotNull(fdReviewId)) {
				if (isLast) {
					list = this.getBaseDao()
							.getHibernateSession().createSQLQuery(hql.toString()).setTimestamp(0, new java.sql.Time(lastResetDate.getTime())).setString(1, fdPersonId)
							.setString(2, "frozen".equals(fdType)?SysDocConstant.DOC_STATUS_EXAMINE:SysDocConstant.DOC_STATUS_PUBLISH)
							.setString(3, fdReviewId).list();
				} else {
					list = this.getBaseDao()
							.getHibernateSession().createSQLQuery(hql.toString()).setTimestamp(0, new java.sql.Time(nextResetDate.getTime()))
							.setTimestamp(1, new java.sql.Time(lastResetDate.getTime()))
							.setString(2, fdPersonId).setString(3, "frozen".equals(fdType)?SysDocConstant.DOC_STATUS_EXAMINE:SysDocConstant.DOC_STATUS_PUBLISH)
							.setString(4, fdReviewId).list();
				}
			} else {
				if (isLast) {
					list = this.getBaseDao()
							.getHibernateSession().createSQLQuery(hql.toString()).setTimestamp(0, new java.sql.Time(lastResetDate.getTime())).setString(1, fdPersonId)
							.setString(2, "frozen".equals(fdType)?SysDocConstant.DOC_STATUS_EXAMINE:SysDocConstant.DOC_STATUS_PUBLISH).list();
				} else {
					list = this.getBaseDao()
							.getHibernateSession().createSQLQuery(hql.toString()).setTimestamp(0, new java.sql.Time(nextResetDate.getTime()))
							.setTimestamp(1, new java.sql.Time(lastResetDate.getTime()))
							.setString(2, fdPersonId).setString(3, "frozen".equals(fdType)?SysDocConstant.DOC_STATUS_EXAMINE:SysDocConstant.DOC_STATUS_PUBLISH)
							.list();
				}
			}
			if (!list.isEmpty() && null != list.get(0))
				return (Double) list.get(0);
		}
		return 0.0;
	}
	
	/**
	 * 根据状态获取使用中的年假信息
	 * @param fdReviewId
	 * @param isLast
	 * @param geesunAnnualMain
	 * @return
	 * @throws Exception 
	 */
	public Double getLeaveDayAuditingByPerson(String fdReviewId, 
			boolean isLast, GeesunAnnualMain geesunAnnualMain) throws Exception {
		//获取员工假期记录
//		GeesunAnnualMain geesunAnnualMain = getGeesunAnnualMainService()
//				.getAnnualByApplyer(fdPersonId);
		if (geesunAnnualMain == null)
			return 0.0;
		Boolean isSqlServer = MetadataUtil
				.isSQLServer(ResourceUtil.getKmssConfigString(Environment.DIALECT));
		Boolean isMysql = MetadataUtil
				.isMySQL(ResourceUtil.getKmssConfigString(Environment.DIALECT));
		String fdPersonId =  geesunAnnualMain.getFdOwner().getFdId();
		Date lastResetDate = geesunAnnualMain.getFdLastResetDate();
		Date nextResetDate = geesunAnnualMain.getFdNextResetDate();
		StringBuffer hql = new StringBuffer();
		String functionName = isSqlServer?"isnull":isMysql?"ifnull":"nvl";
		hql.append("select sum(" + functionName + "(geesunAnnualUse.fd_use, 0.0)) ");
		hql.append("from geesun_annual_use geesunAnnualUse left join km_review_main kmReviewMain");
		hql.append(" on geesunAnnualUse.fd_model_id = kmReviewMain.fd_id where ");
		if (isLast) {
			hql.append(" geesunAnnualUse.doc_create_time < ? ");
		} else {
			hql.append(" geesunAnnualUse.doc_create_time <= ? and geesunAnnualUse.doc_create_time >= ? ");
		}
		hql.append(" and geesunAnnualUse.doc_creator_id = ? and kmReviewMain.doc_status in ('20', '30')");
		if (StringUtil.isNotNull(fdReviewId)) {
			hql.append(" and geesunAnnualUse.fd_model_id <> ?");
		}
		if (StringUtil.isNotNull(hql.toString())) {
			List<Object> list = new ArrayList<Object>();
			if (StringUtil.isNotNull(fdReviewId)) {
				if (isLast) {
					list = this.getBaseDao()
							.getHibernateSession().createSQLQuery(hql.toString()).setTimestamp(0, new java.sql.Time(nextResetDate.getTime())).setString(1, fdPersonId)
							.setString(2, fdReviewId).list();
				} else {
					list = this.getBaseDao()
							.getHibernateSession().createSQLQuery(hql.toString()).setTimestamp(0, new java.sql.Time(nextResetDate.getTime()))
							.setTimestamp(1, new java.sql.Time(lastResetDate.getTime())).setString(2, fdPersonId).setString(3, fdReviewId).list();
				}
			} else {
				if (isLast) {
					list = this.getBaseDao()
							.getHibernateSession().createSQLQuery(hql.toString()).setTimestamp(0, new java.sql.Time(nextResetDate.getTime()))
							.setString(1, fdPersonId).list();
				} else {
					list = this.getBaseDao()
							.getHibernateSession().createSQLQuery(hql.toString()).setTimestamp(0, new java.sql.Time(nextResetDate.getTime()))
							.setTimestamp(1, new java.sql.Time(lastResetDate.getTime()))
							.setString(2, fdPersonId).list();
				}
			}
			if (!list.isEmpty() && null != list.get(0))
				return (Double) list.get(0);
		}
		return 0.0;
	}
	
	@Override
	public List getDataList(RequestContext requestInfo) throws Exception {
		String flag = requestInfo.getParameter("flag");
		String fdBeginDate = requestInfo.getParameter("fdBeginDate");
		String fdEndDate = requestInfo.getParameter("fdEndDate");
		String fdBeginTime = requestInfo.getParameter("fdBeginTime");
		String fdEndTime = requestInfo.getParameter("fdEndTime");
		String fdLeaverId = requestInfo.getParameter("fdPersonId");
		String fdReviewId = requestInfo.getParameter("fdReviewId");
		String docCreateTime = requestInfo.getParameter("docCreateTime");
		if (StringUtil.isNull(fdBeginTime)) {
			fdBeginTime = " 00:00";
		}
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = " 23:59";
		}
		List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();
		//获取员工假期记录
		GeesunAnnualMain geesunAnnualMain = getGeesunAnnualMainService()
				.getAnnualByApplyer(fdLeaverId);
		if ("checkLeaveOver".equals(flag)) {
			//校验申请的年假或者调休假是否超标
			map.put("overType", "0");
			map.put("isYearOver", "NO");
			if (null != geesunAnnualMain) {
				boolean isLast = false;
				Date lastResetDate = geesunAnnualMain.getFdLastResetDate();
				Double njDays = geesunAnnualMain.getFdTotal();
				if (DateUtil.convertStringToDate(docCreateTime, DateUtil.PATTERN_DATE).before(lastResetDate)) {
					njDays = geesunAnnualMain.getFdLastTotal();
					isLast = true;
				}
				Double usedYear = getLeaveDayAuditingByPerson(fdReviewId, isLast, geesunAnnualMain);
				Double fdLeaveYearDay =  getAvailableDays(fdLeaverId, DateUtil.convertStringToDate(fdBeginDate, DateUtil.PATTERN_DATE), 
						DateUtil.convertStringToDate(fdEndDate, DateUtil.PATTERN_DATE));
				if (CalculateUtil.sub(CalculateUtil.sub(njDays, usedYear), fdLeaveYearDay) < 0) {
					map.put("overType", "1");
					map.put("isYearOver", "YES");
				}
			} else {
				map.put("overType", "2");
				map.put("isYearOver", "YES");
			}
			result.add(map);
			return result;
		} else if ("checkResumeType".equals(flag)) {
			//校验申请的销假是否在请假时间范围内
			KmReviewMain kmReviewMain = (KmReviewMain) getKmReviewMainService().findByPrimaryKey(fdReviewId, KmReviewMain.class, true);
			map.put("isTimeHf", "YES");
			if (null != kmReviewMain) {
				Map<String, Object> data = kmReviewMain.getExtendDataModelInfo()
						.getModelData();// 自定义表单内容
				Date begin = null;
				Date end = null;
				String fdLeaveType = (null!= data.get("fd_395a0c2b56a790"))?data.get("fd_395a0c2b56a790").toString():"0";
				Date beginDate = (null!= data.get("fd_39443cd6b60ebe"))?(Date)data.get("fd_39443cd6b60ebe"):null;
				Date endDate = (null!= data.get("fd_39443cdd503ed6"))?(Date)data.get("fd_39443cdd503ed6"):null;
				Date beginTime = (null!= data.get("fd_3968fd2698034e"))?(Date)data.get("fd_3968fd2698034e"):null;
				Date endTime = (null!= data.get("fd_3968fd27cef0fc"))?(Date)data.get("fd_3968fd27cef0fc"):null;
				int fdLeaveTypeVaue = Double.valueOf(fdLeaveType).intValue();
				if (fdLeaveTypeVaue > 11) {
					begin = beginTime;
					end = endTime;
				} else {
					begin = new Date(DateUtil.getDateTimeNumber(beginDate, DateUtil.convertStringToDate("00:00", "HH:mm")));
					end = new Date(DateUtil.getDateTimeNumber(endDate, DateUtil.convertStringToDate("23:59", "HH:mm")));
				}
				if (begin.getTime() <= DateUtil.convertStringToDate(fdBeginTime, DateUtil.PATTERN_DATETIME).getTime()
						&& end.getTime() >= DateUtil.convertStringToDate(fdEndTime, DateUtil.PATTERN_DATETIME).getTime()) {
					map.put("isTimeHf", "NO");
				}
			}
			result.add(map);
			return result;
		} else if ("getAnnualRemain".equals(flag)) {
			//根据人员获取剩余年假
			map.put("annualLeaveNum", "0");
			if (null != geesunAnnualMain) {
				boolean isLast = false;
				Date lastResetDate = geesunAnnualMain.getFdLastResetDate();
				Double njDays = geesunAnnualMain.getFdTotal();
				if (DateUtil.convertStringToDate(docCreateTime, DateUtil.PATTERN_DATE).before(lastResetDate)) {
					njDays = geesunAnnualMain.getFdLastTotal();
					isLast = true;
				}
				Double usedYear = getLeaveDayAuditingByPerson(fdReviewId, isLast, geesunAnnualMain);
				map.put("annualLeaveNum", String.valueOf(CalculateUtil.sub(njDays, usedYear)));
			}
			result.add(map);
			return result;
		}
		return null;
	}
	
	/**
	 * 根据排班计算对应人员开始时间和结束时间范围内容有效天数
	 * @param personId
	 * @param begin
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public double getAvailableDays(String personId, 
			Date begin, Date end) throws Exception {
		double days = 0.0;
		Calendar cal = Calendar.getInstance();
		cal.setTime(end);
		while (cal.getTime().after(begin) || cal.getTimeInMillis() == begin.getTime()) {
			String fdCurrentDate = DateUtil.convertDateToString(cal.getTime(), 
					DateUtil.PATTERN_DATE);
			long workTime = getSysTimeCountService().getManHour(personId, 
					DateUtil.convertStringToDate(fdCurrentDate + " 00:00:00", "yyyy-MM-dd HH:mm:ss").getTime(), 
					DateUtil.convertStringToDate(fdCurrentDate + " 23:59:00", "yyyy-MM-dd HH:mm:ss").getTime());
			if (workTime > 0) {
    			days += 1;
			}
			cal.add(Calendar.DAY_OF_MONTH, -1);
		}
		return days;
	}
	
}
