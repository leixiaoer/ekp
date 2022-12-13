package com.landray.kmss.geesun.ehr.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveRepairKaoqinDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveRepairKaoqinDaoImpl;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunHolidayLeaveAction extends ExtendAction {

	@Override
	protected IBaseService getServiceImp(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	//查询假期额度
	public ActionForward checkLeaveIsEnough(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
//		String userId = request.getParameter("userId"); // 申请用户ID
//		String date = request.getParameter("date").substring(0, 7); // 申请时间
		System.out.println("校验假期额度");
		
		//记得获取相同假期未结束的额度进行相扣减
		
//		JSONObject jsonObject = new JSONObject();
//		jsonObject.put("count", count);
//		response.setCharacterEncoding("UTF-8");
//		response.setHeader("Content-type", "text/json;charset=UTF-8");
//		response.getWriter().write(jsonObject.toString());
		return null;
	}
}
