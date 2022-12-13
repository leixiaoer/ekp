<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/carmng/km_carmng_application/kmCarmngApplicationIndex.do?method=list'}
			</ui:source>
			  <!-- 列表视图 -->	
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.carmng.model.KmCarmngApplication" isDefault="true" layout="sys.ui.listview.columntable" 
				rowHref="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial> 
				<%-- <list:col-html   title="${ lfn:message('km-carmng:kmCarmngApplication.docSubject') }" style="text-align:left">
				{$ <span class="com_subject">{%row['docSubject']%}</span> $}
				</list:col-html> --%>
				<list:col-auto ></list:col-auto>
			</list:colTable>
		</list:listview> 
		
<list:paging></list:paging>	