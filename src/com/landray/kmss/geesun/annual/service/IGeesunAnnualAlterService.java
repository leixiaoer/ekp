package com.landray.kmss.geesun.annual.service;

import java.util.List;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.annual.interfaces.IGeesunAnnualAlterForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualAlter;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;
import com.sunbor.web.tag.Page;

public interface IGeesunAnnualAlterService extends IExtendDataService {

    public abstract List<GeesunAnnualAlter> findByFdAnnual(GeesunAnnualMain fdAnnual) throws Exception;
    
    /**
     * 根据模型ID和名称获取对应数量
     * @param modelId
     * @param modelName
     * @return
     * @throws Exception
     */
    public int getAlterRecordInfoCount(String modelId, String modelName) throws Exception;
    
    /**
	 * 记录xml文件配置的字段修改记录
	 * 
	 * @param form
	 */
	int updateAlterFieldRecord(IGeesunAnnualAlterForm form) throws Exception;
	
	public int updateAlterFieldRecord(IGeesunAnnualAlterForm form,String source)
			throws Exception ;

	/**
	 * 根据request查找修改记录
	 * 
	 * @param formName
	 * @param modelId
	 * @return
	 */
	Page findAlterFieldRecord(RequestContext requestContext) throws Exception;
	
	int findAlterFieldRecordSize(RequestContext requestContext) throws Exception;
    
}
