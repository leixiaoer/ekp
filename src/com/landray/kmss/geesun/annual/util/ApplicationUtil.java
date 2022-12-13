package com.landray.kmss.geesun.annual.util;

import com.landray.kmss.util.ResourceUtil;

public class ApplicationUtil {
	public static String getText(String bundle_key) {
		String[] bundle_keys = bundle_key.split(":");
		return ResourceUtil.getString(bundle_keys[1], bundle_keys[0]);
	}
}
