package com.landray.kmss.geesun.leave.listener;

import java.util.HashMap;
import java.util.Map;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveMappingFormDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveMappingFormDaoImpl;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;

/**
 * 流程结束修改调休状态
 * 
 * @author 渣渣辉
 *
 */

public class GeesunLeaveIntoAddTakeWorkingListener implements IEventListener {
	private IGeesunLeaveMappingFormDao geesunLeaveMappinFormDao = new GeesunLeaveMappingFormDaoImpl();

	@Override
	public void handleEvent(EventExecutionContext context, String arg1) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) context.getMainModel();
		Map<String, String> map = new HashMap<>();
		String flowId = kmReviewMain.getFdId();
		map.put("flowId", flowId);
		if (flowId != null) {
			String state = "20";// 成功通过状态
			map.put("state", state);
			geesunLeaveMappinFormDao.upMessage(map);
		}
	}

}
