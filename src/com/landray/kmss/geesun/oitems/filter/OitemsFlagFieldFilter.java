package com.landray.kmss.geesun.oitems.filter;

import com.landray.kmss.sys.authentication.filter.FilterContext;
import com.landray.kmss.sys.authentication.filter.HQLFragment;
import com.landray.kmss.sys.authentication.filter.IAuthenticationFilter;

/**
 * 状态域过滤器
 * 
 * @author zhuhq
 * 
 */
public class OitemsFlagFieldFilter implements IAuthenticationFilter {
	public int getAuthHQLInfo(FilterContext ctx) throws Exception {
		String[] fields = ctx.getParameter("field").split("\\s*;\\s*");
		String value = ctx.getParameter("value");
		StringBuffer whereBlock = new StringBuffer();
		for (int i = 0; i < fields.length; i++) {
			whereBlock.append(" or ");
			whereBlock.append(ctx.getModelTable() + "." + fields[i] + "="
					+ value);
		}
		whereBlock.append(" or ");
		whereBlock.append(ctx.getModelTable() + ".authReaderFlag is null");
		ctx.setHqlFragment(new HQLFragment(whereBlock.toString().substring(4)));
		return FilterContext.RETURN_VALUE;
	}
}
