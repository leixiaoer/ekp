package com.landray.kmss.geesun.leave.service.spring;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.leave.dao.IGeesunLeaveInfoDao;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveInfoDaoImpl;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataEvent;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataModel;
import com.landray.kmss.sys.metadata.interfaces.ISysMetadataParser;
import com.landray.kmss.util.UserUtil;

/**
 * 调休表单扩展自定义
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveOrderFormEvent implements IExtendDataEvent {
	private IGeesunLeaveInfoDao geesunLeaveInfoDao = new GeesunLeaveInfoDaoImpl();

	@Override
	public void onAdd(IExtendDataModel arg0, ISysMetadataParser arg1) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void onDelete(IExtendDataModel arg0, ISysMetadataParser arg1) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void onInit(RequestContext context, IExtendDataModel model, ISysMetadataParser parser) throws Exception {
		String userId = UserUtil.getUser().getFdId(); // 获取用户ID
		String year = new SimpleDateFormat("yyyy").format(new Date()).toString();// 当前年份
		Map<String, String> map = geesunLeaveInfoDao.getUserLeave(userId, year); // 获取指定用户和年份的剩余调休信息
		if ("".equals(map.get("surplusLeave")) || map.get("surplusLeave") == null) {
			map.put("surplusLeave", "0");
		}
		parser.setFieldValue(model, "fd_394446a77fa542", map.get("surplusLeave")); // 将获取到的剩余调休时数赋值到表单“加班小时”上
	}

	@Override
	public void onUpdate(IExtendDataModel arg0, ISysMetadataParser arg1) throws Exception {
		// TODO Auto-generated method stub

	}

}
