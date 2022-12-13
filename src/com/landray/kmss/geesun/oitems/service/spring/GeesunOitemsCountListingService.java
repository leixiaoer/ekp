package com.landray.kmss.geesun.oitems.service.spring;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.constant.SysOrgConstant;
import com.landray.kmss.geesun.oitems.interfaces.Constants;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsMonthReport;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReportListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsBudgerApplicationService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsMonthReportService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

/***
 * 月统计报表
 * 
 * @author susy
 * 
 */
public class GeesunOitemsCountListingService implements IXMLDataBean {

	private IGeesunOitemsBudgerApplicationService geesunOitemsBudgerApplicationService;

	private IGeesunOitemsMonthReportService geesunOitemsMonthReportService;

	private ISysOrgCoreService sysOrgCoreService;

	private Log logger = LogFactory.getLog(this.getClass());

	public List getDataList(RequestContext requestInfo) throws Exception {
		String fdYear = requestInfo.getParameter("fdYear");
		String fdMonth = requestInfo.getParameter("fdMonth");
		String fdType = requestInfo.getParameter("fdType");
		String containPerson = requestInfo.getParameter("containPerson");
		List result = new ArrayList();
		Date begin = null;
		Date end = null;
		String lang = UserUtil.getUser().getFdDefaultLang();
		if (("English|en-US".equalsIgnoreCase(lang)
				|| "English".equalsIgnoreCase(lang) || "en-US"
				.equalsIgnoreCase(lang))||(ResourceUtil.getLocaleStringByUser().indexOf("en")>-1)){
		// 当前月份首日期
		begin = DateUtil.convertStringToDate(fdMonth + "/01/" + fdYear
				+ " 00:00", ResourceUtil.getString("date.format.datetime"));
		// 月尾日期
		end = DateUtil.convertStringToDate(fdMonth + "/"+getMonLastDay(begin)+"/" + fdYear
				+" 23:59", ResourceUtil
				.getString("date.format.datetime"));
		}else{
			// 当前月份首日期
			 begin = DateUtil.convertStringToDate(fdYear + "-" + fdMonth
					+ "-01 00:00", ResourceUtil.getString("date.format.datetime"));
			// 月尾日期
			end = DateUtil.convertStringToDate(fdYear + "-" + fdMonth + "-"
					+ getMonLastDay(begin) + " 23:59", ResourceUtil
					.getString("date.format.datetime"));
			
		}
		Map<String, String> resultMap = new HashMap<String, String>();
		if ("2".equals(fdType)) {
			if (countDept(begin, end, containPerson, requestInfo)) {
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "failure");
			}
		} else {
			// 个人统计
			if (countPerson(begin, end, requestInfo)) {
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "failure");
			}
		}
		result.add(resultMap);
		return result;
	}

	// 统计个人月领用报表
	private Boolean countPerson(Date monthBegin, Date monthEnd,
			RequestContext requestInfo) throws Exception {
		try {
			// 人员or部门ids
			String fdDeptId = requestInfo.getParameter("fdDeptId");
			// 标题
			String docSubject = requestInfo.getParameter("docSubject");
			HQLInfo hqlInfo = new HQLInfo();
			StringBuffer sb = new StringBuffer();
			// 查找部门、人员
			String[] fdOrgIds = ArrayUtil.toStringArray(fdDeptId.split(";"));
			List<SysOrgElement> orgList = sysOrgCoreService
					.findByPrimaryKeys(fdOrgIds);
			List<String> personList = new ArrayList<String>();
			for (SysOrgElement element : orgList) {
				if (SysOrgConstant.ORG_TYPE_DEPT == element.getFdOrgType()) {
					personList.addAll(sysOrgCoreService.findAllChildrenItem(
							element, SysOrgConstant.ORG_TYPE_PERSON,
							"sysOrgElement.fdId"));
				} else {
					personList.add(element.getFdId());
				}
			}
			sb
					.append("geesunOitemsBudgerApplication.fdType=:fdType and (geesunOitemsBudgerApplication.docStatus='30' or geesunOitemsBudgerApplication.docStatus='31')");
			sb
					.append(" and geesunOitemsBudgerApplication.fdOutTime>=:beginDate and geesunOitemsBudgerApplication.fdOutTime<=:endDate");
			if(personList.size()>1){
				for(int i=0;i<personList.size();i++){
					if(i==0){
						sb
								.append(" and (geesunOitemsBudgerApplication.fdApplyor.fdHierarchyId like :param"
										+ i);
						hqlInfo.setParameter("param" + i, "%"
								+ personList.get(i) + "%");
					}else if(i==personList.size()-1){
						sb
								.append(" or geesunOitemsBudgerApplication.fdApplyor.fdHierarchyId like :param"
										+ i + ")");
						hqlInfo.setParameter("param" + i, "%"
								+ personList.get(i) + "%");
				    }else{
						sb
								.append(" or geesunOitemsBudgerApplication.fdApplyor.fdHierarchyId like :param"
										+ i);
						hqlInfo.setParameter("param" + i, "%"
								+ personList.get(i) + "%");
					}
				}
			}else{
				sb.append(" and geesunOitemsBudgerApplication.fdApplyor.fdHierarchyId like :param0");
				hqlInfo.setParameter("param0","%"+personList.get(0)+"%");
			}
			hqlInfo.setWhereBlock(sb.toString());
			hqlInfo.setParameter("fdType", Constants.GEESUNOITEMS_TYPE_PERSON);
			hqlInfo.setParameter("beginDate", monthBegin);
			hqlInfo.setParameter("endDate", monthEnd);
			List<GeesunOitemsBudgerApplication> geesunOitemsBudgerApplications = geesunOitemsBudgerApplicationService
					.findList(hqlInfo);
			if (geesunOitemsBudgerApplications.size() == 0) {
				return false;
			}
			// 获取月份
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(monthBegin);
			int month = calendar.get(Calendar.MONTH) + 1;
			GeesunOitemsMonthReport geesunOitemsMonthReport = new GeesunOitemsMonthReport();
			String title = null;
			if (StringUtil.isNull(docSubject)) {
				// 标题
				title = ResourceUtil.getString(
						"geesunOitemsMonthReport.setCocSubject", "geesun-oitems");
				String userName = "";
				if (orgList.size() > 1) {
					userName += orgList.get(0).getFdName()
							+ " 、"
							+ orgList.get(1).getFdName()
							+ ResourceUtil.getString("geesunOitemsMonthReport.etc",
									"geesun-oitems");
				}

				title = title.replace("{name}", userName).replace("{month}",
						month + "").replace("{year}",
						calendar.get(Calendar.YEAR) + "");
			} else {
				title = docSubject;
			}
			geesunOitemsMonthReport.setDocSubject(title);
			// 创建时间
			geesunOitemsMonthReport.setDocCreateTime(new Date());
			// 最后修改时间
			geesunOitemsMonthReport.setFdLastModifiedTime(new Date());
			// 所属部门
			geesunOitemsMonthReport.setDocDept(UserUtil.getKMSSUser().getPerson()
					.getFdParent());
			// 统计类型
			geesunOitemsMonthReport.setFdType(Constants.GEESUNOITEMS_TYPE_PERSON);
			// 创建人
			geesunOitemsMonthReport.setDocCreator(UserUtil.getKMSSUser()
					.getPerson());
			// 统计完成(设置属性)
			geesunOitemsMonthReport = this.setMonthReport(geesunOitemsMonthReport,
					geesunOitemsBudgerApplications);
			// 添加日志信息
			if (UserOperHelper.allowLogOper("geesunOitemsCountListingService",
					geesunOitemsMonthReportService.getModelName())) {
				UserOperHelper.setModelNameAndModelDesc(
						geesunOitemsMonthReportService.getModelName(),
						ResourceUtil.getString(
								"geesun-oitems:table.geesunOitemsMonthReport"));
				UserOperContentHelper.putAdd(geesunOitemsMonthReport, "docSubject",
						"docCreateTime", "fdLastModifiedTime", "docDept",
						"fdType", "docCreator", "fdAmount");
			}
			geesunOitemsMonthReportService.add(geesunOitemsMonthReport);
		} catch (Exception e) {
			logger.error("月统计报表生成报错", e);
			return false;
		}
		return true;
	}

	// 统计部门月领用报表
	private Boolean countDept(Date monthBegin, Date monthEnd,
			String isContainPerson, RequestContext requestInfo) {
		// 标题
		String docSubject = requestInfo.getParameter("docSubject");
		// 部门统计
		String fdDeptIds = requestInfo.getParameter("fdDeptId");
		// 将部门ID 转为List
		List<String> deptIdList = new ArrayList<String>();
		for (String fdDeptId : fdDeptIds.split(";")) {
			deptIdList.add(fdDeptId);
		}
		try {
			HQLInfo hqlInfo = new HQLInfo();
			StringBuffer sb = new StringBuffer();
			sb
					.append("geesunOitemsBudgerApplication.fdType=:fdType and (geesunOitemsBudgerApplication.docStatus='30' or geesunOitemsBudgerApplication.docStatus='31')");
			sb
					.append(" and geesunOitemsBudgerApplication.fdOutTime>=:beginDate and geesunOitemsBudgerApplication.fdOutTime<=:endDate");
			if(deptIdList.size()>1){
				for(int i=0;i<deptIdList.size();i++){
					if(i==0){
						sb
								.append(" and (geesunOitemsBudgerApplication.fdApplyor.fdHierarchyId like :param"
										+ i);
						hqlInfo.setParameter("param" + i, "%"
								+ deptIdList.get(i) + "%");
					}else if(i==deptIdList.size()-1){
						sb
								.append(" or geesunOitemsBudgerApplication.fdApplyor.fdHierarchyId like :param"
										+ i + ")");
						hqlInfo.setParameter("param" + i, "%"
								+ deptIdList.get(i) + "%");
				    }else{
						sb
								.append(" or geesunOitemsBudgerApplication.fdApplyor.fdHierarchyId like :param"
										+ i);
						hqlInfo.setParameter("param" + i, "%"
								+ deptIdList.get(i) + "%");
					}
				}
			}else{
				sb.append(" and geesunOitemsBudgerApplication.fdApplyor.fdHierarchyId like :param0");
				hqlInfo.setParameter("param0","%"+deptIdList.get(0)+"%");
			}
			hqlInfo.setWhereBlock(sb.toString());
			hqlInfo.setParameter("fdType", Constants.GEESUNOITEMS_TYPE_DEPT);
			hqlInfo.setParameter("beginDate", monthBegin);
			hqlInfo.setParameter("endDate", monthEnd);
			// 部门名义申请的
			List<GeesunOitemsBudgerApplication> geesunOitemsBudgerApplications = geesunOitemsBudgerApplicationService
					.findList(hqlInfo);
			// 个人名义申请但是属于部门的
			if ("true".equals(isContainPerson)) {
				geesunOitemsBudgerApplications.addAll(getOrgPersonReceive(
						monthBegin, monthEnd, fdDeptIds.split(";")));
			}
			if (geesunOitemsBudgerApplications.size() == 0) {
				return false;
			}
			// 获取月份
			Calendar calendar = Calendar.getInstance();
			// 部门
			calendar.setTime(monthBegin);
			int month = calendar.get(Calendar.MONTH) + 1;
			GeesunOitemsMonthReport geesunOitemsMonthReport = new GeesunOitemsMonthReport();
			String title = "";
			if (StringUtil.isNull(docSubject)) {
				// 标题
				title = ResourceUtil.getString(
						"geesunOitemsMonthReport.setCocSubject", "geesun-oitems");
				title = title
						.replace(
								"{name}",
								sysOrgCoreService.findByPrimaryKey(
										deptIdList.get(0)).getFdName()
										+ ResourceUtil.getString(
												"geesunOitemsMonthReport.etc",
												"geesun-oitems")).replace(
								"{month}", month + "").replace("{year}",
								calendar.get(Calendar.YEAR) + "");
			} else {
				title = docSubject;
			}
			geesunOitemsMonthReport.setDocSubject(title);
			// 创建时间
			geesunOitemsMonthReport.setDocCreateTime(new Date());
			// 最后修改时间
			geesunOitemsMonthReport.setFdLastModifiedTime(new Date());
			// 所属部门
			geesunOitemsMonthReport.setDocDept(UserUtil.getKMSSUser().getPerson()
					.getFdParent());
			// 统计类型
			geesunOitemsMonthReport.setFdType(Constants.GEESUNOITEMS_TYPE_DEPT);
			// 创建者
			geesunOitemsMonthReport.setDocCreator(UserUtil.getKMSSUser()
					.getPerson());
			// 统计完成
			geesunOitemsMonthReport = this.setMonthReport(geesunOitemsMonthReport,
					geesunOitemsBudgerApplications);
			// 添加日志信息
			if (UserOperHelper.allowLogOper("geesunOitemsCountListingService",
					geesunOitemsMonthReportService.getModelName())) {
				UserOperHelper.setModelNameAndModelDesc(
						geesunOitemsMonthReportService.getModelName(),
						ResourceUtil.getString(
								"geesun-oitems:table.geesunOitemsMonthReport"));
				UserOperContentHelper.putAdd(
						geesunOitemsMonthReport, "docSubject",
						"docCreateTime", "fdLastModifiedTime", "docDept",
						"fdType", "docCreator", "fdAmount");
			}
			geesunOitemsMonthReportService.add(geesunOitemsMonthReport);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("月统计报表生成报错", e);
			return false;
		}
		return true;
	}

	/***
	 * 获取当月最后一天
	 * 
	 * @param begin
	 * @return
	 */
	private int getMonLastDay(Date begin) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(begin);
		int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		return lastDay;
	}

	/***
	 * 设置月统计报表
	 * 
	 * @param srcMonthReport
	 * @param geesunOitemsBudgerApplication
	 * @return
	 */
	private GeesunOitemsMonthReport setMonthReport(
			GeesunOitemsMonthReport srcMonthReport,
			List<GeesunOitemsBudgerApplication> applications) {
		for (GeesunOitemsBudgerApplication geesunOitemsBudgerApplication : applications) {
			for (int i = 0; i < geesunOitemsBudgerApplication
					.getGeesunOitemsShoppingTrolleyList().size(); i++) {
				GeesunOitemsReportListing listing = new GeesunOitemsReportListing();
				GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley) geesunOitemsBudgerApplication
						.getGeesunOitemsShoppingTrolleyList().get(i);
				if (geesunOitemsShoppingTrolley.getFdApplicationNumber() != null) {
					// 数量
					listing.setFdCount(geesunOitemsShoppingTrolley.getFdApplicationNumber().longValue());
					// 名称
					if (geesunOitemsShoppingTrolley.getGeesunOitemsListing() != null) {
						GeesunOitemsListing geesunOitemsListing = geesunOitemsShoppingTrolley.getGeesunOitemsListing();
						// 分类名
						if (geesunOitemsListing.getFdCategory() != null) {
							listing.setFdCategory(geesunOitemsListing.getFdCategory().getFdName());
						}
						listing.setFdName(geesunOitemsListing.getFdName());
						// 单位
						listing.setFdUnit(geesunOitemsListing.getFdUnit());
					}
					// 单价
					Double price = null;
					if (null == geesunOitemsShoppingTrolley.getGeesunOitemsWarehousingRecordJoinList()) {
						if (geesunOitemsShoppingTrolley.getGeesunOitemsListing() != null) {
							price = geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdReferencePrice();
						}
					} else {
						price = geesunOitemsShoppingTrolley.getFdReferencePrice();
					}
					listing.setFdReferencePrice(price);
					if (price != null) {
						BigDecimal bd1 = new BigDecimal(Double.toString(price));
						BigDecimal bd2 = new BigDecimal(
								Integer.toString(geesunOitemsShoppingTrolley.getFdApplicationNumber()));
						// 金额
						listing.setFdAmount(bd1.multiply(bd2).doubleValue());
					} else {
						listing.setFdAmount(null);
					}

					// 创建者
					listing.setDocCreator(geesunOitemsBudgerApplication.getFdApplyor());
					// 个人申请单
					if (2 == geesunOitemsBudgerApplication.getFdTemplate().getFdTempletType()) {
						listing.setDocDept(geesunOitemsBudgerApplication.getDocDept());
					}
					// 部门申请单
					else {
						listing.setDocDept(geesunOitemsBudgerApplication.getFdApplyor());
					}
					// 添加到统计表
					srcMonthReport.addGeesunOitemsReportListing(listing);
					// 总计
					if (null == srcMonthReport.getFdAmount()) {
						srcMonthReport.setFdAmount(listing.getFdAmount());
					} else {
						if (listing.getFdAmount() != null) {
							BigDecimal bd3 = new BigDecimal(Double.toString(srcMonthReport.getFdAmount()));
							BigDecimal bd4 = new BigDecimal(Double.toString(listing.getFdAmount()));
							srcMonthReport.setFdAmount(bd3.add(bd4).doubleValue());
						}
					}
				}
			}
		}
		return srcMonthReport;
	}

	/***
	 * 获取部门人员领用表
	 * 
	 * @param monthBegin
	 * @param monthEnd
	 * @param fdDeptId
	 * @return
	 * @throws Exception
	 */
	private List<GeesunOitemsBudgerApplication> getOrgPersonReceive(
			Date monthBegin, Date monthEnd, String[] fdDeptIds)
			throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		StringBuffer sb = new StringBuffer();

		sb
				.append("geesunOitemsBudgerApplication.fdType=:fdType and (geesunOitemsBudgerApplication.docStatus='30' or geesunOitemsBudgerApplication.docStatus='31')");
		sb
				.append(" and geesunOitemsBudgerApplication.fdOutTime>=:beginDate and geesunOitemsBudgerApplication.fdOutTime<=:endDate");
		if(fdDeptIds.length>1){
			for(int i=0;i<fdDeptIds.length;i++){
				if(i==0){
					sb
							.append(" and (geesunOitemsBudgerApplication.docDept.fdHierarchyId like :param"
									+ i);
					hqlInfo.setParameter("param" + i, "%" + fdDeptIds[i] + "%");
				}else if(i==fdDeptIds.length-1){
					sb
							.append(" or geesunOitemsBudgerApplication.docDept.fdHierarchyId like :param"
									+ i + ")");
					hqlInfo.setParameter("param" + i, "%" + fdDeptIds[i] + "%");
			    }else{
					sb
							.append(" or geesunOitemsBudgerApplication.docDept.fdHierarchyId like :param"
									+ i);
					hqlInfo.setParameter("param" + i, "%" + fdDeptIds[i] + "%");
				}
			}
		}else{
			sb.append(" and geesunOitemsBudgerApplication.docDept.fdHierarchyId like :param0");
			hqlInfo.setParameter("param0","%"+fdDeptIds[0]+"%");
		}
		
		
		hqlInfo.setWhereBlock(sb.toString());
		hqlInfo.setParameter("fdType", Constants.GEESUNOITEMS_TYPE_PERSON);
		hqlInfo.setParameter("beginDate", monthBegin);
		hqlInfo.setParameter("endDate", monthEnd);
		List<GeesunOitemsBudgerApplication> geesunOitemsBudgerApplications = geesunOitemsBudgerApplicationService
				.findList(hqlInfo);
		return geesunOitemsBudgerApplications;
	}

	public void setGeesunOitemsBudgerApplicationService(
			IGeesunOitemsBudgerApplicationService geesunOitemsBudgerApplicationService) {
		this.geesunOitemsBudgerApplicationService = geesunOitemsBudgerApplicationService;
	}

	public void setGeesunOitemsMonthReportService(
			IGeesunOitemsMonthReportService geesunOitemsMonthReportService) {
		this.geesunOitemsMonthReportService = geesunOitemsMonthReportService;
	}

	public void setSysOrgCoreService(ISysOrgCoreService sysOrgCoreService) {
		this.sysOrgCoreService = sysOrgCoreService;
	}

}
