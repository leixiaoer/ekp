package com.landray.kmss.geesun.base.forms;

import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.geesun.base.model.GeesunBaseAudit;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;

/**
  * 报销科目审批人员配置表
  */
public class GeesunBaseAuditForm extends ExtendForm implements IAttachmentForm {

    private static FormToModelPropertyMap toModelPropertyMap;

    private String docCreateTime;

    private String docAlterTime;

    private String fdAccountName;

    private String fdAccountCode;

    private String docCreatorId;

    private String docCreatorName;

    private String docAlterorId;

    private String docAlterorName;

    private String fdPersonIds;

    private String fdPersonNames;

    private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);
        docCreateTime = null;
        docAlterTime = null;
        fdAccountName = null;
        fdAccountCode = null;
        docCreatorId = null;
        docCreatorName = null;
        docAlterorId = null;
        docAlterorName = null;
        fdPersonIds = null;
        fdPersonNames = null;
        super.reset(mapping, request);
    }

    public Class<GeesunBaseAudit> getModelClass() {
        return GeesunBaseAudit.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
            toModelPropertyMap.addNoConvertProperty("docAlterTime");
            toModelPropertyMap.put("fdPersonIds", new FormConvertor_IDsToModelList("fdPersons", SysOrgPerson.class));
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
     * 更新时间
     */
    public String getDocAlterTime() {
        return this.docAlterTime;
    }

    /**
     * 更新时间
     */
    public void setDocAlterTime(String docAlterTime) {
        this.docAlterTime = docAlterTime;
    }

    /**
     * 科目名称
     */
    public String getFdAccountName() {
        return this.fdAccountName;
    }

    /**
     * 科目名称
     */
    public void setFdAccountName(String fdAccountName) {
        this.fdAccountName = fdAccountName;
    }

    /**
     * 科目编码
     */
    public String getFdAccountCode() {
        return this.fdAccountCode;
    }

    /**
     * 科目编码
     */
    public void setFdAccountCode(String fdAccountCode) {
        this.fdAccountCode = fdAccountCode;
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

    /**
     * 修改人
     */
    public String getDocAlterorId() {
        return this.docAlterorId;
    }

    /**
     * 修改人
     */
    public void setDocAlterorId(String docAlterorId) {
        this.docAlterorId = docAlterorId;
    }

    /**
     * 修改人
     */
    public String getDocAlterorName() {
        return this.docAlterorName;
    }

    /**
     * 修改人
     */
    public void setDocAlterorName(String docAlterorName) {
        this.docAlterorName = docAlterorName;
    }

    /**
     * 审批人
     */
    public String getFdPersonIds() {
        return this.fdPersonIds;
    }

    /**
     * 审批人
     */
    public void setFdPersonIds(String fdPersonIds) {
        this.fdPersonIds = fdPersonIds;
    }

    /**
     * 审批人
     */
    public String getFdPersonNames() {
        return this.fdPersonNames;
    }

    /**
     * 审批人
     */
    public void setFdPersonNames(String fdPersonNames) {
        this.fdPersonNames = fdPersonNames;
    }

    public AutoHashMap getAttachmentForms() {
        return attachmentForms;
    }
}
