package com.landray.kmss.geesun.base.model;

import java.util.ArrayList;
import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import java.util.Date;
import java.util.List;
import com.landray.kmss.geesun.base.forms.GeesunBaseAuditForm;
import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.sys.organization.model.SysOrgPerson;

/**
  * 报销科目审批人员配置表
  */
public class GeesunBaseAudit extends BaseModel implements IAttachment {

    private static ModelToFormPropertyMap toFormPropertyMap;

    private Date docCreateTime;

    private Date docAlterTime;

    private String fdAccountName;

    private String fdAccountCode;

    private SysOrgPerson docCreator;

    private SysOrgPerson docAlteror;

    private List<SysOrgPerson> fdPersons = new ArrayList<SysOrgPerson>();

    private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

    public Class<GeesunBaseAuditForm> getFormClass() {
        return GeesunBaseAuditForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("docAlterTime", new ModelConvertor_Common("docAlterTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
            toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
            toFormPropertyMap.put("docAlteror.fdName", "docAlterorName");
            toFormPropertyMap.put("docAlteror.fdId", "docAlterorId");
            toFormPropertyMap.put("fdPersons", new ModelConvertor_ModelListToString("fdPersonIds:fdPersonNames", "fdId:fdName"));
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
     * 更新时间
     */
    public Date getDocAlterTime() {
        return this.docAlterTime;
    }

    /**
     * 更新时间
     */
    public void setDocAlterTime(Date docAlterTime) {
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
    public SysOrgPerson getDocCreator() {
        return this.docCreator;
    }

    /**
     * 创建人
     */
    public void setDocCreator(SysOrgPerson docCreator) {
        this.docCreator = docCreator;
    }

    /**
     * 修改人
     */
    public SysOrgPerson getDocAlteror() {
        return this.docAlteror;
    }

    /**
     * 修改人
     */
    public void setDocAlteror(SysOrgPerson docAlteror) {
        this.docAlteror = docAlteror;
    }

    /**
     * 审批人
     */
    public List<SysOrgPerson> getFdPersons() {
        return this.fdPersons;
    }

    /**
     * 审批人
     */
    public void setFdPersons(List<SysOrgPerson> fdPersons) {
        this.fdPersons = fdPersons;
    }

    public AutoHashMap getAttachmentForms() {
        return attachmentForms;
    }
}
