package com.landray.kmss.geesun.oitems.service;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.IBaseService;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 人库记录业务对象接口
 */
public interface IGeesunOitemsWarehousingRecordService  extends IBaseService {
	
	public String addRecord(IExtendForm form, RequestContext context) throws Exception;
	

}
