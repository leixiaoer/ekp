package com.landray.kmss.util;

import java.util.Iterator;

import org.hibernate.cfg.Configuration;
import org.hibernate.dialect.Dialect;
import org.hibernate.mapping.Column;
import org.hibernate.mapping.PersistentClass;
import org.hibernate.mapping.Property;

import com.landray.kmss.sys.config.loader.KmssHibernateLocalSessionFactoryBean;

/**
 * 根据型模型Class获取表名与属性对的字段名
 * 
 * @author 潘永辉
 * 
 */
public class HibernateUtil {
	private static Configuration hibernateConf;

	private static Configuration getHibernateConf() {
		if (hibernateConf == null) {
			return new Configuration();
		}
		return hibernateConf;
	}

	private static PersistentClass getPersistentClass(Class<?> clazz) {
		synchronized (HibernateUtil.class) {
			PersistentClass pc = getHibernateConf().getClassMapping(clazz.getName());
			if (pc == null) {
				hibernateConf = getHibernateConf().addClass(clazz);
				pc = getHibernateConf().getClassMapping(clazz.getName());
			}
			return pc;
		}
	}

	/**
	 * 获取表名
	 * 
	 * @param clazz
	 * @return
	 */
	public static String getTableName(Class<?> clazz) {
		return getPersistentClass(clazz).getTable().getName();
	}

	/**
	 * 根据属性名称获取字段名
	 * 
	 * @param clazz
	 * @param propertyName
	 * @return
	 */
	public static String getColumnName(Class<?> clazz, String propertyName) {
		PersistentClass persistentClass = getPersistentClass(clazz);
		Property property = persistentClass.getProperty(propertyName);
		Iterator<?> it = property.getColumnIterator();
		if (it.hasNext()) {
			Column column = (Column) it.next();
			return column.getName();
		}
		return null;
	}
	
	private static Dialect cachedDialect = null;
    private static Dialect getCurDialect(){
        if(cachedDialect == null){
            KmssHibernateLocalSessionFactoryBean bean  = 
                    (KmssHibernateLocalSessionFactoryBean) SpringBeanUtil.getBean("&sessionFactory");
            Configuration configuration =   bean.getConfiguration();
            cachedDialect = Dialect.getDialect(configuration.getProperties());
        }
        return cachedDialect;
    }
    /**
     * 获取boolean值对应的sql、hql语句中使用的字符串表达，某些数据库使用0|1，某些数据库使用true|false
     * @param value
     * @return
     */
    public static String toBooleanValueString(boolean value){
        if(cachedDialect==null){
            getCurDialect();
        }
        return cachedDialect.toBooleanValueString(value);
    }
}
