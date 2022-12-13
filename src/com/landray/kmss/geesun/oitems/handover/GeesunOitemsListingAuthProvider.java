package com.landray.kmss.geesun.oitems.handover;

import java.util.ArrayList;
import java.util.List;

import com.landray.kmss.sys.handover.interfaces.config.HandoverItem;
import com.landray.kmss.sys.handover.support.config.catetemplate.AbstractCateTempHandler;
import com.landray.kmss.sys.handover.support.config.catetemplate.AbstractCateTempProvider;
import com.landray.kmss.util.ResourceUtil;

public class GeesunOitemsListingAuthProvider extends AbstractCateTempProvider {
	public List<HandoverItem> items() throws Exception {
		List<HandoverItem> items = new ArrayList<HandoverItem>();
		addHandoverItem(items, AbstractCateTempHandler.AUTH_READERS,
				getMessage("authReaders"));
		addHandoverItem(items, AbstractCateTempHandler.AUTH_EDITORS,
				getMessage("authEditors"));
		return items;
	}

	/**
	 * 根据后缀返回message
	 * 
	 * @param suffix
	 * @return
	 */
	private String getMessage(String suffix) {
		String pre = "sys-handover-support-config-auth:sysHandoverDocAuth.";
		return ResourceUtil.getString(pre + suffix);
	}
}
