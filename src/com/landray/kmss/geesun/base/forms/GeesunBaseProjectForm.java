package com.landray.kmss.geesun.base.forms;

import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.geesun.base.model.GeesunBaseProject;

/**
  * 项目号信息
  */
public class GeesunBaseProjectForm extends ExtendForm implements IAttachmentForm {

    private static FormToModelPropertyMap toModelPropertyMap;

    private String fdName;

    private String fdOrder;

    private String fdIsAvailable;

    private String docCreateTime;

    private String fdProjectNo;

    private String docCreatorId;

    private String docCreatorName;

    private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);
        fdName = null;
        fdOrder = null;
        fdIsAvailable = null;
        docCreateTime = null;
        fdProjectNo = null;
        docCreatorId = null;
        docCreatorName = null;
        super.reset(mapping, request);
    }

    public Class<GeesunBaseProject> getModelClass() {
        return GeesunBaseProject.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
        }
        return toModelPropertyMap;
    }

    /**
     * 项目名称
     */
    public String getFdName() {
        return this.fdName;
    }

    /**
     * 项目名称
     */
    public void setFdName(String fdName) {
        this.fdName = fdName;
    }

    /**
     * 排序号
     */
    public String getFdOrder() {
        return this.fdOrder;
    }

    /**
     * 排序号
     */
    public void setFdOrder(String fdOrder) {
        this.fdOrder = fdOrder;
    }

    /**
     * 是否有效
     */
    public String getFdIsAvailable() {
        return this.fdIsAvailable;
    }

    /**
     * 是否有效
     */
    public void setFdIsAvailable(String fdIsAvailable) {
        this.fdIsAvailable = fdIsAvailable;
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
     * 项目号
     */
    public String getFdProjectNo() {
        return this.fdProjectNo;
    }

    /**
     * 项目号
     */
    public void setFdProjectNo(String fdProjectNo) {
        this.fdProjectNo = fdProjectNo;
    }

    /**
     * 创建人
     */
    public String getDocCreatorId() {
        return this.docCreatorId;
    }

    /**
     * 创建人
     */
    public void setDocCreatorId(String docCreatorId) {
        this.docCreatorId = docCreatorId;
    }

    /**
     * 创建人
     */
    public String getDocCreatorName() {
        return this.docCreatorName;
    }

    /**
     * 创建人
     */
    public void setDocCreatorName(String docCreatorName) {
        this.docCreatorName = docCreatorName;
    }

    public AutoHashMap getAttachmentForms() {
        return attachmentForms;
    }
}
