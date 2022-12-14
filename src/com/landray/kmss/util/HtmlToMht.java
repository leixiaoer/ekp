package com.landray.kmss.util;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.MimetypesFileTypeMap;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.CookieStore;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.htmlparser.Node;
import org.htmlparser.Parser;
import org.htmlparser.Tag;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.lexer.Lexer;
import org.htmlparser.lexer.Page;
import org.htmlparser.scanners.ScriptScanner;
import org.htmlparser.tags.Div;
import org.htmlparser.tags.ScriptTag;
import org.htmlparser.tags.TitleTag;
import org.htmlparser.util.DefaultParserFeedback;
import org.htmlparser.util.NodeList;
import org.htmlparser.util.ParserException;
import org.htmlparser.visitors.NodeVisitor;

import com.gargoylesoftware.htmlunit.BrowserVersion;
import com.gargoylesoftware.htmlunit.NicelyResynchronizingAjaxController;
import com.gargoylesoftware.htmlunit.ScriptResult;
import com.gargoylesoftware.htmlunit.WebClient;
import com.gargoylesoftware.htmlunit.WebRequest;
import com.gargoylesoftware.htmlunit.WebResponse;
import com.gargoylesoftware.htmlunit.html.HtmlPage;
import com.landray.kmss.common.exception.KmssRuntimeException;
import com.landray.kmss.sys.authentication.user.KMSSUser;
import com.landray.kmss.web.Globals;



/**
 * 
 * mht???????????????
 * 
 */
public class HtmlToMht {

	/** ???????????? */
	private String strEncoding = null;
	private String title = null;
	private WebClient wc;
	protected int JS_DELAY = 5000;
	// mht??????????????????
	// private String from = "lishigui@126.com";
	// private String to = "lishigui@126.com";
	// private String subject = "blog.csdn.net/lishigui";
	private String from = null;
	private String to = null;

	private static final Log logger = LogFactory.getLog(HtmlToMht.class);

	/**
	 * ?????????
	 * 
	 * @param initWC
	 *            ???????????????WebClient?????????getPage???????????????true???
	 * @throws Exception
	 */
	public HtmlToMht(boolean initWC) throws Exception {
		if (initWC) {
			wc = new WebClient(BrowserVersion.CHROME);
			wc.setJavaScriptTimeout(10000);
			wc.getOptions().setUseInsecureSSL(true);// ???????????????????????? ???????????????????????????
			wc.getOptions().setJavaScriptEnabled(true);// ????????????javascript??????
			wc.getOptions().setCssEnabled(false);// ??????css??????
			wc.getOptions().setThrowExceptionOnScriptError(false);// js??????????????????????????????
			wc.getOptions().setThrowExceptionOnFailingStatusCode(false); // ??????????????????????????????
			wc.getOptions().setPrintContentOnFailingStatusCode(false);
			wc.getOptions().setTimeout(100000);// ????????????????????????
			wc.getOptions().setDoNotTrackEnabled(false);
			wc.setAjaxController(new NicelyResynchronizingAjaxController());
			wc.getCookieManager().setCookiesEnabled(true);// enable
		}
	}

	public static void setLocaleWhenExport(HttpServletRequest request) {
		String j_lang = request.getParameter("j_lang");
		if (StringUtil.isNotNull(j_lang)) {
			Locale locale = ResourceUtil.getLocale(j_lang);
			KMSSUser user = UserUtil.getKMSSUser(request);
			if (user != null) {
				user.setLocale(locale);
			}
			request.getSession().setAttribute(Globals.LOCALE_KEY, locale);
		}
	}

	/**
	 * ??????.mht??????
	 * 
	 * @param request
	 *            ?????????????????????requestUrl???????????????cookie????????????????????????
	 * @param response
	 * @throws Exception
	 */
	public void output(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String url = request.getParameter("requestUrl");
		if (StringUtil.isNull(url)) {
			throw new IllegalArgumentException();
		}
		String urlPrefix = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
		String innerUrlPrefix = ResourceUtil.getKmssConfigString("kmss.innerUrlPrefix");
		if(StringUtil.isNotNull(innerUrlPrefix)){
			url = url.replace(urlPrefix, innerUrlPrefix);
		}
		String sourceCode = request.getParameter("sourceCode");
		title = request.getParameter("title");
		// ?????????js?????????html?????????
		String strText = getClientPage(request, url);
		// String strText = getPage(request, url, sourceCode);
		if (StringUtil.isNull(strText)) {
			throw new Exception("?????????????????????????????????");
		}
		//
		response.reset();
		title = encodeFileName(request, (StringUtil.isNotNull(title) ? title : "html??????") + ".html", true);
		String contentType = FileMimeTypeUtil.getContentType(title);
		response.setContentType(contentType);
		response.setCharacterEncoding(StringUtil.isNull(strEncoding) ? "UTF-8" : strEncoding);
		response.setHeader("Pragma", "public");// ??????ie6??????????????????,ie8???https????????????????????????
		String open = request.getParameter("open");
		if (StringUtil.isNotNull(open)) {
			response.setHeader("Content-Disposition", "filename=\"" + title + "\"");
		} else {
			response.setHeader("Content-Disposition", "attachment;filename=\"" + title + "\"");
		}
		PrintWriter out = response.getWriter();
		out.write(strText);
		out.flush();
		out.close();
		// compile(new URL(url), strText, response);

		return;
	}

