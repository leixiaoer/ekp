package com.landray.kmss.util.excel;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;

/**
 * excel单元格样式枚举
 */
public enum CellStyleEnum {

	/**
	 * 水平居中
	 */
	ALIGNMENT_ALIGN_CENTER,
	/**
	 * 垂直居中
	 */
	VERTICALALIGNMENT_VERTICAL_CENTER;
	
	/**
	 * 根据枚举来设置样式
	 */
	public static void geneCellStyle(HSSFCellStyle style, CellStyleEnum cellStyle){
		switch (cellStyle) {
		case ALIGNMENT_ALIGN_CENTER:
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			break;
		case VERTICALALIGNMENT_VERTICAL_CENTER:
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			break;
		default:
			break;
		}
	}
}
