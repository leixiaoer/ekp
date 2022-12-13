package com.landray.kmss.geesun.base.adjust;

import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.geesun.base.model.GeesunBaseConfig;
import com.landray.kmss.geesun.base.service.IGeesunBaseBudgetAdjustMainService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;
import com.landray.sso.client.oracle.StringUtil;

/**
 * 起草人提交事件，占用预算
 * @author 
 *
 */
public class GeesunBudgetAdjustDraftorSubmitEvent implements IEventListener{
	
	protected IGeesunBaseBudgetAdjustMainService geesunBaseBudgetAdjustMainService;
	
	public void setGeesunBaseBudgetAdjustMainService(IGeesunBaseBudgetAdjustMainService geesunBaseBudgetAdjustMainService) {
		this.geesunBaseBudgetAdjustMainService = geesunBaseBudgetAdjustMainService;
	}
	
	@Override
	public void handleEvent(EventExecutionContext execution, String parameter) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) execution.getMainModel();
		GeesunBaseConfig config = new GeesunBaseConfig();
		if (kmReviewMain == null || kmReviewMain.getFdTemplate() == null || StringUtil.isNull(config.getFdAdjustTemplateIds()) 
				|| config.getFdAdjustTemplateIds().indexOf(kmReviewMain.getFdTemplate().getFdId()) == -1) {
			return;
		}
		//只处理驳回状态
		if(!SysDocConstant.DOC_STATUS_REFUSE.equals(kmReviewMain.getDocStatus())){
			return;
		}
		geesunBaseBudgetAdjustMainService.operationBudget(kmReviewMain, "create");
	}
}
