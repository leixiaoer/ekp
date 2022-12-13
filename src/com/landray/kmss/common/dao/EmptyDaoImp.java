package com.landray.kmss.common.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.util.ClassUtils;

import com.landray.kmss.common.model.IBaseModel;
import com.sunbor.web.tag.Page;

/**
 * 一个不实现任何功能的Dao，主要用于不配置数据库实体，仅保存机制信息的情况
 * 
 * @author 叶中奇
 * @version 1.0 2006-04-02
 */
public class EmptyDaoImp extends HibernateDaoSupport implements IBaseDao {
	protected IHQLBuilder hqlBuilder = null;

	private String modelName;

	public String add(IBaseModel modelObj) throws Exception {
		return modelObj.getFdId();
	}

	public void delete(IBaseModel modelObj) throws Exception {
	}

	public IBaseModel findByPrimaryKey(String id) throws Exception {
		return findByPrimaryKey(id, null, false);
	}

	public IBaseModel findByPrimaryKey(String id, Object modelInfo,
			boolean noLazy) throws Exception {
		IBaseModel model = (IBaseModel) ClassUtils.forName(modelName).newInstance();
		return model;
	}

	public final List findByPrimaryKeys(String[] ids) throws Exception {
		List modelList = new ArrayList();
		modelList.add(findByPrimaryKey(null));
		return modelList;
	}

	public List findList(HQLInfo hqlInfo) throws Exception {
		return new ArrayList();
	}

	public List findList(String whereBlock, String orderBy) throws Exception {
		return new ArrayList();
	}

	public Page findPage(HQLInfo hqlInfo) throws Exception {
		return Page.getEmptyPage();
	}

	public Page findPage(String whereBlock, String orderBy, int pageno,
			int rowsize) throws Exception {
		return Page.getEmptyPage();
	}

	public List findValue(HQLInfo hqlInfo) throws Exception {
		return new ArrayList();
	}

	public List findValue(String selectBlock, String whereBlock, String orderBy)
			throws Exception {
		return new ArrayList();
	}
	
	public void setLock(String tableName, String lockKey, Query query) throws Exception {
	}

	public void flushHibernateSession() {
		getSession().flush();
	}

	public void clearHibernateSession() {
		getSession().clear();
	}

	public Session getHibernateSession() {
		return getSession();
	}

	public String getModelName() {
		return modelName;
	}

	/**
	 * 设置HQL拼装器
	 * 
	 * @param hqlBuilder
	 */
	public void setHqlBuilder(IHQLBuilder hqlBuilder) {
		this.hqlBuilder = hqlBuilder;
	}

	/**
	 * 设置Dao对应的域模型
	 * 
	 * @param modelName
	 */
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}

	public void update(IBaseModel modelObj) throws Exception {
	}

	public boolean isExist(String modelName, String fdId) throws Exception {
		//用占位符进行where条件参数填充
		StringBuilder querySql = new StringBuilder();
		querySql.append("select fdId from ");
		querySql.append(modelName);
		querySql.append(" where fdId = :fdId ");
		List dataList = getSession().createQuery(querySql.toString())
				.setParameter("fdId", fdId)
				.list();
		if (dataList == null || dataList.isEmpty()) {
			return false;
		}
		return true;
	}

	public Iterator findValueIterator(HQLInfo hqlInfo) throws Exception {

		return new ArrayList().iterator();
	}

	public void findValueIterator(HQLInfo hqlInfo, boolean isClear,
			IteratorCallBack callBack) throws Exception {

	}

}
