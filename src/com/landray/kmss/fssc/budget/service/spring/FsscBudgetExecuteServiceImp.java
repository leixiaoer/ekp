package com.landray.kmss.fssc.budget.service.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.PropertyUtils;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.KmssRuntimeException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.fssc.base.model.FsscBaseBudgetScheme;
import com.landray.kmss.fssc.base.util.FsscBaseUtil;
import com.landray.kmss.fssc.budget.constant.FsscBudgetConstant;
import com.landray.kmss.fssc.budget.model.FsscBudgetData;
import com.landray.kmss.fssc.budget.model.FsscBudgetExecute;
import com.landray.kmss.fssc.budget.service.IFsscBudgetDataService;
import com.landray.kmss.fssc.budget.service.IFsscBudgetExecuteService;
import com.landray.kmss.fssc.budget.util.FsscBudgetParseXmlUtil;
import com.landray.kmss.fssc.budget.util.FsscBudgetUtil;
import com.landray.kmss.fssc.common.constant.FsscCommonConstant;
import com.landray.kmss.fssc.common.util.FsscCommonUtil;
import com.landray.kmss.fssc.common.util.FsscNumberUtil;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.config.dict.SysDataDict;
import com.landray.kmss.sys.config.dict.SysDictCommonProperty;
import com.landray.kmss.sys.config.dict.SysDictModel;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.KmssMessage;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

public class FsscBudgetExecuteServiceImp extends ExtendDataServiceImp implements IFsscBudgetExecuteService {
	
	protected IFsscBudgetDataService fsscBudgetDataService;
	
	public IFsscBudgetDataService getFsscBudgetDataService() {
		if(fsscBudgetDataService==null){
			fsscBudgetDataService=(IFsscBudgetDataService) SpringBeanUtil.getBean("fsscBudgetDataService");
		}
		return fsscBudgetDataService;
	}

