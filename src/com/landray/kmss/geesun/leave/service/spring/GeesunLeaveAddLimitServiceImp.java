package com.landray.kmss.geesun.leave.service.spring;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveAdjustDao;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveInfoDao;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveMainDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveAdjustDaoImp;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveInfoDaoImpl;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveMainDaoImp;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveAddLimitService;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveOverTimeService;
import com.landray.kmss.geesun.leave.util.GeesunLeaveLastDayUtil;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.util.UserUtil;

public class GeesunLeaveAddLimitServiceImp implements IGeesunLeaveAddLimitService {
	private IGeesunLeaveInfoDao geesunLeaveInfoDao = new GeesunLeaveInfoDaoImpl();
	private IGeesunLeaveMainDao geesunLeaveMainDao = new GeesunLeaveMainDaoImp();
	private IGeesunLeaveAdjustDao geesunLeaveAdjustDao = new GeesunLeaveAdjustDaoImp();
	private IGeesunLeaveOverTimeService geesunLeaveOverTimeService = new GeesunLeaveOverTimeServiceImp();

	/**
	 * 调整调休额度 增加加班申请信息
	 */
	@Override
	public void AddLimit(Map<String, Object> map, KmReviewMain kmReviewMain) {
		// 先获取年份和用户ID,判断指定年份是否存在指定用户
		// 如果存在,只需要增加修改额度即可
		// 如果不存在,需要新增一条额度数据信息
		String user = getMapValue(map, "fd_395a0e397f83b2");
		Map<String, Object> userMap = null;
		if (!user.isEmpty()) {
			Gson gson = new Gson();
			userMap = new HashMap<String, Object>();
			userMap = gson.fromJson(user, userMap.getClass());
		}
		String userId = userMap.get("id").toString();// 用户ID
		String fdId = kmReviewMain.getFdId().toString(); // 流程ID
		String year = new SimpleDateFormat("yyyy").format(new Date()).toString();// 当前年份
		Map<String, String> hashMap = geesunLeaveInfoDao.getUserLeave(userId, year);
		if (hashMap.size() > 0) { // 已有数据,只需修改跳转即可
			Map<String, String> leaveMap = new HashMap<>();
			Double leaveHour = Double.parseDouble(getMapValue(map, "fd_396de00b2f804a").toString());// 加班时数
			Double surplusLeave = Double.parseDouble(hashMap.get("surplusLeave")); // 获取剩余时数
			Double sunLeave = Double.parseDouble(hashMap.get("sunLeave")); // 获取调休时数总计
			leaveMap.put("fdId", hashMap.get("fdId"));// 流程ID
			leaveMap.put("fdSurplusLeave", (leaveHour + surplusLeave) + "");// 调休剩余时数
			leaveMap.put("fdUseLeave", hashMap.get("useLeave"));// 调休已使用时数
			leaveMap.put("fdSunLeave", (leaveHour + sunLeave) + "");// 调休时数总计
			geesunLeaveInfoDao.updateLeaveInfo(leaveMap); // 修改调休剩余(此处为增加调休额度)
		} else {// 未存在数据,需要添加一条数据
			Map<String, String> leaveMap = new HashMap<>();
			leaveMap.put("fdId", fdId);// 流程ID
			leaveMap.put("fdOwnerNo", UserUtil.getUser(userId).getFdNo());// 工号(既为登录名)
			String deptId = UserUtil.getUser(userId).getFdParent().getFdId(); // 获取指定用户的部门ID
			leaveMap.put("fdDeptId", deptId);// 部门ID
			leaveMap.put("fdTime", year);// 当前年份
			String leaveHour = getMapValue(map, "fd_396de00b2f804a");// 加班时数
			leaveMap.put("fdSurplusLeave", leaveHour);// 调休剩余时数
			leaveMap.put("fdUseLeave", "0");// 调休已使用时数
			leaveMap.put("fdSunLeave", leaveHour);// 调休时数总计
			leaveMap.put("docCreateId", userId);// 创建者ID
			leaveMap.put("docFailureTime", GeesunLeaveLastDayUtil.getYearLast(Integer.parseInt(year)));// 失效日期
			leaveMap.put("docDeptId", deptId);// 创建人的部门ID
			geesunLeaveInfoDao.AddLeaveInfo(leaveMap);

			// 增加geesun_leave_main_areader信息
			Map<String, String> areaderMap = new HashMap<>();
			areaderMap.put("fdSourceId", fdId);
			areaderMap.put("fdTargetId", userId);
			geesunLeaveMainDao.addAreader(areaderMap);
		}
		// 增加加班信息
		geesunLeaveOverTimeService.addMessage(map, kmReviewMain, userId);
		// 增加geesun_leave_adjust_main信息
		Map<String, String> areaderMap = new HashMap<>();
		areaderMap.put("fdSourceId", fdId);
		areaderMap.put("fdTargetId", userId);
		geesunLeaveAdjustDao.addAreader(areaderMap);

		// 解除请假申请被冻结的时间(20流程结束成功)
		Map<String, String> stateMap = new HashMap<>();
		stateMap.put("fdId", fdId);
		stateMap.put("fdState", "20");
		geesunLeaveAdjustDao.upAdjustState(stateMap);

	}

	// 根据入参(表单信息Map),以及key键,经过查询匹配获取相对应的value值
	private String getMapValue(Map<String, Object> map, String key) {
		String value = "";
		if (map.containsKey(key) && map.get(key) != null) {
			value = map.get(key).toString().trim();
		}
		return value;
	}
}
