package com.landray.kmss.geesun.base.adjust;

import com.landray.kmss.geesun.base.model.GeesunBaseConfig;
import com.landray.kmss.geesun.base.service.IGeesunBaseBudgetAdjustMainService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;
import com.landray.kmss.sys.lbpm.engine.persistence.model.LbpmProcess;
import com.landray.sso.client.oracle.StringUtil;

/***
 * 预算调整流程结束，将借出成本中心对应的金额转移到借入成本中心
 * **/
public class GeesunBudgetAdjustFinishEvent implements IEventListener {
	
	protected IGeesunBaseBudgetAdjustMainService geesunBaseBudgetAdjustMainService;
	
	public void setGeesunBaseBudgetAdjustMainService(IGeesunBaseBudgetAdjustMainService geesunBaseBudgetAdjustMainService) {
		this.geesunBaseBudgetAdjustMainService = geesunBaseBudgetAdjustMainService;
	}

	public void handleEvent(EventExecutionContext execution, String parameter)
			throws Exception {
		LbpmProcess self = execution.getProcessInstance();
		if (self == null) {
			return;
		}
		String modelName = self.getFdModelName();
		if (!"com.landray.kmss.km.review.model.KmReviewMain".equals(
				modelName)) {
			return;
		}
		KmReviewMain kmReviewMain = (KmReviewMain) execution.getMainModel();
		GeesunBaseConfig config = new GeesunBaseConfig();
		if (kmReviewMain == null || kmReviewMain.getFdTemplate() == null || StringUtil.isNull(config.getFdAdjustTemplateIds()) 
				|| config.getFdAdjustTemplateIds().indexOf(kmReviewMain.getFdTemplate().getFdId()) == -1) {
			return;
		}
		geesunBaseBudgetAdjustMainService.operationBudget(kmReviewMain, "publish");
	}
}

