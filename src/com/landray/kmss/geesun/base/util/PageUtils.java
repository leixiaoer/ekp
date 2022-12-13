package com.landray.kmss.geesun.base.util;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.util.StringUtil;

/**
 * 分页工具类
 * 
 */
public class PageUtils {
	// 分页公共代码
	public static StatisticsPageInfo buildStatisticsPageInfo(HttpServletRequest request) throws Exception {
		String ordertype = request.getParameter("ordertype");
		String orderby = request.getParameter("orderby");
		boolean isReserve = false;
		if (ordertype != null && ordertype.equalsIgnoreCase("down")) {
			isReserve = true;
		}
		int pageno = getPageNo(request);
		int rowsize = getRowSize(request);
		 
		if (isReserve) {
			orderby += " desc";
		}
		StatisticsPageInfo statisticsPageInfo = new StatisticsPageInfo();
		statisticsPageInfo.setPageno(pageno);
		statisticsPageInfo.setRowsize(rowsize);
		statisticsPageInfo.setOrderby(orderby);
		statisticsPageInfo.setOrdertype(ordertype);
		return statisticsPageInfo;
	}
	
	public static int getPageNo(HttpServletRequest request) {
		int pageno = 0;
		String s_pageno = request.getParameter("pageno");
		if (s_pageno != null && s_pageno.length() > 0) {
			pageno = Integer.parseInt(s_pageno);
		}
		return pageno;
	}
	
	public static int getRowSize(HttpServletRequest request) {
		int rowsize = 0;
		String s_rowsize = request.getParameter("rowsize");
		if (StringUtil.isNotNull(SysConfigParameters.getFdRowSize())) {
			rowsize = Integer.parseInt(SysConfigParameters.getFdRowSize());
		}
		if (s_rowsize != null && s_rowsize.length() > 0) {
			rowsize = Integer.parseInt(s_rowsize);
		}
		return rowsize;
	}
}


