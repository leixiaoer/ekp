package com.landray.kmss.geesun.oitems.right;

import com.landray.kmss.sys.right.plugin.IDisplayProvider;
import com.landray.kmss.util.ResourceUtil;

/**
 * 授权机制属性显示名扩展提供者
 * <p>
 * 在授权页面，优先读本提供者的属性名称，如没有提供，则使用默认名称
 * 
 * @author 潘永辉 2019年3月7日
 *
 */
public class GeesunOitemsManageProvider implements IDisplayProvider {

	@Override
	public String getDisplayLabel(String proName) {
		if ("authReaders".equals(proName)) {
			return ResourceUtil.getString("geesun-oitems:geesunOitemsManage.class.fdnName");
		}
		return null;
	}

}
