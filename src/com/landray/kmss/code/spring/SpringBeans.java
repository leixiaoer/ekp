package com.landray.kmss.code.spring;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.code.struts.StrutsConfig;
import com.landray.kmss.code.util.XMLReaderUtil;

public class SpringBeans {
	
	private static Log logger = LogFactory.getLog(SpringBeans.class);
	
	public static SpringBeans getInstance(File file) throws Exception {
		return (SpringBeans) XMLReaderUtil.getInstance(file, SpringBeans.class);
	}

	private List<SpringBean> beans = new ArrayList<SpringBean>();

	public List<SpringBean> getBeans() {
		return beans;
	}

	public void addBean(SpringBean bean) {
		beans.add(bean);
	}

	public void setBeans(List<SpringBean> beans) {
		this.beans = beans;
	}

	public static void main(String[] args) throws Exception {
		String path = "WebContent/WEB-INF/KmssConfig/dbcenter/flowstat/struts.xml";
		StrutsConfig beans = StrutsConfig.getInstance(new File(path));
		logger.info(beans);
	}
}
