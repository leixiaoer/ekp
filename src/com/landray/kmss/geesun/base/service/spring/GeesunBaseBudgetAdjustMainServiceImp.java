package com.landray.kmss.geesun.base.service.spring;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.landray.kmss.fssc.base.model.FsscBaseBudgetScheme;
import com.landray.kmss.fssc.base.service.IFsscBaseBudgetSchemeService;
import com.landray.kmss.fssc.budget.constant.FsscBudgetConstant;
import com.landray.kmss.fssc.budget.service.IFsscBudgetAdjustLogService;
import com.landray.kmss.fssc.budget.service.IFsscBudgetDataService;
import com.landray.kmss.fssc.budget.service.IFsscBudgetExecuteService;
import com.landray.kmss.fssc.common.util.FsscCommonUtil;
import com.landray.kmss.fssc.common.util.FsscNumberUtil;
import com.landray.kmss.geesun.base.service.IGeesunBaseBudgetAdjustMainService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.metadata.model.ExtendDataModelInfo;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

public class GeesunBaseBudgetAdjustMainServiceImp implements IGeesunBaseBudgetAdjustMainService {
	
	private IFsscBudgetDataService fsscBudgetDataService;

	public IFsscBudgetDataService getFsscBudgetDataService() {
		if(fsscBudgetDataService==null){
			fsscBudgetDataService=(IFsscBudgetDataService) SpringBeanUtil.getBean("fsscBudgetDataService");
		}
		return fsscBudgetDataService;
	}
	
	protected IFsscBudgetExecuteService fsscBudgetExecuteService;

	public IFsscBudgetExecuteService getFsscBudgetExecuteService() {
		if(fsscBudgetExecuteService==null){
			fsscBudgetExecuteService=(IFsscBudgetExecuteService) SpringBeanUtil.getBean("fsscBudgetExecuteService");
		}
		return fsscBudgetExecuteService;
	}
	
	protected IFsscBudgetAdjustLogService fsscBudgetAdjustLogService;
	
	public IFsscBudgetAdjustLogService getFsscBudgetAdjustLogService() {
		if(fsscBudgetAdjustLogService==null){
			fsscBudgetAdjustLogService=(IFsscBudgetAdjustLogService) SpringBeanUtil.getBean("fsscBudgetAdjustLogService");
		}
		return fsscBudgetAdjustLogService;
	}
	
	protected IFsscBaseBudgetSchemeService fsscBaseBudgetSchemeService;
	
	public IFsscBaseBudgetSchemeService getFsscBaseBudgetSchemeService() {
		if (null == fsscBaseBudgetSchemeService) {
			fsscBaseBudgetSchemeService = (IFsscBaseBudgetSchemeService) SpringBeanUtil
					.getBean("fsscBaseBudgetSchemeService");
		}
		return fsscBaseBudgetSchemeService;
	}
	
