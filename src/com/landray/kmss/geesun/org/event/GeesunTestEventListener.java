package com.landray.kmss.geesun.org.event;

import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.lbpm.engine.manager.event.EventExecutionContext;
import com.landray.kmss.sys.lbpm.engine.manager.event.IEventListener;

public class GeesunTestEventListener implements IEventListener {

	@Override
	public void handleEvent(EventExecutionContext arg0, String arg1) throws Exception {
		// TODO Auto-generated method stub
		IBaseModel model = arg0.getMainModel();
		if (model == null) {
			return;
		}
		KmReviewMain kmReviewMain = (KmReviewMain) model;
		String fdText = (String) kmReviewMain.getExtendDataModelInfo().getModelData().get("fd_3af5233b7c9974");
		System.out.println("进入处理人通过事件，文本1值为：" + fdText);
	}

}
