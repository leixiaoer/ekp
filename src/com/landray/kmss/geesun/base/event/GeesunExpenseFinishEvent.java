package com.landray.kmss.geesun.base.event;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.landray.kmss.fssc.common.interfaces.IFsscCommonBudgetOperatService;
import com.landray.kmss.fssc.common.util.FsscCommonUtil;
import com.landray.kmss.fssc.common.util.FsscNumberUtil;
import com.landray.kmss.geesun.base.model.GeesunBaseConfig;
import com.landray.kmss.geesun.base.service.IGeesunFindOrgInfoService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

public class GeesunExpenseFinishEvent implements IEventListener{
	
	private IFsscCommonBudgetOperatService fsscBudgetOperatService;
	
	public IFsscCommonBudgetOperatService getFsscBudgetOperatService() {
		if(fsscBudgetOperatService==null){
			fsscBudgetOperatService = (IFsscCommonBudgetOperatService) SpringBeanUtil.getBean("fsscBudgetOperatService");
		}
		return fsscBudgetOperatService;
	}
	
	protected IGeesunFindOrgInfoService geesunFindOrgInfoService;
	
	public IGeesunFindOrgInfoService getGeesunFindOrgInfoService() {
		if (null == geesunFindOrgInfoService) {
			geesunFindOrgInfoService = (IGeesunFindOrgInfoService) SpringBeanUtil
					.getBean("geesunFindOrgInfoService");
		}
		return geesunFindOrgInfoService;
	}
	
	@Override
	public void handleEvent(EventExecutionContext execution, String parameter) throws Exception {
		KmReviewMain main = (KmReviewMain) execution.getMainModel();
		GeesunBaseConfig config = new GeesunBaseConfig();
		if (StringUtil.isNull(config.getFdTemplateIds()) || config.getFdTemplateIds().indexOf(main.getFdTemplate().getFdId()) == -1) {
			return;
		}
		//没有预算模块，不进行操作
		if(FsscCommonUtil.checkHasModule("/fssc/budget/")){
			if(getFsscBudgetOperatService()!=null){
				Map<String, Object> mainMap = main.getExtendDataModelInfo().getModelData();
				//获取明细数据
				List<Map<String, Object>> detailList = (List<Map<String, Object>>) mainMap.get("fd_3957f578d654fe");//报销明细
				Map<String,Double> map = getBudgetMap(detailList);
				for(Map<String, Object> detail : detailList){
					if(StringUtil.isNull(detail.get("fd_budget_info").toString())|| map.get(detail.get("fdId"))==null ||FsscNumberUtil.isEqual(map.get(detail.get("fdId")), 0d)){
						continue;
					}
					JSONArray data = JSONArray.fromObject(detail.get("fd_budget_info").toString().replaceAll("'", "\""));
					JSONArray params = new JSONArray();
					for(int i=0;i<data.size();i++){
						JSONObject obj = data.getJSONObject(i);
						JSONObject row = new JSONObject();
						row.put("fdModelId", main.getFdId());
						row.put("fdModelName", KmReviewMain.class.getName());
						row.put("fdMoney", map.get(detail.get("fdId")));
						row.put("fdBudgetId", obj.get("fdBudgetId"));
						row.put("fdDetailId", detail.get("fdId"));
						row.put("fdCompanyId", map.get("fd_company_id"));
						row.put("fdCostCenterId", detail.get("fd_center_id"));
						row.put("fdExpenseItemId", detail.get("fd_item_id")); //由于结转情况下，需要重新匹配新的预算，所以需要传费用类型ID
						row.put("fdBudgetItemId", obj.get("fdBudgetItemId"));
						row.put("fdType", "3");
						row.put("fdProjectId", "");
						row.put("fdInnerOrderId", "");
						row.put("fdWbsId", "");
						Map clainterMap = (Map)mainMap.get("fd_3956e4d9e91fa8");//实际报销人
						if (null != clainterMap && !clainterMap.isEmpty()) {
							SysOrgPerson clainter = getGeesunFindOrgInfoService().findOrg(clainterMap);
							if (null != clainter) {
								row.put("fdPersonId", clainter.getFdId());
								if (clainter.getFdParent() != null) {
									row.put("fdDeptId", clainter.getFdParent().getFdId());
								} else {
									row.put("fdDeptId", "");
								}
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
	 * 计算明细需要扣减预算的金额
	 * @param main
	 * @return
	 */
	private Map<String, Double> getBudgetMap(List<Map<String, Object>> detailList) {
		Map<String, Double> rtn = new HashMap<String, Double>();
		for(Map<String, Object> detail : detailList){
			Double fdMoney = 0.0;
			Object money = detail.get("fd_money");
			if (money != null && money instanceof Double) {
				fdMoney = (Double) money;
			} else if (money != null && money instanceof BigDecimal) {
				fdMoney = ((BigDecimal) money).doubleValue();
			}
			rtn.put(detail.get("fdId").toString(), fdMoney);
		}
		return rtn;
	}

}