	public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof FsscBudgetExecute) {
            FsscBudgetExecute fsscBudgetExecute = (FsscBudgetExecute) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        FsscBudgetExecute fsscBudgetExecute = new FsscBudgetExecute();
        FsscBudgetUtil.initModelFromRequest(fsscBudgetExecute, requestContext);
        return fsscBudgetExecute;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        FsscBudgetExecute fsscBudgetExecute = (FsscBudgetExecute) model;
    }
    /********************************************************
     * @param executeJson ????????????????????????
     * return JSONObject result:success ?????????failure????????????message??????????????? 
     * ******************************************************/
    public JSONObject addFsscBudgetExecute(JSONObject executeJson) throws Exception{
    	JSONObject rtnObj=new JSONObject();
    	try {
    		if(!executeJson.isEmpty()){
    			//????????????????????????
    			String[] validateProperty={"fdModelId","fdModelName","fdBudgetId","fdType","fdMoney"};
    			for(String property:validateProperty){
    				Object val=executeJson.containsKey(property)?executeJson.get(property):null;
    				if(val==null){
    					KmssMessage msg = new KmssMessage("fssc-budget:message.fsscBudgetExecute.setParameterError");
    					throw new KmssRuntimeException(msg);
    				}
    			}
    			Map<String, SysDictCommonProperty> dictMap=SysDataDict.getInstance().getModel(FsscBudgetExecute.class.getName()).getPropertyMap();
    			FsscBudgetExecute execute=new FsscBudgetExecute();
    	    	  //??????????????? map???????????????keys  
    	        Iterator it = executeJson.keys();  
    	        while(it.hasNext()){  
    	            String key = (String) it.next();  //??????map???key  
    	            Object value = executeJson.get(key);  //??????value??????  
    	            if(dictMap.containsKey(key)){
    	            	PropertyUtils.setProperty(execute, key, value);  
    	            }
    	        }  
    	        this.add(execute);
    	        rtnObj.put("result", "success");
        	}
		} catch (Exception e) {
			rtnObj.put("result", "failure");
			rtnObj.put("message", e.getMessage());
		}
    	return rtnObj;
    }
    
    /********************************************************
     * @param executeJson ????????????????????????
     * ******************************************************/
    public JSONObject deleteFsscBudgetExecute(JSONObject executeJson) throws Exception{
    	JSONObject rtnObj=new JSONObject();
    	try {
    		HQLInfo hqlInfo=new HQLInfo();
        	StringBuilder whereBlock=new StringBuilder("fsscBudgetExecute.fdModelId=:fdModelId");
        	hqlInfo.setParameter("fdModelId", executeJson.containsKey("fdModelId")?executeJson.get("fdModelId"):"");
        	whereBlock.append(" and fsscBudgetExecute.fdType!=:fdType");
        	hqlInfo.setParameter("fdType", FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_INUSE); //???????????????????????????????????????
        	if(executeJson.containsKey("fdDetailId")&&StringUtil.isNotNull(executeJson.getString("fdDetailId"))){
        		whereBlock.append(" and fsscBudgetExecute.fdDetailId=:fdDetailId");
            	hqlInfo.setParameter("fdDetailId", executeJson.get("fdDetailId")); //?????????????????????????????????ID
        	}
        	if(executeJson.containsKey("fdModelName")){
        		whereBlock.append(" and fsscBudgetExecute.fdModelName=:fdModelName");
        		hqlInfo.setParameter("fdModelName", executeJson.get("fdModelName")); //?????????????????????????????????ID
        	}
        	if(executeJson.containsKey("fdBudgetId")&&StringUtil.isNotNull(executeJson.getString("fdBudgetId"))){//????????????ID?????????????????????????????????????????????
        		whereBlock.append(" and fsscBudgetExecute.fdBudgetId=:fdBudgetId");
        		hqlInfo.setParameter("fdBudgetId", executeJson.get("fdBudgetId")); //????????????ID
        	}
        	hqlInfo.setWhereBlock(whereBlock.toString());
        	List<FsscBudgetExecute> executeList=this.findList(hqlInfo);
        	for(FsscBudgetExecute execute:executeList){
        		this.delete(execute);
        	}
        	rtnObj.put("result", "success");
		} catch (Exception e) {
			rtnObj.put("result", "failure");
			rtnObj.put("message", e.toString());
		}
    	return rtnObj;
    }
    
    @Override
	public Map<String, Double> getExecuteData(String fdBudgetId,String queryType)
			throws Exception {
		Map<String, Double> rtnMap = new ConcurrentHashMap<String, Double>();
		if (StringUtil.isNull(fdBudgetId))
			return rtnMap;
		FsscBudgetData fsscBudgetData = (FsscBudgetData) this.findByPrimaryKey(fdBudgetId,FsscBudgetData.class,true);
		String fdKnots=FsscBaseUtil.getSwitchValue("fdKnots");
    	if(StringUtil.isNull(fdKnots)){
    		fdKnots="0"; //?????????????????????????????????
    	}
		double rollMoney = 0.0;  //??????????????????
		if (FsscBudgetConstant.FSSC_BUDGET_RULE_ROLL.equals(fsscBudgetData.getFdApply())&&"match".equals(queryType)) {//??????????????????????????????????????????????????????????????????????????????????????????
			//??????????????????????????????????????????????????????fsscBudgetDataService.findBudget??????????????????????????????
			JSONArray budgetArray=getBudgets(fsscBudgetData);
			for(int j=0;j<budgetArray.size();j++){
				JSONObject budgetObj=budgetArray.getJSONObject(j);
				List<String> idList=new ArrayList<String>();
				if(budgetObj.containsKey("fdBudgetId")&&budgetObj.get("fdBudgetId")!=null){
					idList.add(budgetObj.getString("fdBudgetId"));
				}
				if(!getFsscBudgetDataService().checkBudgetIsKnots(idList)){
					if(budgetObj.containsKey("canUseAmount")&&budgetObj.get("canUseAmount")!=null){
						rollMoney=FsscNumberUtil.getAddition(rollMoney, budgetObj.getDouble("canUseAmount"), 2);
					}
				}
			}
		}
		// ??????????????????
		double initAmount = fsscBudgetData.getFdMoney();
		// ???????????????????????????
		double alreadyUsedAmount = getExceuteByType(fdBudgetId,FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_INUSE);
		// ??????????????????
		double occupyAmount =  getExceuteByType(fdBudgetId,FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_OCCU);
		// ????????????
		double adjustAmount = getExceuteByType(fdBudgetId,FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_ADJUST);
		// ????????????????????? = ??????????????? + ????????????
		double totalAmount = FsscNumberUtil.getAddition(initAmount, adjustAmount);
		double canUseAmount = FsscNumberUtil.getSubtraction(FsscNumberUtil.getSubtraction(totalAmount, alreadyUsedAmount),occupyAmount);  //???????????????????????????
		canUseAmount = FsscNumberUtil.getAddition(canUseAmount, rollMoney);  //???????????????????????????
		rtnMap.put("rollMoney", rollMoney);  //???????????????
		rtnMap.put("alreadyUsedAmount", FsscNumberUtil.doubleToUp(alreadyUsedAmount));  //?????????
		rtnMap.put("occupyAmount",  FsscNumberUtil.doubleToUp(occupyAmount)); //??????
		rtnMap.put("canUseAmount",  FsscNumberUtil.doubleToUp(canUseAmount));  //?????????
		rtnMap.put("initAmount",  FsscNumberUtil.doubleToUp(initAmount));  //???????????????
		rtnMap.put("totalAmount",  FsscNumberUtil.doubleToUp(totalAmount));  //???????????????
		rtnMap.put("adjustAmount",  FsscNumberUtil.doubleToUp(adjustAmount)); //???????????????
		return rtnMap;
	}
    
    /***************************************************
	 * ???????????????type?????????1??????????????????2??????????????????3?????????????????????4???????????????
	 * ***********************************************/
	
	public Double getExceuteByType(String fdBudgetId,String fdType) throws Exception{
		Double fdGoalMoney=0.0;
		HQLInfo hqlInfo=new HQLInfo();
		hqlInfo.setSelectBlock("sum(fsscBudgetExecute.fdMoney)");
		hqlInfo.setWhereBlock("fsscBudgetExecute.fdBudgetId=:fdBudgetId and fsscBudgetExecute.fdType=:fdType");
		hqlInfo.setParameter("fdBudgetId", fdBudgetId);
		hqlInfo.setParameter("fdType", fdType);
		List result=this.findList(hqlInfo);
		if(!ArrayUtil.isEmpty(result)&&result.get(0)!=null){
			fdGoalMoney=(Double) result.get(0);
		}
		return fdGoalMoney;
	} 
	
	/***************************************************
	 * ???????????????type?????????1??????????????????2??????????????????3?????????????????????4???????????????,????????????id
	 * ***********************************************/
	public Map<String,Double> getExceuteMapByType(List<String> fdBudgetIdList,String fdType) throws Exception{
		Map<String,Double> rtnMap=new HashMap<>();
		StringBuilder hql=new StringBuilder();
		hql.append("select fsscBudgetExecute.fdBudgetId,sum(fsscBudgetExecute.fdMoney)");
		hql.append(" from FsscBudgetExecute fsscBudgetExecute");
		hql.append(" where "+HQLUtil.buildLogicIN("fsscBudgetExecute.fdBudgetId", fdBudgetIdList)+" and fsscBudgetExecute.fdType=:fdType");
		hql.append(" group by fsscBudgetExecute.fdBudgetId");
		List<Object[]> result=this.getBaseDao().getHibernateSession().createQuery(hql.toString())
				.setParameter("fdType", fdType).list();
		if(!ArrayUtil.isEmpty(result)){
			for(Object[] obj:result){
				if(obj.length>1){
					rtnMap.put(String.valueOf(obj[0]), obj[1]!=null?Double.parseDouble(String.valueOf(obj[1])):0.0);
				}
			}
		}
		return rtnMap;
	} 
	
	//???????????????????????????????????????????????????????????????
	public JSONArray getBudgets(FsscBudgetData fsscBudgetData) throws Exception{
		JSONArray rtnArray=new JSONArray();
		FsscBaseBudgetScheme scheme=fsscBudgetData.getFdBudgetScheme();
		if(scheme==null&&StringUtil.isNotNull(fsscBudgetData.getFdBudgetSchemeCode())){
			List<FsscBaseBudgetScheme> schemeList=this.getBaseDao().getHibernateSession()
					.createQuery("select scheme from FsscBaseBudgetScheme scheme where scheme.fdCode=:fdCode")
					.setParameter("fdCode", fsscBudgetData.getFdBudgetSchemeCode()).list();
			if(!ArrayUtil.isEmpty(schemeList)){
				scheme=schemeList.get(0);
			}
		}
		if(scheme==null){
			return rtnArray;
		}
		String fdDimensions=scheme.getFdDimension()+";";  //????????????
		List<Map<String,String>>  propertyList=FsscBudgetParseXmlUtil.getImportProperty();
    	List<Map<String,String>> inPropertyList=new ArrayList<Map<String,String>>();
    	List<Map<String,String>> notInPropertyList=new ArrayList<Map<String,String>>();
    	for(Map<String,String> map:propertyList){
			if(map.containsKey("dimension")){//?????????????????????
				if(FsscCommonUtil.isContain(fdDimensions, map.get("dimension")+";", ";")){
					inPropertyList.add(map);
				}else{
					notInPropertyList.add(map);
				}
			}
		}
    	SysDictModel dict=SysDataDict.getInstance().getModel(FsscBudgetData.class.getName());
		Map<String, SysDictCommonProperty> propertyMap=dict.getPropertyMap();
		HQLInfo hqlInfo=new HQLInfo();
		StringBuilder whereBlock=new StringBuilder("fsscBudgetData.fdBudgetStatus=:fdBudgetStatus");
		whereBlock.append(" and fsscBudgetData.fdYear=:fdYear and fsscBudgetData.fdPeriodType=:fdPeriodType");
		whereBlock.append(" and fsscBudgetData.fdPeriod<:fdPeriod");
		hqlInfo.setParameter("fdBudgetStatus", FsscBudgetConstant.FSSC_BUDGET_STATUS_ENABLE);
		hqlInfo.setParameter("fdYear", fsscBudgetData.getFdYear());
		hqlInfo.setParameter("fdPeriodType", fsscBudgetData.getFdPeriodType());
		hqlInfo.setParameter("fdPeriod", fsscBudgetData.getFdPeriod());
		for (Map<String,String> map : inPropertyList) {
			String property=map.get("property");
			if(propertyMap.get(property).getType().startsWith("com.landray.kmss")){
				Object obj=PropertyUtils.getProperty(fsscBudgetData, property);
				whereBlock.append(" and fsscBudgetData."+property+".fdId=:"+property);
	 			hqlInfo.setParameter(property,PropertyUtils.getProperty(obj, "fdId"));
			}else{
				whereBlock.append(" and fsscBudgetData."+property+".fdId=:"+property);
	 			hqlInfo.setParameter(property,PropertyUtils.getProperty(fsscBudgetData, property));
			}
		}
		for (Map<String,String> map : notInPropertyList) {
			String property=map.get("property");
			if(propertyMap.get(property).getType().startsWith("com.landray.kmss")){
				whereBlock.append(" and fsscBudgetData."+property+".fdId is null");
			}else{
				whereBlock.append(" and fsscBudgetData."+property+" is null");
			}
		}
		hqlInfo.setWhereBlock(whereBlock.toString());
		hqlInfo.setOrderBy("fsscBudgetData.fdPeriod desc");
		List<FsscBudgetData> dataList=getFsscBudgetDataService().findList(hqlInfo);
		for(FsscBudgetData data:dataList){
			JSONObject obj=new JSONObject();
			// ??????????????????
			double initAmount = data.getFdMoney();
			// ???????????????????????????
			double alreadyUsedAmount = getExceuteByType(data.getFdId(),FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_INUSE);
			// ??????????????????
			double occupyAmount =  getExceuteByType(data.getFdId(),FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_OCCU);
			// ????????????
			double adjustAmount = getExceuteByType(data.getFdId(),FsscBudgetConstant.FSSC_BUDGET_EXECUTE_TYPE_ADJUST);
			// ????????????????????? = ??????????????? + ????????????
			double totalAmount = initAmount + adjustAmount;
			double canUseAmount = totalAmount - alreadyUsedAmount - occupyAmount;  //???????????????????????????
			obj.put("fdBudgetId", data.getFdId());
			obj.put("canUseAmount", canUseAmount);
			rtnArray.add(obj);
		}
		return rtnArray;
	}
	
	/***************************************************
	 * ??????????????????????????????????????????????????????????????????????????????
	 * ***********************************************/
	@Override
	public JSONObject updateFsscBudgetExecute(JSONObject executeJson)
			throws Exception {
		JSONObject jsonObject=new JSONObject();
		try {
			JSONObject rtnObj=addFsscBudgetExecute(executeJson);
			if(FsscCommonConstant.FSSC_COMMON_RESUT_SUCCESS.equals(rtnObj.get("result"))){
				jsonObject.put("result","success");
			}else{
				jsonObject.put("result","failure");
				jsonObject.put("message", rtnObj.get("message"));
			}
		} catch (Exception e) {
			jsonObject.put("result","failure");
			jsonObject.put("message", e.toString());
		}
		return jsonObject;
	}
	
	/***************************************************
	 * ????????????????????????????????????
	 * ***********************************************/
	@Override
	public JSONObject matchFsscBudgetExecute(JSONObject dataJson) {
		JSONObject jsonObject=new JSONObject();
		try {
			JSONArray jsonArray=new JSONArray();
			JSONObject obj=new JSONObject();
			String fdModelId=dataJson.containsKey("fdModelId")?dataJson.getString("fdModelId"):null;
			String fdModelName=dataJson.containsKey("fdModelName")?dataJson.getString("fdModelName"):null;
			String fdDetailId=dataJson.containsKey("fdDetailId")?dataJson.getString("fdDetailId"):null;
			String fdType=dataJson.containsKey("fdType")?dataJson.getString("fdType"):null;
			StringBuilder whereBlock=new StringBuilder();
			HQLInfo hqlInfo=new HQLInfo();
			whereBlock.append("fsscBudgetExecute.fdModelId=:fdModelId");
			hqlInfo.setParameter("fdModelId", fdModelId);
			whereBlock.append(" and fsscBudgetExecute.fdModelName=:fdModelName");
			hqlInfo.setParameter("fdModelName", fdModelName);
			if(StringUtil.isNotNull(fdDetailId)){
				whereBlock.append(" and fsscBudgetExecute.fdDetailId=:fdDetailId");
				hqlInfo.setParameter("fdDetailId", fdDetailId);
			}
			if(StringUtil.isNotNull(fdType)){
				whereBlock.append(" and fsscBudgetExecute.fdType=:fdType");
				hqlInfo.setParameter("fdType", fdType);
			}
			hqlInfo.setWhereBlock(whereBlock.toString());
			List<FsscBudgetExecute> executeList=this.findList(hqlInfo);
			Map<String, SysDictCommonProperty> propMap = SysDataDict.getInstance().getModel(FsscBudgetExecute.class.getName()).getPropertyMap();
			for (FsscBudgetExecute execute : executeList) {
				obj=new JSONObject();
				Iterator its=propMap.keySet().iterator();
				while(its.hasNext()){
					String property=(String) its.next();
					SysDictCommonProperty dict=propMap.get(property);
					String type=dict.getType();
					if(type.startsWith("com.landray.kmss")){//????????????
						Object object=PropertyUtils.getProperty(execute, property);
						if(object!=null){
							obj.put(property+"Id", PropertyUtils.getProperty(object, "fdId"));	
						}
					}else{//????????????
						obj.put(property, PropertyUtils.getProperty(execute, property));	
					}
				}
				jsonArray.add(obj);
			}
			jsonObject.put("result","success");
			jsonObject.put("data", jsonArray);
		} catch (Exception e) {
			jsonObject.put("result","failure");
			jsonObject.put("message", e.toString());
		}
		return jsonObject;
	}

	/***************************************************
	 * ????????????????????????????????????????????????????????????
	 * ***********************************************/
	@Override
	public Map<String, Map<String,String>> getExtraExecute(List<FsscBudgetExecute> dataList)
			throws Exception {
		Map<String, Map<String,String>> rtnMap=new HashMap<String, Map<String,String>>();
		StringBuilder hql=new StringBuilder();
		Map<String,String> valMap=new HashMap<String,String>();
		for (FsscBudgetExecute execute : dataList) {
			valMap=new HashMap<String,String>();
			String fdModelName=execute.getFdModelName();
			if(StringUtil.isNotNull(fdModelName)&&fdModelName.indexOf("$")>-1){
				fdModelName=fdModelName.substring(0,fdModelName.indexOf("$"));
			}
			hql=new StringBuilder();
			if (KmReviewMain.class.getName().equals(fdModelName)) {
				hql.append(" select t.fdNumber,t.docSubject,t.fdId from "+fdModelName);
			} else {
				hql.append(" select t.docNumber,t.docSubject,t.fdId from "+fdModelName);
			}
			hql.append(" t where t.fdId=:fdModelId");
			List<Object[]> result=this.getBaseDao().getHibernateSession().createQuery(hql.toString())
					.setParameter("fdModelId", execute.getFdModelId()).list();
			for(int i=0,len=result.size();i<len;i++){
				Object[] obj=result.get(i);
				valMap.put("docNumber", String.valueOf(obj[0]));
				valMap.put("docSubject", String.valueOf(obj[1]));
				if(StringUtil.isNotNull(fdModelName)){
					SysDictModel model=SysDataDict.getInstance().getModel(fdModelName);
					String messageKey=model.getMessageKey();
					if(StringUtil.isNotNull(messageKey)){
						valMap.put("fdModelName", ResourceUtil.getString(messageKey.split(":")[1], messageKey.split(":")[0]));
					}
					valMap.put("fdUrl", model.getUrl().replace("${fdId}", String.valueOf(obj[2])));
				}
			}
			valMap.put("budgetId", execute.getFdBudgetId());
			rtnMap.put(execute.getFdId(), valMap);
		}
		return rtnMap;
	}
	
}
