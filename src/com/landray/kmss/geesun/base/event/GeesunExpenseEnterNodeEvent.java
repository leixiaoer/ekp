package com.landray.kmss.geesun.base.event;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.fssc.common.interfaces.IFsscCommonBudgetOperatService;
import com.landray.kmss.fssc.common.util.FsscCommonUtil;
import com.landray.kmss.geesun.base.service.spring.GeesunBaseListenerFormServiceImp;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * 起草节点进入事件，释放预算数据
 *
 */
public class GeesunExpenseEnterNodeEvent implements IEventListener{
	
	private static final Log logger = LogFactory
			.getLog(GeesunExpenseEnterNodeEvent.class);
	
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
		String modelStatus = execution.getExecuteParameters().getExpectMainModelStatus();
		if(main!=null&&SysDocConstant.DOC_STATUS_REFUSE.equals(modelStatus)){
			logger.error("单据ID为：" + main.getFdId() + "的单据驳回后进入取消占用方法！");
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

}
