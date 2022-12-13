package com.landray.kmss.geesun.leave.service.spring;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.landray.kmss.geesun.leave.service.IClockingInDateService;
import com.landray.kmss.sys.time.interfaces.ISysTimeCountService;
import com.landray.kmss.util.SpringBeanUtil;

public class ClockingInDateServiceImp implements IClockingInDateService {
	protected ISysTimeCountService sysTimeCountService;

	/**
	 * 判断是否为休息日
	 */
	@Override
	public long isRestDay(String startTime, String endTime, String userId) {
		if (null == sysTimeCountService) {
			// 当存在外部工时系统定义时，采用外部工时定义系统服务
			sysTimeCountService = (ISysTimeCountService) SpringBeanUtil.getBean("sysTimeCountService");
		}
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date1;
		Date date2;
		long workTime = 0;
		try {
			date1 = simpleDateFormat.parse(startTime);
			date2 = simpleDateFormat.parse(endTime);
			long ts1 = date1.getTime();
			long ts2 = date2.getTime();
			try {
				workTime = sysTimeCountService.getManHour(userId, ts1, ts2);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return workTime;
	}
}
