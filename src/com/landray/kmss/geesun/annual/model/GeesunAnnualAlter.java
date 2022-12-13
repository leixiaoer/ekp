package com.landray.kmss.geesun.annual.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualAlterForm;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.DateUtil;

/**
  * 年假调整记录表
  */
public class GeesunAnnualAlter extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 字段名称
	 */
	private String fdFieldName;
	
	/**
	 * @return 字段名称
	 */
	public String getFdFieldName() {
		return this.fdFieldName;
	}
	
	/**
	 * @param fdFieldName 字段名称
	 */
	public void setFdFieldName(String fdFieldName) {
		this.fdFieldName = fdFieldName;
	}
	
	/**
	 * 模型ID
	 */
	private String fdModelId;
	
	/**
	 * @return 模型ID
	 */
	public String getFdModelId() {
		return this.fdModelId;
	}
	
	/**
	 * @param fdModelId 模型ID
	 */
	public void setFdModelId(String fdModelId) {
		this.fdModelId = fdModelId;
	}
	
	/**
	 * 模型名称
	 */
	private String fdModelName;
	
	/**
	 * @return 模型名称
	 */
	public String getFdModelName() {
		return this.fdModelName;
	}
	
	/**
	 * @param fdModelName 模型名称
	 */
	public void setFdModelName(String fdModelName) {
		this.fdModelName = fdModelName;
	}
	
	/**
	 * 来源
	 */
	private String fdSource;
	
	/**
	 * @return 来源
	 */
	public String getFdSource() {
		return this.fdSource;
	}
	
	/**
	 * @param fdSource 来源
	 */
	public void setFdSource(String fdSource) {
		this.fdSource = fdSource;
	}
	
	/**
	 * 修改前
	 */
	protected String fdBerforAlter;
	
	/**
	 * @return 修改前
	 */
	public String getFdBerforAlter() {
		return (String) readLazyField("fdBerforAlter", fdBerforAlter);
	}
	
	/**
	 * @param fdBerforAlter 修改前
	 */
	public void setFdBerforAlter(String fdBerforAlter) {
		this.fdBerforAlter = (String) writeLazyField("fdBerforAlter",
				this.fdBerforAlter, fdBerforAlter);
	}

	/**
	 * 修改后
	 */
	protected String fdAfterAlter;
	
	/**
	 * @return 修改后
	 */
	public String getFdAfterAlter() {
		return (String) readLazyField("fdAfterAlter", fdAfterAlter);
	}
	
	/**
	 * @param fdAfterAlter 修改后
	 */
	public void setFdAfterAlter(String fdAfterAlter) {
		this.fdAfterAlter = (String) writeLazyField("fdAfterAlter",
				this.fdAfterAlter, fdAfterAlter);
	}
	
	/**
	 * 创建时间
	 */
	private Date docCreateTime;
	
	/**
	 * @return 创建时间
	 */
	public Date getDocCreateTime() {
		return this.docCreateTime;
	}
	
	/**
	 * @param docCreateTime 创建时间
	 */
	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}
	
	/**
	 * 创建者
	 */
	private SysOrgPerson docCreator;
	
	/**
	 * @return 创建者
	 */
	public SysOrgPerson getDocCreator() {
		return this.docCreator;
	}
	
	/**
	 * @param docCreator 创建者
	 */
	public void setDocCreator(SysOrgPerson docCreator) {
		this.docCreator = docCreator;
	}

    public Class<GeesunAnnualAlterForm> getFormClass() {
        return GeesunAnnualAlterForm.class;
    }

    private static ModelToFormPropertyMap toFormPropertyMap;
    
    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
            toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
        }
        return toFormPropertyMap;
    }

}
