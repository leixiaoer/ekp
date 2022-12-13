package com.landray.kmss.geesun.oitems.service.spring;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReceiveContext;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecord;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsBudgerApplicationService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsTempletService;
import com.landray.kmss.geesun.oitems.util.GeesunOitemsTitleUtil;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.number.interfaces.ISysNumberFlowService;
import com.landray.kmss.sys.number.model.SysNumberMain;
import com.landray.kmss.sys.number.service.ISysNumberMainMappService;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.NumberUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.util.excel.Column;
import com.landray.kmss.util.excel.ExcelOutput;
import com.landray.kmss.util.excel.ExcelOutputImp;
import com.landray.kmss.util.excel.Sheet;
import com.landray.kmss.util.excel.WorkBook;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 部门预算申请业务接口实现
 */
public class GeesunOitemsBudgerApplicationServiceImp extends ExtendDataServiceImp
		implements IGeesunOitemsBudgerApplicationService {

	private ISysNumberFlowService sysNumberFlowService;

	public void setSysNumberFlowService(
			ISysNumberFlowService sysNumberFlowService) {
		this.sysNumberFlowService = sysNumberFlowService;
	}

	private ISysNumberMainMappService sysNumberMainMappService;

	public void setSysNumberMainMappService(
			ISysNumberMainMappService sysNumberMainMappService) {
		this.sysNumberMainMappService = sysNumberMainMappService;
	}

	private IGeesunOitemsTempletService geesunOitemsTempletService;

	public void setGeesunOitemsTempletService(
			IGeesunOitemsTempletService geesunOitemsTempletService) {
		this.geesunOitemsTempletService = geesunOitemsTempletService;
	}

	@Override
	protected IBaseModel convertBizFormToModel(IExtendForm form,
			IBaseModel model, ConvertorContext context) throws Exception {
		model = super.convertBizFormToModel(form, model, context);
		if (model instanceof GeesunOitemsBudgerApplication) {
			GeesunOitemsBudgerApplication geesunOitemsBudgerApplication = (GeesunOitemsBudgerApplication) model;
			SysNumberMain sysNumberMain = (SysNumberMain) sysNumberMainMappService
					.getSysNumberMain(
							ModelUtil.getModelClassName(
									geesunOitemsBudgerApplication),
							geesunOitemsBudgerApplication.getFdTemplate()
									.getFdId());
			if (sysNumberMain != null
					&& geesunOitemsBudgerApplication.getDocNumber() == null
					&& !geesunOitemsBudgerApplication.getDocStatus()
							.startsWith("1")) {
				geesunOitemsBudgerApplication.setDocNumber(sysNumberFlowService
						.generateFlowNumber(geesunOitemsBudgerApplication));
			}
		}
		return model;
	}

	@Override
	protected IBaseModel initBizModelSetting(RequestContext requestContext)
			throws Exception {
		GeesunOitemsBudgerApplication geesunOitemsBudgerApplication = new GeesunOitemsBudgerApplication();
		String templateId = requestContext.getParameter("templateId");
		if (StringUtil.isNotNull(templateId)) {
			GeesunOitemsTemplet fdTemplate = (GeesunOitemsTemplet) geesunOitemsTempletService
					.findByPrimaryKey(templateId);
			if (fdTemplate != null) {
				geesunOitemsBudgerApplication.setFdTemplate(fdTemplate);
				geesunOitemsBudgerApplication
						.setFdType(fdTemplate.getFdTempletType().toString());
				geesunOitemsBudgerApplication.setDocCreator(UserUtil.getUser());
				geesunOitemsBudgerApplication.setDocCreateTime(new Date());
				geesunOitemsBudgerApplication.setFdLastModifiedTime(new Date());
			}
		}
		return geesunOitemsBudgerApplication;
	}

	@Override
	protected void initCoreServiceFormSetting(IExtendForm form,
			IBaseModel model, RequestContext requestContext) throws Exception {
		GeesunOitemsBudgerApplication geesunOitemsBudgerApplication = (GeesunOitemsBudgerApplication) model;
		dispatchCoreService.initFormSetting(form, "geesunOitemsTemplet",
				geesunOitemsBudgerApplication.getFdTemplate(), "geesunOitemsTemplet",
				requestContext);
	}

	@Override
	public String add(IBaseModel modelObj) throws Exception {
		GeesunOitemsBudgerApplication mainModel = (GeesunOitemsBudgerApplication) modelObj;
		mainModel.setTitleRegulation(mainModel.getFdTemplate().getTitleRegulation());
		// 根据标题规则生成标题
		GeesunOitemsTitleUtil.genTitle(modelObj);
		String fdId = super.add(modelObj);
		return fdId;
	}
	
	@Override
	public void update(IBaseModel modelObj) throws Exception {
		GeesunOitemsBudgerApplication mainModel = (GeesunOitemsBudgerApplication) modelObj;
		mainModel.setTitleRegulation(mainModel.getFdTemplate().getTitleRegulation());
		// 根据标题规则生成标题
		GeesunOitemsTitleUtil.genTitle(modelObj);
		super.update(modelObj);
	}
	
	/*
	 * 库存导出
	 */
	public void export(HttpServletResponse response, Map geesunOitemsListingMap,
			String title) throws Exception {
		// 导出Excel表

		/* 创建WorkBook、Sheet */
		WorkBook workbook = new WorkBook();
		Locale chinaLocale = new Locale("zh", "ZH");
		workbook.setLocale(chinaLocale);
		workbook.setBundle("geesun-oitems");
		workbook.setFilename(title);
		Sheet sheet = new Sheet();
		sheet.setTitle(title);
		/* 创建列标题 */
		Column[] col = new Column[9];
		for (int i = 0; i < col.length; i++) {
			col[i] = new Column();
		}
		col[0].setTitleKey("geesunOitemsListing.fdNo");
		col[1].setTitleKey("geesunOitemsListing.fdName");
		col[2].setTitleKey("geesunOitemsListing.fdCategoryId");
		col[3].setTitleKey("geesunOitemsListing.fdSpecification");
		col[4].setTitleKey("geesunOitemsListing.fdBrand");
		col[5].setTitleKey("geesunOitemsListing.fdUnit");
		col[6].setTitleKey("geesunOitemsListing.fdReferencePrice.inprice.last");
		col[7].setTitleKey("geesunOitemsListing.number");
		col[8].setTitleKey("geesunOitemsListing.fdAmount.money");
		for (int i = 0; i < col.length; i++)
			sheet.addColumn(col[i]);

		/* 创建表数据 */
		List contentList = new ArrayList();
		DecimalFormat df = new DecimalFormat("#.00");
		Iterator iterator = geesunOitemsListingMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = (String) iterator.next();
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) geesunOitemsListingMap
					.get(key);
			Object[] row = new Object[9];
			row[0] = geesunOitemsListing.getFdNo();
			row[1] = geesunOitemsListing.getFdName();
			if (geesunOitemsListing.getFdCategory() != null) {
				row[2] = geesunOitemsListing.getFdCategory().getFdName();
			} else {
				row[2] = "";
			}
			row[3] = geesunOitemsListing.getFdSpecification();
			row[4] = geesunOitemsListing.getFdBrand();
			row[5] = geesunOitemsListing.getFdUnit();
			if (null != geesunOitemsListing.getFdReferencePrice()) {
				row[6] = NumberUtil.roundDecimal(geesunOitemsListing
						.getFdReferencePrice());
			} else {
				row[6] = "";
			}
			row[7] = geesunOitemsListing.getFdAmount();
//			String amounts = NumberUtil.roundDecimal(geesunOitemsListing.getFdAmount()* geesunOitemsListing.getFdReferencePrice());
			Double amounts = 0.00d;
			if(null != geesunOitemsListing && null != geesunOitemsListing.getGeesunOitemsWarehousingRecordJoinListList() &&
					geesunOitemsListing.getGeesunOitemsWarehousingRecordJoinListList().size()>0) {
				for (Object object: geesunOitemsListing.getGeesunOitemsWarehousingRecordJoinListList()) {
					if(null == object) {
						continue;
					}
					GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = (GeesunOitemsWarehousingRecordJoinList) object;
					amounts = amounts+ geesunOitemsWarehousingRecordJoinList.getFdCurNumber()*geesunOitemsWarehousingRecordJoinList.getFdPrice();
				}
			}
			row[8] = df.format(amounts);

			contentList.add(row);
		}

		sheet.setContentList(contentList);
		// 将工作表添加到workbook
		workbook.setFilename(title);
		workbook.addSheet(sheet);
		/* 导出Excel */
		ExcelOutput output = new ExcelOutputImp();
		output.output(workbook, response);

	}

	/*
	 * 入库导出
	 */
	public void exportInCount(HttpServletResponse response,
			Map geesunOitemsWarehousingRecordMap, String title) throws Exception {
		// 导出Excel表

		/* 创建WorkBook、Sheet */
		WorkBook workbook = new WorkBook();
		Locale chinaLocale = new Locale("zh", "ZH");
		workbook.setLocale(chinaLocale);
		workbook.setBundle("geesun-oitems");
		workbook.setFilename(title);
		Sheet sheet = new Sheet();
		sheet.setTitle(title);
		/* 创建列标题 */
		Column[] col = new Column[9];
		for (int i = 0; i < col.length; i++) {
			col[i] = new Column();
		}
		col[0].setTitleKey("geesunOitemsListing.fdNo");
		col[1].setTitleKey("geesunOitemsListing.fdName");
		col[2].setTitleKey("geesunOitemsListing.fdCategoryId");
		col[3].setTitleKey("geesunOitemsListing.fdSpecification");
		col[4].setTitleKey("geesunOitemsListing.fdBrand");
		col[5].setTitleKey("geesunOitemsListing.fdReferencePrice.inprice");
		col[6].setTitleKey("geesunOitemsListing.number");
		col[7].setTitleKey("geesunOitemsListing.fdUnit");
		col[8].setTitleKey("geesunOitemsListing.fdAmount.money");
		for (int i = 0; i < col.length; i++)
			sheet.addColumn(col[i]);

		/* 创建表数据 */
		List contentList = new ArrayList();
		Iterator iterator = geesunOitemsWarehousingRecordMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = (String) iterator.next();
			GeesunOitemsWarehousingRecord geesunOitemsWarehousingRecord = (GeesunOitemsWarehousingRecord) geesunOitemsWarehousingRecordMap
					.get(key);
			Object[] row = new Object[9];
			row[0] = geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdNo();
			row[1] = geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdName();
			if (geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdCategory() != null) {
				row[2] = geesunOitemsWarehousingRecord.getGeesunOitemsListing()
						.getFdCategory().getFdName();
			} else {
				row[2] = "";
			}
			row[3] = geesunOitemsWarehousingRecord.getGeesunOitemsListing()
					.getFdSpecification();
			row[4] = geesunOitemsWarehousingRecord.getGeesunOitemsListing()
					.getFdBrand();
			if (null != geesunOitemsWarehousingRecord.getFdPrice()) {
				row[5] = NumberUtil.roundDecimal(geesunOitemsWarehousingRecord
						.getFdPrice());
			} else {
				row[5] = "";
			}
			row[6] = geesunOitemsWarehousingRecord.getFdNumber();
			row[7] = geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdUnit();
			row[8] = NumberUtil.roundDecimal(geesunOitemsWarehousingRecord
					.getFdNumber()
					* geesunOitemsWarehousingRecord.getFdPrice());
			contentList.add(row);
		}

		sheet.setContentList(contentList);
		// 将工作表添加到workbook
		workbook.setFilename(title);
		workbook.addSheet(sheet);
		/* 导出Excel */
		ExcelOutput output = new ExcelOutputImp();
		output.output(workbook, response);

	}

	/*
	 * 导出
	 */
	public void exportOutCount(HttpServletResponse response,
			Map geesunOitemsShoppingTrolleyMap, String title) throws Exception {
		// 导出Excel表

		/* 创建WorkBook、Sheet */
		WorkBook workbook = new WorkBook();
		Locale chinaLocale = new Locale("zh", "ZH");
		workbook.setLocale(chinaLocale);
		workbook.setBundle("geesun-oitems");
		workbook.setFilename(title);
		Sheet sheet = new Sheet();
		sheet.setTitle(title);
		/* 创建列标题 */
		Column[] col = new Column[9];
		for (int i = 0; i < col.length; i++) {
			col[i] = new Column();
		}
		col[0].setTitleKey("geesunOitemsListing.fdNo");
		col[1].setTitleKey("geesunOitemsListing.fdName");
		col[2].setTitleKey("geesunOitemsListing.fdCategoryId");
		col[3].setTitleKey("geesunOitemsListing.fdSpecification");
		col[4].setTitleKey("geesunOitemsListing.fdBrand");
		col[5].setTitleKey("geesunOitemsListing.fdReferencePrice.outprice");
		col[6].setTitleKey("geesunOitemsListing.number");
		col[7].setTitleKey("geesunOitemsListing.fdUnit");
		col[8].setTitleKey("geesunOitemsListing.fdAmount.money");
		for (int i = 0; i < col.length; i++)
			sheet.addColumn(col[i]);

		/* 创建表数据 */
		List contentList = new ArrayList();
		Iterator iterator = geesunOitemsShoppingTrolleyMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = (String) iterator.next();
			GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley) geesunOitemsShoppingTrolleyMap
					.get(key);
			Object[] row = new Object[9];
			row[0] = geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdNo();
			row[1] = geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdName();
			if (geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdCategory() != null) {
				row[2] = geesunOitemsShoppingTrolley.getGeesunOitemsListing()
						.getFdCategory().getFdName();
			} else {
				row[2] = "";
			}
			row[3] = geesunOitemsShoppingTrolley.getGeesunOitemsListing()
					.getFdSpecification();
			row[4] = geesunOitemsShoppingTrolley.getFdBrand();

			if (null != geesunOitemsShoppingTrolley.getFdReferencePrice()) {
				row[5] = NumberUtil.roundDecimal(geesunOitemsShoppingTrolley
						.getFdReferencePrice());
			} else {
				row[5] = "";
			}
			row[6] = geesunOitemsShoppingTrolley.getFdApplicationNumber();
			row[7] = geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdUnit();
			row[8] = NumberUtil.roundDecimal(geesunOitemsShoppingTrolley
					.getFdApplicationNumber()
					* geesunOitemsShoppingTrolley.getFdReferencePrice());

			contentList.add(row);
		}

		sheet.setContentList(contentList);
		// 将工作表添加到workbook
		workbook.setFilename(title);
		workbook.addSheet(sheet);
		/* 导出Excel */
		ExcelOutput output = new ExcelOutputImp();
		output.output(workbook, response);

	}

	public void exportReceive(HttpServletResponse response,
			List<GeesunOitemsReceiveContext> rtnList, String title)
			throws Exception {
		// 导出Excel表

		/* 创建WorkBook、Sheet */
		WorkBook workbook = new WorkBook();
		Locale chinaLocale = new Locale("zh", "ZH");
		workbook.setLocale(chinaLocale);
		workbook.setBundle("geesun-oitems");
		workbook.setFilename(title);
		Sheet sheet = new Sheet();
		sheet.setTitle(title);
		/* 创建列标题 */
		Column[] col = new Column[11];
		for (int i = 0; i < col.length; i++) {
			col[i] = new Column();
		}
		col[0].setTitleKey("geesunOitemsListing.fdNo");
		col[1].setTitleKey("geesunOitemsListing.fdName");
		col[2].setTitleKey("geesunOitemsListing.fdCategoryId");
		col[3].setTitleKey("geesunOitemsListing.fdSpecification");
		col[4].setTitleKey("geesunOitemsListing.fdBrand");
		col[5].setTitleKey("geesunOitemsListing.fdReferencePrice");
		col[6].setTitleKey("geesunOitemsListing.fdAmount");
		col[7].setTitleKey("geesunOitemsListing.application.number");
		col[8].setTitleKey("geesunOitemsListing.fdUnit");
		col[9].setTitleKey("geesunOitemsListing.application.number.balance");
		col[10].setTitleKey("geesunOitemsListing.application.fdAmount.money");
		for (int i = 0; i < col.length; i++)
			sheet.addColumn(col[i]);

		/* 创建表数据 */
		List contentList = new ArrayList();
		Iterator iterator = rtnList.iterator();
		while (iterator.hasNext()) {
			GeesunOitemsReceiveContext geesunOitemsReceiveContext = (GeesunOitemsReceiveContext) iterator
					.next();
			GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = (GeesunOitemsWarehousingRecordJoinList) geesunOitemsReceiveContext
					.getGeesunOitemsWarehousingRecordJoinList();
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) geesunOitemsWarehousingRecordJoinList
					.getGeesunOitemsListing();
			Object[] row = new Object[11];
			row[0] = geesunOitemsListing.getFdNo();
			row[1] = geesunOitemsListing.getFdName();
			if (geesunOitemsListing.getFdCategory() != null) {
				row[2] = geesunOitemsListing.getFdCategory().getFdName();
			} else {
				row[2] = "";
			}
			row[3] = geesunOitemsListing.getFdSpecification();
			row[4] = geesunOitemsListing.getFdBrand();

			if (null != geesunOitemsWarehousingRecordJoinList.getFdPrice()) {
				row[5] = NumberUtil
						.roundDecimal(geesunOitemsWarehousingRecordJoinList
								.getFdPrice());
			} else {
				row[5] = "";
			}
			row[6] = geesunOitemsWarehousingRecordJoinList.getFdCurNumber();

			// if(null!=geesunOitemsWarehousingRecordJoinList.getFdPrice()){
			// row[8] =
			// NumberUtil.roundDecimal(geesunOitemsWarehousingRecordJoinList.getFdNumber()*geesunOitemsWarehousingRecordJoinList.getFdPrice());
			// }else{
			// row[8] ="";
			// }

			if (null != geesunOitemsListing.getFdReferencePrice()) {
				row[7] = geesunOitemsReceiveContext.getFdReceiveAmount();
			} else {
				row[7] = "";
			}
			row[8] = geesunOitemsListing.getFdUnit();

			row[9] = geesunOitemsWarehousingRecordJoinList.getFdCurNumber()
					- geesunOitemsReceiveContext.getFdReceiveAmount();

			if (null != geesunOitemsWarehousingRecordJoinList.getFdPrice()) {
				row[10] = NumberUtil.roundDecimal(geesunOitemsReceiveContext
						.getFdReceiveAmount()
						* geesunOitemsWarehousingRecordJoinList.getFdPrice());
			} else {
				row[10] = "";
			}

			contentList.add(row);
		}

		sheet.setContentList(contentList);
		// 将工作表添加到workbook
		workbook.setFilename(title);
		workbook.addSheet(sheet);
		/* 导出Excel */
		ExcelOutput output = new ExcelOutputImp();
		output.output(workbook, response);

	}

	// /**
	// * 部门预算统计
	// */
	// public Map count(HttpServletRequest request) throws Exception {
	// String budgerWhereBlock = "" ;
	// HQLInfo budgerHqlInfo = new HQLInfo();
	// String fdStartTime = request.getParameter("fdStartTime");
	// if(StringUtil.isNotNull(fdStartTime)){
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsBudgerApplication.docCreateTime>=:budgerBeginDate",
	// " and ", budgerWhereBlock); ;
	// budgerHqlInfo.setParameter("budgerBeginDate", new SimpleDateFormat(
	// ResourceUtil.getString("date.format.date"))
	// .parse(fdStartTime));
	// }
	// String fdEndTime = request.getParameter("fdEndTime");
	// if(StringUtil.isNotNull(fdEndTime)){
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsBudgerApplication.docCreateTime>=:budgerEndTime",
	// " and ", budgerWhereBlock);
	// budgerHqlInfo.setParameter("budgerEndTime", new SimpleDateFormat(
	// ResourceUtil.getString("date.format.date"))
	// .parse(fdEndTime));
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
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsListing.fdCategory.fdId in ("+categoryIds+")",
	// " and ", budgerWhereBlock);
	// }
	// String fdDeptId = request.getParameter("fdDeptId");
	// if(StringUtil.isNotNull(fdDeptId)){
	// String[] fdDeptIds = fdDeptId.split(";");
	// String deptIds ="" ;
	// for(int i=0;i<fdDeptIds.length;i++){
	// deptIds = deptIds+"'"+fdDeptIds[i]+"'," ;
	// }
	// if(!"".equals(deptIds)){
	// deptIds = deptIds.substring(0, deptIds.lastIndexOf(","));
	// }
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsBudgerApplication.fdApplyor.fdId in ("+deptIds+")",
	// " and ", budgerWhereBlock);
	// }
	// budgerWhereBlock =
	// StringUtil.linkString("geesunOitemsBudgerListing.geesunOitemsBudgerApplication.docStatus='30' and geesunOitemsBudgerListing.geesunOitemsBudgerApplication.fdOutStatus='0'",
	// " and ", budgerWhereBlock);
	// budgerHqlInfo.setWhereBlock(budgerWhereBlock);
	// List geesunOitemsBudgerListingList =
	// geesunOitemsBudgerListingService.findList(budgerHqlInfo);
	// //map 是物品唯一
	// Map map = new HashMap();
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

}
