package com.landray.kmss.geesun.leave.service.spring;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveBarterDao;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveInfoDao;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveTakeWorkingDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveBarterDaoImp;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveInfoDaoImpl;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveTakeWorkingDaoImpl;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveTakeWorkingService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.util.UserUtil;

/**
 * 增加调休申请信息修改调休时数
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveTakeWorkingServiceImp implements IGeesunLeaveTakeWorkingService {
	private IGeesunLeaveTakeWorkingDao workingDao = new GeesunLeaveTakeWorkingDaoImpl();
	private IGeesunLeaveInfoDao geesunLeaveInfoDao = new GeesunLeaveInfoDaoImpl();
	private IGeesunLeaveBarterDao geesunLeaveBarterDao = new GeesunLeaveBarterDaoImp();

	@Override
	public void addTakeWorking(Map<String, Object> map, KmReviewMain kmReviewMain) {
		String user = getMapValue(map, "fd_395a154b559cee"); // 获取申请人ID
		Map<String, Object> userMap = null;
		if (!user.isEmpty()) {
			Gson gson = new Gson();
			userMap = new HashMap<String, Object>();
			userMap = gson.fromJson(user, userMap.getClass());
		}
		String userId = userMap.get("id").toString(); // 用户ID
		String deptId = UserUtil.getUser(userId).getFdParent().getFdId(); // 部门ID
		Map<String, String> hashMap = new HashMap<>();
		hashMap.put("fdId", kmReviewMain.getFdId());// 流程ID
		hashMap.put("docSubject", kmReviewMain.getDocSubject());// 流程标题
		hashMap.put("fdStartTime", getMapValue(map, "fd_39685af3347f00"));// 调休开始时间
		hashMap.put("fdEndTime", getMapValue(map, "fd_39685afaaf9286"));// 调休结束时间
		hashMap.put("fdLeaveHour", getMapValue(map, "fd_39686015ee288e"));// 调休时长
		hashMap.put("docCreatorId", userId);// 申请人ID
		hashMap.put("docDeptId", deptId);// 申请人部门ID
		workingDao.addBarter(hashMap); // 增加调休记录

		// 后续就是修改调休额度
		String year = new SimpleDateFormat("yyyy").format(new Date()).toString();// 当前年份
		Map<String, String> leaveMap = geesunLeaveInfoDao.getUserLeave(userId, year);// 获取指定用户指定年份的额度信息
		Double leaveHour = Double.parseDouble(getMapValue(map, "fd_39686015ee288e"));// 本次调休时数
		Double surplusHour = Double.parseDouble(leaveMap.get("surplusLeave"));// 额度剩余时数
		Double useLeaveHour = Double.parseDouble(leaveMap.get("useLeave")); // 额度已使用时数
		Double sunLeaveHour = Double.parseDouble(leaveMap.get("sunLeave")); // 额度总计
		surplusHour = surplusHour - leaveHour;
		useLeaveHour += leaveHour;
		Map<String, String> messageMap = new HashMap<>();
		messageMap.put("fdId", leaveMap.get("fdId"));
		messageMap.put("fdSurplusLeave", surplusHour.toString());
		messageMap.put("fdUseLeave", useLeaveHour.toString());
		messageMap.put("fdSunLeave", sunLeaveHour.toString());
		messageMap.put("fdTakeId", kmReviewMain.getFdId());
		geesunLeaveInfoDao.updateLeaveInfo(messageMap); // 修改调休剩余(此处为扣减调休额度)

		// 增加geesun_leave_barter_areader信息
		Map<String, String> areaderMap = new HashMap<>();
		areaderMap.put("fdSourceId", kmReviewMain.getFdId()); // 调休记录fdId
		areaderMap.put("fdTargetId", userId); // 申请人用户ID
		geesunLeaveBarterDao.addAreader(areaderMap);

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
