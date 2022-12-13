package com.landray.kmss.geesun.base.formula;

import java.util.ArrayList;
import java.util.List;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.base.model.GeesunBaseBxsj;
import com.landray.kmss.geesun.base.service.IGeesunBaseBxsjService;
import com.landray.kmss.km.asset.model.KmAssetApplyChange;
import com.landray.kmss.km.asset.model.KmAssetApplyChangeList;
import com.landray.kmss.km.asset.model.KmAssetApplyDeal;
import com.landray.kmss.km.asset.model.KmAssetApplyDealList;
import com.landray.kmss.km.asset.model.KmAssetApplyDivert;
import com.landray.kmss.km.asset.model.KmAssetApplyDivertList;
import com.landray.kmss.km.asset.model.KmAssetApplyGet;
import com.landray.kmss.km.asset.model.KmAssetApplyGetList;
import com.landray.kmss.km.asset.model.KmAssetApplyIn;
import com.landray.kmss.km.asset.model.KmAssetApplyInList;
import com.landray.kmss.km.asset.model.KmAssetApplyRent;
import com.landray.kmss.km.asset.model.KmAssetApplyRentList;
import com.landray.kmss.km.asset.model.KmAssetApplyRepair;
import com.landray.kmss.km.asset.model.KmAssetApplyRepairList;
import com.landray.kmss.km.asset.model.KmAssetApplyReturn;
import com.landray.kmss.km.asset.model.KmAssetApplyReturnList;
import com.landray.kmss.sys.formula.parser.FormulaParser;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunBaseGetFirstCharger {
	private static IGeesunBaseBxsjService geesunBaseBxsjService;
	public static IGeesunBaseBxsjService getGeesunBaseBxsjService() {
		if(geesunBaseBxsjService==null){
			geesunBaseBxsjService = (IGeesunBaseBxsjService) SpringBeanUtil.getBean("geesunBaseBxsjService");
		}
		return geesunBaseBxsjService;
	}
	
	/**
	 * 获取报销科目配置的对应负责人
	 * 
	 * @return
	 * @throws Exception
	 */
	public static List<SysOrgElement> getCharger(Object data, Object data1, String property) throws Exception {
		List<SysOrgElement> rtn = new ArrayList<SysOrgElement>();
		if(data instanceof List && data1 instanceof List){
			List<?> list = (List<?>) data;
			List<?> list1 = (List<?>) data1;
			for(int i = 0; i < list.size(); i ++){
				Object code = list.get(i);
				Object code1 = list1.get(i);
				if(code instanceof String && code1 instanceof String){
					GeesunBaseBxsj bxsj = getGeesunBaseBxsj((String)code, (String) code1);
					if ("second".equals(property) && null != bxsj) {
						rtn.addAll(bxsj.getFdSecondCharger());
					} else {
						if (null != bxsj) {
							rtn.addAll(bxsj.getFdFirstCharger());
						}
					}
				}
//				else{
//					Object object =PropertyUtils.getProperty(code, property);
//					if(object instanceof GeesunBaseBxsj){
//						GeesunBaseBxsj bxsj = (GeesunBaseBxsj)object;
//						rtn.addAll(bxsj.getFdFirstCharger());
//					}
//				}
			}
		}else{
			if(data instanceof String && data1 instanceof String){
				GeesunBaseBxsj bxsj = getGeesunBaseBxsj((String)data, (String)data1);
				if ("second".equals(property) && null != bxsj) {
					rtn.addAll(bxsj.getFdSecondCharger());
				} else {
					if (null != bxsj) {
						rtn.addAll(bxsj.getFdFirstCharger());
					}
				}
			}else{
				GeesunBaseBxsj bxsj = (GeesunBaseBxsj)data;
				if ("second".equals(property) && null != bxsj) {
					rtn.addAll(bxsj.getFdSecondCharger());
				} else {
					if (null != bxsj) {
						rtn.addAll(bxsj.getFdFirstCharger());
					}
				}
			}
		}
		return rtn;
	}
	
	/**
	 * 根据报销科目编码获取负责人信息
	 * @param twoAccountCode
	 * @param twoAccountCode
	 * @return
	 * @throws Exception
	 */
	public static GeesunBaseBxsj getGeesunBaseBxsj(String 
			twoAccountCode, String threeAccountCode) throws Exception {
		GeesunBaseBxsj bxsj = null;
		HQLInfo hql = new HQLInfo();
		hql.setWhereBlock("geesunBaseBxsj.fdRelateType=:fdRelateType and geesunBaseBxsj.fdTwoAccountCode=:fdTwoAccountCode and geesunBaseBxsj.fdRelateName=:fdRelateName");
		hql.setParameter("fdRelateType", "firstCharger");
		hql.setParameter("fdTwoAccountCode", twoAccountCode);
		hql.setParameter("fdRelateName", threeAccountCode);
		List<GeesunBaseBxsj> bxsjList = getGeesunBaseBxsjService().findList(hql);
		if (!ArrayUtil.isEmpty(bxsjList)) {
			bxsj = bxsjList.get(0);
		}
		return bxsj;
	}
	
	/**
	 * 判断资产类别是否存在param参数的值
	 * @param param
	 * @return
	 */
	public static boolean getAssetCate(String param) {
		boolean flag = false;
		Object object = FormulaParser.getRunningData();
		if (object instanceof KmAssetApplyGet) {
			KmAssetApplyGet get = (KmAssetApplyGet) object;
			List<KmAssetApplyGetList> getLists = get.getFdItems();
			if (!ArrayUtil.isEmpty(getLists)) {
				for (KmAssetApplyGetList getList: getLists) {
					if (null != getList.getFdAssetCard() && param.equals(getList.getFdAssetCard().getFdAssetCategory().getFdName())) {
						flag = true;
						break;
					}
				}
			}
		} else if (object instanceof KmAssetApplyReturn) {
			KmAssetApplyReturn re = (KmAssetApplyReturn) object;
			List<KmAssetApplyReturnList> reLists = re.getFdApplyReturnList();
			if (!ArrayUtil.isEmpty(reLists)) {
				for (KmAssetApplyReturnList reList: reLists) {
					if (null != reList.getFdAssetCard() && param.equals(reList.getFdAssetCard().getFdAssetCategory().getFdName())) {
						flag = true;
						break;
					}
				}
			}
		} else if (object instanceof KmAssetApplyIn) {
			KmAssetApplyIn in = (KmAssetApplyIn) object;
			List<KmAssetApplyInList> inLists = in.getKmAssetApplyInList();
			if (!ArrayUtil.isEmpty(inLists)) {
				for (KmAssetApplyInList inList: inLists) {
					if (null != inList.getFdAssetCategory() && param.equals(inList.getFdAssetCategory().getFdName())) {
						flag = true;
						break;
					}
				}
			}
		} else if (object instanceof KmAssetApplyRent) {
			KmAssetApplyRent rent = (KmAssetApplyRent) object;
			List<KmAssetApplyRentList> rentLists = rent.getFdApplyRentList();
			if (!ArrayUtil.isEmpty(rentLists)) {
				for (KmAssetApplyRentList rentList: rentLists) {
					if (null != rentList.getFdAssetCard() && param.equals(rentList.getFdAssetCard().getFdAssetCategory().getFdName())) {
						flag = true;
						break;
					}
				}
			}
		} else if (object instanceof KmAssetApplyDivert) {
			KmAssetApplyDivert divert = (KmAssetApplyDivert) object;
			List<KmAssetApplyDivertList> divertLists = divert.getFdItems();
			if (!ArrayUtil.isEmpty(divertLists)) {
				for (KmAssetApplyDivertList divertList: divertLists) {
					if (null != divertList.getFdAssetCard() && param.equals(divertList.getFdAssetCard().getFdAssetCategory().getFdName())) {
						flag = true;
						break;
					}
				}
			}
		} else if (object instanceof KmAssetApplyRepair) {
			KmAssetApplyRepair repair = (KmAssetApplyRepair) object;
			List<KmAssetApplyRepairList> repairLists = repair.getFdItems();
			if (!ArrayUtil.isEmpty(repairLists)) {
				for (KmAssetApplyRepairList repairList: repairLists) {
					if (null != repairList.getFdAssetCard() && param.equals(repairList.getFdAssetCard().getFdAssetCategory().getFdName())) {
						flag = true;
						break;
					}
				}
			}
		} else if (object instanceof KmAssetApplyChange) {
			KmAssetApplyChange change = (KmAssetApplyChange) object;
			List<KmAssetApplyChangeList> changeLists = change.getFdApplyChangeList();
			if (!ArrayUtil.isEmpty(changeLists)) {
				for (KmAssetApplyChangeList changeList: changeLists) {
					if (null != changeList.getFdAssetCard() && param.equals(changeList.getFdAssetCard().getFdAssetCategory().getFdName())) {
						flag = true;
						break;
					}
				}
			}
		} else if (object instanceof KmAssetApplyDeal) {
			KmAssetApplyDeal deal = (KmAssetApplyDeal) object;
			List<KmAssetApplyDealList> dealLists = deal.getFdApplyDealList();
			if (!ArrayUtil.isEmpty(dealLists)) {
				for (KmAssetApplyDealList dealList: dealLists) {
					if (null != dealList.getFdAssetCard() && param.equals(dealList.getFdAssetCard().getFdAssetCategory().getFdName())) {
						flag = true;
						break;
					}
				}
			}
		}
		return flag;
	}
	
}
