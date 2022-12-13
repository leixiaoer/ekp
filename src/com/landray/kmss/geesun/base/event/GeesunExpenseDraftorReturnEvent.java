package com.landray.kmss.geesun.base.event;

import net.sf.json.JSONObject;

import com.landray.kmss.fssc.common.interfaces.IFsscCommonBudgetOperatService;
import com.landray.kmss.fssc.common.util.FsscCommonUtil;
import com.landray.kmss.geesun.base.model.GeesunBaseConfig;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.sso.client.oracle.StringUtil;
/**
 * 起草人撤回，释放预算
 *
 */
public class GeesunExpenseDraftorReturnEvent implements IEventListener{
	
	private IFsscCommonBudgetOperatService fsscBudgetOperatService;
	
	public IFsscCommonBudgetOperatService getFsscBudgetOperatService() {
		if(fsscBudgetOperatService==null){
			fsscBudgetOperatService = (IFsscCommonBudgetOperatService) SpringBeanUtil.getBean("fsscBudgetOperatService");
		}
		return fsscBudgetOperatService;
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
				JSONObject object = new JSONObject();
				object.put("fdModelName", KmReviewMain.class.getName());
				object.put("fdModelId", main.getFdId());
				getFsscBudgetOperatService().deleteFsscBudgetExecute(object);
			}
		}
	}
}
