package com.landray.kmss.geesun.base.service.spring;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.fssc.base.model.FsscBaseCompany;
import com.landray.kmss.fssc.base.model.FsscBaseCostCenter;
import com.landray.kmss.fssc.base.service.IFsscBaseCompanyService;
import com.landray.kmss.fssc.base.service.IFsscBaseCostCenterService;
import com.landray.kmss.fssc.base.service.IFsscBaseExchangeRateService;
import com.landray.kmss.fssc.base.util.FsscBaseUtil;
import com.landray.kmss.fssc.common.interfaces.IFsscCommonBudgetOperatService;
import com.landray.kmss.fssc.common.util.FsscCommonUtil;
import com.landray.kmss.fssc.common.util.FsscNumberUtil;
import com.landray.kmss.geesun.annual.util.GeesunAnnualConstant;
import com.landray.kmss.geesun.base.service.IGeesunBaseAccountService;
import com.landray.kmss.geesun.base.service.IGeesunBaseListenerFormService;
import com.landray.kmss.geesun.base.service.IGeesunFindOrgInfoService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataEvent;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataModel;
import com.landray.kmss.sys.metadata.interfaces.ISysMetadataParser;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 监听费用表单的增删改查事件初始化公司等信息及扣减预算
 * @author guoyp
 */
