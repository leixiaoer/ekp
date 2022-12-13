package com.landray.kmss.geesun.oitems.actions;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.dao.HQLWrapper;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsBudgerApplicationService;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.StringUtil;

import edu.emory.mathcs.backport.java.util.Arrays;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟
 */
public class GeesunOitemsBudgerApplicationIndexAction extends ExtendAction

{
	protected IGeesunOitemsBudgerApplicationService geesunOitemsBudgerApplicationService;

	protected IGeesunOitemsBudgerApplicationService getServiceImp(
			HttpServletRequest request) {
		if (geesunOitemsBudgerApplicationService == null)
			geesunOitemsBudgerApplicationService = (IGeesunOitemsBudgerApplicationService) getBean("geesunOitemsBudgerApplicationService");
		return geesunOitemsBudgerApplicationService;
	}

	protected String getParentProperty() {
		return "fdTemplate";
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		CriteriaValue cv = new CriteriaValue(request);
		StringBuilder hql = new StringBuilder(" 1=1 ");
		String[] fdApplyPerson = cv.polls("fdApplyPerson");
		String[] fdApplyDept = cv.polls("fdApplyDept");
		if(fdApplyPerson!=null){
			if(fdApplyPerson.length>1){
				HQLWrapper hqlW = HQLUtil.buildPreparedLogicIN("geesunOitemsBudgerApplication.fdApplyor.fdId","geesunOitemsBudgerApplication0_", Arrays.asList(fdApplyPerson));
				hql.append("  and ("+hqlW.getHql()+")");
				hqlInfo.setParameter(hqlW.getParameterList());
			}else{
				hql.append(" and ( geesunOitemsBudgerApplication.fdApplyor.fdId =:fdApplyPerson)");
				hqlInfo.setParameter("fdApplyPerson", fdApplyPerson[0]);
			}	
		}
		if (fdApplyDept!=null) {
			if(fdApplyDept.length>1){
				HQLWrapper hqlW = HQLUtil.buildPreparedLogicIN("geesunOitemsBudgerApplication.fdApplyor.fdId","geesunOitemsBudgerApplication0_", Arrays.asList(fdApplyDept));
				hql.append("  and ("+hqlW.getHql()+")");
				hqlInfo.setParameter(hqlW.getParameterList());
			}else{
				hql.append(" and ( geesunOitemsBudgerApplication.fdApplyor.fdId =:fdApplyDept)");
				hqlInfo.setParameter("fdApplyDept", fdApplyDept[0]);
			}
		}
		hqlInfo.setWhereBlock(hql.toString());
		hqlInfo.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
		CriteriaUtil.buildHql(cv, hqlInfo, GeesunOitemsBudgerApplication.class);
	}

	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if (StringUtil.isNull(curOrderBy)) {
			curOrderBy = "geesunOitemsBudgerApplication.docCreateTime desc";
		}
		return curOrderBy;
	}
}
