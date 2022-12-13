package com.landray.kmss.geesun.oitems.dao.hibernate;

import java.util.Date;

import com.landray.kmss.common.dao.BaseDaoImp;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.oitems.dao.IGeesunOitemsWarehousingRecordDao;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecord;
import com.landray.kmss.util.UserUtil;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 人库记录数据访问接口实现
 */
public class GeesunOitemsWarehousingRecordDaoImp extends BaseDaoImp implements IGeesunOitemsWarehousingRecordDao {

	@Override
	public String add(IBaseModel modelObj) throws Exception {
		GeesunOitemsWarehousingRecord geesunOitemsWarehousingRecord = (GeesunOitemsWarehousingRecord) modelObj;
		geesunOitemsWarehousingRecord.setDocCreateTime(new Date());
		geesunOitemsWarehousingRecord.setDocCreator(UserUtil.getUser());
		return super.add(geesunOitemsWarehousingRecord);
	}
}
