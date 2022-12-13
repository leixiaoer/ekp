package com.landray.kmss.geesun.oitems.util;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication;
import com.landray.kmss.sys.formula.parser.FormulaParser;
import com.landray.kmss.util.StringUtil;

public class GeesunOitemsTitleUtil {
	
	private static final Logger logger = Logger
			.getLogger(GeesunOitemsTitleUtil.class);

	/**
	 * 根据标题规则生成标题
	 * 
	 * @param modelObj
	 * @throws Exception
	 */
	public static void genTitle(IBaseModel modelObj) throws Exception {
		GeesunOitemsBudgerApplication mainModel = (GeesunOitemsBudgerApplication) modelObj;
		String titleRegulation = mainModel.getFdTemplate().getTitleRegulation();
		String mainRegulation = mainModel.getTitleRegulation();
		//优先取主文档规则
		titleRegulation = StringUtil.isNotNull(mainRegulation) ? mainRegulation :titleRegulation;
		if (StringUtils.isNotBlank(titleRegulation)) {
			FormulaParser formulaParser = FormulaParser.getInstance(modelObj);
			Object docSubject = formulaParser.parseValueScript(titleRegulation);
			if (docSubject == null || "".equals(docSubject)) {
				throw new Exception("docSubject is null");
			}
			mainModel.setDocSubject(GeesunOitemsTitleUtil
					.convertObjToString(docSubject));
		}
	}

	/**
	 * 
	 * 
	 * @param obj
	 * @param propName
	 * @return
	 */
	public static String convertObjToString(Object obj) {
		Object scriptValue = obj;
		String reString = "";

		if (scriptValue == null) {
			reString = "";
		} else {
			if (scriptValue.toString().length() > 200) {
				reString = scriptValue.toString().substring(0, 199);
			} else {
				reString = scriptValue.toString();
			}
		}
		return reString;
	}

}