	/**
	 * 预算调整校验当前行借出金额是否足够
	 */
	public JSONObject checkLendMoney(HttpServletRequest request) throws Exception {
		JSONArray budgetArray=new JSONArray(); 
		JSONArray currentBudgetArray=new JSONArray(); //获取当前期间最小的预算
		JSONArray allBudgetArray=new JSONArray();
		JSONObject jsonObject=new JSONObject();
		JSONObject messageJson=new JSONObject();
		String params=request.getParameter("hashMapArray");
		String fdLendPeriod=request.getParameter("fdLendPeriod");
		if(StringUtil.isNotNull(params) && StringUtil.isNotNull(fdLendPeriod)){
			JSONObject dataJson=JSONObject.fromObject(params);
			  //迭代器迭代 map集合所有的keys  
	        Iterator it = dataJson.keys();  
	        while(it.hasNext()){  
	            String key = (String) it.next();  //获取map的key  
	            Object value = dataJson.get(key);  //得到value的值  
	            messageJson.put(key, value);  
	        } 
	        Calendar cal = Calendar.getInstance();
	        cal.setTime(DateUtil.convertStringToDate(fdLendPeriod, DateUtil.PATTERN_DATE));
			budgetArray=getFsscBudgetDataService().findBudget(messageJson,FsscBudgetConstant.FSSC_BUDGET_PERIOD_TYPE_MONTH,
					String.valueOf(cal.get(cal.YEAR)),cal.get(cal.MONTH)>9?String.valueOf(cal.get(cal.MONTH)):("0"+cal.get(cal.MONTH)));
			FsscCommonUtil.concatTwoJSON(budgetArray, allBudgetArray);
			currentBudgetArray=budgetArray;
			budgetArray=getFsscBudgetDataService().findBudget(messageJson,FsscBudgetConstant.FSSC_BUDGET_PERIOD_TYPE_QUARTER,
					String.valueOf(cal.get(cal.YEAR)),"0"+String.valueOf(cal.get(cal.MONTH)/3));
			FsscCommonUtil.concatTwoJSON(budgetArray, allBudgetArray);
			if(currentBudgetArray.size()==0){//无月度预算，查找对应的季度预算
				currentBudgetArray=budgetArray;
			}
			budgetArray=getFsscBudgetDataService().findBudget(messageJson,FsscBudgetConstant.FSSC_BUDGET_PERIOD_TYPE_YEAR,
					String.valueOf(cal.get(cal.YEAR)),null);
			FsscCommonUtil.concatTwoJSON(budgetArray, allBudgetArray);
			if(currentBudgetArray.size()==0){//无月度、季度预算，查找对应的年度度预算
				currentBudgetArray=budgetArray;
			}
			if(currentBudgetArray.size()>0){
				jsonObject.put("minPeriod", currentBudgetArray.get(0));
			}
			jsonObject.put("allPeriod", allBudgetArray);
		}
		return jsonObject;  //正常情况下，月度只会有一条预算结果，出现多条只获取第一条
	}
	
	/**
	 * 预算调整/追加校验当前行借入成本中心对应预算是否存在
	 */
	public JSONObject checkBorrowMoney(HttpServletRequest request) throws Exception {
		JSONObject rtnObj=new JSONObject();
		double canUse=0.0;
		JSONArray budgetArray=new JSONArray();
		JSONObject messageJson=new JSONObject();
		String params=request.getParameter("hashMapArray");
		if(StringUtil.isNotNull(params)){
			JSONObject dataJson=JSONObject.fromObject(params);
			//迭代器迭代 map集合所有的keys  
			Iterator it = dataJson.keys();  
			while(it.hasNext()){  
				String key = (String) it.next();  //获取map的key  
				Object value = dataJson.get(key);  //得到value的值  
				messageJson.put(key, value);  
			} 
			budgetArray=getFsscBudgetDataService().findBudget(messageJson,FsscBudgetConstant.FSSC_BUDGET_PERIOD_TYPE_ALL,null,null);
		}
		int size=budgetArray.size();
		if(size>0){
			canUse=budgetArray.getJSONObject(0).getDouble("fdCanUseAmount");
			for(int k=1;k<size;k++){
				double fdCanUseAmount=budgetArray.getJSONObject(0).getDouble("fdCanUseAmount");
				if(canUse>fdCanUseAmount){
					canUse=fdCanUseAmount;
				}
			}
		}
		rtnObj.put("result", !budgetArray.isEmpty());
		rtnObj.put("canUse", canUse);
		return rtnObj;  //返回值为true则预算存在
	}

