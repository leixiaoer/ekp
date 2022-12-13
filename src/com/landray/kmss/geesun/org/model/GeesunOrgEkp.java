package com.landray.kmss.geesun.org.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.org.forms.GeesunOrgEkpForm;
import com.landray.kmss.sys.quartz.interfaces.ISysQuartzModel;



/**
 * HR同步日志
 * 
 * @author 
 * @version 1.0 2019-06-19
 */
public class GeesunOrgEkp  extends BaseModel implements ISysQuartzModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
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
	 * 同步结果
	 */
	private String fdResult;
	
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
	private String fdType;
	
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
	private String fdMessage;
	
	/**
	 * @return 错误信息
	 */
	public String getFdMessage() {
		return (String) readLazyField("fdMessage", this.fdMessage);
	}
	
	/**
	 * @param fdMessage 错误信息
	 */
	public void setFdMessage(String fdMessage) {
		this.fdMessage = (String) writeLazyField("fdMessage",
				this.fdMessage, fdMessage);
	}
	
	/**
	 * 接口返回信息
	 */
	private String fdReturns;
	
	/**
	 * @return 接口返回信息
	 */
	public String getFdReturns() {
		return (String) readLazyField("fdReturns", this.fdReturns);
	}
	
	/**
	 * @param fdReturns 接口返回信息
	 */
	public void setFdReturns(String fdReturns) {
		this.fdReturns = (String) writeLazyField("fdReturns",
				this.fdReturns, fdReturns);
	}

	/**
	 * 传入信息
	 */
	private String fdInput;
	
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

	public Class getFormClass() {
		return GeesunOrgEkpForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap;

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
		}
		return toFormPropertyMap;
	}
}
