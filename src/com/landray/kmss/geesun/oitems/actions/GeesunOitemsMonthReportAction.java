package com.landray.kmss.geesun.oitems.actions;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsMonthReportForm;
import com.landray.kmss.geesun.oitems.interfaces.Constants;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsMonthReport;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReportListing;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsMonthReportService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.sys.profile.util.OrgImportExportUtil;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.NumberUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 月统计表 Action
 * 
 * @author
 * @version 1.0 2011-11-23
 */
public class GeesunOitemsMonthReportAction extends ExtendAction {
	protected IGeesunOitemsMonthReportService geesunOitemsMonthReportService;

	protected IGeesunOitemsMonthReportService getServiceImp(
			HttpServletRequest request) {
		if (geesunOitemsMonthReportService == null)
			geesunOitemsMonthReportService = (IGeesunOitemsMonthReportService) getBean("geesunOitemsMonthReportService");
		return geesunOitemsMonthReportService;
	}

	@Override
	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		String fdType = request.getParameter("fdType");
		if ("person".equals(fdType)) {
			hqlInfo.setWhereBlock(" geesunOitemsMonthReport.fdType='"
					+ Constants.GEESUNOITEMS_TYPE_PERSON + "'");
		}
		if ("dept".equals(fdType)) {
			hqlInfo.setWhereBlock(" geesunOitemsMonthReport.fdType='"
					+ Constants.GEESUNOITEMS_TYPE_DEPT + "'");
		}
		CriteriaValue cv = new CriteriaValue(request);
		CriteriaUtil.buildHql(cv, hqlInfo, GeesunOitemsMonthReport.class);
	}

	/**
	 * 根据http请求，获取model，将model转化为form并返回。<br>
	 * URL中必须包含fdId参数，该参数为记录id。<br>
	 * 若获取model不成功，则抛出errors.norecord的错误信息。
	 * 
	 * @param form
	 * @param request
	 * @return form对象
	 * @throws Exception
	 */
	@Override
	protected void loadActionForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		form.reset(mapping, request);
		GeesunOitemsMonthReportForm rtnForm = null;
		String id = request.getParameter("fdId");
		if (!StringUtil.isNull(id)) {
			GeesunOitemsMonthReport model = (GeesunOitemsMonthReport) getServiceImp(
					request).findByPrimaryKey(id, null, true);
			if (model != null)
				UserOperHelper.logFind(model);// 添加日志信息
				rtnForm = (GeesunOitemsMonthReportForm) getServiceImp(request)
						.convertModelToForm((GeesunOitemsMonthReportForm) form,
								model, new RequestContext(request));
			// 明细表
			List<GeesunOitemsReportListing> listings = model
					.getGeesunOitemsReportListing();
			request.setAttribute("mapItem", getServiceImp(request)
					.groupListByPerson(listings));
			request.setAttribute("listSize", listings.size());
		}
		if (rtnForm == null)
			throw new NoRecordException();
		request.setAttribute(getFormName(rtnForm, request), rtnForm);
	}

	/**
	 * 月领用报表导出
	 */
	public void exportMonthReport(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fdId = request.getParameter("fdId");
		GeesunOitemsMonthReport monthReport = (GeesunOitemsMonthReport) getServiceImp(request).findByPrimaryKey(fdId);
		// 添加日志信息
		if (UserOperHelper.allowLogOper("exportMonthReport",
				getServiceImp(request).getModelName())) {
			UserOperHelper
					.setEventType(ResourceUtil.getString("button.export"));
			UserOperContentHelper.putFind(monthReport);
		}
		try {
			Map<String, List<GeesunOitemsReportListing>> mapItem = getServiceImp(
					request).groupListByPerson(
							monthReport.getGeesunOitemsReportListing());
			String title = monthReport.getDocSubject();
			HSSFWorkbook workbook = exportInCount(response, mapItem, title);
			response.setContentType("application/vnd.ms-excel; charset=UTF-8");
			response.addHeader("Content-Disposition", "attachment;filename=\""
					+ OrgImportExportUtil.encodeFileName(request, title)
					+ ".xls\"");
			workbook.write(response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private HSSFCellStyle buildCellStyle(HSSFWorkbook workbook, short weight) {
		HSSFCellStyle style = workbook.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.index);
		style.setBottomBorderColor(IndexedColors.BLACK.index);
		style.setLeftBorderColor(IndexedColors.BLACK.index);
		style.setRightBorderColor(IndexedColors.BLACK.index);
		HSSFFont font = workbook.createFont();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		font.setFontHeightInPoints((short) 10);
		font.setBoldweight(weight);
		style.setFont(font);
		return style;
	}

	private HSSFWorkbook exportInCount(HttpServletResponse response,
			Map<String, List<GeesunOitemsReportListing>> mapItem, String title)
			throws Exception {
		// 导出Excel表
		/* 创建WorkBook、Sheet */
		HSSFWorkbook workbook = new HSSFWorkbook();

		HSSFSheet sheet = workbook.createSheet(title);
		/* 创建表头 */
		String[] header = new String[9];
		header[0] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsMonthReport.receiveDept");
		header[1] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsMonthReport.receivePerson");
		header[2] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsMonthReport.subtotal");
		header[3] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsReportListing.fdCategory");
		header[4] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsReportListing.fdName");
		header[5] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsReportListing.fdUnit");
		header[6] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsReportListing.fdReferencePrice");
		header[7] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsReportListing.fdCount");
		header[8] = ResourceUtil
				.getString("geesun-oitems:geesunOitemsReportListing.fdAmount");
		HSSFRow firstRow = sheet.createRow(0);
		for (int i = 0; i < header.length; i++) {
			HSSFCell cell = firstRow.createCell(i);
			cell.setCellStyle(
					buildCellStyle(workbook, HSSFFont.BOLDWEIGHT_BOLD));
			cell.setCellValue(header[i]);
			sheet.setColumnWidth(i, 20 * 256);// 设置列的宽度
		}
		/* 创建表数据 */
		Set<Entry<String, List<GeesunOitemsReportListing>>> entrySet = mapItem
				.entrySet();
		Iterator<Entry<String, List<GeesunOitemsReportListing>>> iter = entrySet
				.iterator();
		int j = 1;
		HSSFCellStyle style = buildCellStyle(workbook,
				HSSFFont.BOLDWEIGHT_NORMAL);
		while (iter.hasNext()) {
			Entry<String, List<GeesunOitemsReportListing>> entry = iter.next();
			List<GeesunOitemsReportListing> listings = entry.getValue();
			Double subtotal = new Double(0);
			int size = listings.size();
			for (int k = 0; k < size; k++) {
				GeesunOitemsReportListing listing = listings.get(k);
				HSSFRow contentRow = sheet.createRow(j);
				HSSFCell cell = null;

				if (k == 0) {
					cell = contentRow.createCell(0);
					cell.setCellValue(listing.getDocDept().getDeptLevelNames());
					cell.setCellStyle(style);

					cell = contentRow.createCell(1);
					cell.setCellValue(
							listing.getDocCreator().getDeptLevelNames());
					cell.setCellStyle(style);
					// 小计
					for (GeesunOitemsReportListing listing2 : listings)
						subtotal += listing2.getFdAmount();
					cell = contentRow.createCell(2);
					cell.setCellValue(
							NumberUtil.roundDecimal(subtotal, "#.##"));
					cell.setCellStyle(style);
				}

				cell = contentRow.createCell(3);
				cell.setCellValue(listing.getFdCategory());
				cell.setCellStyle(style);

				cell = contentRow.createCell(4);
				cell.setCellValue(listing.getFdName());
				cell.setCellStyle(style);

				cell = contentRow.createCell(5);
				cell.setCellValue(listing.getFdUnit());
				cell.setCellStyle(style);

				cell = contentRow.createCell(6);
				cell.setCellValue(NumberUtil
						.roundDecimal(listing.getFdReferencePrice(), "#.##"));
				cell.setCellStyle(style);

				cell = contentRow.createCell(7);
				cell.setCellValue(listing.getFdCount());
				cell.setCellStyle(style);

				cell = contentRow.createCell(8);
				cell.setCellValue(
						NumberUtil.roundDecimal(listing.getFdAmount(), "#.##"));
				cell.setCellStyle(style);
				j++;
			}
			for (int i = 0; i < 3; i++) {
				CellRangeAddress region = new CellRangeAddress(j - size, j - 1,
						i, i);
				sheet.addMergedRegion(region);
				RegionUtil.setBorderBottom(1, region, sheet, workbook); // 下边框
				RegionUtil.setBorderLeft(1, region, sheet, workbook); // 左边框
				RegionUtil.setBorderRight(1, region, sheet, workbook); // 有边框
				RegionUtil.setBorderTop(1, region, sheet, workbook); // 上边框
			}
		}
		return workbook;
	}

}
