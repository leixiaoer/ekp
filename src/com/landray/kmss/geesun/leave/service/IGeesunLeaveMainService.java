package com.landray.kmss.geesun.leave.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.geesun.leave.forms.GeesunLeaveMainForm;
import com.landray.kmss.geesun.leave.util.GeesunImportMessage;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;

public interface IGeesunLeaveMainService extends IExtendDataService {
	/**
	 * @author guoyp 校验保存导入信息
	 * @param mainForm
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public List<GeesunImportMessage> saveImport(GeesunLeaveMainForm mainForm, HttpServletRequest request)
			throws Exception;
}