	/**
	 * ?????????????????????JS??????????????? ???htmlunit???
	 * 
	 * @param request
	 *            ???????????????????????????????????????
	 * @param url
	 *            ?????????URL
	 * @param sourceCode
	 *            ?????????????????????js??????
	 * @return
	 * @throws Exception
	 */
	public String getPage(HttpServletRequest request, String url, String sourceCode) throws Exception {
		String result = null;
		//final String _contextPath = ResourceUtil.getKmssConfigString("kmss.innerUrlPrefix");
		
		final String _contextPath = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
		
		String contextPath = request.getContextPath();
		
		if (url == null || url.trim().equals("")) {
			return "";
		}
		int index = url.indexOf(contextPath)+contextPath.length();
		
		String contextPathUrl = url.substring(index);
		
		url = _contextPath + contextPathUrl;

		String host = HttpClientUtil.getDomainByUrl(_contextPath);
		
		String domain = host.contains(":")?host.substring(0,host.indexOf(":")):host;

		if (url.indexOf("j_lang=") == -1) {
			String j_lang = ResourceUtil.getLocaleStringByUser(request);
			url += url.indexOf("?") == -1 ? "?" : "&" + "j_lang=" + j_lang;
		}
		Cookie[] cks = request.getCookies();
		for (Cookie ck : cks) {
			com.gargoylesoftware.htmlunit.util.Cookie cookie = new com.gargoylesoftware.htmlunit.util.Cookie(domain,
					ck.getName(), ck.getValue());
			wc.getCookieManager().addCookie(cookie);
		}

		// ????????????URL
		WebRequest webRequest = new WebRequest(new URL(url), "post");
		HtmlPage page = null;
		try {
			page = wc.getPage(webRequest);
			if (StringUtil.isNotNull(sourceCode)) {
				ScriptResult sResult = page.executeJavaScript(sourceCode);
				page = (HtmlPage) sResult.getNewPage();
			}
		} catch (Exception e) {
		}
		// ???????????????????????????
		if (page == null) {
			KmssMessage msg = new KmssMessage("errors.required","page object");
			throw new KmssRuntimeException(msg);
		}
		WebResponse webResponse = page.getWebResponse();
		strEncoding = webResponse.getContentCharset();
		// ??????javascript?????????
		wc.waitForBackgroundJavaScript(JS_DELAY);
		result = page.asXml();
		if (StringUtil.isNull(title))
			title = page.getTitleText();
		ScriptScanner.STRICT = false; // ??????htmlparser????????????????????????</>???????????????????????????
		Parser parser = createParser(result);
		Node html = parser.parse(new TagNameFilter("html")).elementAt(0);
		html.accept(new NodeVisitor() {
			@Override
			public void visitTag(Tag tag) {
				String src = tag.getAttribute("src");
				String href = tag.getAttribute("href");
				String data_remove = tag.getAttribute("data-remove");
				if ("true".equals(data_remove)) {
					tag.getParent().getChildren().remove(tag);
				} else if ("script".equalsIgnoreCase(tag.getTagName()) && src != null && !src.startsWith("http")) {
					tag.setAttribute("src", _contextPath + src);
				} else if ("link".equalsIgnoreCase(tag.getTagName()) && href != null && !href.startsWith("http")) {
					tag.setAttribute("href", _contextPath + href);
				} else if ("img".equalsIgnoreCase(tag.getTagName()) && src != null) {
					if (!src.startsWith("http")) {
						tag.setAttribute("src", _contextPath + src);
					}
					if (src.contains("sys/attachment/sys_att_main/sysAttMain.do?method=download")) {
						src = src.replace("sys/attachment/sys_att_main/sysAttMain.do?method=download",
								"sys/print/data/sysPrintWordData.do?method=loadImage");
						tag.setAttribute("src", src);
						if (StringUtil.isNull(tag.getAttribute("width"))) {
							tag.setAttribute("width", "132");
						}
						if (StringUtil.isNull(tag.getAttribute("height"))) {
							tag.setAttribute("height", "132");
						}
					}
				} else if ("div".equalsIgnoreCase(tag.getTagName())
						&& "lui/toolbar!Button".equals(tag.getAttribute("data-lui-type"))) {
					String remove = tag.getAttribute("data-remove");
					if (StringUtil.isNull(remove) || "true".equals(remove)) {
						Div div = (Div) tag;
						div.getParent().getChildren().remove(div);
					}
				} else if ("div".equalsIgnoreCase(tag.getTagName())
						&& "lui/toolbar!ToolBar".equals(tag.getAttribute("data-lui-type"))) {
					String remove = tag.getAttribute("data-remove");
					if (StringUtil.isNull(remove) || "true".equals(remove)) {
						Div div = (Div) tag;
						div.getParent().getChildren().remove(div);
					}
				}
			}
		});
		result = html.toHtml();
		ScriptScanner.STRICT = true; // ??????
		String absPath = _contextPath;
		result = absoluteContext(absPath, request.getContextPath(), result);
		result = preventRefresh(result);
		return result;
	}

	/**
	 * ???????????????HTML???????????????????????????????????????????????????????????????????????????????????????HTML????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????HTML????????????????????????????????????????????????????????????????????????
	 * 
	 * @param result
	 * @return
	 */
	private String preventRefresh(String result) {
		String script = "\n<script type=\"text/javascript\">\n" + "	domain.register(\"login\", function(){});\n"
				+ "	LUI.ajaxComplete = function(xhr) {}\n" + "</script>";
		result = result.replace("</html>", script + "</html>");
		return result;
	}