	/**
	 * 操作预算
	 * @param kmReviewMain
	 * @param method
	 * @throws Exception
	 */
	public void operationBudget(KmReviewMain kmReviewMain, String method) throws Exception{
		JSONArray budgetArray=new JSONArray();  //所有对应预算信息
		Map<String, Object> mainMap = kmReviewMain.getExtendDataModelInfo().getModelData();
		String fdAdjustType = mainMap.get("fd_adjust_type").toString();
		//获取明细数据
		List<Map<String, Object>> detailList = (List<Map<String, Object>>) mainMap.get("fd_3957075055172c");//预算调整明细
		String fdSchemeId=mainMap.get("fd_scheme_id").toString();
		FsscBaseBudgetScheme scheme = (FsscBaseBudgetScheme) getFsscBaseBudgetSchemeService().findByPrimaryKey(fdSchemeId, FsscBaseBudgetScheme.class, true);
		for(Map<String, Object> detail:detailList){
			Double fdMoney = (null!=detail.get("fd_money")?(Double)detail.get("fd_money"):0.0);
			//借入信息json
			JSONObject borrowJson=new JSONObject();
			borrowJson.put("fdBudgetSchemeId", fdSchemeId);
			//借出信息json
			JSONObject lendJson=new JSONObject();
			lendJson.put("fdBudgetSchemeId", fdSchemeId);
			String fdCompanyId=mainMap.get("fd_company_id").toString();
			//包含公司
			borrowJson.put("fdCompanyId", fdCompanyId);
			borrowJson.put("fdCostCenterId", detail.get("fd_borrow_cost_center_id").toString());
			borrowJson.put("fdBudgetItemId", detail.get("fd_borrow_budget_item_id").toString());
			//包含公司
			lendJson.put("fdCompanyId", fdCompanyId);
			if(FsscBudgetConstant.FSSC_BUDGET_ADJUST_TYPE_ADJUST.equals(fdAdjustType)){//只有调整才有借出成本中心操作
				lendJson.put("fdCostCenterId", detail.get("fd_lend_cost_center_id").toString());
				lendJson.put("fdBudgetItemId", detail.get("fd_lend_budget_item_id").toString());
			}
			//获取所有借入预算，增加调整记录
			budgetArray=getFsscBudgetDataService().findBudget(borrowJson,FsscBudgetConstant.FSSC_BUDGET_PERIOD_TYPE_ALL,null,null);
			if("publish".equals(method)){
				//获取所有借入预算，增加调整记录
				budgetArray=getFsscBudgetDataService().findBudget(borrowJson,FsscBudgetConstant.FSSC_BUDGET_PERIOD_TYPE_ALL,null,null);
				addOrUpdateExecute(budgetArray,fdMoney,kmReviewMain,scheme,detail,FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_ADJUST,"Borrow");
				addAdjustLog(budgetArray,fdMoney, kmReviewMain);//增加预算调整记录
			}
			if(FsscBudgetConstant.FSSC_BUDGET_ADJUST_TYPE_ADJUST.equals(fdAdjustType)){//只有调整才有借出成本中心操作
				//获取所有借出预算，增加调整记录
				String fdBudgetInfo=detail.get("fd_budget_info").toString();
				if(StringUtil.isNotNull(fdBudgetInfo)){
					budgetArray=JSONArray.fromObject(fdBudgetInfo);
					List<String> idList=new ArrayList<>();
					for(int n=0,size=budgetArray.size();n<size;n++){
						JSONObject json=budgetArray.getJSONObject(n);
						if(json.containsKey("fdBudgetId")){
							idList.add(json.getString("fdBudgetId"));
						}
					}
					if(getFsscBudgetDataService().checkBudgetIsKnots(idList)){//页面字段信息预算已全部结转
						budgetArray=getFsscBudgetDataService().findBudget(lendJson,FsscBudgetConstant.FSSC_BUDGET_PERIOD_TYPE_ALL,null,null);
					}
				}
				if("create".equals(method)){//借出方，冻结对应的预算
					addOrUpdateExecute(budgetArray,fdMoney,kmReviewMain,scheme,detail,FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_OCCU,"Lend");
				}else if("update".equals(method)){//借出方重新冻结对应的预算
					addOrUpdateExecute(budgetArray,fdMoney,kmReviewMain,scheme,detail,FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_OCCU,"Lend");
				}else if("publish".equals(method)){
					addAdjustLog(budgetArray,FsscNumberUtil.getSubtraction(0, fdMoney, 2), kmReviewMain);  //增加预算调整记录
					addOrUpdateExecute(budgetArray,FsscNumberUtil.getSubtraction(0, fdMoney, 2),kmReviewMain,scheme,detail,FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_ADJUST,"Lend");
				}else if("delete".equals(method)){
					deleteExecute(budgetArray,kmReviewMain,detail);
				}
			}
		}
	} 
	
