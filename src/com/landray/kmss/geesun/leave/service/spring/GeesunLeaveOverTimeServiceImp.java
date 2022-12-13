package com.landray.kmss.geesun.leave.service.spring;

import java.util.HashMap;
import java.util.Map;

import com.landray.kmss.geesun.leave.dao.IGeesunLeaveOverTimeDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveOverTimeDaoImpl;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveOverTimeService;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.util.UserUtil;

/**
 * 加班
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveOverTimeServiceImp implements IGeesunLeaveOverTimeService {
	private IGeesunLeaveOverTimeDao geesunLeaveTimeDao = new GeesunLeaveOverTimeDaoImpl();

	/**
	 * 增加加班信息
	 */
	public void addMessage(Map<String, Object> map, KmReviewMain kmReviewMain, String userId) {
		// 能走到这一步的,加班申请肯定是为非工作日的加班
		// 所以需要将加班信息写入至加班模块中
		Map<String, String> ajMap = new HashMap<>();
		ajMap.put("fdId", kmReviewMain.getFdId());// 流程ID
		ajMap.put("docSubject", kmReviewMain.getDocSubject());// 主题名称
		ajMap.put("fdStartTime", getMapValue(map, "fd_397203954f20aa"));// 请假开始时间
		ajMap.put("fdEndTime", getMapValue(map, "fd_3972039d0e3dda"));// 请假结束时间
		ajMap.put("docCreatorId", userId);// 创建者ID
		ajMap.put("docDeptId", UserUtil.getUser(userId).getFdParent().getFdId());// 部门ID
		ajMap.put("fdLeaveHour", getMapValue(map, "fd_396de00b2f804a"));
		geesunLeaveTimeDao.AddOverTime(ajMap);
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
