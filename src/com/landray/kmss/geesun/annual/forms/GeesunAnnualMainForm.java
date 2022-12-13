package com.landray.kmss.geesun.annual.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.readlog.forms.ReadLogForm;
import com.landray.kmss.sys.readlog.interfaces.ISysReadLogForm;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.web.upload.FormFile;

/**
  * 年假记录表
  */
public class GeesunAnnualMainForm extends ExtendForm implements ISysReadLogForm {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static FormToModelPropertyMap toModelPropertyMap;

    private String docCreateTime;

    private String fdOwnerNo;

    private String fdTotal;

    private String fdRemain;

    private String fdFrozen;

    private String fdUsed;

    private String docReadCount;

    private String fdLastTotal;

    private String fdLastRemain;

    private String fdLastFrozen;

    private String fdLastUsed;

    private String fdNextResetDate;
    
    private String fdLastResetDate;

    private String docCreatorId;

    private String docCreatorName;

    private String fdOwnerId;

    private String fdOwnerName;

    private String docDeptId;

    private String docDeptName;

    private ReadLogForm readLogForm = new ReadLogForm();

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        docCreateTime = null;
        fdOwnerNo = null;
        fdTotal = null;
        fdRemain = null;
        fdFrozen = null;
        fdUsed = null;
        docReadCount = null;
        fdLastTotal = null;
        fdLastRemain = null;
        fdLastFrozen = null;
        fdLastUsed = null;
        fdNextResetDate = null;
        docCreatorId = null;
        docCreatorName = null;
        fdOwnerId = null;
        fdOwnerName = null;
        docDeptId = null;
        docDeptName = null;
        super.reset(mapping, request);
    }

    public Class<GeesunAnnualMain> getModelClass() {
        return GeesunAnnualMain.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
            toModelPropertyMap.addNoConvertProperty("docReadCount");
            toModelPropertyMap.put("fdNextResetDate", new FormConvertor_Common("fdNextResetDate").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel("docCreator", SysOrgPerson.class));
            toModelPropertyMap.put("fdOwnerId", new FormConvertor_IDToModel("fdOwner", SysOrgPerson.class));
            toModelPropertyMap.put("docDeptId", new FormConvertor_IDToModel("docDept", SysOrgElement.class));
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
     * 工号
     */
    public String getFdOwnerNo() {
        return this.fdOwnerNo;
    }

    /**
     * 工号
     */
    public void setFdOwnerNo(String fdOwnerNo) {
        this.fdOwnerNo = fdOwnerNo;
    }

    /**
     * 年假总额度
     */
    public String getFdTotal() {
        return this.fdTotal;
    }

    /**
     * 年假总额度
     */
    public void setFdTotal(String fdTotal) {
        this.fdTotal = fdTotal;
    }

    /**
     * 年假剩余额度
     */
    public String getFdRemain() {
        return this.fdRemain;
    }

    /**
     * 年假剩余额度
     */
    public void setFdRemain(String fdRemain) {
        this.fdRemain = fdRemain;
    }

    /**
     * 年假冻结额度
     */
    public String getFdFrozen() {
        return this.fdFrozen;
    }

    /**
     * 年假冻结额度
     */
    public void setFdFrozen(String fdFrozen) {
        this.fdFrozen = fdFrozen;
    }

    /**
     * 年假已用额度
     */
    public String getFdUsed() {
        return this.fdUsed;
    }

    /**
     * 年假已用额度
     */
    public void setFdUsed(String fdUsed) {
        this.fdUsed = fdUsed;
    }

    /**
     * 阅读次数
     */
    public String getDocReadCount() {
        return this.docReadCount;
    }

    /**
     * 阅读次数
     */
    public void setDocReadCount(String docReadCount) {
        this.docReadCount = docReadCount;
    }

    /**
     * 上一年度总额度
     */
    public String getFdLastTotal() {
        return this.fdLastTotal;
    }

    /**
     * 上一年度总额度
     */
    public void setFdLastTotal(String fdLastTotal) {
        this.fdLastTotal = fdLastTotal;
    }

    /**
     * 上一年度剩余额度
     */
    public String getFdLastRemain() {
        return this.fdLastRemain;
    }

    /**
     * 上一年度剩余额度
     */
    public void setFdLastRemain(String fdLastRemain) {
        this.fdLastRemain = fdLastRemain;
    }

    /**
     * 上一年度冻结额度
     */
    public String getFdLastFrozen() {
        return this.fdLastFrozen;
    }

    /**
     * 上一年度冻结额度
     */
    public void setFdLastFrozen(String fdLastFrozen) {
        this.fdLastFrozen = fdLastFrozen;
    }

    /**
     * 上一年度已用额度
     */
    public String getFdLastUsed() {
        return this.fdLastUsed;
    }

    /**
     * 上一年度已用额度
     */
    public void setFdLastUsed(String fdLastUsed) {
        this.fdLastUsed = fdLastUsed;
    }

    /**
     * 下一次年假额度重置时间
     */
    public String getFdNextResetDate() {
        return this.fdNextResetDate;
    }

    /**
     * 下一次年假额度重置时间
     */
    public void setFdNextResetDate(String fdNextResetDate) {
        this.fdNextResetDate = fdNextResetDate;
    }
    
    /**
     * 上一次年假额度重置时间
     */
    public String getFdLastResetDate() {
        return this.fdLastResetDate;
    }

    /**
     * 上一次年假额度重置时间
     */
    public void setFdLastResetDate(String fdLastResetDate) {
        this.fdLastResetDate = fdLastResetDate;
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
     * 归属人
     */
    public String getFdOwnerId() {
        return this.fdOwnerId;
    }

    /**
     * 归属人
     */
    public void setFdOwnerId(String fdOwnerId) {
        this.fdOwnerId = fdOwnerId;
    }

    /**
     * 归属人
     */
    public String getFdOwnerName() {
        return this.fdOwnerName;
    }

    /**
     * 归属人
     */
    public void setFdOwnerName(String fdOwnerName) {
        this.fdOwnerName = fdOwnerName;
    }

    /**
     * 所属部门
     */
    public String getDocDeptId() {
        return this.docDeptId;
    }

    /**
     * 所属部门
     */
    public void setDocDeptId(String docDeptId) {
        this.docDeptId = docDeptId;
    }

    /**
     * 所属部门
     */
    public String getDocDeptName() {
        return this.docDeptName;
    }

    /**
     * 所属部门
     */
    public void setDocDeptName(String docDeptName) {
        this.docDeptName = docDeptName;
    }

    public ReadLogForm getReadLogForm() {
        return readLogForm;
    }

    public void setReadLogForm(ReadLogForm readLogForm) {
        this.readLogForm = readLogForm;
    }
    
    protected FormFile theFile;

	public FormFile getTheFile() {
		return theFile;
	}

	public void setTheFile(FormFile theFile) {
		this.theFile = theFile;
	}
    
}
