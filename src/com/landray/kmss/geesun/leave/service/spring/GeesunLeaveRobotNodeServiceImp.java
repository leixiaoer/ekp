package com.landray.kmss.geesun.leave.service.spring;

import java.util.Map;

import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveTakeWorkingService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.metadata.model.ExtendDataModelInfo;
import com.landray.kmss.sys.workflow.engine.INodeServiceActionResult;
import com.landray.kmss.sys.workflow.engine.WorkflowEngineContext;
import com.landray.kmss.sys.workflow.engine.spi.model.SysWfNode;
import com.landray.kmss.sys.workflow.support.oa.robot.support.AbstractRobotNodeServiceImp;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunLeaveRobotNodeServiceImp extends AbstractRobotNodeServiceImp {

	private GeesunLeaveRobotNodeServiceImp geesunLeaveRobotNodeServiceImpl;
	private IGeesunLeaveTakeWorkingService geesunLeaveAddTakeWorkingService = new GeesunLeaveTakeWorkingServiceImp();

	public GeesunLeaveRobotNodeServiceImp getSsdzSapMainService() {
		if (null == geesunLeaveRobotNodeServiceImpl) {
			geesunLeaveRobotNodeServiceImpl = (GeesunLeaveRobotNodeServiceImp) SpringBeanUtil
					.getBean("GeesunLeaveRobotNodeServiceImpl");
		}
		return geesunLeaveRobotNodeServiceImpl;
	}

	@Override
	public INodeServiceActionResult execute(WorkflowEngineContext context, SysWfNode node) throws Exception {
		// 获取模板model
		IBaseModel model = context.getMainModel();
		// 如果是流程管理类(model存在于KmReviewMain[流程管理类]中)
		if (model instanceof KmReviewMain) {
			KmReviewMain kmReviewMain = (KmReviewMain) model;
			if (null != kmReviewMain && kmReviewMain.getFdUseForm()) {
				ExtendDataModelInfo data = kmReviewMain.getExtendDataModelInfo();
				// 自定义表单内容,获取提交的表单的属性信息
				Map<String, Object> map = data.getModelData();
				geesunLeaveAddTakeWorkingService.addTakeWorking(map, kmReviewMain); // 增加调休申请记录信息修改调休额度
			}
		}
		return getDefaultActionResult(context, node);
	}

}
