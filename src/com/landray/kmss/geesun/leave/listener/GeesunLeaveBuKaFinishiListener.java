package com.landray.kmss.geesun.leave.listener;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveRepairKaoqinDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveRepairKaoqinDaoImpl;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;

/**
 * 补录考勤补卡流程结束进进入事件
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveBuKaFinishiListener implements IEventListener {
	private IGeesunLeaveRepairKaoqinDao geesunLeaveRepairKaoqinDao = new GeesunLeaveRepairKaoqinDaoImpl();

	@Override
	public void handleEvent(EventExecutionContext context, String arg1) throws Exception {
		KmReviewMain kmReviewMain = (KmReviewMain) context.getMainModel();
		if(kmReviewMain != null){
			String fdId = kmReviewMain.getFdId();
			if (fdId != null) {
				String state = "20";// 成功通过状态
				geesunLeaveRepairKaoqinDao.upState(fdId, state);
			}
		}
	}
}
