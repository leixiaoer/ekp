package com.landray.kmss.geesun.base.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.Query;

import com.alibaba.fastjson.JSON;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.fssc.base.constant.FsscBaseConstant;
import com.landray.kmss.fssc.base.model.FsscBaseCompany;
import com.landray.kmss.fssc.base.model.FsscBaseExchangeRate;
import com.landray.kmss.fssc.base.util.FsscBaseUtil;
import com.landray.kmss.fssc.common.interfaces.IFsscCommonBudgetMatchService;
import com.landray.kmss.fssc.common.util.FsscCommonUtil;
import com.landray.kmss.geesun.base.forms.GeesunBaseBxsjForm;
import com.landray.kmss.geesun.base.model.GeesunBaseBxsj;
import com.landray.kmss.geesun.base.service.IGeesunBaseBudgetAdjustMainService;
import com.landray.kmss.geesun.base.service.IGeesunBaseBxsjService;
import com.landray.kmss.geesun.base.util.PageUtils;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

public class GeesunBaseBxsjAction extends ExtendAction {

    private IGeesunBaseBxsjService geesunBaseBxsjService;

    public IGeesunBaseBxsjService getServiceImp(HttpServletRequest request) {
        if (geesunBaseBxsjService == null) {
            geesunBaseBxsjService = (IGeesunBaseBxsjService) getBean("geesunBaseBxsjService");
        }
        return geesunBaseBxsjService;
    }
    
    private IFsscCommonBudgetMatchService fsscCommonBudgetService;

	public IFsscCommonBudgetMatchService getFsscCommonBudgetService() {
		if (fsscCommonBudgetService == null) {
			fsscCommonBudgetService = (IFsscCommonBudgetMatchService) getBean("fsscBudgetMatchService");
        }
		return fsscCommonBudgetService;
	}
	
	protected IGeesunBaseBudgetAdjustMainService geesunBaseBudgetAdjustMainService;
	
