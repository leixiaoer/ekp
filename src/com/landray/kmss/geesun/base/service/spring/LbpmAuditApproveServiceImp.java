package com.landray.kmss.geesun.base.service.spring;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.base.service.ILbpmAuditApproveService;
import com.landray.kmss.sys.authentication.background.IBackgroundAuthService;
import com.landray.kmss.sys.config.dict.SysDataDict;
import com.landray.kmss.sys.config.dict.SysDictModel;
import com.landray.kmss.sys.lbpm.engine.builder.ProcessInstance;
import com.landray.kmss.sys.lbpm.engine.persistence.AccessManager;
import com.landray.kmss.sys.lbpm.engine.persistence.model.LbpmProcess;
import com.landray.kmss.sys.lbpm.engine.persistence.model.LbpmWorkitem;
import com.landray.kmss.sys.lbpmservice.support.service.ILbpmProcessService;
import com.landray.kmss.sys.lbpmservice.util.SysLbpmUtil;
import com.landray.kmss.sys.lbpmservice.webservice.LbpmParameterInitializer;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.workflow.interfaces.ISysWfMainForm;
import com.landray.kmss.sys.workflow.webservice.DefaultStartParameter;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.Runner;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 自动审批通过
 * @author guoyp
 */
public class LbpmAuditApproveServiceImp implements ILbpmAuditApproveService {

	protected IBackgroundAuthService backgroundAuthService;

	public void setBackgroundAuthService(
			IBackgroundAuthService backgroundAuthService) {
		this.backgroundAuthService = backgroundAuthService;
	}

	protected AccessManager accessManager;

	public void setAccessManager(AccessManager accessManager) {
		this.accessManager = accessManager;
	}

	protected ILbpmProcessService lbpmProcessService;

	public void setLbpmProcessService(ILbpmProcessService lbpmProcessService) {
		this.lbpmProcessService = lbpmProcessService;
	}

	protected ISysOrgCoreService sysOrgCoreService;

	public void setSysOrgCoreService(ISysOrgCoreService sysOrgCoreService) {
		this.sysOrgCoreService = sysOrgCoreService;
	}

	protected ISysOrgElementService sysOrgElementService;

	public void setSysOrgElementService(
			ISysOrgElementService sysOrgElementService) {
		this.sysOrgElementService = sysOrgElementService;
	}
	
	/**
	 * 审批通过
	 * @param fdProcessId
	 * @return
	 * @throws Exception
	 */
	public void updateBatchApprove(String fdProcessId, final String auditNote) throws Exception {
		LbpmProcess lbpmProcess = accessManager.get(LbpmProcess.class,
				fdProcessId);
		if (ProcessInstance.COMPLETED.equals(lbpmProcess.getFdStatus())) {
			return;
		}
		IBaseModel mainModel = accessManager.findFirst(
				"from " + lbpmProcess.getFdModelName() + " where fdId=?",
				fdProcessId);

		SysDictModel dictModel = SysDataDict.getInstance().getModel(
				lbpmProcess.getFdModelName());

		if (dictModel == null)
			return;
		IBaseService service = (IBaseService) SpringBeanUtil.getBean(dictModel
				.getServiceBean());
		final IExtendForm form = service.convertModelToForm(null, mainModel,
				new RequestContext());

		List<LbpmWorkitem> itemList = lbpmProcess.getFdWorkitems();
		if (ArrayUtil.isEmpty(itemList))
			return;
		List ids = new ArrayList();
		List personIds = new ArrayList();
		String backUserId=null;
		String[] expecterArray = new String[itemList.size()];
		for (int i = 0; i < itemList.size(); i ++) {
			LbpmWorkitem workitem = itemList.get(i);
			SysOrgElement sysOrgElement = (SysOrgElement) workitem.getFdExpecter();
			if (null != sysOrgElement && sysOrgElement.getFdIsAvailable())
				ids.add((sysOrgElement));
		}
		personIds = sysOrgCoreService.expandToPersonIds(ids);
		String currentUserId = UserUtil.getUser().getFdId();
		if (ArrayUtil.isEmpty(personIds) || !personIds.contains(currentUserId)){
			//后台定时任务操作废弃，传递工作项处理人
			SysOrgElement sysOrgElement = (SysOrgElement) sysOrgElementService
					.findByPrimaryKey(itemList.get(0).getFdExpecter().getFdId());
			if (null != sysOrgElement && sysOrgElement.getFdIsAvailable())
				ids.add((sysOrgElement));
			personIds = sysOrgCoreService.expandToPersonIds(ids);
			backUserId=(String) personIds.get(0);
		}else{
			//当是用户操作废弃，传递当前用户ID
			backUserId=currentUserId;
		}
		backgroundAuthService.switchUserById(backUserId,
				new Runner() {

					public Object run(Object parameter) throws Exception {
						DefaultStartParameter param = new DefaultStartParameter();
						param.setAuditNode(auditNote);
						ISysWfMainForm wfForm = (ISysWfMainForm) form;
						LbpmParameterInitializer.initialize(wfForm, param);
						String parameterJson = SysLbpmUtil.getSysWfBusinessForm(wfForm).getFdParameterJson();
//						if("废弃".equals(auditNote)||"系统自动废弃".equals(auditNote)){
//							parameterJson = parameterJson.replace("handler_pass", "handler_abandon");
//							JSONObject json = JSONObject.fromObject(parameterJson);
//							JSONObject newJson = json.getJSONObject("param");
//							newJson.put("notifyOnFinish", false);
//							json.put("param", newJson);
//							SysLbpmUtil.getSysWfBusinessForm(wfForm).setFdParameterJson(json.toString());
//						} else {
							JSONObject json = JSONObject.fromObject(parameterJson);
							JSONObject newJson = json.getJSONObject("param");
							newJson.put("notifyOnFinish", false);
							json.put("param", newJson);
							SysLbpmUtil.getSysWfBusinessForm(wfForm).setFdParameterJson(json.toString());
//						}
						
						// 提交流程
						lbpmProcessService.updateByPanel(wfForm
								.getSysWfBusinessForm());
						return null;
					}
				}, null);
	}

}
