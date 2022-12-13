package com.landray.kmss.geesun.org.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.org.model.GeesunOrgEkp;
import com.landray.kmss.web.action.ActionMapping;



/**
 * HR同步日志 Form
 * 
 * @author 
 * @version 1.0 2019-06-19
 */
public class GeesunOrgEkpForm  extends ExtendForm  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
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
	 * 同步结果
	 */
	private String fdResult = null;
	
	/**
	 * @return 同步结果
	 */
	public String getFdResult() {
		return this.fdResult;
	}
	
	/**
	 * @param fdResult 同步结果
	 */
	public void setFdResult(String fdResult) {
		this.fdResult = fdResult;
	}
	
	/**
	 * 类型
	 */
	private String fdType = null;
	
	/**
	 * @return 类型
	 */
	public String getFdType() {
		return this.fdType;
	}
	
	/**
	 * @param fdType 类型
	 */
	public void setFdType(String fdType) {
		this.fdType = fdType;
	}
	
	/**
	 * 错误信息
	 */
	private String fdMessage = null;
	
	/**
	 * @return 错误信息
	 */
	public String getFdMessage() {
		return this.fdMessage;
	}
	
	/**
	 * @param fdMessage 错误信息
	 */
	public void setFdMessage(String fdMessage) {
		this.fdMessage = fdMessage;
	}
	
	/**
	 * 接口返回信息
	 */
	private String fdReturns = null;
	
	/**
	 * @return 接口返回信息
	 */
	public String getFdReturns() {
		return this.fdReturns;
	}
	
	/**
	 * @param fdReturns 接口返回信息
	 */
	public void setFdReturns(String fdReturns) {
		this.fdReturns = fdReturns;
	}
	
	/**
	 * 传入信息
	 */
	private String fdInput = null;
	
	/**
	 * @return 传入信息
	 */
	public String getFdInput() {
		return this.fdInput;
	}
	
	/**
	 * @param fdInput 传入信息
	 */
	public void setFdInput(String fdInput) {
		this.fdInput = fdInput;
	}
	
	//机制开始 
	//机制结束

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		docCreateTime = null;
		fdResult = null;
		fdType = null;
		fdMessage = null;
		fdInput = null;
		fdReturns = null;
		super.reset(mapping, request);
	}

	public Class getModelClass() {
		return GeesunOrgEkp.class;
	}
	
	private static FormToModelPropertyMap toModelPropertyMap;

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
		}
		return toModelPropertyMap;
	}
}
