package com.landray.kmss.geesun.org.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.org.model.GeesunOrgPost;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.web.action.ActionMapping;

/**
  * 岗位中间表
  */
public class GeesunOrgPostForm extends ExtendForm  {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static FormToModelPropertyMap toModelPropertyMap;

    private String docCreateTime;

    private String fdPostId;

    private String fdPostName;

    private String fdParentId;

    private String fdPostNo;

    private String fdSuperPostId;

    private String fdSuperDeptId;

    private String fdQidongDate;

    private String fdNewDate;
    
    private String fdIsDel;

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        docCreateTime = null;
        fdPostId = null;
        fdPostName = null;
        fdParentId = null;
        fdPostNo = null;
        fdSuperPostId = null;
        fdSuperDeptId = null;
        fdQidongDate = null;
        fdNewDate = null;
        fdIsDel = null;
        super.reset(mapping, request);
    }

    public Class<GeesunOrgPost> getModelClass() {
        return GeesunOrgPost.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
            toModelPropertyMap.put("fdQidongDate", new FormConvertor_Common("fdQidongDate").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("fdNewDate", new FormConvertor_Common("fdNewDate").setDateTimeType(DateUtil.TYPE_DATETIME));
        }
        return toModelPropertyMap;
    }

    /**
     * 创建时间
     */
    public String getDocCreateTime() {
        return this.docCreateTime;
    }

    /**
     * 创建时间
     */
    public void setDocCreateTime(String docCreateTime) {
        this.docCreateTime = docCreateTime;
    }

    /**
     * 岗位ID
     */
    public String getFdPostId() {
        return this.fdPostId;
    }

    /**
     * 岗位ID
     */
    public void setFdPostId(String fdPostId) {
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
    public String getFdParentId() {
        return this.fdParentId;
    }

    /**
     * 部门ID
     */
    public void setFdParentId(String fdParentId) {
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
     * 上级岗位ID
     */
    public String getFdSuperPostId() {
        return this.fdSuperPostId;
    }

    /**
     * 上级岗位ID
     */
    public void setFdSuperPostId(String fdSuperPostId) {
        this.fdSuperPostId = fdSuperPostId;
    }

    /**
     * 上级部门ID
     */
    public String getFdSuperDeptId() {
        return this.fdSuperDeptId;
    }

    /**
     * 上级部门ID
     */
    public void setFdSuperDeptId(String fdSuperDeptId) {
        this.fdSuperDeptId = fdSuperDeptId;
    }

    /**
     * 启动时间
     */
    public String getFdQidongDate() {
        return this.fdQidongDate;
    }

    /**
     * 启动时间
     */
    public void setFdQidongDate(String fdQidongDate) {
        this.fdQidongDate = fdQidongDate;
    }

    /**
     * 更新时间
     */
    public String getFdNewDate() {
        return this.fdNewDate;
    }

    /**
     * 更新时间
     */
    public void setFdNewDate(String fdNewDate) {
        this.fdNewDate = fdNewDate;
    }
    
    /**
     * 是否删除
     */
    public String getFdIsDel() {
        return this.fdIsDel;
    }

    /**
     * 是否删除
     */
    public void setFdIsDel(String fdIsDel) {
        this.fdIsDel = fdIsDel;
    }
    
}
