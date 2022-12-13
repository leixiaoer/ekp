package com.landray.kmss.geesun.oitems.dao;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.dao.IBaseDao;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReceiveContext;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 人库记录数据访问接口
 */
public interface IGeesunOitemsWarehousingRecordJoinListDao extends IBaseDao {
	List<GeesunOitemsReceiveContext> findReceiveCount(HttpServletRequest request) throws Exception;
}
