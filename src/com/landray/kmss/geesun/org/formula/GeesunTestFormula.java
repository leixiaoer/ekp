package com.landray.kmss.geesun.org.formula;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.sys.formula.parser.FormulaParser;

public class GeesunTestFormula {
	
	private static Log logger = LogFactory.getLog(GeesunTestFormula.class);
	
	public static boolean compareNumber(String fdTest) throws Exception {
		System.out.println(fdTest);
		boolean flag = false;
		Object data = FormulaParser.getRunningData();
		if (data instanceof KmReviewMain) {
			KmReviewMain main = (KmReviewMain) data;
			Map<String, Object> map = main.getExtendDataModelInfo().getModelData();
			Double num1 = (Double)map.get("fd_3af52ae5f3ea20");
			List<Map<String, Object>> detail = (List<Map<String, Object>>) map.get("fd_3af52adbf3ff9a");
			Double num2 = 0.0;
			for (Map<String, Object> detailMap : detail) {
				num2 += (Double) detailMap.get("fd_3af52ae98727cc");
			}
			if (num1 > num2) {
				flag = true;
			}
		}
		return flag;
	}
	
}