	public IGeesunBaseBudgetAdjustMainService getGeesunBaseBudgetAdjustMainService() {
		if (null == geesunBaseBudgetAdjustMainService) {
			geesunBaseBudgetAdjustMainService = (IGeesunBaseBudgetAdjustMainService) getBean("geesunBaseBudgetAdjustMainService");
		}
		return geesunBaseBudgetAdjustMainService;
	}

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunBaseBxsj.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.base.util.GeesunBaseUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.base.model.GeesunBaseBxsj.class);
        com.landray.kmss.geesun.base.util.GeesunBaseUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunBaseBxsjForm geesunBaseBxsjForm = (GeesunBaseBxsjForm) super.createNewForm(mapping, form, request, response);
        ((IGeesunBaseBxsjService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(request));
        return geesunBaseBxsjForm;
    }
    
    /**
	 * 查找预算
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForm getBudgetData(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String json = request.getParameter("data");
		try {
			JSONArray param = JSONArray.fromObject(json);
			JSONArray budgets = new JSONArray();
			if(FsscCommonUtil.checkHasModule("/fssc/budget/")){
				for(int i=0;i<param.size();i++){
					JSONObject row = param.getJSONObject(i);
					String fdDetailId = row.getString("fdDetailId");
					JSONObject budget = getFsscCommonBudgetService().matchFsscBudget(row);
					row.clear();
					row.put("fdDetailId", fdDetailId);
					row.put("budget", budget);
					budgets.add(row);
				}
			}
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(budgets.toString());
		} catch (Exception e) {
			response.getWriter().write("");
			e.printStackTrace();
		}
        return null;
    }
    
    /**
	 * 单条明细匹配预算
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward matchBudget(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONObject rtn = new JSONObject();
		String param = request.getParameter("data");
		rtn.put("result", "success");
		if(!FsscCommonUtil.checkHasModule("/fssc/budget/")){
			JSONObject budget = new JSONObject();
			budget.put("result", "2");
			budget.put("data", new JSONArray());
			rtn.put("budget", new JSONObject());
		}else{
			JSONObject data = JSONObject.fromObject(param);
			JSONObject budget = getFsscCommonBudgetService().matchFsscBudget(data);
			try {
				FsscBaseCompany comp = (FsscBaseCompany) getServiceImp(request).findByPrimaryKey(data.getString("fdCompanyId"), FsscBaseCompany.class, true);
				String hql = "from com.landray.kmss.fssc.base.model.FsscBaseExchangeRate where fdType=:fdType and fdIsAvailable=:fdIsAvailable and fdCompany.fdId=:fdCompanyId and fdSourceCurrency.fdId=:fdSourceCurrencyId and fdTargetCurrency.fdId=:fdTargetCurrencyId";
				Query query = getServiceImp(request).getBaseDao().getHibernateSession().createQuery(hql);
				//判断是否启用了实时汇率
				String value = FsscBaseUtil.getSwitchValue("fdRateEnabled");
				if("1".equals(value)){
					query.setParameter("fdType", FsscBaseConstant.FSSC_BASE_EXCHANGE_RATE_TYPE_CURRENT);
				}else{
					query.setParameter("fdType", FsscBaseConstant.FSSC_BASE_EXCHANGE_RATE_TYPE_COST);
				}
				query.setParameter("fdCompanyId", data.getString("fdCompanyId"));
				query.setParameter("fdIsAvailable", true);
				query.setParameter("fdSourceCurrencyId",data.getString("fdCurrencyId"));
				query.setParameter("fdTargetCurrencyId", comp.getFdBudgetCurrency().getFdId());
				List<FsscBaseExchangeRate> rates = query.list();
				if(ArrayUtil.isEmpty(rates)){
					//如果没有查到相应汇率，但匹配到了预算，提示用户不能报销
					if("2".equals(budget.get("result"))&&budget.getJSONArray("data").size()>0){
						rtn.put("result", "failure");
						rtn.put("message", ResourceUtil.getString("tips.exchangeRateNotExist","fssc-expense"));
					}else{
						rtn.put("budget", budget);
						rtn.put("fdBudgetRate", "0");
					}
				}else{
					rtn.put("budget", budget);
					rtn.put("fdBudgetRate", rates.get(0).getFdRate());
				}
			} catch (Exception e) {
				rtn.put("result", "failure");
				rtn.put("message", ResourceUtil.getString("errors.unknown")+"<br>"+e.getMessage());
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(rtn.toString());
		return null;
	}
	
	/**
	 * 预算调整校验当前行借出金额是否足够
	 */
	public ActionForward checkLendMoney(ActionMapping mapping,ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONObject json = getGeesunBaseBudgetAdjustMainService().checkLendMoney(request);
		if(UserOperHelper.allowLogOper("checkLendMoney", GeesunBaseBxsj.class.getName())){
			UserOperContentHelper.putFind(JSON.parseObject(json.toString()));
		}
		response.setCharacterEncoding("UTF-8");
		if(!json.isEmpty()){
			response.getWriter().write(json.toString());
		}else{
			response.getWriter().write("");
		}
		return null;
	}
	/**
	 * 预算调整/追加校验当前行借入成本中心对应预算是否存在
	 */
	public ActionForward checkBorrowMoney(ActionMapping mapping,ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONObject result = getGeesunBaseBudgetAdjustMainService().checkBorrowMoney(request);
		if(UserOperHelper.allowLogOper("checkLendMoney", GeesunBaseBxsj.class.getName())){
			String params=request.getParameter("hashMapArray");
			if(StringUtil.isNotNull(params)){
				UserOperContentHelper.putFind(JSONObject.fromObject(params));
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(String.valueOf(result));
		return null;
	}
	/**
	 * 查看页面预算调整，校验调减金额不能多余可使用额，防止预算调为负数
	 */
	public ActionForward checkAdjust(ActionMapping mapping,ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		boolean result = getGeesunBaseBudgetAdjustMainService().checkAdjust(request);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(String.valueOf(result));
		return null;
	}
	
	/**
	 * 用于查询所有报表数据
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward listQuery(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-listQuery", true, getClass());
		KmssMessages messages = new KmssMessages();
		String forward = "listQuery";
		Page page = new Page();
		try {
			page = getServiceImp(request).getExpenseReportList(PageUtils.buildStatisticsPageInfo(request), request);
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-listQuery", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward(forward, mapping, form, request, response);
		}
	}
	
	/**
	 * 导出财务总表数据
	 */
	public ActionForward exportReportData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-exportReportData", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String subject = request.getParameter("subject");
			String number = request.getParameter("number");
			String status = request.getParameter("status");
			String type = request.getParameter("type");
			String fdMonth = request.getParameter("fdMonth");
			String beginDate = request.getParameter("beginDate");
			String endDate = request.getParameter("endDate");
			getServiceImp(request).exportReportListInfos(subject, number, status, type, beginDate, endDate, response);
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		return null;
	}
    
}
