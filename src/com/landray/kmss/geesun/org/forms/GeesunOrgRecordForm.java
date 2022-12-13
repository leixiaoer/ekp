package com.landray.kmss.geesun.org.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.org.model.GeesunOrgRecord;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.web.action.ActionMapping;

/**
  * 同步记录表
  */
public class GeesunOrgRecordForm extends ExtendForm implements IAttachmentForm {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static FormToModelPropertyMap toModelPropertyMap;

    private String stext;

    private String objidUp;

    private String objid;

    private String priox;

    private String zsfyx;

    private String zhrOmJglx;

    private String zzDatum;

    private String objidSUp;

    private String begda;

    private String nachn;

    private String phone;

    private String gbdat;

    private String call;

    private String gender;

    private String wxid;

    private String pernr;

    private String plans02;

    private String email;

    private String zhrOmGwzd;

    private String plans01;

    private String zhrOmGwzj;

    private String vnamc;

    private String orgeh;

    private String icnum;

    private String docCreateTime;

    private String fdOrganType;

    private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);
        stext = null;
        objidUp = null;
        objid = null;
        priox = null;
        zsfyx = null;
        zhrOmJglx = null;
        zzDatum = null;
        objidSUp = null;
        begda = null;
        nachn = null;
        phone = null;
        gbdat = null;
        call = null;
        gender = null;
        wxid = null;
        pernr = null;
        plans02 = null;
        email = null;
        zhrOmGwzd = null;
        plans01 = null;
        zhrOmGwzj = null;
        vnamc = null;
        orgeh = null;
        icnum = null;
        docCreateTime = null;
        fdOrganType = null;
        super.reset(mapping, request);
    }

    public Class<GeesunOrgRecord> getModelClass() {
        return GeesunOrgRecord.class;
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
     * STEXT
     */
    public String getStext() {
        return this.stext;
    }

    /**
     * STEXT
     */
    public void setStext(String stext) {
        this.stext = stext;
    }

    /**
     * OBJID_UP
     */
    public String getObjidUp() {
        return this.objidUp;
    }

    /**
     * OBJID_UP
     */
    public void setObjidUp(String objidUp) {
        this.objidUp = objidUp;
    }

    /**
     * OBJID
     */
    public String getObjid() {
        return this.objid;
    }

    /**
     * OBJID
     */
    public void setObjid(String objid) {
        this.objid = objid;
    }

    /**
     * PRIOX
     */
    public String getPriox() {
        return this.priox;
    }

    /**
     * PRIOX
     */
    public void setPriox(String priox) {
        this.priox = priox;
    }

    /**
     * ZSFYX
     */
    public String getZsfyx() {
        return this.zsfyx;
    }

    /**
     * ZSFYX
     */
    public void setZsfyx(String zsfyx) {
        this.zsfyx = zsfyx;
    }

    /**
     * ZHR_OM_JGLX
     */
    public String getZhrOmJglx() {
        return this.zhrOmJglx;
    }

    /**
     * ZHR_OM_JGLX
     */
    public void setZhrOmJglx(String zhrOmJglx) {
        this.zhrOmJglx = zhrOmJglx;
    }

    /**
     * ZZ_DATUM
     */
    public String getZzDatum() {
        return this.zzDatum;
    }

    /**
     * ZZ_DATUM
     */
    public void setZzDatum(String zzDatum) {
        this.zzDatum = zzDatum;
    }

    /**
     * OBJID_S_UP
     */
    public String getObjidSUp() {
        return this.objidSUp;
    }

    /**
     * OBJID_S_UP
     */
    public void setObjidSUp(String objidSUp) {
        this.objidSUp = objidSUp;
    }

    /**
     * BEGDA
     */
    public String getBegda() {
        return this.begda;
    }

    /**
     * BEGDA
     */
    public void setBegda(String begda) {
        this.begda = begda;
    }

    /**
     * NACHN
     */
    public String getNachn() {
        return this.nachn;
    }

    /**
     * NACHN
     */
    public void setNachn(String nachn) {
        this.nachn = nachn;
    }

    /**
     * PHONE
     */
    public String getPhone() {
        return this.phone;
    }

    /**
     * PHONE
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * GBDAT
     */
    public String getGbdat() {
        return this.gbdat;
    }

    /**
     * GBDAT
     */
    public void setGbdat(String gbdat) {
        this.gbdat = gbdat;
    }

    /**
     * CALL
     */
    public String getCall() {
        return this.call;
    }

    /**
     * CALL
     */
    public void setCall(String call) {
        this.call = call;
    }

    /**
     * GENDER
     */
    public String getGender() {
        return this.gender;
    }

    /**
     * GENDER
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * WXID
     */
    public String getWxid() {
        return this.wxid;
    }

    /**
     * WXID
     */
    public void setWxid(String wxid) {
        this.wxid = wxid;
    }

    /**
     * PERNR
     */
    public String getPernr() {
        return this.pernr;
    }

    /**
     * PERNR
     */
    public void setPernr(String pernr) {
        this.pernr = pernr;
    }

    /**
     * PLANS_02
     */
    public String getPlans02() {
        return this.plans02;
    }

    /**
     * PLANS_02
     */
    public void setPlans02(String plans02) {
        this.plans02 = plans02;
    }

    /**
     * EMAIL
     */
    public String getEmail() {
        return this.email;
    }

    /**
     * EMAIL
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * ZHR_OM_GWZD
     */
    public String getZhrOmGwzd() {
        return this.zhrOmGwzd;
    }

    /**
     * ZHR_OM_GWZD
     */
    public void setZhrOmGwzd(String zhrOmGwzd) {
        this.zhrOmGwzd = zhrOmGwzd;
    }

    /**
     * PLANS_01
     */
    public String getPlans01() {
        return this.plans01;
    }

    /**
     * PLANS_01
     */
    public void setPlans01(String plans01) {
        this.plans01 = plans01;
    }

    /**
     * ZHR_OM_GWZJ
     */
    public String getZhrOmGwzj() {
        return this.zhrOmGwzj;
    }

    /**
     * ZHR_OM_GWZJ
     */
    public void setZhrOmGwzj(String zhrOmGwzj) {
        this.zhrOmGwzj = zhrOmGwzj;
    }

    /**
     * VNAMC
     */
    public String getVnamc() {
        return this.vnamc;
    }

    /**
     * VNAMC
     */
    public void setVnamc(String vnamc) {
        this.vnamc = vnamc;
    }

    /**
     * ORGEH
     */
    public String getOrgeh() {
        return this.orgeh;
    }

    /**
     * ORGEH
     */
    public void setOrgeh(String orgeh) {
        this.orgeh = orgeh;
    }

    /**
     * ICNUM
     */
    public String getIcnum() {
        return this.icnum;
    }

    /**
     * ICNUM
     */
    public void setIcnum(String icnum) {
        this.icnum = icnum;
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
     * 组织类型
     */
    public String getFdOrganType() {
        return this.fdOrganType;
    }

    /**
     * 组织类型
     */
    public void setFdOrganType(String fdOrganType) {
        this.fdOrganType = fdOrganType;
    }

    public AutoHashMap getAttachmentForms() {
        return attachmentForms;
    }
}
