package com.landray.kmss.geesun.annual.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.geesun.annual.model.GeesunAnnualAlter;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.web.action.ActionMapping;

/**
  * 年假调整记录表
  */
public class GeesunAnnualAlterForm extends BaseGeesunAnnualAlterForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 字段名称
	 */
	private String fdFieldName = null;
	
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
	private String fdModelId = null;
	
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
	private String fdModelName = null;
	
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
	private String fdSource = null;
	
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
	 * 修改前内容
	 */
	private String fdBerforAlter = null;
	
	/**
	 * @return 修改前内容
	 */
	public String getFdBerforAlter() {
		return this.fdBerforAlter;
	}
	
	/**
	 * @param fdBerforAlter 修改前内容
	 */
	public void setFdBerforAlter(String fdBerforAlter) {
		this.fdBerforAlter = fdBerforAlter;
	}
	
	/**
	 * 修改后内容
	 */
	private String fdAfterAlter = null;
	
	/**
	 * @return 修改后内容
	 */
	public String getFdAfterAlter() {
		return this.fdAfterAlter;
	}
	
	/**
	 * @param fdAfterAlter 修改后内容
	 */
	public void setFdAfterAlter(String fdAfterAlter) {
		this.fdAfterAlter = fdAfterAlter;
	}
	
	/**
	 * 创建时间
	 */
	private String docCreateTime = null;
	
	/**
	 * @return 创建时间
	 */
	public String getDocCreateTime() {
		return this.docCreateTime;
	}
	
	/**
	 * @param docCreateTime 创建时间
	 */
	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}
	
	/**
	 * 创建者的ID
	 */
	private String docCreatorId = null;
	
	/**
	 * @return 创建者的ID
	 */
	public String getDocCreatorId() {
		return this.docCreatorId;
	}
	
	/**
	 * @param docCreatorId 创建者的ID
	 */
	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}
	
	/**
	 * 创建者的名称
	 */
	private String docCreatorName = null;
	
	/**
	 * @return 创建者的名称
	 */
	public String getDocCreatorName() {
		return this.docCreatorName;
	}
	
	/**
	 * @param docCreatorName 创建者的名称
	 */
	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	private static FormToModelPropertyMap toModelPropertyMap;

    public void reset(ActionMapping mapping, HttpServletRequest request) {
    	fdFieldName = null;
		fdModelId = null;
		fdModelName = null;
		fdSource = null;
		fdBerforAlter = null;
		fdAfterAlter = null;
		docCreateTime = null;
		docCreatorId = null;
		docCreatorName = null;
        super.reset(mapping, request);
    }

    public Class<GeesunAnnualAlter> getModelClass() {
        return GeesunAnnualAlter.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.put("docCreatorId",
					new FormConvertor_IDToModel("docCreator",
					SysOrgPerson.class));
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
        }
        return toModelPropertyMap;
    }

}
