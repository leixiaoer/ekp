package com.landray.kmss.geesun.base.service.spring;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.JdbcUtils;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.base.model.GeesunBaseBxsj;
import com.landray.kmss.geesun.base.model.GeesunBaseFsscReportModel;
import com.landray.kmss.geesun.base.service.IGeesunBaseBxsjService;
import com.landray.kmss.geesun.base.util.GeesunBaseUtil;
import com.landray.kmss.geesun.base.util.StatisticsPageInfo;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.km.review.service.IKmReviewMainService;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.EnumerationTypeUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.util.excel.Column;
import com.landray.kmss.util.excel.ExcelOutput;
import com.landray.kmss.util.excel.ExcelOutputImp;
import com.landray.kmss.util.excel.Sheet;
import com.landray.kmss.util.excel.WorkBook;
import com.landray.sso.client.oracle.StringUtil;
import com.sunbor.web.tag.Page;

public class GeesunBaseBxsjServiceImp extends ExtendDataServiceImp implements IGeesunBaseBxsjService {
	
	private static final Log logger = LogFactory
			.getLog(GeesunBaseBxsjServiceImp.class);

    private ISysNotifyMainCoreService sysNotifyMainCoreService;
    
    private IKmReviewMainService kmReviewMainService;

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunBaseBxsj) {
            GeesunBaseBxsj geesunBaseBxsj = (GeesunBaseBxsj) model;
            geesunBaseBxsj.setDocAlterTime(new Date());
            geesunBaseBxsj.setDocAlteror(UserUtil.getUser());
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunBaseBxsj geesunBaseBxsj = new GeesunBaseBxsj();
        geesunBaseBxsj.setDocCreateTime(new Date());
        geesunBaseBxsj.setDocAlterTime(new Date());
        geesunBaseBxsj.setDocCreator(UserUtil.getUser());
        geesunBaseBxsj.setDocAlteror(UserUtil.getUser());
        GeesunBaseUtil.initModelFromRequest(geesunBaseBxsj, requestContext);
        return geesunBaseBxsj;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunBaseBxsj geesunBaseBxsj = (GeesunBaseBxsj) model;
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
    
    public IKmReviewMainService getKmReviewMainService() {
        if (kmReviewMainService == null) {
        	kmReviewMainService = (IKmReviewMainService) SpringBeanUtil.getBean("kmReviewMainService");
        }
        return kmReviewMainService;
    }
    
    protected Page returnPage(StatisticsPageInfo statisticsPageInfo, List list) {
		int total = 0;
		if (!ArrayUtil.isEmpty(list)) {
			total = list.size();
		}

		Page page = null;
		int rowSize = statisticsPageInfo.getRowsize();
		int pageNo = statisticsPageInfo.getPageno()==0?1:statisticsPageInfo.getPageno();
		page = new Page();
		page.setRowsize(rowSize);
		page.setPageno(pageNo);
		page.setTotalrows(total);
		page.excecute();
//		query.setFirstResult(page.getStart());
//		query.setMaxResults(page.getRowsize());
		page.setList(list.subList((pageNo-1)*rowSize, (pageNo*rowSize<total)?(pageNo*rowSize):total));
		return page;
	}
    
    /**
	 * ??????????????????
	 */
	public Page getExpenseReportList(StatisticsPageInfo statisticsPageInfo, 
			HttpServletRequest request) throws Exception {
		String subject = request.getParameter("subject");
		String number = request.getParameter("number");
		String status = request.getParameter("status");
		String type = request.getParameter("type");
		String beginDate = request.getParameter("beginDate");
		String endDate = request.getParameter("endDate");
		List<GeesunBaseFsscReportModel> list = new ArrayList<GeesunBaseFsscReportModel>();
		try {
			list = getExpenseReportList(subject, number, status, type, beginDate, endDate);
    	} catch (Exception e) {
    		logger.error(e);
    		throw e;
    	}
		return returnPage(statisticsPageInfo, list);
	}
	
	/**
	 * ??????????????????
	 * @param punchDate
	 * @param fdLoginName
	 * @throws Exception
	 */
	public List<GeesunBaseFsscReportModel> getExpenseReportList(
			String subject, String number, String status, String type, String beginDate, String endDate) throws Exception {
		List<GeesunBaseFsscReportModel> list = new ArrayList<GeesunBaseFsscReportModel>();
		Connection conn = null;
		PreparedStatement ps = null;
        ResultSet rs = null;
		try {
			DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");	
			conn = dataSource.getConnection();
			String sqlEkp = "SELECT k.doc_create_time, k.fd_number," + 
					"(SELECT fd_no FROM sys_org_element WHERE fd_id = k.doc_creator_id) creatorNo," +
					"(SELECT fd_name FROM sys_org_element WHERE fd_id = k.doc_creator_id) creatorName," +
					"k.fd_template_id," +
					"(SELECT fd_name FROM sys_org_element WHERE fd_id = m.fd_gangWei) gwName," +
					"(SELECT fd_name FROM sys_org_element WHERE fd_id = m.fd_shiJiBaoXiaoRen) sjbxrName," +
					"d.fd_money, d.fd_center_id_text," +
					"m.fd_baoXiaoBuMen," + 
					"(SELECT fd_name FROM sys_org_element WHERE fd_id = d.fd_shiYongBuMen) sybmName," +
					"d.fd_item_id_text, d.fd_399347829623b6_text, d.fd_3993704996d8c6_text, d.fd_yongTu," +
					"m.fd_baoXiaoShuoMing, k.doc_status, m.fd_xianJinLiuLiangXiangMu, p.fd_pay_date," +
					"p.fd_demo, m.fd_receiver, m.fd_bank_name, m.fd_id, m.fd_shouKuanDanWei, d.fd_id, m.fd_guanLianDanJu, m.fd_fuKuanShuoMing, " +
					"(SELECT fd_name FROM sys_org_element WHERE fd_id = m.fd_buMen1) bmName, " +
					"d.fd_begin_date, d.fd_end_date, d.fd_travel_days, d.fd_start_place, d.fd_end_place," +
					"d.fd_ccf, d.fd_jpf, d.fd_snjtf, d.fd_zsf, d.fd_zffy, d.fd_ccbt, d.fd_other, m.fd_shouKuanZhangHao, d.fd_chanPinXian " +
					" FROM ekp_fssc_detail d " +
					"LEFT JOIN ekp_fssc_main m ON d.fd_parent_id = m.fd_id " +
					"LEFT JOIN geesun_base_pay p ON d.fd_parent_id = p.fd_review_id " +
					"LEFT JOIN km_review_main k ON d.fd_parent_id = k.fd_id where 1 = 1 ";
			if (StringUtil.isNotNull(subject)) {
				sqlEkp = sqlEkp + " and upper(k.doc_subject) like ?";
			}
			if (StringUtil.isNotNull(number)) {
				sqlEkp = sqlEkp + " and upper(k.fd_number) like ?";
			}
			if (StringUtil.isNotNull(status)) {
				sqlEkp = sqlEkp + " and k.doc_status = ?";
			}
			if (StringUtil.isNotNull(type)) {
				sqlEkp = sqlEkp + " and k.fd_template_id = ?";
			}
			if (StringUtil.isNotNull(beginDate)) {
				sqlEkp = sqlEkp + " and k.doc_create_time >= ?";
			}
			if (StringUtil.isNotNull(endDate)) {
				sqlEkp = sqlEkp + " and k.doc_create_time <= ?";
			}
			/*if (StringUtil.isNotNull(fdMonth)) {
				Boolean isSqlServer = MetadataUtil
						.isSQLServer(ResourceUtil.getKmssConfigString(Environment.DIALECT));
				if (isSqlServer) {
					sqlEkp = sqlEkp + " and convert(varchar(7), k.doc_create_time, 127) = ?";
				} else {
					sqlEkp = sqlEkp + " and DATE_FORMAT(k.doc_create_time, '%Y-%m') = ?";
				}
			}*/
			ps = conn.prepareStatement(sqlEkp);
			int para = 1;
			if (StringUtil.isNotNull(subject)) {
				ps.setString(para ++, "%" + subject.trim().toUpperCase() + "%");
			}
			if (StringUtil.isNotNull(number)) {
				ps.setString(para ++, "%" + number.trim().toUpperCase() + "%");
			}
			if (StringUtil.isNotNull(status)) {
				ps.setString(para ++, status);
			}
			if (StringUtil.isNotNull(type)) {
				ps.setString(para ++, type);
			}
			if (StringUtil.isNotNull(beginDate)) {
				ps.setTimestamp(para++, new java.sql.Timestamp(DateUtil.convertStringToDate(beginDate + " 00:00", DateUtil.PATTERN_DATETIME).getTime()));
			}
			if (StringUtil.isNotNull(endDate)) {
				ps.setTimestamp(para ++, new java.sql.Timestamp(DateUtil.convertStringToDate(endDate + " 23:59", DateUtil.PATTERN_DATETIME).getTime()));
			}
			/*if (StringUtil.isNotNull(fdMonth)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
				Date date = sdf.parse(fdMonth.substring(1, 7));
				Calendar c = Calendar.getInstance();
				c.setTime(date);
				c.add(Calendar.MONTH, 1);
				String month = DateUtil.convertDateToString(c.getTime(), "yyyy-MM");
				logger.error("???????????????????????????" + month);
				ps.setString(para ++, month);
			}*/
			rs = ps.executeQuery();
			while (rs.next()) {
				GeesunBaseFsscReportModel model = new GeesunBaseFsscReportModel();
				Date docCreateTime = rs.getDate(1);
				String fdTemplateId = rs.getString(5);
				model.setFdApplyDate(docCreateTime);
				model.setFdApplyNumber(rs.getString(2));
				model.setFdApplyNo(rs.getString(3));
				model.setFdApplyerName(rs.getString(4));
				model.setFdTemplateId(fdTemplateId);
				model.setFdApplyerGw(rs.getString(6));
				if ("1796454cc441e9d1866f5b44fcb96980".equals(fdTemplateId)) {
					model.setFdReceiverName(rs.getString(24));
					model.setFdQsbg(rs.getString(27));
					model.setFdAccount(rs.getString(22));
					model.setFdKhh(rs.getString(21));
				} else {
					model.setFdReceiverName(rs.getString(7));
					model.setFdAccount(rs.getString(41));
					model.setFdKhh(rs.getString(22));
					model.setFdHh(rs.getString(27));
				}
				model.setFdTotalMoney(rs.getDouble(8));
				model.setFdCenterName(rs.getString(9));
				if ("1796454cc441e9d1866f5b44fcb96980".equals(fdTemplateId)) {
					model.setFdApplyerDeptName(rs.getString(28));
				} else {
					model.setFdApplyerDeptName(rs.getString(10));
				}
				model.setFdUserDeptName(rs.getString(11));
				model.setFdProduct(rs.getString(42));
				model.setFdItemName(rs.getString(12));
				String fdApplyId = rs.getString(23);
				String fdApplyDetailId = rs.getString(25);
				model.setFdApplyId(fdApplyId);
				model.setFdApplyDetailId(fdApplyDetailId);
				String fdThreeItemName = rs.getString(13);
				if ("1796454cc441e9d1866f5b44fcb96980".equals(fdTemplateId)) {
					//?????????????????????????????????????????????????????????????????????
					if (docCreateTime.before(DateUtil.convertStringToDate("2021-07-14 17:17", DateUtil.PATTERN_DATETIME)) && StringUtil.isNull(fdThreeItemName)) {
						KmReviewMain mm = (KmReviewMain) getKmReviewMainService().findByPrimaryKey(fdApplyId, null, true);
						if (null!=mm) {
							List<Map<String, Object>> detailList = (List<Map<String, Object>>) mm.getExtendDataModelInfo().getModelData().get("fd_3957f578d654fe");
							if (!ArrayUtil.isEmpty(detailList)) {
								for (Map<String, Object> detail : detailList) {
									if (fdApplyDetailId.equals(detail.get("fdId").toString())) {
										model.setFdThreeItemName((null!=detail.get("fd_3995dc30aa4b9c")?detail.get("fd_3995dc30aa4b9c").toString():""));
										break;
									}
								}
							}
						}
					} else {
						model.setFdThreeItemName(fdThreeItemName);
					}
				} else {
					model.setFdThreeItemName(fdThreeItemName);
				}
				model.setFdProjectNo(rs.getString(14));
				model.setFdPayReason(rs.getString(26));
				if ("1796454cc441e9d1866f5b44fcb96980".equals(fdTemplateId)) {
					model.setFdExpenseDescription(rs.getString(20));
				} else {
					model.setFdExpenseDescription(rs.getString(16));
				}
				model.setFdStatus(EnumerationTypeUtil.getColumnEnumsLabel(
						"common_status", rs.getString(17)));
				model.setFdXjlXm(rs.getString(18));
				Date fdPayDate = rs.getDate(19);
				if (null != fdPayDate) {
					model.setFdPayDate(fdPayDate);
				}
//				model.setFdPayDescription();
				model.setFdBeginDate(rs.getDate(29));
				model.setFdEndDate(rs.getDate(30));
				model.setFdTravelDays(rs.getDouble(31));
				model.setFdStartPlace(rs.getString(32));
				model.setFdEndPlace(rs.getString(33));
				model.setFdCcf(rs.getDouble(34));
				model.setFdJpf(rs.getDouble(35));
				model.setFdSnjtf(rs.getDouble(36));
				model.setFdZsf(rs.getDouble(37));
				model.setFdZffy(rs.getDouble(38));
				model.setFdCcbt(rs.getDouble(39));
				model.setFdOther(rs.getDouble(40));
				list.add(model);
			}
		} catch (Exception e) {
			logger.error(e);
			throw e;
		} finally {
			JdbcUtils.closeResultSet(rs);
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
		return list;
	}
    
    /**
	 * ??????????????????
	 * @param ids
	 * @param response
	 * @throws Exception
	 */
	public void exportReportListInfos(String subject, String number, String status, String type, String beginDate, String endDate,
			HttpServletResponse response) throws Exception {
		List<GeesunBaseFsscReportModel> reportList = getExpenseReportList(subject, number, status, type, beginDate, endDate);
		// ?????????
		java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(
				"yyyyMMddhhmmss");
		WorkBook workbook = new WorkBook();
		Locale chinaLocale = new Locale("zh", "ZH");
		workbook.setLocale(chinaLocale);
		workbook.setBundle("geesun-base");
		String title = "????????????????????????";
		title = format.format(new Date()) + title;
		workbook.setFilename(title);
		Sheet sheet = new Sheet();
		sheet.setTitle(title);
		/* ??????????????? */
		Column[] col = new Column[35];
		for (int i = 0; i < col.length; i++) {
			col[i] = new Column();
		}
		col[0].setTitle("????????????");
		col[0].setType("Date");
		col[1].setTitle("???????????????");
		col[2].setTitle("???????????????");
		col[3].setTitle("?????????1");
		col[4].setTitle("??????");
		col[5].setTitle("????????????/???????????????");
		col[6].setTitle("????????????");
		col[7].setTitle("????????????");
		col[8].setTitle("????????????");
		col[9].setTitle("????????????");
		col[10].setTitle("?????????");
		col[11].setTitle("????????????");
		col[12].setTitle("????????????");
		col[13].setTitle("?????????");
		col[14].setTitle("????????????");
		col[15].setTitle("????????????");
		col[16].setTitle("????????????");
		col[17].setTitle("????????????");
		col[18].setTitle("???????????????");
		col[19].setTitle("????????????");
		col[19].setType("Date");
//		col[19].setTitle("????????????");
		col[20].setTitle("??????");
		col[21].setTitle("?????????");
		col[22].setTitle("??????");
		col[23].setTitle("????????????");
		col[23].setType("Date");
		col[24].setTitle("????????????");
		col[24].setType("Date");
		col[25].setTitle("????????????");
		col[26].setTitle("?????????");
		col[27].setTitle("?????????");
		col[28].setTitle("?????????");
		col[29].setTitle("?????????");
		col[30].setTitle("???????????????");
		col[31].setTitle("?????????");
		col[32].setTitle("????????????");
		col[33].setTitle("????????????");
		col[34].setTitle("??????");

		for (int i = 0; i < col.length; i++) {
			sheet.addColumn(col[i]);
		}
		/* ??????????????? */
		List<Object[]> contentList = new ArrayList<Object[]>();
		for (GeesunBaseFsscReportModel obj : reportList) {
			Object[] row = new Object[35];
			row[0] = obj.getFdApplyDate();
			row[1] = obj.getFdApplyNumber();
			row[2] = obj.getFdApplyNo();
			row[3] = obj.getFdApplyerName();
			row[4] = obj.getFdApplyerGw();
			row[5] = obj.getFdReceiverName();
			row[6] = obj.getFdTotalMoney();
			row[7] = obj.getFdCenterName();
			row[8] = obj.getFdApplyerDeptName();
			row[9] = obj.getFdUserDeptName();
			row[10] = obj.getFdProduct();
			row[11] = obj.getFdItemName();
			row[12] = obj.getFdThreeItemName();
			row[13] = obj.getFdProjectNo();
			row[14] = obj.getFdPayReason();
			row[15] = obj.getFdQsbg();
			row[16] = obj.getFdExpenseDescription();
			row[17] = obj.getFdStatus();
			row[18] = obj.getFdXjlXm();
			row[19] = obj.getFdPayDate();
//			row[19] = obj.getFdPayDescription();
			row[20] = obj.getFdHh();
			row[21] = obj.getFdAccount();
			row[22] = obj.getFdKhh();
			row[23] = obj.getFdBeginDate();
			row[24] = obj.getFdEndDate();
			row[25] = obj.getFdTravelDays();
			row[26] = obj.getFdStartPlace();
			row[27] = obj.getFdEndPlace();
			row[28] = obj.getFdCcf();
			row[29] = obj.getFdJpf();
			row[30] = obj.getFdSnjtf();
			row[31] = obj.getFdZsf();
			row[32] = obj.getFdZffy();
			row[33] = obj.getFdCcbt();
			row[34] = obj.getFdOther();
			contentList.add(row);
		}
		// ?????????????????????contentList
		sheet.setContentList(contentList);
		// ?????????????????????workbook
		workbook.addSheet(sheet);
		/* ??????Excel */
		ExcelOutput output = new ExcelOutputImp();
		response.reset();
		if (workbook.getSheetList().size() > 0) {
			output.output(workbook, response);
		}
	}
    
}
