package com.landray.kmss.geesun.org.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.org.forms.GeesunOrgPostForm;
import com.landray.kmss.util.DateUtil;

/**
  * 岗位中间表
  */
public class GeesunOrgPost extends BaseModel {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static ModelToFormPropertyMap toFormPropertyMap;

    private Date docCreateTime;

    private Integer fdPostId;

    private String fdPostName;

    private Integer fdParentId;

    private String fdPostNo;

    private Integer fdSuperPostId;

    private Integer fdSuperDeptId;

    private Date fdQidongDate;

    private Date fdNewDate;
    
    private Integer fdIsDel;

    public Class<GeesunOrgPostForm> getFormClass() {
        return GeesunOrgPostForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("fdQidongDate", new ModelConvertor_Common("fdQidongDate").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("fdNewDate", new ModelConvertor_Common("fdNewDate").setDateTimeType(DateUtil.TYPE_DATETIME));
        }
        return toFormPropertyMap;
    }

    public void recalculateFields() {
        super.recalculateFields();
    }

    /**
     * 创建时间
     */
    public Date getDocCreateTime() {
        return this.docCreateTime;
    }

    /**
     * 创建时间
     */
    public void setDocCreateTime(Date docCreateTime) {
        this.docCreateTime = docCreateTime;
    }

    /**
     * 岗位ID
     */
    public Integer getFdPostId() {
        return this.fdPostId;
    }

    /**
     * 岗位ID
     */
    public void setFdPostId(Integer fdPostId) {
        this.fdPostId = fdPostId;
    }

    /**
     * 岗位名称
     */
    public String getFdPostName() {
        return this.fdPostName;
    }

    /**
     * 岗位名称
     */
    public void setFdPostName(String fdPostName) {
        this.fdPostName = fdPostName;
    }

    /**
     * 部门ID
     */
    public Integer getFdParentId() {
        return this.fdParentId;
    }

    /**
     * 部门ID
     */
    public void setFdParentId(Integer fdParentId) {
        this.fdParentId = fdParentId;
    }

    /**
     * 岗位编码
     */
    public String getFdPostNo() {
        return this.fdPostNo;
    }

    /**
     * 岗位编码
     */
    public void setFdPostNo(String fdPostNo) {
        this.fdPostNo = fdPostNo;
    }
    
    /**
     * 是否删除
     */
    public Integer getFdIsDel() {
        return this.fdIsDel;
    }

    /**
     * 是否删除
     */
    public void setFdIsDel(Integer fdIsDel) {
        this.fdIsDel = fdIsDel;
    }

    /**
     * 上级岗位ID
     */
    public Integer getFdSuperPostId() {
        return this.fdSuperPostId;
    }

    /**
     * 上级岗位ID
     */
    public void setFdSuperPostId(Integer fdSuperPostId) {
        this.fdSuperPostId = fdSuperPostId;
    }

    /**
     * 上级部门ID
     */
    public Integer getFdSuperDeptId() {
        return this.fdSuperDeptId;
    }

    /**
     * 上级部门ID
     */
    public void setFdSuperDeptId(Integer fdSuperDeptId) {
        this.fdSuperDeptId = fdSuperDeptId;
    }

    /**
     * 启动时间
     */
    public Date getFdQidongDate() {
        return this.fdQidongDate;
    }

    /**
     * 启动时间
     */
    public void setFdQidongDate(Date fdQidongDate) {
        this.fdQidongDate = fdQidongDate;
    }

    /**
     * 更新时间
     */
    public Date getFdNewDate() {
        return this.fdNewDate;
    }

    /**
     * 更新时间
     */
    public void setFdNewDate(Date fdNewDate) {
        this.fdNewDate = fdNewDate;
    }
    
}