	/**
	 * ??????httpClient??????????????????
	 * 
	 * @param request
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public String getClientPage(HttpServletRequest request, String url) throws Exception {
		String result = null;
		try {
			String cookieHeader = request.getHeader("Cookie");
			logger.warn("ServerName:"+request.getServerName());
			logger.warn("ServerPort:"+request.getServerPort());
			logger.warn("ServletPath:"+request.getServletPath());
			logger.warn("Header Cookie:"+cookieHeader);
			logger.warn("SESSIONID :"+request.getRequestedSessionId());
			String innerUrlPrefix = ResourceUtil.getKmssConfigString("kmss.innerUrlPrefix");
			if(StringUtil.isNull(innerUrlPrefix)){
				innerUrlPrefix = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
			}
			
			URI innerUri = new URI(innerUrlPrefix);
			String fdHost = innerUri.getHost();
			String fdPath = innerUri.getPath();
			if (!fdPath.endsWith("/")) {
				fdPath += "/";
			}
			logger.warn("fdHost:"+fdHost);
			logger.warn("fdPath:"+fdPath);
			
			if (url.indexOf("j_lang=") == -1) {
				String j_lang = ResourceUtil.getLocaleStringByUser(request);
				url += url.indexOf("?") == -1 ? "?" : "&" + "j_lang=" + j_lang;
			}
			url+= url.indexOf("?") == -1 ? "?" : "&" + "isGetHtml=true";
			CookieStore stores = new BasicCookieStore();
			/**
			Cookie[] cks = request.getCookies();
			for (Cookie ck : cks) {
				BasicClientCookie cookie = new BasicClientCookie(ck.getName(),
						CookieHelper.getCookie(request, ck.getName()));
				cookie.setDomain(fdHost);
				cookie.setPath(fdPath);
				stores.addCookie(cookie);
			}
			// archive??????????????????
			if ("fileDoc".equals(request.getParameter("method"))
					|| "fileDocAll".equals(request.getParameter("method"))) {
				BasicClientCookie _fromSource = new BasicClientCookie("_fromSource", "ArChIvE");
				_fromSource.setDomain(fdHost);
				_fromSource.setPath(fdPath);
				stores.addCookie(_fromSource);
			}
			**/
			CloseableHttpClient client = new HttpUtil().createHttpClient(url, stores);
			HttpGet method = new HttpGet(url);
			// JG??????????????????IE?????????????????????
			method.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko");
			cookieHeader = cookieHeader +"; _fromSource=ArChIvE";
			logger.warn("CookieHeader:"+cookieHeader);
			logger.warn("Url :"+url);
			method.setHeader("Cookie", cookieHeader);
			HttpResponse httpResponse = client.execute(method);
			HttpEntity entity = httpResponse.getEntity();
			result = EntityUtils.toString(entity);

