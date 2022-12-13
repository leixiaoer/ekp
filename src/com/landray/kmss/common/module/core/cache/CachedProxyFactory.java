package com.landray.kmss.common.module.core.cache;

import com.landray.kmss.common.module.util.ExceptionUtil;
import com.landray.kmss.util.KeyLockFactory;
import com.landray.kmss.util.KeyLockFactory.KeyLock;

import java.util.HashMap;
import java.util.Map;

/**
 * 在生成代理逻辑之前加一层缓存
 *
 * @author 严明镜
 * @version 1.0 2021年03月11日
 */
public class CachedProxyFactory {

	private final KeyLockFactory locker = new KeyLockFactory();

	/**
	 * 缓存key根据接口和警告级别一起判断
	 */
	private final Map<String, Object> proxyCache = new HashMap<>();

	public <T> T createProxy(ICachedProxyGenerator<T> generator) {
		if (generator.getKey() == null) {
			//不缓存直接创建
			return generateProxy(generator);
		} else {
			return generateCachedProxy(generator);
		}
	}

	@SuppressWarnings("unchecked")
	private <T> T generateCachedProxy(ICachedProxyGenerator<T> generator) {
		//从缓存中取
		if (proxyCache.containsKey(generator.getKey())) {
			return (T) proxyCache.get(generator.getKey());
		}
		KeyLock keyLock = locker.getKeyLock(generator.getKey()).lock();
		try {
			T proxy = generateProxy(generator);
			if (proxy != null) {
				proxyCache.put(generator.getKey(), proxy);
			}
			return proxy;
		} finally {
			keyLock.unlock();
		}
	}

	private <T> T generateProxy(ICachedProxyGenerator<T> generator) {
		if (!generator.valid()) {
			return null;
		}
		try {
			return generator.createProxy();
		} catch (Exception e) {
			ExceptionUtil.printException("获取代理对象时发生异常", e);
			return null;
		}
	}
}
