package com.landray.kmss.geesun.oitems.converter;

import java.math.BigDecimal;

import org.apache.commons.beanutils.NestedNullException;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.common.convertor.BaseFormConvertor;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.common.convertor.IFormToModelConvertor;
import com.landray.kmss.sys.log.util.UserOperConvertHelper;
import com.landray.kmss.util.StringUtil;

public class FormConverter_String2Double extends BaseFormConvertor implements IFormToModelConvertor {
	private static final Log logger = LogFactory.getLog(FormConverter_String2Double.class);


	/**
	 * @param tPropertyName
	 *            目标属性名
	 */
	public FormConverter_String2Double(String tPropertyName) {
		this.tPropertyName = tPropertyName;
	}

	public void excute(ConvertorContext ctx) throws Exception {
		Object obj;
		try {
			obj = PropertyUtils.getProperty(ctx.getSObject(), ctx.getSPropertyName());
		} catch (NestedNullException e) {
			if (logger.isDebugEnabled())
				logger.debug("获取属性" + ctx.getSPropertyName() + "的值时中间出现null值，不转换该属性");
			return;
		}
		if (obj != null) {
			if (obj instanceof String) {
				// obj = Double.parseDouble((String) obj);
				// System.out.println(obj);
				if (!StringUtil.isNull(obj.toString())) {
					BigDecimal b = new BigDecimal((String) obj);
					b.setScale(2, BigDecimal.ROUND_HALF_UP);
					// 记录日志
					saveOperLog(ctx, obj);
					PropertyUtils.setSimpleProperty(ctx.getTObject(), getTPropertyName(), b.doubleValue());
				} else {
					// 记录日志
					saveOperLog(ctx, null);
					PropertyUtils.setSimpleProperty(ctx.getTObject(), getTPropertyName(), null);
				}
			}
			// BeanUtils.copyProperty(ctx.getTObject(), getTPropertyName(),
			// obj);
		} else {
			if (logger.isDebugEnabled())
				logger.debug("属性" + ctx.getSPropertyName() + "的值为null，不转换该属性");
		}
	}

	/**
	 * 保存操作日志
	 * 
	 * @param ctx
	 * @param obj
	 */
	public void saveOperLog(ConvertorContext ctx, Object obj) {
		if (!UserOperConvertHelper.isConvertAllow()) {
			return;
		}
		if (ctx.getLogOper() == null) {
			return;
		}
		UserOperConvertHelper.convertCommon(ctx, ctx.getTObject(),
				getTPropertyName(), ctx.getSObject(),
				ctx.getSPropertyName(), obj);
	}

	public FormConverter_String2Double setTPropertyName(String propertyName) {
		tPropertyName = propertyName;
		return this;
	}
}
