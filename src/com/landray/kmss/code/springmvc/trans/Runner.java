package com.landray.kmss.code.springmvc.trans;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * SrpingMvc转换的执行程序
 */
public class Runner {
	
	private static Log logger = LogFactory.getLog(Runner.class);
	
	/** 报告文件 */
	public static String REPORTFILE = "report.txt";
	/** 转换目录 */
	public static String[] SCANPATHS = { "src", "WebContent" };
	/** 移除struts.xml */
	public static boolean DELETE_STRUTSXML = true;

	public static void main(String[] args) throws Exception {
		TransContext context = new TransContext();
		// 将本项目文件转换成SpringMVC框架
		logger.info("开始迁移相关程序 ...");
		new SrpingMvcTrans(context).start();
		logger.info("");
		// 清理struts.xml
		if (DELETE_STRUTSXML) {
			if (context.hasError()) {
				logger.warn("由于前面步骤存在错误，跳过struts.xml的清理任务\r\n");
				// new DeleteXmlFile(context).start();
			} else {
				logger.info("开始清理strtus.xml ...");
				new DeleteXmlFile(context).start();
				logger.info("");
			}
		}
		// 打印结果
		context.report();
	}
}
