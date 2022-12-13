package com.landray.kmss.fssc.common.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class FsscCommonCheckVersionTag extends TagSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1126345L;
	private String version;
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public int doStartTag()throws JspException{
		try {
//			if(FsscCommonUtil.checkVersion(version)){
//			if(1 == 1){
				return 1;
//			}
		} catch (Exception e) {
			return 0;
		}
//		return 0;
	}

}