	/************************************************************
	 * @param budgetArray需要操作的预算 json格式
	 * @param fdMoney 调整金额
	 * @param KmReviewMain 调整model
	 * @param scheme 预算调整方案
	 * @param fdExecuteType 执行类型，冻结、使用、调整
	 * @param fdType 类型，Borrow 为借入，Lend为借出
	 * ************************************************************/
	public void addOrUpdateExecute(JSONArray budgetArray,Double fdMoney,KmReviewMain main,FsscBaseBudgetScheme scheme, Map<String, Object> detail,String fdExecuteType,String fdType) throws Exception{
		ExtendDataModelInfo data = main.getExtendDataModelInfo();
		Map<String, Object> mainMap = data.getModelData();
		List<String> notHavePeriod=new ArrayList<String>();
		if(scheme!=null){
			String fdPeriod=scheme.getFdPeriod();
			if(StringUtil.isNotNull(fdPeriod)){
				if(!FsscCommonUtil.isContain(fdPeriod, "2;", ";")){//包含年
					notHavePeriod.add("5");
				}
				if(!FsscCommonUtil.isContain(fdPeriod, "3;", ";")){//包含季
					notHavePeriod.add("3");
				}
				if(!FsscCommonUtil.isContain(fdPeriod, "4;", ";")){//包含月
					notHavePeriod.add("1");
				}
			}
		}
		JSONObject executeJson=new JSONObject();//对应预算执行信息
		for(int i=0,len=budgetArray.size();i<len;i++){
			executeJson=new JSONObject();
			JSONObject budgetJson=(JSONObject) budgetArray.get(i);
			executeJson.put("fdModelId", main.getFdId()); //预算调整ID
			executeJson.put("fdModelName", KmReviewMain.class.getName()); //预算modelName
			executeJson.put("fdMoney", fdMoney); //调整金额
			executeJson.put("fdType", fdExecuteType);
			executeJson.put("fdDetailId", detail.get("fdId"));
			executeJson.put("fdBudgetId", budgetJson.containsKey("fdBudgetId")?budgetJson.get("fdBudgetId"):"");
			if(notHavePeriod.contains(budgetJson.get("fdPeriodType"))){
				notHavePeriod.remove(budgetJson.get("fdPeriodType"));  //有对应的预算，则移除
			}
			executeJson.put("fdCostCenterId", detail.get("fd_borrow_cost_center_id").toString());
			executeJson.put("fdBudgetItemId", detail.get("fd_borrow_budget_item_id").toString());
			if("Borrow".equals(fdType)){//拼接预算调整信息
				if(!ArrayUtil.isEmpty(notHavePeriod)){
					String fdTips=ResourceUtil.getString("message.adjust.tips", "fssc-budget");
					String tips="";
					if(notHavePeriod.contains("1")){
						tips+=ResourceUtil.getString("message.adjust.tips.month", "fssc-budget");
					}
					if(notHavePeriod.contains("3")){
						tips+=ResourceUtil.getString("message.adjust.tips.quarter", "fssc-budget");
					}
					if(notHavePeriod.contains("5")){
						tips+=ResourceUtil.getString("message.adjust.tips.year", "fssc-budget");
					}
					if(StringUtil.isNotNull(tips)){
						fdTips=fdTips.replaceAll("tips", tips.substring(0, tips.length()-1));
					}
					mainMap.put("fd_tips", fdTips);
					data.saveModelData();
				}
			}
			//create删除是没数据的，正常情况下，update先删除历史占用的，插入新的占用计算，publish和update类似
			getFsscBudgetExecuteService().deleteFsscBudgetExecute(executeJson);
			//预算执行表插入type为调整的记录，便于后面统计预算总额
			getFsscBudgetExecuteService().addFsscBudgetExecute(executeJson);
		}
	}
	/************************************************************
	 * @param budgetArray需要操作的预算 json格式
	 * @param detail 调整明细model
	 * ************************************************************/
	public void deleteExecute(JSONArray budgetArray, KmReviewMain kmReviewMain, Map<String, Object> detail) throws Exception{
		JSONObject executeJson=new JSONObject();//对应预算执行信息
		for(int i=0,len=budgetArray.size();i<len;i++){
			executeJson=new JSONObject();
			JSONObject budgetJson=(JSONObject) budgetArray.get(i);
			executeJson.put("fdModelId", kmReviewMain.getFdId()); //预算调整ID
			executeJson.put("fdModelName", KmReviewMain.class.getName()); //预算modelName
			executeJson.put("fdDetailId", detail.get("fdId"));
			executeJson.put("fdBudgetId", budgetJson.containsKey("fdBudgetId")?budgetJson.get("fdBudgetId"):"");  //预算ID
			executeJson.put("fdCostCenterId", detail.get("fd_borrow_cost_center_id").toString());
			executeJson.put("fdBudgetItemId", detail.get("fd_borrow_budget_item_id").toString());
			//create删除是没数据的，正常情况下，update先删除历史占用的，插入新的占用计算，publish和update类似
			getFsscBudgetExecuteService().deleteFsscBudgetExecute(executeJson);
		}
	}
	/************************************************************
	 * @param budgetArray需要操作的预算 json格式
	 * @param fdMoney 调整金额
	 * @param fdPersonId 调整人Id
	 * @param fdAdjustMainId 调整单Id
	 * ************************************************************/
	public void addAdjustLog(JSONArray budgetArray,Double fdMoney,KmReviewMain kmReviewMain) throws Exception{
		Map<String, Object> mainMap = kmReviewMain.getExtendDataModelInfo().getModelData();
		JSONObject logJson=new JSONObject();//对应预算执行信息
		for(int i=0,len=budgetArray.size();i<len;i++){
			logJson=new JSONObject();
			JSONObject budgetJson=(JSONObject) budgetArray.get(i);
			logJson.put("fdModelId", kmReviewMain.getFdId()); //预算调整ID
			logJson.put("fdModelName", KmReviewMain.class.getName()); //预算调整modelName
			logJson.put("fdBudgetId", budgetJson.containsKey("fdBudgetId")?budgetJson.get("fdBudgetId"):""); //预算ID
			logJson.put("fdMoney", fdMoney);
			logJson.put("fdPersonId", kmReviewMain.getDocCreator().getFdId());
			logJson.put("fdDesc", mainMap.get("fd_desc").toString());
			//create删除是没数据的没正常情况下，update先删除历史占用的，插入新的占用计算，publish和update类似
			getFsscBudgetAdjustLogService().addAdjust(logJson);
		}
	}
	
