<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDictModel"%>
<%@page import="com.landray.kmss.sys.config.dict.SysDataDict"%>
	<%
		String mainModelName = "com.landray.kmss.km.asset.model.KmAssetApplyRepair";
		SysDictModel dict = SysDataDict.getInstance().getModel(mainModelName);
		String url = dict.getUrl();
		String addUrl = url.substring(0, url.indexOf(".do"))
				+ ".do";
		addUrl += "?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}";
		if (addUrl.startsWith("/")) {
			addUrl = addUrl.substring(1);
		}
		request.setAttribute("addUrl", addUrl);
	%>
<kmss:authShow roles="ROLE_KMASSETAPPLY_CREATE">	
<div id="usualCateDiv">	
	<ui:dataview>
		<ui:event event="load">
			var data = this.data;
			if(data.list && data.list.length == 0){
			document.getElementById("catexiao").style.display="none";
			}  
		</ui:event>
		<ui:source type="AjaxJson">
		    {"url":"/km/asset/km_asset_apply_template/kmAssetApplyTemplate.do?method=listUsual&mainModelName=com.landray.kmss.km.asset.model.KmAssetApplyRepair&fdTempKey=KmAssetApplyRepairDoc"}
		</ui:source>
		<ui:render type="Template">
				{$
				<div id="catexiao">
					<div class="lui-cate-panel-heading usual-cate-title">		     
						 <h2 class="lui-cate-panel-heading-title"><bean:message key="kmAssetApplyTemplate.enum.fdType6" bundle="km-asset"/></h2> 
					</div>
					<ul class='lui-cate-panel-list'>
				$} 
				var _data = data.list;
				for(var i=0;i < _data.length;i++){
					{$
					 <kmss:auth requestURL="{%_data[i].addUrl%}" requestMethod="GET">
						<li class="lui-cate-panel-list-item">
							 <div class="link-box">
						        <div class="link-box-heading">
						          <p><span>{%_data[i].templateDesc%}</span></p>
						        </div>
						        <div class="link-box-body">
						          <a  data-href="{%Com_Parameter.ContextPath%}{%_data[i].addUrl%}" target="_blank"  title="{%_data[i].templateDesc %}" onclick="Com_OpenNewWindow(this)">${lfn:message('button.add') }</a>
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
						</kmss:auth>
					$}
				}
			 {$
				</ul>
				</div>
			$}
			if(data.list && data.list.length == 0){
			{$
			<div class="prompt_frame">
			<div class="prompt_centerL">
				<div class="prompt_centerR">
					<div class="prompt_centerC">
						<div class="prompt_container clearfloat">
							<div>
								<div class="prompt_content_error"></div>
								<div class="prompt_content_right">
									<div class="prompt_content_inside">
										<bean:message key="return.title" />
										<div class="msgtitle">${lfn:message('km-asset:kmAsset.tree.tipmoban') }</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
			$}
			}
		</ui:render>
		
	</ui:dataview>
</div>	

</kmss:authShow>