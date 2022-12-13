package com.landray.kmss.geesun.leave.listener;

import java.util.HashMap;
import java.util.Map;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveAdjustDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveAdjustDaoImp;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;

/**
 * 加班流程进入开始节点修改冻结时间状态
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveIntoMappingAdjustFromListener implements IEventListener {
	private IGeesunLeaveAdjustDao geesunLeaveAdjustDao = new GeesunLeaveAdjustDaoImp();

	@Override
	public void handleEvent(EventExecutionContext context, String arg1) throws Exception {
		Map<String, String> map = new HashMap<>();
		KmReviewMain kmReviewMain = (KmReviewMain) context.getMainModel();
		if (kmReviewMain != null) {
			String fdId = kmReviewMain.getFdId();
			map.put("fdId", fdId);
			if (fdId != null) {
				String state = "30";// 废弃状态
				map.put("fdState", state);
				geesunLeaveAdjustDao.upAdjustState(map);
			}
		}
	}
}