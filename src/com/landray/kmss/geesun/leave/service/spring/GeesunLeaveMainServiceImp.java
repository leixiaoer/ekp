package com.landray.kmss.geesun.leave.service.spring;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.landray.kmss.geesun.annual.util.StringUtils;
import com.landray.kmss.geesun.leave.util.GeesunImportMessage;
import com.landray.kmss.geesun.leave.util.GeesunLeaveLastDayUtil;
import com.landray.kmss.geesun.leave.util.GeesunLeaveUtil;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveMainService;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.leave.dao.hibernate.GeesunLeaveInfoDaoImpl;
import com.landray.kmss.geesun.leave.forms.GeesunLeaveMainForm;
import com.landray.kmss.geesun.leave.model.GeesunLeaveMain;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.organization.service.ISysOrgPersonService;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.upload.FormFile;
import com.landray.kmss.common.forms.IExtendForm;

public class GeesunLeaveMainServiceImp extends ExtendDataServiceImp implements IGeesunLeaveMainService {

	private ISysNotifyMainCoreService sysNotifyMainCoreService;
	private GeesunLeaveInfoDaoImpl geesunLeaveInfoDaoImpl = new GeesunLeaveInfoDaoImpl();

	public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context)
			throws Exception {
		model = super.convertBizFormToModel(form, model, context);
		if (model instanceof GeesunLeaveMain) {
			GeesunLeaveMain geesunLeaveMain = (GeesunLeaveMain) model;
		}
		return model;
	}

	public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
		GeesunLeaveMain geesunLeaveMain = new GeesunLeaveMain();
		geesunLeaveMain.setDocCreateTime(new Date());
		geesunLeaveMain.setDocCreator(UserUtil.getUser());
		geesunLeaveMain.setDocDept(UserUtil.getUser().getFdParent());
		GeesunLeaveUtil.initModelFromRequest(geesunLeaveMain, requestContext);
		return geesunLeaveMain;
	}

	public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext)
			throws Exception {
		GeesunLeaveMain geesunLeaveMain = (GeesunLeaveMain) model;
	}

	public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
		if (sysNotifyMainCoreService == null) {
			sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
		}
		return sysNotifyMainCoreService;
	}

	protected ISysOrgPersonService sysOrgPersonService;

	public ISysOrgPersonService getSysOrgPersonService() {
		if (null == sysOrgPersonService) {
			sysOrgPersonService = (ISysOrgPersonService) SpringBeanUtil.getBean("sysOrgPersonService");
		}
		return sysOrgPersonService;
	}

	/**
	 * @author guoyp ????????????????????????
	 * @param mainForm
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public List<GeesunImportMessage> saveImport(GeesunLeaveMainForm mainForm, HttpServletRequest request)
			throws Exception {
		List<GeesunImportMessage> messages = new ArrayList<GeesunImportMessage>();
		FormFile file = mainForm.getTheFile();
		if (file.getFileSize() == 0) {
			GeesunImportMessage message = new GeesunImportMessage();
			message.addFailMsg(ResourceUtil.getString("geesunLeaveMain.excel.upload.excel.empty", "geesun-leave"));
			messages.add(message);
		} else {
			Sheet sheet = null;
			if (file.getFileName().toString().substring(file.getFileName().toString().length() - 4).equals(".xls")) {
				POIFSFileSystem fs = new POIFSFileSystem(file.getInputStream());
				HSSFWorkbook wb = new HSSFWorkbook(fs);
				sheet = wb.getSheetAt(0);
			} else if (file.getFileName().toString().substring(file.getFileName().toString().length() - 5)
					.equals(".xlsx")) {
				XSSFWorkbook wb = new XSSFWorkbook(file.getInputStream());
				sheet = wb.getSheetAt(0);// ??????Excel???
			}
			// ??????????????????????????????
			List<GeesunLeaveMain> dataList = getImpotDataList(sheet, request);
			messages = this.save(dataList);
		}
		return messages;
	}

	/**
	 * ?????????????????????????????????GeesunLeaveMain??????????????????
	 * 
	 * @param sheet
	 * @param request
	 * @return
	 * @throws Exception
	 */
	private List<GeesunLeaveMain> getImpotDataList(Sheet sheet, HttpServletRequest request) throws Exception {
		List<GeesunLeaveMain> dataList = new ArrayList<GeesunLeaveMain>();
		boolean isNull = false;
		for (int i = 2; i <= sheet.getLastRowNum(); i++) {
			// ??????????????????
			Row row = sheet.getRow(i);
			if (row == null || StringUtils.isBlankRow(row) || row.getZeroHeight()) {
				continue;
			}
			GeesunLeaveMain geesunleaveMain = new GeesunLeaveMain();
			geesunleaveMain.setDocCreateTime(new Date());
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
					geesunleaveMain.setDocCreator(owner);
					geesunleaveMain.setFdOwnerNo(cell0.trim());// ??????
					geesunleaveMain.setDocDept(owner.getFdParent());// ??????
					String years = new SimpleDateFormat("yyyy").format(new Date());
					geesunleaveMain.setFdTime(years);// ????????????
					String lastDays = GeesunLeaveLastDayUtil.getYearLast(Integer.parseInt(years)); // ?????????????????????????????????
					Date lastDay = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(lastDays + ":00");
					geesunleaveMain.setDocFailureTime(lastDay); // ????????????
					Calendar c = Calendar.getInstance();
					int year = c.get(Calendar.YEAR);
					c.set(Calendar.YEAR, year);
					if (c.getTime().before(new Date())) {
						c.add(Calendar.YEAR, +1);
					}
				}
				// ????????????
				String cell1 = StringUtils.getCell(row, 2);
				if (null != cell1) {
					if (StringUtil.isNotNull(cell1)) {
						geesunleaveMain.setFdSurplusLeave(Double.valueOf(cell1));// ????????????
						geesunleaveMain.setFdUseLeave(0.0);// ????????????
						geesunleaveMain.setFdSunLeave(Double.valueOf(cell1));// ????????????
					} else {
						geesunleaveMain.setFdSurplusLeave(null);
						geesunleaveMain.setFdUseLeave(null);// ????????????
						geesunleaveMain.setFdSunLeave(null);// ????????????
						isNull = true;
					}
				} else {
					isNull = true;
				}
				dataList.add(geesunleaveMain);
				if (isNull)
					break;
			}
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
	private List<GeesunImportMessage> save(List<GeesunLeaveMain> dataList) throws Exception {
		List<GeesunImportMessage> messages = new ArrayList<GeesunImportMessage>();
		int rowNum = 2;
		// ????????????????????????
		for (GeesunLeaveMain geesunLeaveMain : dataList) {
			rowNum++;
			// ?????????????????????
			GeesunImportMessage message = new GeesunImportMessage();
			boolean error = false;
			// ????????????????????????
			if (null == geesunLeaveMain.getFdSurplusLeave()) {
				message.addMoreMsg(ResourceUtil.getString("geesunLeaveMain.excel.ts.not.find", "geesun-leave"));
				error = true;
			}
			// ???????????????
			if (null == geesunLeaveMain.getFdOwnerNo()) {
				message.addMoreMsg(ResourceUtil.getString("geesunLeaveMain.excel.loginName.not.find", "geesun-leave"));
				error = true;
			}
			if (error) {
				// ????????????
				message.addFailMsg(ResourceUtil.getString("geesunLeaveMain.import.message.fail", "geesun-leave")
						.replace("%rowNum%", String.valueOf(rowNum)));
			} else {
				String userId = geesunLeaveMain.getDocCreator().getFdId();
				Map<String, String> userMap = geesunLeaveInfoDaoImpl.getUserLeave(userId,
						new SimpleDateFormat("yyyy").format(new Date()));
				if (userMap.size() == 0) {
					message.addSuccessMsg(ResourceUtil
							.getString("geesunLeaveMain.excel.import.success", "geesun-leave").replace("%rowNum%",
									String.valueOf(rowNum)));
					// ????????????
					this.add(geesunLeaveMain);
				} else {
					// ????????????????????????
					message.addWarnMsg(ResourceUtil
							.getString("geesunLeaveMain.excel.import.updateIgnore", "geesun-leave")
							.replace("%rowNum%", String.valueOf(rowNum))
							.replace("%loginName%", geesunLeaveMain.getFdOwnerNo()));
				}
			}
			messages.add(message);
		}
		GeesunImportMessage messageEnd = new GeesunImportMessage();
		messageEnd.addSuccessMsg(ResourceUtil.getString("geesunLeaveMain.excel.import.all", "geesun-leave"));
		messages.add(messageEnd);
		return messages;
	}
}
