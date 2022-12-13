package com.landray.kmss.geesun.annual.actions;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualMainForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualAlterService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualMainService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualUseService;
import com.landray.kmss.geesun.annual.util.CalculateUtil;
import com.landray.kmss.geesun.annual.util.GeesunImportMessage;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.sys.organization.service.ISysOrgPersonService;
import com.landray.kmss.sys.time.interfaces.ISysTimeCountService;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunAnnualMainAction extends ExtendAction {
	
	private static final Log logger = LogFactory.getLog(GeesunAnnualMainAction.class);

    private IGeesunAnnualMainService geesunAnnualMainService;

    public IGeesunAnnualMainService getServiceImp(HttpServletRequest request) {
        if (geesunAnnualMainService == null) {
            geesunAnnualMainService = (IGeesunAnnualMainService) getBean("geesunAnnualMainService");
        }
        return geesunAnnualMainService;
    }
    
    private ISysOrgPersonService sysOrgPersonService;
    
    public ISysOrgPersonService getSysOrgPersonService() {
        if (sysOrgPersonService == null)
            sysOrgPersonService = (ISysOrgPersonService) getBean("sysOrgPersonService");
        return sysOrgPersonService;
    }
    
    private IGeesunAnnualAlterService geesunAnnualAlterService;
    
    public IGeesunAnnualAlterService getGeesunAnnualAlterService() {
        if (geesunAnnualAlterService == null)
        	geesunAnnualAlterService = (IGeesunAnnualAlterService) getBean("geesunAnnualAlterService");
        return geesunAnnualAlterService;
    }
    
    private IGeesunAnnualUseService geesunAnnualUseService;
    
    public IGeesunAnnualUseService getGeesunAnnualUseService() {
        if (geesunAnnualUseService == null)
        	geesunAnnualUseService = (IGeesunAnnualUseService) getBean("geesunAnnualUseService");
        return geesunAnnualUseService;
    }
    
    /**
     * 工时计算bean
     */
    protected ISysTimeCountService sysTimeCountService;
    
    public ISysTimeCountService getSysTimeCountService() {
    	if (null == sysTimeCountService) {
			sysTimeCountService = (ISysTimeCountService) getBean("sysTimeCountService");;
    	}
    	return sysTimeCountService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunAnnualMain.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.annual.util.GeesunAnnualUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.annual.model.GeesunAnnualMain.class);
        com.landray.kmss.geesun.annual.util.GeesunAnnualUtil.buildHqlInfoModel(hqlInfo, request);
        String where = hqlInfo.getWhereBlock();
        if (!UserUtil.checkRole("ROLE_GEESUNANNUAL_ADMIN")) {
			where = StringUtil.linkString(where, " and ",
					" geesunAnnualMain.fdOwner.fdId=:fdOwnerId");
			hqlInfo.setParameter("fdOwnerId", UserUtil.getUser().getFdId());
		}
        hqlInfo.setWhereBlock(where);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunAnnualMainForm geesunAnnualMainForm = (GeesunAnnualMainForm) super.createNewForm(mapping, form, request, response);
        ((IGeesunAnnualMainService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(request));
        return geesunAnnualMainForm;
    }
    
    /**
	 * @author guoyp
	 * 下载子项导入模板
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward downloadTableImport(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-downloadTableImport", true, getClass());
		KmssMessages messages = new KmssMessages();
		String fdName = "import.xls";
		String path = request.getSession().getServletContext().getRealPath("/");
		String filePath = path + "/geesun/annual/geesun_annual_main/" + fdName;
		InputStream is = new FileInputStream(new File(filePath));
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		// 模板文件名
		response.reset();
		response.setHeader("Content-disposition", "attachment; filename=\"" + new String(fdName.getBytes("GB2312"), "ISO-8859-1") + "\"");
		response.setContentType("application/x-msdownload");
		try {
			bis = new BufferedInputStream(is);
			bos = new BufferedOutputStream(response.getOutputStream());
			// 缓冲区
			byte[] buff = new byte[20480];
			// 遍历，开始下载模板
			while ((bis.read(buff, 0, buff.length)) != -1) {
				bos.write(buff, 0, buff.length);
			}
			bos.flush();
		} catch (Exception e) {
			messages.addError(e);
		} finally {
			IOUtils.closeQuietly(is);
			IOUtils.closeQuietly(bos);
			IOUtils.closeQuietly(bis);
		}
		TimeCounter.logCurrentTime("Action-downloadTableImport", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return null;
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_RETURN).save(request);
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return null;
		}
	}
    
    /**
	 * @author guoyp
	 * Excel导入年假额度信息内容
	 */
	public ActionForward importExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-importExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			GeesunAnnualMainForm mainForm = (GeesunAnnualMainForm) form;
			List<GeesunImportMessage> messageList = getServiceImp(request)
					.saveImport(mainForm, request);
			request.setAttribute("messageList", messageList);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("result", mapping, form, request, response);
		}
	}
	
	@Override
	protected void loadActionForm(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		form.reset(mapping, request);
		IExtendForm rtnForm = null;
		GeesunAnnualMain geesunAnnualMain = null;
		String id = request.getParameter("fdId");
		if (!StringUtil.isNull(id)) {
			geesunAnnualMain = (GeesunAnnualMain)getServiceImp(request).findByPrimaryKey(id,
					GeesunAnnualMain.class, true);
			if (geesunAnnualMain != null)
				rtnForm = getServiceImp(request).convertModelToForm(
						(IExtendForm) form, geesunAnnualMain, new RequestContext(request));
		}
		if (rtnForm == null) {
			throw new NoRecordException();
		} else {
			int alterRecordNum = getGeesunAnnualAlterService().getAlterRecordInfoCount(id, GeesunAnnualMain.class.getName());
			if (alterRecordNum > 0) {
				request.setAttribute("alterRecordInfoCount", "(" + String.valueOf(alterRecordNum) + ")");
			}
			int usingRecordNum = getGeesunAnnualUseService().getNumByAnnual(request);
			if (usingRecordNum > 0) {
				request.setAttribute("usingRecordInfoCount", "(" + String.valueOf(usingRecordNum) + ")");
			}
			int usedRecordNum = getGeesunAnnualUseService().getNumByAnnual(request);
			if (usedRecordNum > 0) {
				request.setAttribute("usedRecordInfoCount", "(" + String.valueOf(usedRecordNum) + ")");
			}
			int resumeRecordNum = getGeesunAnnualUseService().getNumByAnnual(request);
			if (resumeRecordNum > 0) {
				request.setAttribute("resumeRecordInfoCount", "(" + String.valueOf(resumeRecordNum) + ")");
			}
			java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
			Double fdTotal = (null!=geesunAnnualMain.getFdTotal()?geesunAnnualMain.getFdTotal():0.0);
			Double fdLastTotal = (null!=geesunAnnualMain.getFdLastTotal()?geesunAnnualMain.getFdLastTotal():0.0);
			Double fdUsing = getGeesunAnnualUseService().getYearLeaveDayAuditingByPerson(null, "frozen", false, geesunAnnualMain);
			Double fdUsed = getGeesunAnnualUseService().getYearLeaveDayAuditingByPerson(null, "", false, geesunAnnualMain);
			Double fdLastUsing = getGeesunAnnualUseService().getYearLeaveDayAuditingByPerson(null, "frozen", true, geesunAnnualMain);
			Double fdLastUsed = getGeesunAnnualUseService().getYearLeaveDayAuditingByPerson(null, "", true, geesunAnnualMain);
			Double fdRemain = CalculateUtil.sub(fdTotal, CalculateUtil.sum(fdUsing, fdUsed));
			Double fdLastRemain = CalculateUtil.sub(fdLastTotal, CalculateUtil.sum(fdLastUsing, fdLastUsed));
			((GeesunAnnualMainForm) form).setFdLastTotal(fdLastTotal.toString());
			((GeesunAnnualMainForm) form).setFdFrozen(fdUsing.toString());
			((GeesunAnnualMainForm) form).setFdUsed(fdUsed.toString());
			((GeesunAnnualMainForm) form).setFdRemain(fdRemain.toString());
			((GeesunAnnualMainForm) form).setFdLastFrozen(fdLastUsing.toString());
			((GeesunAnnualMainForm) form).setFdLastUsed(fdLastUsed.toString());
			((GeesunAnnualMainForm) form).setFdLastRemain(fdLastRemain.toString());
		}
		request.setAttribute(getFormName(rtnForm, request), rtnForm);
	}
	
	/**
	 * 导出人员额度信息，方便导入
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward exportAnnuals(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-exportAnnuals", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			List<GeesunAnnualMain> employeeList = new ArrayList<GeesunAnnualMain>();
			String fdIds = request.getParameter("selectIds");
			if (StringUtil.isNotNull(fdIds)) {
				employeeList = getServiceImp(request).findByPrimaryKeys(fdIds.split(";"));
			} else {
				HQLInfo hqlInfo = new HQLInfo();
				changeFindPageHQLInfo(request, hqlInfo);
				employeeList = getServiceImp(request).findList(hqlInfo);
			}
			getServiceImp(request).exportAnnuals(employeeList, response);
		} catch (Exception e) {
			messages.addError(e);
		}
		return null;
	}
	
	/**
     * 根据员工排班、开始和结束时间计算该时间区间内的工作时间
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ActionForward calculateWorkDays(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        TimeCounter.logCurrentTime("Action-calculateWorkDays", true, getClass());
        JSONObject result = new JSONObject();
        float leaveDays = 0;
        try {
            String fdStartTime = request.getParameter("fdStartTime");
            String fdEndTime = request.getParameter("fdEndTime");
            String docCreatorId = request.getParameter("docCreatorId");            
            if (StringUtil.isNotNull(docCreatorId)) {
            	long workTime = getSysTimeCountService().getManHour(docCreatorId, 
            			DateUtil.convertStringToDate(fdStartTime, "yyyy-MM-dd HH:mm").getTime(), 
            			DateUtil.convertStringToDate(fdEndTime, "yyyy-MM-dd HH:mm").getTime());
            	if (workTime > 0) {
            		
            	}
            }
            result.put("leaveDays", leaveDays);
            result.put("status", Integer.valueOf(1));
            request.setAttribute("lui-source", result);
        } catch(Exception e) {
            result.put("status", Integer.valueOf(0));
            e.printStackTrace();
            request.setAttribute("lui-source", result);
        }
        return mapping.findForward("lui-source");
    }
    
    protected IKmReviewMainService kmReviewMainService;
	
	public IKmReviewMainService getKmReviewMainService() {
		if (null == kmReviewMainService) {
			kmReviewMainService = (IKmReviewMainService) getBean("kmReviewMainService");
		}
		return kmReviewMainService;
	}
    
    /**
	 * 更新单据表单数据
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward updateReviewInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		TimeCounter.logCurrentTime("Action-updateReviewInfo", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String reviewId = request.getParameter("reviewId");
			KmReviewMain kmReviewMain = (KmReviewMain) getKmReviewMainService().findByPrimaryKey(reviewId.trim(), KmReviewMain.class, true);
			if (null != kmReviewMain) {
				String type = request.getParameter("type");
				String fieldId = request.getParameter("fieldId");
				String fieldValue = request.getParameter("fieldValue");
				getServiceImp(request).updateReviewInfo(kmReviewMain, type, fieldId, fieldValue);
			}
		} catch (Exception e) {
			messages.addError(e);
			logger.error("更新单据表单数据报错:", e);
		}
		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-updateReviewInfo", false, getClass());
		if (messages.hasError()) {
			return getActionForward("failure", mapping, form, request,
					response);
		} else {
			return getActionForward("success", mapping, form, request, response);
		}
	}
    
}
