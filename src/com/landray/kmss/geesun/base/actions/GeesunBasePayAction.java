package com.landray.kmss.geesun.base.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.base.forms.GeesunBasePayForm;
import com.landray.kmss.geesun.base.model.GeesunBasePay;
import com.landray.kmss.geesun.base.service.IGeesunBasePayService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunBasePayAction extends ExtendAction {

    private IGeesunBasePayService geesunBasePayService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunBasePayService == null) {
            geesunBasePayService = (IGeesunBasePayService) getBean("geesunBasePayService");
        }
        return geesunBasePayService;
    }
    
    private IKmReviewMainService kmReviewMainService;
    
    public IKmReviewMainService getKmReviewMainService() {
        if (kmReviewMainService == null) {
        	kmReviewMainService = (IKmReviewMainService) getBean("kmReviewMainService");
        }
        return kmReviewMainService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunBasePay.class);
        String whereBlock = hqlInfo.getWhereBlock();
		String mainId = request.getParameter("fdModelId");
		if (StringUtil.isNotNull(mainId)) {
			if (StringUtil.isNull(whereBlock)) {
				whereBlock = " geesunBasePay.fdReview.fdId=:mainId";
			} else {
				whereBlock += " and geesunBasePay.fdReview.fdId=:mainId";
			}
			hqlInfo.setParameter("mainId", mainId);
		}
		hqlInfo.setWhereBlock(whereBlock);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.base.util.GeesunBaseUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.base.model.GeesunBasePay.class);
        com.landray.kmss.geesun.base.util.GeesunBaseUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunBasePayForm geesunBasePayForm = (GeesunBasePayForm) super.createNewForm(mapping, form, request, response);
        ((IGeesunBasePayService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(request));
        return geesunBasePayForm;
    }
    
    public ActionForward listdata(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.list(mapping, form, request, response);
		return mapping.findForward("listdata");
	}
    
    /**
	 * 判断勾选的单据是否已付款
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 */
	public ActionForward checkHasPay(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String canPay = "0";
		String fdReviewId = request.getParameter("fdReviewId");
		boolean flag = checkHasPay(fdReviewId);
		if (flag) {
			canPay = "1";
		}
		KmReviewMain kmReviewMain = (KmReviewMain) getKmReviewMainService().findByPrimaryKey(fdReviewId, KmReviewMain.class, true);
    	if (null != kmReviewMain) {
    		Map<String, Object> mainMap = kmReviewMain.getExtendDataModelInfo().getModelData();
    		//获取明细数据
			List<Map<String, Object>> detailList = (List<Map<String, Object>>) mainMap.get("fd_3957f578d654fe");//报销明细
			if (!ArrayUtil.isEmpty(detailList)) {
				for (Map<String, Object> detail : detailList) {
					String fdCenterId = detail.get("fd_center_id").toString();
					if ("179c23e8d173bd9395c5007473a82dfc".equals(fdCenterId)) {
						canPay = "2";
						break;
					}
				}
			}
    	}
		response.getWriter().print(canPay);
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}
	
	/**
	 * 判断勾选的单据是否已付款
	 * @return
	 * @throws Exception
	 */
	private boolean checkHasPay(String fdReviewId) throws Exception {
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		boolean flag = false;
		String sql = "select count(fd_id) from geesun_base_pay where fd_review_id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, fdReviewId);
			rs = ps.executeQuery();
			if (rs.next() && rs.getLong(1) > 0) {
				flag = true;
			}
		} catch (Exception ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(rs);
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
		return flag;
	}
    
}
