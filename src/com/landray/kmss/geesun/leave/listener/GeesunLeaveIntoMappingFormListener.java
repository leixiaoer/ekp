package com.landray.kmss.geesun.leave.listener;

import java.util.HashMap;
import java.util.Map;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveMappingFormDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveMappingFormDaoImpl;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;

/**
 * 
 * 进入开始节点触发事件,修改假期冻结额度(30)
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveIntoMappingFormListener implements IEventListener {
	private IGeesunLeaveMappingFormDao geesunLeaveMappinFormDao = new GeesunLeaveMappingFormDaoImpl();

	@Override
	public void handleEvent(EventExecutionContext context, String arg1) throws Exception {
		Map<String, String> map = new HashMap<>();
		KmReviewMain geesunLeaveBarter = (KmReviewMain) context.getMainModel();
		if (geesunLeaveBarter != null) {
			String flowId = geesunLeaveBarter.getFdId();
			map.put("flowId", flowId);
			if (flowId != null) {
				String state = "30";// 废弃状态
				map.put("state", state);
				geesunLeaveMappinFormDao.upMessage(map);
			}
		}
	}
}
