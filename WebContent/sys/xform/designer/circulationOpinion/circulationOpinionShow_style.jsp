<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.landray.kmss.framework.plugin.core.config.IExtension"%>
<%@page import="com.landray.kmss.framework.service.plugin.Plugin"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.sys.circulation.service.ISysCirculationOpinionStyleService"%>

<%
//获取样式扩展点
IExtension[] extensions = Plugin.getExtensions(
		"com.landray.kmss.sys.xform.jsp.circulation.viewstyle", "*");

List<Map<String,String>> list = new ArrayList<Map<String,String>>();
if(extensions !=null){
	for(int i=0;i<extensions.length;i++){
		Map<String,String> mapElement=new HashMap<String,String>();
		
		Object viewName = Plugin.getParamValue(extensions[i],"viewName");
		//获取字符串BeanId
		Object viewValue =Plugin.getParamValueString(extensions[i],"viewValue");
		Object order =Plugin.getParamValue(extensions[i],"order");
		Object previewPictureURL =Plugin.getParamValue(extensions[i],"previewPictureURL");
		
		
		mapElement.put("viewName",null==viewName?"":ResourceUtil.getString((String)viewName,request.getLocale()));
		mapElement.put("viewValue",null==viewValue?"":(String)viewValue);
		//确保没有输入序号的扩展排到最后
		mapElement.put("order",null==order?"100":(String)order);
		mapElement.put("previewPictureURL",null==previewPictureURL?"":(String)previewPictureURL);
		
		if(null!=viewValue){
			ISysCirculationOpinionStyleService auditNoteStyle = (ISysCirculationOpinionStyleService) SpringBeanUtil
					.getBean(viewValue.toString());
			mapElement.put("styleHtml",auditNoteStyle.getStyleHTML());
		}
		list.add(mapElement);
	}
}

//排序
for(int i=0;i<list.size();i++){
	Map<String,String> mapI=list.get(i);
	float mapIOrder=Float.valueOf(mapI.get("order"));
	for(int j=i;j<list.size();j++){
		Map<String,String> mapJ=list.get(j);
		float mapJOrder=Float.valueOf(mapJ.get("order"));
		if(mapJOrder<mapIOrder){
			Map<String,String> mapTemp=mapI;
			mapI=mapJ;
			mapIOrder=mapJOrder;//更新order
			mapJ=mapTemp;
			list.set(i,mapI);
			list.set(j,mapJ);//不跳出，一直到找出最小的放在前面
		}
	}
}
//构建JSON数组，相应给客户端
out.print(JSONArray.fromObject(list));
%>