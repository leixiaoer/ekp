package com.landray.kmss.geesun.base.service.spring;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.geesun.base.model.GeesunBaseConfig;
import com.landray.kmss.geesun.base.model.GeesunBasePay;
import com.landray.kmss.geesun.base.service.IGeesunBasePayService;
import com.landray.kmss.geesun.base.util.BoxJdbcUtils;
import com.landray.kmss.geesun.base.util.GeesunBaseUtil;
import com.landray.kmss.geesun.base.util.example.BoxJdbcCUDExample;
import com.landray.kmss.geesun.base.util.example.BoxJdbcQueryExample;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.sso.client.oracle.StringUtil;

public class GeesunBasePayServiceImp extends ExtendDataServiceImp 
	implements IGeesunBasePayService, IXMLDataBean {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;
    
    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
    
    private IKmReviewMainService kmReviewMainService;
    
    public IKmReviewMainService getKmReviewMainService() {
        if (kmReviewMainService == null) {
        	kmReviewMainService = (IKmReviewMainService) SpringBeanUtil.getBean("kmReviewMainService");
        }
        return kmReviewMainService;
    }
    
    private LbpmAuditApproveServiceImp lbpmAuditApproveService;
    
    public LbpmAuditApproveServiceImp getLbpmAuditApproveService() {
        if (lbpmAuditApproveService == null) {
        	lbpmAuditApproveService = (LbpmAuditApproveServiceImp) SpringBeanUtil.getBean("lbpmAuditApproveService");
        }
        return lbpmAuditApproveService;
    }

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunBasePay) {
            GeesunBasePay geesunBasePay = (GeesunBasePay) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
    	String fdReviewId = requestContext.getParameter("fdReviewId");
        GeesunBasePay geesunBasePay = new GeesunBasePay();
        geesunBasePay.setDocCreateTime(new Date());
        geesunBasePay.setDocCreator(UserUtil.getUser());
        geesunBasePay.setFdPayDate(new Date());
    	KmReviewMain kmReviewMain = (KmReviewMain) getKmReviewMainService().findByPrimaryKey(fdReviewId, KmReviewMain.class, true);
    	if (null != kmReviewMain) {
    		geesunBasePay.setFdReview(kmReviewMain);
    		geesunBasePay.setFdYwDate(kmReviewMain.getDocCreateTime());
    		Map<String, Object> mainMap = kmReviewMain.getExtendDataModelInfo().getModelData();
    		//获取明细数据
    		String fdDemo = "付";
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
    		BigDecimal total = new BigDecimal(0);
			List<Map<String, Object>> detailList = (List<Map<String, Object>>) mainMap.get("fd_3957f578d654fe");//报销明细
    		if ("1787bde51d21bfc828cb12a4358a13da".equals(kmReviewMain.getFdTemplate().getFdId())) {
    			//费用报销
    			Map clainterMap = (Map)mainMap.get("fd_3956e4d9e91fa8");//实际报销人
    			if (null != clainterMap && !clainterMap.isEmpty()) {
    				fdDemo += clainterMap.get("name").toString();
    			}
    			fdDemo += "报销";
    			if (!ArrayUtil.isEmpty(detailList)) {
    				Map<String, Object> detail = detailList.get(0);
    				Map userDeptMap = (Map)detail.get("fd_39935eea60939e");//使用部门
        			if (null != userDeptMap && !userDeptMap.isEmpty()) {
        				fdDemo += userDeptMap.get("name").toString();
        			}
        			fdDemo += detail.get("fd_item_id_text").toString();
    			}
    			Object money = mainMap.get("fd_396f759aca2272");
    			if (money != null && money instanceof Double) {
    				Double fdMoney = (Double) money;
    				total = total.add(new BigDecimal(fdMoney));
    			} else if (money != null && money instanceof BigDecimal) {
    				BigDecimal fdMoney = (BigDecimal) money;
    				total = total.add(fdMoney);
    			}
    		} else if ("1787be42f2631c4cb4b66cf4e329a937".equals(kmReviewMain.getFdTemplate().getFdId())) {
    			//差旅报销
    			Map clainterMap = (Map)mainMap.get("fd_3956fe21a6e702");//报销人
    			if (null != clainterMap && !clainterMap.isEmpty()) {
    				fdDemo += clainterMap.get("name").toString();
    			}
    			if (!ArrayUtil.isEmpty(detailList)) {
    				Map<String, Object> detail = detailList.get(0);
    				Date startDate = detail.get("fd_3980c1d14a57dc")!=null?(Date)detail.get("fd_3980c1d14a57dc"):null;
    				Date endDate = detail.get("fd_395700c7e098c6")!=null?(Date)detail.get("fd_395700c7e098c6"):null;
    				if (startDate != null) {
    					fdDemo += sdf.format(startDate);
    				}
    				fdDemo += "-";
    				if (endDate != null) {
    					fdDemo += sdf.format(endDate);
    				}
    				fdDemo += "出差";
        			fdDemo += detail.get("fd_3999ccc29c54a6_text").toString();
        			fdDemo += detail.get("fd_item_id_text").toString();
    			}
    			Object money = mainMap.get("fd_3957027e2cf912");
    			if (money != null && money instanceof Double) {
    				Double fdMoney = (Double) money;
    				total = total.add(new BigDecimal(fdMoney));
    			} else if (money != null && money instanceof BigDecimal) {
    				BigDecimal fdMoney = (BigDecimal) money;
    				total = total.add(fdMoney);
    			}
    		} else if ("1796454cc441e9d1866f5b44fcb96980".equals(kmReviewMain.getFdTemplate().getFdId())) {
    			//付款
    			fdDemo += (null!=mainMap.get("fd_receiver")?mainMap.get("fd_receiver").toString():"");
    			if (!ArrayUtil.isEmpty(detailList)) {
    				Map<String, Object> detail = detailList.get(0);
    				fdDemo += detail.get("fd_item_id_text").toString();
    			}
    			fdDemo += ("(" + kmReviewMain.getDocCreator().getFdName() + ")");
    			Object money = mainMap.get("fd_3997700c84b8ee");
    			if (money != null && money instanceof Double) {
    				Double fdMoney = (Double) money;
    				total = total.add(new BigDecimal(fdMoney));
    			} else if (money != null && money instanceof BigDecimal) {
    				BigDecimal fdMoney = (BigDecimal) money;
    				total = total.add(fdMoney);
    			}
    		} else if ("17775dcba9e95c14e8dd7f54e279c9eb".equals(kmReviewMain.getFdTemplate().getFdId())) {
    			//借款
    			Map borrowerMap = (Map)mainMap.get("fd_394a6c4b877e44");//借款人
    			if (null != borrowerMap && !borrowerMap.isEmpty()) {
    				fdDemo += borrowerMap.get("name").toString();
    			} else {
    				fdDemo += kmReviewMain.getDocCreator().getFdName();
    			}
    			fdDemo += "借款：" + mainMap.get("fd_394a6cc5b24526").toString();
    			Object money = mainMap.get("fd_394a6c6f537822");
    			if (money != null && money instanceof Double) {
    				Double fdMoney = (Double) money;
    				total = total.add(new BigDecimal(fdMoney));
    			} else if (money != null && money instanceof BigDecimal) {
    				BigDecimal fdMoney = (BigDecimal) money;
    				total = total.add(fdMoney);
    			}
    		}
			geesunBasePay.setFdDemo(fdDemo);
			geesunBasePay.setFdPayMoney(total.doubleValue());
    	}
        GeesunBaseUtil.initModelFromRequest(geesunBasePay, requestContext);
        return geesunBasePay;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunBasePay geesunBasePay = (GeesunBasePay) model;
    }

    public List<GeesunBasePay> findByFdReview(KmReviewMain fdReview) throws Exception {
        HQLInfo hqlInfo = new HQLInfo();
        hqlInfo.setWhereBlock("geesunBasePay.fdReview.fdId=:fdId");
        hqlInfo.setParameter("fdId", fdReview.getFdId());
        return this.findList(hqlInfo);
    }

    /**
     * 保存时同时往HR数据库写入记录
     */
    @Override
	public String add(IBaseModel modelObj) throws Exception {
    	GeesunBasePay pay = (GeesunBasePay) modelObj;
    	if (StringUtil.isNotNull(pay.getFdPayBank3())) {
    		int orderId = addToHrTable(pay);
        	pay.setFdOrderId(orderId);
//        	getLbpmAuditApproveService().updateBatchApprove(pay.getFdReview().getFdId(), "出纳付款自动通过");
    	}
		return super.add(pay);
	}

	private int addToHrTable(GeesunBasePay pay) throws Exception {
		int orderId = 0;
    	GeesunBaseConfig config = new GeesunBaseConfig();
    	String selectOrderId = "select isnull((select max(FOrderID)  from cn_yhrjz),0) + 1 as FOrderID";
    	List<Object> list = new ArrayList<Object>();
    	BoxJdbcQueryExample selectOrder = BoxJdbcQueryExample.createInstance(config.getFdHrDbName(),
    			selectOrderId,
				list);
		List<Map<String, Object>> resultList = BoxJdbcUtils.executeQuery(selectOrder);
    	String sql = "insert into cn_yhrjz(FOrderID,fyear,fperiod,fdate,FOperationDate,FCredit,FCreditB,FExp,FRemark,"
    			+ "FLyr,fkmid,fnum,FDebit,FDebitB,FDzAlready,FDzNumber,fjz,fsource,fslb,fsdh,FRate) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		List<Object> paramList = new ArrayList<Object>();
		orderId = Integer.valueOf(resultList.get(0).get("FOrderID").toString());
		paramList.add(orderId);
		paramList.add(Integer.valueOf(pay.getFdPeriod().substring(1, 5)));
		paramList.add(Integer.valueOf(pay.getFdPeriod().substring(5, 7)) + 1);
		paramList.add(pay.getFdPayDate());
		paramList.add(pay.getFdPayDate());
		paramList.add(pay.getFdPayMoney());
		paramList.add(pay.getFdPayMoney());
		paramList.add(pay.getFdDemo());
		paramList.add(pay.getFdRemark());
		paramList.add(pay.getDocCreator().getFdName());
		paramList.add(pay.getFdPayBank1());
		paramList.add(0);
		paramList.add(0);
		paramList.add(0);
		paramList.add(0);
		paramList.add(-1);
		paramList.add(0);
		paramList.add(-1);
		paramList.add(3);
		paramList.add(pay.getFdReview().getFdNumber());
		paramList.add(1);
		BoxJdbcCUDExample insert = BoxJdbcCUDExample
				.createInstanceForParams(config.getFdHrDbName(), sql, paramList);
		BoxJdbcUtils.excuteCUD(insert);
		return orderId;
    }

    /**
     * 抓取数据
     */
	@Override
	public List getDataList(RequestContext request) throws Exception {
		String flag = request.getParameter("flag");
		String keyword = request.getParameter("keyword");
		GeesunBaseConfig config = new GeesunBaseConfig();
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		String sql = "select FID, FKmdm, fkmmc from cn_account where FIsCash = ? order by fid";
		if ("getTAccount".equals(flag)) {
			sql = "select FAccountID,FNumber,FName from t_Account where FDelete = ? order by FNumber";
		}
		List<Object> list = new ArrayList<Object>();
		list.add(0);
		BoxJdbcQueryExample example = BoxJdbcQueryExample.createInstance(config.getFdHrDbName(),
				sql,
				list);
		List<Map<String, Object>> resultList = BoxJdbcUtils.executeQuery(example);
		if (!ArrayUtil.isEmpty(resultList)) {
			for (Map<String, Object> temp : resultList) {
				Map<String, Object> map = new HashMap<String, Object>();
				if ("getTAccount".equals(flag)) {
					String fdName = (null!=temp.get("FName")?temp.get("FName").toString():"");
					if (StringUtil.isNotNull(keyword) && fdName.indexOf(keyword) == -1) {
						continue;
					}
					map.put("id", temp.get("FAccountID"));
					map.put("name", temp.get("FNumber") + "  " + fdName);
//					map.put("code", temp.get("FNumber"));
				} else {
					String fdName = (null!=temp.get("fkmmc")?temp.get("fkmmc").toString():"");
					if (StringUtil.isNotNull(keyword) && fdName.indexOf(keyword) == -1) {
						continue;
					}
					map.put("id", temp.get("FID"));
					map.put("name", temp.get("FKmdm") + "  " + temp.get("fkmmc"));
//					map.put("code", temp.get("FKmdm"));
				}
				result.add(map);
			}
		}
		return result;
	}
}
