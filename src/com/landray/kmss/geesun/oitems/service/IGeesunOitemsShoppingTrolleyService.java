package com.landray.kmss.geesun.oitems.service;

import java.util.List;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IGeesunOitemsShoppingTrolleyService extends IBaseService {

	void addOitems(IExtendForm form, RequestContext requestContext)
			throws Exception;

	public void deleteShoppingTrolley(SysQuartzJobContext context)
			throws Exception;

	public List<GeesunOitemsShoppingTrolley>
			addShops(List<GeesunOitemsShoppingTrolley> shops, String fdAppId)
					throws Exception;

	public void deleteShoppingTrolley(String fdApplicationId) throws Exception;

	public boolean checkShop(String fdAppId,
			GeesunOitemsWarehousingRecordJoinList record) throws Exception;

}
