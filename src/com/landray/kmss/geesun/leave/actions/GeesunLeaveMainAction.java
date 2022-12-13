package com.landray.kmss.geesun.leave.actions;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.landray.kmss.geesun.leave.model.GeesunLeaveMain;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveInfoDao;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveMappingFormDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveInfoDaoImpl;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveMappingFormDaoImpl;
import com.landray.kmss.geesun.leave.forms.GeesunLeaveMainForm;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.leave.service.IClockingInDateService;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveMainService;
import com.landray.kmss.geesun.leave.service.spring.ClockingInDateServiceImp;
import com.landray.kmss.geesun.leave.util.GeesunImportMessage;
import com.landray.kmss.geesun.leave.util.GeesunLeaveJudgeSatUtil;
import com.landray.kmss.geesun.leave.util.GeesunLeaveLastDayUtil;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.IOUtils;

import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunLeaveMainAction extends ExtendAction {

	private IGeesunLeaveMainService geesunLeaveMainService;
	private IGeesunLeaveMappingFormDao geesunLeaveMappingFormDao = new GeesunLeaveMappingFormDaoImpl();
	private IClockingInDateService clockingInDateService = new ClockingInDateServiceImp();
	private IGeesunLeaveInfoDao geesunLeaveInfoDao = new GeesunLeaveInfoDaoImpl();
	public static Double sumDouble;

	public IGeesunLeaveMainService getServiceImp(HttpServletRequest request) {
		if (geesunLeaveMainService == null) {
			geesunLeaveMainService = (IGeesunLeaveMainService) getBean("geesunLeaveMainService");
		}
		return geesunLeaveMainService;
	}

	public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
		HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunLeaveMain.class);
		hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
		com.landray.kmss.geesun.leave.util.GeesunLeaveUtil.buildHqlInfoDate(hqlInfo, request,
				com.landray.kmss.geesun.leave.model.GeesunLeaveMain.class);
		com.landray.kmss.geesun.leave.util.GeesunLeaveUtil.buildHqlInfoModel(hqlInfo, request);
	}

	public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		GeesunLeaveMainForm geesunLeaveMainForm = (GeesunLeaveMainForm) super.createNewForm(mapping, form, request,
				response);
		((IGeesunLeaveMainService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(
				request));
		return geesunLeaveMainForm;
	}

	/**
	 * @author zhazh Excel导入调休额度信息内容
	 */
	public ActionForward importExcel(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-importExcel", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String post = "POST";
			if (!request.getMethod().equals(post))
				throw new UnexpectedRequestException();
			GeesunLeaveMainForm mainForm = (GeesunLeaveMainForm) form;
			List<GeesunImportMessage> messageList = getServiceImp(request).saveImport(mainForm, request);
			request.setAttribute("messageList", messageList);
		} catch (Exception e) {
			messages.addError(e);
		}
		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return getActionForward("result", mapping, form, request, response);
		}
	}

	/**
	 * 下载子项导入模板
	 * 
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
		String filePath = path + "/geesun/leave/geesun_leave_main/" + fdName;
		InputStream is = new FileInputStream(new File(filePath));
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		// 模板文件名
		response.reset();
		response.setHeader("Content-disposition", "attachment; filename=\""
				+ new String(fdName.getBytes("GB2312"), "ISO-8859-1") + "\"");
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
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return null;
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_RETURN)
					.save(request);
			KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE)
					.save(request);
			return null;
		}
	}

	/**
	 * 获取指定用户的剩余调休时数
	 */
	public ActionForm getHour(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {
		JSONObject json = new JSONObject();
		String userId = request.getParameter("userId"); // 用户ID
		String year = new SimpleDateFormat("yyyy").format(new Date()).toString();// 当前年份
		Map<String, String> leaveInfo = geesunLeaveInfoDao.getUserLeave(userId, year);
		if (leaveInfo.size() == 0) {
			json.put("hour", "0");
		} else {
			json.put("hour", leaveInfo.get("surplusLeave"));
		}
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-type", "text/json;charset=UTF-8");
		response.getWriter().write(json.toString());
		return null;
	}

	/**
	 * 
	 * 获取有效的调休时间(0.5小时为单位)
	 * 
	 */
	public ActionForm getLeaveTime(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {
		JSONObject json = new JSONObject();
		String startTime = request.getParameter("startTime"); // 调休开始时间
		String endTime = request.getParameter("endTime"); // 调休结束时间
		String userId = request.getParameter("userId"); // 调休申请人ID
		Double overTime = Double.parseDouble(clockingInDateService.isRestDay(startTime, endTime, userId) + "");// 工作时长(毫秒值)
		Double hour = overTime / Double.parseDouble((60 * 60 * 1000) + "");// 工作时长(小时)
		hour = getHour(hour); // 获取标准的0.5小时单位的时长

		Double greezeHour = geesunLeaveMappingFormDao.getFreezeHour(userId);// 被冻结的调休额度

		String year = new SimpleDateFormat("yyyy").format(new Date()).toString();// 当前年份
		Map<String, String> map = geesunLeaveInfoDao.getUserLeave(userId, year); // 获取指定用户和年份的剩余调休信息
		if (map.size() == 0) {
			json.put("leaveTimeHour", "0");
			json.put("boo", "false");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-type", "text/json;charset=UTF-8");
			response.getWriter().write(json.toString());
			return null;
		}
		Double suplusHour = Double.parseDouble(map.get("surplusLeave"));// 数据库中剩余的调休额度

		if ((suplusHour - hour - greezeHour) < 0) { // 数据库剩余时数减去冻结时数减去申请调休时数,小于0不允许提交
			json.put("boo", "false");
		} else {
			json.put("boo", hour);
		}
		json.put("leaveTimeHour", hour);
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-type", "text/json;charset=UTF-8");
		response.getWriter().write(json.toString());
		return null;
	}

	/**
	 * 
	 * 判断调休的时间是否符合规则
	 * 
	 */
	public ActionForm judgeSat(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {
		JSONObject json = new JSONObject();
		String startTime = request.getParameter("startTime"); // 调休开始时间
		String endTime = request.getParameter("endTime"); // 调休结束时间
		String userId = request.getParameter("userId"); // 申请人ID
		String start = startTime.substring(0, 10);
		String end = endTime.substring(0, 10);

		Double takeHour = Double.parseDouble(clockingInDateService.isRestDay(startTime, endTime, userId) + "");
		if (takeHour == 0) {
			json.put("startTime", "非工作时间");
			json.put("endTime", "非工作时间");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-type", "text/json;charset=UTF-8");
			response.getWriter().write(json.toString());
			return null;
		}

		Boolean startBoo = GeesunLeaveJudgeSatUtil.calLeaveDays(start); // 获取开始时间是否为周六(boolean类型)
		if (start.equals(end)) { // 如果开始时间和结束时间为同一天
			Double overTime = Double.parseDouble(clockingInDateService.isRestDay(startTime, endTime, userId) + "");
			Double hour = (overTime / Double.parseDouble((60 * 60 * 1000) + "")); // 获取的调休时长(工作时长)
			if (startBoo == true && hour >= 2.5) { // 结束和开始时间都为周六
				json.put("startTime", startTime);
				json.put("endTime", endTime);
			} else if (startBoo == true && hour < 2.5) {
				json.put("startTime", "");
				json.put("endTime", "星期六小于2.5");
			} else if (startBoo == false && hour >= 1) {
				json.put("startTime", startTime);
				json.put("endTime", endTime);
			} else if (startBoo == false && hour < 1) {
				json.put("startTime", "");
				json.put("endTime", "工作日小于1");
			}
		} else { // 开始时间和结束时间不为同一天
			DateControls(json, startTime, endTime, userId);
		}

		Map<String, String> strMap = new HashMap<>();
		String dateS = startTime.substring(0, 7); // 开始时间
		String dateE = endTime.substring(0, 7); // 结束时间
		if (dateS.equals(dateE)) { // 开始时间和结束时间为同一月份
			Double infoHour = judge(startTime, endTime, userId, takeHour, strMap, dateS, dateE);
			if (infoHour > 16) {
				json.put("startTime", "超出规定时间范围");
				json.put("endTime", "超出规定时间范围");
				response.setCharacterEncoding("UTF-8");
				response.setHeader("Content-type", "text/json;charset=UTF-8");
				response.getWriter().write(json.toString());
				return null;
			}
		} else {// 调休开始结束时间不为同一月份
			// 先计算开始时间
			strMap.put("userId", userId);
			strMap.put("year", startTime.substring(0, 4));
			strMap.put("startMonth", startTime.substring(5, 7));
			strMap.put("endMonth", startTime.substring(5, 7));
			String eTime = GeesunLeaveLastDayUtil.getMonthLast(startTime); // 临时的结束时间
			Double staDouble = Double.parseDouble(clockingInDateService.isRestDay(startTime, eTime, userId) + "");
			Double sInfoHour = staDouble / Double.parseDouble((60 * 60 * 1000) + "");// 工作时长(小时)
			JSONArray infoJson = geesunLeaveMappingFormDao.getFreezeDate(strMap); // 获取列表
			for (int i = 0; i < infoJson.size(); i++) {
				JSONObject jsonObj = (JSONObject) infoJson.get(i);
				String infoStart = jsonObj.get("startTime").toString().substring(0, 7); // 已使用的开始时间信息
				String infoEnd = jsonObj.get("endTime").toString().substring(0, 7); // 已使用的结束时间信息
				if (infoStart.equals(infoEnd)) {
					sInfoHour += Double.parseDouble(jsonObj.get("hour").toString());
					continue;
				}
				Double overTime = 0.0;
				if (dateS.equals(infoStart)) { // 调休开始时间和开始时间信息
					overTime = Double.parseDouble(clockingInDateService.isRestDay(jsonObj.get("startTime").toString()
							.substring(0, 15), eTime, userId)
							+ "");
				} else if (dateE.equals(infoEnd)) {
					String sTime = GeesunLeaveLastDayUtil.getMonthStart(endTime); // 临时的开始时间
					overTime = Double.parseDouble(clockingInDateService.isRestDay(sTime, jsonObj.get("endTime")
							.toString().substring(0, 15), userId)
							+ "");
				}
				Double hour = (overTime / Double.parseDouble((60 * 60 * 1000) + "")); // 获取的调休时长(工作时长)
				sInfoHour += hour;
			}
			if (sInfoHour > 16) {
				json.put("startTime", "超出规定时间范围");
				json.put("endTime", "超出规定时间范围");
				response.setCharacterEncoding("UTF-8");
				response.setHeader("Content-type", "text/json;charset=UTF-8");
				response.getWriter().write(json.toString());
				return null;
			}

			// 计算结束时间
			Double eInfoHour = endTimeJudge(startTime, endTime, userId, strMap, dateS, dateE, eTime);
			if (eInfoHour > 16) {
				json.put("startTime", "超出规定时间范围");
				json.put("endTime", "超出规定时间范围");
				response.setCharacterEncoding("UTF-8");
				response.setHeader("Content-type", "text/json;charset=UTF-8");
				response.getWriter().write(json.toString());
				return null;
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-type", "text/json;charset=UTF-8");
		response.getWriter().write(json.toString());
		return null;
	}

	private void DateControls(JSONObject json, String startTime, String endTime, String userId) {
		String startDay = GeesunLeaveJudgeSatUtil.getLastDay(startTime, true); // 获取开始时间的后一天的时间
		Double startOverTime = Double.parseDouble(clockingInDateService.isRestDay(startTime, startDay, userId) + "");
		Double startHour = (startOverTime / Double.parseDouble((60 * 60 * 1000) + "")); // 获取开始时间的调休时长(工作时长)
		if (startHour > 0) {
			String startD = GeesunLeaveJudgeSatUtil.getLastDay(startTime, false); // 获取开始时间当天的时间
			Double sOverTime = Double.parseDouble(clockingInDateService.isRestDay(startD, startDay, userId) + "");
			Double sHour = (sOverTime / Double.parseDouble((60 * 60 * 1000) + "")); // 获取开始当天的调休时长(工作时长)
			if (sHour > 2.5) { // 结束时间当天是整天工作日
				if (startHour >= 1) {
					json.put("startTime", startTime);
				} else {
					json.put("startTime", "工作日小于1");
				}
			} else if ("2.5".equals(sHour.toString())) { // 结束时间使用5.5用户的周六
				if (startHour < 2.5) {
					json.put("startTime", "星期六小于2.5");
				} else {
					json.put("startTime", startTime);
				}
			} else {
				json.put("startTime", startTime);
			}
		} else {
			json.put("startTime", startTime);
		}

		String endD = GeesunLeaveJudgeSatUtil.getLastDay(endTime, false); // 获取结束时间当天的时间
		Double endOverTime = Double.parseDouble(clockingInDateService.isRestDay(endD, endTime, userId) + "");
		Double endHour = (endOverTime / Double.parseDouble((60 * 60 * 1000) + "")); // 获取结束时间的调休时长(工作时长)
		if (endHour > 0) {
			String endDay = GeesunLeaveJudgeSatUtil.getLastDay(endTime, true); // 获取结束时间后一天的时间
			Double eOverTime = Double.parseDouble(clockingInDateService.isRestDay(endD, endDay, userId) + "");
			Double eHour = (eOverTime / Double.parseDouble((60 * 60 * 1000) + "")); // 获取结束当天的调休时长(工作时长)
			if (eHour > 2.5) { // 结束时间当天是整天工作日
				if (endHour >= 1) {
					json.put("endTime", endTime);
				} else {
					json.put("endTime", "工作日小于1");
				}
			} else if ("2.5".equals(eHour.toString())) { // 结束时间使用5.5用户的周六
				if (endHour < 2.5) {
					json.put("endTime", "星期六小于2.5");
				} else {
					json.put("endTime", endTime);
				}
			} else {
				json.put("endTime", endTime);
			}
		} else {
			json.put("endTime", endTime);
		}
	}

	// 计算结束时间
	private Double endTimeJudge(String startTime, String endTime, String userId, Map<String, String> strMap,
			String dateS, String dateE, String eTime) throws ParseException {
		JSONArray infoJson;
		strMap.put("userId", userId);
		strMap.put("year", endTime.substring(0, 4));
		strMap.put("startMonth", endTime.substring(5, 7));
		strMap.put("endMonth", endTime.substring(5, 7));
		Double endDouble = Double.parseDouble(clockingInDateService.isRestDay(eTime, endTime, userId) + "");
		Double eInfoHour = endDouble / Double.parseDouble((60 * 60 * 1000) + "");// 工作时长(小时)
		infoJson = geesunLeaveMappingFormDao.getFreezeDate(strMap); // 获取列表
		for (int i = 0; i < infoJson.size(); i++) {
			JSONObject jsonObj = (JSONObject) infoJson.get(i);
			String infoStart = jsonObj.get("startTime").toString().substring(0, 7); // 已使用的开始时间信息
			String infoEnd = jsonObj.get("endTime").toString().substring(0, 7); // 已使用的结束时间信息
			if (infoStart.equals(infoEnd)) {
				eInfoHour += Double.parseDouble(jsonObj.get("hour").toString());
				continue;
			}
			Double overTime = 0.0;
			if (dateS.equals(infoStart)) { // 调休开始时间和开始时间信息
				eTime = GeesunLeaveLastDayUtil.getMonthLast(startTime); // 临时的结束时间
				overTime = Double.parseDouble(clockingInDateService.isRestDay(jsonObj.get("startTime").toString()
						.substring(0, 15), eTime, userId)
						+ "");
			} else if (dateE.equals(infoEnd)) {
				String sTime = GeesunLeaveLastDayUtil.getMonthStart(endTime); // 临时的开始时间
				overTime = Double.parseDouble(clockingInDateService.isRestDay(sTime, jsonObj.get("endTime").toString()
						.substring(0, 15), userId)
						+ "");
			}
			Double hour = (overTime / Double.parseDouble((60 * 60 * 1000) + "")); // 获取的调休时长(工作时长)
			eInfoHour += hour;
		}
		return eInfoHour;
	}

	// 调休加班开始结束时间为同一月时判断
	private Double judge(String startTime, String endTime, String userId, Double takeHour, Map<String, String> strMap,
			String dateS, String dateE) throws ParseException {
		strMap.put("userId", userId);
		strMap.put("year", startTime.substring(0, 4));
		strMap.put("startMonth", startTime.substring(5, 7));
		strMap.put("endMonth", endTime.substring(5, 7));
		JSONArray infoJson = geesunLeaveMappingFormDao.getFreezeDate(strMap); // 获取列表
		Double infoHour = (takeHour / Double.parseDouble((60 * 60 * 1000) + "")); // 获取的调休时长(工作时长);
		for (int i = 0; i < infoJson.size(); i++) {
			JSONObject jsonObj = (JSONObject) infoJson.get(i);
			String infoStart = jsonObj.get("startTime").toString().substring(0, 7); // 已使用的开始时间信息
			String infoEnd = jsonObj.get("endTime").toString().substring(0, 7); // 已使用的结束时间信息
			if (infoStart.equals(infoEnd)) {
				infoHour += Double.parseDouble(jsonObj.get("hour").toString());
				continue;
			}
			// 开始时间信息和结束时间信息不为同一月份
			Double overTime = 0.0;
			if (dateS.equals(infoStart)) { // 调休开始时间和开始时间信息
				String eTime = GeesunLeaveLastDayUtil.getMonthLast(startTime); // 临时的结束时间
				overTime = Double.parseDouble(clockingInDateService.isRestDay(jsonObj.get("startTime").toString()
						.substring(0, 15), eTime, userId)
						+ "");
			} else if (dateE.equals(infoEnd)) {
				String sTime = GeesunLeaveLastDayUtil.getMonthStart(endTime); // 临时的开始时间
				overTime = Double.parseDouble(clockingInDateService.isRestDay(sTime, jsonObj.get("endTime").toString()
						.substring(0, 15), userId)
						+ "");
			}
			Double hour = (overTime / Double.parseDouble((60 * 60 * 1000) + "")); // 获取的调休时长(工作时长)
			infoHour += hour;
		}
		return infoHour;
	}

	/**
	 * 
	 * 获取外出小时合计(0.5小时为单位)
	 * 
	 */
	public ActionForm outHour(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {
		JSONObject json = new JSONObject();
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String index = request.getParameter("index");
		if ("0".equals(index)) {
			sumDouble = 0.0;
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Double start = Double.parseDouble(format.parse(startTime).getTime() + "");
		Double end = Double.parseDouble(format.parse(endTime).getTime() + "");
		if (start >= end) {
			json.put("message", "0");
			json.put("sumDouble", sumDouble);
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-type", "text/json;charset=UTF-8");
			response.getWriter().write(json.toString());
			return null;
		}
		Double hour = (end - start) / 3600000;
		Double hours = hour % 1;
		if (hours >= 0.5) {
			hour = hour - (hours - 0.5);
		} else if (hours < 0.5) {
			hour = hour - hours;
		}
		sumDouble += hour;
		json.put("message", hour);
		json.put("sumDouble", sumDouble);
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-type", "text/json;charset=UTF-8");
		response.getWriter().write(json.toString());
		return null;
	}

	// 获取标准的0.5小时的时长
	private Double getHour(Double hour) {
		Double hours = hour % 1;
		if (hours >= 0.5) {
			hour = hour - (hours - 0.5);
		} else if (hours < 0.5) {
			hour = hour - hours;
		}
		if (hour < 0) {
			hour = 0.0;
		}
		return hour;
	}
}