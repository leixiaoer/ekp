package com.landray.kmss.geesun.annual.service.spring;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.cfg.Environment;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualMainForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualConfig;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.model.GeesunAnnualReset;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualAlterService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualMainService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualResetService;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualUseService;
import com.landray.kmss.geesun.annual.util.CalculateUtil;
import com.landray.kmss.geesun.annual.util.GeesunAnnualConstant;
import com.landray.kmss.geesun.annual.util.GeesunAnnualUtil;
import com.landray.kmss.geesun.annual.util.GeesunImportMessage;
import com.landray.kmss.geesun.annual.util.StringUtils;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.admin.dbchecker.metadata.util.MetadataUtil;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.metadata.model.ExtendDataModelInfo;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.organization.service.ISysOrgPersonService;
import com.landray.kmss.sys.quartz.interfaces.ISysQuartzCoreService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzModelContext;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.upload.FormFile;

public class GeesunAnnualMainServiceImp extends ExtendDataServiceImp 
	implements IGeesunAnnualMainService, IXMLDataBean, GeesunAnnualConstant {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;
    
    private ISysQuartzCoreService sysQuartzCoreService;
	
	public ISysQuartzCoreService getSysQuartzCoreService() {
		if (null == sysQuartzCoreService) {
			sysQuartzCoreService = (ISysQuartzCoreService) SpringBeanUtil
					.getBean("sysQuartzCoreService");
		}
		return sysQuartzCoreService;
	}

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunAnnualMain) {
            GeesunAnnualMain geesunAnnualMain = (GeesunAnnualMain) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunAnnualMain geesunAnnualMain = new GeesunAnnualMain();
        geesunAnnualMain.setDocCreateTime(new Date());
        geesunAnnualMain.setDocCreator(UserUtil.getUser());
        geesunAnnualMain.setFdOwner(UserUtil.getUser());
        geesunAnnualMain.setDocDept(UserUtil.getUser().getFdParent());
        GeesunAnnualUtil.initModelFromRequest(geesunAnnualMain, requestContext);
        return geesunAnnualMain;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunAnnualMain geesunAnnualMain = (GeesunAnnualMain) model;
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
    
    protected ISysOrgCoreService sysOrgCoreService;
	
	public ISysOrgCoreService getSysOrgCoreService() {
		if (null == sysOrgCoreService) {
			sysOrgCoreService = (ISysOrgCoreService) SpringBeanUtil
					.getBean("sysOrgCoreService");
		}
		return sysOrgCoreService;
	}
	
	protected ISysOrgPersonService sysOrgPersonService;
	
	public ISysOrgPersonService getSysOrgPersonService() {
		if (null == sysOrgPersonService) {
			sysOrgPersonService = (ISysOrgPersonService) SpringBeanUtil
					.getBean("sysOrgPersonService");
		}
		return sysOrgPersonService;
	}
	
	protected IGeesunAnnualAlterService geesunAnnualAlterService;
	
	public IGeesunAnnualAlterService getGeesunAnnualAlterService() {
		if (null == geesunAnnualAlterService) {
			geesunAnnualAlterService = (IGeesunAnnualAlterService) SpringBeanUtil
					.getBean("geesunAnnualAlterService");
		}
		return geesunAnnualAlterService;
	}
	
	protected IGeesunAnnualUseService geesunAnnualUseService;
	
	public IGeesunAnnualUseService getGeesunAnnualUseService() {
		if (null == geesunAnnualUseService) {
			geesunAnnualUseService = (IGeesunAnnualUseService) SpringBeanUtil
					.getBean("geesunAnnualUseService");
		}
		return geesunAnnualUseService;
	}
	
	protected IGeesunAnnualResetService geesunAnnualResetService;
	
	public IGeesunAnnualResetService getGeesunAnnualResetService() {
		if (null == geesunAnnualResetService) {
			geesunAnnualResetService = (IGeesunAnnualResetService) SpringBeanUtil
					.getBean("geesunAnnualResetService");
		}
		return geesunAnnualResetService;
	}
	
	@Override
	public String add(IBaseModel modelObj) throws Exception {
		GeesunAnnualMain geesunAnnualMain = (GeesunAnnualMain) modelObj;
		SysOrgPerson owner = geesunAnnualMain.getFdOwner();
		if (owner != null) {
			Map<String, Object> map = owner.getCustomPropMap();
			Calendar c = Calendar.getInstance();
			Date fdRuzhiDate = (Date) map.get("ruzhiriqi");
			geesunAnnualMain.setFdOwnerNo(owner.getFdLoginName());
			geesunAnnualMain.setDocDept(owner.getFdParent());
			int year = c.get(Calendar.YEAR);
			c.setTime(fdRuzhiDate);
			c.set(Calendar.YEAR, year);
			if (c.getTime().before(new Date())) {
				c.add(Calendar.YEAR, +1);
			}
			geesunAnnualMain.setFdNextResetDate(c.getTime());
			//????????????????????????????????????????????????
			generateCommonQuartz(geesunAnnualMain, c.getTime());
			c.add(Calendar.YEAR, -1);
			geesunAnnualMain.setFdLastResetDate(c.getTime());
		}
		return super.add(geesunAnnualMain);
	}

	public List getDataList(RequestContext requestInfo) throws Exception {
		String ownerId = requestInfo.getParameter("ownerId");
		SysOrgPerson owner = (SysOrgPerson) getSysOrgPersonService().findByPrimaryKey(ownerId, 
				SysOrgPerson.class, true);
		if (null == owner) {
			return null;
		}
		List<Map<String, String>> rtnList = new ArrayList<Map<String, String>>();
		Map<String, String> node = new HashMap<String, String>();
		node.put("fdOwnerDeptId", owner.getFdParent().getFdId());
		node.put("fdOwnerDept", owner.getFdParent().getFdName());
		node.put("fdLoginName", owner.getFdLoginName());
		rtnList.add(node);
		return rtnList;
	}
	
	/**
	 * ??????????????????????????????
	 * @param fdOwnerId
	 * @param docCreateTime
	 * @return
	 * @throws Exception
	 */
	public GeesunAnnualMain getAnnualByApplyer(String 
			fdOwnerId) throws Exception {
		if (StringUtil.isNull(fdOwnerId)) {
			return null;
		}
		HQLInfo hql = new HQLInfo();
		hql.setWhereBlock("geesunAnnualMain.fdOwner.fdId=:fdOwnerId");
		hql.setParameter("fdOwnerId", fdOwnerId);
		List<GeesunAnnualMain> result = this.findList(hql);
		if (!ArrayUtil.isEmpty(result)) {
			return result.get(0);
		}
		return null;
	}
    
    /**
	 * @author guoyp
	 * ????????????????????????
	 * @param mainForm
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public List<GeesunImportMessage> saveImport(GeesunAnnualMainForm 
			mainForm, HttpServletRequest request) throws Exception {
		List<GeesunImportMessage> messages = new ArrayList<GeesunImportMessage>();
		FormFile file = mainForm.getTheFile();
		if (file.getFileSize() == 0) {
			GeesunImportMessage message = new GeesunImportMessage();
			message.addFailMsg(ResourceUtil.getString("geesunAnnualMain.excel.upload.excel.empty", "geesun-annual"));
			messages.add(message);
		} else {
			Sheet sheet = null;
			if (file.getFileName().toString().substring(file.getFileName().toString().length() - 4).equals(".xls")) {
				POIFSFileSystem fs = new POIFSFileSystem(file.getInputStream());
				HSSFWorkbook wb = new HSSFWorkbook(fs);
				sheet = wb.getSheetAt(0);
			} else if (file.getFileName().toString().substring(file.getFileName().toString().length() - 5).equals(".xlsx")) {
				XSSFWorkbook wb = new XSSFWorkbook(file.getInputStream());
				sheet = wb.getSheetAt(0);// ??????Excel???
			}
			// ??????????????????????????????
			List<GeesunAnnualMain> dataList = getImpotDataList(sheet, request);
			messages = this.save(dataList);
		}
		return messages;
	}

	/**
	 * ?????????????????????????????????GeesunAnnualMain??????????????????
	 * @param sheet
	 * @param request
	 * @return
	 * @throws Exception
	 */
	private List<GeesunAnnualMain> getImpotDataList(Sheet sheet, 
			HttpServletRequest request) throws Exception {
		List<GeesunAnnualMain> dataList = new ArrayList<GeesunAnnualMain>();
		boolean isNull = false;
		for (int i = 2; i <= sheet.getLastRowNum(); i++) {
			// ??????????????????
			Row row = sheet.getRow(i);
			if (row == null || StringUtils.isBlankRow(row) || row.getZeroHeight()) {
				continue;
			}
			GeesunAnnualMain geesunAnnualMain = new GeesunAnnualMain();
			geesunAnnualMain.setDocCreator(UserUtil.getUser());
			geesunAnnualMain.setDocCreateTime(new Date());
			// ?????????
			String cell0 = StringUtils.getCell(row, 1);
			if (null != cell0) {
				if (cell0.indexOf(".") != -1) {
					cell0 = cell0.split("\\.")[0];
				}
				HQLInfo hql = new HQLInfo();
				StringBuffer sb = new StringBuffer("fdLoginName=:fdLoginName and fdIsAvailable=:fdIsAvailable");
				hql.setWhereBlock(sb.toString());
				hql.setParameter("fdLoginName", cell0.trim());
				hql.setParameter("fdIsAvailable", Boolean.TRUE);
				List<SysOrgPerson> ownerList = getSysOrgPersonService().findList(hql);
				if (!ArrayUtil.isEmpty(ownerList)) {
					SysOrgPerson owner = ownerList.get(0);
					geesunAnnualMain.setFdOwnerNo(cell0.trim());
					geesunAnnualMain.setFdOwner(owner);//?????????
					geesunAnnualMain.setDocDept(owner.getFdParent());//??????
				} else {
					geesunAnnualMain.setFdOwner(null);
					isNull = true;
				}
			} else {
				isNull = true;
			}
			// ????????????
			String cell1 = StringUtils.getCell(row, 2);
			if (null != cell1) {
				if (StringUtil.isNotNull(cell1)) {
					geesunAnnualMain.setFdTotal(Double.valueOf(cell1));
				} else {
					geesunAnnualMain.setFdTotal(null);
					isNull = true;
				}
			} else {
				isNull = true;
			}
			
			dataList.add(geesunAnnualMain);
			if (isNull)
				break;
		}
		return dataList;
	}

	/**
	 * ?????????????????????????????????????????????
	 * 
	 * @param fszbBudgetMain
	 * @param rowNum
	 * @return
	 * @throws Exception
	 */
	private List<GeesunImportMessage> save(List<GeesunAnnualMain> dataList) throws Exception {
		List<GeesunImportMessage> messages = new ArrayList<GeesunImportMessage>();
		int rowNum = 2;
		// ????????????????????????
		for (GeesunAnnualMain geesunAnnualMain : dataList) {
			rowNum++;
			// ?????????????????????
			GeesunImportMessage message = new GeesunImportMessage();
			boolean error = false;
			// ??????????????????
			if (null == geesunAnnualMain.getFdTotal()) {
				message.addMoreMsg(ResourceUtil.getString("geesunAnnualMain.excel.ts.not.find", "geesun-annual"));
				error = true;
			}
			// ???????????????
			if (null == geesunAnnualMain.getFdOwner()) {
				message.addMoreMsg(ResourceUtil.getString("geesunAnnualMain.excel.loginName.not.find", "geesun-annual"));
				error = true;
			}
			if (error) {
				// ????????????
				message.addFailMsg(ResourceUtil.getString("geesunAnnualMain.import.message.fail", "geesun-annual").replace("%rowNum%",
						String.valueOf(rowNum)));
			} else {
				GeesunAnnualMain dbAnnual = getAnnualByOwner(geesunAnnualMain.getFdOwner());
				if (null == dbAnnual) {
					message.addSuccessMsg(ResourceUtil.getString("geesunAnnualMain.excel.import.success", "geesun-annual").replace("%rowNum%",
							String.valueOf(rowNum)));
					// ????????????
					this.add(geesunAnnualMain);
				} else {
					//????????????????????????
					message.addWarnMsg(ResourceUtil.getString("geesunAnnualMain.excel.import.updateIgnore", "geesun-annual").replace(
							"%rowNum%",
							String.valueOf(rowNum)).replace("%loginName%", geesunAnnualMain.getFdOwner().getFdLoginName()));
				}
			}
			messages.add(message);
		}
		GeesunImportMessage messageEnd = new GeesunImportMessage();
		messageEnd.addSuccessMsg(ResourceUtil.getString("geesunAnnualMain.excel.import.all", "geesun-annual"));
		messages.add(messageEnd);
		return messages;
	}
	
	/**
	 * ?????????????????????????????????
	 * @param owner
	 * @return
	 * @throws Exception
	 */
	private GeesunAnnualMain getAnnualByOwner(SysOrgPerson owner) throws Exception {
		HQLInfo hql = new HQLInfo();
		hql.setWhereBlock("geesunAnnualMain.fdOwner.fdId=:fdOwnerId");
		hql.setParameter("fdOwnerId", owner.getFdId());
		List<GeesunAnnualMain> result = this.findList(hql);
		if (!ArrayUtil.isEmpty(result)) {
			return result.get(0);
		}
		return null;
	}
	
	/**
	 * ??????java??????excel???????????????????????????
	 * 
	 * @param s
	 * @return
	 */
	public static String toUtf8String(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c >= 0 && c <= 255) {
				sb.append(c);
			} else {
				byte[] b;
				try {
					b = Character.toString(c).getBytes("utf-8");
				} catch (Exception ex) {
					b = new byte[0];
				}
				for (int j = 0; j < b.length; j++) {
					int k = b[j];
					if (k < 0)
						k += 256;
					sb.append("%" + Integer.toHexString(k).toUpperCase());
				}
			}
		}
		return sb.toString();
	}
	
	/**
	 * ??????????????????????????????
	 * @param ids
	 * @param response
	 * @throws Exception
	 */
	public void exportAnnuals(List<GeesunAnnualMain> annualList, 
			HttpServletResponse response) throws Exception {
		// ????????????
		String[] cloumns = new String[12];
		cloumns[0] = ResourceUtil.getString("geesunAnnualMain.fdOwnerNo", "geesun-annual");
		cloumns[1] = ResourceUtil.getString("geesunAnnualMain.fdOwner", "geesun-annual");
		cloumns[2] = ResourceUtil.getString("geesunAnnualMain.docDept", "geesun-annual");
		cloumns[3] = ResourceUtil.getString("geesunAnnualMain.fdNextResetDate", "geesun-annual");
		cloumns[4] = ResourceUtil.getString("geesunAnnualMain.fdTotal", "geesun-annual");
		cloumns[5] = ResourceUtil.getString("geesunAnnualMain.fdRemain", "geesun-annual");
		cloumns[6] = ResourceUtil.getString("geesunAnnualMain.fdFrozen", "geesun-annual");
		cloumns[7] = ResourceUtil.getString("geesunAnnualMain.fdUsed", "geesun-annual");
		cloumns[8] = ResourceUtil.getString("geesunAnnualMain.fdLastTotal", "geesun-annual");
		cloumns[9] = ResourceUtil.getString("geesunAnnualMain.fdLastRemain", "geesun-annual");
		cloumns[10] = ResourceUtil.getString("geesunAnnualMain.fdLastFrozen", "geesun-annual");
		cloumns[11] = ResourceUtil.getString("geesunAnnualMain.fdLastUsed", "geesun-annual");
		// ???????????????
		OutputStream os = response.getOutputStream();
		// ???????????????
		response.reset();
		// ????????????????????????
		String filename = "?????????????????????.xls";
		response.setContentType("application/vnd.ms-excel; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment;filename=" + StringUtils.toUtf8String(filename));
		HSSFWorkbook workBook = new HSSFWorkbook();
		HSSFSheet sheet =  workBook.createSheet("?????????????????????");
		for (int i = 0; i < cloumns.length; i++) {
			sheet.setColumnWidth(i, 14000);
		}
		HSSFCellStyle styleRowOne = workBook.createCellStyle();
		HSSFFont fontRude = workBook.createFont();
		fontRude.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// ???????????????
		fontRude.setFontHeightInPoints((short) 18);
		fontRude.setColor(HSSFColor.RED.index);
		styleRowOne.setFont(fontRude);// ??????style?????????
		styleRowOne.setFillForegroundColor(HSSFColor.TAN.index);
		styleRowOne.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		styleRowOne.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleRowOne.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleRowOne.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleRowOne.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// ???????????????????????????????????????????????????
		styleRowOne.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		// ?????????????????????????????????(????????????)
		styleRowOne.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFCellStyle styleRowTwo = workBook.createCellStyle();
		HSSFFont font = workBook.createFont();
		font.setFontHeightInPoints((short) 15);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
		styleRowTwo.setFont(font);
		styleRowTwo.setFillForegroundColor(HSSFColor.AQUA.index);
		styleRowTwo.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		styleRowTwo.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleRowTwo.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		styleRowTwo.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleRowTwo.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleRowTwo.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleRowTwo.setBorderTop(HSSFCellStyle.BORDER_THIN);
		HSSFCellStyle style = workBook.createCellStyle();
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// ????????????????????????
		HSSFFont font1 = workBook.createFont();
		// ?????????????????????
		font1.setBoldweight((short) 10);
		// ?????????????????????
		font1.setFontHeightInPoints((short) 15);
		font1.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
		style.setFont(font1);// ??????style?????????
		style.setWrapText(true);// ??????????????????
		// ???????????????????????????????????????????????????
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		// ?????????????????????????????????(????????????)
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		HSSFRow head = sheet.createRow(0);
		head.setHeightInPoints((float) 40.0);
		sheet.addMergedRegion(new CellRangeAddress(0,1,0,11));
		HSSFCell ce = head.createCell((short) 0);
		// ??????????????????????????????????????????
		ce.setCellValue(ResourceUtil.getString("geesunAnnualMain.export.detail", "geesun-annual"));
		// ???????????????
		ce.setCellStyle(styleRowOne);
		// ????????? ??????
		HSSFRow rowTitle = sheet.createRow(2);
		rowTitle.setHeightInPoints((float) 30.0);
		for (int i = 0; i < cloumns.length; i++) {
			HSSFCell cell = rowTitle.createCell((short) i);
			cell.setCellStyle(styleRowTwo);
			cell.setCellValue(cloumns[i]);
		}
		// ????????????Action???????????????list?????????????????????????????????????????????Excel??????
		if (!ArrayUtil.isEmpty(annualList)) {
			int k = 0;
			for (int i = 0; i < annualList.size(); i++) {
				rowTitle = sheet.createRow(k + 3);
				GeesunAnnualMain annual = annualList.get(i);
				SysOrgPerson user = annual.getFdOwner();
				if (user == null || !user.getFdIsAvailable()) {
					continue;
				}
				Double fdTotal = (null!=annual.getFdTotal()?annual.getFdTotal():0.0);
				Double fdLastTotal = (null!=annual.getFdLastTotal()?annual.getFdLastTotal():0.0);
				Double fdUsing = getGeesunAnnualUseService().getYearLeaveDayAuditingByPerson(null, "frozen", false, annual);
				Double fdUsed = getGeesunAnnualUseService().getYearLeaveDayAuditingByPerson(null, "", false, annual);
				Double fdLastUsing = getGeesunAnnualUseService().getYearLeaveDayAuditingByPerson(null, "frozen", true, annual);
				Double fdLastUsed = getGeesunAnnualUseService().getYearLeaveDayAuditingByPerson(null, "", true, annual);
				Double fdRemain = CalculateUtil.sub(fdTotal, CalculateUtil.sum(fdUsing, fdUsed));
				Double fdLastRemain = CalculateUtil.sub(fdLastTotal, CalculateUtil.sum(fdLastUsing, fdLastUsed));
				for (int j = 0; j < cloumns.length; j++) {
					HSSFCell cell = rowTitle.createCell((short) j);
					cell.setCellStyle(style);
					switch (j) {
						case 0:
							cell.setCellValue(annual.getFdOwnerNo());
							break;
						case 1:
							cell.setCellValue(annual.getFdOwner().getFdName());
							break;
						case 2:
							cell.setCellValue(annual.getDocDept().getFdName());
							break;
						case 3:
							cell.setCellValue(DateUtil.convertDateToString(annual.getFdNextResetDate(), DateUtil.PATTERN_DATE));
							break;
						case 4:
							cell.setCellValue(fdTotal);
							break;
						case 5:
							cell.setCellValue(fdRemain);
							break;
						case 6:
							cell.setCellValue(fdUsing);
							break;
						case 7:
							cell.setCellValue(fdUsed);
							break;
						case 8:
							cell.setCellValue(fdLastTotal);
							break;
						case 9:
							cell.setCellValue(fdLastRemain);
							break;
						case 10:
							cell.setCellValue(fdLastUsing);
							break;
						case 11:
							cell.setCellValue(fdLastUsed);
							break;
					}
				}
				k ++;
			}
		}
		workBook.write(os);
		// ???????????????????????????
		os.flush();
		os.close();
	}
	
	/**
	 * ??????????????????
	 * @param geesunAnnualMain
	 * @param fdDate
	 * @throws Exception
	 */
	private void generateCommonQuartz(GeesunAnnualMain geesunAnnualMain, 
			Date fdDate) throws Exception {
		SysQuartzModelContext quartzContext = new SysQuartzModelContext();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(fdDate);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MINUTE, 0);
		JSONObject parameter = new JSONObject();
		parameter.put("fdId", geesunAnnualMain.getFdId());
		quartzContext.setQuartzParameter(parameter.toString());
		quartzContext.setQuartzCronExpression(SysQuartzModelContext
				.getCronExpression(calendar));
		quartzContext.setQuartzJobMethod("updateResetAnnual");
		quartzContext.setQuartzJobService("geesunAnnualMainService");
		quartzContext.setQuartzKey("updateResetAnnualKey");
		quartzContext.setQuartzLink(ModelUtil.getModelUrl(geesunAnnualMain));
		quartzContext.setQuartzSubject("??????????????????????????????????????????");
		quartzContext.setQuartzEnabled(true);
		getSysQuartzCoreService().addScheduler(quartzContext,
				geesunAnnualMain);
	}
	
	/**
	 * ????????????????????????????????????
	 * @param context
	 * @throws Exception
	 */
	public void updateResetAnnual(SysQuartzJobContext context) throws Exception {
		JSONObject parameter = JSONObject.fromObject(context.getParameter());
		GeesunAnnualMain geesunAnnualMain = (GeesunAnnualMain) this
				.findByPrimaryKey(parameter.getString("fdId"), GeesunAnnualMain.class, true);
		updateResetPersonAnnual(geesunAnnualMain);
	}
	
	/**
	 * ??????????????????????????????????????????
	 * @param geesunAnnualMain
	 * @throws Exception
	 */
	private void updateResetPersonAnnual(GeesunAnnualMain geesunAnnualMain) throws Exception {
		GeesunAnnualReset reset = getAnnualReset(geesunAnnualMain);
		boolean isAdd = false;
		boolean isNeedExecute = false;
		if (reset == null) {
			isAdd = true;
			reset = new GeesunAnnualReset();
		}
		SysOrgPerson owner = geesunAnnualMain.getFdOwner();
		reset.setFdAnnual(geesunAnnualMain);
		reset.setFdOwner(owner);
		reset.setFdHasExecute(GEESUN_ANNUAL_EXECUTE_NO);//???????????????
		reset.setFdExecuteTime(new Date());
		try {
			int baseAnnualNum = 5;//????????????5???
			int maxAddAnnualNum = 10;//??????????????????10???
			//????????????????????????
			Map<String, Object> map = owner.getCustomPropMap();
			Calendar c = Calendar.getInstance();
			Date fdRuzhiDate = (Date) map.get("ruzhiriqi");
			int year = c.get(Calendar.YEAR);
			c.setTime(fdRuzhiDate);
			int rzYear = c.get(Calendar.YEAR);
			int nx = year - rzYear;
			if (nx > 0) {
				isNeedExecute = true;
				int addYear = (nx - 1 < maxAddAnnualNum)?(nx - 1):maxAddAnnualNum;
				Date fdLastResetYear = geesunAnnualMain.getFdLastResetDate();
				Date fdNextResetYear = geesunAnnualMain.getFdNextResetDate();
				c.setTime(fdLastResetYear);
				c.add(Calendar.YEAR, +1);
				geesunAnnualMain.setFdLastResetDate(c.getTime());
				c.setTime(fdNextResetYear);
				c.add(Calendar.YEAR, +1);
				geesunAnnualMain.setFdNextResetDate(c.getTime());
				geesunAnnualMain.setFdLastTotal(geesunAnnualMain.getFdTotal());
				geesunAnnualMain.setFdTotal((double)(baseAnnualNum + addYear));
				this.update(geesunAnnualMain);
				reset.setFdHasExecute(GEESUN_ANNUAL_EXECUTE_YES);//?????????
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (isNeedExecute) {
				if (isAdd) {
					getGeesunAnnualResetService().add(reset);
				} else {
					getGeesunAnnualResetService().update(reset);
				}
			}
		}
	}
	
	/**
	 * ???????????????????????????????????????????????????????????????
	 * @param geesunAnnualMain
	 * @return
	 * @throws Exception
	 */
	private GeesunAnnualReset getAnnualReset(GeesunAnnualMain 
			geesunAnnualMain) throws Exception {
		HQLInfo hql = new HQLInfo();
		hql.setWhereBlock("geesunAnnualReset.fdAnnual.fdId=:fdAnnualId");
		hql.setParameter("fdAnnualId", geesunAnnualMain.getFdId());
		List<GeesunAnnualReset> resetList = getGeesunAnnualResetService().findList(hql);
		if (!ArrayUtil.isEmpty(resetList)) {
			return resetList.get(0);
		}
		return null;
	}
	
	/**
	 * ?????????????????????????????????????????????ID??????
	 * @param dataSource
	 * @param fdDeptId
	 * @throws Exception
	 */
	private List<String> getAllValidUserIdList(DataSource dataSource, 
			String fdDeptId) throws Exception {
		List<String> userIdList = new ArrayList<String>();
		Boolean isSqlServer = MetadataUtil
			    .isSQLServer(ResourceUtil.getKmssConfigString(Environment.DIALECT));
		String sql = "select person.fd_id from sys_org_person person left join sys_org_element element on person.fd_id = element.fd_id "
				+ " where element.fd_is_available = ? and instr(element.fd_hierarchy_id, ?) > 0";
		if (isSqlServer) {
			sql = "select person.fd_id from sys_org_person person left join sys_org_element element on person.fd_id = element.fd_id "
					+ " where element.fd_is_available = ? and charindex(?, element.fd_hierarchy_id) > 0";
		}
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setBoolean(1, Boolean.TRUE);
			ps.setString(2, fdDeptId);
			rs = ps.executeQuery();
			while (rs.next()) {
				userIdList.add(rs.getString(1));
			}
		} catch (Exception ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(rs);
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
		return userIdList;
	}
	
	/**
	 * ????????????????????????????????????????????????????????????????????????
	 * @param context
	 * @throws Exception
	 */
	public void checkErrorResetLogQuartz(SysQuartzJobContext context) throws Exception {
		context.logMessage("?????????????????????????????????????????????????????????????????????????????????????????????");
		Calendar c = Calendar.getInstance();
		GeesunAnnualConfig config = new GeesunAnnualConfig();
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		List<String> userIdList = getAllValidUserIdList(dataSource, config.getFdOrgId());
		if (!ArrayUtil.isEmpty(userIdList)) {
			int year = c.get(Calendar.YEAR);
			for (String userId : userIdList) {
				GeesunAnnualMain geesunAnnualMain = getAnnualByApplyer(userId);
				if (null != geesunAnnualMain) {
					//???????????????????????????????????????????????????????????????
					HQLInfo hqlInfo = new HQLInfo();
					hqlInfo.setWhereBlock("geesunAnnualReset.fdExecuteTime>:time1 and geesunAnnualReset.fdExecuteTime<=:time2 "
							+ "and year(geesunAnnualReset.fdExecuteTime)=:executeYear and geesunAnnualReset.fdHasExecute=:fdHasExecute and geesunAnnualReset.fdAnnual.fdId=:fdAnnualId");
					hqlInfo.setParameter("time1", geesunAnnualMain.getFdLastResetDate());
					hqlInfo.setParameter("time2", geesunAnnualMain.getFdNextResetDate());
					hqlInfo.setParameter("executeYear", year);
					hqlInfo.setParameter("fdHasExecute", GEESUN_ANNUAL_EXECUTE_YES);
					hqlInfo.setParameter("fdAnnualId", geesunAnnualMain.getFdId());
					List<GeesunAnnualReset> resetList = getGeesunAnnualResetService().findList(hqlInfo);
					if (ArrayUtil.isEmpty(resetList) && new Date().after(geesunAnnualMain.getFdNextResetDate())) {
						context.logMessage("??????????????????ID??????" + geesunAnnualMain.getFdId() + ";???????????????" + geesunAnnualMain.getFdOwner().getFdName());
						updateResetPersonAnnual(geesunAnnualMain);
					}
				} else {
					//???????????????????????????????????????????????????????????????
					SysOrgPerson owner = (SysOrgPerson) getSysOrgPersonService().findByPrimaryKey(userId, SysOrgPerson.class, true);
					Map<String, Object> map = owner.getCustomPropMap();
					Date fdRuzhiDate = (Date) map.get("ruzhiriqi");
					long workYears = DateUtil.getDatePoor(new Date(), fdRuzhiDate)/365;
					c.setTime(fdRuzhiDate);
					c.set(Calendar.YEAR, year);
					//???????????????????????????????????????
					if (new Date().after(c.getTime()) && workYears >= 1) {
						GeesunAnnualMain annualMain = new GeesunAnnualMain();
						context.logMessage("???????????????????????????????????????????????????????????????????????????????????????" + owner.getFdLoginName() + "-" + owner.getFdName() + "?????????????????? ????????????ID??????" + annualMain.getFdId());
						annualMain.setDocCreator(UserUtil.getUser());
						annualMain.setDocCreateTime(new Date());
						annualMain.setFdOwnerNo(owner.getFdLoginName());
						annualMain.setFdOwner(owner);//?????????
						annualMain.setDocDept(owner.getFdParent());//??????
						annualMain.setFdTotal(5.0);
						annualMain.setFdNextResetDate(c.getTime());
						annualMain.setFdLastResetDate(fdRuzhiDate);
						this.add(annualMain);
					}
				}
			}
		}
		context.logMessage("???????????????????????????????????????????????????????????????????????????????????????");
	}
	
	public void updateReviewInfo(KmReviewMain 
			kmReviewMain, String type, String fieldId, String fieldValue) throws Exception {
		ExtendDataModelInfo data = kmReviewMain.getExtendDataModelInfo();
		Map<String, Object> map = data.getModelData();
		if ("common".equals(type)) {
			map.put(fieldId, fieldValue);
//			getSysMetadataParser().setFieldValue(kmReviewMain, fieldId.trim(), fieldValue);
		} else {
			String[] arry = fieldId.split("\\.");
			//?????????
			List<Map<String, Object>> detail = (List<Map<String, Object>>) map.get(arry[0]);
			for (Map<String, Object> temp : detail) {
				temp.put(arry[1], fieldValue);
			}
			map.put(arry[0], detail);
//			List<Object> list = new ArrayList<Object>();
//			list.add(fieldValue);
//			getSysMetadataParser().setFieldValue(kmReviewMain, fieldId.trim(), list);
		}
		data.saveModelData();
	}
    
}
