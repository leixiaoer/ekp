<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
	<%
		String mainModelName = request.getParameter("mainModelName");
		mainModelName = org.apache.commons.lang.StringEscapeUtils.escapeHtml(mainModelName);
		
		SysDictModel dict = SysDataDict.getInstance().getModel(mainModelName);
		String url = dict.getUrl();
		String addUrl = url.substring(0, url.indexOf(".do"))
				+ ".do";
		addUrl += "?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}";
		if (!addUrl.startsWith("/")) {
			addUrl += "/";
		}
		request.setAttribute("addUrl", addUrl);
	%>
<div id="usualCateDiv">	
	<ui:dataview>
		<ui:event event="load">
			var data = this.data;
			if(data.list && data.list.length == 0){
				this.erase();
			}  
		</ui:event>
		<ui:source type="AjaxJson">
		    {"url":"/sys/lbpmperson/SysLbpmPersonCreate.do?method=listUsual&mainModelName=${JsParam.mainModelName}"}
		</ui:source>
		<ui:render type="Template">
			<c:choose>
				<c:when test="${'true' ne param.isSimpleCategory }">
				{$
					<div class="lui-cate-panel-heading usual-cate-title">		     
						 <h2 class="lui-cate-panel-heading-title"><bean:message key="lbpmperson.recent.cateTemplate" bundle="sys-lbpmperson"/></h2> 
					</div>
					<ul class='lui-cate-panel-list'>
				$} 
				var _data = data.list;
				for(var i=0;i < _data.length;i++){
					{$
						<li class="lui-cate-panel-list-item">
							 <div class="link-box">
						        <div class="link-box-heading">
						          <p><span>{%_data[i].templateDesc%}</span></p>
						        </div>
						        <div class="link-box-body">
						          <a  onclick="Com_OpenNewWindow(this)" data-href="{%Com_Parameter.ContextPath%}{%_data[i].addUrl%}" target="_blank"  title="{%_data[i].templateDesc %}"><bean:message key="button.add"/></a>
						        </div>
								<div class="link-box-footer">
						          <h6 class="link-box-title">
						$}
						          if(_data[i].cateName){
						           {$
						         	  <i class="icon"></i><span>{%env.fn.formatText(_data[i].cateName)%}</span>
						         	$} 
						           }
						{$
						          </h6>
						        </div>
						     </div>
						</li>
					$}
				}
			 {$
				</ul>
			$}
			</c:when>
			<c:otherwise>
				{$
					<div class="lui-cate-panel-heading usual-cate-title">		     
						 <h2 class="lui-cate-panel-heading-title"><bean:message key="lbpmperson.recent.category" bundle="sys-lbpmperson"/></h2> 
					</div>
					<ul class='lui-cate-simple-panel-list clearfloat'>
				$} 
				var _data = data.list;
				for(var i=0;i < _data.length;i++){
					{$
						<li class="lui-cate-simple-panel-list-item">
							 <div class="link-box">
								<div class="link-box-heading">
									<p class="link-box-title"> <span><i class="icon"></i><span>{%_data[i].templateDesc%}</span> </span>
									</p>
								</div>
								<div class="link-box-body">
									<a class="btn-add" onclick="Com_OpenNewWindow(this)" data-href="{%Com_Parameter.ContextPath%}{%_data[i].addUrl%}" target="_blank" title="{%_data[i].templateDesc %}"><bean:message key="button.add"/></a>
								</div>
							</div>
						</li>
					$}
				}
			 {$
				</ul>
			$}
			</c:otherwise>
			</c:choose>
		</ui:render>
	</ui:dataview>
</div>	
	