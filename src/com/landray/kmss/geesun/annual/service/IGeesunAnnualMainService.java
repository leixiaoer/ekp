package com.landray.kmss.geesun.annual.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.geesun.annual.forms.GeesunAnnualMainForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.util.GeesunImportMessage;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IGeesunAnnualMainService extends IExtendDataService {
	
	/**
	 * @author guoyp
	 * 校验保存导入信息
	 * @param mainForm
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public List<GeesunImportMessage> saveImport(GeesunAnnualMainForm 
			mainForm, HttpServletRequest request) throws Exception;
	
	/**
	 * 导出员工年假信息列表
	 * @param ids
	 * @param response
	 * @throws Exception
	 */
	public void exportAnnuals(List<GeesunAnnualMain> annualList, 
			HttpServletResponse response) throws Exception;
	
	/**
	 * 根据申请人获取其年假
	 * @param fdOwnerId
	 * @return
	 * @throws Exception
	 */
	public GeesunAnnualMain getAnnualByApplyer(String 
			fdOwnerId) throws Exception;
	
	/**
	 * 更新员工年假数据定时任务
	 * @param context
	 * @throws Exception
	 */
	public void updateResetAnnual(SysQuartzJobContext context) throws Exception;
	
	/**
	 * 定时检测执行失败的重置日志并重新执行重置年假任务
	 * @param context
	 * @throws Exception
	 */
	public void checkErrorResetLogQuartz(SysQuartzJobContext context) throws Exception;
	
	/**
	 * 更新表单字段数据
	 * @param kmReviewMain
	 * @param type
	 * @param fieldId
	 * @param fieldValue
	 * @throws Exception
	 */
	public void updateReviewInfo(KmReviewMain 
			kmReviewMain, String type, String fieldId, String fieldValue) throws Exception;
	
}
