package com.landray.kmss.geesun.leave.listener;

import java.util.Map;

import com.landray.kmss.geesun.leave.service.IGeesunLeaveAddLimitService;
import com.landray.kmss.geesun.leave.service.spring.GeesunLeaveAddLimitServiceImp;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;
import com.landray.kmss.sys.metadata.model.ExtendDataModelInfo;

/**
 * 加班申请流程结束触发事件 按照判断条件:修改假期额度,增加加班记录(增加)
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveIntoLeaveListener implements IEventListener {
	private IGeesunLeaveAddLimitService geesunLeaveAddLimit = new GeesunLeaveAddLimitServiceImp();

	@Override
	public void handleEvent(EventExecutionContext context, String arg1) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) context.getMainModel();
		// 获取到提交流程的表单的模型(包含数据在内)
		ExtendDataModelInfo data = kmReviewMain.getExtendDataModelInfo();
		// 获取到键值对的Map集合数据(表单提交的所有数据以键值对的方式存储)
		Map<String, Object> map = data.getModelData();
		geesunLeaveAddLimit.AddLimit(map, kmReviewMain);// 跳转修改假期额度
	}
}