			String urlPrefix = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
			result = result.replace(innerUrlPrefix, urlPrefix);
			URI uri = new URI(urlPrefix);
			final String _contextPath = uri.getScheme() + "://" + uri.getHost()
					+ (uri.getPort() == -1 ? "" : (":" + uri.getPort()));
			// ?????????????????????HTML
			result = getHtmlPageResult(result, url, _contextPath);
			String absPath = urlPrefix;
			String context = request.getContextPath();
			result = absoluteContext(absPath, context, result);
			result = preventRefresh(result);
		} catch (Exception e) {
			logger.error("??????html?????????URL???" + url,e);
			throw new RuntimeException("??????html?????????URL???"+ url , e);
		}
		return result;
	}
	
	/**
	 * ????????????????????????Html
	 * 
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public String getClientPageArchives(String url) throws Exception {
		String result = null;
		try {
			GetMethod get = HttpClientUtil.createGetMethod(url);
			HttpClient httpClient = HttpClientUtil.createClient();
			HttpClientUtil.addCookieToHttpClient(httpClient, HttpClientUtil.getDomainByUrl(url), "_fromSource",
					"ArChIvE");
			result = HttpClientUtil.getDataByHttpClient(httpClient, get);

			String serverUrl = ResourceUtil.getKmssConfigString("kmss.innerUrlPrefix");
			String tempUrl = "";
			if (serverUrl.startsWith("http://")) {
				tempUrl = serverUrl.substring(7);
			} else if (serverUrl.startsWith("https://")) {
				tempUrl = serverUrl.substring(8);
			}
			if (tempUrl.lastIndexOf("/") != -1) { // ????????????
				serverUrl = serverUrl.substring(0, serverUrl.lastIndexOf("/"));
			}
			final String contextPath = serverUrl;
			result = getHtmlPageResult(result, url, contextPath);

			if (tempUrl.lastIndexOf("/") != -1) { // ????????????
				String absPath = ResourceUtil.getKmssConfigString("kmss.innerUrlPrefix");
				String context = absPath.substring(absPath.lastIndexOf("/"));
				result = absoluteContext(absPath, context, result);
			}
			result = preventRefresh(result);
		} catch (Exception e) {
			logger.error("??????html?????????URL???" + url);
			throw e;
		}
		return result;
	}

	public static void main(String args[]) throws Exception {
			
		String result = "<script>Com_IncludeFile('standardtable.css','http://localhost:8080/gkp/sys/xform/designer/standardtable/tablestyle/tb_normal_rednone/','css',true);23423423423424,234234234;23423423j;Com_IncludeFile('3333.css','http://localhost:8080/gkp/sys/xform/designer/standardtable/tablestyle/tb_normal_rednone/','css',true);</script>";
		
		Parser parser = createParser(result);
		Node script = parser.parse(new TagNameFilter("script")).elementAt(0);
		script.accept(new NodeVisitor() {
			@Override
			public void visitTag(Tag tag) {
				if ("script".equalsIgnoreCase(tag.getTagName())) {
				ScriptTag script = (ScriptTag) tag;
					String codeStr = script.getScriptCode();
					Pattern p = Pattern.compile("Com_IncludeFile.+?.true");
					//Pattern p = Pattern.compile("'[^,]+','[a-zA-Z]+://[^\s^']*',('css'|"css")");
					//'[^,]+','[a-zA-Z]+://[^\s^']*',('css'|"css")
					Matcher m = p.matcher(codeStr);
					while (m.find()) {
						String matchStr = m.group();
						String[] matchStrArr = matchStr.split(",");
						System.out.println(matchStrArr[0]);
						String[] matchStrArr2 = matchStrArr[0].split("'");
						System.out.println(matchStrArr2[1]);
						
 						String cssPath = matchStrArr[1]+matchStrArr[0];
					}
				}
			};
		});
		
		//System.out.println(script.);
	}
	

	/**
	 * HTML???????????????
	 * 
	 * @param result
	 * @param url
	 * @param contextPath
	 *            http://localhost:8080
	 * @return
	 * @throws Exception
	 */
	private String getHtmlPageResult(String result, String url, final String contextPath) throws Exception {
		ScriptScanner.STRICT = false; // ??????htmlparser????????????????????????</>???????????????????????????
		Parser parser = createParser(result);
		Node html = parser.parse(new TagNameFilter("html")).elementAt(0);
		if (html == null) {
			throw new Exception("page not found:" + url);
		}
		// ui:event?????????????????????????????????????????????????????????????????????
		final StringBuffer luiEvtShowCode = new StringBuffer();
		// CSS???????????????
		final StringBuffer cssStyles = new StringBuffer();
		// ??????1*1px?????? Data/Base64?????????gif????????????
		final String IMG_BLANK = "data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQImWNgYGBgAAAABQABh6FO1AAAAABJRU5ErkJggg==";
		html.accept(new NodeVisitor() {
			@Override
			public void visitTag(Tag tag) {
				String src = tag.getAttribute("src");
				String href = tag.getAttribute("href");
				String data_remove = tag.getAttribute("data-remove");
				if ("true".equals(data_remove)) {
					tag.getParent().getChildren().remove(tag);
				} else if ("script".equalsIgnoreCase(tag.getTagName())) {
					//????????????Com_IncludeFile?????????????????????
					ScriptTag scriptTag = (ScriptTag) tag;
					String codeStr = scriptTag.getScriptCode();
					Pattern p = Pattern.compile("Com_IncludeFile.+?.true");
					Matcher m = p.matcher(codeStr);
					while (m.find()) {
						String matchStr = m.group();
						String cssPath = "";
						String[] matchStrArr = matchStr.split(",");
						boolean flag = false;
						if(matchStrArr.length > 1){
							if(matchStrArr[1].indexOf("'") >-1){
								String[] matchStrArr1 = matchStrArr[1].split("'");
								if(matchStrArr1.length > 1){
									if (matchStrArr1[0].contains(
											"Com_Parameter.ContextPath")) {
										flag = true;
									}
									cssPath+=matchStrArr1[1];
								}
							}else if(matchStrArr[1].indexOf("\"") >-1){
								String[] matchStrArr1 = matchStrArr[1].split("\"");
								if(matchStrArr1.length > 1){
									if (matchStrArr1[0].contains(
											"Com_Parameter.ContextPath")) {
										flag = true;
									}
									cssPath+=matchStrArr1[1];
								}
							}
							if(matchStrArr[0].indexOf("'") >-1){
								String[] matchStrArr2 = matchStrArr[0].split("'");
								if(matchStrArr2.length > 1){
									cssPath+=matchStrArr2[1];
								}
							}else if(matchStrArr[0].indexOf("\"") >-1){
								String[] matchStrArr2 = matchStrArr[0].split("\"");
								if(matchStrArr2.length > 1){
									cssPath+=matchStrArr2[1];
								}
							}
							if(flag) {
								cssStyles.append(getStyleContent(ResourceUtil.getKmssConfigString(
														"kmss.urlPrefix")+ "/" + cssPath));
							}else {
								cssStyles.append(getStyleContent(contextPath+cssPath));
							}
						}
					}
					
					if (src != null && !src.startsWith("http")) {
						tag.setAttribute("src", contextPath + src);
					} else if ("lui/event".equals(tag.getAttribute("type"))
							&& "show".equals(tag.getAttribute("data-lui-event"))) {
						ScriptTag script = (ScriptTag) tag;
						luiEvtShowCode.append(script.getScriptCode());
					}
				} else if ("link".equalsIgnoreCase(tag.getTagName()) && href != null) {
					if (!href.startsWith("http")) {
						tag.setAttribute("href", contextPath + href);
					}
					if (href.contains(".css")) {
						cssStyles.append(getStyleContent(tag.getAttribute("href")));
						tag.setAttribute("href", "");
					}
				} else if ("img".equalsIgnoreCase(tag.getTagName())) {
					if (src == null) {
						// ??????src?????????img???????????????????????????
						tag.setAttribute("src", IMG_BLANK);
					} else {
						if (src.contains("sys/attachment/sys_att_main/sysAttMain.do")
								&& src.contains("method=download")) {
							// ????????????img?????????src?????????jsessionid
							Pattern p = Pattern.compile("^.+sysAttMain.do(;jsessionid=(\\w+))?\\?method=download.+$");
							Matcher m = p.matcher(src);
							if (m.find()) {
								String matchStr = m.group(1);
								if (StringUtil.isNotNull(matchStr)) {
									src = src.replace(matchStr, "");
								}
							}
							src = src.replace("sys/attachment/sys_att_main/sysAttMain.do?method=download",
									"sys/print/data/sysPrintWordData.do?method=loadImage");
						}
						if (!src.contains("data:image")) {
							tag.setAttribute("src", getBASE64Image(contextPath + src));
						}
					}
				} else if ("div".equalsIgnoreCase(tag.getTagName())
						&& "lui/toolbar!Button".equals(tag.getAttribute("data-lui-type"))) {
					String remove = tag.getAttribute("data-remove");
					if (StringUtil.isNull(remove) || "true".equals(remove)) {
						Div div = (Div) tag;
						div.getParent().getChildren().remove(div);
					}
				} else if ("div".equalsIgnoreCase(tag.getTagName())
						&& "lui/toolbar!ToolBar".equals(tag.getAttribute("data-lui-type"))) {
					String remove = tag.getAttribute("data-remove");
					if (StringUtil.isNull(remove) || "true".equals(remove)) {
						Div div = (Div) tag;
						div.getParent().getChildren().remove(div);
					}
				} else if ("title".equalsIgnoreCase(tag.getTagName())) {
					if (StringUtil.isNull(title)) {
						TitleTag titleTag = (TitleTag) tag;
						title = StringUtils.trim(titleTag.getTitle());
					}
				} else if ("meta".equalsIgnoreCase(tag.getTagName())) {
					if (tag.getAttribute("http-equiv") != null
							&& tag.getAttribute("http-equiv").equalsIgnoreCase("Content-Type")) {
						String content = tag.getAttribute("content");
						Pattern pat = Pattern.compile(".*charset=([^;]*).*");
						Matcher matcher = pat.matcher(content);
						if (matcher.find()) {
							strEncoding = matcher.group(1);
						}
					}
				}
			}
		});
		// ??????????????????????????????????????????????????????URL????????????
		ScriptTag onload = new ScriptTag();
		StringBuilder replaceImgSrcBuilder = new StringBuilder();
		replaceImgSrcBuilder.append("seajs.use(['lui/jquery'], function($) { ");
		replaceImgSrcBuilder.append("	$(document).ready(function() { ");
		

		replaceImgSrcBuilder.append("  for(var key in window.Attachment_ObjectInfo){ ");
		replaceImgSrcBuilder.append("  var attachmentObject = window.Attachment_ObjectInfo[key];");
		replaceImgSrcBuilder.append("   attachmentObject.getUrl = function(method, docId) { ");
		replaceImgSrcBuilder.append("  var url = Com_Parameter.ContextPath; ");
		replaceImgSrcBuilder.append("  if(url.substring(0,4) !== 'http') { ");
		replaceImgSrcBuilder.append("  url = self.getHost() + url;} ");
		replaceImgSrcBuilder.append("  url += \"sys/attachment/sys_att_main/sysAttMain.do?method=\" + method+ \"&fdId=\" + docId; ");
		replaceImgSrcBuilder.append("   if('download'== method){ ");
		replaceImgSrcBuilder.append("  url = url.replace(\"sys/attachment/sys_att_main/sysAttMain.do?method=download\", \"sys/print/data/sysPrintWordData.do?method=loadImage\");} ");
		replaceImgSrcBuilder.append("   if (window.console) console.log(url ); ");
		replaceImgSrcBuilder.append("  return url;};} ");
		
		
		replaceImgSrcBuilder.append("		 var replaceImgSrc = function(retryTimes, index) { ");
		replaceImgSrcBuilder.append("		 	if(retryTimes > index) { ");
		replaceImgSrcBuilder.append("			 	var $imgs = $(\"img[src]\"); ");
		replaceImgSrcBuilder.append("			 	if($imgs.length > 0) { ");
		replaceImgSrcBuilder.append("					$imgs.attr('src', function() { ");
		replaceImgSrcBuilder.append("						var src = $(this).attr('src'); ");
		replaceImgSrcBuilder.append("						if (src.substring(0, 7) === 'file://') src = src.substring(7); ");
		replaceImgSrcBuilder.append("						return src.replace('sys/attachment/sys_att_main/sysAttMain.do?method=download','sys/print/data/sysPrintWordData.do?method=loadImage'); ");
		replaceImgSrcBuilder.append(" 					}); ");
		replaceImgSrcBuilder.append("				" + luiEvtShowCode.toString());
		replaceImgSrcBuilder.append("		 		} ");
		replaceImgSrcBuilder.append("		 		else { ");
		replaceImgSrcBuilder.append("		 			setTimeout(function(){ ");
		replaceImgSrcBuilder.append("		 				replaceImgSrc.call(this, retryTimes, ++index); ");
		replaceImgSrcBuilder.append("		 			}, 300);");
		replaceImgSrcBuilder.append("		 		} ");
		replaceImgSrcBuilder.append("			} ");
		replaceImgSrcBuilder.append("		}; ");
		replaceImgSrcBuilder.append("		replaceImgSrc.call(this, 5, 0); ");
		replaceImgSrcBuilder.append("	}); ");
		replaceImgSrcBuilder.append("}); </SCRIPT>");
		replaceImgSrcBuilder.append(cssStyles.toString());
		onload.setScriptCode(replaceImgSrcBuilder.toString());
		html.getChildren().add(onload);
		result = html.toHtml();
		ScriptScanner.STRICT = true; // ??????
		return result;
	}

	public String getStyleContent(String URL) {
		byte[] data = getBytesFromUrl(URL);
		if (data != null) {
			String content = new String(data);
			return "\r\n<style type=\"text/css\">\r\n" + content + "\r\n</style>";
		}
		return "";
	}

	public String getBASE64Image(String URL) {
		byte[] data = getBytesFromUrl(URL);
		if (data != null) {
			String encode = Base64.encodeBase64String(data);
			return "data:image/png;base64," + encode;
		}
		return URL;
	}

	public byte[] getBytesFromUrl(String URL) {
		byte[] data = null;
		try {
			InputStream is = null;
			HttpURLConnection conn = null;
			try {
				URL url = new URL(URL);
				conn = (HttpURLConnection) url.openConnection();
				conn.setDoInput(true);
				conn.setRequestMethod("GET");
				conn.setConnectTimeout(10000);
				is = conn.getInputStream();
				if (conn.getResponseCode() == 200) {
					data = IOUtils.toByteArray(is);
				} else {
					data = null;
				}
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (is != null) {
						is.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				conn.disconnect();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}

	/**
	 * ??????????????????????????????
	 * 
	 * @param request
	 * @param result
	 * @return
	 */
	private String absoluteContext(String absPath, String context, String result) {
		// ??????'/ekp/???"/ekp/??????????????????
		result = result.replace("\"" + context + "/", "\"" + absPath + "/").replace("'" + context + "/",
				"'" + absPath + "/");
		//
		Pattern p = Pattern.compile("base\\s*?:\\s*?['\"]" + context + "['\"]");
		Matcher m = p.matcher(result);
		result = m.replaceFirst("base:'" + absPath + "'");
		p = Pattern.compile("contextPath\\s*?:\\s*?['\"]" + context + "['\"]");
		m = p.matcher(result);
		result = m.replaceFirst("contextPath:'" + absPath + "'");
		return result;
	}

	/**
	 * ?????????????????????????????????<br>
	 * ???????????????strWeb ????????????; strText ????????????; response<br>
	 * ???????????????boolean<br>
	 */
	public boolean compile(URL strWeb, String strText, HttpServletResponse response) {
		if (strWeb == null || strText == null || response == null) {
			return false;
		}
		HashMap urlMap = new HashMap();
		NodeList nodes = new NodeList();
		try {
			Parser parser = createParser(strText);
			nodes = parser.parse(null);
		} catch (ParserException e) {
			e.printStackTrace();
		}

		URL strWebB = extractAllScriptNodes(nodes);
		if (strWebB == null || StringUtil.isNull(strWebB.toString())) {
			strWebB = strWeb;
		}
		ArrayList urlScriptList = extractAllScriptNodes(nodes, urlMap, strWebB);
		ArrayList urlImageList = extractAllImageNodes(nodes, urlMap, strWebB);
		if (strWebB == null || StringUtil.isNull(strWebB.toString())) {
			for (Iterator iter = urlMap.entrySet().iterator(); iter.hasNext();) {
				Map.Entry entry = (Map.Entry) iter.next();
				String key = (String) entry.getKey();
				String val = (String) entry.getValue();
				strText = strText.replace(val, key);
			}
		}

		try {
			createMhtArchive(strText, urlScriptList, urlImageList, strWeb, response);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;

	}

	/**
	 * ?????????????????????????????????<br>
	 * ???????????????url ????????????<br>
	 * ???????????????byte[]<br>
	 */
	public byte[] downBinaryFile(String url) {
		InputStream raw = null;
		InputStream in = null;
		try {
			URL cUrl = new URL(url);
			URLConnection uc = cUrl.openConnection();
			uc.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
			// String contentType = this.strType;
			int contentLength = uc.getContentLength();
			if (contentLength > 0) {
				raw = uc.getInputStream();
				in = new BufferedInputStream(raw);
				byte[] data = new byte[contentLength];
				int bytesRead = 0;
				int offset = 0;
				while (offset < contentLength) {
					bytesRead = in.read(data, offset, data.length - offset);
					if (bytesRead == -1) {
						break;
					}
					offset += bytesRead;
				}

				return data;
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {

		} finally {
			if (in != null)
				try {
					in.close();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			if (raw != null)
				try {
					raw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}

		return null;

	}

	/**
	 * ?????????????????????HTML parser<br>
	 * ???????????????inputHTML ??????????????????<br>
	 * ???????????????HTML parser<br>
	 */
	private static Parser createParser(String inputHTML) {
		Lexer mLexer = new Lexer(new Page(inputHTML));
		return new Parser(mLexer, new DefaultParserFeedback(DefaultParserFeedback.QUIET));
	}

	/**
	 * ???????????????????????????URL??????<br>
	 * ???????????????nodes ??????????????????<br>
	 * ???????????????URL<br>
	 */
	private URL extractAllScriptNodes(NodeList nodes) {

		NodeList filtered = nodes.extractAllNodesThatMatch(new TagNameFilter("BASE"), true);

		if (filtered != null && filtered.size() > 0) {
			Tag tag = (Tag) filtered.elementAt(0);
			String href = tag.getAttribute("href");
			if (href != null && href.length() > 0) {
				try {
					return new URL(href);
				} catch (MalformedURLException e) {
					e.printStackTrace();

				}
			}
		}
		return null;
	}

	/**
	 * ????????????????????????????????????css,js??????<br>
	 * ???????????????nodes ??????????????????; urlMap ????????????url??????<br>
	 * ???????????????css,js???????????????<br>
	 */
	private ArrayList extractAllScriptNodes(NodeList nodes, HashMap urlMap, URL strWeb) {

		ArrayList urlList = new ArrayList();
		NodeList filtered = nodes.extractAllNodesThatMatch(new TagNameFilter("script"), true);
		// ?????????????????????script??????
		for (int i = 0; i < filtered.size(); i++) {
			Tag tag = (Tag) filtered.elementAt(i);
			String src = tag.getAttribute("src");
			// Handle external css file's url
			if (src != null && src.length() > 0) {
				String innerURL = src;
				// ??????????????????,?????????????????????????
				String absoluteURL = makeAbsoluteURL(strWeb, innerURL);
				if (absoluteURL != null && !urlMap.containsKey(absoluteURL)) {
					urlMap.put(absoluteURL, innerURL);
					ArrayList urlInfo = new ArrayList();
					urlInfo.add(innerURL);
					urlInfo.add(absoluteURL);
					urlList.add(urlInfo);
				}
				tag.setAttribute("src", absoluteURL);
			}
		}

		filtered = nodes.extractAllNodesThatMatch(new TagNameFilter("link"), true);
		for (int i = 0; i < filtered.size(); i++) {
			Tag tag = (Tag) filtered.elementAt(i);
			String type = tag.getAttribute("type");
			String rel = tag.getAttribute("rel");
			String href = tag.getAttribute("href");
			boolean isCssFile = false;
			if (rel != null) {
				isCssFile = rel.indexOf("stylesheet") != -1;
			} else if (type != null) {
				isCssFile |= type.indexOf("text/css") != -1;
			}

			if (isCssFile && href != null && href.length() > 0) {
				String innerURL = href;
				String absoluteURL = makeAbsoluteURL(strWeb, innerURL);
				if (absoluteURL != null && !urlMap.containsKey(absoluteURL)) {
					urlMap.put(absoluteURL, innerURL);
					ArrayList urlInfo = new ArrayList();
					urlInfo.add(innerURL);
					urlInfo.add(absoluteURL);
					urlList.add(urlInfo);
				}
				tag.setAttribute("href", absoluteURL);
			}
		}

		return urlList;

	}

	/**
	 * ????????????????????????????????????????????????<br>
	 * ???????????????nodes ??????????????????; urlMap ????????????url??????; strWeb ????????????<br>
	 * ?????????????????????????????????<br>
	 */
	private ArrayList extractAllImageNodes(NodeList nodes, HashMap urlMap, URL strWeb) {

		ArrayList urlList = new ArrayList();
		NodeList filtered = nodes.extractAllNodesThatMatch(new TagNameFilter("IMG"), true);

		for (int i = 0; i < filtered.size(); i++) {
			Tag tag = (Tag) filtered.elementAt(i);
			String src = tag.getAttribute("src");
			// Handle external css file's url
			if (src != null && src.length() > 0) {
				String innerURL = src;
				String absoluteURL = makeAbsoluteURL(strWeb, innerURL);
				if (absoluteURL != null && !urlMap.containsKey(absoluteURL)) {
					urlMap.put(absoluteURL, innerURL);
					ArrayList urlInfo = new ArrayList();
					urlInfo.add(innerURL);
					urlInfo.add(absoluteURL);
					urlList.add(urlInfo);
				}
				tag.setAttribute("src", absoluteURL);
			}
		}
		return urlList;
	}

	/**
	 * ??????????????????????????????????????????<br>
	 * ???????????????strWeb ????????????; innerURL ??????????????????<br>
	 * ?????????????????????????????????<br>
	 */
	public String makeAbsoluteURL(URL strWeb, String innerURL) {

		// TODO Auto-generated method stub
		// ????????????(???????????????)
		int pos = innerURL.indexOf("?");
		if (pos != -1) {
			innerURL = innerURL.substring(0, pos);
		}
		if (strWeb == null || StringUtil.isNull(strWeb.toString())) {
			if (innerURL.startsWith("//")) {
				innerURL = "http:" + innerURL;
			}
		}
		if (innerURL != null && innerURL.toLowerCase().indexOf("http") == 0) {
			return innerURL;
		}
		URL linkUri = null;
		try {
			linkUri = new URL(strWeb, innerURL);
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return null;

		}

		String absURL = linkUri.toString();
		absURL = absURL.replace("../", "");
		absURL = absURL.replace("./", "");

		return absURL;

	}

	/**
	 * ?????????????????????mht??????<br>
	 * ???????????????content ??????????????????; urlScriptList ??????????????????; urlImageList ?????????????????? strWeb
	 * ??????????????? strFilePath ????????????<br>
	 * ???????????????<br>
	 */
	private void createMhtArchive(String content, ArrayList urlScriptList, ArrayList urlImageList, URL strWeb,
			HttpServletResponse response) throws Exception {

		// Instantiate a Multipart object
		MimeMultipart mp = new MimeMultipart("related");

		Properties properties = new Properties();
		// ??????????????????
		properties = System.getProperties();
		properties.put("mail.smtp.host", "smtp.126.com");
		properties.put("mail.smtp.auth", "true");
		// ??????????????????
		Session session = Session.getDefaultInstance(properties, new Email_auth(from, ""));

		// props.put("mail.smtp.host", smtp);
		MimeMessage msg = new MimeMessage(session);

		// set mailer
		msg.setHeader("X-Mailer", "Code Manager .SWT");

		// set from
		if (from != null) {
			msg.setFrom(new InternetAddress(from));
		}

		// set subject
		if (StringUtil.isNotNull(title)) {
			msg.setSubject(title);
		}

		// to
		if (to != null) {
			InternetAddress[] toAddresses = getInetAddresses(to);
			msg.setRecipients(Message.RecipientType.TO, toAddresses);

		}

		// ??????????????????
		MimeBodyPart bp = new MimeBodyPart();
		bp.setText(content, strEncoding);
		bp.addHeader("Content-Type", "text/html;charset=" + strEncoding);
		bp.addHeader("Content-Location", strWeb.toString());
		mp.addBodyPart(bp);

		int urlCount = urlScriptList.size();

		for (int i = 0; i < urlCount; i++) {

			bp = new MimeBodyPart();
			ArrayList urlInfo = (ArrayList) urlScriptList.get(i);
			String absoluteURL = urlInfo.get(1).toString();

			bp.addHeader("Content-Location",
					javax.mail.internet.MimeUtility.encodeWord(java.net.URLDecoder.decode(absoluteURL, strEncoding)));

			DataSource source = new AttachmentDataSource(absoluteURL, "text");
			bp.setDataHandler(new DataHandler(source));

			mp.addBodyPart(bp);

		}

		urlCount = urlImageList.size();

		for (int i = 0; i < urlCount; i++) {

			bp = new MimeBodyPart();
			ArrayList urlInfo = (ArrayList) urlImageList.get(i);

			// String url = urlInfo.get(0).toString();
			String absoluteURL = urlInfo.get(1).toString();
			bp.addHeader("Content-Location",
					javax.mail.internet.MimeUtility.encodeWord(java.net.URLDecoder.decode(absoluteURL, strEncoding)));

			DataSource source = new AttachmentDataSource(absoluteURL, "image");
			bp.setDataHandler(new DataHandler(source));

			mp.addBodyPart(bp);
		}
		msg.setContent(mp);
		msg.writeTo(response.getOutputStream());
	}

	private InternetAddress[] getInetAddresses(String emails) throws Exception {
		ArrayList list = new ArrayList();
		StringTokenizer tok = new StringTokenizer(emails, ",");
		while (tok.hasMoreTokens()) {
			list.add(tok.nextToken());
		}
		int count = list.size();
		InternetAddress[] addresses = new InternetAddress[count];
		for (int i = 0; i < count; i++) {
			addresses[i] = new InternetAddress(list.get(i).toString());
		}
		return addresses;

	}

	/**
	 * ???????????????
	 * 
	 * @param request
	 * @param oldFileName
	 * @param isEncode
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private static String encodeFileName(HttpServletRequest request, String oldFileName, boolean isEncode)
			throws UnsupportedEncodingException {
		String userAgent = request.getHeader("User-Agent").toUpperCase();
		if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("TRIDENT") > -1 || userAgent.indexOf("EDGE") > -1) {// ie????????????
			oldFileName = URLEncoder.encode(oldFileName, "UTF-8");
			// ??????????????????????????????????????????+?????????????????????
			oldFileName = oldFileName.replace("+", "%20");
		} else {
			oldFileName = new String(oldFileName.getBytes("UTF-8"), "ISO8859-1");
		}
		if (isEncode) { // ????????????????????????????????????????????????URL?????????????????????????????????????????????????????????????????????
			oldFileName = oldFileName.replace("+", "%20");
		}
		return oldFileName;
	}

	class AttachmentDataSource implements DataSource {

		private MimetypesFileTypeMap map = new MimetypesFileTypeMap();
		private String strUrl;
		private String strType;
		private byte[] dataSize = null;

		/**
		 * 
		 * This is some content type maps.
		 */
		private Map normalMap = new HashMap();
		{
			// Initiate normal mime type map
			// Images
			normalMap.put("image", "image/jpeg");
			normalMap.put("text", "text/plain");

		}

		public AttachmentDataSource(String strUrl, String strType) {
			this.strType = strType;
			this.strUrl = strUrl;
			strUrl = strUrl.trim();
			strUrl = strUrl.replaceAll(" ", "%20");
			dataSize = downBinaryFile(strUrl);

		}

		public String getContentType() {
			return getMimeType(getName());
		}

		public String getName() {
			char separator = File.separatorChar;
			if (strUrl.lastIndexOf(separator) >= 0)
				return strUrl.substring(strUrl.lastIndexOf(separator) + 1);
			return strUrl;

		}

		private String getMimeType(String fileName) {
			String type = (String) normalMap.get(strType);
			if (type == null) {
				try {
					type = map.getContentType(fileName);
				} catch (Exception e) {
				}
				if (type == null) {
					type = "application/octet-stream";
				}
			}
			return type;

		}

		public InputStream getInputStream() throws IOException {
			if (dataSize == null)
				dataSize = new byte[0];
			return new ByteArrayInputStream(dataSize);
		}

		public OutputStream getOutputStream() throws IOException {
			return new java.io.ByteArrayOutputStream();
		}

	}

	class Email_auth extends Authenticator {

		String auth_user;
		String auth_password;

		public Email_auth() {
			super();
		}

		public Email_auth(String user, String password) {
			super();
			setUsername(user);
			setUserpass(password);

		}

		public void setUsername(String username) {
			auth_user = username;
		}

		public void setUserpass(String userpass) {
			auth_password = userpass;
		}

		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(auth_user, auth_password);
		}

	}

	class HttpUtil {

		public RequestConfig defaultRequestConfig = RequestConfig.custom().setConnectTimeout(50000)
				.setConnectionRequestTimeout(50000).setSocketTimeout(50000).build();

		@SuppressWarnings("deprecation")
		private CloseableHttpClient createSSLClientDefault(CookieStore cookieStore) throws Exception {
			X509TrustManager tm = new X509TrustManager() {
				public void checkClientTrusted(X509Certificate[] xcs, String string) {
				}

				public void checkServerTrusted(X509Certificate[] xcs, String string) {
				}

				public X509Certificate[] getAcceptedIssuers() {
					return null;
				}
			};

			SSLContext sslcontext = SSLContext.getInstance("TLS");

			sslcontext.init(null, new TrustManager[] { tm }, null);
			SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext,
					SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
			if (cookieStore != null) {
				return HttpClients.custom().setSSLSocketFactory(sslsf).setDefaultCookieStore(cookieStore)
						.setDefaultRequestConfig(defaultRequestConfig).build();
			} else {
				return HttpClients.custom().setSSLSocketFactory(sslsf).setDefaultRequestConfig(defaultRequestConfig)
						.build();
			}
		}

		public CloseableHttpClient createHttpClient(String url) throws Exception {
			CloseableHttpClient http = null;
			if (url.startsWith("https")) {
				http = createSSLClientDefault(null);
			} else {
				http = HttpClients.custom().setDefaultRequestConfig(defaultRequestConfig).build();
			}
			return http;
		}

		public CloseableHttpClient createHttpClient(String url, CookieStore cookieStore) throws Exception {
			CloseableHttpClient http = null;
			if (url.startsWith("https")) {
				http = createSSLClientDefault(cookieStore);
			} else {
				http = HttpClients.custom().setDefaultCookieStore(cookieStore)
						.setDefaultRequestConfig(defaultRequestConfig).build();
			}
			return http;
		}

		/**
		 * 
		 * @param url
		 * @param headsMap
		 * @param httpclient
		 * @throws Exception
		 */
		public CloseableHttpResponse doSynchGet(CloseableHttpClient httpclient, String url,
				Map<String, String> headsMap) throws Exception {
			HttpGet httpget = new HttpGet(url);
			// ??????header??????
			if (headsMap != null && headsMap.size() > 0) {
				for (Map.Entry<String, String> entry : headsMap.entrySet()) {
					httpget.setHeader(entry.getKey(), entry.getValue());
				}
			}

			// ????????????????????????????????????
			return httpclient.execute(httpget);
		}

		/**
		 * 
		 * @param url
		 * @param content
		 * @param headsMap
		 * @param httpclient
		 * @throws Exception
		 */
		public CloseableHttpResponse doSynchPost(CloseableHttpClient httpclient, String url, String content,
				Map<String, String> headsMap) throws Exception {
			// ??????post??????????????????
			HttpPost httpPost = new HttpPost(url);

			HttpEntity entity = new StringEntity(content, "UTF-8");
			// ??????????????????????????????
			httpPost.setEntity(entity);

			// ??????header??????
			if (headsMap != null && headsMap.size() > 0) {
				for (Map.Entry<String, String> entry : headsMap.entrySet()) {
					httpPost.setHeader(entry.getKey(), entry.getValue());
				}
			}

			// ????????????????????????????????????
			return httpclient.execute(httpPost);
		}
	}

}
