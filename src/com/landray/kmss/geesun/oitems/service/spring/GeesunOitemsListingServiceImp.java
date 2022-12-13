package com.landray.kmss.geesun.oitems.service.spring;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFComment;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.IndexedColors;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.geesun.oitems.dao.IGeesunOitemsWarehousingRecordJoinListDao;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsManage;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReceiveContext;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecord;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsShoppingTrolleyService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordService;
import com.landray.kmss.sys.attachment.model.SysAttMain;
import com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 用品清单管理业务接口实现
 */
public class GeesunOitemsListingServiceImp extends BaseServiceImp implements
		IGeesunOitemsListingService {
	private Logger logger = Logger.getLogger(GeesunOitemsListingServiceImp.class);
	private IGeesunOitemsWarehousingRecordService geesunOitemsWarehousingRecordService;

	public void setGeesunOitemsWarehousingRecordService(
			IGeesunOitemsWarehousingRecordService geesunOitemsWarehousingRecordService) {
		this.geesunOitemsWarehousingRecordService = geesunOitemsWarehousingRecordService;
	}

	private IGeesunOitemsShoppingTrolleyService geesunOitemsShoppingTrolleyService;

	public void setGeesunOitemsShoppingTrolleyService(
			IGeesunOitemsShoppingTrolleyService geesunOitemsShoppingTrolleyService) {
		this.geesunOitemsShoppingTrolleyService = geesunOitemsShoppingTrolleyService;
	}

	private IGeesunOitemsWarehousingRecordJoinListDao geesunOitemsWarehousingRecordJoinListDao;

	public void setGeesunOitemsWarehousingRecordJoinListDao(
			IGeesunOitemsWarehousingRecordJoinListDao geesunOitemsWarehousingRecordJoinListDao) {
		this.geesunOitemsWarehousingRecordJoinListDao = geesunOitemsWarehousingRecordJoinListDao;
	}

	/**
	 * 入库统计
	 */
	public LinkedHashMap inCount(HttpServletRequest request) throws Exception {
		// add by 刘声斌 date:2010-04-27 增加默认开始，结束时间点
		String startTimeStr = " 00:00:00";
		String endTimeStr = " 23:59:59";

		String whereBlock = "";
		HQLInfo hqlInfo = new HQLInfo();
		String fdStartTime = (String) request.getParameter("fdStartTime");
		if (StringUtil.isNotNull(fdStartTime)) {
			fdStartTime = fdStartTime + startTimeStr;
			whereBlock = StringUtil.linkString(
					"geesunOitemsWarehousingRecord.docCreateTime>=:beginDate",
					" and ", whereBlock);
			hqlInfo.setParameter("beginDate", new SimpleDateFormat(ResourceUtil
					.getString("date.format.datetime")).parse(fdStartTime));
		}
		String fdEndTime = (String) request.getParameter("fdEndTime");
		if (StringUtil.isNotNull(fdEndTime)) {
			fdEndTime = fdEndTime + endTimeStr;
			whereBlock = StringUtil.linkString(
					"geesunOitemsWarehousingRecord.docCreateTime<=:fdEndTime",
					" and ", whereBlock);
			hqlInfo.setParameter("fdEndTime", new SimpleDateFormat(ResourceUtil
					.getString("date.format.datetime")).parse(fdEndTime));
		}
		String fdCategoryId = request.getParameter("fdCategoryId");
		//if (StringUtil.isNotNull(fdCategoryId)) {
			// getWhereBlockByFdCategoryId(request);
			// String[] fdCategoryIds = fdCategoryId.split(";");
			whereBlock = StringUtil
					.linkString(
							whereBlock,
							" and ",
							getWhereBlockByFdCategoryId(request,
									"geesunOitemsWarehousingRecord.geesunOitemsListing.fdCategory.fdId"));

			// String categoryIds = "";
			// for (int i = 0; i < fdCategoryIds.length; i++) {
			// categoryIds = categoryIds + "'" + fdCategoryIds[i] + "',";
			// }
			// if (!"".equals(categoryIds)) {
			// categoryIds = categoryIds.substring(0, categoryIds
			// .lastIndexOf(","));
			// }
			// whereBlock = StringUtil.linkString(
			// "geesunOitemsWarehousingRecord.geesunOitemsListing.fdCategory.fdId in("
			// + categoryIds + ")", " and ", whereBlock);
		//}
		if (StringUtil.isNull(whereBlock)) {
			whereBlock = "1=2";
		}
		hqlInfo.setWhereBlock(whereBlock);
		hqlInfo.setOrderBy(" geesunOitemsListing.fdNo desc ");
		List geesunOitemsWarehousingRecordList = geesunOitemsWarehousingRecordService
				.findList(hqlInfo);
		LinkedHashMap map = new LinkedHashMap();
		for (int i = 0; i < geesunOitemsWarehousingRecordList.size(); i++) {
			GeesunOitemsWarehousingRecord geesunOitemsWarehousingRecord = (GeesunOitemsWarehousingRecord) geesunOitemsWarehousingRecordList
					.get(i);
			if (map.get(geesunOitemsWarehousingRecord.getGeesunOitemsListing()
					.getFdId()
					+ "-" + geesunOitemsWarehousingRecord.getFdPrice()) == null) {
				map.put(geesunOitemsWarehousingRecord.getGeesunOitemsListing()
						.getFdId()
						+ "-" + geesunOitemsWarehousingRecord.getFdPrice(),
						geesunOitemsWarehousingRecord);
				// 添加日志信息
				UserOperHelper
						.logFind(geesunOitemsWarehousingRecord.getGeesunOitemsListing());
			} else {
				GeesunOitemsWarehousingRecord geesunOitemsWarehousingRecordBef = (GeesunOitemsWarehousingRecord) map
						.get(geesunOitemsWarehousingRecord.getGeesunOitemsListing()
								.getFdId()
								+ "-" + geesunOitemsWarehousingRecord.getFdPrice());
				geesunOitemsWarehousingRecordBef
						.setFdNumber(geesunOitemsWarehousingRecordBef.getFdNumber()
								+ geesunOitemsWarehousingRecord.getFdNumber());
				map.remove(geesunOitemsWarehousingRecordBef.getGeesunOitemsListing()
						.getFdId()
						+ "-" + geesunOitemsWarehousingRecordBef.getFdPrice());
				map.put(geesunOitemsWarehousingRecord.getGeesunOitemsListing()
						.getFdId()
						+ "-" + geesunOitemsWarehousingRecord.getFdPrice(),
						geesunOitemsWarehousingRecordBef);
			}
		}
		return map;
	}

	/**
	 * 出库统计,统计部门申请出库和个人申请出库
	 */
	// public Map outCount(HttpServletRequest request) throws Exception {
	// String personalWhereBlock = "" ;
	// String budgerWhereBlock = "" ;
	// HQLInfo personalHqlInfo = new HQLInfo();
	// HQLInfo budgerHqlInfo = new HQLInfo();
	// String fdStartTime = request.getParameter("fdStartTime");
	// if(StringUtil.isNotNull(fdStartTime)){
	// personalWhereBlock =
	// StringUtil.linkString("geesunOitemsApplicationListing.geesunOitemsGetApplication.docCreateTime>=:personalBeginDate",
	// " and ", personalWhereBlock); ;
	// personalHqlInfo.setParameter("personalBeginDate", new SimpleDateFormat(
	// ResourceUtil.getString("date.format.date"))
	// .parse(fdStartTime));
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsBudgerApplication.docCreateTime>=:budgerBeginDate",
	// " and ", budgerWhereBlock); ;
	// budgerHqlInfo.setParameter("budgerBeginDate", new SimpleDateFormat(
	// ResourceUtil.getString("date.format.date"))
	// .parse(fdStartTime));
	// }
	// String fdEndTime = request.getParameter("fdEndTime");
	// if(StringUtil.isNotNull(fdEndTime)){
	// personalWhereBlock =
	// StringUtil.linkString("geesunOitemsApplicationListing.geesunOitemsGetApplication.docCreateTime<=:personalEndTime",
	// " and ", personalWhereBlock);
	// personalHqlInfo.setParameter("personalEndTime", new SimpleDateFormat(
	// ResourceUtil.getString("date.format.date"))
	// .parse(fdEndTime));
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsBudgerApplication.docCreateTime>=:budgerEndTime",
	// " and ", budgerWhereBlock);
	// budgerHqlInfo.setParameter("budgerEndTime", new SimpleDateFormat(
	// ResourceUtil.getString("date.format.date"))
	// .parse(fdEndTime));
	// }
	// String fdDeptId = request.getParameter("fdDeptId");
	// if(StringUtil.isNotNull(fdDeptId)){
	// //部门为多选
	// String[] fdDeptIds = fdDeptId.split(";");
	// String deptIds ="" ;
	// for(int i=0;i<fdDeptIds.length;i++){
	// deptIds = deptIds+"'"+fdDeptIds[i]+"'," ;
	// }
	// if(!"".equals(deptIds)){
	// deptIds = deptIds.substring(0, deptIds.lastIndexOf(","));
	// }
	// personalWhereBlock =
	// StringUtil.linkString("geesunOitemsApplicationListing.geesunOitemsGetApplication.fdApplyor.fdId in ("+deptIds+")",
	// " and ", personalWhereBlock);
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsBudgerApplication.fdApplyor.fdId in ("+deptIds+")",
	// " and ", budgerWhereBlock);
	// }
	// String fdCategoryId = request.getParameter("fdCategoryId");
	// if(StringUtil.isNotNull(fdCategoryId)){
	// String[] fdCategoryIds = fdCategoryId.split(",");
	// String categoryIds ="" ;
	// for(int i=0;i<fdCategoryIds.length;i++){
	// categoryIds = categoryIds+"'"+fdCategoryIds[i]+"'," ;
	// }
	// if(!"".equals(categoryIds)){
	// categoryIds = categoryIds.substring(0, categoryIds.lastIndexOf(","));
	// }
	// personalWhereBlock =
	// StringUtil.linkString("geesunOitemsApplicationListing.geesunOitemsListing.fdCategory.fdId in("+categoryIds+")",
	// " and ", personalWhereBlock);
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsListing.fdCategory.fdId in ("+categoryIds+")",
	// " and ", budgerWhereBlock);
	// }
	// personalWhereBlock =
	// StringUtil.linkString("geesunOitemsApplicationListing.geesunOitemsGetApplication.docStatus='30' and geesunOitemsApplicationListing.geesunOitemsGetApplication.fdOutStatus='1'",
	// " and ", personalWhereBlock);
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsBudgerApplication.docStatus='30' and geesunOitemsBudgerListing.geesunOitemsBudgerApplication.fdOutStatus='1'",
	// " and ", budgerWhereBlock);
	// personalHqlInfo.setWhereBlock(personalWhereBlock);
	// budgerHqlInfo.setWhereBlock(budgerWhereBlock);
	// List geesunOitemsApplicationListingList =
	// geesunOitemsApplicationListingService.findList(personalHqlInfo);
	// List geesunOitemsBudgerListingList =
	// geesunOitemsBudgerListingService.findList(budgerHqlInfo);
	// Map map = new HashMap();
	// //统计个人申请
	// for(int i=0;i<geesunOitemsApplicationListingList.size();i++){
	// GeesunOitemsApplicationListing geesunOitemsApplicationListing
	// =(GeesunOitemsApplicationListing)geesunOitemsApplicationListingList.get(i);
	// if(geesunOitemsApplicationListing.getGeesunOitemsGetApplication()!=null){
	// GeesunOitemsListing geesunOitemsListing =
	// geesunOitemsApplicationListing.getGeesunOitemsListing();
	// if(map.get(geesunOitemsListing.getFdId())==null){
	// geesunOitemsListing.setFdAmount(geesunOitemsApplicationListing.getFdApplicationNumber());
	// map.put(geesunOitemsListing.getFdId(), geesunOitemsListing);
	// }else{
	// GeesunOitemsListing geesunOitemsListingBefor =
	// (GeesunOitemsListing)map.get(geesunOitemsListing.getFdId());
	// geesunOitemsListingBefor.setFdAmount(geesunOitemsListingBefor.getFdAmount()+geesunOitemsApplicationListing.getFdApplicationNumber());
	// map.remove(geesunOitemsListingBefor.getFdId());
	// map.put(geesunOitemsListingBefor.getFdId(), geesunOitemsListingBefor);
	// }
	// }
	// }
	// //统计部门预算申请
	// for(int i=0;i<geesunOitemsBudgerListingList.size();i++){
	// GeesunOitemsBudgerListing geesunOitemsBudgerListing
	// =(GeesunOitemsBudgerListing)geesunOitemsBudgerListingList.get(i);
	// if(geesunOitemsBudgerListing.getGeesunOitemsBudgerApplication()!=null){
	// GeesunOitemsListing geesunOitemsListing =
	// geesunOitemsBudgerListing.getGeesunOitemsListing();
	// if(map.get(geesunOitemsListing.getFdId())==null){
	// geesunOitemsListing.setFdAmount(geesunOitemsBudgerListing.getFdApplicationNumber());
	// map.put(geesunOitemsListing.getFdId(), geesunOitemsListing);
	// }else{
	// GeesunOitemsListing geesunOitemsListingBefor =
	// (GeesunOitemsListing)map.get(geesunOitemsListing.getFdId());
	// geesunOitemsListingBefor.setFdAmount(geesunOitemsListingBefor.getFdAmount()+geesunOitemsBudgerListing.getFdApplicationNumber());
	// map.remove(geesunOitemsListingBefor.getFdId());
	// map.put(geesunOitemsListingBefor.getFdId(), geesunOitemsListingBefor);
	// }
	// }
	// }
	// return map;
	// }
	public LinkedHashMap outCount(HttpServletRequest request) throws Exception {
		// add by 刘声斌 date:2010-04-27 增加默认开始，结束时间点
		String startTimeStr = " 00:00:00";
		String endTimeStr = " 23:59:59";
		HQLInfo hql = new HQLInfo();
		String whereBlock = " ";
		whereBlock = StringUtil.linkString(getWhereBlockByFdStartTime(request),
				" and ", whereBlock);
		whereBlock = StringUtil.linkString(getWhereBlockByFdEndTime(request),
				" and ", whereBlock);
		whereBlock = StringUtil.linkString(getWhereBlockByFdCategoryId(request,
				"geesunOitemsShoppingTrolley.geesunOitemsListing.fdCategory.fdId"),
				" and ", whereBlock);
		whereBlock = StringUtil.linkString(getWhereBlockByFdDeptId(request),
				" and ", whereBlock);
		String fdStartTime = (String) request.getParameter("fdStartTime");
		String fdEndTime = (String) request.getParameter("fdEndTime");
		if (StringUtil.isNotNull(fdStartTime)) {
			fdStartTime = fdStartTime + startTimeStr;
			Date startDate = DateUtil.convertStringToDate(fdStartTime,
					DateUtil.TYPE_DATETIME, Locale.getDefault());
			hql.setParameter("fdStartTime", startDate);

		}
		if (StringUtil.isNotNull(fdEndTime)) {
			fdEndTime = fdEndTime + endTimeStr;
			Date endDate = DateUtil.convertStringToDate(fdEndTime,
					DateUtil.TYPE_DATETIME, Locale.getDefault());
			hql.setParameter("fdEndTime", endDate);
		}
		if (StringUtil.isNull(whereBlock)) {
			whereBlock = "1=2";
		}
		whereBlock += " and geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docStatus ='31'";
		hql.setWhereBlock(whereBlock);
		hql.setOrderBy(" geesunOitemsListing.fdNo desc ");
		List trolleyList = geesunOitemsShoppingTrolleyService.findList(hql);
		LinkedHashMap map = new LinkedHashMap();
		for (int i = 0; i < trolleyList.size(); i++) {
			GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley) trolleyList
					.get(i);
			if (geesunOitemsShoppingTrolley.getGeesunOitemsBudgerApplication() != null) {
				if (map.get(geesunOitemsShoppingTrolley.getGeesunOitemsListing()
						.getFdId()
						+ "-" + geesunOitemsShoppingTrolley.getFdReferencePrice()) == null) {
					map.put(geesunOitemsShoppingTrolley.getGeesunOitemsListing()
							.getFdId()
							+ "-"
							+ geesunOitemsShoppingTrolley.getFdReferencePrice(),
							geesunOitemsShoppingTrolley);
					// 添加日志信息
					UserOperHelper.logFind(geesunOitemsShoppingTrolley.getGeesunOitemsListing());
				} else {
					GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolleybef = (GeesunOitemsShoppingTrolley) map
							.get(geesunOitemsShoppingTrolley.getGeesunOitemsListing()
									.getFdId()
									+ "-"
									+ geesunOitemsShoppingTrolley
											.getFdReferencePrice());
					if (geesunOitemsShoppingTrolley.getFdApplicationNumber() == null) {
						geesunOitemsShoppingTrolley.setFdApplicationNumber(0);
					}
					if (geesunOitemsShoppingTrolleybef.getFdAmount() == null) {
						geesunOitemsShoppingTrolleybef.setFdAmount(0);
					}
					geesunOitemsShoppingTrolleybef
							.setFdApplicationNumber(geesunOitemsShoppingTrolleybef
									.getFdApplicationNumber()
									+ geesunOitemsShoppingTrolley
											.getFdApplicationNumber());
					map.remove(geesunOitemsShoppingTrolleybef.getGeesunOitemsListing()
							.getFdId()
							+ "-"
							+ geesunOitemsShoppingTrolley.getFdReferencePrice());
					map.put(geesunOitemsShoppingTrolley.getGeesunOitemsListing()
							.getFdId()
							+ "-"
							+ geesunOitemsShoppingTrolley.getFdReferencePrice(),
							geesunOitemsShoppingTrolleybef);
				}
			}
		}
		return map;
	}

	private String getWhereBlockByFdEndTime(HttpServletRequest request) {
		String fdEndTime = (String) request.getParameter("fdEndTime");
		String whereBlock = "";
		if (StringUtil.isNotNull(fdEndTime)) {
			whereBlock = "geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdOutTime <= :fdEndTime";
		}
		return whereBlock;
	}

	private String getWhereBlockByFdStartTime(HttpServletRequest request) {
		String fdStartTime = (String) request.getParameter("fdStartTime");
		String whereBlock = "";
		if (StringUtil.isNotNull(fdStartTime)) {
			whereBlock = "geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdOutTime >= :fdStartTime";
		}
		return whereBlock;
	}

	private String getWhereBlockByFdCategoryId(HttpServletRequest request,
			String linkString) throws Exception {
		String whereBlock = "";
		String[] categoryIds = null;
		List<String> elementIdList = new ArrayList<String>();
		Set<GeesunOitemsManage> elementSet = new HashSet<GeesunOitemsManage>();
		String fdCategoryId = request.getParameter("fdCategoryId");
		IGeesunOitemsManageService geesunOitemsManageService = (IGeesunOitemsManageService) SpringBeanUtil
				.getBean("geesunOitemsManageService");
		if (StringUtil.isNull(fdCategoryId)) {
			//return whereBlock;
			//add 如果fdCategoryId==null 按照类别管理员过滤数据
			HQLInfo hql = new HQLInfo();
			hql.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
			hql.setSelectBlock(" fdId ");
			List<String> list = geesunOitemsManageService.findList(hql);
			categoryIds = (String[]) list.toArray(new String[list.size()]);
		} else {
			categoryIds = fdCategoryId.split(";");
		}
		if (null == categoryIds || categoryIds.length <= 0) {
			return "1 = 0";
		}

		for (int i = 0; i < categoryIds.length; i++) {
			String id = categoryIds[i];
			GeesunOitemsManage geesunOitemsManage = (GeesunOitemsManage) geesunOitemsManageService
					.findByPrimaryKey(id);
			List elementList = geesunOitemsManageService.findList(
					"geesunOitemsManage.fdHierarchyId like '"
							+ geesunOitemsManage.getFdHierarchyId() + "%'", null);
			elementSet.addAll(elementList);
		}

		for (java.util.Iterator<GeesunOitemsManage> itera = elementSet.iterator(); itera
				.hasNext();) {
			GeesunOitemsManage manage = itera.next();
			elementIdList.add(manage.getFdId());
		}
		whereBlock = HQLUtil.buildLogicIN(linkString, elementIdList);

		return whereBlock;
	}

	public String getWhereBlockByFdDeptId(HttpServletRequest request)
			throws Exception {
		String whereBlock = "";
		String fdDeptId = request.getParameter("fdDeptId");
		List<String> elementIdList = new ArrayList<String>();
		Set<SysOrgElement> elementSet = new HashSet<SysOrgElement>();
		if (StringUtil.isNull(fdDeptId)) {
			return whereBlock;
		}
		String[] deptIds = fdDeptId.split(";");
		for (int i = 0; i < deptIds.length; i++) {
			String id = deptIds[i];
			ISysOrgElementService sysOrgElementService = (ISysOrgElementService) SpringBeanUtil
					.getBean("sysOrgElementService");
			SysOrgElement sysOrgElement = (SysOrgElement) sysOrgElementService
					.findByPrimaryKey(id);
			List elementList = sysOrgElementService.findList(
					"sysOrgElement.fdHierarchyId like '"
							+ sysOrgElement.getFdHierarchyId() + "%'", null);
			elementSet.addAll(elementList);
		}
		for (java.util.Iterator<SysOrgElement> itera = elementSet.iterator(); itera
				.hasNext();) {
			SysOrgElement elementObj = itera.next();
			elementIdList.add(elementObj.getFdId());
		}
		whereBlock = HQLUtil
				.buildLogicIN(
						"geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdApplyor.fdId",
						elementIdList);

		return whereBlock;
	}

	public List<GeesunOitemsReceiveContext> findReceiveCount(
			HttpServletRequest request) throws Exception {

		String sql = "select geesunOitemsShoppingTrolley.geesunOitemsWarehousingRecordJoinList.fdId , sum(geesunOitemsShoppingTrolley.fdApplicationNumber) as number "
				+ "  from GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley where geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdId is not null and  geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docStatus = '30' ";
		String fdCategoryId = (String) request.getAttribute("fdCategoryId");
		String fdStartTime = (String) request.getAttribute("fdStartTime");
		String fdEndTime = (String) request.getAttribute("fdEndTime");
		String fdDeptId = (String) request.getAttribute("fdDeptId");
		//if (StringUtil.isNotNull(fdCategoryId)) {
			sql = StringUtil
					.linkString(
							sql,
							" and ",
							getWhereBlockByFdCategoryId(request,
									"geesunOitemsShoppingTrolley.geesunOitemsListing.fdCategory.fdId"));
		//}
		if (StringUtil.isNotNull(fdStartTime)) {
			String whereBlock = "geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docCreateTime >= :fdStartTime";
			sql = StringUtil.linkString(sql, " and ", whereBlock);
		}
		if (StringUtil.isNotNull(fdEndTime)) {
			String whereBlock = "geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docCreateTime <= :fdEndTime";
			sql = StringUtil.linkString(sql, " and ", whereBlock);
		}
		if (StringUtil.isNotNull(fdDeptId)) {
			sql = StringUtil.linkString(sql, " and ",
					getWhereBlockByFdDeptId(request));
		}
		sql = sql
				+ " group by geesunOitemsShoppingTrolley.geesunOitemsWarehousingRecordJoinList.fdId order by max(geesunOitemsShoppingTrolley.fdNo) desc";

		request.setAttribute("sql", sql);
		List<GeesunOitemsReceiveContext> rtnList = geesunOitemsWarehousingRecordJoinListDao
				.findReceiveCount(request);
		return rtnList;
	}

	// 删除的同时删除库存记录
	@SuppressWarnings("unchecked")
	public void delete(IBaseModel modelObj) throws Exception {
		UserOperHelper.logDelete(modelObj);// 添加日志信息
		if (dispatchCoreService != null)
			dispatchCoreService.delete(modelObj);
		GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) modelObj;
		String whereBlock = "geesunOitemsWarehousingRecord.geesunOitemsListing.fdId='"
				+ geesunOitemsListing.getFdId() + "'";
		List<GeesunOitemsWarehousingRecord> recordList = geesunOitemsWarehousingRecordService
				.findList(whereBlock, null);
		if (!recordList.isEmpty()) {
			for (int i = 0; i < recordList.size(); i++) {
				geesunOitemsWarehousingRecordService.delete(recordList.get(i)
						.getFdId());
			}
		}
		// 删除未申请的关联数据(购物车)
		List<GeesunOitemsShoppingTrolley> trolleys = geesunOitemsShoppingTrolleyService.findList(
				"geesunOitemsListing.fdId = '" + geesunOitemsListing.getFdId() + "' and geesunOitemsBudgerApplication is null", null);
		if (CollectionUtils.isNotEmpty(trolleys)) {
			for (GeesunOitemsShoppingTrolley trolley : trolleys) {
				geesunOitemsShoppingTrolleyService.delete(trolley);
			}
		}
		getBaseDao().delete(geesunOitemsListing);
	}

	protected ISysAttMainCoreInnerService sysAttMainService;

	public void setSysAttMainService(
			ISysAttMainCoreInnerService sysAttMainService) {
		this.sysAttMainService = sysAttMainService;
	}
	@Override
	public String getPicIdsByListingId(String fdId) throws Exception {
		try {
			List<SysAttMain> attMainList = new ArrayList<SysAttMain>();
			StringBuffer sb = new StringBuffer();
			attMainList = this.sysAttMainService.findByModelKey(
					"com.landray.kmss.geesun.oitems.model.GeesunOitemsListing", fdId,
					"geesunOitemsListing");
			if (!ArrayUtil.isEmpty(attMainList)) {
				for (int i = 0; i < attMainList.size(); i++) {
					SysAttMain sysAttMain = attMainList.get(i);
					if (i == attMainList.size() - 1) {
						sb.append(sysAttMain.getFdId());
					} else {
						sb.append(sysAttMain.getFdId()).append(";");
					}
				}
			}
			return sb.toString();
		} catch (Exception e) {
			logger.error("获取用品图片失败", e);
			throw e;
		}
	}

	@Override
	public String checkUnique(String fdNo,String fdListingId) throws Exception {
		String repeat = "false";
		HQLInfo hql = new HQLInfo();
		String wb = "geesunOitemsListing.fdNo =:fdNo ";
		hql.setParameter("fdNo", fdNo);
		if (StringUtil.isNotNull(fdListingId)) { 
			wb += " and geesunOitemsListing.fdId<>:fdListingId"; 
			hql.setParameter("fdListingId", fdListingId);
		} 
		hql.setWhereBlock(wb);
		List l = this.findList(hql);
		if (l.size() > 0) {
			repeat = "true";
		}
		return repeat;
	}

	@Override
	public void downloadTemplate(HttpServletRequest request,
			HttpServletResponse response)
			throws Exception {
		response.reset();
		response.setContentType("application/vnd.ms-excel; charset=UTF-8");
		String filename = ResourceUtil
				.getString("geesun-oitems:geesunOitems.import.template.filename");
		filename = encodeFileName(request, filename) + ".xls";
		// 火狐导出excel的时候，如果文件名含有空格，会截断后面的字符串，导致下载下来的文件无法解析 by zhugr 2017-11-09
		response.addHeader("Content-Disposition", "attachment;filename=\""
				+ filename + "\"");

		// 开始构建excel模板
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		// 列标题样式
		HSSFCellStyle titleStyle = buildStyle(wb, "title");
		// 内容样式
		HSSFCellStyle contentStyle = buildStyle(wb, "content");
		// 列名
		String[] columns = new String[] {
				ResourceUtil.getString("geesun-oitems:geesunOitemsListing.fdNo"), // 编号
				ResourceUtil
						.getString("geesun-oitems:geesunOitemsListing.fdName"),
				ResourceUtil
						.getString("geesun-oitems:geesunOitemsListing.fdCategoryId"),
				ResourceUtil
						.getString("geesun-oitems:geesunOitemsListing.fdSpecification"),
				ResourceUtil
						.getString("geesun-oitems:geesunOitemsListing.fdBrand"),
				ResourceUtil
						.getString("geesun-oitems:geesunOitemsListing.fdUnit"),
				ResourceUtil
						.getString("geesun-oitems:geesunOitemsListing.number"),
				ResourceUtil
						.getString(
								"geesun-oitems:geesunOitemsListing.fdReferencePrice") };
		String[] contents = new String[] { "B001", "T50", "办公用品0", "2G", "IBM",
				"台", "2", "3800" };
		// 标题
		HSSFRow row = sheet.createRow(0);
		for (int i = 0; i < columns.length; i++) {
			HSSFCell cell = row.createCell(i);
			cell.setCellStyle(titleStyle);
			// 设置红色标注
			HSSFFont font = wb.createFont();
			HSSFFont bFont = wb.createFont();
			font.setColor(HSSFFont.COLOR_RED);
			bFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			HSSFRichTextString ts = new HSSFRichTextString(
					columns[i] + "(*)");
			ts.applyFont(columns[i].length() + 1, columns[i].length() + 2,
					font);
			ts.applyFont(columns[i].length() + 2, columns[i].length() + 3,
					bFont);
			cell.setCellValue(ts);
			sheet.setColumnWidth(i, 5000);
			// 设置注释(只有类别)
			if (i == 2) {
				HSSFPatriarch patr = sheet.createDrawingPatriarch();
				HSSFComment comment = patr
						.createComment(
								new HSSFClientAnchor(125, 125, 511,
										255, (short) i, i, (short) (i + 1),
										i + 4));
				String textStr = ResourceUtil.getString(
						"geesunOitems.import.category.tip",
						"geesun-oitems");
				comment.setString(new HSSFRichTextString(textStr));
				cell.setCellComment(comment);
			}
		}
		// 内容
		HSSFRow contentRow = sheet.createRow(1);
		for (int i = 0; i < contents.length; i++) {
			HSSFCell cell = contentRow.createCell(i);
			cell.setCellStyle(contentStyle);
			cell.setCellValue(contents[i]);
		}
		wb.write(response.getOutputStream());
	}

	private HSSFCellStyle buildStyle(HSSFWorkbook wb, String key) {
		HSSFCellStyle style = wb.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.index);
		style.setBottomBorderColor(IndexedColors.BLACK.index);
		style.setLeftBorderColor(IndexedColors.BLACK.index);
		style.setRightBorderColor(IndexedColors.BLACK.index);
		HSSFFont styleFont = wb.createFont();
		if ("title".equals(key)) {
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleFont.setFontHeightInPoints((short) 10);
			styleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		}
		styleFont.setFontName("微软雅黑");
		style.setFont(styleFont);
		return style;
	}

	/**
	 * 文件名编码
	 * 
	 * @param request
	 * @param oldFileName
	 * @param isEncode
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private static String encodeFileName(HttpServletRequest request,
			String oldFileName)
			throws UnsupportedEncodingException {
		String userAgent = request.getHeader("User-Agent").toUpperCase();
		if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("TRIDENT") > -1
				|| userAgent.indexOf("EDGE") > -1) {// ie情况处理
			oldFileName = URLEncoder.encode(oldFileName, "UTF-8");
			// 这里的编码后，空格会被解析成+，需要重新处理
			oldFileName = oldFileName.replace("+", "%20");
		} else {
			oldFileName = new String(oldFileName.getBytes("UTF-8"),
					"ISO8859-1");
		}
		return oldFileName;
	}

	@Override
	public GeesunOitemsListing findByFdNo(String fdNo) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setWhereBlock("geesunOitemsListing.fdNo = :fdNo");
		hqlInfo.setParameter("fdNo", fdNo);
		List<GeesunOitemsListing> list = findList(hqlInfo);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}
}
