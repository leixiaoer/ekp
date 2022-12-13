package com.landray.kmss.util;

import java.io.FilePermission;
import java.security.Permission;
import java.security.PrivilegedAction;
import java.security.PrivilegedExceptionAction;

/**
 * 安全控制，可以在kmssconfig.properties的kmss.securityController.disabled=true关闭
 * 
 * @author 叶中奇
 */
public class SecurityController {
	private static Boolean disabled = null;

	private static ThreadLocal<Boolean> open = new ThreadLocal<>();

	public static <T> T doPrivileged(PrivilegedAction<T> action) {
		init();
		open.set(Boolean.TRUE);
		try {
			return action.run();
		} finally {
			open.remove();
		}
	}

	public static <T> T doPrivileged(PrivilegedExceptionAction<T> action)
			throws Exception {
		init();
		open.set(Boolean.TRUE);
		try {
			return action.run();
		} finally {
			open.remove();
		}
	}

	private synchronized static void init() {
		if (disabled == null) {
			String value = ResourceUtil.getKmssConfigString("kmss.securityController.disabled");
			if (StringUtil.isNotNull(value)) {
				value=value.trim();
			}
			
			disabled = "true".equals(value);
		}
		
		if (disabled || System.getSecurityManager() != null) {
			return;
		}
		System.setSecurityManager(new SecurityManager() {
			@Override
			public void checkPermission(Permission perm) {
				doCheckPermission(perm);
			}

			@Override
			public void checkPermission(Permission perm, Object context) {
				doCheckPermission(perm);
			}
		});
	}

	private static void doCheckPermission(Permission perm) {
		if (!Boolean.TRUE.equals(open.get())) {
			return;
		}
		if (perm instanceof RuntimePermission) {
			if (perm.getName().equals("setSecurityManager")
					|| perm.getName().startsWith("exitVM")) {
				throw new SecurityException();
			}
		} else if (perm instanceof FilePermission) {
			String action = perm.getActions();
			if ("read".equals(action)) {
				return;
			}
			throw new SecurityException();
		}
	}
}
