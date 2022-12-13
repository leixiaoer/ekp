<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
    <ui:dataview id="appDetail">
		<ui:source type="AjaxJson">
		    {"url":"/km/carmng/km_carmng_application/kmCarmngApplication.do?method=listApplicationByIds&fdApplicationIds=${JsParam.fdApplicationIds}"}
		</ui:source>
		<ui:render type="Template">
			{$
			<center><div>申请单信息</div></center>
			$}
			if(data.length < 1) {
			{$
				<div>
					${ lfn:message('message.noRecord') }
				</div>
			$}
			}
			if(data.length > 0) {
				for(var i=0; i < data.length; i++){
					{$
					<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							联系人
						</td>
						<td width=35%>
							{% data[i].fdApplicationPersonName %} / {% data[i].fdApplicationPersonPhone %}
						</td>
						<td class="td_normal_title" width=15%>
							随车人数
						</td>
						<td width=35%>
							{% data[i].fdUnerNumber %}
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							用车人
						</td>
						<td colspan="3" width=85%>
					$}
						if(data[i].fdUserPersons){
							{$
								<div>
									<img src="${LUI_ContextPath}/km/carmng/resource/images/inner_person.png" />
									<span style="vertical-align: top;">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdInnerPerson"/><c:out value="{% data[i].fdUserPersons %}"></c:out>
									</span>
								</div>
							$}
						}
						if(data[i].fdOtherUsers){
							{$
								<div>
									<img src="${LUI_ContextPath}/km/carmng/resource/images/other_person.png" />
									<span style="vertical-align: top;">
										<bean:message bundle="km-carmng" key="kmCarmngApplication.fdOtherPerson"/><c:out value="{% data[i].fdOtherUsers %}"></c:out>
									</span>
								</div>
							$}
						}
					{$		
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							路线安排
						</td>
						<td colspan="3">
					$}
					var path = data[i].fdApplicationPath;
					for(var j = 0; j < path.length; j++ ){
						{$
						  {% path[j].fdDestination%}
						$}
					}
					{$
						</td>
					</tr>
					</table></br>
					$}
				}
			}
		</ui:render>
	</ui:dataview>