public class GeesunBaseListenerFormServiceImp implements IExtendDataEvent, 
	IGeesunBaseListenerFormService, GeesunAnnualConstant {
	
	private static final Log logger = LogFactory
			.getLog(GeesunBaseListenerFormServiceImp.class);
	
	private IFsscCommonBudgetOperatService fsscBudgetOperatService;
	
	public IFsscCommonBudgetOperatService getFsscBudgetOperatService() {
		if(fsscBudgetOperatService==null){
			fsscBudgetOperatService = (IFsscCommonBudgetOperatService) SpringBeanUtil.getBean("fsscBudgetOperatService");
		}
		return fsscBudgetOperatService;
	}
	
	private IFsscBaseExchangeRateService fsscBaseExchangeRateService;
	

	public IFsscBaseExchangeRateService getFsscBaseExchangeRateService() {
		if(fsscBaseExchangeRateService==null){
			fsscBaseExchangeRateService = (IFsscBaseExchangeRateService) SpringBeanUtil.getBean("fsscBaseExchangeRateService");
		}
		return fsscBaseExchangeRateService;
	}
	
	private IFsscBaseCompanyService fsscBaseCompanyService;

	public IFsscBaseCompanyService getFsscBaseCompanyService() {
		if(fsscBaseCompanyService==null){
			fsscBaseCompanyService = (IFsscBaseCompanyService) SpringBeanUtil.getBean("fsscBaseCompanyService");
		}
		return fsscBaseCompanyService;
	}
	
	private IFsscBaseCostCenterService fsscBaseCostCenterService;
	
	public IFsscBaseCostCenterService getFsscBaseCostCenterService() {
		if(fsscBaseCostCenterService==null){
			fsscBaseCostCenterService = (IFsscBaseCostCenterService) SpringBeanUtil.getBean("fsscBaseCostCenterService");
		}
		return fsscBaseCostCenterService;
	}
	
	protected IGeesunFindOrgInfoService geesunFindOrgInfoService;
	
	public IGeesunFindOrgInfoService getGeesunFindOrgInfoService() {
		if (null == geesunFindOrgInfoService) {
			geesunFindOrgInfoService = (IGeesunFindOrgInfoService) SpringBeanUtil
					.getBean("geesunFindOrgInfoService");
		}
		return geesunFindOrgInfoService;
	}
	
	protected IKmReviewMainService kmReviewMainService;
	
	public IKmReviewMainService getKmReviewMainService() {
		if (null == kmReviewMainService) {
			kmReviewMainService = (IKmReviewMainService) SpringBeanUtil
					.getBean("kmReviewMainService");
		}
		return kmReviewMainService;
	}
	
	protected IGeesunBaseAccountService geesunBaseAccountService;
	
	public IGeesunBaseAccountService getGeesunBaseAccountService() {
		if (null == geesunBaseAccountService) {
			geesunBaseAccountService = (IGeesunBaseAccountService) SpringBeanUtil
					.getBean("geesunBaseAccountService");
		}
		return geesunBaseAccountService;
	}
	
	@Override
	public void onAdd(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		updateBudgetInfo(kmReviewMain);
//		addOrUpdateOrDeleteAccount(kmReviewMain, dataParser, "");
	}

	@Override
	public void onDelete(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		DataSource dataSource = (DataSource) SpringBeanUtil
				.getBean("dataSource");
		deletePayInfo(dataSource, kmReviewMain.getFdId());
		deleteBudgetInfo(kmReviewMain);
//		addOrUpdateOrDeleteAccount(kmReviewMain, dataParser, "DELETE");
	}

	@Override
	public void onInit(RequestContext request, IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		SysOrgPerson person = UserUtil.getUser();
		//设置默认公司
        List<FsscBaseCompany> own = getFsscBaseCompanyService().findCompanyByUserId(person.getFdId());;
        if(!ArrayUtil.isEmpty(own)){
        	dataParser.setFieldValue(model, "fd_company_id", own.get(0).getFdId());//记账公司
        	//设置默认币种汇率
    		Double rate = getFsscBaseExchangeRateService().getRateByAccountCurrency(own.get(0), own.get(0).getFdAccountCurrency().getFdId());
    		dataParser.setFieldValue(model, "fd_currency_id", own.get(0).getFdAccountCurrency().getFdId());//币种ID
    		dataParser.setFieldValue(model, "fd_exchange_rate", rate);//汇率
        	String  fdDeduRule=FsscBaseUtil.getDetailPropertyValue(own.get(0).getFdId(),"fdDeduRule");
        	if(StringUtil.isNull(fdDeduRule)){
        		fdDeduRule="1";  //为空则默认为含税金额，保留原有逻辑
        	}
        	dataParser.setFieldValue(model, "fd_dedu_flag", fdDeduRule);//是否含税
        	//默认成本中心
        	FsscBaseCostCenter costsOwn=getFsscBaseCostCenterService().findCostCenterByUserId(own.get(0).getFdId(), person.getFdId());
        	if(costsOwn!=null){
        		dataParser.setFieldValue(model, "fd_cost_center_id", costsOwn.getFdId());//成本中心
//        		if ("1".equals(costsOwn.getFdIsGroup())) {//成本中心则找上级--利润中心
//        			FsscBaseCostCenter costsOwnParent = (FsscBaseCostCenter) costsOwn.getFdParent();
//        			dataParser.setFieldValue(model, "fd_cost_center_id", costsOwnParent.getFdId());//成本中心
//				}
        	}
        }
        //获取对应账号信息
//        GeesunBaseAccount account = getGeesunBaseAccountService().getAccountByUser(person);
//        if (null != account) {
//        	dataParser.setFieldValue(model, "fd_receiver", account.getFdAccount());//收款人
//        	dataParser.setFieldValue(model, "fd_bank_name", account.getFdBankName());//收款银行
//        }
	}
	
	@Override
	public void onUpdate(IExtendDataModel model, ISysMetadataParser dataParser) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		updateBudgetInfo(kmReviewMain);
//		addOrUpdateOrDeleteAccount(kmReviewMain, dataParser, "");
	}
	
	private void deleteBudgetInfo(KmReviewMain main) throws Exception {
		logger.error("单据ID为：" + main.getFdId() + "，单据状态为" + main.getDocStatus() + "的单据进入删除方法！");
		JSONObject object = new JSONObject();
		object.put("fdModelName", KmReviewMain.class.getName());
		object.put("fdModelId", main.getFdId());
		getFsscBudgetOperatService().deleteFsscBudgetExecute(object);
	}
	
	public void updateBudgetInfo(KmReviewMain main) throws Exception{
		if(!SysDocConstant.DOC_STATUS_DRAFT.equals(main.getDocStatus()) && !SysDocConstant.DOC_STATUS_PUBLISH.equals(main.getDocStatus())
				&& !SysDocConstant.DOC_STATUS_DISCARD.equals(main.getDocStatus())){
			logger.error("单据ID为：" + main.getFdId() + "，单据状态为" + main.getDocStatus() + "的单据进入更新占用方法！");
			Map<String,Double> budgetMap = new HashMap<String,Double>();
			if(FsscCommonUtil.checkHasModule("/fssc/budget/")){
				Map<String, Object> map = main.getExtendDataModelInfo().getModelData();
				//获取明细数据
				List<Map<String, Object>> detailList = (List<Map<String, Object>>) map.get("fd_3957f578d654fe");//报销明细
				for(Map<String, Object> detail : detailList){
					if(budgetMap.containsKey(detail.get("fdId"))){
						Double money = budgetMap.get(detail.get("fdId"));
						if(FsscNumberUtil.isEqual(money, 0d)){
							continue;
						}
					}
					if(StringUtil.isNull(detail.get("fd_budget_info").toString())){
						continue;
					}
					JSONArray data = JSONArray.fromObject(detail.get("fd_budget_info").toString().replaceAll("'", "\""));
					JSONArray params = new JSONArray();
					for(int i=0;i<data.size();i++){
						JSONObject obj = data.getJSONObject(i);
						JSONObject row = new JSONObject();
						row.put("fdModelId", main.getFdId());
						row.put("fdModelName", KmReviewMain.class.getName());
						if(budgetMap.containsKey(detail.get("fdId"))){
							row.put("fdMoney", budgetMap.get(detail.get("fdId")));
						}else{
							Double fdMoney = 0.0;
							Object money = detail.get("fd_money");
							if (money != null && money instanceof Double) {
								fdMoney = (Double) money;
							} else if (money != null && money instanceof BigDecimal) {
								fdMoney = ((BigDecimal) money).doubleValue();
							}
							row.put("fdMoney", fdMoney);
						}
						row.put("fdBudgetId", obj.get("fdBudgetId"));
						row.put("fdDetailId", detail.get("fdId"));
						row.put("fdCompanyId", map.get("fd_company_id"));
						row.put("fdCostCenterId", detail.get("fd_cost_center_id"));
						row.put("fdExpenseItemId", detail.get("fd_expense_itemId")); //由于结转情况下，需要重新匹配新的预算，所以需要传费用类型ID
						row.put("fdBudgetItemId", obj.get("fdBudgetItemId"));
						
						row.put("fdType", "2");
						row.put("fdProjectId", "");
						row.put("fdInnerOrderId", "");
						row.put("fdWbsId", "");
						Map clainterMap = (Map)map.get("fd_3956e4d9e91fa8");//实际报销人
						if (null != clainterMap && !clainterMap.isEmpty()) {
							SysOrgPerson clainter = getGeesunFindOrgInfoService().findOrg(clainterMap);
							if (null != clainter) {
								row.put("fdPersonId", clainter.getFdId());
								row.put("fdDeptId", (null!=clainter.getFdParent()?clainter.getFdParent().getFdId():""));
							}
						} else {
							row.put("fdPersonId", "");
							row.put("fdDeptId", "");
						}
						row.put("fdCurrency", map.get("fd_currency_id"));
						params.add(row);
					}
					if(params.size()>0){
						getFsscBudgetOperatService().updateFsscBudgetExecute(params);
					}
				}
			}
		}
	}
	
	/**
	 * 插入、更新或者删除账号表记录
	 * @param kmReviewMain
	 * @param dataParser
	 * @throws fdType
	 */
	private void addOrUpdateOrDeleteAccount(KmReviewMain kmReviewMain, 
			ISysMetadataParser dataParser, String fdType) throws Exception {
		if (!SysDocConstant.DOC_STATUS_DRAFT.equals(kmReviewMain.getDocStatus())) {
//			SysOrgPerson fdApplyer = (SysOrgPerson) dataParser.getFieldValue(kmReviewMain,
//						"fd_3956e4bc3a2ac0", true);//申请人
			DataSource dataSource = (DataSource) SpringBeanUtil
					.getBean("dataSource");
			Connection connect = null;
			PreparedStatement insertSql = null;
			PreparedStatement updateSql = null;
			PreparedStatement deleteSql = null;
			PreparedStatement selectSql = null;
			ResultSet resultSet = null;
			try {
				SysOrgPerson fdOwner = kmReviewMain.getDocCreator();
				String fdAccountName = "";
				try {
					fdAccountName = (String) dataParser.getFieldValue(kmReviewMain,
							"fd_receiver", true);
				} catch (Exception e) {
					fdAccountName = "";
				}
				String fdBankName = "";
				try {
					fdBankName = (String) dataParser.getFieldValue(kmReviewMain,
							"fd_bank_name", true);
				} catch (Exception e) {
					fdBankName = "";
				}
				connect = dataSource.getConnection();
				connect.setAutoCommit(false);
				insertSql = connect
						.prepareStatement("insert into geesun_base_account(fd_id, doc_create_time, fd_bank_name, "
							+ "fd_account, doc_creator_id, fd_owner_id, fd_review_id) values(?,?,?,?,?,?,?)");
				updateSql = connect
						.prepareStatement("update geesun_base_account set fd_bank_name = ?, fd_account = ?, "
								+ " doc_create_time=?  where fd_id = ?");
				deleteSql = connect
						.prepareStatement("delete from geesun_base_account where fd_review_id = ?");
				if ("DELETE".equals(fdType)) {
					deleteSql.setString(1, kmReviewMain.getFdId());
					deleteSql.executeUpdate();
				} else {
					selectSql = connect
							.prepareStatement("select fd_id from geesun_base_account"
									+ " where fd_bank_name = ? and fd_owner_id = ?");
					selectSql.setString(1, fdBankName);
					selectSql.setString(2, kmReviewMain.getFdId());
					resultSet = selectSql.executeQuery();
					if (resultSet.next()) {
						updateSql.setString(1, fdBankName);
						updateSql.setString(2, fdAccountName);
						updateSql.setTimestamp(3, new Timestamp(new Date().getTime())); 
						updateSql.setString(4, resultSet.getString(1));
						updateSql.executeUpdate();
					} else {
						insertSql.setString(1, IDGenerator.generateID());
						insertSql.setTimestamp(2, new Timestamp(new Date().getTime()));
						insertSql.setString(3, fdBankName);
						insertSql.setString(4, fdAccountName);
						insertSql.setString(5, fdOwner.getFdId());
						insertSql.setString(6, fdOwner.getFdId());
						insertSql.setString(7, kmReviewMain.getFdId());
						insertSql.executeUpdate();
					}
				}
				connect.commit();
			} catch (SQLException ex) {
				logger.error("监听表单对账号新增改查时出现异常", ex);
				connect.rollback();
				throw ex;
			} finally {
				JdbcUtils.closeResultSet(resultSet);
				JdbcUtils.closeStatement(selectSql);;
				JdbcUtils.closeStatement(insertSql);
				JdbcUtils.closeStatement(updateSql);
				JdbcUtils.closeStatement(deleteSql);
				JdbcUtils.closeConnection(connect);
			}
		}
	}
	
	private void deletePayInfo(DataSource dataSource, String fdReviewId) throws Exception {
		String delete_sql = "delete from geesun_base_pay where fd_review_id = ?";
		PreparedStatement psDeleteMiddle = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			psDeleteMiddle = conn.prepareStatement(delete_sql);
			psDeleteMiddle.setString(1, fdReviewId);
			psDeleteMiddle.executeUpdate();
			
		} catch (Exception ex) {
			logger.error("清除付款表数据clean发生异常："+ex);
			throw ex;
		} finally {
			// 关闭流
			JdbcUtils.closeStatement(psDeleteMiddle);
			JdbcUtils.closeConnection(conn);
		}
	}
	
}