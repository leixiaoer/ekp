package com.landray.kmss.geesun.leave.actions;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.landray.kmss.geesun.leave.model.GeesunLeaveAdjust;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveAdjustDao;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveKaoQinRecordDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveAdjustDaoImp;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveKaoQinRecordDaoImpl;
import com.landray.kmss.geesun.leave.forms.GeesunLeaveAdjustForm;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.leave.service.IClockingInDateService;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveAdjustService;
import com.landray.kmss.geesun.leave.service.spring.ClockingInDateServiceImp;
import com.landray.kmss.geesun.leave.util.GeesunLeaveJudgeSatUtil;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionForm;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunLeaveAdjustAction extends ExtendAction {
	private IGeesunLeaveAdjustService geesunLeaveAdjustService;
	private IGeesunLeaveKaoQinRecordDao geesunLeaveKaoQinRDao = new GeesunLeaveKaoQinRecordDaoImpl();
	private IClockingInDateService clockingInDateService = new ClockingInDateServiceImp();
	private IGeesunLeaveAdjustDao geesunLeaveAdjustDao = new GeesunLeaveAdjustDaoImp();

	public IBaseService getServiceImp(HttpServletRequest request) {
		if (geesunLeaveAdjustService == null) {
			geesunLeaveAdjustService = (IGeesunLeaveAdjustService) getBean("geesunLeaveAdjustService");
		}
		return geesunLeaveAdjustService;
	}

	public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
		HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunLeaveAdjust.class);
		hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
		com.landray.kmss.geesun.leave.util.GeesunLeaveUtil.buildHqlInfoDate(hqlInfo, request,
				com.landray.kmss.geesun.leave.model.GeesunLeaveAdjust.class);
		com.landray.kmss.geesun.leave.util.GeesunLeaveUtil.buildHqlInfoModel(hqlInfo, request);
	}

	public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		GeesunLeaveAdjustForm geesunLeaveAdjustForm = (GeesunLeaveAdjustForm) super.createNewForm(mapping, form,
				request, response);
		((IGeesunLeaveAdjustService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(
				request));
		return geesunLeaveAdjustForm;
	}

	// 判断加班开始时间是否为非工作日（周六末,节假日：结束时间已被限制24小时内）
	public ActionForm judgeWeek(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		JSONObject json = new JSONObject();
		String startTime = request.getParameter("startTime"); // 加班开始日期时间
		String endTime = request.getParameter("endTime"); // 加班结束日期时间
		String userId = request.getParameter("userId"); // 申请人ID
		String fdID = request.getParameter("fdId"); // 流程ID
		String fdNo = UserUtil.getUser(userId).getFdNo(); // 申请人的工号
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		// 第一步:判断时间段是否被使用
		JSONArray jsonArray = geesunLeaveAdjustDao.getDateMessage(userId);
		jsonArray = geesunLeaveAdjustDao.getFreezeMessage(userId, jsonArray);
		if (jsonArray.size() != 0) {
			Long start = format.parse(startTime + ":00").getTime();
			Long end = format.parse(endTime + ":00").getTime();
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject dateJson = (JSONObject) jsonArray.get(i);
				String id = dateJson.get("fdId").toString();//
				if(fdID.equals(id)){
					json.put("overTimeHour", "");
					break;
				}
				Long dateStart = format.parse(dateJson.getString("fdStartTime") + ":00").getTime();
				Long dateEnd = format.parse(dateJson.getString("fdEndTime") + ":00").getTime();
				if (start > dateStart && start < dateEnd) { // 如果请假开始时间大于数据库开始时间并且小于数据库结束时间(表单开始时间重复)
					json.put("overTimeHour", "开始时间重复");
					break;
				} else if (end > dateStart && end < dateEnd) { // 如果请假结束时间大于数据库开始时间并且小于数据库结束时间(表单结束时间重复)
					json.put("overTimeHour", "结束时间重复");
					break;
				} else if (start <= dateStart && end >= dateEnd) {
					json.put("overTimeHour", "时间段已被使用");
					break;
				}
				json.put("overTimeHour", "");
			}
			// 当捕获到重复日期信息时,直接return
			if (json.getString("overTimeHour").length() > 0) {
				response.setCharacterEncoding("UTF-8");
				response.setHeader("Content-type", "text/json;charset=UTF-8");
				response.getWriter().write(json.toString());
				return null;
			}
		}
		// 获取开始结束时间的小时差
		Double startS = Double.parseDouble(format.parse(startTime + ":00").getTime() + "");// 开始日期时间的毫秒值
		Double endS = Double.parseDouble(format.parse(endTime + ":00").getTime() + ""); // 结束日期时间的毫秒值
		Double timeS = (endS - startS) / 3600000;
		DecimalFormat deFor = new DecimalFormat("0.0");
		timeS = Double.parseDouble(deFor.format(timeS) + "");
		if (timeS >= 0) { // 如果时间差是负数,不做后续处理
			// 加班开始日期当天是否为工作日
			String startFirst = GeesunLeaveJudgeSatUtil.getLastDay(startTime, false); // 加班开始日期时间的当天开始时间
			String startLast = GeesunLeaveJudgeSatUtil.getLastDay(startTime, true); // 加班开始日期时间的后一天开始时间
			Double startOverDay = Double.parseDouble(clockingInDateService.isRestDay(startFirst, startLast, userId)
					+ "");// 用于判断加班开始日期当天是否为工作日
			Double startHour = startOverDay / Double.parseDouble((60 * 60 * 1000) + "");// 工作时长

			// 加班结束日期当天是否为工作日
			String endFirst = GeesunLeaveJudgeSatUtil.getLastDay(endTime, false); // 加班结束日期的当天开始时间
			String endLast = GeesunLeaveJudgeSatUtil.getLastDay(endTime, true); // 加班结束日期的后一天开始时间
			Double endOverDay = Double.parseDouble(clockingInDateService.isRestDay(endFirst, endLast, userId) + "");// 用于判断加班结束日期当天是否为工作日
			Double endHour = endOverDay / Double.parseDouble((60 * 60 * 1000) + "");// 工作时长

			timeS = dateFormat(timeS);
			if (startHour <= 0 && endHour <= 0) { // 判断加班开始结束日期时间是否存在工作日的情况
				if (timeS <= 24) { // 限制开始结束时间必须为24小时内
					getMap(json, startTime, endTime, fdNo, format, timeS, startFirst, endLast);
				} else {
					json.put("overTimeHour", "大于24小时");
				}
			} else if (startHour > 0 && endHour > 0) {
				Boolean staBoo = GeesunLeaveJudgeSatUtil.JuMonday(startTime);
				Boolean endBoo = GeesunLeaveJudgeSatUtil.JuMonday(endTime);
				if (staBoo == true && endBoo == true) {
					getMap(json, startTime, endTime, fdNo, format, timeS, "", "");
				} else {
					if (startHour == 2.5 && endHour == 2.5) {
						getMap(json, startTime, endTime, fdNo, format, timeS, "2.5", "2.5");
					} else {
						json.put("overTimeHour", "加班开始结束日期均为工作日");
					}
				}
			} else if (startHour > 0 && endHour <= 0) {
				Boolean staBoo = GeesunLeaveJudgeSatUtil.JuMonday(startTime);
				if (staBoo == true) {
					getMap(json, startTime, endTime, fdNo, format, timeS, "", "");
				} else {
					if (startHour == 2.5) {
						getMap(json, startTime, endTime, fdNo, format, timeS, "2.5", "");
					} else {
						json.put("overTimeHour", "加班开始日期为工作日");
					}
				}
			} else if (startHour <= 0 && endHour > 0) {
				Boolean endBoo = GeesunLeaveJudgeSatUtil.JuMonday(endTime);
				if (endBoo == true) {
					getMap(json, startTime, endTime, fdNo, format, timeS, "", "");
				} else {
					if (endHour == 2.5) {
						getMap(json, startTime, endTime, fdNo, format, timeS, "", "2.5");
					} else {
						json.put("overTimeHour", "加班结束日期为工作日");
					}
				}
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-type", "text/json;charset=UTF-8");
		response.getWriter().write(json.toString());
		return null;

	}

	private void getMap(JSONObject json, String startTime, String endTime, String fdNo, SimpleDateFormat format,
			Double timeS, String startJ, String endJ) throws ParseException {
		Map<String, String> hashMap = new HashMap<>();
		hashMap.put("fdNo", fdNo);
		hashMap.put("startJ", startJ);
		hashMap.put("endJ", endJ);
		hashMap.put("startTime", startTime);
		hashMap.put("endTime", endTime);
		hashMap.put("timeS", timeS + "");
		getKaoqinRecord(hashMap, json);
	}

	// 判断通过后,查询是否有无对应的打卡记录
	private void getKaoqinRecord(Map<String, String> hashMap, JSONObject json) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Map<String, String> map = new HashMap<String, String>();
		map.put("fdNo", hashMap.get("fdNo"));
		map.put("date", hashMap.get("startTime").substring(0, 10)); // 只需要取开始时间
		JSONArray jsonArr = geesunLeaveKaoQinRDao.getKaoQin(map);
		if (jsonArr.size() != 0) {
			Iterator<Object> ob = jsonArr.iterator();
			while (ob.hasNext()) {
				JSONObject jsonOb = (JSONObject) ob.next();
				String start = jsonOb.getString("sb1"); // 目前只取上班1卡点
				// if (!jsonOb.getString("sb3").equals("null")) {
				// start = jsonOb.getString("sb3");
				// } else if (!jsonOb.getString("sb2").equals("null")) {
				// start = jsonOb.getString("sb2");
				// } else {
				// start = jsonOb.getString("sb1");
				// }
				String end = "";
				if (!"null".equals(jsonOb.getString("xb3"))) {
					end = jsonOb.getString("xb3");
				} else if (!"null".equals(jsonOb.getString("xb2"))) {
					end = jsonOb.getString("xb2");
				} else {
					end = jsonOb.getString("xb1");
				}
				if ("null".equals(start) && "null".equals(end)) {
					json.put("overTimeHour", "未查询到记录");
					return;
				} else if ("null".equals(start) || "null".equals(end)) {
					json.put("overTimeHour", "查询一条记录");
					return;
				}
				if (format.parse(start).getTime() <= format.parse(hashMap.get("startTime")).getTime()
						&& format.parse(end).getTime() >= format.parse(hashMap.get("endTime")).getTime()) {
					if (hashMap.get("startJ").equals("2.5") || hashMap.get("endJ").equals("2.5")) {
						Long start1 = format.parse(hashMap.get("startTime").substring(0, 16)).getTime();
						Long start2 = format.parse(hashMap.get("startTime").substring(0, 10) + " 13:30").getTime();
						Long startTime = start1 > start2 ? start1 : start2;
						Long endTime = format.parse(hashMap.get("endTime").substring(0, 16)).getTime();
						DecimalFormat deFor = new DecimalFormat("0.0");
						Double hour = Double.parseDouble(deFor.format((endTime - startTime)) + "")
								/ Double.parseDouble(deFor.format(3600000) + "");
						hour = dateFormat(hour);
						//进行转换,小周周六大于2.5小时判断输出
						if(hour >2.5){
							Double shour = 2.5;
							json.put("overTimeHour", shour);
						} else{
						    json.put("overTimeHour", hour);
						}						
						json.put("overTimeHour", hour);
						return;
					}
					json.put("overTimeHour", hashMap.get("timeS"));
				} else {
					json.put("overTimeHour", "核对打卡时间");
				}
			}
		}else {
			json.put("overTimeHour", "未查询到记录");
			return;
		}
	}

	//将时间(double)改为以0.5小时为标准的形式
	private Double dateFormat(Double hour) {
		Double hours = hour % 1; // 转换为0.5小时为单位
		if (hours >= 0.5) {
			hour = hour - (hours - 0.5);
		} else if (hours < 0.5) {
			hour = hour - hours;
		}
		return hour;
	}
}