	/**
	 * 校验预算数据查看页面调整，调减金额不能不能调为负数
	 */
	public boolean checkAdjust(HttpServletRequest request) throws Exception {
		boolean result=Boolean.TRUE; //默认校验通过
		String params=request.getParameter("hashMapArray");
		if(StringUtil.isNotNull(params)){
			JSONObject dataJson=JSONObject.fromObject(params);
			String fdBudgetId=dataJson.containsKey("fdBudgetId")?dataJson.getString("fdBudgetId"):null;
			if(StringUtil.isNotNull(fdBudgetId)){
				Map<String, String> resultMap=fsscBudgetDataService.getBudgetAcountInfo(fdBudgetId,"double");
				Double fdMoney=(resultMap.containsKey("fdTotalAmount")&&resultMap.get("fdTotalAmount")!=null)
						?Double.parseDouble(String.valueOf(resultMap.get("fdTotalAmount"))):0.00;//可使用额
				Double fdAdjustMoney=dataJson.containsKey("fdAdjustMoney")?Double.parseDouble(dataJson.getString("fdAdjustMoney")):0.00; //调整金额
				if(FsscNumberUtil.getSubtraction(Math.abs(fdAdjustMoney),fdMoney)>0.000001){//调整金额绝对值大于可使用额，不允许调整
					result=Boolean.FALSE;
				}
			}
		}
		return result;
	}
	
}
